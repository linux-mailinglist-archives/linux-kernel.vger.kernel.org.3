Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3306B500A26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbiDNJqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiDNJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:14 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:49 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918FC6EB29
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:43:49 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20220414094239dd843d76be31c539da
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uTcDp5Nkl0VvZJ5XdRbzpKlEWkQB5/anDN6tDzknOUE=;
 b=GZ48m/9p85aNxNoD8yNT0TphwgiHWuPTzyWlFKn0+bQNpXOk0i53OMU1Xacxr6dYqjoeuP
 BoqCvrHxmxUZ6kV1ztyYx6XEs65CSEECdCCejF0R/6u2ujVaUhPRZwG4vro8ZUC9yoVzmXQS
 BG4Jp6DZc17sRJoOi342GmF13qTb4=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 02/20] tty: n_gsm: fix restart handling via CLD command
Date:   Thu, 14 Apr 2022 02:42:07 -0700
Message-Id: <20220414094225.4527-2-daniel.starke@siemens.com>
In-Reply-To: <20220414094225.4527-1-daniel.starke@siemens.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
the newer 27.010 here. Chapter 5.8.2 states that both sides will revert to
the non-multiplexed mode via a close-down message (CLD). The usual program
flow is as following:
- start multiplex mode by sending AT+CMUX to the mobile
- establish the control channel (DLCI 0)
- establish user channels (DLCI >0)
- terminate user channels
- send close-down message (CLD)
- revert to AT protocol (i.e. leave multiplexed mode)

The AT protocol is out of scope of the n_gsm driver. However,
gsm_disconnect() sends CLD if gsm_config() detects that the requested
parameters require the mux protocol to restart. The next immediate action
is to start the mux protocol by opening DLCI 0 again. Any responder side
which handles CLD commands correctly forces us to fail at this point
because AT+CMUX needs to be sent to the mobile to start the mux again.
Therefore, remove the CLD command in this phase and keep both sides in
multiplexed mode.
Remove the gsm_disconnect() function as it become unnecessary and merge the
remaining parts into gsm_cleanup_mux() to handle the termination order and
locking correctly.

Fixes: 71e077915396 ("tty: n_gsm: do not send/receive in ldisc close path")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 68 +++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3d28ecebd473..daaffcfadaae 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2106,49 +2106,35 @@ static void gsm_error(struct gsm_mux *gsm)
 	gsm->io_error++;
 }
 
-static int gsm_disconnect(struct gsm_mux *gsm)
-{
-	struct gsm_dlci *dlci = gsm->dlci[0];
-	struct gsm_control *gc;
-
-	if (!dlci)
-		return 0;
-
-	/* In theory disconnecting DLCI 0 is sufficient but for some
-	   modems this is apparently not the case. */
-	gc = gsm_control_send(gsm, CMD_CLD, NULL, 0);
-	if (gc)
-		gsm_control_wait(gsm, gc);
-
-	del_timer_sync(&gsm->t2_timer);
-	/* Now we are sure T2 has stopped */
-
-	gsm_dlci_begin_close(dlci);
-	wait_event_interruptible(gsm->event,
-				dlci->state == DLCI_CLOSED);
-
-	if (signal_pending(current))
-		return -EINTR;
-
-	return 0;
-}
-
 /**
  *	gsm_cleanup_mux		-	generic GSM protocol cleanup
  *	@gsm: our mux
+ *	@disc: disconnect link?
  *
  *	Clean up the bits of the mux which are the same for all framing
  *	protocols. Remove the mux from the mux table, stop all the timers
  *	and then shut down each device hanging up the channels as we go.
  */
 
-static void gsm_cleanup_mux(struct gsm_mux *gsm)
+static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 {
 	int i;
 	struct gsm_dlci *dlci = gsm->dlci[0];
 	struct gsm_msg *txq, *ntxq;
 
 	gsm->dead = true;
+	mutex_lock(&gsm->mutex);
+
+	if (dlci) {
+		if (disc && dlci->state != DLCI_CLOSED) {
+			gsm_dlci_begin_close(dlci);
+			wait_event(gsm->event, dlci->state == DLCI_CLOSED);
+		}
+		dlci->dead = true;
+	}
+
+	/* Finish outstanding timers, making sure they are done */
+	del_timer_sync(&gsm->t2_timer);
 
 	spin_lock(&gsm_mux_lock);
 	for (i = 0; i < MAX_MUX; i++) {
@@ -2162,13 +2148,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
 	if (i == MAX_MUX)
 		return;
 
-	del_timer_sync(&gsm->t2_timer);
-	/* Now we are sure T2 has stopped */
-	if (dlci)
-		dlci->dead = true;
-
 	/* Free up any link layer users */
-	mutex_lock(&gsm->mutex);
 	for (i = 0; i < NUM_DLCI; i++)
 		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
@@ -2370,19 +2350,11 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 
 	/*
 	 * Close down what is needed, restart and initiate the new
-	 * configuration
+	 * configuration. On the first time there is no DLCI[0]
+	 * and closing or cleaning up is not necessary.
 	 */
-
-	if (need_close || need_restart) {
-		int ret;
-
-		ret = gsm_disconnect(gsm);
-
-		if (ret)
-			return ret;
-	}
-	if (need_restart)
-		gsm_cleanup_mux(gsm);
+	if (need_close || need_restart)
+		gsm_cleanup_mux(gsm, true);
 
 	gsm->initiator = c->initiator;
 	gsm->mru = c->mru;
@@ -2494,7 +2466,7 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 		for (i = 1; i < NUM_DLCI; i++)
 			tty_unregister_device(gsm_tty_driver, base + i);
 	}
-	gsm_cleanup_mux(gsm);
+	gsm_cleanup_mux(gsm, false);
 	tty_kref_put(gsm->tty);
 	gsm->tty = NULL;
 }
@@ -2597,7 +2569,7 @@ static int gsmld_open(struct tty_struct *tty)
 
 	ret = gsmld_attach_gsm(tty, gsm);
 	if (ret != 0) {
-		gsm_cleanup_mux(gsm);
+		gsm_cleanup_mux(gsm, false);
 		mux_put(gsm);
 	}
 	return ret;
-- 
2.25.1

