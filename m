Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17F5500A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbiDNJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbiDNJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:46:14 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 02:43:50 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD56F49F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:43:49 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20220414094240d59dc1823e7e034b5c
        for <linux-kernel@vger.kernel.org>;
        Thu, 14 Apr 2022 11:42:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=11aQEbG0uJXoDTit7eTTEggwscwc7PJvAx4LM5VfELI=;
 b=dzXnulYxrV70irSyorXVmlpMQ7UmX1cxZmsueRplhnKmxMEJMrvqyeNWefXn9T8Ao/QOvn
 fRSl46cZABUsXbXOq1+5q7Hd+kZWWyfwx6HEAWhzBz7PNJ3OhUdlGqwKh2Vw0jDUgnFWiO0B
 KncTpPr1f+wE18BiaRRX+KpNMIY2E=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 03/20] tty: n_gsm: fix decoupled mux resource
Date:   Thu, 14 Apr 2022 02:42:08 -0700
Message-Id: <20220414094225.4527-3-daniel.starke@siemens.com>
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

The active mux instances are managed in the gsm_mux array and via mux_get()
and mux_put() functions separately. This gives a very loose coupling
between the actual instance and the gsm_mux array which manages it. It also
results in unnecessary lockings which makes it prone to failures. And it
creates a race condition if more than the maximum number of mux instances
are requested while the user changes the parameters of an active instance.
The user may loose ownership of the current mux instance in this case.
Fix this by moving the gsm_mux array handling to the mux allocation and
deallocation functions.

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 63 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index daaffcfadaae..f546dfe03d29 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2136,18 +2136,6 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	/* Finish outstanding timers, making sure they are done */
 	del_timer_sync(&gsm->t2_timer);
 
-	spin_lock(&gsm_mux_lock);
-	for (i = 0; i < MAX_MUX; i++) {
-		if (gsm_mux[i] == gsm) {
-			gsm_mux[i] = NULL;
-			break;
-		}
-	}
-	spin_unlock(&gsm_mux_lock);
-	/* open failed before registering => nothing to do */
-	if (i == MAX_MUX)
-		return;
-
 	/* Free up any link layer users */
 	for (i = 0; i < NUM_DLCI; i++)
 		if (gsm->dlci[i])
@@ -2171,7 +2159,6 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 static int gsm_activate_mux(struct gsm_mux *gsm)
 {
 	struct gsm_dlci *dlci;
-	int i = 0;
 
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
 	init_waitqueue_head(&gsm->event);
@@ -2183,18 +2170,6 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	else
 		gsm->receive = gsm1_receive;
 
-	spin_lock(&gsm_mux_lock);
-	for (i = 0; i < MAX_MUX; i++) {
-		if (gsm_mux[i] == NULL) {
-			gsm->num = i;
-			gsm_mux[i] = gsm;
-			break;
-		}
-	}
-	spin_unlock(&gsm_mux_lock);
-	if (i == MAX_MUX)
-		return -EBUSY;
-
 	dlci = gsm_dlci_alloc(gsm, 0);
 	if (dlci == NULL)
 		return -ENOMEM;
@@ -2210,6 +2185,15 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
  */
 static void gsm_free_mux(struct gsm_mux *gsm)
 {
+	int i;
+
+	for (i = 0; i < MAX_MUX; i++) {
+		if (gsm == gsm_mux[i]) {
+			gsm_mux[i] = NULL;
+			break;
+		}
+	}
+	mutex_destroy(&gsm->mutex);
 	kfree(gsm->txframe);
 	kfree(gsm->buf);
 	kfree(gsm);
@@ -2229,12 +2213,20 @@ static void gsm_free_muxr(struct kref *ref)
 
 static inline void mux_get(struct gsm_mux *gsm)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&gsm_mux_lock, flags);
 	kref_get(&gsm->ref);
+	spin_unlock_irqrestore(&gsm_mux_lock, flags);
 }
 
 static inline void mux_put(struct gsm_mux *gsm)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&gsm_mux_lock, flags);
 	kref_put(&gsm->ref, gsm_free_muxr);
+	spin_unlock_irqrestore(&gsm_mux_lock, flags);
 }
 
 static inline unsigned int mux_num_to_base(struct gsm_mux *gsm)
@@ -2255,6 +2247,7 @@ static inline unsigned int mux_line_to_num(unsigned int line)
 
 static struct gsm_mux *gsm_alloc_mux(void)
 {
+	int i;
 	struct gsm_mux *gsm = kzalloc(sizeof(struct gsm_mux), GFP_KERNEL);
 	if (gsm == NULL)
 		return NULL;
@@ -2284,6 +2277,26 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	gsm->mtu = 64;
 	gsm->dead = true;	/* Avoid early tty opens */
 
+	/* Store the instance to the mux array or abort if no space is
+	 * available.
+	 */
+	spin_lock(&gsm_mux_lock);
+	for (i = 0; i < MAX_MUX; i++) {
+		if (!gsm_mux[i]) {
+			gsm_mux[i] = gsm;
+			gsm->num = i;
+			break;
+		}
+	}
+	spin_unlock(&gsm_mux_lock);
+	if (i == MAX_MUX) {
+		mutex_destroy(&gsm->mutex);
+		kfree(gsm->txframe);
+		kfree(gsm->buf);
+		kfree(gsm);
+		return NULL;
+	}
+
 	return gsm;
 }
 
-- 
2.25.1

