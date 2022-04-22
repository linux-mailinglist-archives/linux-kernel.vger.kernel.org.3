Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC4D50B12E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444715AbiDVHOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444672AbiDVHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:14:36 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 00:11:43 PDT
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AEE51323
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:11:42 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202204220710375252303e7d3f2d72cb
        for <linux-kernel@vger.kernel.org>;
        Fri, 22 Apr 2022 09:10:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HCoAqgrHQKyCuVz/FqZ9uH/p1/IK2zii6dkkGwez/mU=;
 b=jPKcKXwf8hiVr35oLisxodp1qoe/LaKPPpj/UjYmsBbD7UwO/ufEw7tC1YCot34buHWQDO
 TKMfWrG1O/EjKNw76/rTa8/yW4u+8qu5H916AjeoaAPrxfulpbw3rjmmZQXv3AAoNS9Erxk+
 /8valCbdXUMmYoJkAjA78VIe3bsT0=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 3/3] tty: n_gsm: fix software flow control handling
Date:   Fri, 22 Apr 2022 00:10:25 -0700
Message-Id: <20220422071025.5490-3-daniel.starke@siemens.com>
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
the newer 27.010 here. Chapter 5.4.8.1 states that XON/XOFF characters
shall be used instead of Fcon/Fcoff command in advanced option mode to
handle flow control. Chapter 5.4.8.2 describes how XON/XOFF characters
shall be handled. Basic option mode only used Fcon/Fcoff commands and no
XON/XOFF characters. These are treated as data bytes here.
The current implementation uses the gsm_mux field 'constipated' to handle
flow control from the remote peer and the gsm_dlci field 'constipated' to
handle flow control from each DLCI. The later is unrelated to this patch.
The gsm_mux field is correctly set for Fcon/Fcoff commands in
gsm_control_message(). However, the same is not true for XON/XOFF
characters in gsm1_receive().
Disable software flow control handling in the tty to allow explicit
handling by n_gsm.
Add the missing handling in advanced option mode for gsm_mux in
gsm1_receive() to comply with the standard.

This patch depends on the following commit:
Commit 8838b2af23ca ("tty: n_gsm: fix SW flow control encoding/handling")

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 570f0b8b7576..8652308c187f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -232,6 +232,7 @@ struct gsm_mux {
 	int initiator;			/* Did we initiate connection */
 	bool dead;			/* Has the mux been shut down */
 	struct gsm_dlci *dlci[NUM_DLCI];
+	int old_c_iflag;		/* termios c_iflag value before attach */
 	bool constipated;		/* Asked by remote to shut up */
 
 	spinlock_t tx_lock;
@@ -2022,6 +2023,16 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 
 static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 {
+	/* handle XON/XOFF */
+	if ((c & ISO_IEC_646_MASK) == XON) {
+		gsm->constipated = true;
+		return;
+	} else if ((c & ISO_IEC_646_MASK) == XOFF) {
+		gsm->constipated = false;
+		/* Kick the link in case it is idling */
+		gsm_data_kick(gsm, NULL);
+		return;
+	}
 	if (c == GSM1_SOF) {
 		/* EOF is only valid in frame if we have got to the data state */
 		if (gsm->state == GSM_DATA) {
@@ -2449,6 +2460,9 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	int ret, i;
 
 	gsm->tty = tty_kref_get(tty);
+	/* Turn off tty XON/XOFF handling to handle it explicitly. */
+	gsm->old_c_iflag = tty->termios.c_iflag;
+	tty->termios.c_iflag &= (IXON | IXOFF);
 	ret =  gsm_activate_mux(gsm);
 	if (ret != 0)
 		tty_kref_put(gsm->tty);
@@ -2489,6 +2503,8 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	WARN_ON(tty != gsm->tty);
 	for (i = 1; i < NUM_DLCI; i++)
 		tty_unregister_device(gsm_tty_driver, base + i);
+	/* Restore tty XON/XOFF handling. */
+	gsm->tty->termios.c_iflag = gsm->old_c_iflag;
 	tty_kref_put(gsm->tty);
 	gsm->tty = NULL;
 }
-- 
2.25.1

