Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4234B3D8F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbiBMUuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:50:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiBMUuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:50:23 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD0B53723;
        Sun, 13 Feb 2022 12:50:17 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 58EC220133D;
        Sun, 13 Feb 2022 20:50:15 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 58AF3808C5; Sun, 13 Feb 2022 21:48:21 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 2/4] hw_random: start and stop in-kernel rngd in separate function
Date:   Sun, 13 Feb 2022 21:46:29 +0100
Message-Id: <20220213204631.354247-3-linux@dominikbrodowski.net>
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

Extract the start/stop logic for the in-kernel rngd thread to
a separate function.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/hw_random/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 6f09f4e5af20..29febf55b0d4 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -51,7 +51,7 @@ MODULE_PARM_DESC(default_quality,
 
 static void drop_current_rng(void);
 static int hwrng_init(struct hwrng *rng);
-static void start_khwrngd(void);
+static void hwrng_manage_rngd(void);
 
 static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 			       int wait);
@@ -164,10 +164,7 @@ static int hwrng_init(struct hwrng *rng)
 	if (current_quality > 1024)
 		current_quality = 1024;
 
-	if (current_quality == 0 && hwrng_fill)
-		kthread_stop(hwrng_fill);
-	if (current_quality > 0 && !hwrng_fill)
-		start_khwrngd();
+	hwrng_manage_rngd();
 
 	return 0;
 }
@@ -466,12 +463,19 @@ static int hwrng_fillfn(void *unused)
 	return 0;
 }
 
-static void start_khwrngd(void)
+static void hwrng_manage_rngd(void)
 {
-	hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
-	if (IS_ERR(hwrng_fill)) {
-		pr_err("hwrng_fill thread creation failed\n");
-		hwrng_fill = NULL;
+	if (WARN_ON(!mutex_is_locked(&rng_mutex)))
+		return;
+
+	if (current_quality == 0 && hwrng_fill)
+		kthread_stop(hwrng_fill);
+	if (current_quality > 0 && !hwrng_fill) {
+		hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
+		if (IS_ERR(hwrng_fill)) {
+			pr_err("hwrng_fill thread creation failed\n");
+			hwrng_fill = NULL;
+		}
 	}
 }
 
-- 
2.35.1

