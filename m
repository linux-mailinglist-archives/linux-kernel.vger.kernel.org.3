Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A585AC361
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 10:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiIDIKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 04:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiIDIKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 04:10:02 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6043424F33;
        Sun,  4 Sep 2022 01:10:00 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 7F8A62013EB;
        Sun,  4 Sep 2022 08:09:56 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 9EB01804A6; Sun,  4 Sep 2022 10:02:50 +0200 (CEST)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org
Subject: [PATCH] random / hw_random: core: start hwrng kthread also for untrusted sources
Date:   Sun,  4 Sep 2022 10:02:47 +0200
Message-Id: <20220904080247.7890-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.37.3
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

Start the hwrng kthread even if the hwrng source has a quality setting
of zero. Then, every CRNG_RESEED_INTERVAL, one batch of data from this
zero-quality hwrng source will be mixed into the CRNG pool.

However, to avoid that an untrusted device assists in initializing the
CRNG, go to sleep in add_hwgenerator_randomness() in case the entropy
parameter passed to that function is zero.

This patch is based on the assumption that data from a hwrng source
will not actively harm the CRNG state, but that many hwrng sources
(such as TPM devices), even though they are assigend a quality level of
zero, actually provide some entropy, which is good to mix into the CRNG
pool every once in a while.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/hw_random/core.c | 36 ++++++++++-------------------------
 drivers/char/random.c         |  4 ++--
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 16f227b995e8..edb86c0cccda 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -52,7 +52,7 @@ MODULE_PARM_DESC(default_quality,
 
 static void drop_current_rng(void);
 static int hwrng_init(struct hwrng *rng);
-static void hwrng_manage_rngd(struct hwrng *rng);
+static int hwrng_fillfn(void *unused);
 
 static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
 			       int wait);
@@ -96,6 +96,15 @@ static int set_current_rng(struct hwrng *rng)
 	drop_current_rng();
 	current_rng = rng;
 
+	/* if necessary, start hwrng thread */
+	if (!hwrng_fill) {
+		hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
+		if (IS_ERR(hwrng_fill)) {
+			pr_err("hwrng_fill thread creation failed\n");
+			hwrng_fill = NULL;
+		}
+	}
+
 	return 0;
 }
 
@@ -167,8 +176,6 @@ static int hwrng_init(struct hwrng *rng)
 		rng->quality = 1024;
 	current_quality = rng->quality; /* obsolete */
 
-	hwrng_manage_rngd(rng);
-
 	return 0;
 }
 
@@ -454,10 +461,6 @@ static ssize_t rng_quality_store(struct device *dev,
 	/* the best available RNG may have changed */
 	ret = enable_best_rng();
 
-	/* start/stop rngd if necessary */
-	if (current_rng)
-		hwrng_manage_rngd(current_rng);
-
 out:
 	mutex_unlock(&rng_mutex);
 	return ret ? ret : len;
@@ -509,9 +512,6 @@ static int hwrng_fillfn(void *unused)
 		mutex_unlock(&reading_mutex);
 		put_rng(rng);
 
-		if (!quality)
-			break;
-
 		if (rc <= 0) {
 			pr_warn("hwrng: no data available\n");
 			msleep_interruptible(10000);
@@ -533,22 +533,6 @@ static int hwrng_fillfn(void *unused)
 	return 0;
 }
 
-static void hwrng_manage_rngd(struct hwrng *rng)
-{
-	if (WARN_ON(!mutex_is_locked(&rng_mutex)))
-		return;
-
-	if (rng->quality == 0 && hwrng_fill)
-		kthread_stop(hwrng_fill);
-	if (rng->quality > 0 && !hwrng_fill) {
-		hwrng_fill = kthread_run(hwrng_fillfn, NULL, "hwrng");
-		if (IS_ERR(hwrng_fill)) {
-			pr_err("hwrng_fill thread creation failed\n");
-			hwrng_fill = NULL;
-		}
-	}
-}
-
 int hwrng_register(struct hwrng *rng)
 {
 	int err = -EINVAL;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 79d7d4e4e582..b360ed4ece03 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -867,9 +867,9 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 
 	/*
 	 * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
-	 * we're not yet initialized.
+	 * we're not yet initialized or this source isn't trusted.
 	 */
-	if (!kthread_should_stop() && crng_ready())
+	if (!kthread_should_stop() && (crng_ready() || !entropy))
 		schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
-- 
2.37.3

