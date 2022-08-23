Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCC959D14A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbiHWGaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbiHWGaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:30:14 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 23:30:13 PDT
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040B4606A8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:30:12 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2022082306240679f15e862bbbdcc705
        for <linux-kernel@vger.kernel.org>;
        Tue, 23 Aug 2022 08:29:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yJf+L5ZnsIVVwHGDEnHt0V5d7irUi96d0y60rt3a4Yo=;
 b=o0IIIZpcc/CYt6NDkCM2jhAa56A+ktWa6xCBP53u1GITNjJM1BcZSav2LhY//6YCUQGty6
 QPosf1cH9bA7dfIlwvpswE1QPKePpgfIkmzGFZ31tsgmifCaH0+CJEN8m5DCZXVTa+Y1pyYg
 Cd6Yo+goeW9O4P05Fs2DdNg8XRKlY=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 5/6] tty: n_gsm: name the debug bits
Date:   Tue, 23 Aug 2022 08:22:58 +0200
Message-Id: <20220823062259.4754-5-daniel.starke@siemens.com>
In-Reply-To: <20220823062259.4754-1-daniel.starke@siemens.com>
References: <20220823062259.4754-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

No changes since v1.

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5a20561c0a5d..fcf2d52d5095 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -63,6 +63,13 @@
 static int debug;
 module_param(debug, int, 0600);
 
+/* Module debug bits */
+#define DBG_DUMP	(1 << 0) /* Data transmission dump. */
+#define DBG_CD_ON	(1 << 1) /* Always assume CD line on. */
+#define DBG_DATA	(1 << 2) /* Data transmission details. */
+#define DBG_ERRORS	(1 << 3) /* Details for fail conditions. */
+#define DBG_TTY		(1 << 4) /* Transmission statistics for DLCI TTYs. */
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
@@ -1765,7 +1772,7 @@ static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
 static void gsm_dlci_close(struct gsm_dlci *dlci)
 {
 	del_timer(&dlci->t1);
-	if (debug & 8)
+	if (debug & DBG_ERRORS)
 		pr_debug("DLCI %d goes closed.\n", dlci->addr);
 	dlci->state = DLCI_CLOSED;
 	/* Prevent us from sending data before the link is up again */
@@ -1799,7 +1806,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 	/* This will let a tty open continue */
 	dlci->state = DLCI_OPEN;
 	dlci->constipated = false;
-	if (debug & 8)
+	if (debug & DBG_ERRORS)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
 	if (dlci->addr)
@@ -1835,7 +1842,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			gsm_command(dlci->gsm, dlci->addr, SABM|PF);
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else if (!dlci->addr && gsm->control == (DM | PF)) {
-			if (debug & 8)
+			if (debug & DBG_ERRORS)
 				pr_info("DLCI %d opening in ADM mode.\n",
 					dlci->addr);
 			dlci->mode = DLCI_MODE_ADM;
@@ -1940,7 +1947,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 	unsigned int modem = 0;
 	int len;
 
-	if (debug & 16)
+	if (debug & DBG_TTY)
 		pr_debug("%d bytes for tty\n", clen);
 	switch (dlci->adaption)  {
 	/* Unsupported types */
@@ -2030,7 +2037,7 @@ static void gsm_kick_timer(struct timer_list *t)
 		sent = gsm_dlci_data_sweep(gsm);
 	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 
-	if (sent && debug & 4)
+	if (sent && debug & DBG_DATA)
 		pr_info("%s TX queue stalled\n", __func__);
 }
 
@@ -2164,7 +2171,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	if (gsm->fcs != GOOD_FCS) {
 		gsm->bad_fcs++;
-		if (debug & 4)
+		if (debug & DBG_DATA)
 			pr_debug("BAD FCS %02x\n", gsm->fcs);
 		return;
 	}
@@ -2790,7 +2797,7 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 		set_bit(TTY_DO_WRITE_WAKEUP, &gsm->tty->flags);
 		return -ENOSPC;
 	}
-	if (debug & 4)
+	if (debug & DBG_DATA)
 		gsm_hex_dump_bytes(__func__, data, len);
 	return gsm->tty->ops->write(gsm->tty, data, len);
 }
@@ -2877,7 +2884,7 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
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

