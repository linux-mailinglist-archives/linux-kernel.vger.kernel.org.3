Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69721586BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiHAN3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiHAN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95863C179;
        Mon,  1 Aug 2022 06:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E6C612C6;
        Mon,  1 Aug 2022 13:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3959C433D6;
        Mon,  1 Aug 2022 13:29:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S+kpgMnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659360556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKJOoamZnuVeYfzjXQgjS2Ghoq/vg62eefbibY7cYCQ=;
        b=S+kpgMnlJ3fPlcD1QucdzozIO/1dBK30GkPDxs1UJbUgoZSco6LkGuioxJQTbj7n+U4PPi
        NgtZaQ0icPKfKxIt7m5yaUQQumNu72ZzFsoAgrCKmjkMLWEycDSjOogk+uPd6Mm+yUBD6c
        tap8jPql2sblg0GOcnp0RT0swe2Eme0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bdcf6de2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 13:29:16 +0000 (UTC)
Date:   Mon, 1 Aug 2022 15:29:11 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v2] random: implement getrandom() in vDSO
Message-ID: <YufVJ5wmYgkgRnpQ@zx2c4.com>
References: <YuXLlUZ8EzvZB43U@zx2c4.com>
 <20220731013125.2103601-1-Jason@zx2c4.com>
 <871qu0qri6.fsf@oldenburg.str.redhat.com>
 <YufLzQkmaERnJMOs@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YufLzQkmaERnJMOs@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Mon, Aug 01, 2022 at 02:49:17PM +0200, Jason A. Donenfeld wrote:
> What I understand you to mean is that *instead of* doing vDSO, we could
> just batch in the kernel, and reap most of the performance benefits. If
> that turns out to be true, and then we don't even need this vDSO stuff,
> I'd be really happy. So I'll give this a try.
> 
> One question is where to store that batch. On the surface, per-cpu seems
> appealing, like what we do for get_random_u32() and such for kernel
> callers. But per-cpu means disabling preemption, which then becomes a
> problem when copying into userspace, where the copies can fault. So
> maybe something more sensible is, like above, just doing this per-task.
> I'll give it a stab and will let you know what it looks like.

So doing the batching in the kernel gives roughly a 2x performance boost
for the u32 case. Below is a little hacky patch you can play with. This
isn't the face melting 15x of the vDSO approach, but it is something, I
guess.

Jason

From 99a314f603c9cd173e6db2e3776eb76477283e1a Mon Sep 17 00:00:00 2001
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 1 Aug 2022 15:19:33 +0200
Subject: [PATCH] random: batch getrandom() output per-task

bla bla just a test

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 68 +++++++++++++++++++++++++++----------------
 include/linux/sched.h |  6 ++++
 2 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d44832e9e709..1be0fea81cea 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -400,49 +400,67 @@ EXPORT_SYMBOL(get_random_bytes);
 static ssize_t get_random_bytes_user(struct iov_iter *iter)
 {
 	u32 chacha_state[CHACHA_STATE_WORDS];
-	u8 block[CHACHA_BLOCK_SIZE];
-	size_t ret = 0, copied;
+	unsigned long next_gen;
+	size_t ret, copied, batch_len;
+	bool do_more = true;

 	if (unlikely(!iov_iter_count(iter)))
 		return 0;

-	/*
-	 * Immediately overwrite the ChaCha key at index 4 with random
-	 * bytes, in case userspace causes copy_to_iter() below to sleep
-	 * forever, so that we still retain forward secrecy in that case.
-	 */
-	crng_make_state(chacha_state, (u8 *)&chacha_state[4], CHACHA_KEY_SIZE);
-	/*
-	 * However, if we're doing a read of len <= 32, we don't need to
-	 * use chacha_state after, so we can simply return those bytes to
-	 * the user directly.
-	 */
-	if (iov_iter_count(iter) <= CHACHA_KEY_SIZE) {
-		ret = copy_to_iter(&chacha_state[4], CHACHA_KEY_SIZE, iter);
-		goto out_zero_chacha;
+retry_generation:
+	ret = 0;
+	next_gen = READ_ONCE(base_crng.generation);
+	if (unlikely(next_gen != current->rng_batch.generation || crng_has_old_seed())) {
+		current->rng_batch.position = sizeof(current->rng_batch.buf);
+		current->rng_batch.generation = next_gen;
 	}

-	for (;;) {
-		chacha20_block(chacha_state, block);
+more_batch:
+	batch_len = min_t(size_t, iov_iter_count(iter),
+			  sizeof(current->rng_batch.buf) - current->rng_batch.position);
+	if (batch_len) {
+		copied = copy_to_iter(current->rng_batch.buf + current->rng_batch.position,
+				      batch_len, iter);
+		ret += copied;
+		memset(current->rng_batch.buf + current->rng_batch.position, 0, batch_len);
+		current->rng_batch.position += batch_len;
+		if (!iov_iter_count(iter) || copied != batch_len)
+			goto out;
+	}
+
+	crng_make_state(chacha_state, current->rng_batch.buf + CHACHA_BLOCK_SIZE, 32);
+	while (iov_iter_count(iter) >= CHACHA_BLOCK_SIZE) {
+		chacha20_block(chacha_state, current->rng_batch.buf);
 		if (unlikely(chacha_state[12] == 0))
 			++chacha_state[13];

-		copied = copy_to_iter(block, sizeof(block), iter);
+		copied = copy_to_iter(current->rng_batch.buf, CHACHA_BLOCK_SIZE, iter);
 		ret += copied;
-		if (!iov_iter_count(iter) || copied != sizeof(block))
+		if (!iov_iter_count(iter) || copied != CHACHA_BLOCK_SIZE) {
+			do_more = false;
 			break;
+		}

-		BUILD_BUG_ON(PAGE_SIZE % sizeof(block) != 0);
+		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
 		if (ret % PAGE_SIZE == 0) {
-			if (signal_pending(current))
+			if (signal_pending(current)) {
+				do_more = false;
 				break;
+			}
 			cond_resched();
 		}
 	}
-
-	memzero_explicit(block, sizeof(block));
-out_zero_chacha:
+	chacha20_block(chacha_state, current->rng_batch.buf);
+	current->rng_batch.position = 0;
 	memzero_explicit(chacha_state, sizeof(chacha_state));
+	if (do_more)
+		goto more_batch;
+
+out:
+	if (unlikely(ret && current->rng_batch.generation != READ_ONCE(base_crng.generation))) {
+		iov_iter_revert(iter, ret);
+		goto retry_generation;
+	}
 	return ret ? ret : -EFAULT;
 }

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758..6df125a43bb1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1500,6 +1500,12 @@ struct task_struct {
 	struct callback_head		l1d_flush_kill;
 #endif

+	struct {
+		unsigned long generation;
+		u8 buf[96];
+		u8 position;
+	} rng_batch;
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
--
2.35.1


