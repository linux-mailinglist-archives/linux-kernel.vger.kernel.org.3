Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE734562B6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiGAGSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiGAGSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:18:40 -0400
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC1928708
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:18:37 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20220701061835b4a450f9caa7cb455a
        for <linux-kernel@vger.kernel.org>;
        Fri, 01 Jul 2022 08:18:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Q3xME2eakWdOnQ/QXFCEHQhhMH2gb9P2XFSPGWjYtsA=;
 b=b937ZNB+cLSe587w6GVQIku/pEIVf/Pd7fGNGuiGtJyMPAWPys7pbTuu1AQ2U8LbZb8dYQ
 ZhXp9vxhYsckl1H8cuCRhy9cav/sBVYIUmiig+fEB5i8+fO5it3qFpB1iU0RC7DTvCkEsor4
 kZKI0v1a0oLHyWb3Tan4tV/ZPerLQ=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 2/9] tty: n_gsm: fix tty registration before control channel open
Date:   Fri,  1 Jul 2022 08:16:45 +0200
Message-Id: <20220701061652.39604-2-daniel.starke@siemens.com>
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

The current implementation registers/deregisters the user ttys at mux
attach/detach. That means that the user devices are available before any
control channel is open. However, user channel initialization requires an
open control channel. Furthermore, the user is not informed if the mux
restarts due to configuration changes.
Put the registration/deregistration procedure into separate function to
improve readability.
Move registration to mux activation and deregistration to mux cleanup to
keep the user devices only open as long as a control channel exists. The
user will be informed via the device driver if the mux was reconfigured in
a way that required a mux re-activation.
This makes it necessary to add T2 initialization to gsmld_open() for the
ldisc open code path (not the reconfiguration code path) to avoid deletion
of an uninitialized T2 at mux cleanup.

Fixes: d50f6dcaf22a ("tty: n_gsm: expose gsmtty device nodes at ldisc open time")
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 117 ++++++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 38 deletions(-)

Stable backport remark has been removed compared to v3. No other changes applied.

Link: https://lore.kernel.org/all/20220530144512.2731-2-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 63314fe5e43b..9b0bbd0d35d0 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -235,6 +235,7 @@ struct gsm_mux {
 	struct gsm_dlci *dlci[NUM_DLCI];
 	int old_c_iflag;		/* termios c_iflag value before attach */
 	bool constipated;		/* Asked by remote to shut up */
+	bool has_devices;		/* Devices were registered */
 
 	spinlock_t tx_lock;
 	unsigned int tx_bytes;		/* TX data outstanding */
@@ -444,6 +445,68 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
 	return modembits;
 }
 
+/**
+ *	gsm_register_devices	-	register all tty devices for a given mux index
+ *
+ *	@driver: the tty driver that describes the tty devices
+ *	@index:  the mux number is used to calculate the minor numbers of the
+ *	         ttys for this mux and may differ from the position in the
+ *	         mux array.
+ */
+static int gsm_register_devices(struct tty_driver *driver, unsigned int index)
+{
+	struct device *dev;
+	int i;
+	unsigned int base;
+
+	if (!driver || index >= MAX_MUX)
+		return -EINVAL;
+
+	base = index * NUM_DLCI; /* first minor for this index */
+	for (i = 1; i < NUM_DLCI; i++) {
+		/* Don't register device 0 - this is the control channel
+		 * and not a usable tty interface
+		 */
+		dev = tty_register_device(gsm_tty_driver, base + i, NULL);
+		if (IS_ERR(dev)) {
+			if (debug & 8)
+				pr_info("%s failed to register device minor %u",
+					__func__, base + i);
+			for (i--; i >= 1; i--)
+				tty_unregister_device(gsm_tty_driver, base + i);
+			return PTR_ERR(dev);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ *	gsm_unregister_devices	-	unregister all tty devices for a given mux index
+ *
+ *	@driver: the tty driver that describes the tty devices
+ *	@index:  the mux number is used to calculate the minor numbers of the
+ *	         ttys for this mux and may differ from the position in the
+ *	         mux array.
+ */
+static void gsm_unregister_devices(struct tty_driver *driver,
+				   unsigned int index)
+{
+	int i;
+	unsigned int base;
+
+	if (!driver || index >= MAX_MUX)
+		return;
+
+	base = index * NUM_DLCI; /* first minor for this index */
+	for (i = 1; i < NUM_DLCI; i++) {
+		/* Don't unregister device 0 - this is the control
+		 * channel and not a usable tty interface
+		 */
+		tty_unregister_device(gsm_tty_driver, base + i);
+	}
+}
+
 /**
  *	gsm_print_packet	-	display a frame for debug
  *	@hdr: header to print before decode
@@ -2191,6 +2254,10 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	del_timer_sync(&gsm->t2_timer);
 
 	/* Free up any link layer users and finally the control channel */
+	if (gsm->has_devices) {
+		gsm_unregister_devices(gsm_tty_driver, gsm->num);
+		gsm->has_devices = false;
+	}
 	for (i = NUM_DLCI - 1; i >= 0; i--)
 		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
@@ -2214,6 +2281,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 static int gsm_activate_mux(struct gsm_mux *gsm)
 {
 	struct gsm_dlci *dlci;
+	int ret;
 
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
 	init_waitqueue_head(&gsm->event);
@@ -2225,9 +2293,14 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	else
 		gsm->receive = gsm1_receive;
 
+	ret = gsm_register_devices(gsm_tty_driver, gsm->num);
+	if (ret)
+		return ret;
+
 	dlci = gsm_dlci_alloc(gsm, 0);
 	if (dlci == NULL)
 		return -ENOMEM;
+	gsm->has_devices = true;
 	gsm->dead = false;		/* Tty opens are now permissible */
 	return 0;
 }
@@ -2488,39 +2561,14 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
  *	will need moving to an ioctl path.
  */
 
-static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
+static void gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
-	unsigned int base;
-	int ret, i;
-
 	gsm->tty = tty_kref_get(tty);
 	/* Turn off tty XON/XOFF handling to handle it explicitly. */
 	gsm->old_c_iflag = tty->termios.c_iflag;
 	tty->termios.c_iflag &= (IXON | IXOFF);
-	ret =  gsm_activate_mux(gsm);
-	if (ret != 0)
-		tty_kref_put(gsm->tty);
-	else {
-		/* Don't register device 0 - this is the control channel and not
-		   a usable tty interface */
-		base = mux_num_to_base(gsm); /* Base for this MUX */
-		for (i = 1; i < NUM_DLCI; i++) {
-			struct device *dev;
-
-			dev = tty_register_device(gsm_tty_driver,
-							base + i, NULL);
-			if (IS_ERR(dev)) {
-				for (i--; i >= 1; i--)
-					tty_unregister_device(gsm_tty_driver,
-								base + i);
-				return PTR_ERR(dev);
-			}
-		}
-	}
-	return ret;
 }
 
-
 /**
  *	gsmld_detach_gsm	-	stop doing 0710 mux
  *	@tty: tty attached to the mux
@@ -2531,12 +2579,7 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 
 static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 {
-	unsigned int base = mux_num_to_base(gsm); /* Base for this MUX */
-	int i;
-
 	WARN_ON(tty != gsm->tty);
-	for (i = 1; i < NUM_DLCI; i++)
-		tty_unregister_device(gsm_tty_driver, base + i);
 	/* Restore tty XON/XOFF handling. */
 	gsm->tty->termios.c_iflag = gsm->old_c_iflag;
 	tty_kref_put(gsm->tty);
@@ -2629,7 +2672,6 @@ static void gsmld_close(struct tty_struct *tty)
 static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
-	int ret;
 
 	if (tty->ops->write == NULL)
 		return -EINVAL;
@@ -2645,12 +2687,11 @@ static int gsmld_open(struct tty_struct *tty)
 	/* Attach the initial passive connection */
 	gsm->encoding = 1;
 
-	ret = gsmld_attach_gsm(tty, gsm);
-	if (ret != 0) {
-		gsm_cleanup_mux(gsm, false);
-		mux_put(gsm);
-	}
-	return ret;
+	gsmld_attach_gsm(tty, gsm);
+
+	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
+
+	return 0;
 }
 
 /**
-- 
2.34.1

