Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703B84AA9DB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 17:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiBEQCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 11:02:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33318 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380344AbiBEQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 11:02:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BDF860FDB;
        Sat,  5 Feb 2022 16:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF10C340E8;
        Sat,  5 Feb 2022 16:02:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jr6XJir6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644076920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1iZx9N/3Al1BNBml4zAA68jO81KukzY4F+ZRLKcqbrk=;
        b=jr6XJir6XQ5ZoiiH2CzPV8NaiwSHZvSh16ANfTq/okBhTT1NDgBtkRLbydE9pKB3lzFCdB
        Wp6EFE4KRJKhXu2IL/nhWD6O1Y9yrJzPcZG+oZUwDis2RJSUVIhVpv0E82FZAGSzgPNe24
        fVYB2/Cs3Po7d8QLAJtBFDk0hJuCfms=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bff21410 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 5 Feb 2022 16:02:00 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v3 4/5] random: always wake up entropy writers after extraction
Date:   Sat,  5 Feb 2022 17:01:17 +0100
Message-Id: <20220205160118.252698-5-Jason@zx2c4.com>
In-Reply-To: <20220205160118.252698-1-Jason@zx2c4.com>
References: <20220205160118.252698-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that POOL_BITS == POOL_MIN_BITS, we must unconditionally wake up
entropy writers after every extraction. Therefore there's no point of
write_wakeup_threshold, so we can move it to the dustbin of unused
compatibility sysctls. While we're at it, we can fix a small comparison
where we were waking up after <= min rather than < min.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d0ec8503941e..82ec3a0399fb 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -296,12 +296,6 @@ enum {
  */
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 static struct fasync_struct *fasync;
-/*
- * If the entropy count falls under this number of bits, then we
- * should wake up processes which are selecting or polling on write
- * access to /dev/random.
- */
-static int random_write_wakeup_bits = POOL_MIN_BITS;
 
 static DEFINE_SPINLOCK(random_ready_list_lock);
 static LIST_HEAD(random_ready_list);
@@ -739,10 +733,8 @@ static void crng_reseed(struct crng_state *crng)
 				return;
 		} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
 		extract_entropy(buf.key, sizeof(buf.key));
-		if (random_write_wakeup_bits) {
-			wake_up_interruptible(&random_write_wait);
-			kill_fasync(&fasync, SIGIO, POLL_OUT);
-		}
+		wake_up_interruptible(&random_write_wait);
+		kill_fasync(&fasync, SIGIO, POLL_OUT);
 	} else {
 		_extract_crng(&primary_crng, buf.block);
 		_crng_backtrack_protect(&primary_crng, buf.block,
@@ -1471,7 +1463,7 @@ static __poll_t random_poll(struct file *file, poll_table *wait)
 	mask = 0;
 	if (crng_ready())
 		mask |= EPOLLIN | EPOLLRDNORM;
-	if (input_pool.entropy_count < random_write_wakeup_bits)
+	if (input_pool.entropy_count < POOL_MIN_BITS)
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	return mask;
 }
@@ -1556,7 +1548,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		 */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (xchg(&input_pool.entropy_count, 0) && random_write_wakeup_bits) {
+		if (xchg(&input_pool.entropy_count, 0)) {
 			wake_up_interruptible(&random_write_wait);
 			kill_fasync(&fasync, SIGIO, POLL_OUT);
 		}
@@ -1636,9 +1628,9 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
 
 #include <linux/sysctl.h>
 
-static int min_write_thresh;
-static int max_write_thresh = POOL_BITS;
 static int random_min_urandom_seed = 60;
+static int random_write_wakeup_bits = POOL_MIN_BITS;
+static int sysctl_poolsize = POOL_BITS;
 static char sysctl_bootid[16];
 
 /*
@@ -1677,7 +1669,6 @@ static int proc_do_uuid(struct ctl_table *table, int write, void *buffer,
 	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
 }
 
-static int sysctl_poolsize = POOL_BITS;
 static struct ctl_table random_table[] = {
 	{
 		.procname	= "poolsize",
@@ -1697,10 +1688,8 @@ static struct ctl_table random_table[] = {
 		.procname	= "write_wakeup_threshold",
 		.data		= &random_write_wakeup_bits,
 		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_write_thresh,
-		.extra2		= &max_write_thresh,
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec,
 	},
 	{
 		.procname	= "urandom_min_reseed_secs",
@@ -1892,13 +1881,13 @@ void add_hwgenerator_randomness(const char *buffer, size_t count,
 	}
 
 	/* Throttle writing if we're above the trickle threshold.
-	 * We'll be woken up again once below random_write_wakeup_thresh,
-	 * when the calling thread is about to terminate, or once
-	 * CRNG_RESEED_INTERVAL has lapsed.
+	 * We'll be woken up again once below POOL_MIN_BITS, when
+	 * the calling thread is about to terminate, or once
+	 * CRNG_RESEED_INTERVAL has elapsed.
 	 */
 	wait_event_interruptible_timeout(random_write_wait,
 			!system_wq || kthread_should_stop() ||
-			input_pool.entropy_count <= random_write_wakeup_bits,
+			input_pool.entropy_count < POOL_MIN_BITS,
 			CRNG_RESEED_INTERVAL);
 	mix_pool_bytes(buffer, count);
 	credit_entropy_bits(entropy);
-- 
2.35.0

