Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D845A4E04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiH2N1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiH2N0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:26:49 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF29E4A816
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:25:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [95.31.169.23])
        by mail.ispras.ru (Postfix) with ESMTPSA id 84E1040737B8;
        Mon, 29 Aug 2022 13:17:22 +0000 (UTC)
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org, Hillf Danton <hdanton@sina.com>
Subject: [PATCH v4 1/2] tty: n_gsm: replace kicktimer with delayed_work
Date:   Mon, 29 Aug 2022 16:16:39 +0300
Message-Id: <20220829131640.69254-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829131640.69254-1-pchelkin@ispras.ru>
References: <20220829131640.69254-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kick_timer timer_list is replaced with kick_timeout delayed_work to be
able to synchronize with mutexes as a prerequisite for the introduction
of tx_mutex.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: c568f7086c6e ("tty: n_gsm: fix missing timer to handle stalled links")
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
v1->v2: sorry, now adapted patch from 5.10 to upstream
v2->v3: replaced a kick_timer with a delayed_work
v3->v4: separated kick_timer and tx_mutex into different patches

 drivers/tty/n_gsm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index caa5c14ed57f..c4164c85ffd4 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -256,7 +256,7 @@ struct gsm_mux {
 	struct list_head tx_data_list;	/* Pending data packets */
 
 	/* Control messages */
-	struct timer_list kick_timer;	/* Kick TX queuing on timeout */
+	struct delayed_work kick_timeout;	/* Kick TX queuing on timeout */
 	struct timer_list t2_timer;	/* Retransmit timer for commands */
 	int cretries;			/* Command retry counter */
 	struct gsm_control *pending_cmd;/* Our current pending command */
@@ -1009,7 +1009,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 	gsm->tx_bytes += msg->len;
 
 	gsmld_write_trigger(gsm);
-	mod_timer(&gsm->kick_timer, jiffies + 10 * gsm->t1 * HZ / 100);
+	schedule_delayed_work(&gsm->kick_timeout, 10 * gsm->t1 * HZ / 100);
 }
 
 /**
@@ -1984,16 +1984,16 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 }
 
 /**
- *	gsm_kick_timer	-	transmit if possible
- *	@t: timer contained in our gsm object
+ *	gsm_kick_timeout	-	transmit if possible
+ *	@work: work contained in our gsm object
  *
  *	Transmit data from DLCIs if the queue is empty. We can't rely on
  *	a tty wakeup except when we filled the pipe so we need to fire off
  *	new data ourselves in other cases.
  */
-static void gsm_kick_timer(struct timer_list *t)
+static void gsm_kick_timeout(struct work_struct *work)
 {
-	struct gsm_mux *gsm = from_timer(gsm, t, kick_timer);
+	struct gsm_mux *gsm = container_of(work, struct gsm_mux, kick_timeout.work);
 	unsigned long flags;
 	int sent = 0;
 
@@ -2458,7 +2458,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	}
 
 	/* Finish outstanding timers, making sure they are done */
-	del_timer_sync(&gsm->kick_timer);
+	cancel_delayed_work_sync(&gsm->kick_timeout);
 	del_timer_sync(&gsm->t2_timer);
 
 	/* Finish writing to ldisc */
@@ -2501,7 +2501,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	if (dlci == NULL)
 		return -ENOMEM;
 
-	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
+	INIT_DELAYED_WORK(&gsm->kick_timeout, gsm_kick_timeout);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
 	INIT_WORK(&gsm->tx_work, gsmld_write_task);
 	init_waitqueue_head(&gsm->event);
@@ -2946,7 +2946,7 @@ static int gsmld_open(struct tty_struct *tty)
 
 	gsmld_attach_gsm(tty, gsm);
 
-	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
+	INIT_DELAYED_WORK(&gsm->kick_timeout, gsm_kick_timeout);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
 	INIT_WORK(&gsm->tx_work, gsmld_write_task);
 
-- 
2.25.1

