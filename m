Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B21F55DC6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiF1HJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiF1HJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:09:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B248BB489;
        Tue, 28 Jun 2022 00:09:15 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:09:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsmjqaZFfqc+ta7xvXRtpXGQex6GuKf+433cr2vZofs=;
        b=4fP+VM6rVKHTKxdRFw3s2L+ikvHiDuwWnsjaLXUrlHI1psY5eN8ti7wRReOKMim9VUZb+e
        Jh3ATVC+4/q8dQxeOcL1zHjLQjh88aZJrd2tkmoOGK79fir5B4LaPY1fwiJjbb5KsNSKGw
        5GD1V39eACssbIYA53MCVrJDCRnVx+U5df+2AOawdTcnOgCRr/0Mi0yRi4rv1XwJ+arHOz
        N2uPI4MOU7NZDnCg2sj47C5Q9C9GHYCx6tlr8UbnImbU07Yihji9gqtDm3p+IKLMm986X8
        HOt0Vg0yFDScp9L0WGjIUy4by7llMTH/8er7xac4ezJNSFBuDuLzb9fceL4Hsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsmjqaZFfqc+ta7xvXRtpXGQex6GuKf+433cr2vZofs=;
        b=FKhjYIfD3g5vhMvYu2u99EtDjrWdWB4MrnJklAczg+Mefd/09tnPciVDj2WH4Tf19dwGny
        ObhxbLIy/QI5XlDQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: mips: move module NOP patching into arch code
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220615154142.1574619-3-ardb@kernel.org>
References: <20220615154142.1574619-3-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <165640015317.4207.8002350045283771396.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fdfd42892f311e2b3695852036e5be23661dc590
Gitweb:        https://git.kernel.org/tip/fdfd42892f311e2b3695852036e5be23661dc590
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 15 Jun 2022 17:41:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Jun 2022 09:48:55 +02:00

jump_label: mips: move module NOP patching into arch code

MIPS is the only remaining architecture that needs to patch jump label
NOP encodings to initialize them at load time. So let's move the module
patching part of that from generic code into arch/mips, and drop it from
the others.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220615154142.1574619-3-ardb@kernel.org
---
 arch/mips/kernel/jump_label.c | 19 +++++++++++++++++++
 arch/mips/kernel/module.c     |  5 +++--
 arch/s390/kernel/module.c     |  1 -
 arch/sparc/kernel/module.c    |  3 ---
 arch/x86/kernel/module.c      |  3 ---
 include/linux/jump_label.h    |  7 +------
 kernel/jump_label.c           | 27 +--------------------------
 7 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/arch/mips/kernel/jump_label.c b/arch/mips/kernel/jump_label.c
index 662c8db..71a882c 100644
--- a/arch/mips/kernel/jump_label.c
+++ b/arch/mips/kernel/jump_label.c
@@ -88,3 +88,22 @@ void arch_jump_label_transform(struct jump_entry *e,
 
 	mutex_unlock(&text_mutex);
 }
+
+#ifdef CONFIG_MODULES
+void jump_label_apply_nops(struct module *mod)
+{
+	struct jump_entry *iter_start = mod->jump_entries;
+	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
+	struct jump_entry *iter;
+
+	/* if the module doesn't have jump label entries, just return */
+	if (iter_start == iter_stop)
+		return;
+
+	for (iter = iter_start; iter < iter_stop; iter++) {
+		/* Only write NOPs for arch_branch_static(). */
+		if (jump_label_init_type(iter) == JUMP_LABEL_NOP)
+			arch_jump_label_transform(iter, JUMP_LABEL_NOP);
+	}
+}
+#endif
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 14f46d1..0c936cb 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -21,6 +21,7 @@
 #include <linux/spinlock.h>
 #include <linux/jump_label.h>
 
+extern void jump_label_apply_nops(struct module *mod);
 
 struct mips_hi16 {
 	struct mips_hi16 *next;
@@ -428,8 +429,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const Elf_Shdr *s;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
-	/* Make jump label nops. */
-	jump_label_apply_nops(me);
+	if (IS_ENABLED(CONFIG_JUMP_LABEL))
+		jump_label_apply_nops(me);
 
 	INIT_LIST_HEAD(&me->arch.dbe_list);
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 26125a9..2d159b3 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -548,6 +548,5 @@ int module_finalize(const Elf_Ehdr *hdr,
 #endif /* CONFIG_FUNCTION_TRACER */
 	}
 
-	jump_label_apply_nops(me);
 	return 0;
 }
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index df39580..66c45a2 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -208,9 +208,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	/* make jump label nops */
-	jump_label_apply_nops(me);
-
 	do_patch_sections(hdr, sechdrs);
 
 	/* Cheetah's I-cache is fully coherent.  */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b98ffcf..95b9cf2 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -304,9 +304,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 					    tseg, tseg + text->sh_size);
 	}
 
-	/* make jump label nops */
-	jump_label_apply_nops(me);
-
 	if (orc && orc_ip)
 		unwind_module_init(me, (void *)orc_ip->sh_addr, orc_ip->sh_size,
 				   (void *)orc->sh_addr, orc->sh_size);
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index bf1eef3..2003a09 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -230,12 +230,12 @@ extern void static_key_slow_inc(struct static_key *key);
 extern void static_key_slow_dec(struct static_key *key);
 extern void static_key_slow_inc_cpuslocked(struct static_key *key);
 extern void static_key_slow_dec_cpuslocked(struct static_key *key);
-extern void jump_label_apply_nops(struct module *mod);
 extern int static_key_count(struct static_key *key);
 extern void static_key_enable(struct static_key *key);
 extern void static_key_disable(struct static_key *key);
 extern void static_key_enable_cpuslocked(struct static_key *key);
 extern void static_key_disable_cpuslocked(struct static_key *key);
+extern enum jump_label_type jump_label_init_type(struct jump_entry *entry);
 
 /*
  * We should be using ATOMIC_INIT() for initializing .enabled, but
@@ -303,11 +303,6 @@ static inline int jump_label_text_reserved(void *start, void *end)
 static inline void jump_label_lock(void) {}
 static inline void jump_label_unlock(void) {}
 
-static inline int jump_label_apply_nops(struct module *mod)
-{
-	return 0;
-}
-
 static inline void static_key_enable(struct static_key *key)
 {
 	STATIC_KEY_CHECK_USE(key);
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index b156e15..b1ac294 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -508,7 +508,7 @@ void __init jump_label_init(void)
 
 #ifdef CONFIG_MODULES
 
-static enum jump_label_type jump_label_init_type(struct jump_entry *entry)
+enum jump_label_type jump_label_init_type(struct jump_entry *entry)
 {
 	struct static_key *key = jump_entry_key(entry);
 	bool type = static_key_type(key);
@@ -596,31 +596,6 @@ static void __jump_label_mod_update(struct static_key *key)
 	}
 }
 
-/***
- * apply_jump_label_nops - patch module jump labels with arch_get_jump_label_nop()
- * @mod: module to patch
- *
- * Allow for run-time selection of the optimal nops. Before the module
- * loads patch these with arch_get_jump_label_nop(), which is specified by
- * the arch specific jump label code.
- */
-void jump_label_apply_nops(struct module *mod)
-{
-	struct jump_entry *iter_start = mod->jump_entries;
-	struct jump_entry *iter_stop = iter_start + mod->num_jump_entries;
-	struct jump_entry *iter;
-
-	/* if the module doesn't have jump label entries, just return */
-	if (iter_start == iter_stop)
-		return;
-
-	for (iter = iter_start; iter < iter_stop; iter++) {
-		/* Only write NOPs for arch_branch_static(). */
-		if (jump_label_init_type(iter) == JUMP_LABEL_NOP)
-			arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
-	}
-}
-
 static int jump_label_add_module(struct module *mod)
 {
 	struct jump_entry *iter_start = mod->jump_entries;
