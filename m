Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F395A77B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiHaHkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiHaHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:40:36 -0400
X-Greylist: delayed 67 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 00:40:33 PDT
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB6AB6D0B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:40:27 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202208310739239a887c0cc6e9a060ba
        for <linux-kernel@vger.kernel.org>;
        Wed, 31 Aug 2022 09:39:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3J5YJMYogxurmh9Iy3+kLDwBkuAs+TWkBdMkdxAGFv0=;
 b=TAMk0XOvgXPuMlvqMcWYvxWM9vdV/QgQL3YkE/3Le5eeiHOC3g8iEHEut542dJ96gb0xUL
 RE3YOfDM8WnPKyB1gcYfYUnqdcLjPRGWh68MADdEdI5a6lJPvjjHPiyUsfVkLV/9lQWdwQBW
 2A5T+XcvZZ0kI6P3JISZk1u4X3jsA=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 5/6] tty: n_gsm: name the debug bits
Date:   Wed, 31 Aug 2022 09:37:59 +0200
Message-Id: <20220831073800.7459-5-daniel.starke@siemens.com>
In-Reply-To: <20220831073800.7459-1-daniel.starke@siemens.com>
References: <20220831073800.7459-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Introduce defines to name the various debug bits used within the code to
improve readability and to make its specific use clear.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

Incorporated review comments from Jiri Slaby since v2:
- changed (1 << n) to BIT(n) in the debug macro definitions

Link: https://lore.kernel.org/all/1d8d0d72-a5b7-724e-a70a-71d9fd3330c4@kernel.org/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index e050d76385ba..f8a8c4059907 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -63,6 +63,13 @@
 static int debug;
 module_param(debug, int, 0600);
 
+/* Module debug bits */
+#define DBG_DUMP	BIT(0) /* Data transmission dump. */
+#define DBG_CD_ON	BIT(1) /* Always assume CD line on. */
+#define DBG_DATA	BIT(2) /* Data transmission details. */
+#define DBG_ERRORS	BIT(3) /* Details for fail conditions. */
+#define DBG_TTY		BIT(4) /* Transmission statistics for DLCI TTYs. */
+
 /* Defaults: these are from the specification */
 
 #define T1	10		/* 100mS */
@@ -535,7 +542,7 @@ static int gsm_register_devices(struct tty_driver *driver, unsigned int index)
 		 */
 		dev = tty_register_device(gsm_tty_driver, base + i, NULL);
 		if (IS_ERR(dev)) {
-			if (debug & 8)
+			if (debug & DBG_ERRORS)
 				pr_info("%s failed to register device minor %u",
 					__func__, base + i);
 			for (i--; i >= 1; i--)
@@ -589,7 +596,7 @@ static void gsm_unregister_devices(struct tty_driver *driver,
 static void gsm_print_packet(const char *hdr, int addr, int cr,
 					u8 control, const u8 *data, int dlen)
 {
-	if (!(debug & 1))
+	if (!(debug & DBG_DUMP))
 		return;
 
 	pr_info("%s %d) %c: ", hdr, addr, "RC"[cr]);
@@ -833,7 +840,7 @@ static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg)
 		len += 2;
 	}
 
-	if (debug & 4)
+	if (debug & DBG_DATA)
 		gsm_hex_dump_bytes(__func__, gsm->txframe, len);
 	gsm_print_packet("-->", msg->addr, gsm->initiator, msg->ctrl, msg->data,
 			 msg->len);
@@ -1766,7 +1773,7 @@ static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
 static void gsm_dlci_close(struct gsm_dlci *dlci)
 {
 	del_timer(&dlci->t1);
-	if (debug & 8)
+	if (debug & DBG_ERRORS)
 		pr_debug("DLCI %d goes closed.\n", dlci->addr);
 	dlci->state = DLCI_CLOSED;
 	/* Prevent us from sending data before the link is up again */
@@ -1800,7 +1807,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 	/* This will let a tty open continue */
 	dlci->state = DLCI_OPEN;
 	dlci->constipated = false;
-	if (debug & 8)
+	if (debug & DBG_ERRORS)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
 	if (dlci->addr)
@@ -1836,7 +1843,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			gsm_command(dlci->gsm, dlci->addr, SABM|PF);
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else if (!dlci->addr && gsm->control == (DM | PF)) {
-			if (debug & 8)
+			if (debug & DBG_ERRORS)
 				pr_info("DLCI %d opening in ADM mode.\n",
 					dlci->addr);
 			dlci->mode = DLCI_MODE_ADM;
@@ -1941,7 +1948,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 	unsigned int modem = 0;
 	int len;
 
-	if (debug & 16)
+	if (debug & DBG_TTY)
 		pr_debug("%d bytes for tty\n", clen);
 	switch (dlci->adaption)  {
 	/* Unsupported types */
@@ -2029,7 +2036,7 @@ static void gsm_kick_timer(struct timer_list *t)
 		sent = gsm_dlci_data_sweep(gsm);
 	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 
-	if (sent && debug & 4)
+	if (sent && debug & DBG_DATA)
 		pr_info("%s TX queue stalled\n", __func__);
 }
 
@@ -2163,7 +2170,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	if (gsm->fcs != GOOD_FCS) {
 		gsm->bad_fcs++;
-		if (debug & 4)
+		if (debug & DBG_DATA)
 			pr_debug("BAD FCS %02x\n", gsm->fcs);
 		return;
 	}
@@ -2789,7 +2796,7 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 		set_bit(TTY_DO_WRITE_WAKEUP, &gsm->tty->flags);
 		return -ENOSPC;
 	}
-	if (debug & 4)
+	if (debug & DBG_DATA)
 		gsm_hex_dump_bytes(__func__, data, len);
 	return gsm->tty->ops->write(gsm->tty, data, len);
 }
@@ -2876,7 +2883,7 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	struct gsm_mux *gsm = tty->disc_data;
 	char flags = TTY_NORMAL;
 
-	if (debug & 4)
+	if (debug & DBG_DATA)
 		gsm_hex_dump_bytes(__func__, cp, count);
 
 	for (; count; count--, cp++) {
@@ -3416,7 +3423,7 @@ static int gsm_carrier_raised(struct tty_port *port)
 	/* Not yet open so no carrier info */
 	if (dlci->state != DLCI_OPEN)
 		return 0;
-	if (debug & 2)
+	if (debug & DBG_CD_ON)
 		return 1;
 
 	/*
-- 
2.34.1

