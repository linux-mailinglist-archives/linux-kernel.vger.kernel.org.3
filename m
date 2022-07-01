Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89869562B63
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiGAGSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiGAGSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:18:41 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98AE34B9F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:18:38 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20220701061836e903a86cc71890a96d
        for <linux-kernel@vger.kernel.org>;
        Fri, 01 Jul 2022 08:18:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JstKKP14IeAJUJyGWN+riogwN0b3Q0v0/SL0F6tHsGU=;
 b=QZTmDi3WWNUwdB4a8rom5ZaCO8HoA+GZaHYvh+/ut/ZG/g9PEmqgMAA+/hzZ6Py0qzmcjd
 6iHq5gPL9N37cndf/4sTXnQgCABWozPiAdnvQ44DJ66uATdguaE3tOM85Yh3em+LQK/q/y/W
 mOD8IYmUwWUgUZfkF1KoWTndXSoU0=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 4/9] tty: n_gsm: fix missing timer to handle stalled links
Date:   Fri,  1 Jul 2022 08:16:47 +0200
Message-Id: <20220701061652.39604-4-daniel.starke@siemens.com>
In-Reply-To: <20220701061652.39604-1-daniel.starke@siemens.com>
References: <20220701061652.39604-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The current implementation does not handle the situation that no data is in
the internal queue and needs to be sent out while the user tty fifo is
full.
Add a timer that moves more data from user tty down to the internal queue
which is then serialized on the ldisc. This timer is triggered if no data
was moved from a user tty to the internal queue within 10 * T1.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

Stable backport remark has been removed compared to v3. No other changes applied.

Link: https://lore.kernel.org/all/20220530144512.2731-4-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b51e2023d88d..58bf4b4aea78 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -244,6 +244,7 @@ struct gsm_mux {
 	struct list_head tx_list;	/* Pending data packets */
 
 	/* Control messages */
+	struct timer_list kick_timer;	/* Kick TX queuing on timeout */
 	struct timer_list t2_timer;	/* Retransmit timer for commands */
 	int cretries;			/* Command retry counter */
 	struct gsm_control *pending_cmd;/* Our current pending command */
@@ -833,6 +834,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 	list_add_tail(&msg->list, &gsm->tx_list);
 	gsm->tx_bytes += msg->len;
 	gsm_data_kick(gsm, dlci);
+	mod_timer(&gsm->kick_timer, jiffies + 10 * gsm->t1 * HZ / 100);
 }
 
 /**
@@ -885,9 +887,6 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 	size = len + h;
 
 	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
-	/* FIXME: need a timer or something to kick this so it can't
-	 * get stuck with no work outstanding and no buffer free
-	 */
 	if (!msg)
 		return -ENOMEM;
 	dp = msg->data;
@@ -964,9 +963,6 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 
 	size = len + overhead;
 	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
-
-	/* FIXME: need a timer or something to kick this so it can't
-	   get stuck with no work outstanding and no buffer free */
 	if (msg == NULL) {
 		skb_queue_tail(&dlci->skb_list, dlci->skb);
 		dlci->skb = NULL;
@@ -1062,9 +1058,9 @@ static int gsm_dlci_modem_output(struct gsm_mux *gsm, struct gsm_dlci *dlci,
  *	renegotiate DLCI priorities with optional stuff. Needs optimising.
  */
 
-static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
+static int gsm_dlci_data_sweep(struct gsm_mux *gsm)
 {
-	int len;
+	int len, ret = 0;
 	/* Priority ordering: We should do priority with RR of the groups */
 	int i = 1;
 
@@ -1087,7 +1083,11 @@ static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
 		/* DLCI empty - try the next */
 		if (len == 0)
 			i++;
+		else
+			ret++;
 	}
+
+	return ret;
 }
 
 /**
@@ -1806,6 +1806,30 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 	}
 }
 
+/**
+ *	gsm_kick_timer	-	transmit if possible
+ *	@t: timer contained in our gsm object
+ *
+ *	Transmit data from DLCIs if the queue is empty. We can't rely on
+ *	a tty wakeup except when we filled the pipe so we need to fire off
+ *	new data ourselves in other cases.
+ */
+static void gsm_kick_timer(struct timer_list *t)
+{
+	struct gsm_mux *gsm = from_timer(gsm, t, kick_timer);
+	unsigned long flags;
+	int sent = 0;
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	/* If we have nothing running then we need to fire up */
+	if (gsm->tx_bytes < TX_THRESH_LO)
+		sent = gsm_dlci_data_sweep(gsm);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+
+	if (sent && debug & 4)
+		pr_info("%s TX queue stalled\n", __func__);
+}
+
 /*
  *	Allocate/Free DLCI channels
  */
@@ -2261,6 +2285,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	}
 
 	/* Finish outstanding timers, making sure they are done */
+	del_timer_sync(&gsm->kick_timer);
 	del_timer_sync(&gsm->t2_timer);
 
 	/* Free up any link layer users and finally the control channel */
@@ -2293,6 +2318,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	struct gsm_dlci *dlci;
 	int ret;
 
+	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
 	init_waitqueue_head(&gsm->event);
 	spin_lock_init(&gsm->control_lock);
@@ -2699,6 +2725,7 @@ static int gsmld_open(struct tty_struct *tty)
 
 	gsmld_attach_gsm(tty, gsm);
 
+	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
 
 	return 0;
-- 
2.34.1

