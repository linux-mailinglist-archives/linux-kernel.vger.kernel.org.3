Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E669F5264DD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381398AbiEMOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380980AbiEMObq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:31:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887FB1B12CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D01FA621C6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3453C34116;
        Fri, 13 May 2022 14:29:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P+KlA1Xu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652452152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DHSCR7JojA9am5Am3S46p3wilJLdjEwEscTFyoAsl74=;
        b=P+KlA1XufzwcZwfv10Q1G+C2WJU0Hy/bQCdU6bXhwD9ObbPNnlUxuKbzapndMke6AZt/bx
        C45X+dstpKEvCWsrWFuQsWMrbrkbzZlWZ6M0HcmRXc1db8za0jTLD/crmSblLYeYNzsP3Z
        5kwvZimxlRlscD6+nZsTGXVa1AnRWxM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 292509fe (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 13 May 2022 14:29:11 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] random: move initialization functions out of hot pages
Date:   Fri, 13 May 2022 16:29:08 +0200
Message-Id: <20220513142908.341220-1-Jason@zx2c4.com>
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

Much of random.c is devoted to initializing the rng and accounting for
when a sufficient amount of entropy has been added. In a perfect world,
this would all happen during init, and so we could mark these functions
as __init. But in reality, this isn't the case: sometimes the rng only
finishes initializing some seconds after system init is finished.

For this reason, at the moment, a whole host of functions that are only
used relatively close to system init and then never again are intermixed
with functions that are used in hot code all the time. This creates more
cache misses than necessary.

In order to pack the hot code closer together, this commit moves the
initialization functions that can't be marked as __init into
.text.unlikely by way of the __cold attribute.

Of particular note is moving credit_init_bits() into a macro wrapper
that inlines the crng_ready() static branch check. This avoids a
function call to a nop+ret, and most notably prevents extra entropy
arithmetic from being computed in mix_interrupt_randomness().

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5e5f0c51e3b1..812070f4731d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -110,7 +110,7 @@ bool rng_is_initialized(void)
 }
 EXPORT_SYMBOL(rng_is_initialized);
 
-static void crng_set_ready(struct work_struct *work)
+static void __cold crng_set_ready(struct work_struct *work)
 {
 	static_branch_enable(&crng_is_ready);
 }
@@ -149,7 +149,7 @@ EXPORT_SYMBOL(wait_for_random_bytes);
  * returns: 0 if callback is successfully added
  *	    -EALREADY if pool is already initialised (callback not called)
  */
-int register_random_ready_notifier(struct notifier_block *nb)
+int __cold register_random_ready_notifier(struct notifier_block *nb)
 {
 	unsigned long flags;
 	int ret = -EALREADY;
@@ -167,7 +167,7 @@ int register_random_ready_notifier(struct notifier_block *nb)
 /*
  * Delete a previously registered readiness callback function.
  */
-int unregister_random_ready_notifier(struct notifier_block *nb)
+int __cold unregister_random_ready_notifier(struct notifier_block *nb)
 {
 	unsigned long flags;
 	int ret;
@@ -178,7 +178,7 @@ int unregister_random_ready_notifier(struct notifier_block *nb)
 	return ret;
 }
 
-static void process_random_ready_list(void)
+static void __cold process_random_ready_list(void)
 {
 	unsigned long flags;
 
@@ -190,7 +190,7 @@ static void process_random_ready_list(void)
 #define warn_unseeded_randomness() \
 	_warn_unseeded_randomness(__func__, (void *)_RET_IP_)
 
-static void _warn_unseeded_randomness(const char *func_name, void *caller)
+static void __cold _warn_unseeded_randomness(const char *func_name, void *caller)
 {
 	if (!IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM) || crng_ready())
 		return;
@@ -615,7 +615,7 @@ EXPORT_SYMBOL(get_random_u32);
  * This function is called when the CPU is coming up, with entry
  * CPUHP_RANDOM_PREPARE, which comes before CPUHP_WORKQUEUE_PREP.
  */
-int random_prepare_cpu(unsigned int cpu)
+int __cold random_prepare_cpu(unsigned int cpu)
 {
 	/*
 	 * When the cpu comes back online, immediately invalidate both
@@ -790,13 +790,15 @@ static void extract_entropy(void *buf, size_t len)
 	memzero_explicit(&block, sizeof(block));
 }
 
-static void credit_init_bits(size_t bits)
+#define credit_init_bits(bits) if (!crng_ready()) _credit_init_bits(bits)
+
+static void __cold _credit_init_bits(size_t bits)
 {
 	static struct execute_work set_ready;
 	unsigned int new, orig, add;
 	unsigned long flags;
 
-	if (crng_ready() || !bits)
+	if (!bits)
 		return;
 
 	add = min_t(size_t, bits, POOL_BITS);
@@ -1012,7 +1014,7 @@ EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
  * Handle random seed passed by bootloader, and credit it if
  * CONFIG_RANDOM_TRUST_BOOTLOADER is set.
  */
-void add_bootloader_randomness(const void *buf, size_t len)
+void __cold add_bootloader_randomness(const void *buf, size_t len)
 {
 	mix_pool_bytes(buf, len);
 	if (trust_bootloader)
@@ -1028,7 +1030,7 @@ static BLOCKING_NOTIFIER_HEAD(vmfork_chain);
  * don't credit it, but we do immediately force a reseed after so
  * that it's used by the crng posthaste.
  */
-void add_vmfork_randomness(const void *unique_vm_id, size_t len)
+void __cold add_vmfork_randomness(const void *unique_vm_id, size_t len)
 {
 	add_device_randomness(unique_vm_id, len);
 	if (crng_ready()) {
@@ -1041,13 +1043,13 @@ void add_vmfork_randomness(const void *unique_vm_id, size_t len)
 EXPORT_SYMBOL_GPL(add_vmfork_randomness);
 #endif
 
-int register_random_vmfork_notifier(struct notifier_block *nb)
+int __cold register_random_vmfork_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&vmfork_chain, nb);
 }
 EXPORT_SYMBOL_GPL(register_random_vmfork_notifier);
 
-int unregister_random_vmfork_notifier(struct notifier_block *nb)
+int __cold unregister_random_vmfork_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_unregister(&vmfork_chain, nb);
 }
@@ -1092,7 +1094,7 @@ static void fast_mix(unsigned long s[4], unsigned long v1, unsigned long v2)
  * This function is called when the CPU has just come online, with
  * entry CPUHP_AP_RANDOM_ONLINE, just after CPUHP_AP_WORKQUEUE_ONLINE.
  */
-int random_online_cpu(unsigned int cpu)
+int __cold random_online_cpu(unsigned int cpu)
 {
 	/*
 	 * During CPU shutdown and before CPU onlining, add_interrupt_
@@ -1249,7 +1251,7 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned int nu
 	if (in_hardirq())
 		this_cpu_ptr(&irq_randomness)->count += max(1u, bits * 64) - 1;
 	else
-		credit_init_bits(bits);
+		_credit_init_bits(bits);
 }
 
 void add_input_randomness(unsigned int type, unsigned int code, unsigned int value)
@@ -1277,7 +1279,7 @@ void add_disk_randomness(struct gendisk *disk)
 }
 EXPORT_SYMBOL_GPL(add_disk_randomness);
 
-void rand_initialize_disk(struct gendisk *disk)
+void __cold rand_initialize_disk(struct gendisk *disk)
 {
 	struct timer_rand_state *state;
 
@@ -1312,7 +1314,7 @@ struct entropy_timer_state {
  *
  * So the re-arming always happens in the entropy loop itself.
  */
-static void entropy_timer(struct timer_list *timer)
+static void __cold entropy_timer(struct timer_list *timer)
 {
 	struct entropy_timer_state *state = container_of(timer, struct entropy_timer_state, timer);
 
@@ -1326,7 +1328,7 @@ static void entropy_timer(struct timer_list *timer)
  * If we have an actual cycle counter, see if we can
  * generate enough entropy with timing noise
  */
-static void try_to_generate_entropy(void)
+static void __cold try_to_generate_entropy(void)
 {
 	enum { NUM_TRIAL_SAMPLES = 8192, MAX_SAMPLES_PER_BIT = 32 };
 	struct entropy_timer_state stack;
-- 
2.35.1

