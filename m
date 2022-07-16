Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A757724D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiGPXTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiGPXSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A67722521
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:04 -0700 (PDT)
Message-ID: <20220716230954.531875572@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=n/x/B8Fp0Zw1KyBer7r29adRRpTb/pJqU9PpL7Cx/VI=;
        b=g6C2o++/uTV7cr+0ZZ3+X1pSHMQ2ov/nbYmTaNVTZv4NIDNY06tWRjhHe/vxoNFqyIkG9m
        g1f8CeJ+s1qahgOsdMWCeKVL6EIulZsQOe3UjCZt/lXDhJu3wLQjUyKea311cq4gr+rzhu
        PWMYJ9pmKHjmZeLGogOyU+E5DoFfsnsDK7B+svxQybkm5W1hsrM6gXUNzQSGZ1Ab9+2a29
        0qgy3MaQfU+zBJsXUlIRifGRIs5A4T/HB5B8x4GtRG/ORkjC6G6uoFIh+A1QruVmLz0C0o
        lb6Guz2hXMA1vL6wvH0BJ3UHdT0mMwcRc6kWBS+/hQL3eGKc43MXt8JQv1Y4gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=n/x/B8Fp0Zw1KyBer7r29adRRpTb/pJqU9PpL7Cx/VI=;
        b=QugiXolVRHGq7pGLiEqOkpR+DA+aFx3u/3BOdtTSeNFGzi1ZSLd4Ohbi5miisZ+aEZOxIG
        NtxWMyuULqud9wCQ==
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
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 31/38] x86/calldepth: Add ret/call counting for debug
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:18:00 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debuigfs mechanism to validate the accounting, e.g. vs. call/ret
balance and to gather statistics about the stuffing to call ratio.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/nospec-branch.h |   32 +++++++++++++++++++--
 arch/x86/kernel/callthunks.c         |   51 +++++++++++++++++++++++++++++++++++
 arch/x86/lib/retpoline.S             |    7 ++++
 3 files changed, 86 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -77,6 +77,23 @@
  */
 
 #ifdef CONFIG_CALL_DEPTH_TRACKING
+
+#ifdef CONFIG_CALL_THUNKS_DEBUG
+# define CALL_THUNKS_DEBUG_INC_CALLS				\
+	incq	%gs:__x86_call_count;
+# define CALL_THUNKS_DEBUG_INC_RETS				\
+	incq	%gs:__x86_ret_count;
+# define CALL_THUNKS_DEBUG_INC_STUFFS				\
+	incq	%gs:__x86_stuffs_count;
+# define CALL_THUNKS_DEBUG_INC_CTXSW				\
+	incq	%gs:__x86_ctxsw_count;
+#else
+# define CALL_THUNKS_DEBUG_INC_CALLS
+# define CALL_THUNKS_DEBUG_INC_RETS
+# define CALL_THUNKS_DEBUG_INC_STUFFS
+# define CALL_THUNKS_DEBUG_INC_CTXSW
+#endif
+
 #define CREDIT_CALL_DEPTH					\
 	movq	$-1, PER_CPU_VAR(__x86_call_depth);
 
@@ -88,10 +105,12 @@
 #define RESET_CALL_DEPTH_FROM_CALL				\
 	mov	$0xfc, %rax;					\
 	shl	$56, %rax;					\
-	movq	%rax, PER_CPU_VAR(__x86_call_depth);
+	movq	%rax, PER_CPU_VAR(__x86_call_depth);		\
+	CALL_THUNKS_DEBUG_INC_CALLS
 
 #define INCREMENT_CALL_DEPTH					\
-	sarq	$5, %gs:__x86_call_depth
+	sarq	$5, %gs:__x86_call_depth;			\
+	CALL_THUNKS_DEBUG_INC_CALLS
 #else
 #define CREDIT_CALL_DEPTH
 #define RESET_CALL_DEPTH
@@ -127,7 +146,8 @@
 	dec	reg;				\
 	jnz	771b;				\
 						\
-	CREDIT_CALL_DEPTH
+	CREDIT_CALL_DEPTH			\
+	CALL_THUNKS_DEBUG_INC_CTXSW
 
 #ifdef __ASSEMBLY__
 
@@ -274,6 +294,12 @@ static inline void x86_set_skl_return_th
 }
 
 DECLARE_PER_CPU(u64, __x86_call_depth);
+#ifdef CONFIG_CALL_THUNKS_DEBUG
+DECLARE_PER_CPU(u64, __x86_call_count);
+DECLARE_PER_CPU(u64, __x86_ret_count);
+DECLARE_PER_CPU(u64, __x86_stuffs_count);
+DECLARE_PER_CPU(u64, __x86_ctxsw_count);
+#endif
 #else
 static inline void x86_set_skl_return_thunk(void) {}
 #endif
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -3,6 +3,7 @@
 #define pr_fmt(fmt) "callthunks: " fmt
 
 #include <linux/btree.h>
+#include <linux/debugfs.h>
 #include <linux/memory.h>
 #include <linux/moduleloader.h>
 #include <linux/set_memory.h>
@@ -32,6 +33,13 @@ static int __init debug_thunks(char *str
 	return 1;
 }
 __setup("debug-callthunks", debug_thunks);
+
+DEFINE_PER_CPU(u64, __x86_call_count);
+DEFINE_PER_CPU(u64, __x86_ret_count);
+DEFINE_PER_CPU(u64, __x86_stuffs_count);
+DEFINE_PER_CPU(u64, __x86_ctxsw_count);
+EXPORT_SYMBOL_GPL(__x86_ctxsw_count);
+
 #else
 #define prdbg(fmt, args...)	do { } while(0)
 #endif
@@ -530,3 +538,46 @@ void callthunks_module_free(struct modul
 	mutex_unlock(&text_mutex);
 }
 #endif /* CONFIG_MODULES */
+
+#if defined(CONFIG_CALL_THUNKS_DEBUG) && defined(CONFIG_DEBUG_FS)
+static int callthunks_debug_show(struct seq_file *m, void *p)
+{
+	unsigned long cpu = (unsigned long)m->private;
+
+	seq_printf(m, "C: %16llu R: %16llu S: %16llu X: %16llu\n,",
+		   per_cpu(__x86_call_count, cpu),
+		   per_cpu(__x86_ret_count, cpu),
+		   per_cpu(__x86_stuffs_count, cpu),
+		   per_cpu(__x86_ctxsw_count, cpu));
+	return 0;
+}
+
+static int callthunks_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, callthunks_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_ops = {
+	.open		= callthunks_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init callthunks_debugfs_init(void)
+{
+	struct dentry *dir;
+	unsigned long cpu;
+
+	dir = debugfs_create_dir("callthunks", NULL);
+	for_each_possible_cpu(cpu) {
+		void *arg = (void *)cpu;
+		char name [10];
+
+		sprintf(name, "cpu%lu", cpu);
+		debugfs_create_file(name, 0644, dir, arg, &dfs_ops);
+	}
+	return 0;
+}
+__initcall(callthunks_debugfs_init);
+#endif
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -202,13 +202,18 @@ EXPORT_SYMBOL(__x86_return_thunk)
 	.align 64
 SYM_FUNC_START(__x86_return_skl)
 	ANNOTATE_NOENDBR
-	/* Keep the hotpath in a 16byte I-fetch */
+	/*
+	 * Keep the hotpath in a 16byte I-fetch for the non-debug
+	 * case.
+	 */
+	CALL_THUNKS_DEBUG_INC_RETS
 	shlq	$5, PER_CPU_VAR(__x86_call_depth)
 	jz	1f
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
 1:
+	CALL_THUNKS_DEBUG_INC_STUFFS
 	.rept	16
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	2f

