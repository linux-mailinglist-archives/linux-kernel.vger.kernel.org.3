Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E527A4B1211
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243780AbiBJPug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:50:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243772AbiBJPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:50:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB7BB3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:50:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8925861CA4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D27FC004E1;
        Thu, 10 Feb 2022 15:50:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Pe8AtVnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644508231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rcgCZkugrNJ4pcB0eRUnVhwg1dN/LIR8pqidSg1+e/M=;
        b=Pe8AtVnttvYcK6cRHB9WwnQ1PT25F4faWoNFxH699o0qxxK0lqaB7QJcv0df57bmJc9WQq
        lIyUDQAzRIpovObJbpwWEwsPk6iXJoEQaO+5a+SRJMMu9IGoKdp94JsCqSfW+tfPVCeCyh
        2zua57/TGJ0WZXls+jUTy22pznUpFUo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7098b324 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 15:50:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/3] random: remove unused tracepoints
Date:   Thu, 10 Feb 2022 16:50:11 +0100
Message-Id: <20220210155012.136485-3-Jason@zx2c4.com>
In-Reply-To: <20220210155012.136485-1-Jason@zx2c4.com>
References: <20220210155012.136485-1-Jason@zx2c4.com>
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

These explicit tracepoints aren't really used and show sign of aging.
It's work to keep these up to date, and before I attempted to keep them
up to date, they weren't up to date, which indicates that they're not
really used. These days there are better ways of introspecting anyway.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c         |  30 +----
 include/trace/events/random.h | 206 ----------------------------------
 lib/random32.c                |   2 -
 3 files changed, 3 insertions(+), 235 deletions(-)
 delete mode 100644 include/trace/events/random.h

diff --git a/drivers/char/random.c b/drivers/char/random.c
index cf535596d1bc..30a3c0717e3e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -237,9 +237,6 @@
 #include <asm/irq_regs.h>
 #include <asm/io.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/random.h>
-
 enum {
 	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
 	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
@@ -315,7 +312,6 @@ static void mix_pool_bytes(const void *in, size_t nbytes)
 {
 	unsigned long flags;
 
-	trace_mix_pool_bytes(nbytes, _RET_IP_);
 	spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(in, nbytes);
 	spin_unlock_irqrestore(&input_pool.lock, flags);
@@ -390,8 +386,6 @@ static void credit_entropy_bits(size_t nbits)
 		entropy_count = min_t(unsigned int, POOL_BITS, orig + add);
 	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);
 
-	trace_credit_entropy_bits(nbits, entropy_count, _RET_IP_);
-
 	if (crng_init < 2 && entropy_count >= POOL_MIN_BITS)
 		crng_reseed();
 }
@@ -719,7 +713,6 @@ void add_device_randomness(const void *buf, size_t size)
 	if (!crng_ready() && size)
 		crng_slow_load(buf, size);
 
-	trace_add_device_randomness(size, _RET_IP_);
 	spin_lock_irqsave(&input_pool.lock, flags);
 	_mix_pool_bytes(buf, size);
 	_mix_pool_bytes(&time, sizeof(time));
@@ -798,7 +791,6 @@ void add_input_randomness(unsigned int type, unsigned int code,
 	last_value = value;
 	add_timer_randomness(&input_timer_state,
 			     (type << 4) ^ code ^ (code >> 4) ^ value);
-	trace_add_input_randomness(input_pool.entropy_count);
 }
 EXPORT_SYMBOL_GPL(add_input_randomness);
 
@@ -900,7 +892,6 @@ void add_disk_randomness(struct gendisk *disk)
 		return;
 	/* first major is 1, so we get >= 0x200 here */
 	add_timer_randomness(disk->random, 0x100 + disk_devt(disk));
-	trace_add_disk_randomness(disk_devt(disk), input_pool.entropy_count);
 }
 EXPORT_SYMBOL_GPL(add_disk_randomness);
 #endif
@@ -925,8 +916,6 @@ static void extract_entropy(void *buf, size_t nbytes)
 	} block;
 	size_t i;
 
-	trace_extract_entropy(nbytes, input_pool.entropy_count);
-
 	for (i = 0; i < ARRAY_SIZE(block.rdseed); ++i) {
 		if (!arch_get_random_seed_long(&block.rdseed[i]) &&
 		    !arch_get_random_long(&block.rdseed[i]))
@@ -998,8 +987,6 @@ static void _get_random_bytes(void *buf, size_t nbytes)
 	u8 tmp[CHACHA_BLOCK_SIZE];
 	size_t len;
 
-	trace_get_random_bytes(nbytes, _RET_IP_);
-
 	if (!nbytes)
 		return;
 
@@ -1197,7 +1184,6 @@ size_t __must_check get_random_bytes_arch(void *buf, size_t nbytes)
 	size_t left = nbytes;
 	u8 *p = buf;
 
-	trace_get_random_bytes_arch(left, _RET_IP_);
 	while (left) {
 		unsigned long v;
 		size_t chunk = min_t(size_t, left, sizeof(unsigned long));
@@ -1281,16 +1267,6 @@ void rand_initialize_disk(struct gendisk *disk)
 }
 #endif
 
-static ssize_t urandom_read_nowarn(struct file *file, char __user *buf,
-				   size_t nbytes, loff_t *ppos)
-{
-	ssize_t ret;
-
-	ret = get_random_bytes_user(buf, nbytes);
-	trace_urandom_read(nbytes, input_pool.entropy_count);
-	return ret;
-}
-
 static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
 			    loff_t *ppos)
 {
@@ -1303,7 +1279,7 @@ static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
 				  current->comm, nbytes);
 	}
 
-	return urandom_read_nowarn(file, buf, nbytes, ppos);
+	return get_random_bytes_user(buf, nbytes);
 }
 
 static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
@@ -1314,7 +1290,7 @@ static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
 	ret = wait_for_random_bytes();
 	if (ret != 0)
 		return ret;
-	return urandom_read_nowarn(file, buf, nbytes, ppos);
+	return get_random_bytes_user(buf, nbytes);
 }
 
 static __poll_t random_poll(struct file *file, poll_table *wait)
@@ -1475,7 +1451,7 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
 		if (unlikely(ret))
 			return ret;
 	}
-	return urandom_read_nowarn(NULL, buf, count, NULL);
+	return get_random_bytes_user(buf, count);
 }
 
 /********************************************************************
diff --git a/include/trace/events/random.h b/include/trace/events/random.h
deleted file mode 100644
index dd6e154f9f75..000000000000
--- a/include/trace/events/random.h
+++ /dev/null
@@ -1,206 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM random
-
-#if !defined(_TRACE_RANDOM_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_RANDOM_H
-
-#include <linux/writeback.h>
-#include <linux/tracepoint.h>
-
-TRACE_EVENT(add_device_randomness,
-	TP_PROTO(size_t bytes, unsigned long IP),
-
-	TP_ARGS(bytes, IP),
-
-	TP_STRUCT__entry(
-		__field(size_t,		bytes	)
-		__field(unsigned long,	IP	)
-	),
-
-	TP_fast_assign(
-		__entry->bytes		= bytes;
-		__entry->IP		= IP;
-	),
-
-	TP_printk("bytes %zu caller %pS",
-		__entry->bytes, (void *)__entry->IP)
-);
-
-DECLARE_EVENT_CLASS(random__mix_pool_bytes,
-	TP_PROTO(size_t bytes, unsigned long IP),
-
-	TP_ARGS(bytes, IP),
-
-	TP_STRUCT__entry(
-		__field(size_t,		bytes	)
-		__field(unsigned long,	IP	)
-	),
-
-	TP_fast_assign(
-		__entry->bytes		= bytes;
-		__entry->IP		= IP;
-	),
-
-	TP_printk("input pool: bytes %zu caller %pS",
-		  __entry->bytes, (void *)__entry->IP)
-);
-
-DEFINE_EVENT(random__mix_pool_bytes, mix_pool_bytes,
-	TP_PROTO(size_t bytes, unsigned long IP),
-
-	TP_ARGS(bytes, IP)
-);
-
-TRACE_EVENT(credit_entropy_bits,
-	TP_PROTO(size_t bits, size_t entropy_count, unsigned long IP),
-
-	TP_ARGS(bits, entropy_count, IP),
-
-	TP_STRUCT__entry(
-		__field(size_t,		bits			)
-		__field(size_t,		entropy_count		)
-		__field(unsigned long,	IP			)
-	),
-
-	TP_fast_assign(
-		__entry->bits		= bits;
-		__entry->entropy_count	= entropy_count;
-		__entry->IP		= IP;
-	),
-
-	TP_printk("input pool: bits %zu entropy_count %zu caller %pS",
-		  __entry->bits, __entry->entropy_count, (void *)__entry->IP)
-);
-
-TRACE_EVENT(add_input_randomness,
-	TP_PROTO(size_t input_bits),
-
-	TP_ARGS(input_bits),
-
-	TP_STRUCT__entry(
-		__field(size_t,	input_bits		)
-	),
-
-	TP_fast_assign(
-		__entry->input_bits	= input_bits;
-	),
-
-	TP_printk("input_pool_bits %zu", __entry->input_bits)
-);
-
-TRACE_EVENT(add_disk_randomness,
-	TP_PROTO(dev_t dev, size_t input_bits),
-
-	TP_ARGS(dev, input_bits),
-
-	TP_STRUCT__entry(
-		__field(dev_t,		dev			)
-		__field(size_t,		input_bits		)
-	),
-
-	TP_fast_assign(
-		__entry->dev		= dev;
-		__entry->input_bits	= input_bits;
-	),
-
-	TP_printk("dev %d,%d input_pool_bits %zu", MAJOR(__entry->dev),
-		  MINOR(__entry->dev), __entry->input_bits)
-);
-
-DECLARE_EVENT_CLASS(random__get_random_bytes,
-	TP_PROTO(size_t nbytes, unsigned long IP),
-
-	TP_ARGS(nbytes, IP),
-
-	TP_STRUCT__entry(
-		__field(size_t,		nbytes			)
-		__field(unsigned long,	IP			)
-	),
-
-	TP_fast_assign(
-		__entry->nbytes		= nbytes;
-		__entry->IP		= IP;
-	),
-
-	TP_printk("nbytes %zu caller %pS", __entry->nbytes, (void *)__entry->IP)
-);
-
-DEFINE_EVENT(random__get_random_bytes, get_random_bytes,
-	TP_PROTO(size_t nbytes, unsigned long IP),
-
-	TP_ARGS(nbytes, IP)
-);
-
-DEFINE_EVENT(random__get_random_bytes, get_random_bytes_arch,
-	TP_PROTO(size_t nbytes, unsigned long IP),
-
-	TP_ARGS(nbytes, IP)
-);
-
-DECLARE_EVENT_CLASS(random__extract_entropy,
-	TP_PROTO(size_t nbytes, size_t entropy_count),
-
-	TP_ARGS(nbytes, entropy_count),
-
-	TP_STRUCT__entry(
-		__field(  size_t,	nbytes			)
-		__field(  size_t,	entropy_count		)
-	),
-
-	TP_fast_assign(
-		__entry->nbytes		= nbytes;
-		__entry->entropy_count	= entropy_count;
-	),
-
-	TP_printk("input pool: nbytes %zu entropy_count %zu",
-		  __entry->nbytes, __entry->entropy_count)
-);
-
-
-DEFINE_EVENT(random__extract_entropy, extract_entropy,
-	TP_PROTO(size_t nbytes, size_t entropy_count),
-
-	TP_ARGS(nbytes, entropy_count)
-);
-
-TRACE_EVENT(urandom_read,
-	TP_PROTO(size_t nbytes, size_t entropy_count),
-
-	TP_ARGS(nbytes, entropy_count),
-
-	TP_STRUCT__entry(
-		__field( size_t,	nbytes		)
-		__field( size_t,	entropy_count	)
-	),
-
-	TP_fast_assign(
-		__entry->nbytes		= nbytes;
-		__entry->entropy_count	= entropy_count;
-	),
-
-	TP_printk("reading: nbytes %zu entropy_count %zu",
-		  __entry->nbytes, __entry->entropy_count)
-);
-
-TRACE_EVENT(prandom_u32,
-
-	TP_PROTO(unsigned int ret),
-
-	TP_ARGS(ret),
-
-	TP_STRUCT__entry(
-		__field(   unsigned int, ret)
-	),
-
-	TP_fast_assign(
-		__entry->ret = ret;
-	),
-
-	TP_printk("ret=%u" , __entry->ret)
-);
-
-#endif /* _TRACE_RANDOM_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
diff --git a/lib/random32.c b/lib/random32.c
index a57a0e18819d..3c19820796d0 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -41,7 +41,6 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <asm/unaligned.h>
-#include <trace/events/random.h>
 
 /**
  *	prandom_u32_state - seeded pseudo-random number generator.
@@ -387,7 +386,6 @@ u32 prandom_u32(void)
 	struct siprand_state *state = get_cpu_ptr(&net_rand_state);
 	u32 res = siprand_u32(state);
 
-	trace_prandom_u32(res);
 	put_cpu_ptr(&net_rand_state);
 	return res;
 }
-- 
2.35.0

