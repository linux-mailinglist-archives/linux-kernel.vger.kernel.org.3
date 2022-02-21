Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE54BDC93
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379471AbiBUPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:47:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiBUPrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:47:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469CC22BC5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:47:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB8AF6120F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 15:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8C2C340E9;
        Mon, 21 Feb 2022 15:47:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jKYr5cIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645458446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBYkKyKNPkdz2kvGFW609VIaQtBA6vJAm5BIip1HHmo=;
        b=jKYr5cIOzzJ/FFJs/BX/lSydIpnJVHGexwNCNmAblhnlMEmGDFyzKNeolb3i/6XlDHdfoC
        z85AqBdJoAgYZrboRkHsU3Uln+Wqt7/O/aQ6UpYNem7/Djukuv5sc/A1GVqzTpQfy5Z0BF
        ivtcg3uiKPa2PHhQfBoVlcWAaqvqjeA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e28c4740 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 21 Feb 2022 15:47:25 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v4] random: always wake up entropy writers after extraction
Date:   Mon, 21 Feb 2022 16:47:21 +0100
Message-Id: <20220221154721.2292443-1-Jason@zx2c4.com>
In-Reply-To: <CAHmME9rNtcZfj5CmRarX3-MKBYVG0tTzu80Jmm=2peWp0zy2UA@mail.gmail.com>
References: <CAHmME9rNtcZfj5CmRarX3-MKBYVG0tTzu80Jmm=2peWp0zy2UA@mail.gmail.com>
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

Now that POOL_BITS == POOL_MIN_BITS, we must unconditionally wake up
entropy writers after every extraction. Therefore there's no point of
write_wakeup_threshold, so we can move it to the dustbin of unused
compatibility sysctls. While we're at it, we can fix a small comparison
where we were waking up after <= min rather than < min.

Cc: Theodore Ts'o <tytso@mit.edu>
Suggested-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
v4 keeps the file writable to avoid breaking userspace and updates
kernel.rst.

 Documentation/admin-guide/sysctl/kernel.rst |  7 +++--
 drivers/char/random.c                       | 33 +++++++--------------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d359bcfadd39..d3c6d9a501a9 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1029,14 +1029,17 @@ This is a directory, with the following entries:
 * ``poolsize``: the entropy pool size, in bits;
 
 * ``urandom_min_reseed_secs``: obsolete (used to determine the minimum
-  number of seconds between urandom pool reseeding).
+  number of seconds between urandom pool reseeding). This file is
+  writable for compatibility purposes, but writing to it has no effect
+  on any RNG behavior.
 
 * ``uuid``: a UUID generated every time this is retrieved (this can
   thus be used to generate UUIDs at will);
 
 * ``write_wakeup_threshold``: when the entropy count drops below this
   (as a number of bits), processes waiting to write to ``/dev/random``
-  are woken up.
+  are woken up. This file is writable for compatibility purposes, but
+  writing to it has no effect on any RNG behavior.
 
 If ``drivers/char/random.c`` is built with ``ADD_INTERRUPT_BENCH``
 defined, these additional entries are present:
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 20538e9b1a2c..3b30e764eeef 100644
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
@@ -739,10 +733,8 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
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
@@ -1698,9 +1689,7 @@ static struct ctl_table random_table[] = {
 		.data		= &random_write_wakeup_bits,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_write_thresh,
-		.extra2		= &max_write_thresh,
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
2.35.1

