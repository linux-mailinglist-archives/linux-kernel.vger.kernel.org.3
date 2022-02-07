Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA34AC416
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384409AbiBGPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357118AbiBGPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:39:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC42DC0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:39:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8870A614D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FF7C340FA;
        Mon,  7 Feb 2022 15:39:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YkM1wg/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644248381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ACmf7yHVl31eDtpEDeQOcSk4Rx1+KN2xIsLIQaM7DA=;
        b=YkM1wg/5oxns+XC6scOzdjfiRWtbIWhyZAJZEca7qe8z5VvermzED6cp8LtoRqCPMPeRIk
        +mydz6Xoyz+q1O3fePFuiRurtkKi6liVi1PDYtb4fepucC3J3+s6hBCuxCD74YCkjSaNX6
        fGa/45CdiowrSaznVBnHkjbMOSkeMw4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c64d8002 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 7 Feb 2022 15:39:41 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH v3 1/2] random: remove batched entropy locking
Date:   Mon,  7 Feb 2022 16:39:13 +0100
Message-Id: <20220207153914.365931-2-Jason@zx2c4.com>
In-Reply-To: <20220207153914.365931-1-Jason@zx2c4.com>
References: <20220207153914.365931-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rather than use spinlocks to protect batched entropy, we can instead
disable interrupts locally, since we're dealing with per-cpu data, and
manage resets with a basic generation counter. At the same time, we
can't quite do this on PREEMPT_RT, where we still want spinlocks-as-
mutexes semantics. So we use a local_lock_t, which provides the right
behavior for each. Because this is a per-cpu lock, that generation
counter is still doing the necessary CPU-to-CPU communication.

This should improve performance a bit. It will also fix the linked splat
that Jonathan received with a PROVE_RAW_LOCK_NESTING=y.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Reported-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Tested-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Link: https://lore.kernel.org/lkml/YfMa0QgsjCVdRAvJ@latitude/
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 51 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 8ae2bf5ca606..395e76c009d6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1731,13 +1731,16 @@ static int __init random_sysctls_init(void)
 device_initcall(random_sysctls_init);
 #endif	/* CONFIG_SYSCTL */
 
+static atomic_t batch_generation = ATOMIC_INIT(0);
+
 struct batched_entropy {
 	union {
 		u64 entropy_u64[CHACHA_BLOCK_SIZE / sizeof(u64)];
 		u32 entropy_u32[CHACHA_BLOCK_SIZE / sizeof(u32)];
 	};
+	local_lock_t lock;
 	unsigned int position;
-	spinlock_t batch_lock;
+	int generation;
 };
 
 /*
@@ -1749,7 +1752,7 @@ struct batched_entropy {
  * point prior.
  */
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
-	.batch_lock = __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
+	.lock = INIT_LOCAL_LOCK(batched_entropy_u64.lock)
 };
 
 u64 get_random_u64(void)
@@ -1758,41 +1761,54 @@ u64 get_random_u64(void)
 	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
+	int next_gen;
 
 	warn_unseeded_randomness(&previous);
 
+	local_lock_irqsave(&batched_entropy_u64.lock, flags);
 	batch = raw_cpu_ptr(&batched_entropy_u64);
-	spin_lock_irqsave(&batch->batch_lock, flags);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
+
+	next_gen = atomic_read(&batch_generation);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0 ||
+	    next_gen != batch->generation) {
 		extract_crng((u8 *)batch->entropy_u64);
 		batch->position = 0;
+		batch->generation = next_gen;
 	}
+
 	ret = batch->entropy_u64[batch->position++];
-	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	local_unlock_irqrestore(&batched_entropy_u64.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u64);
 
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
-	.batch_lock = __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
+	.lock = INIT_LOCAL_LOCK(batched_entropy_u32.lock)
 };
+
 u32 get_random_u32(void)
 {
 	u32 ret;
 	unsigned long flags;
 	struct batched_entropy *batch;
 	static void *previous;
+	int next_gen;
 
 	warn_unseeded_randomness(&previous);
 
+	local_lock_irqsave(&batched_entropy_u32.lock, flags);
 	batch = raw_cpu_ptr(&batched_entropy_u32);
-	spin_lock_irqsave(&batch->batch_lock, flags);
-	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0) {
+
+	next_gen = atomic_read(&batch_generation);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u32) == 0 ||
+	    next_gen != batch->generation) {
 		extract_crng((u8 *)batch->entropy_u32);
 		batch->position = 0;
+		batch->generation = next_gen;
 	}
+
 	ret = batch->entropy_u32[batch->position++];
-	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	local_unlock_irqrestore(&batched_entropy_u32.lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(get_random_u32);
@@ -1803,22 +1819,7 @@ EXPORT_SYMBOL(get_random_u32);
  * next usage. */
 static void invalidate_batched_entropy(void)
 {
-	int cpu;
-	unsigned long flags;
-
-	for_each_possible_cpu(cpu) {
-		struct batched_entropy *batched_entropy;
-
-		batched_entropy = per_cpu_ptr(&batched_entropy_u32, cpu);
-		spin_lock_irqsave(&batched_entropy->batch_lock, flags);
-		batched_entropy->position = 0;
-		spin_unlock(&batched_entropy->batch_lock);
-
-		batched_entropy = per_cpu_ptr(&batched_entropy_u64, cpu);
-		spin_lock(&batched_entropy->batch_lock);
-		batched_entropy->position = 0;
-		spin_unlock_irqrestore(&batched_entropy->batch_lock, flags);
-	}
+	atomic_inc(&batch_generation);
 }
 
 /**
-- 
2.35.0

