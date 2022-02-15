Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881F4B79D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbiBOVOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:14:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiBOVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:14:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C306371C97;
        Tue, 15 Feb 2022 13:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FEC8618FA;
        Tue, 15 Feb 2022 21:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E1EC340EB;
        Tue, 15 Feb 2022 21:13:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IgL/2/E1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644959627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kp7eWj533NNXB9m2ob0Q6FbMxEEdkB1SZsAocpyT3WI=;
        b=IgL/2/E1e1E7zCYvhET5dX678TGPh3WQ9Dx3D2r2DuwZb/dXyQfElTGoySAuZbdUNtyQi9
        bmDP8eQZVd38ZBtYLXDl6Z6QU56IDPwKCtEKUnRiVNeiDrsqXpP21hwil5o8HswG7jWDHc
        ml+m0C7a8CwyxK/wT/cqDQaDnY9zGyU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6df90ad4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 15 Feb 2022 21:13:47 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH v3] random: absorb fast pool into input pool after fast load
Date:   Tue, 15 Feb 2022 22:13:33 +0100
Message-Id: <20220215211333.244383-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9qMRO0YFwQRUZfuUjTy2=C0QYkNLZSK5YgVD0xpcP2qbQ@mail.gmail.com>
References: <CAHmME9qMRO0YFwQRUZfuUjTy2=C0QYkNLZSK5YgVD0xpcP2qbQ@mail.gmail.com>
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

During crng_init == 0, we never credit entropy in add_interrupt_
randomness(), but instead dump it directly into the primary_crng. That's
fine, except for the fact that we then wind up throwing away that
entropy later when we switch to extracting from the input pool and
overwriting the primary_crng key. The two other early init sites --
add_hwgenerator_randomness()'s use crng_fast_load() and add_device_
randomness()'s use of crng_slow_load() -- always additionally give their
inputs to the input pool. But not add_interrupt_randomness().

This commit fixes that shortcoming by calling mix_pool_bytes() after
crng_fast_load() in add_interrupt_randomness(). That's partially
verboten on PREEMPT_RT, where it implies taking spinlock_t from an IRQ
handler. But this also only happens during early boot and then never
again after that. Plus it's a trylock so it has the same considerations
as calling crng_fast_load(), which we're already using.

Cc: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Suggested-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
v3 uses a trylock instead of a spinlock, just like all the other locks
taken in hard irq. (Incidentally, we're now talking about moving this
into the deferred stage, so that at can be a spinlock, but at least with
what we have here, this really must be a trylock.)

 drivers/char/random.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d31b0b3afe2e..f3179c67010b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -850,6 +850,10 @@ void add_interrupt_randomness(int irq)
 		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
 			fast_pool->count = 0;
 			fast_pool->last = now;
+			if (spin_trylock(&input_pool.lock)) {
+				_mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
+				spin_unlock(&input_pool.lock);
+			}
 		}
 		return;
 	}
-- 
2.35.0

