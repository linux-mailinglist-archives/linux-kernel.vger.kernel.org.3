Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA85AC3D7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiIDKSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 06:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiIDKSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 06:18:11 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA494506D;
        Sun,  4 Sep 2022 03:18:10 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id B44AF2013F1;
        Sun,  4 Sep 2022 10:18:08 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id C5B1780905; Sun,  4 Sep 2022 12:17:58 +0200 (CEST)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org
Subject: [PATCH] random: use hwgenerator randomness more frequently at early boot
Date:   Sun,  4 Sep 2022 12:17:53 +0200
Message-Id: <20220904101753.3050-1-linux@dominikbrodowski.net>
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

Mix in randomness from hw-rng sources more frequently during early
boot, approximately once for every rng reseed.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---

This patch is currently based on
	[PATCH] random / hw_random: core: start hwrng kthread also for untrusted sources

Jason, if you prefer that this patch can be applied first (as it
makes sense also independently of the other patch), this ordering
should be trivial to change.

 drivers/char/random.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b360ed4ece03..5559351f1259 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -260,25 +260,35 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 }
 
 /*
- * Return whether the crng seed is considered to be sufficiently old
- * that a reseeding is needed. This happens if the last reseeding
- * was CRNG_RESEED_INTERVAL ago, or during early boot, at an interval
- * proportional to the uptime.
+ * Return the interval to the next regular reseed of the crng. This
+ * equals CRNG_RESEED_INTERVAL, or during early boot, an interval
+ * proportional to the uptime,
  */
-static bool crng_has_old_seed(void)
+static unsigned int crng_interval(void)
 {
 	static bool early_boot = true;
-	unsigned long interval = CRNG_RESEED_INTERVAL;
 
 	if (unlikely(READ_ONCE(early_boot))) {
 		time64_t uptime = ktime_get_seconds();
 		if (uptime >= CRNG_RESEED_INTERVAL / HZ * 2)
 			WRITE_ONCE(early_boot, false);
 		else
-			interval = max_t(unsigned int, CRNG_RESEED_START_INTERVAL,
-					 (unsigned int)uptime / 2 * HZ);
+			return max_t(unsigned int, CRNG_RESEED_START_INTERVAL,
+				     (unsigned int)uptime / 2 * HZ);
 	}
-	return time_is_before_jiffies(READ_ONCE(base_crng.birth) + interval);
+
+	return CRNG_RESEED_INTERVAL;
+}
+
+/*
+ * Return whether the crng seed is considered to be sufficiently old
+ * that a reseeding is needed. This happens if the last reseeding
+ * was CRNG_RESEED_INTERVAL ago, or during early boot, at an interval
+ * proportional to the uptime.
+ */
+static bool crng_has_old_seed(void)
+{
+	return time_is_before_jiffies(READ_ONCE(base_crng.birth) + crng_interval());
 }
 
 /*
@@ -866,11 +876,11 @@ void add_hwgenerator_randomness(const void *buf, size_t len, size_t entropy)
 	credit_init_bits(entropy);
 
 	/*
-	 * Throttle writing to once every CRNG_RESEED_INTERVAL, unless
+	 * Throttle writing to once every reseed interval, unless
 	 * we're not yet initialized or this source isn't trusted.
 	 */
 	if (!kthread_should_stop() && (crng_ready() || !entropy))
-		schedule_timeout_interruptible(CRNG_RESEED_INTERVAL);
+		schedule_timeout_interruptible(crng_interval());
 }
 EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
 
-- 
2.37.3

