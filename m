Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C54B50B12C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444683AbiDVHOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345890AbiDVHOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:14:35 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 00:11:43 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136465131E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:11:41 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202204220710374730a04c63206925d3
        for <linux-kernel@vger.kernel.org>;
        Fri, 22 Apr 2022 09:10:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6TYWz5NM2Ayh/wAaSx/ZruxeD4HMnQKe81wQRU87fBM=;
 b=VybX2RKuTM9/fnm3XwYiVizce4MpI0CMeQ2pXYxRFKB+n4Ek6w7wRF8Ti0Fq6Vt5lJHBgS
 45ynA2nYKsJCldVpP0QZCOjSzQiD1N2krxZ1TIOKfNs2vu/TL+Vgh5o0B56mW4vfHdESsQD9
 GeQWvB1BqRVh8Nvau8ETIIWep2Vsc=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 2/3] tty: n_gsm: fix invalid use of MSC in advanced option
Date:   Fri, 22 Apr 2022 00:10:24 -0700
Message-Id: <20220422071025.5490-2-daniel.starke@siemens.com>
In-Reply-To: <20220422071025.5490-1-daniel.starke@siemens.com>
References: <20220422071025.5490-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.4.6.3.7 states that the Modem Status
Command (MSC) shall only be used if the basic option was chosen.
The current implementation uses MSC frames even if advanced option was
chosen to inform the peer about modem line state updates. A standard
conform peer may choose to discard these frames in advanced option mode.
Furthermore, gsmtty_modem_update() is not part of the 'tty_operations'
functions despite its name.
Rename gsmtty_modem_update() to gsm_modem_update() to clarify this. Split
its function into gsm_modem_upd_via_data() and gsm_modem_upd_via_msc()
depending on the encoding and adaption. Introduce gsm_dlci_modem_output()
as adaption of gsm_dlci_data_output() to encode and queue empty frames in
advanced option mode. Use it in gsm_modem_upd_via_data().
gsm_modem_upd_via_msc() is based on the initial gsmtty_modem_update()
function which used only MSC frames to update modem states.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 125 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 99fe54247a87..570f0b8b7576 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -366,7 +366,7 @@ static const u8 gsm_fcs8[256] = {
 #define GOOD_FCS	0xCF
 
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
-static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk);
+static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
 
 /**
  *	gsm_fcs_add	-	update FCS
@@ -914,6 +914,63 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 	return size;
 }
 
+/**
+ *	gsm_dlci_modem_output	-	try and push modem status out of a DLCI
+ *	@gsm: mux
+ *	@dlci: the DLCI to pull modem status from
+ *	@brk: break signal
+ *
+ *	Push an empty frame in to the transmit queue to update the modem status
+ *	bits and to transmit an optional break.
+ *
+ *	Caller must hold the tx_lock of the mux.
+ */
+
+static int gsm_dlci_modem_output(struct gsm_mux *gsm, struct gsm_dlci *dlci,
+				 u8 brk)
+{
+	u8 *dp = NULL;
+	struct gsm_msg *msg;
+	int size;
+
+	/* for modem bits without break data */
+	if (dlci->adaption == 1) {
+		size = 0;
+	} else if (dlci->adaption == 2) {
+		size = 1;
+		if (brk > 0)
+			size++;
+	} else {
+		pr_err("%s: unsupported adaption %d\n", __func__,
+		       dlci->adaption);
+	}
+
+	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
+	if (!msg) {
+		pr_err("%s: gsm_data_alloc error", __func__);
+		return -ENOMEM;
+	}
+	dp = msg->data;
+	switch (dlci->adaption) {
+	case 1: /* Unstructured */
+		break;
+	case 2: /* Unstructured with modem bits. */
+		if (brk == 0) {
+			*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
+		} else {
+			*dp++ = gsm_encode_modem(dlci) << 1;
+			*dp++ = (brk << 4) | 2 | EA; /* Length, Break, EA */
+		}
+		break;
+	default:
+		/* Handled above */
+		break;
+	}
+
+	__gsm_data_queue(dlci, msg);
+	return size;
+}
+
 /**
  *	gsm_dlci_data_sweep		-	look for data to send
  *	@gsm: the GSM mux
@@ -1464,7 +1521,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
 	if (dlci->addr)
-		gsmtty_modem_update(dlci, 0);
+		gsm_modem_update(dlci, 0);
 	wake_up(&dlci->gsm->event);
 }
 
@@ -2897,12 +2954,43 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
 
 #define TX_SIZE		512
 
-static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk)
+/**
+ *	gsm_modem_upd_via_data	-	send modem bits via convergence layer
+ *	@dlci: channel
+ *	@brk: break signal
+ *
+ *	Send an empty frame to signal mobile state changes and to transmit the
+ *	break signal for adaption 2.
+ */
+
+static void gsm_modem_upd_via_data(struct gsm_dlci *dlci, u8 brk)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+	unsigned long flags;
+
+	if (dlci->state != DLCI_OPEN || dlci->adaption != 2)
+		return;
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	gsm_dlci_modem_output(gsm, dlci, brk);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+}
+
+/**
+ *	gsm_modem_upd_via_msc	-	send modem bits via control frame
+ *	@dlci: channel
+ *	@brk: break signal
+ */
+
+static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 {
 	u8 modembits[3];
 	struct gsm_control *ctrl;
 	int len = 2;
 
+	if (dlci->gsm->encoding != 0)
+		return 0;
+
 	modembits[0] = (dlci->addr << 2) | 2 | EA;  /* DLCI, Valid, EA */
 	if (!brk) {
 		modembits[1] = (gsm_encode_modem(dlci) << 1) | EA;
@@ -2917,6 +3005,27 @@ static int gsmtty_modem_update(struct gsm_dlci *dlci, u8 brk)
 	return gsm_control_wait(dlci->gsm, ctrl);
 }
 
+/**
+ *	gsm_modem_update	-	send modem status line state
+ *	@dlci: channel
+ *	@brk: break signal
+ */
+
+static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
+{
+	if (dlci->adaption == 2) {
+		/* Send convergence layer type 2 empty data frame. */
+		gsm_modem_upd_via_data(dlci, brk);
+		return 0;
+	} else if (dlci->gsm->encoding == 0) {
+		/* Send as MSC control message. */
+		return gsm_modem_upd_via_msc(dlci, brk);
+	}
+
+	/* Modem status lines are not supported. */
+	return -EPROTONOSUPPORT;
+}
+
 static int gsm_carrier_raised(struct tty_port *port)
 {
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
@@ -2949,7 +3058,7 @@ static void gsm_dtr_rts(struct tty_port *port, int onoff)
 		modem_tx &= ~(TIOCM_DTR | TIOCM_RTS);
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		gsmtty_modem_update(dlci, 0);
+		gsm_modem_update(dlci, 0);
 	}
 }
 
@@ -3140,7 +3249,7 @@ static int gsmtty_tiocmset(struct tty_struct *tty,
 
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		return gsmtty_modem_update(dlci, 0);
+		return gsm_modem_update(dlci, 0);
 	}
 	return 0;
 }
@@ -3201,7 +3310,7 @@ static void gsmtty_throttle(struct tty_struct *tty)
 		dlci->modem_tx &= ~TIOCM_RTS;
 	dlci->throttled = true;
 	/* Send an MSC with RTS cleared */
-	gsmtty_modem_update(dlci, 0);
+	gsm_modem_update(dlci, 0);
 }
 
 static void gsmtty_unthrottle(struct tty_struct *tty)
@@ -3213,7 +3322,7 @@ static void gsmtty_unthrottle(struct tty_struct *tty)
 		dlci->modem_tx |= TIOCM_RTS;
 	dlci->throttled = false;
 	/* Send an MSC with RTS set */
-	gsmtty_modem_update(dlci, 0);
+	gsm_modem_update(dlci, 0);
 }
 
 static int gsmtty_break_ctl(struct tty_struct *tty, int state)
@@ -3231,7 +3340,7 @@ static int gsmtty_break_ctl(struct tty_struct *tty, int state)
 		if (encode > 0x0F)
 			encode = 0x0F;	/* Best effort */
 	}
-	return gsmtty_modem_update(dlci, encode);
+	return gsm_modem_update(dlci, encode);
 }
 
 static void gsmtty_cleanup(struct tty_struct *tty)
-- 
2.25.1

