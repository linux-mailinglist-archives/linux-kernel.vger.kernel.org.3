Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D3D4F30F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354441AbiDEKON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241165AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A3DEC2;
        Tue,  5 Apr 2022 01:29:02 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWHx7GuHvjFyiDGqiRNjT+EunpmHI0JLj3DkpOXDk64=;
        b=0gKa36INyHuRr03aHowy1T0MIgeFy7pjXD29Ff1HROw3xGRbd7ime0Fl3wX9113NW/ub+7
        2IjWgdzz6hUgtF/mNFjgU4dGdH+eZ+CyfNCohwC0d4zGNJbOmvLs3C/a9GZo7114wq3flu
        r5Q5jAWvFuZN3BXx4IPUgeRsctEDnPTZ06VIfsNImChNgVjYJEMJjBU1wcJnUKa219y4Px
        sh4KF4QJsgbu7S9HxHcapXbdU0PSloO7fdLxujZWpCiJ6WXllY559wW6P35Hs6EL68/wrZ
        KyjiZb8AM75Oso3xQ0BE5Eg/iJsVM7fDVTVrwHMzkpxrKbvXZNlwEgDh48IgSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWHx7GuHvjFyiDGqiRNjT+EunpmHI0JLj3DkpOXDk64=;
        b=SO91N5s8M99R7W/ux1JSg6saFfjFFTCLN1/EP4lCOoDHhfnlQHOTMIdlW5A0T82SzdM41y
        04w2+6tmQF3OaWDw==
From:   "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Don't make __static_call_return0 static
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C30821468a0e7d28251954b578e5051dc09300d04=2E16472?=
 =?utf-8?q?58493=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
References: =?utf-8?q?=3C30821468a0e7d28251954b578e5051dc09300d04=2E164725?=
 =?utf-8?q?8493=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
MIME-Version: 1.0
Message-ID: <164914733979.389.2930127244146772178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     8fd4ddda2f49a66bf5dd3d0c01966c4b1971308b
Gitweb:        https://git.kernel.org/tip/8fd4ddda2f49a66bf5dd3d0c01966c4b1971308b
Author:        Christophe Leroy <christophe.leroy@csgroup.eu>
AuthorDate:    Mon, 14 Mar 2022 12:49:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:38 +02:00

static_call: Don't make __static_call_return0 static

System.map shows that vmlinux contains several instances of
__static_call_return0():

	c0004fc0 t __static_call_return0
	c0011518 t __static_call_return0
	c00d8160 t __static_call_return0

arch_static_call_transform() uses the middle one to check whether we are
setting a call to __static_call_return0 or not:

	c0011520 <arch_static_call_transform>:
	c0011520:       3d 20 c0 01     lis     r9,-16383	<== r9 =  0xc001 << 16
	c0011524:       39 29 15 18     addi    r9,r9,5400	<== r9 += 0x1518
	c0011528:       7c 05 48 00     cmpw    r5,r9		<== r9 has value 0xc0011518 here

So if static_call_update() is called with one of the other instances of
__static_call_return0(), arch_static_call_transform() won't recognise it.

In order to work properly, global single instance of __static_call_return0() is required.

Fixes: 3f2a8fc4b15d ("static_call/x86: Add __static_call_return0()")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/30821468a0e7d28251954b578e5051dc09300d04.1647258493.git.christophe.leroy@csgroup.eu
---
 include/linux/static_call.h |   5 +-
 kernel/Makefile             |   3 +-
 kernel/static_call.c        | 541 +-----------------------------------
 kernel/static_call_inline.c | 543 +++++++++++++++++++++++++++++++++++-
 4 files changed, 546 insertions(+), 546 deletions(-)
 create mode 100644 kernel/static_call_inline.c

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 3e56a97..fcc5b48 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -248,10 +248,7 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
-static inline long __static_call_return0(void)
-{
-	return 0;
-}
+extern long __static_call_return0(void);
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
diff --git a/kernel/Makefile b/kernel/Makefile
index 471d719..847a82b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -114,7 +114,8 @@ obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
 obj-$(CONFIG_KCSAN) += kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
-obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
+obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
+obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
diff --git a/kernel/static_call.c b/kernel/static_call.c
index f2b8bae..e9c3e69 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -1,549 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
 #include <linux/static_call.h>
-#include <linux/bug.h>
-#include <linux/smp.h>
-#include <linux/sort.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/cpu.h>
-#include <linux/processor.h>
-#include <asm/sections.h>
-
-extern struct static_call_site __start_static_call_sites[],
-			       __stop_static_call_sites[];
-extern struct static_call_tramp_key __start_static_call_tramp_key[],
-				    __stop_static_call_tramp_key[];
-
-static bool static_call_initialized;
-
-/* mutex to protect key modules/sites */
-static DEFINE_MUTEX(static_call_mutex);
-
-static void static_call_lock(void)
-{
-	mutex_lock(&static_call_mutex);
-}
-
-static void static_call_unlock(void)
-{
-	mutex_unlock(&static_call_mutex);
-}
-
-static inline void *static_call_addr(struct static_call_site *site)
-{
-	return (void *)((long)site->addr + (long)&site->addr);
-}
-
-static inline unsigned long __static_call_key(const struct static_call_site *site)
-{
-	return (long)site->key + (long)&site->key;
-}
-
-static inline struct static_call_key *static_call_key(const struct static_call_site *site)
-{
-	return (void *)(__static_call_key(site) & ~STATIC_CALL_SITE_FLAGS);
-}
-
-/* These assume the key is word-aligned. */
-static inline bool static_call_is_init(struct static_call_site *site)
-{
-	return __static_call_key(site) & STATIC_CALL_SITE_INIT;
-}
-
-static inline bool static_call_is_tail(struct static_call_site *site)
-{
-	return __static_call_key(site) & STATIC_CALL_SITE_TAIL;
-}
-
-static inline void static_call_set_init(struct static_call_site *site)
-{
-	site->key = (__static_call_key(site) | STATIC_CALL_SITE_INIT) -
-		    (long)&site->key;
-}
-
-static int static_call_site_cmp(const void *_a, const void *_b)
-{
-	const struct static_call_site *a = _a;
-	const struct static_call_site *b = _b;
-	const struct static_call_key *key_a = static_call_key(a);
-	const struct static_call_key *key_b = static_call_key(b);
-
-	if (key_a < key_b)
-		return -1;
-
-	if (key_a > key_b)
-		return 1;
-
-	return 0;
-}
-
-static void static_call_site_swap(void *_a, void *_b, int size)
-{
-	long delta = (unsigned long)_a - (unsigned long)_b;
-	struct static_call_site *a = _a;
-	struct static_call_site *b = _b;
-	struct static_call_site tmp = *a;
-
-	a->addr = b->addr  - delta;
-	a->key  = b->key   - delta;
-
-	b->addr = tmp.addr + delta;
-	b->key  = tmp.key  + delta;
-}
-
-static inline void static_call_sort_entries(struct static_call_site *start,
-					    struct static_call_site *stop)
-{
-	sort(start, stop - start, sizeof(struct static_call_site),
-	     static_call_site_cmp, static_call_site_swap);
-}
-
-static inline bool static_call_key_has_mods(struct static_call_key *key)
-{
-	return !(key->type & 1);
-}
-
-static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
-{
-	if (!static_call_key_has_mods(key))
-		return NULL;
-
-	return key->mods;
-}
-
-static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
-{
-	if (static_call_key_has_mods(key))
-		return NULL;
-
-	return (struct static_call_site *)(key->type & ~1);
-}
-
-void __static_call_update(struct static_call_key *key, void *tramp, void *func)
-{
-	struct static_call_site *site, *stop;
-	struct static_call_mod *site_mod, first;
-
-	cpus_read_lock();
-	static_call_lock();
-
-	if (key->func == func)
-		goto done;
-
-	key->func = func;
-
-	arch_static_call_transform(NULL, tramp, func, false);
-
-	/*
-	 * If uninitialized, we'll not update the callsites, but they still
-	 * point to the trampoline and we just patched that.
-	 */
-	if (WARN_ON_ONCE(!static_call_initialized))
-		goto done;
-
-	first = (struct static_call_mod){
-		.next = static_call_key_next(key),
-		.mod = NULL,
-		.sites = static_call_key_sites(key),
-	};
-
-	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
-		bool init = system_state < SYSTEM_RUNNING;
-		struct module *mod = site_mod->mod;
-
-		if (!site_mod->sites) {
-			/*
-			 * This can happen if the static call key is defined in
-			 * a module which doesn't use it.
-			 *
-			 * It also happens in the has_mods case, where the
-			 * 'first' entry has no sites associated with it.
-			 */
-			continue;
-		}
-
-		stop = __stop_static_call_sites;
-
-		if (mod) {
-#ifdef CONFIG_MODULES
-			stop = mod->static_call_sites +
-			       mod->num_static_call_sites;
-			init = mod->state == MODULE_STATE_COMING;
-#endif
-		}
-
-		for (site = site_mod->sites;
-		     site < stop && static_call_key(site) == key; site++) {
-			void *site_addr = static_call_addr(site);
-
-			if (!init && static_call_is_init(site))
-				continue;
-
-			if (!kernel_text_address((unsigned long)site_addr)) {
-				/*
-				 * This skips patching built-in __exit, which
-				 * is part of init_section_contains() but is
-				 * not part of kernel_text_address().
-				 *
-				 * Skipping built-in __exit is fine since it
-				 * will never be executed.
-				 */
-				WARN_ONCE(!static_call_is_init(site),
-					  "can't patch static call site at %pS",
-					  site_addr);
-				continue;
-			}
-
-			arch_static_call_transform(site_addr, NULL, func,
-						   static_call_is_tail(site));
-		}
-	}
-
-done:
-	static_call_unlock();
-	cpus_read_unlock();
-}
-EXPORT_SYMBOL_GPL(__static_call_update);
-
-static int __static_call_init(struct module *mod,
-			      struct static_call_site *start,
-			      struct static_call_site *stop)
-{
-	struct static_call_site *site;
-	struct static_call_key *key, *prev_key = NULL;
-	struct static_call_mod *site_mod;
-
-	if (start == stop)
-		return 0;
-
-	static_call_sort_entries(start, stop);
-
-	for (site = start; site < stop; site++) {
-		void *site_addr = static_call_addr(site);
-
-		if ((mod && within_module_init((unsigned long)site_addr, mod)) ||
-		    (!mod && init_section_contains(site_addr, 1)))
-			static_call_set_init(site);
-
-		key = static_call_key(site);
-		if (key != prev_key) {
-			prev_key = key;
-
-			/*
-			 * For vmlinux (!mod) avoid the allocation by storing
-			 * the sites pointer in the key itself. Also see
-			 * __static_call_update()'s @first.
-			 *
-			 * This allows architectures (eg. x86) to call
-			 * static_call_init() before memory allocation works.
-			 */
-			if (!mod) {
-				key->sites = site;
-				key->type |= 1;
-				goto do_transform;
-			}
-
-			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
-			if (!site_mod)
-				return -ENOMEM;
-
-			/*
-			 * When the key has a direct sites pointer, extract
-			 * that into an explicit struct static_call_mod, so we
-			 * can have a list of modules.
-			 */
-			if (static_call_key_sites(key)) {
-				site_mod->mod = NULL;
-				site_mod->next = NULL;
-				site_mod->sites = static_call_key_sites(key);
-
-				key->mods = site_mod;
-
-				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
-				if (!site_mod)
-					return -ENOMEM;
-			}
-
-			site_mod->mod = mod;
-			site_mod->sites = site;
-			site_mod->next = static_call_key_next(key);
-			key->mods = site_mod;
-		}
-
-do_transform:
-		arch_static_call_transform(site_addr, NULL, key->func,
-				static_call_is_tail(site));
-	}
-
-	return 0;
-}
-
-static int addr_conflict(struct static_call_site *site, void *start, void *end)
-{
-	unsigned long addr = (unsigned long)static_call_addr(site);
-
-	if (addr <= (unsigned long)end &&
-	    addr + CALL_INSN_SIZE > (unsigned long)start)
-		return 1;
-
-	return 0;
-}
-
-static int __static_call_text_reserved(struct static_call_site *iter_start,
-				       struct static_call_site *iter_stop,
-				       void *start, void *end, bool init)
-{
-	struct static_call_site *iter = iter_start;
-
-	while (iter < iter_stop) {
-		if (init || !static_call_is_init(iter)) {
-			if (addr_conflict(iter, start, end))
-				return 1;
-		}
-		iter++;
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_MODULES
-
-static int __static_call_mod_text_reserved(void *start, void *end)
-{
-	struct module *mod;
-	int ret;
-
-	preempt_disable();
-	mod = __module_text_address((unsigned long)start);
-	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
-	if (!try_module_get(mod))
-		mod = NULL;
-	preempt_enable();
-
-	if (!mod)
-		return 0;
-
-	ret = __static_call_text_reserved(mod->static_call_sites,
-			mod->static_call_sites + mod->num_static_call_sites,
-			start, end, mod->state == MODULE_STATE_COMING);
-
-	module_put(mod);
-
-	return ret;
-}
-
-static unsigned long tramp_key_lookup(unsigned long addr)
-{
-	struct static_call_tramp_key *start = __start_static_call_tramp_key;
-	struct static_call_tramp_key *stop = __stop_static_call_tramp_key;
-	struct static_call_tramp_key *tramp_key;
-
-	for (tramp_key = start; tramp_key != stop; tramp_key++) {
-		unsigned long tramp;
-
-		tramp = (long)tramp_key->tramp + (long)&tramp_key->tramp;
-		if (tramp == addr)
-			return (long)tramp_key->key + (long)&tramp_key->key;
-	}
-
-	return 0;
-}
-
-static int static_call_add_module(struct module *mod)
-{
-	struct static_call_site *start = mod->static_call_sites;
-	struct static_call_site *stop = start + mod->num_static_call_sites;
-	struct static_call_site *site;
-
-	for (site = start; site != stop; site++) {
-		unsigned long s_key = __static_call_key(site);
-		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
-		unsigned long key;
-
-		/*
-		 * Is the key is exported, 'addr' points to the key, which
-		 * means modules are allowed to call static_call_update() on
-		 * it.
-		 *
-		 * Otherwise, the key isn't exported, and 'addr' points to the
-		 * trampoline so we need to lookup the key.
-		 *
-		 * We go through this dance to prevent crazy modules from
-		 * abusing sensitive static calls.
-		 */
-		if (!kernel_text_address(addr))
-			continue;
-
-		key = tramp_key_lookup(addr);
-		if (!key) {
-			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
-				static_call_addr(site));
-			return -EINVAL;
-		}
-
-		key |= s_key & STATIC_CALL_SITE_FLAGS;
-		site->key = key - (long)&site->key;
-	}
-
-	return __static_call_init(mod, start, stop);
-}
-
-static void static_call_del_module(struct module *mod)
-{
-	struct static_call_site *start = mod->static_call_sites;
-	struct static_call_site *stop = mod->static_call_sites +
-					mod->num_static_call_sites;
-	struct static_call_key *key, *prev_key = NULL;
-	struct static_call_mod *site_mod, **prev;
-	struct static_call_site *site;
-
-	for (site = start; site < stop; site++) {
-		key = static_call_key(site);
-		if (key == prev_key)
-			continue;
-
-		prev_key = key;
-
-		for (prev = &key->mods, site_mod = key->mods;
-		     site_mod && site_mod->mod != mod;
-		     prev = &site_mod->next, site_mod = site_mod->next)
-			;
-
-		if (!site_mod)
-			continue;
-
-		*prev = site_mod->next;
-		kfree(site_mod);
-	}
-}
-
-static int static_call_module_notify(struct notifier_block *nb,
-				     unsigned long val, void *data)
-{
-	struct module *mod = data;
-	int ret = 0;
-
-	cpus_read_lock();
-	static_call_lock();
-
-	switch (val) {
-	case MODULE_STATE_COMING:
-		ret = static_call_add_module(mod);
-		if (ret) {
-			WARN(1, "Failed to allocate memory for static calls");
-			static_call_del_module(mod);
-		}
-		break;
-	case MODULE_STATE_GOING:
-		static_call_del_module(mod);
-		break;
-	}
-
-	static_call_unlock();
-	cpus_read_unlock();
-
-	return notifier_from_errno(ret);
-}
-
-static struct notifier_block static_call_module_nb = {
-	.notifier_call = static_call_module_notify,
-};
-
-#else
-
-static inline int __static_call_mod_text_reserved(void *start, void *end)
-{
-	return 0;
-}
-
-#endif /* CONFIG_MODULES */
-
-int static_call_text_reserved(void *start, void *end)
-{
-	bool init = system_state < SYSTEM_RUNNING;
-	int ret = __static_call_text_reserved(__start_static_call_sites,
-			__stop_static_call_sites, start, end, init);
-
-	if (ret)
-		return ret;
-
-	return __static_call_mod_text_reserved(start, end);
-}
-
-int __init static_call_init(void)
-{
-	int ret;
-
-	if (static_call_initialized)
-		return 0;
-
-	cpus_read_lock();
-	static_call_lock();
-	ret = __static_call_init(NULL, __start_static_call_sites,
-				 __stop_static_call_sites);
-	static_call_unlock();
-	cpus_read_unlock();
-
-	if (ret) {
-		pr_err("Failed to allocate memory for static_call!\n");
-		BUG();
-	}
-
-	static_call_initialized = true;
-
-#ifdef CONFIG_MODULES
-	register_module_notifier(&static_call_module_nb);
-#endif
-	return 0;
-}
-early_initcall(static_call_init);
 
 long __static_call_return0(void)
 {
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__static_call_return0);
-
-#ifdef CONFIG_STATIC_CALL_SELFTEST
-
-static int func_a(int x)
-{
-	return x+1;
-}
-
-static int func_b(int x)
-{
-	return x+2;
-}
-
-DEFINE_STATIC_CALL(sc_selftest, func_a);
-
-static struct static_call_data {
-      int (*func)(int);
-      int val;
-      int expect;
-} static_call_data [] __initdata = {
-      { NULL,   2, 3 },
-      { func_b, 2, 4 },
-      { func_a, 2, 3 }
-};
-
-static int __init test_static_call_init(void)
-{
-      int i;
-
-      for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
-	      struct static_call_data *scd = &static_call_data[i];
-
-              if (scd->func)
-                      static_call_update(sc_selftest, scd->func);
-
-              WARN_ON(static_call(sc_selftest)(scd->val) != scd->expect);
-      }
-
-      return 0;
-}
-early_initcall(test_static_call_init);
-
-#endif /* CONFIG_STATIC_CALL_SELFTEST */
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
new file mode 100644
index 0000000..dc5665b
--- /dev/null
+++ b/kernel/static_call_inline.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/static_call.h>
+#include <linux/bug.h>
+#include <linux/smp.h>
+#include <linux/sort.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/processor.h>
+#include <asm/sections.h>
+
+extern struct static_call_site __start_static_call_sites[],
+			       __stop_static_call_sites[];
+extern struct static_call_tramp_key __start_static_call_tramp_key[],
+				    __stop_static_call_tramp_key[];
+
+static bool static_call_initialized;
+
+/* mutex to protect key modules/sites */
+static DEFINE_MUTEX(static_call_mutex);
+
+static void static_call_lock(void)
+{
+	mutex_lock(&static_call_mutex);
+}
+
+static void static_call_unlock(void)
+{
+	mutex_unlock(&static_call_mutex);
+}
+
+static inline void *static_call_addr(struct static_call_site *site)
+{
+	return (void *)((long)site->addr + (long)&site->addr);
+}
+
+static inline unsigned long __static_call_key(const struct static_call_site *site)
+{
+	return (long)site->key + (long)&site->key;
+}
+
+static inline struct static_call_key *static_call_key(const struct static_call_site *site)
+{
+	return (void *)(__static_call_key(site) & ~STATIC_CALL_SITE_FLAGS);
+}
+
+/* These assume the key is word-aligned. */
+static inline bool static_call_is_init(struct static_call_site *site)
+{
+	return __static_call_key(site) & STATIC_CALL_SITE_INIT;
+}
+
+static inline bool static_call_is_tail(struct static_call_site *site)
+{
+	return __static_call_key(site) & STATIC_CALL_SITE_TAIL;
+}
+
+static inline void static_call_set_init(struct static_call_site *site)
+{
+	site->key = (__static_call_key(site) | STATIC_CALL_SITE_INIT) -
+		    (long)&site->key;
+}
+
+static int static_call_site_cmp(const void *_a, const void *_b)
+{
+	const struct static_call_site *a = _a;
+	const struct static_call_site *b = _b;
+	const struct static_call_key *key_a = static_call_key(a);
+	const struct static_call_key *key_b = static_call_key(b);
+
+	if (key_a < key_b)
+		return -1;
+
+	if (key_a > key_b)
+		return 1;
+
+	return 0;
+}
+
+static void static_call_site_swap(void *_a, void *_b, int size)
+{
+	long delta = (unsigned long)_a - (unsigned long)_b;
+	struct static_call_site *a = _a;
+	struct static_call_site *b = _b;
+	struct static_call_site tmp = *a;
+
+	a->addr = b->addr  - delta;
+	a->key  = b->key   - delta;
+
+	b->addr = tmp.addr + delta;
+	b->key  = tmp.key  + delta;
+}
+
+static inline void static_call_sort_entries(struct static_call_site *start,
+					    struct static_call_site *stop)
+{
+	sort(start, stop - start, sizeof(struct static_call_site),
+	     static_call_site_cmp, static_call_site_swap);
+}
+
+static inline bool static_call_key_has_mods(struct static_call_key *key)
+{
+	return !(key->type & 1);
+}
+
+static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
+{
+	if (!static_call_key_has_mods(key))
+		return NULL;
+
+	return key->mods;
+}
+
+static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
+{
+	if (static_call_key_has_mods(key))
+		return NULL;
+
+	return (struct static_call_site *)(key->type & ~1);
+}
+
+void __static_call_update(struct static_call_key *key, void *tramp, void *func)
+{
+	struct static_call_site *site, *stop;
+	struct static_call_mod *site_mod, first;
+
+	cpus_read_lock();
+	static_call_lock();
+
+	if (key->func == func)
+		goto done;
+
+	key->func = func;
+
+	arch_static_call_transform(NULL, tramp, func, false);
+
+	/*
+	 * If uninitialized, we'll not update the callsites, but they still
+	 * point to the trampoline and we just patched that.
+	 */
+	if (WARN_ON_ONCE(!static_call_initialized))
+		goto done;
+
+	first = (struct static_call_mod){
+		.next = static_call_key_next(key),
+		.mod = NULL,
+		.sites = static_call_key_sites(key),
+	};
+
+	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
+		bool init = system_state < SYSTEM_RUNNING;
+		struct module *mod = site_mod->mod;
+
+		if (!site_mod->sites) {
+			/*
+			 * This can happen if the static call key is defined in
+			 * a module which doesn't use it.
+			 *
+			 * It also happens in the has_mods case, where the
+			 * 'first' entry has no sites associated with it.
+			 */
+			continue;
+		}
+
+		stop = __stop_static_call_sites;
+
+		if (mod) {
+#ifdef CONFIG_MODULES
+			stop = mod->static_call_sites +
+			       mod->num_static_call_sites;
+			init = mod->state == MODULE_STATE_COMING;
+#endif
+		}
+
+		for (site = site_mod->sites;
+		     site < stop && static_call_key(site) == key; site++) {
+			void *site_addr = static_call_addr(site);
+
+			if (!init && static_call_is_init(site))
+				continue;
+
+			if (!kernel_text_address((unsigned long)site_addr)) {
+				/*
+				 * This skips patching built-in __exit, which
+				 * is part of init_section_contains() but is
+				 * not part of kernel_text_address().
+				 *
+				 * Skipping built-in __exit is fine since it
+				 * will never be executed.
+				 */
+				WARN_ONCE(!static_call_is_init(site),
+					  "can't patch static call site at %pS",
+					  site_addr);
+				continue;
+			}
+
+			arch_static_call_transform(site_addr, NULL, func,
+						   static_call_is_tail(site));
+		}
+	}
+
+done:
+	static_call_unlock();
+	cpus_read_unlock();
+}
+EXPORT_SYMBOL_GPL(__static_call_update);
+
+static int __static_call_init(struct module *mod,
+			      struct static_call_site *start,
+			      struct static_call_site *stop)
+{
+	struct static_call_site *site;
+	struct static_call_key *key, *prev_key = NULL;
+	struct static_call_mod *site_mod;
+
+	if (start == stop)
+		return 0;
+
+	static_call_sort_entries(start, stop);
+
+	for (site = start; site < stop; site++) {
+		void *site_addr = static_call_addr(site);
+
+		if ((mod && within_module_init((unsigned long)site_addr, mod)) ||
+		    (!mod && init_section_contains(site_addr, 1)))
+			static_call_set_init(site);
+
+		key = static_call_key(site);
+		if (key != prev_key) {
+			prev_key = key;
+
+			/*
+			 * For vmlinux (!mod) avoid the allocation by storing
+			 * the sites pointer in the key itself. Also see
+			 * __static_call_update()'s @first.
+			 *
+			 * This allows architectures (eg. x86) to call
+			 * static_call_init() before memory allocation works.
+			 */
+			if (!mod) {
+				key->sites = site;
+				key->type |= 1;
+				goto do_transform;
+			}
+
+			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+			if (!site_mod)
+				return -ENOMEM;
+
+			/*
+			 * When the key has a direct sites pointer, extract
+			 * that into an explicit struct static_call_mod, so we
+			 * can have a list of modules.
+			 */
+			if (static_call_key_sites(key)) {
+				site_mod->mod = NULL;
+				site_mod->next = NULL;
+				site_mod->sites = static_call_key_sites(key);
+
+				key->mods = site_mod;
+
+				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+				if (!site_mod)
+					return -ENOMEM;
+			}
+
+			site_mod->mod = mod;
+			site_mod->sites = site;
+			site_mod->next = static_call_key_next(key);
+			key->mods = site_mod;
+		}
+
+do_transform:
+		arch_static_call_transform(site_addr, NULL, key->func,
+				static_call_is_tail(site));
+	}
+
+	return 0;
+}
+
+static int addr_conflict(struct static_call_site *site, void *start, void *end)
+{
+	unsigned long addr = (unsigned long)static_call_addr(site);
+
+	if (addr <= (unsigned long)end &&
+	    addr + CALL_INSN_SIZE > (unsigned long)start)
+		return 1;
+
+	return 0;
+}
+
+static int __static_call_text_reserved(struct static_call_site *iter_start,
+				       struct static_call_site *iter_stop,
+				       void *start, void *end, bool init)
+{
+	struct static_call_site *iter = iter_start;
+
+	while (iter < iter_stop) {
+		if (init || !static_call_is_init(iter)) {
+			if (addr_conflict(iter, start, end))
+				return 1;
+		}
+		iter++;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_MODULES
+
+static int __static_call_mod_text_reserved(void *start, void *end)
+{
+	struct module *mod;
+	int ret;
+
+	preempt_disable();
+	mod = __module_text_address((unsigned long)start);
+	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
+	if (!try_module_get(mod))
+		mod = NULL;
+	preempt_enable();
+
+	if (!mod)
+		return 0;
+
+	ret = __static_call_text_reserved(mod->static_call_sites,
+			mod->static_call_sites + mod->num_static_call_sites,
+			start, end, mod->state == MODULE_STATE_COMING);
+
+	module_put(mod);
+
+	return ret;
+}
+
+static unsigned long tramp_key_lookup(unsigned long addr)
+{
+	struct static_call_tramp_key *start = __start_static_call_tramp_key;
+	struct static_call_tramp_key *stop = __stop_static_call_tramp_key;
+	struct static_call_tramp_key *tramp_key;
+
+	for (tramp_key = start; tramp_key != stop; tramp_key++) {
+		unsigned long tramp;
+
+		tramp = (long)tramp_key->tramp + (long)&tramp_key->tramp;
+		if (tramp == addr)
+			return (long)tramp_key->key + (long)&tramp_key->key;
+	}
+
+	return 0;
+}
+
+static int static_call_add_module(struct module *mod)
+{
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = start + mod->num_static_call_sites;
+	struct static_call_site *site;
+
+	for (site = start; site != stop; site++) {
+		unsigned long s_key = __static_call_key(site);
+		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
+		unsigned long key;
+
+		/*
+		 * Is the key is exported, 'addr' points to the key, which
+		 * means modules are allowed to call static_call_update() on
+		 * it.
+		 *
+		 * Otherwise, the key isn't exported, and 'addr' points to the
+		 * trampoline so we need to lookup the key.
+		 *
+		 * We go through this dance to prevent crazy modules from
+		 * abusing sensitive static calls.
+		 */
+		if (!kernel_text_address(addr))
+			continue;
+
+		key = tramp_key_lookup(addr);
+		if (!key) {
+			pr_warn("Failed to fixup __raw_static_call() usage at: %ps\n",
+				static_call_addr(site));
+			return -EINVAL;
+		}
+
+		key |= s_key & STATIC_CALL_SITE_FLAGS;
+		site->key = key - (long)&site->key;
+	}
+
+	return __static_call_init(mod, start, stop);
+}
+
+static void static_call_del_module(struct module *mod)
+{
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = mod->static_call_sites +
+					mod->num_static_call_sites;
+	struct static_call_key *key, *prev_key = NULL;
+	struct static_call_mod *site_mod, **prev;
+	struct static_call_site *site;
+
+	for (site = start; site < stop; site++) {
+		key = static_call_key(site);
+		if (key == prev_key)
+			continue;
+
+		prev_key = key;
+
+		for (prev = &key->mods, site_mod = key->mods;
+		     site_mod && site_mod->mod != mod;
+		     prev = &site_mod->next, site_mod = site_mod->next)
+			;
+
+		if (!site_mod)
+			continue;
+
+		*prev = site_mod->next;
+		kfree(site_mod);
+	}
+}
+
+static int static_call_module_notify(struct notifier_block *nb,
+				     unsigned long val, void *data)
+{
+	struct module *mod = data;
+	int ret = 0;
+
+	cpus_read_lock();
+	static_call_lock();
+
+	switch (val) {
+	case MODULE_STATE_COMING:
+		ret = static_call_add_module(mod);
+		if (ret) {
+			WARN(1, "Failed to allocate memory for static calls");
+			static_call_del_module(mod);
+		}
+		break;
+	case MODULE_STATE_GOING:
+		static_call_del_module(mod);
+		break;
+	}
+
+	static_call_unlock();
+	cpus_read_unlock();
+
+	return notifier_from_errno(ret);
+}
+
+static struct notifier_block static_call_module_nb = {
+	.notifier_call = static_call_module_notify,
+};
+
+#else
+
+static inline int __static_call_mod_text_reserved(void *start, void *end)
+{
+	return 0;
+}
+
+#endif /* CONFIG_MODULES */
+
+int static_call_text_reserved(void *start, void *end)
+{
+	bool init = system_state < SYSTEM_RUNNING;
+	int ret = __static_call_text_reserved(__start_static_call_sites,
+			__stop_static_call_sites, start, end, init);
+
+	if (ret)
+		return ret;
+
+	return __static_call_mod_text_reserved(start, end);
+}
+
+int __init static_call_init(void)
+{
+	int ret;
+
+	if (static_call_initialized)
+		return 0;
+
+	cpus_read_lock();
+	static_call_lock();
+	ret = __static_call_init(NULL, __start_static_call_sites,
+				 __stop_static_call_sites);
+	static_call_unlock();
+	cpus_read_unlock();
+
+	if (ret) {
+		pr_err("Failed to allocate memory for static_call!\n");
+		BUG();
+	}
+
+	static_call_initialized = true;
+
+#ifdef CONFIG_MODULES
+	register_module_notifier(&static_call_module_nb);
+#endif
+	return 0;
+}
+early_initcall(static_call_init);
+
+#ifdef CONFIG_STATIC_CALL_SELFTEST
+
+static int func_a(int x)
+{
+	return x+1;
+}
+
+static int func_b(int x)
+{
+	return x+2;
+}
+
+DEFINE_STATIC_CALL(sc_selftest, func_a);
+
+static struct static_call_data {
+      int (*func)(int);
+      int val;
+      int expect;
+} static_call_data [] __initdata = {
+      { NULL,   2, 3 },
+      { func_b, 2, 4 },
+      { func_a, 2, 3 }
+};
+
+static int __init test_static_call_init(void)
+{
+      int i;
+
+      for (i = 0; i < ARRAY_SIZE(static_call_data); i++ ) {
+	      struct static_call_data *scd = &static_call_data[i];
+
+              if (scd->func)
+                      static_call_update(sc_selftest, scd->func);
+
+              WARN_ON(static_call(sc_selftest)(scd->val) != scd->expect);
+      }
+
+      return 0;
+}
+early_initcall(test_static_call_init);
+
+#endif /* CONFIG_STATIC_CALL_SELFTEST */
