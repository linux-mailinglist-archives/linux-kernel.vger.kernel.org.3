Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E8B4AE687
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiBICjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242728AbiBIBUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:20:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52844C06157B;
        Tue,  8 Feb 2022 17:20:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14FF9B81E2E;
        Wed,  9 Feb 2022 01:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38821C004E1;
        Wed,  9 Feb 2022 01:20:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TjGdN/d1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644369612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+BvSffpxoiCV4pJMnMVT9UMKRkfrW0iMmasZO/6IK4=;
        b=TjGdN/d1NrTmRtPAHIDSrh2UIFpYoDBE9olAx1F4ZdPPbnEx6XIzMNCH5/ezgvl+mdSwbl
        WtQodnFebLyBO7+we1KpoH44j3zeI/fdjVuG2D0oLMrDaJQaN7Vo8PX4WnJiKh5Rs/gt6K
        7s6Q7Z1fjMiCmNWmQ1NUiif6B3iQqxo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d63d5d5a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Feb 2022 01:20:12 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, linux@dominikbrodowski.net, ebiggers@kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 8/9] random: use hash function for crng_slow_load()
Date:   Wed,  9 Feb 2022 02:19:18 +0100
Message-Id: <20220209011919.493762-9-Jason@zx2c4.com>
In-Reply-To: <20220209011919.493762-1-Jason@zx2c4.com>
References: <20220209011919.493762-1-Jason@zx2c4.com>
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

Since we have a hash function that's really fast, and the goal of
crng_slow_load() is reportedly to "touch all of the crng's state", we
can just hash the old state together with the new state and call it a
day. This way we dont need to reason about another LFSR or worry about
various attacks there. This code is only ever used at early boot and
then never again.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 359fd2501c45..f7f9cbfe13f7 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -470,42 +470,30 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
  * all), and (2) it doesn't have the performance constraints of
  * crng_fast_load().
  *
- * So we do something more comprehensive which is guaranteed to touch
- * all of the primary_crng's state, and which uses a LFSR with a
- * period of 255 as part of the mixing algorithm.  Finally, we do
- * *not* advance crng_init_cnt since buffer we may get may be something
- * like a fixed DMI table (for example), which might very well be
- * unique to the machine, but is otherwise unvarying.
+ * So, we simply hash the contents in with the current key. Finally,
+ * we do *not* advance crng_init_cnt since buffer we may get may be
+ * something like a fixed DMI table (for example), which might very
+ * well be unique to the machine, but is otherwise unvarying.
  */
-static int crng_slow_load(const u8 *cp, size_t len)
+static void crng_slow_load(const u8 *cp, size_t len)
 {
 	unsigned long flags;
-	static u8 lfsr = 1;
-	u8 tmp;
-	unsigned int i, max = sizeof(base_crng.key);
-	const u8 *src_buf = cp;
-	u8 *dest_buf = base_crng.key;
+	struct blake2s_state hash;
+
+	blake2s_init(&hash, sizeof(base_crng.key));
 
 	if (!spin_trylock_irqsave(&base_crng.lock, flags))
-		return 0;
+		return;
 	if (crng_init != 0) {
 		spin_unlock_irqrestore(&base_crng.lock, flags);
-		return 0;
-	}
-	if (len > max)
-		max = len;
-
-	for (i = 0; i < max; i++) {
-		tmp = lfsr;
-		lfsr >>= 1;
-		if (tmp & 1)
-			lfsr ^= 0xE1;
-		tmp = dest_buf[i % sizeof(base_crng.key)];
-		dest_buf[i % sizeof(base_crng.key)] ^= src_buf[i % len] ^ lfsr;
-		lfsr += (tmp << 3) | (tmp >> 5);
+		return;
 	}
+
+	blake2s_update(&hash, base_crng.key, sizeof(base_crng.key));
+	blake2s_update(&hash, cp, len);
+	blake2s_final(&hash, base_crng.key);
+
 	spin_unlock_irqrestore(&base_crng.lock, flags);
-	return 1;
 }
 
 static void crng_reseed(void)
-- 
2.35.0

