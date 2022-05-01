Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9652651646E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbiEAMmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiEAMmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 08:42:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE79C66C92;
        Sun,  1 May 2022 05:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 451FBB80D69;
        Sun,  1 May 2022 12:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9260BC385A9;
        Sun,  1 May 2022 12:39:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Z48ZxlW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651408740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R7oHxsnSVkJzwRFPbGvtqio8GcixiqQ2bt7n7N7x8fo=;
        b=Z48ZxlW9ZU1DSDgErx14aIDfbnlkpcae/mMc9c4KDzuO0QZRi0rstdnS8TJWKGLFLc+cqd
        C45W9bWtCVwTvUK2s52/0F2bdnGhqM9AdJybz2raVhDGD+fTR0ajWcx4V8OXvaS74jzDrq
        fktRbuR9jgvEiDz7Gv00Wze/Ii/HjSk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 39f0bf52 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 1 May 2022 12:39:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: mix in timestamps and reseed on system restore
Date:   Sun,  1 May 2022 14:38:49 +0200
Message-Id: <20220501123849.3858-1-Jason@zx2c4.com>
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

Since the RNG loses freshness system suspend/hibernation, when we
resume, immediately reseed using whatever data we can, which for this
particular case is the various timestamps regarding system suspend time,
in addition to more generally the RDSEED/RDRAND/RDTSC values that happen
whenever the crng reseeds.

On systems that suspend and resume automatically all the time -- such as
Android -- we skip the reseeding on suspend resumption, since that could
wind up being far too busy. This is the same trade-off made in
WireGuard.

In addition to reseeding upon resumption always mix into the pool these
various stamps on every power notification event.

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0935a140795e..48eac27214ea 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -53,6 +53,7 @@
 #include <linux/completion.h>
 #include <linux/uuid.h>
 #include <linux/uaccess.h>
+#include <linux/suspend.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
 #include <asm/processor.h>
@@ -966,6 +967,37 @@ static int __init parse_trust_bootloader(char *arg)
 early_param("random.trust_cpu", parse_trust_cpu);
 early_param("random.trust_bootloader", parse_trust_bootloader);
 
+static int random_pm_notification(struct notifier_block *nb, unsigned long action, void *data)
+{
+	unsigned long flags, entropy = random_get_entropy();
+
+	/*
+	 * Encode a representation of how long the system has been suspended,
+	 * in a way that is distinct from prior system suspends.
+	 */
+	ktime_t stamps[] = {
+		ktime_get(),
+		ktime_get_boottime(),
+		ktime_get_real()
+	};
+
+	spin_lock_irqsave(&input_pool.lock, flags);
+	_mix_pool_bytes(&action, sizeof(action));
+	_mix_pool_bytes(stamps, sizeof(stamps));
+	_mix_pool_bytes(&entropy, sizeof(entropy));
+	spin_unlock_irqrestore(&input_pool.lock, flags);
+
+	if (action == PM_RESTORE_PREPARE ||
+	    (action == PM_POST_SUSPEND &&
+	     !IS_ENABLED(CONFIG_PM_AUTOSLEEP) && !IS_ENABLED(CONFIG_ANDROID))) {
+		crng_reseed(true);
+		pr_notice("crng reseeded on system resumption\n");
+	}
+	return 0;
+}
+
+static struct notifier_block pm_notifier = { .notifier_call = random_pm_notification };
+
 /*
  * The first collection of entropy occurs at system boot while interrupts
  * are still turned off. Here we push in RDSEED, a timestamp, and utsname().
@@ -1009,6 +1041,8 @@ int __init rand_initialize(void)
 		unseeded_warning.interval = 0;
 	}
 
+	WARN_ON(register_pm_notifier(&pm_notifier));
+
 	WARN(!random_get_entropy(), "Missing cycle counter and fallback timer; RNG "
 				    "entropy collection will consequently suffer.");
 	return 0;
-- 
2.35.1

