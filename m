Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7784ADDBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381805AbiBHPyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382192AbiBHPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:54:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8055C061579;
        Tue,  8 Feb 2022 07:54:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6256F61657;
        Tue,  8 Feb 2022 15:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45922C340E9;
        Tue,  8 Feb 2022 15:54:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gsakA+XT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644335642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTCMClZ/8hdkID8gWxLun/PWoNRaIRZF4QHrYPAUfKE=;
        b=gsakA+XT3TJ3oSPIg3PHxrEcopoSu7eJYc1J7WmhkESKNXEZgW3t/GQautXYQB3/aTtQ33
        Zg202BSZg95BDPHF62tt0Rtbhyg0fcUI3o1vmzbkUjW6d6hR6L4DX1FN0sQup1xxF/k7Dk
        JMdOT4DHSbaEpJcyXK13u7fvnbP3oWY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c20a5771 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 8 Feb 2022 15:54:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v1 3/7] random: inline leaves of rand_initialize()
Date:   Tue,  8 Feb 2022 16:53:31 +0100
Message-Id: <20220208155335.378318-4-Jason@zx2c4.com>
In-Reply-To: <20220208155335.378318-1-Jason@zx2c4.com>
References: <20220208155335.378318-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the following one. We simply inline the
various functions that rand_initialize() calls that have no other
callers. The compiler was doing this anyway before. Doing this will
allow us to reorganize this after.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 90 ++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 57 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 59d8d38f6a07..db0e0e77613e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -471,42 +471,6 @@ static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 
 static void invalidate_batched_entropy(void);
 
-static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
-static int __init parse_trust_cpu(char *arg)
-{
-	return kstrtobool(arg, &trust_cpu);
-}
-early_param("random.trust_cpu", parse_trust_cpu);
-
-static bool __init crng_init_try_arch_early(void)
-{
-	int i;
-	bool arch_init = true;
-	unsigned long rv;
-
-	for (i = 4; i < 16; i++) {
-		if (!arch_get_random_seed_long_early(&rv) &&
-		    !arch_get_random_long_early(&rv)) {
-			rv = random_get_entropy();
-			arch_init = false;
-		}
-		primary_crng.state[i] ^= rv;
-	}
-
-	return arch_init;
-}
-
-static void __init crng_initialize(void)
-{
-	extract_entropy(&primary_crng.state[4], sizeof(u32) * 12);
-	if (crng_init_try_arch_early() && trust_cpu && crng_init < 2) {
-		invalidate_batched_entropy();
-		crng_init = 2;
-		pr_notice("crng init done (trusting CPU's manufacturer)\n");
-	}
-	primary_crng.init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
-}
-
 /*
  * crng_fast_load() can be called by code in the interrupt service
  * path.  So we can't afford to dilly-dally. Returns the number of
@@ -1230,17 +1194,28 @@ int __must_check get_random_bytes_arch(void *buf, int nbytes)
 }
 EXPORT_SYMBOL(get_random_bytes_arch);
 
+static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
+static int __init parse_trust_cpu(char *arg)
+{
+	return kstrtobool(arg, &trust_cpu);
+}
+early_param("random.trust_cpu", parse_trust_cpu);
+
 /*
- * init_std_data - initialize pool with system data
- *
- * This function clears the pool's entropy count and mixes some system
- * data into the pool to prepare it for use. The pool is not cleared
- * as that can only decrease the entropy in the pool.
+ * Note that setup_arch() may call add_device_randomness()
+ * long before we get here. This allows seeding of the pools
+ * with some platform dependent data very early in the boot
+ * process. But it limits our options here. We must use
+ * statically allocated structures that already have all
+ * initializations complete at compile time. We should also
+ * take care not to overwrite the precious per platform data
+ * we were given.
  */
-static void __init init_std_data(void)
+int __init rand_initialize(void)
 {
 	int i;
 	ktime_t now = ktime_get_real();
+	bool arch_init = true;
 	unsigned long rv;
 
 	mix_pool_bytes(&now, sizeof(now));
@@ -1251,22 +1226,23 @@ static void __init init_std_data(void)
 		mix_pool_bytes(&rv, sizeof(rv));
 	}
 	mix_pool_bytes(utsname(), sizeof(*(utsname())));
-}
 
-/*
- * Note that setup_arch() may call add_device_randomness()
- * long before we get here. This allows seeding of the pools
- * with some platform dependent data very early in the boot
- * process. But it limits our options here. We must use
- * statically allocated structures that already have all
- * initializations complete at compile time. We should also
- * take care not to overwrite the precious per platform data
- * we were given.
- */
-int __init rand_initialize(void)
-{
-	init_std_data();
-	crng_initialize();
+	extract_entropy(&primary_crng.state[4], sizeof(u32) * 12);
+	for (i = 4; i < 16; i++) {
+		if (!arch_get_random_seed_long_early(&rv) &&
+		    !arch_get_random_long_early(&rv)) {
+			rv = random_get_entropy();
+			arch_init = false;
+		}
+		primary_crng.state[i] ^= rv;
+	}
+	if (arch_init && trust_cpu && crng_init < 2) {
+		invalidate_batched_entropy();
+		crng_init = 2;
+		pr_notice("crng init done (trusting CPU's manufacturer)\n");
+	}
+	primary_crng.init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
+
 	if (ratelimit_disable) {
 		urandom_warning.interval = 0;
 		unseeded_warning.interval = 0;
-- 
2.35.0

