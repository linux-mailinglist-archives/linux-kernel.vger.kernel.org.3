Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD15577249
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiGPXTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiGPXSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2E223BEC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:06 -0700 (PDT)
Message-ID: <20220716230954.651974187@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ClwOwqNEOMfbSYwIuxbNweOtgmvdarLY2d+mT83kdoA=;
        b=V+I/80uZtQGL80itUgyEvjUXgke6eWnrtjG5YhyYrrw/OL831hP4h6F0R0VVw969bTLl95
        mKdVmE34l4evnFyOlueBgCd5YYefTihzZr+cql2sXCrQyDOvnYg3W++x9MJx4ufo79xe2Q
        E2Xqu5D6iweziFoVulfOqpwoH5sklvnuMJcisCQlWSvt1LHlNqsO/od7bGwe5aaoj+0+aq
        ZNz6hW33p3mzhBx6FPdpcf6ZQ/bXlnYgKlTNLL/j2MoZnvH7on0hGetbct3tAXDl9n/3Rg
        6bgLXuWJR83S0WDQfakVukzalGQBoFHXXXmaaSpMSnE8VI930VE1YrLpd5UMNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ClwOwqNEOMfbSYwIuxbNweOtgmvdarLY2d+mT83kdoA=;
        b=MGpaN4YaztpvyGHR5iqeV1A3YllhUw4g0wMH9rWNV5tG+IqpslOR4DZi3h7KwRDs16CCHS
        FkazDGMYwYwiC7Bw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [patch 33/38] kallsyms: Take callthunks into account
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:18:03 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Similar to ftrace and bpf call thunks are creating symbols which are
interesting for things like printing stack-traces, perf, live-patching
and things like that.

Add the required functionality to the core and implement it in x86.

Callthunks will report the same function name as their target, but
their module name will be "callthunk" or "callthunk:${modname}" for
modules.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/callthunks.c |  155 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/kallsyms.h     |   24 ++++++
 kernel/kallsyms.c            |   23 ++++++
 3 files changed, 202 insertions(+)

--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -4,6 +4,7 @@
 
 #include <linux/btree.h>
 #include <linux/debugfs.h>
+#include <linux/kallsyms.h>
 #include <linux/memory.h>
 #include <linux/moduleloader.h>
 #include <linux/set_memory.h>
@@ -548,6 +549,160 @@ void *callthunks_translate_call_dest(voi
 	return dest;
 }
 
+static bool is_module_callthunk(void *addr)
+{
+	bool ret = false;
+
+#ifdef CONFIG_MODULES
+	struct module *mod;
+
+	preempt_disable();
+	mod = __module_address((unsigned long)addr);
+	if (mod && within_module_thunk((unsigned long)addr, mod))
+		ret = true;
+	preempt_enable();
+#endif
+	return ret;
+}
+
+static bool is_callthunk(void *addr)
+{
+	if (builtin_layout.base <= addr &&
+	    addr < builtin_layout.base + builtin_layout.size)
+		return true;
+	return is_module_callthunk(addr);
+}
+
+static void *__callthunk_dest(void *addr)
+{
+	unsigned long mask = callthunk_desc.thunk_size - 1;
+	void *thunk;
+
+	thunk = (void *)((unsigned long)addr & ~mask);
+	thunk += callthunk_desc.template_size;
+	return jump_get_dest(thunk);
+}
+
+static void *callthunk_dest(void *addr)
+{
+	if (!is_callthunk(addr))
+		return NULL;
+	return __callthunk_dest(addr);
+}
+
+static void set_modname(char **modname, unsigned long addr)
+{
+	if (!modname || !IS_ENABLED(CONFIG_MODULES))
+		*modname = "callthunk";
+
+#ifdef CONFIG_MODULES
+	else {
+		struct module * mod;
+
+		preempt_disable();
+		mod = __module_address(addr);
+		*modname = mod->callthunk_name;
+		preempt_enable();
+	}
+#endif
+}
+
+const char *
+callthunk_address_lookup(unsigned long addr, unsigned long *size,
+			 unsigned long *off, char **modname, char *sym)
+{
+	unsigned long dest, mask = callthunk_desc.thunk_size - 1;
+	const char *ret;
+
+	if (!thunks_initialized)
+		return NULL;
+
+	dest = (unsigned long)callthunk_dest((void *)addr);
+	if (!dest)
+		return NULL;
+
+	ret = kallsyms_lookup(dest, size, off, modname, sym);
+	if (!ret)
+		return NULL;
+
+	*off = addr & mask;
+	*size = callthunk_desc.thunk_size;
+
+	set_modname(modname, addr);
+	return ret;
+}
+
+static int get_module_thunk(char **modname, struct module_layout **layoutp,
+			    unsigned int symthunk)
+{
+#ifdef CONFIG_MODULES
+	extern struct list_head modules;
+	struct module *mod;
+	unsigned int size;
+
+	symthunk -= (*layoutp)->text_size;
+	list_for_each_entry_rcu(mod, &modules, list) {
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+
+		*layoutp = &mod->thunk_layout;
+		size = mod->thunk_layout.text_size;
+
+		if (symthunk >= size) {
+			symthunk -= size;
+			continue;
+		}
+		*modname = mod->callthunk_name;
+		return symthunk;
+	}
+#endif
+	return -ERANGE;
+}
+
+int callthunk_get_kallsym(unsigned int symnum, unsigned long *value,
+			  char *type, char *name, char *module_name,
+			  int *exported)
+{
+	int symthunk = symnum * callthunk_desc.thunk_size;
+	struct module_layout *layout = &builtin_layout;
+	char *modname = "callthunk";
+	void *thunk, *dest;
+	int ret = -ERANGE;
+
+	if (!thunks_initialized)
+		return -ERANGE;
+
+	preempt_disable();
+
+	if (symthunk >= layout->text_size) {
+		symthunk = get_module_thunk(&modname, &layout, symthunk);
+		if (symthunk < 0)
+			goto out;
+	}
+
+	thunk = layout->base + symthunk;
+	dest = __callthunk_dest(thunk);
+
+	if (!dest) {
+		strlcpy(name, "(unknown callthunk)", KSYM_NAME_LEN);
+		ret = 0;
+		goto out;
+	}
+
+	ret = lookup_symbol_name((unsigned long)dest, name);
+	if (ret)
+		goto out;
+
+	*value = (unsigned long)thunk;
+	*exported = 0;
+	*type = 't';
+	strlcpy(module_name, modname, MODULE_NAME_LEN);
+
+out:
+	preempt_enable();
+	return ret;
+}
+
 #ifdef CONFIG_MODULES
 void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
 					    struct module *mod)
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -65,6 +65,30 @@ static inline void *dereference_symbol_d
 	return ptr;
 }
 
+#ifdef CONFIG_CALL_THUNKS
+extern const char *
+callthunk_address_lookup(unsigned long addr, unsigned long *size,
+			 unsigned long *off, char **modname, char *sym);
+extern int callthunk_get_kallsym(unsigned int symnum, unsigned long *value,
+				 char *type, char *name, char *module_name,
+				 int *exported);
+#else
+static inline const char *
+callthunk_address_lookup(unsigned long addr, unsigned long *size,
+			 unsigned long *off, char **modname, char *sym)
+{
+	return NULL;
+}
+
+static inline
+int callthunk_get_kallsym(unsigned int symnum, unsigned long *value,
+			  char *type, char *name, char *module_name,
+			  int *exported)
+{
+	return -1;
+}
+#endif
+
 #ifdef CONFIG_KALLSYMS
 int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 				      unsigned long),
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -365,6 +365,10 @@ static const char *kallsyms_lookup_build
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
 						offset, modname, namebuf);
 
+	if (!ret)
+		ret = callthunk_address_lookup(addr, symbolsize,
+					       offset, modname, namebuf);
+
 found:
 	cleanup_symbol_name(namebuf);
 	return ret;
@@ -578,6 +582,7 @@ struct kallsym_iter {
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
 	loff_t pos_bpf_end;
+	loff_t pos_callthunk_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
 	char type;
@@ -657,6 +662,20 @@ static int get_ksymbol_bpf(struct kallsy
 	return 1;
 }
 
+static int get_ksymbol_callthunk(struct kallsym_iter *iter)
+{
+	int ret = callthunk_get_kallsym(iter->pos - iter->pos_bpf_end,
+					&iter->value, &iter->type,
+					iter->name, iter->module_name,
+					&iter->exported);
+	if (ret < 0) {
+		iter->pos_callthunk_end = iter->pos;
+		return 0;
+	}
+
+	return 1;
+}
+
 /*
  * This uses "__builtin__kprobes" as a module name for symbols for pages
  * allocated for kprobes' purposes, even though "__builtin__kprobes" is not a
@@ -724,6 +743,10 @@ static int update_iter_mod(struct kallsy
 	    get_ksymbol_bpf(iter))
 		return 1;
 
+	if ((!iter->pos_callthunk_end || iter->pos_callthunk_end > pos) &&
+	    get_ksymbol_callthunk(iter))
+		return 1;
+
 	return get_ksymbol_kprobe(iter);
 }
 

