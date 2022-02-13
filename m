Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04514B3D94
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiBMUun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:50:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiBMUuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:50:23 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680353715;
        Sun, 13 Feb 2022 12:50:16 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 58AB9201335;
        Sun, 13 Feb 2022 20:50:15 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id E59A5809A1; Sun, 13 Feb 2022 21:48:33 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 3/4] hw_random: use per-rng quality value instead of global setting
Date:   Sun, 13 Feb 2022 21:46:30 +0100
Message-Id: <20220213204631.354247-4-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213204631.354247-1-linux@dominikbrodowski.net>
References: <20220213204631.354247-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current_quality variable exposed as a module parameter is
fundamentally broken: If it is set at boot time, it is overwritten once
the first hw rng device is loaded; if it is set at runtime, it is
without effect if the hw rng device had its quality value set to 0 (and
no default_quality was set); and if a new rng is selected, it gets
overwritten. Therefore, mark it as obsolete, and replace it by the
per-rng quality setting.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/hw_random/core.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 29febf55b0d4..8df102b39b35 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -44,14 +44,14 @@ static unsigned short default_quality; /* = 0; default to "off" */
 
 module_param(current_quality, ushort, 0644);
 MODULE_PARM_DESC(current_quality,
-		 "current hwrng entropy estimation per 1024 bits of input");
+		 "current hwrng entropy estimation per 1024 bits of input -- obsolete");
 module_param(default_quality, ushort, 0644);
 MODULE_PARM_DESC(default_quality,
 		 "default entropy content of hwrng per 1024 bits of input");
 
 static void drop_current_rng(void);
 static int hwrng_init(struct hwrng *rng);
-static void hwrng_manage_rngd(void);
+static void hwrng_manage_rngd(struct hwrng *rng);
 
 static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 			       int wait);
@@ -160,11 +160,13 @@ static int hwrng_init(struct hwrng *rng)
 	reinit_completion(&rng->cleanup_done);
 
 skip_init:
-	current_quality = rng->quality ? : default_quality;
-	if (current_quality > 1024)
-		current_quality = 1024;
+	if (!rng->quality)
+		rng->quality = default_quality;
+	if (rng->quality > 1024)
+		rng->quality = 1024;
+	current_quality = rng->quality; /* obsolete */
 
-	hwrng_manage_rngd();
+	hwrng_manage_rngd(rng);
 
 	return 0;
 }
@@ -429,19 +431,24 @@ static int hwrng_fillfn(void *unused)
 	long rc;
 
 	while (!kthread_should_stop()) {
+		unsigned short quality;
 		struct hwrng *rng;
 
-		if (!current_quality)
-			break;
-
 		rng = get_current_rng();
 		if (IS_ERR(rng) || !rng)
 			break;
 		mutex_lock(&reading_mutex);
 		rc = rng_get_data(rng, rng_fillbuf,
 				  rng_buffer_size(), 1);
+		if (current_quality != rng->quality)
+			rng->quality = current_quality; /* obsolete */
+		quality = rng->quality;
 		mutex_unlock(&reading_mutex);
 		put_rng(rng);
+
+		if (!quality)
+			break;
+
 		if (rc <= 0) {
 			pr_warn("hwrng: no data available\n");
 			msleep_interruptible(10000);
@@ -451,7 +458,7 @@ static int hwrng_fillfn(void *unused)
 		/* If we cannot credit at least one bit of entropy,
 		 * keep track of the remainder for the next iteration
 		 */
-		entropy = rc * current_quality * 8 + entropy_credit;
+		entropy = rc * quality * 8 + entropy_credit;
 		if ((entropy >> 10) == 0)
 			entropy_credit = entropy;
 
@@ -463,14 +470,14 @@ static int hwrng_fillfn(void *unused)
 	return 0;
 }
 
-static void hwrng_manage_rngd(void)
+static void hwrng_manage_rngd(struct hwrng *rng)
 {
 	if (WARN_ON(!mutex_is_locked(&rng_mutex)))
 		return;
 
-	if (current_quality == 0 && hwrng_fill)
+	if (rng->quality == 0 && hwrng_fill)
 		kthread_stop(hwrng_fill);
-	if (current_quality > 0 && !hwrng_fill) {
+	if (rng->quality > 0 && !hwrng_fill) {
 		hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
 		if (IS_ERR(hwrng_fill)) {
 			pr_err("hwrng_fill thread creation failed\n");
-- 
2.35.1

