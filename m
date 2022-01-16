Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54A948FDEA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiAPQgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiAPQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:36:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788B3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 08:36:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CC72B80D87
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 16:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86334C36AE7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 16:36:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CqUqUwI3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642350959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDRp2dfJ+P2kZRTL/+hqDO/0UMoS4zphLXLzusTsbC8=;
        b=CqUqUwI3vrUaAy2zMpFX9DJHHrXCn7T5i5Toba4EtnRZCIaGE3ehjDrkA8UfWp9R5Lmm1v
        G1ZN9oWy1NZKavYBEn184kQpSDOtMNaW0J47IJvzaqk9O4DFrZjryHPF5B+dBs0Tj1WO7R
        dzmC6IWhVhdCcveRpQy7YcDUzawgB6Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 744e854d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 16 Jan 2022 16:35:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 4/4] random: selectively clang-format where it makes sense
Date:   Sun, 16 Jan 2022 17:35:47 +0100
Message-Id: <20220116163547.154991-4-Jason@zx2c4.com>
In-Reply-To: <20220116163547.154991-1-Jason@zx2c4.com>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220116163547.154991-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an old driver that has seen a lot of different eras of kernel
coding style. In an effort to make it easier to code for, unify the
coding style around the current norm, by accepting some of -- but
certainly not all of -- the suggestions from clang-format. This should
remove ambiguity in coding style, especially with regards to spacing,
when code is being changed or amended. Consequently it also makes code
review easier on the eyes, following one uniform style rather than
several.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 191 ++++++++++++++++++++----------------------
 1 file changed, 90 insertions(+), 101 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 274056155e50..d0c14eb05c66 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -443,9 +443,9 @@ static DEFINE_SPINLOCK(random_ready_list_lock);
 static LIST_HEAD(random_ready_list);
 
 struct crng_state {
-	u32		state[16];
-	unsigned long	init_time;
-	spinlock_t	lock;
+	u32 state[16];
+	unsigned long init_time;
+	spinlock_t lock;
 };
 
 static struct crng_state primary_crng = {
@@ -469,7 +469,7 @@ static bool crng_need_final_init = false;
 #define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
 static unsigned long crng_global_init_time = 0;
-#define CRNG_INIT_CNT_THRESH (2*CHACHA_KEY_SIZE)
+#define CRNG_INIT_CNT_THRESH (2 * CHACHA_KEY_SIZE)
 static void _extract_crng(struct crng_state *crng, u8 out[CHACHA_BLOCK_SIZE]);
 static void _crng_backtrack_protect(struct crng_state *crng,
 				    u8 tmp[CHACHA_BLOCK_SIZE], int used);
@@ -579,10 +579,10 @@ static void mix_pool_bytes(const void *in, int nbytes)
 }
 
 struct fast_pool {
-	u32		pool[4];
-	unsigned long	last;
-	u16		reg_idx;
-	u8		count;
+	u32 pool[4];
+	unsigned long last;
+	u16 reg_idx;
+	u8 count;
 };
 
 /*
@@ -622,7 +622,7 @@ static void process_random_ready_list(void)
 	struct random_ready_callback *rdy, *tmp;
 
 	spin_lock_irqsave(&random_ready_list_lock, flags);
-	list_for_each_entry_safe(rdy, tmp, &random_ready_list, list) {
+	list_for_each_entry_safe (rdy, tmp, &random_ready_list, list) {
 		struct module *owner = rdy->owner;
 
 		list_del_init(&rdy->list);
@@ -710,7 +710,7 @@ static int credit_entropy_bits_safe(int nbits)
 		return -EINVAL;
 
 	/* Cap the value to avoid overflows */
-	nbits = min(nbits,  POOL_BITS);
+	nbits = min(nbits, POOL_BITS);
 
 	credit_entropy_bits(nbits);
 	return 0;
@@ -722,7 +722,7 @@ static int credit_entropy_bits_safe(int nbits)
  *
  *********************************************************************/
 
-#define CRNG_RESEED_INTERVAL (300*HZ)
+#define CRNG_RESEED_INTERVAL (300 * HZ)
 
 static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
 
@@ -746,9 +746,9 @@ early_param("random.trust_cpu", parse_trust_cpu);
 
 static bool crng_init_try_arch(struct crng_state *crng)
 {
-	int		i;
-	bool		arch_init = true;
-	unsigned long	rv;
+	int i;
+	bool arch_init = true;
+	unsigned long rv;
 
 	for (i = 4; i < 16; i++) {
 		if (!arch_get_random_seed_long(&rv) &&
@@ -764,9 +764,9 @@ static bool crng_init_try_arch(struct crng_state *crng)
 
 static bool __init crng_init_try_arch_early(struct crng_state *crng)
 {
-	int		i;
-	bool		arch_init = true;
-	unsigned long	rv;
+	int i;
+	bool arch_init = true;
+	unsigned long rv;
 
 	for (i = 4; i < 16; i++) {
 		if (!arch_get_random_seed_long_early(&rv) &&
@@ -836,8 +836,8 @@ static void do_numa_crng_init(struct work_struct *work)
 	struct crng_state *crng;
 	struct crng_state **pool;
 
-	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL|__GFP_NOFAIL);
-	for_each_online_node(i) {
+	pool = kcalloc(nr_node_ids, sizeof(*pool), GFP_KERNEL | __GFP_NOFAIL);
+	for_each_online_node (i) {
 		crng = kmalloc_node(sizeof(struct crng_state),
 				    GFP_KERNEL | __GFP_NOFAIL, i);
 		spin_lock_init(&crng->lock);
@@ -846,7 +846,7 @@ static void do_numa_crng_init(struct work_struct *work)
 	}
 	/* pairs with READ_ONCE() in select_crng() */
 	if (cmpxchg_release(&crng_node_pool, NULL, pool) != NULL) {
-		for_each_node(i)
+		for_each_node (i)
 			kfree(pool[i]);
 		kfree(pool);
 	}
@@ -892,7 +892,7 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 		return 0;
 	}
-	p = (u8 *) &primary_crng.state[4];
+	p = (u8 *)&primary_crng.state[4];
 	while (len > 0 && crng_init_cnt < CRNG_INIT_CNT_THRESH) {
 		p[crng_init_cnt % CHACHA_KEY_SIZE] ^= *cp;
 		cp++; crng_init_cnt++; len--; ret++;
@@ -922,12 +922,12 @@ static size_t crng_fast_load(const u8 *cp, size_t len)
  */
 static int crng_slow_load(const u8 *cp, size_t len)
 {
-	unsigned long		flags;
-	static u8		lfsr = 1;
-	u8			tmp;
-	unsigned		i, max = CHACHA_KEY_SIZE;
-	const u8 *		src_buf = cp;
-	u8 *			dest_buf = (u8 *) &primary_crng.state[4];
+	unsigned long flags;
+	static u8 lfsr = 1;
+	u8 tmp;
+	unsigned i, max = CHACHA_KEY_SIZE;
+	const u8 *src_buf = cp;
+	u8 *dest_buf = (u8 *)&primary_crng.state[4];
 
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
@@ -938,7 +938,7 @@ static int crng_slow_load(const u8 *cp, size_t len)
 	if (len > max)
 		max = len;
 
-	for (i = 0; i < max ; i++) {
+	for (i = 0; i < max; i++) {
 		tmp = lfsr;
 		lfsr >>= 1;
 		if (tmp & 1)
@@ -953,11 +953,11 @@ static int crng_slow_load(const u8 *cp, size_t len)
 
 static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 {
-	unsigned long	flags;
-	int		i, num;
+	unsigned long flags;
+	int i, num;
 	union {
-		u8	block[CHACHA_BLOCK_SIZE];
-		u32	key[8];
+		u8 block[CHACHA_BLOCK_SIZE];
+		u32 key[8];
 	} buf;
 
 	if (use_input_pool) {
@@ -971,11 +971,11 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 	}
 	spin_lock_irqsave(&crng->lock, flags);
 	for (i = 0; i < 8; i++) {
-		unsigned long	rv;
+		unsigned long rv;
 		if (!arch_get_random_seed_long(&rv) &&
 		    !arch_get_random_long(&rv))
 			rv = random_get_entropy();
-		crng->state[i+4] ^= buf.key[i] ^ rv;
+		crng->state[i + 4] ^= buf.key[i] ^ rv;
 	}
 	memzero_explicit(&buf, sizeof(buf));
 	WRITE_ONCE(crng->init_time, jiffies);
@@ -983,8 +983,7 @@ static void crng_reseed(struct crng_state *crng, bool use_input_pool)
 	crng_finalize_init(crng);
 }
 
-static void _extract_crng(struct crng_state *crng,
-			  u8 out[CHACHA_BLOCK_SIZE])
+static void _extract_crng(struct crng_state *crng, u8 out[CHACHA_BLOCK_SIZE])
 {
 	unsigned long flags, init_time;
 
@@ -1013,9 +1012,9 @@ static void extract_crng(u8 out[CHACHA_BLOCK_SIZE])
 static void _crng_backtrack_protect(struct crng_state *crng,
 				    u8 tmp[CHACHA_BLOCK_SIZE], int used)
 {
-	unsigned long	flags;
-	u32		*s, *d;
-	int		i;
+	unsigned long flags;
+	u32 *s, *d;
+	int i;
 
 	used = round_up(used, sizeof(u32));
 	if (used + CHACHA_KEY_SIZE > CHACHA_BLOCK_SIZE) {
@@ -1023,9 +1022,9 @@ static void _crng_backtrack_protect(struct crng_state *crng,
 		used = 0;
 	}
 	spin_lock_irqsave(&crng->lock, flags);
-	s = (u32 *) &tmp[used];
+	s = (u32 *)&tmp[used];
 	d = &crng->state[4];
-	for (i=0; i < 8; i++)
+	for (i = 0; i < 8; i++)
 		*d++ ^= *s++;
 	spin_unlock_irqrestore(&crng->lock, flags);
 }
@@ -1070,7 +1069,6 @@ static ssize_t extract_crng_user(void __user *buf, size_t nbytes)
 	return ret;
 }
 
-
 /*********************************************************************
  *
  * Entropy input management
@@ -1165,11 +1163,11 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 	 * Round down by 1 bit on general principles,
 	 * and limit entropy estimate to 12 bits.
 	 */
-	credit_entropy_bits(min_t(int, fls(delta>>1), 11));
+	credit_entropy_bits(min_t(int, fls(delta >> 1), 11));
 }
 
 void add_input_randomness(unsigned int type, unsigned int code,
-				 unsigned int value)
+			  unsigned int value)
 {
 	static unsigned char last_value;
 
@@ -1189,19 +1187,19 @@ static DEFINE_PER_CPU(struct fast_pool, irq_randomness);
 #ifdef ADD_INTERRUPT_BENCH
 static unsigned long avg_cycles, avg_deviation;
 
-#define AVG_SHIFT 8     /* Exponential average factor k=1/256 */
-#define FIXED_1_2 (1 << (AVG_SHIFT-1))
+#define AVG_SHIFT 8 /* Exponential average factor k=1/256 */
+#define FIXED_1_2 (1 << (AVG_SHIFT - 1))
 
 static void add_interrupt_bench(cycles_t start)
 {
-        long delta = random_get_entropy() - start;
+	long delta = random_get_entropy() - start;
 
-        /* Use a weighted moving average */
-        delta = delta - ((avg_cycles + FIXED_1_2) >> AVG_SHIFT);
-        avg_cycles += delta;
-        /* And average deviation */
-        delta = abs(delta) - ((avg_deviation + FIXED_1_2) >> AVG_SHIFT);
-        avg_deviation += delta;
+	/* Use a weighted moving average */
+	delta = delta - ((avg_cycles + FIXED_1_2) >> AVG_SHIFT);
+	avg_cycles += delta;
+	/* And average deviation */
+	delta = abs(delta) - ((avg_deviation + FIXED_1_2) >> AVG_SHIFT);
+	avg_deviation += delta;
 }
 #else
 #define add_interrupt_bench(x)
@@ -1209,7 +1207,7 @@ static void add_interrupt_bench(cycles_t start)
 
 static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
-	u32 *ptr = (u32 *) regs;
+	u32 *ptr = (u32 *)regs;
 	unsigned int idx;
 
 	if (regs == NULL)
@@ -1224,12 +1222,12 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 
 void add_interrupt_randomness(int irq)
 {
-	struct fast_pool	*fast_pool = this_cpu_ptr(&irq_randomness);
-	struct pt_regs		*regs = get_irq_regs();
-	unsigned long		now = jiffies;
-	cycles_t		cycles = random_get_entropy();
-	u32			c_high, j_high;
-	u64			ip;
+	struct fast_pool *fast_pool = this_cpu_ptr(&irq_randomness);
+	struct pt_regs *regs = get_irq_regs();
+	unsigned long now = jiffies;
+	cycles_t cycles = random_get_entropy();
+	u32 c_high, j_high;
+	u64 ip;
 
 	if (cycles == 0)
 		cycles = get_reg(fast_pool, regs);
@@ -1239,8 +1237,8 @@ void add_interrupt_randomness(int irq)
 	fast_pool->pool[1] ^= now ^ c_high;
 	ip = regs ? instruction_pointer(regs) : _RET_IP_;
 	fast_pool->pool[2] ^= ip;
-	fast_pool->pool[3] ^= (sizeof(ip) > 4) ? ip >> 32 :
-		get_reg(fast_pool, regs);
+	fast_pool->pool[3] ^=
+		(sizeof(ip) > 4) ? ip >> 32 : get_reg(fast_pool, regs);
 
 	fast_mix(fast_pool);
 	add_interrupt_bench(cycles);
@@ -1254,8 +1252,7 @@ void add_interrupt_randomness(int irq)
 		return;
 	}
 
-	if ((fast_pool->count < 64) &&
-	    !time_after(now, fast_pool->last + HZ))
+	if ((fast_pool->count < 64) && !time_after(now, fast_pool->last + HZ))
 		return;
 
 	if (!spin_trylock(&input_pool.lock))
@@ -1319,7 +1316,7 @@ static size_t account(size_t nbytes, int min)
 		entropy_count = 0;
 	}
 	nfrac = ibytes << (POOL_ENTROPY_SHIFT + 3);
-	if ((size_t) entropy_count > nfrac)
+	if ((size_t)entropy_count > nfrac)
 		entropy_count -= nfrac;
 	else
 		entropy_count = 0;
@@ -1422,10 +1419,9 @@ static ssize_t extract_entropy(void *buf, size_t nbytes, int min)
 }
 
 #define warn_unseeded_randomness(previous) \
-	_warn_unseeded_randomness(__func__, (void *) _RET_IP_, (previous))
+	_warn_unseeded_randomness(__func__, (void *)_RET_IP_, (previous))
 
-static void _warn_unseeded_randomness(const char *func_name, void *caller,
-				      void **previous)
+static void _warn_unseeded_randomness(const char *func_name, void *caller, void **previous)
 {
 #ifdef CONFIG_WARN_ALL_UNSEEDED_RANDOM
 	const bool print_once = false;
@@ -1433,8 +1429,7 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
 	static bool print_once __read_mostly;
 #endif
 
-	if (print_once ||
-	    crng_ready() ||
+	if (print_once || crng_ready() ||
 	    (previous && (caller == READ_ONCE(*previous))))
 		return;
 	WRITE_ONCE(*previous, caller);
@@ -1442,9 +1437,8 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
 	print_once = true;
 #endif
 	if (__ratelimit(&unseeded_warning))
-		printk_deferred(KERN_NOTICE "random: %s called from %pS "
-				"with crng_init=%d\n", func_name, caller,
-				crng_init);
+		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n",
+				func_name, caller, crng_init);
 }
 
 /*
@@ -1487,7 +1481,6 @@ void get_random_bytes(void *buf, int nbytes)
 }
 EXPORT_SYMBOL(get_random_bytes);
 
-
 /*
  * Each time the timer fires, we expect that we got an unpredictable
  * jump in the cycle counter. Even if the timer is running on another
@@ -1526,7 +1519,7 @@ static void try_to_generate_entropy(void)
 	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
 	while (!crng_ready()) {
 		if (!timer_pending(&stack.timer))
-			mod_timer(&stack.timer, jiffies+1);
+			mod_timer(&stack.timer, jiffies + 1);
 		mix_pool_bytes(&stack.now, sizeof(stack.now));
 		schedule();
 		stack.now = random_get_entropy();
@@ -1736,9 +1729,8 @@ void rand_initialize_disk(struct gendisk *disk)
 }
 #endif
 
-static ssize_t
-urandom_read_nowarn(struct file *file, char __user *buf, size_t nbytes,
-		    loff_t *ppos)
+static ssize_t urandom_read_nowarn(struct file *file, char __user *buf,
+				   size_t nbytes, loff_t *ppos)
 {
 	int ret;
 
@@ -1748,8 +1740,8 @@ urandom_read_nowarn(struct file *file, char __user *buf, size_t nbytes,
 	return ret;
 }
 
-static ssize_t
-urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+static ssize_t urandom_read(struct file *file, char __user *buf, size_t nbytes,
+			    loff_t *ppos)
 {
 	static int maxwarn = 10;
 
@@ -1763,8 +1755,8 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	return urandom_read_nowarn(file, buf, nbytes, ppos);
 }
 
-static ssize_t
-random_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+static ssize_t random_read(struct file *file, char __user *buf, size_t nbytes,
+			   loff_t *ppos)
 {
 	int ret;
 
@@ -1774,8 +1766,7 @@ random_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	return urandom_read_nowarn(file, buf, nbytes, ppos);
 }
 
-static __poll_t
-random_poll(struct file *file, poll_table * wait)
+static __poll_t random_poll(struct file *file, poll_table *wait)
 {
 	__poll_t mask;
 
@@ -1789,8 +1780,7 @@ random_poll(struct file *file, poll_table * wait)
 	return mask;
 }
 
-static int
-write_pool(const char __user *buffer, size_t count)
+static int write_pool(const char __user *buffer, size_t count)
 {
 	size_t bytes;
 	u32 t, buf[16];
@@ -1892,9 +1882,9 @@ static int random_fasync(int fd, struct file *filp, int on)
 }
 
 const struct file_operations random_fops = {
-	.read  = random_read,
+	.read = random_read,
 	.write = random_write,
-	.poll  = random_poll,
+	.poll = random_poll,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.fasync = random_fasync,
@@ -1902,7 +1892,7 @@ const struct file_operations random_fops = {
 };
 
 const struct file_operations urandom_fops = {
-	.read  = urandom_read,
+	.read = urandom_read,
 	.write = random_write,
 	.unlocked_ioctl = random_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
@@ -1910,19 +1900,19 @@ const struct file_operations urandom_fops = {
 	.llseek = noop_llseek,
 };
 
-SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
-		unsigned int, flags)
+SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count, unsigned int,
+		flags)
 {
 	int ret;
 
-	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM|GRND_INSECURE))
+	if (flags & ~(GRND_NONBLOCK | GRND_RANDOM | GRND_INSECURE))
 		return -EINVAL;
 
 	/*
 	 * Requesting insecure and blocking randomness at the same time makes
 	 * no sense.
 	 */
-	if ((flags & (GRND_INSECURE|GRND_RANDOM)) == (GRND_INSECURE|GRND_RANDOM))
+	if ((flags & (GRND_INSECURE | GRND_RANDOM)) == (GRND_INSECURE | GRND_RANDOM))
 		return -EINVAL;
 
 	if (count > INT_MAX)
@@ -1962,8 +1952,8 @@ static char sysctl_bootid[16];
  * returned as an ASCII string in the standard UUID format; if via the
  * sysctl system call, as 16 bytes of binary data.
  */
-static int proc_do_uuid(struct ctl_table *table, int write,
-			void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_do_uuid(struct ctl_table *table, int write, void *buffer,
+			size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table fake_table;
 	unsigned char buf[64], tmp_uuid[16], *uuid;
@@ -1992,8 +1982,8 @@ static int proc_do_uuid(struct ctl_table *table, int write,
 /*
  * Return entropy available scaled to integral bits
  */
-static int proc_do_entropy(struct ctl_table *table, int write,
-			   void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_do_entropy(struct ctl_table *table, int write, void *buffer,
+			   size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table fake_table;
 	int entropy_count;
@@ -2090,7 +2080,7 @@ struct batched_entropy {
  * point prior.
  */
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) = {
-	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
+	.batch_lock = __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
 };
 
 u64 get_random_u64(void)
@@ -2115,7 +2105,7 @@ u64 get_random_u64(void)
 EXPORT_SYMBOL(get_random_u64);
 
 static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) = {
-	.batch_lock	= __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
+	.batch_lock = __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
 };
 u32 get_random_u32(void)
 {
@@ -2176,8 +2166,7 @@ static void invalidate_batched_entropy(void)
  * Return: A page aligned address within [start, start + range).  On error,
  * @start is returned.
  */
-unsigned long
-randomize_page(unsigned long start, unsigned long range)
+unsigned long randomize_page(unsigned long start, unsigned long range)
 {
 	if (!PAGE_ALIGNED(start)) {
 		range -= PAGE_ALIGN(start) - start;
-- 
2.34.1

