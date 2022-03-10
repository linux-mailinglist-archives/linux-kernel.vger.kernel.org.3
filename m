Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4B4D5379
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbiCJVMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiCJVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:12:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87497154734;
        Thu, 10 Mar 2022 13:11:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 100DFB82705;
        Thu, 10 Mar 2022 21:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30FCC340E8;
        Thu, 10 Mar 2022 21:11:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cLcImcim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646946660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiQsDf0ZHU9pJCBzw/+6bKMG6fcODAXJyij3QbvbGO4=;
        b=cLcImcimORLroi9kYWw15iDOMiENCkfrY1a1FmJ3ORz8ugnmdZsguAK+xPbbiQjDfcjicU
        9dePDSgAu7bnAZJ24hL+8jVtMB6AKDpGa0e1MH4K3I9D2runiuruqz/OKg0J9BFmpDjn0m
        u+/F4qCg/E43FLvocRs+ThMp1qayHHY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2bffdb85 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Mar 2022 21:10:59 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v2] random: reseed more often immediately after booting
Date:   Thu, 10 Mar 2022 14:10:50 -0700
Message-Id: <20220310211050.135078-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9ohyKKX4Qg_dyGq36MxFkhBoVQYYgs8uUoCfBkJNqfX7Q@mail.gmail.com>
References: <CAHmME9ohyKKX4Qg_dyGq36MxFkhBoVQYYgs8uUoCfBkJNqfX7Q@mail.gmail.com>
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
existing entropy accounting with more frequent reseedings at boot.

The idea is that at boot, we're getting entropy from various places, and
we're not very sure which of early boot entropy is good and which isn't.
Even when we're crediting the entropy, we're still not totally certain
that it's any good. Since boot is the one time (aside from a compromise)
that we have zero entropy, it's important that we shephard entropy into
the crng fairly often.

At the same time, we don't want a "premature next" problem, whereby an
attacker can brute force individual bits of added entropy. In lieu of
going full-on Fortuna (for now), we can pick a simpler strategy of just
reseeding more often during the first 5 minutes after boot. This is
still bounded by the 256-bit entropy credit requirement, so we'll skip a
reseeding if we haven't reached that, but in case entropy /is/ coming
in, this ensures that it makes its way into the crng rather rapidly
during these early stages.

For this we start at 5 seconds after boot, and double that interval
until it's more than 5 minutes. After that, we then move to our normal
schedule of reseeding not more than once per 5 minutes.

One interesting caveat is that reseeding is presently on-demand, so
we're not reseeding at precisely the 5, 10, 20, 40, 80, 160 marks, but
rather whenever the crng is actually used and we've matched or exceeded
one of those marks. This means that we might wind up trying to reseed at
both second 79 and second 80, or at second 41 and second 80, or anywhere
in between. In that sense, this isn't quite imposing a minimum frequency
on reseeds during early boot, but simply bounding a maximum frequency.
Since we're still requiring 256 bits of entropy credits, this shouldn't
be a super large issue in terms of "premature next", and in the event
that we reseed a bit late and then miss the next reseeding due to not
enough entropy credits, we still have acquired more entropy by virtue of
having reseeded later.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Note "on-demand" funkiness in commit message.
- Always use READ_ONCE() with next_init_secs.

 drivers/char/random.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d94d5ba414ee..27d91cfc3cd9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -333,6 +333,28 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
 	memzero_explicit(first_block, sizeof(first_block));
 }
 
+/*
+ * Return whether the crng seed is considered to be sufficiently
+ * old that a reseeding might be attempted. This is the case 5,
+ * 10, 20, 40, 80, and 160 seconds after boot, and after if the
+ * last reseeding was CRNG_RESEED_INTERVAL ago.
+ */
+static bool crng_has_old_seed(void)
+{
+	static unsigned int next_init_secs = 5;
+	unsigned int this_init_secs = READ_ONCE(next_init_secs);
+
+	if (unlikely(this_init_secs < CRNG_RESEED_INTERVAL / HZ)) {
+		unsigned int uptime = min_t(u64, INT_MAX, ktime_get_seconds());
+		if (uptime >= this_init_secs) {
+			WRITE_ONCE(next_init_secs, 5U << fls(uptime / 5));
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
@@ -366,10 +388,10 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
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

