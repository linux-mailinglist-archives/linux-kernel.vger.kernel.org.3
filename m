Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD974544C23
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245453AbiFIMdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbiFIMdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D6B192AB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A192619BF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 12:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D437CC34114;
        Thu,  9 Jun 2022 12:33:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mPLOVvmm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654778011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSYQGAKV0NAoJGNwfFuUVE9nqijGNSU8b+ZISJRatmU=;
        b=mPLOVvmmWmr9mOmfK6h7V5tZ1lsne9dp4NUex/mzsDduozgpZSMlnQYBhbRuhsT2QLWGGw
        GnQ87sI3p0ZbD51tjavn4ciJ4ixeyRjYfNQKN+0rrwruYe86mAXBmu39Rq1ckTdX3Ewz60
        uX7Y0TMcy75pHMIr2+Ur+kdU9S1eQds=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b86d10e9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 9 Jun 2022 12:33:30 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        John Ogness <john.ogness@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] mm/kfence: select random number before taking raw lock
Date:   Thu,  9 Jun 2022 14:33:19 +0200
Message-Id: <20220609123319.17576-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9rkQDnsTu-8whevtBa_J6aOKT=gQO7kBAxwWrBgKgcyUQ@mail.gmail.com>
References: <CAHmME9rkQDnsTu-8whevtBa_J6aOKT=gQO7kBAxwWrBgKgcyUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RNG uses vanilla spinlocks, not raw spinlocks, so kfence should pick
its random numbers before taking its raw spinlocks. This also has the
nice effect of doing less work inside the lock. It should fix a splat
that Geert saw with CONFIG_PROVE_RAW_LOCK_NESTING:

     dump_backtrace.part.0+0x98/0xc0
     show_stack+0x14/0x28
     dump_stack_lvl+0xac/0xec
     dump_stack+0x14/0x2c
     __lock_acquire+0x388/0x10a0
     lock_acquire+0x190/0x2c0
     _raw_spin_lock_irqsave+0x6c/0x94
     crng_make_state+0x148/0x1e4
     _get_random_bytes.part.0+0x4c/0xe8
     get_random_u32+0x4c/0x140
     __kfence_alloc+0x460/0x5c4
     kmem_cache_alloc_trace+0x194/0x1dc
     __kthread_create_on_node+0x5c/0x1a8
     kthread_create_on_node+0x58/0x7c
     printk_start_kthread.part.0+0x34/0xa8
     printk_activate_kthreads+0x4c/0x54
     do_one_initcall+0xec/0x278
     kernel_init_freeable+0x11c/0x214
     kernel_init+0x24/0x124
     ret_from_fork+0x10/0x20

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v1->v2:
- Make the bools const to help compiler elide branch when possible,
  suggested by Marco.

 mm/kfence/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 4e7cd4c8e687..4b5e5a3d3a63 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -360,6 +360,9 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	unsigned long flags;
 	struct slab *slab;
 	void *addr;
+	const bool random_right_allocate = prandom_u32_max(2);
+	const bool random_fault = CONFIG_KFENCE_STRESS_TEST_FAULTS &&
+				  !prandom_u32_max(CONFIG_KFENCE_STRESS_TEST_FAULTS);
 
 	/* Try to obtain a free object. */
 	raw_spin_lock_irqsave(&kfence_freelist_lock, flags);
@@ -404,7 +407,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	 * is that the out-of-bounds accesses detected are deterministic for
 	 * such allocations.
 	 */
-	if (prandom_u32_max(2)) {
+	if (random_right_allocate) {
 		/* Allocate on the "right" side, re-calculate address. */
 		meta->addr += PAGE_SIZE - size;
 		meta->addr = ALIGN_DOWN(meta->addr, cache->align);
@@ -444,7 +447,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
 	if (cache->ctor)
 		cache->ctor(addr);
 
-	if (CONFIG_KFENCE_STRESS_TEST_FAULTS && !prandom_u32_max(CONFIG_KFENCE_STRESS_TEST_FAULTS))
+	if (random_fault)
 		kfence_protect(meta->addr); /* Random "faults" by protecting the object. */
 
 	atomic_long_inc(&counters[KFENCE_COUNTER_ALLOCATED]);
-- 
2.35.1

