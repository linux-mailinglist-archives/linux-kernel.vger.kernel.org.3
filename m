Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F03542E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiFHKpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbiFHKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:45:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE92D921C;
        Wed,  8 Jun 2022 03:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25B67B82515;
        Wed,  8 Jun 2022 10:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968E9C341C0;
        Wed,  8 Jun 2022 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654685129;
        bh=c7CfPX19eVzkri+WoXphSC63kVD98IclMqfOQOsGVQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gp5kNjbpdizeodqHjqDwuOqmbpDqX/xM7zihgD8KK/CepnWCIDTuQvr6oZsMFMmEM
         x2SJ98AOT/2YFYGBGcb5GZ0DRp6//7O46Rvvruy9ffnUKV27XSUCRayD+6Qfn0zQ01
         NmisZeppZtMmT9hHcJRf+qMM2Z62AWC2w7qYS84tKIYZRPbmExtCq0/jjcEAAUxDZ3
         Gm+tDm7QOUW6HsORHyaOfAh+2iHP0MVchHp6wOPKcYGmyyEZHBYuIqUPs9WaKmePmt
         GEBSmjX/cEJVlZtOtk2nNcg28F+/UsDz45x3bl8ioSP8IPnkgyAT6wda4ktpqxZMJf
         kOEErzObRfYMA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/3] jump_label: mips: move module NOP patching into arch code
Date:   Wed,  8 Jun 2022 12:45:11 +0200
Message-Id: <20220608104512.1176209-3-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608104512.1176209-1-ardb@kernel.org>
References: <20220608104512.1176209-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6445; h=from:subject; bh=c7CfPX19eVzkri+WoXphSC63kVD98IclMqfOQOsGVQU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBioH21qhfGEwZDqn2RBezVRa70NovaR4URqFttnuPf x+3Wx46JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqB9tQAKCRDDTyI5ktmPJGfIDA DCfwL+kpiWqH9Svu3esUbTPpqeLkIloRhP+PLurJECH+Y6CRoSnUT0BZTHjqXpyxWQ/y+C0NLqbYj7 xrJLjtRj2WDdr6+pn9CJVw7Wm9bHB3r+u89BMCwRNpoSJhPQfRM9Qx8UFHQ7IEb0PJ9ANE7U5BtExL Z6ffex8k7uqKCblp3NhuRgmts7toMQy2XXtX9He6mEMNeh0csNFvKjyHBo6F0KrG5FfB1mxzLpeny4 AsZY6moIlFp404CqkXHs4bIcUxWta8LtEfy1YbJsOCpdlGyOslyxleYvuV9ABlxlBFvf59DAVXsAiP GLbccLXhr00CBqT8QKAmXiaNg4NyK29fxtdg7IxWnhzCf/FE5naksCkCGtugnAXbcudQxsZBxPVNXm OP2vgjgy4BoNl90zeaVtN7OkPRnBCLHieDr81iUO89XZu+/JSJ0E5vCdOlZVHFnAGEEjHNaZlGWuCa LgW4kgRyaG3ELVL6zK0hgKsRjIgNihalTMD2fX7nJ4GqM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS is the only remaining architecture that needs to patch jump label
NOP encodings to initialize them at load time. So let's move the module
patching part of that from generic code into arch/mips, and drop it from
the others.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/mips/kernel/jump_label.c | 17 ++++++++++++
 arch/mips/kernel/module.c     |  5 ++--
 arch/s390/kernel/module.c     |  1 -
 arch/sparc/kernel/module.c    |  3 ---
 arch/x86/kernel/module.c      |  3 ---
 include/linux/jump_label.h    |  7 +----
 kernel/jump_label.c           | 27 +-------------------
 7 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/arch/mips/kernel/jump_label.c b/arch/mips/kernel/jump_label.c
index 662c8db9f45b..0f98e7f1461f 100644
--- a/arch/mips/kernel/jump_label.c
+++ b/arch/mips/kernel/jump_label.c
@@ -88,3 +88,20 @@ void arch_jump_label_transform(struct jump_entry *e,
 
 	mutex_unlock(&text_mutex);
 }
+
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
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 14f46d17500a..0c936cbf20c5 100644
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
index 26125a9c436d..2d159b32885b 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -548,6 +548,5 @@ int module_finalize(const Elf_Ehdr *hdr,
 #endif /* CONFIG_FUNCTION_TRACER */
 	}
 
-	jump_label_apply_nops(me);
 	return 0;
 }
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index df39580f398d..66c45a2764bc 100644
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
index b98ffcf4d250..95b9cf25d4bd 100644
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
index bf1eef337a07..2003a0935478 100644
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
index b156e152d6b4..b1ac2948be79 100644
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
-- 
2.30.2

