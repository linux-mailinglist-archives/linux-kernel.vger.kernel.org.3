Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665084D31BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiCIP2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiCIP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:28:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4EEA0BD6;
        Wed,  9 Mar 2022 07:27:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47747B82206;
        Wed,  9 Mar 2022 15:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3922EC340EF;
        Wed,  9 Mar 2022 15:27:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="au+XfYnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646839631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fz2+KeSp+jvLPB+YA1juwcXf9iyTbUDMiVw8jPLgQt8=;
        b=au+XfYnxZxOpYG3IwW0bLGPHQQQ7EJIZTa7sVGbagQZmfbUgdJrgNOj1khJzvS18zvGAgI
        TNfOpnCGJccxRWdVZfZRrjWdvensJy5lh+v4/l40oKlXFcmGzM9hmUkspx8ZyCssYPWQ9G
        QtEXUwSJ1kUn+yjuXaZ01fZBJk+zfuM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d6e72e32 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 9 Mar 2022 15:27:11 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: reseed more often immediately after booting
Date:   Wed,  9 Mar 2022 08:26:53 -0700
Message-Id: <20220309152653.1244096-1-Jason@zx2c4.com>
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

In order to chip away at the "premature first" problem, we augment our
existing entropy accounting with increased reseedings at boot. The idea
is that at boot, we're getting entropy from various places, and we're
not very sure which of early boot entropy is good and which isn't. Even
when we're crediting the entropy, we're still not totally certain that
it's any good. Since boot is the one time (aside from a compromise) that
we have zero entropy, it's important that we shephard entropy into the
crng fairly often. At the same time, we don't want a "premature next"
problem, whereby an attacker can brute force individual bits of added
entropy. In lieu of going full-on Fortuna (for now), we can pick a
simpler strategy of just reseeding more often during the first 5 minutes
after boot. This is still bounded by the 256-bit entropy credit
requirement, so we'll skip a reseeding if we haven't reached that, but
in case entropy /is/ coming in, this ensures that it makes its way into
the crng rather rapidly during these early stages. For this we start at
5 seconds after boot, and double that interval until it's more than 5
minutes. After that, we then move to our normal schedule of reseeding
not more than once per 5 minutes.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0ceda9a12bfe..e86e093e1d67 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -333,6 +333,27 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 	memzero_explicit(first_block, sizeof(first_block));
 }
 
+/*
+ * Return whether the crng seed is considered to be sufficiently
+ * old that a reseeding might be attempted. This is the case 5,
+ * 10, 20, 40, 80, and 160 seconds after boot, and after if the
+ * last reseeding was CRNG_RESEED_INTERVAL minutes ago.
+ */
+static bool crng_has_old_seed(void)
+{
+	static unsigned int next_init_secs = 5;
+
+	if (unlikely(next_init_secs < CRNG_RESEED_INTERVAL / HZ)) {
+		ktime_t uptime = ktime_get_seconds();
+		if (uptime >= READ_ONCE(next_init_secs)) {
+			WRITE_ONCE(next_init_secs, (1U << fls(uptime / 5)) * 5);
+			return true;
+		}
+		return false;
+	}
+	return time_after(jiffies, READ_ONCE(base_crng.birth) + CRNG_RESEED_INTERVAL);
+}
+
 /*
  * This function returns a ChaCha state that you may use for generating
  * random data. It also returns up to 32 bytes on its own of random data
@@ -366,10 +387,10 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
 	}
 
 	/*
-	 * If the base_crng is more than 5 minutes old, we reseed, which
-	 * in turn bumps the generation counter that we check below.
+	 * If the base_crng is old enough, we try to reseed, which in turn
+	 * bumps the generation counter that we check below.
 	 */
-	if (unlikely(time_after(jiffies, READ_ONCE(base_crng.birth) + CRNG_RESEED_INTERVAL)))
+	if (unlikely(crng_has_old_seed()))
 		crng_reseed(false);
 
 	local_lock_irqsave(&crngs.lock, flags);
-- 
2.35.1

