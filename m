Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104954B1B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346718AbiBKBPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:15:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbiBKBPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:15:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEAA10DF;
        Thu, 10 Feb 2022 17:15:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35AFCB826B6;
        Fri, 11 Feb 2022 01:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C2DC340EE;
        Fri, 11 Feb 2022 01:14:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gvvb3nOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644542096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qicFl/mTm3mu5RuRZnuUB+C11zbXBShykKe2Sy/yMQU=;
        b=Gvvb3nOQTcea8dXzeJbq+9ccPoaL/iJIqhr+ARirYI5c0QnZzX6whxdgTh0CRAcTPfBMdK
        v6LIx0Mev7xGbTpZmqeaw4tT0hETLk3V1J19DiE07nPcix1mJXwA3W/J5/EfrSR51XgLBF
        0y6cmd4KNnwBhD4HMcFsmCLWo8wA3iQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d8deccdf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 01:14:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH] random: ensure mix_interrupt_randomness() is consistent
Date:   Fri, 11 Feb 2022 02:14:46 +0100
Message-Id: <20220211011446.392673-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
References: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
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

This addresses two issues alluded to in an earlier commit.

The first issue is that mix_interrupt_randomness() might be migrated to
another CPU during CPU hotplug. This issue is rectified by checking that
it hasn't been migrated (after disabling migration). If it has been
migrated, then we set the count to zero, so that when the CPU comes
online again, it can requeue the work. As part of this, we switch to
using an atomic_t, so that the increment in the irq handler doesn't wipe
out the zeroing if the CPU comes back online while this worker is
running.

The second issue is that, though relatively minor in effect, we probably
do after all want to make sure we get a consistent view of the pool onto
the stack, in case it's interrupted by an irq while reading. To do this,
we simply read count before and after the memcpy and make sure they're
the same. If they're not, we try again. The likelihood of actually
hitting this is very low, as we're talking about a 2 or 4 word mov, and
we're executing on the same CPU as the potential interruption.
Nonetheless, it's easy enough to fix, so we do here.

If we only were concerned with the first issue rather than the second,
we could fix this entirely with just using an atomic_t. But in order to
fix them both, it requires a bit of coordination, which this patch
tackles.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9c779f1bda34..caaf3c33bb38 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1152,10 +1152,11 @@ struct fast_pool {
 	union {
 		u64 pool64[2];
 		u32 pool32[4];
+		unsigned long pool_long[16 / sizeof(long)];
 	};
 	struct work_struct mix;
 	unsigned long last;
-	unsigned int count;
+	atomic_t count;
 	u16 reg_idx;
 };
 #define FAST_POOL_MIX_INFLIGHT (1U << 31)
@@ -1210,14 +1211,39 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 static void mix_interrupt_randomness(struct work_struct *work)
 {
 	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
-	u32 pool[ARRAY_SIZE(fast_pool->pool32)];
+	unsigned long pool[ARRAY_SIZE(fast_pool->pool_long)];
+	unsigned int count_snapshot;
+	size_t i;
 
-	/* Copy the pool to the stack so that the mixer always has a consistent view. */
-	memcpy(pool, fast_pool->pool32, sizeof(pool));
+	/* Check to see if we're running on the wrong CPU due to hotplug. */
+	migrate_disable();
+	if (fast_pool != this_cpu_ptr(&irq_randomness)) {
+		migrate_enable();
+		/*
+		 * If we are unlucky enough to have been moved to another CPU,
+		 * then we set our count to zero atomically so that when the
+		 * CPU comes back online, it can enqueue work again.
+		 */
+		atomic_set_release(&fast_pool->count, 0);
+		return;
+	}
+
+	/*
+	 * Copy the pool to the stack so that the mixer always has a
+	 * consistent view. It's extremely unlikely but possible that
+	 * this 2 or 4 word read is interrupted by an irq, but in case
+	 * it is, we double check that count stays the same.
+	 */
+	do {
+		count_snapshot = (unsigned int)atomic_read(&fast_pool->count);
+		for (i = 0; i < ARRAY_SIZE(pool); ++i)
+			pool[i] = READ_ONCE(fast_pool->pool_long[i]);
+	} while (count_snapshot != (unsigned int)atomic_read(&fast_pool->count));
 
 	/* We take care to zero out the count only after we're done reading the pool. */
-	WRITE_ONCE(fast_pool->count, 0);
+	atomic_set(&fast_pool->count, 0);
 	fast_pool->last = jiffies;
+	migrate_enable();
 
 	mix_pool_bytes(pool, sizeof(pool));
 	credit_entropy_bits(1);
@@ -1246,12 +1272,12 @@ void add_interrupt_randomness(int irq)
 	}
 
 	fast_mix(fast_pool->pool32);
-	new_count = ++fast_pool->count;
+	new_count = (unsigned int)atomic_inc_return_acquire(&fast_pool->count);
 
 	if (unlikely(crng_init == 0)) {
 		if (new_count >= 64 &&
 		    crng_fast_load(fast_pool->pool32, sizeof(fast_pool->pool32)) > 0) {
-			fast_pool->count = 0;
+			atomic_set(&fast_pool->count, 0);
 			fast_pool->last = now;
 
 			/*
@@ -1273,7 +1299,7 @@ void add_interrupt_randomness(int irq)
 
 	if (unlikely(!fast_pool->mix.func))
 		INIT_WORK(&fast_pool->mix, mix_interrupt_randomness);
-	fast_pool->count |= FAST_POOL_MIX_INFLIGHT;
+	atomic_or(FAST_POOL_MIX_INFLIGHT, &fast_pool->count);
 	queue_work_on(raw_smp_processor_id(), system_highpri_wq, &fast_pool->mix);
 }
 EXPORT_SYMBOL_GPL(add_interrupt_randomness);
-- 
2.35.0

