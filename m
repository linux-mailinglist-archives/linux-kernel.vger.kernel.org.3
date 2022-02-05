Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7814AAD11
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 00:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381447AbiBEXfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 18:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiBEXfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 18:35:16 -0500
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 15:35:14 PST
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A125DC061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 15:35:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 54ADB1F7;
        Sun,  6 Feb 2022 00:30:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2xG9pPbeLRYL; Sun,  6 Feb 2022 00:29:59 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 34512171;
        Sun,  6 Feb 2022 00:29:59 +0100 (CET)
Received: from samy by begin with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1nGUVB-00HZhK-PH;
        Sun, 06 Feb 2022 00:29:57 +0100
Date:   Sun, 6 Feb 2022 00:29:57 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCH] [speakup] Allow lower values for the flush parameter
Message-ID: <20220205232957.bc6o6yyt5hitg754@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: /
Authentication-Results: hera.aquilenet.fr;
        none
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 54ADB1F7
X-Spamd-Result: default: False [0.40 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_LAST(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[]
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users needing it with the dectlk synth report that a 100ms flush delay
is still noticeable and prefer to set it to e.g. 10ms. This leaves the
default to 4000ms (since hitting it is a sign that the cable is faulty
and should be replaced), but allows to set it as short as 10ms.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
index 2b8699673bac..eea2a2fa4f01 100644
--- a/drivers/accessibility/speakup/synth.c
+++ b/drivers/accessibility/speakup/synth.c
@@ -348,7 +348,7 @@ struct var_t synth_time_vars[] = {
 	{ TRIGGER, .u.n = {NULL, 20, 10, 2000, 0, 0, NULL } },
 	{ JIFFY, .u.n = {NULL, 50, 20, 200, 0, 0, NULL } },
 	{ FULL, .u.n = {NULL, 400, 200, 60000, 0, 0, NULL } },
-	{ FLUSH, .u.n = {NULL, 4000, 100, 4000, 0, 0, NULL } },
+	{ FLUSH, .u.n = {NULL, 4000, 10, 4000, 0, 0, NULL } },
 	V_LAST_VAR
 };
 
