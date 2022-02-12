Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22F64B34E7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiBLMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:23:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBLMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:23:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5387A24BE5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:23:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F010BB80691
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F84FC340E7;
        Sat, 12 Feb 2022 12:23:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ODF4alSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644668607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWzS0mxyHFBKh8dXUL5dPMBahNNosCP3EmVR3IgONbg=;
        b=ODF4alSnFZv0Vo4Y4ftU0BsLfvKnCmUXAh/Npp+RBclNrjOVgiFcdmKEdF5xfO/oLXF0Or
        zagaFN0cmyyCYV9qKnCgY/c8xV4lrB1UILRDAXHQ7lyqe6CySrY5dllGfTt7aYBri7YqyC
        9xeZDxs0PXmCtuZQK1JjN61X5GFNyiw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5cdef4b8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 12:23:27 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 01/10] random: introduce drain_entropy() helper to declutter crng_reseed()
Date:   Sat, 12 Feb 2022 13:23:09 +0100
Message-Id: <20220212122318.623435-2-Jason@zx2c4.com>
In-Reply-To: <20220212122318.623435-1-Jason@zx2c4.com>
References: <20220212122318.623435-1-Jason@zx2c4.com>
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

In preparation for separating responsibilities, break out the entropy
count management part of crng_reseed() into its own function.

No functional changes.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 44a20a1a1b3a..436b146b33be 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -260,6 +260,7 @@ static struct {
 };
 
 static void extract_entropy(void *buf, size_t nbytes);
+static bool drain_entropy(void *buf, size_t nbytes);
 
 static void crng_reseed(void);
 
@@ -453,22 +454,13 @@ static void crng_slow_load(const void *cp, size_t len)
 static void crng_reseed(void)
 {
 	unsigned long flags;
-	int entropy_count;
 	unsigned long next_gen;
 	u8 key[CHACHA_KEY_SIZE];
 	bool finalize_init = false;
 
-	/* First we make sure we have POOL_MIN_BITS of entropy in the pool,
-	 * and then we drain all of it. Only then can we extract a new key.
-	 */
-	do {
-		entropy_count = READ_ONCE(input_pool.entropy_count);
-		if (entropy_count < POOL_MIN_BITS)
-			return;
-	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
-	extract_entropy(key, sizeof(key));
-	wake_up_interruptible(&random_write_wait);
-	kill_fasync(&fasync, SIGIO, POLL_OUT);
+	/* Only reseed if we can, to prevent brute forcing a small amount of new bits. */
+	if (!drain_entropy(key, sizeof(key)))
+		return;
 
 	/* We copy the new key into the base_crng, overwriting the old one,
 	 * and update the generation counter. We avoid hitting ULONG_MAX,
@@ -893,6 +885,25 @@ static void extract_entropy(void *buf, size_t nbytes)
 	memzero_explicit(&block, sizeof(block));
 }
 
+/*
+ * First we make sure we have POOL_MIN_BITS of entropy in the pool,
+ * and then we drain all of it. Only then can we extract a new key
+ * with extract_entropy().
+ */
+static bool drain_entropy(void *buf, size_t nbytes)
+{
+	unsigned int entropy_count;
+	do {
+		entropy_count = READ_ONCE(input_pool.entropy_count);
+		if (entropy_count < POOL_MIN_BITS)
+			return false;
+	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
+	extract_entropy(buf, nbytes);
+	wake_up_interruptible(&random_write_wait);
+	kill_fasync(&fasync, SIGIO, POLL_OUT);
+	return true;
+}
+
 #define warn_unseeded_randomness(previous) \
 	_warn_unseeded_randomness(__func__, (void *)_RET_IP_, (previous))
 
-- 
2.35.0

