Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599884B3C03
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 16:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiBMPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 10:25:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiBMPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 10:25:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15285C84F;
        Sun, 13 Feb 2022 07:25:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6282461198;
        Sun, 13 Feb 2022 15:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA38C004E1;
        Sun, 13 Feb 2022 15:25:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aoG+cYJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644765938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qu7F7nASzCXbLX8xn2An7b4T3SKVpy9K/XBe+vap7ts=;
        b=aoG+cYJvhTPi8I2pwTIp4uBzpNLLo/te0WVV/MLLQBqF9jOgP6XnjmrH3ehVV2wnlECGnA
        0Kx5A0KXsxyKTde2iwRr77HhdY6/qS1s5gOALUDQVzjTPrScI47ftSoY/n/cWyGYxV7mHu
        S0miTlypBntjD+/faY5VRwn7kiZr1wg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 20bd1738 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 13 Feb 2022 15:25:37 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matt Mackall <mpm@selenic.com>, Kalle Valo <kvalo@kernel.org>,
        ath9k-devel@qca.qualcomm.com, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: pull add_hwgenerator_randomness() declaration into random.h
Date:   Sun, 13 Feb 2022 16:25:22 +0100
Message-Id: <20220213152522.816777-1-Jason@zx2c4.com>
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

add_hwgenerator_randomness() is a function implemented and documented
inside of random.c. It is the way that hardware RNGs push data into it.
Therefore, it should be declared in random.h. Otherwise sparse complains
with:

random.c:1137:6: warning: symbol 'add_hwgenerator_randomness' was not declared. Should it be static?

The alternative would be to include hw_random.h into random.c, but that
wouldn't really be good for anything except slowing down compile time.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>
Cc: ath9k-devel@qca.qualcomm.com
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/hw_random/core.c        | 1 +
 drivers/net/wireless/ath/ath9k/rng.c | 1 +
 include/linux/hw_random.h            | 2 --
 include/linux/random.h               | 2 ++
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index a3db27916256..cfb085de876b 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/hw_random.h>
+#include <linux/random.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/sched/signal.h>
diff --git a/drivers/net/wireless/ath/ath9k/rng.c b/drivers/net/wireless/ath/ath9k/rng.c
index f9d3d6eedd3c..aae2bd3cac69 100644
--- a/drivers/net/wireless/ath/ath9k/rng.c
+++ b/drivers/net/wireless/ath/ath9k/rng.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/hw_random.h>
+#include <linux/random.h>
 #include <linux/kthread.h>
 
 #include "ath9k.h"
diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
index 1a9fc38f8938..aa1d4da03538 100644
--- a/include/linux/hw_random.h
+++ b/include/linux/hw_random.h
@@ -60,7 +60,5 @@ extern int devm_hwrng_register(struct device *dev, struct hwrng *rng);
 /** Unregister a Hardware Random Number Generator driver. */
 extern void hwrng_unregister(struct hwrng *rng);
 extern void devm_hwrng_unregister(struct device *dve, struct hwrng *rng);
-/** Feed random bits into the pool. */
-extern void add_hwgenerator_randomness(const void *buffer, size_t count, size_t entropy);
 
 #endif /* LINUX_HWRANDOM_H_ */
diff --git a/include/linux/random.h b/include/linux/random.h
index 37e1e8c43d7e..d7354de9351e 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -32,6 +32,8 @@ static inline void add_latent_entropy(void) {}
 extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value) __latent_entropy;
 extern void add_interrupt_randomness(int irq) __latent_entropy;
+extern void add_hwgenerator_randomness(const void *buffer, size_t count,
+				       size_t entropy);
 
 extern void get_random_bytes(void *buf, size_t nbytes);
 extern int wait_for_random_bytes(void);

base-commit: 1b057ea07bdc88c5ab77cb9a9bc46f8690492c81
prerequisite-patch-id: 722401baa02ea28022621588a48b701d116c0ad5
prerequisite-patch-id: 8da951eeda7c2b69ccf9de465f6e33b6a32d1b8a
prerequisite-patch-id: b252828d4fa0211224b7cac57b7a40a26847caf3
prerequisite-patch-id: ac9dc6b642ecfd8d42394b06d7757e4076da3a35
prerequisite-patch-id: aecaed912a18486ea6743ef94d86683d6ce35320
prerequisite-patch-id: 74e4aea70835f508339e5223f1b01266698f1173
prerequisite-patch-id: c315d7e54165666dae309e3ac6d5e666c6c97a33
prerequisite-patch-id: 9b8f505cf7f6b605ba5143c801e3487149481cde
prerequisite-patch-id: 7e48a52a3947c9d0d73a9867a7a3fb403e0e18ff
prerequisite-patch-id: 6c5c60bf502f7691087241c32c3a898135783ea0
prerequisite-patch-id: 80b04855c1ec5315d175cda682f528dab5db13ca
prerequisite-patch-id: 00ec3b71c3fe248d55b00f1b210f029a221f295a
prerequisite-patch-id: bac900c80e57d5fd5234b81a51359a76b378a9e9
prerequisite-patch-id: d2c04ce2d5667557c6d863fb26ad046a16b86f7b
prerequisite-patch-id: 4d98a7945c6dce30c3630f4668aa4b32ca53c971
prerequisite-patch-id: bd93293024b6ad54ffaf1ae5bee3d805961e310d
prerequisite-patch-id: e17118e66c1761f954fac49822231986f429e996
prerequisite-patch-id: dca680875ff2a505bc35d8999fa18832d6cc378e
prerequisite-patch-id: 798e5c78bbc4c0e1748a64496e4b139b6d5c85bf
prerequisite-patch-id: d41dada11f57459add7e28d4a8714929b9ed07f8
prerequisite-patch-id: a3159bc3b25f67ab0fb409dfc86373e3b6c3bc5e
prerequisite-patch-id: 6d069efe964e32e90ac052183360f3b8e78fd6bd
prerequisite-patch-id: 56253c1e4f608de542e26e5201f476a6e33c0166
prerequisite-patch-id: 4cdc3b96e517592d6fdf493baaa49e032f0788c9
prerequisite-patch-id: 4a7abc91a7dc1f6fdfb6a1bf310e0aeffee284ec
-- 
2.35.0

