Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF6857725D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiGPXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiGPXTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:19:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B523BC9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:13 -0700 (PDT)
Message-ID: <20220716230954.772385338@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Kf2G1rz5pONni7MT992YEuxpma07TxS3Y+PewVU2bX4=;
        b=UqtU09MxfNOF1FVYOUtExn/u/selQX/fZnoqeuCXfBR0kBVJ41hIWPAge7J2aOoGIiuq/g
        N2RoL7NnRABnj40DdCkDMNeXM19Nn2WCgnfoIsiTkWKRaUdbcLQvVzeP2GFWEOUFRNS5kq
        0RUzPBskCk2D5P4810gSSdCMBpJfwBJLaTt92sKVm/KrTLBZo7VH3y7JCkwBSO8mp6nY6J
        KTFc5FsFbnU1+K2gSeOLW3tR4J2WVP3Jw/Mr+qq2kRGUtNbraz2vP1RjvpZnW931u35lBy
        zioHOn8LsFuQcv2BILOONAejwDotk5nz1oSH7VdZzIS498lizUj7qu976COahg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Kf2G1rz5pONni7MT992YEuxpma07TxS3Y+PewVU2bX4=;
        b=dYB1/mTvB2NH2OUTBq9mvLvtbaGbzKNkQxLkc4ixf8hSad7Kkv7owhcqfKvtbUodjhOhdw
        xZz1gIIE9U9VrkBA==
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
Subject: [patch 35/38] kprobes: Add callthunk blacklisting
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:18:06 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Callthunks are not safe for probing. Add them to the kprobes black listed
areas.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/callthunks.c |    5 ++++
 kernel/kprobes.c             |   52 +++++++++++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -6,6 +6,7 @@
 #include <linux/debugfs.h>
 #include <linux/kallsyms.h>
 #include <linux/memory.h>
+#include <linux/kprobes.h>
 #include <linux/moduleloader.h>
 #include <linux/set_memory.h>
 #include <linux/static_call.h>
@@ -476,6 +477,7 @@ static __init_or_module int callthunks_s
 
 static __init noinline void callthunks_init(struct callthunk_sites *cs)
 {
+	unsigned long base, size;
 	int ret;
 
 	if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH)) {
@@ -494,6 +496,9 @@ static __init noinline void callthunks_i
 	if (WARN_ON_ONCE(ret))
 		return;
 
+	base = (unsigned long)builtin_layout.base;
+	size = builtin_layout.size;
+	kprobe_add_area_blacklist(base, base + size);
 	static_call_force_reinit();
 	thunks_initialized = true;
 }
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2439,40 +2439,38 @@ void dump_kprobe(struct kprobe *kp)
 }
 NOKPROBE_SYMBOL(dump_kprobe);
 
-int kprobe_add_ksym_blacklist(unsigned long entry)
+static int __kprobe_add_ksym_blacklist(unsigned long start, unsigned long end)
 {
 	struct kprobe_blacklist_entry *ent;
-	unsigned long offset = 0, size = 0;
-
-	if (!kernel_text_address(entry) ||
-	    !kallsyms_lookup_size_offset(entry, &size, &offset))
-		return -EINVAL;
 
 	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
 	if (!ent)
 		return -ENOMEM;
-	ent->start_addr = entry;
-	ent->end_addr = entry + size;
+	ent->start_addr = start;
+	ent->end_addr = end;
 	INIT_LIST_HEAD(&ent->list);
 	list_add_tail(&ent->list, &kprobe_blacklist);
 
-	return (int)size;
+	return (int)(end - start);
+}
+
+int kprobe_add_ksym_blacklist(unsigned long entry)
+{
+	unsigned long offset = 0, size = 0;
+
+	if (!kernel_text_address(entry) ||
+	    !kallsyms_lookup_size_offset(entry, &size, &offset))
+		return -EINVAL;
+
+	return __kprobe_add_ksym_blacklist(entry, entry + size);
 }
 
 /* Add all symbols in given area into kprobe blacklist */
 int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 {
-	unsigned long entry;
-	int ret = 0;
+	int ret = __kprobe_add_ksym_blacklist(start, end);
 
-	for (entry = start; entry < end; entry += ret) {
-		ret = kprobe_add_ksym_blacklist(entry);
-		if (ret < 0)
-			return ret;
-		if (ret == 0)	/* In case of alias symbol */
-			ret = 1;
-	}
-	return 0;
+	return ret < 0 ? ret : 0;
 }
 
 /* Remove all symbols in given area from kprobe blacklist */
@@ -2578,6 +2576,14 @@ static void add_module_kprobe_blacklist(
 		end = start + mod->noinstr_text_size;
 		kprobe_add_area_blacklist(start, end);
 	}
+
+#ifdef CONFIG_CALL_THUNKS
+	start = (unsigned long)mod->thunk_layout.base;
+	if (start) {
+		end = start + mod->thunk_layout.size;
+		kprobe_remove_area_blacklist(start, end);
+	}
+#endif
 }
 
 static void remove_module_kprobe_blacklist(struct module *mod)
@@ -2601,6 +2607,14 @@ static void remove_module_kprobe_blackli
 		end = start + mod->noinstr_text_size;
 		kprobe_remove_area_blacklist(start, end);
 	}
+
+#ifdef CONFIG_CALL_THUNKS
+	start = (unsigned long)mod->thunk_layout.base;
+	if (start) {
+		end = start + mod->thunk_layout.size;
+		kprobe_remove_area_blacklist(start, end);
+	}
+#endif
 }
 
 /* Module notifier call back, checking kprobes on the module */

