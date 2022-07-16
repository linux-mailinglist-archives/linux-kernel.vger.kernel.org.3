Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52F2577264
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiGPXTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGPXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768E240B6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:51 -0700 (PDT)
Message-ID: <20220716230954.095980377@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TLRAvZyLEqsQnwkoOe77XpgKA72Xpqcnn5aNrBgcecY=;
        b=zu68aOfoTqg7NypD3iZoMno0+P25QhX7HLERWL4CZTTSaxsTUfvg4Z+FAVZj/gf1yTDIOt
        m9yMKN/2AzBe0fIWHNyi7f1hC5fqxe1b4ENRp63p1zpJJNeHRkIYewLA1lVwBFzsT+RcVI
        90J6W4K2GWoWLjWGy7W+eOrMnAQ1WEuhoYL2AC2uINHrxgAMV40xqPgZgTwiGcESbYy4Ej
        c9ujKGfN7fBRJdjZeryA+CykR1NJ234iJt9BqCHM24h+U8uOVojDnlWfyb1sj7nQM1LFa0
        QDxAp87oNzkwiLPRxvqECQFsNrhr8Fut7cSERXYkSTpXgW0peG0JWfapnx9TXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TLRAvZyLEqsQnwkoOe77XpgKA72Xpqcnn5aNrBgcecY=;
        b=bDKQoKtEz/awFA0KCCwZ5LGnaiaLhvF3ypOdgvTOzoN/FOQEp1pvTHrWBg7l/HaOZv1hKf
        ppuZ84PmuQK7ZHAA==
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 24/38] module: Add layout for callthunks tracking
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:48 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Various things will need to be able to tell if a specific address is a
callthunk or not (ORC, BPF, static_call). In order to answer this
question in the face of modules it is necessary to (quickly) find the
module associated with a specific (callthunk) address.

Extend the __module_address() infrastructure with knowledge of the
(per module) callthunk range.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/module.h      |   21 +++++++++++++++++++--
 kernel/module/internal.h    |    8 ++++++++
 kernel/module/main.c        |    6 ++++++
 kernel/module/tree_lookup.c |   17 ++++++++++++++++-
 4 files changed, 49 insertions(+), 3 deletions(-)

--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -424,6 +424,9 @@ struct module {
 	/* Core layout: rbtree is accessed frequently, so keep together. */
 	struct module_layout core_layout __module_layout_align;
 	struct module_layout init_layout;
+#ifdef CONFIG_CALL_THUNKS
+	struct module_layout thunk_layout;
+#endif
 #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
 	struct module_layout data_layout;
 #endif
@@ -590,9 +593,23 @@ static inline bool within_module_init(un
 	       addr < (unsigned long)mod->init_layout.base + mod->init_layout.size;
 }
 
-static inline bool within_module(unsigned long addr, const struct module *mod)
+static inline bool within_module_thunk(unsigned long addr,
+				       const struct module *mod)
+{
+#ifdef CONFIG_CALL_THUNKS
+	return (unsigned long)mod->thunk_layout.base <= addr &&
+	       addr < (unsigned long)mod->thunk_layout.base + mod->thunk_layout.size;
+#else
+	return false;
+#endif
+}
+
+static inline bool within_module(unsigned long addr,
+				 const struct module *mod)
 {
-	return within_module_init(addr, mod) || within_module_core(addr, mod);
+	return within_module_core(addr, mod)  ||
+	       within_module_thunk(addr, mod) ||
+	       within_module_init(addr, mod);
 }
 
 /* Search for module by name: must be in a RCU-sched critical section. */
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -219,6 +219,14 @@ static inline struct module *mod_find(un
 }
 #endif /* CONFIG_MODULES_TREE_LOOKUP */
 
+#if defined(CONFIG_MODULES_TREE_LOOKUP) && defined(CONFIG_CALL_THUNKS)
+void mod_tree_insert_thunk(struct module *mod);
+void mod_tree_remove_thunk(struct module *mod);
+#else
+static inline void mod_tree_insert_thunk(struct module *mod) { }
+static inline void mod_tree_remove_thunk(struct module *mod) { }
+#endif
+
 void module_enable_ro(const struct module *mod, bool after_init);
 void module_enable_nx(const struct module *mod);
 void module_enable_x(const struct module *mod);
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1154,6 +1154,7 @@ static void free_module(struct module *m
 	 */
 	mutex_lock(&module_mutex);
 	mod->state = MODULE_STATE_UNFORMED;
+	mod_tree_remove_thunk(mod);
 	mutex_unlock(&module_mutex);
 
 	/* Remove dynamic debug info */
@@ -2770,6 +2771,10 @@ static int load_module(struct load_info
 	if (err < 0)
 		goto free_modinfo;
 
+	mutex_lock(&module_mutex);
+	mod_tree_insert_thunk(mod);
+	mutex_unlock(&module_mutex);
+
 	flush_module_icache(mod);
 
 	/* Setup CFI for the module. */
@@ -2859,6 +2864,7 @@ static int load_module(struct load_info
 	mutex_lock(&module_mutex);
 	/* Unlink carefully: kallsyms could be walking list. */
 	list_del_rcu(&mod->list);
+	mod_tree_remove_thunk(mod);
 	mod_tree_remove(mod);
 	wake_up_all(&module_wq);
 	/* Wait for RCU-sched synchronizing before releasing mod->list. */
--- a/kernel/module/tree_lookup.c
+++ b/kernel/module/tree_lookup.c
@@ -66,11 +66,26 @@ static noinline void __mod_tree_insert(s
 	latch_tree_insert(&node->node, &tree->root, &mod_tree_ops);
 }
 
-static void __mod_tree_remove(struct mod_tree_node *node, struct mod_tree_root *tree)
+static noinline void __mod_tree_remove(struct mod_tree_node *node, struct mod_tree_root *tree)
 {
 	latch_tree_erase(&node->node, &tree->root, &mod_tree_ops);
 }
 
+#ifdef CONFIG_CALL_THUNKS
+void mod_tree_insert_thunk(struct module *mod)
+{
+	mod->thunk_layout.mtn.mod = mod;
+	if (mod->thunk_layout.size)
+		__mod_tree_insert(&mod->thunk_layout.mtn, &mod_tree);
+}
+
+void mod_tree_remove_thunk(struct module *mod)
+{
+	if (mod->thunk_layout.size)
+		__mod_tree_remove(&mod->thunk_layout.mtn, &mod_tree);
+}
+#endif
+
 /*
  * These modifications: insert, remove_init and remove; are serialized by the
  * module_mutex.

