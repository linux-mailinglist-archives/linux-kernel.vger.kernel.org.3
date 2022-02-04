Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481274AA300
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348566AbiBDWSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:18:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59640 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348258AbiBDWSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:18:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D388B83705;
        Fri,  4 Feb 2022 22:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE392C004E1;
        Fri,  4 Feb 2022 22:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644013089;
        bh=MyTsb1RD4SOHRX3mB93R3YhXVlw0eJEKURFgtMAHxVo=;
        h=From:To:Cc:Subject:Date:From;
        b=rO7m7wkQgkdIBQRhKwH0on1lfveX3TJg953izhyqmswOQWQrhI8gfS5qhnO28s0ot
         YBCPbF4beqTdO9rrYdh+QomyZVR39A/O/9RH7UQsiMnovO2sSCkVgkxGlU4Psph+fO
         x05cs3LJPl3rbfAGDizjxzDBDP5mfaCDURwO4XBtCyEeuqnnxCT9DaZpeYOjJI2tqK
         GhJj1LmxU0aclKNczIUI11f03VHMwD6UT8S10CQIY2nuXTGTJkl2esJvdU2Zce+mxP
         onIzRRBLKbuDQfmoprmP6zhIkpSMFEy9KRJwxrIp7k1IQbhd+uoHXeCNiDhwtlqL/x
         eHPV1qS5n0nDQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A . Donenfeld " <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] random: remove use_input_pool parameter from crng_reseed()
Date:   Fri,  4 Feb 2022 14:17:33 -0800
Message-Id: <20220204221733.39411-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The primary_crng is always reseeded from the input_pool, while the NUMA
crngs are always reseeded from the primary_crng.  Remove the redundant
'use_input_pool' parameter from crng_reseed() and just directly check
whether the crng is the primary_crng.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/char/random.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e16cf254db15..964bce981235 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -371,7 +371,7 @@ static struct {
 
 static void extract_entropy(void *buf, size_t nbytes);
 
-static void crng_reseed(struct crng_state *crng, bool use_input_pool);
+static void crng_reseed(struct crng_state *crng);
 
 /*
  * This function adds bytes into the entropy "pool".  It does not
@@ -470,7 +470,7 @@ static void credit_entropy_bits(int nbits)
 	trace_credit_entropy_bits(nbits, entropy_count, _RET_IP_);
 
 	if (crng_init < 2 && entropy_count >= POOL_MIN_BITS)
-		crng_reseed(&primary_crng, true);
+		crng_reseed(&primary_crng);
 }
 
 /*********************************************************************
@@ -707,7 +707,7 @@ static int crng_slow_load(const u8 *cp, size_t len)
 	return 1;
 }
 
-static void crng_reseed(struct crng_state *crng, bool use_input_pool)
+static void crng_reseed(struct crng_state *crng)
 {
 	unsigned long flags;
 	int i;
@@ -716,7 +716,7 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 		u32 key[8];
 	} buf;
 
-	if (use_input_pool) {
+	if (crng == &primary_crng) {
 		int entropy_count;
 		do {
 			entropy_count = READ_ONCE(input_pool.entropy_count);
@@ -756,7 +756,7 @@ static void _extract_crng(struct crng_state *crng, u8 out[CHACHA_BLOCK_SIZE])
 		init_time = READ_ONCE(crng->init_time);
 		if (time_after(READ_ONCE(crng_global_init_time), init_time) ||
 		    time_after(jiffies, init_time + CRNG_RESEED_INTERVAL))
-			crng_reseed(crng, crng == &primary_crng);
+			crng_reseed(crng);
 	}
 	spin_lock_irqsave(&crng->lock, flags);
 	chacha20_block(&crng->state[0], out);
@@ -1555,7 +1555,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return -EPERM;
 		if (crng_init < 2)
 			return -ENODATA;
-		crng_reseed(&primary_crng, true);
+		crng_reseed(&primary_crng);
 		WRITE_ONCE(crng_global_init_time, jiffies - 1);
 		return 0;
 	default:

base-commit: 4bccade22d405309cbc588094f956f4d310e4677
-- 
2.35.1

