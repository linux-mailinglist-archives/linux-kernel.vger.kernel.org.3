Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC104BF5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiBVKYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBVKYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:24:20 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9041598C9;
        Tue, 22 Feb 2022 02:23:55 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K2wHg4fYyz9sSK;
        Tue, 22 Feb 2022 11:23:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FvcC2oE_30W0; Tue, 22 Feb 2022 11:23:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K2wHd4nGdz9sS4;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 944358B77B;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XmT3q87Ny7oE; Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7406B8B764;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MANWHf1075634
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:23:32 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MANWI91075633;
        Tue, 22 Feb 2022 11:23:32 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Fixup for 54f2273e5fef ("module: Move kallsyms support into a separate file")
Date:   Tue, 22 Feb 2022 11:23:27 +0100
Message-Id: <c1fdda1d836cdd7a05d3178d5e6ea4b687e548cd.1645525354.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cab881354cedd64c53ce4e35ef8c86806baad99c.1645525354.git.christophe.leroy@csgroup.eu>
References: <cab881354cedd64c53ce4e35ef8c86806baad99c.1645525354.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645525381; l=1918; s=20211009; h=from:subject:message-id; bh=FwgKdS8iKTLyex0Nq0FuY+Z+GBgNinuvCSGTdhHJdHE=; b=DsVT5DK2ayAeHEte4buz0UVJdqIJgYq6FRU0e1bCzfZ+8vzNZ9KnSBy9zMz78wCi6FMFiZPHlMGj qkXnAe06AmfHNMdFfIWvk836nHcPaiRKyjrqz3muXgrL1M9V0eZF
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 54f2273e5fef ("module: Move kallsyms support into a separate file")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h | 7 ++++---
 kernel/module/kallsyms.c | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 6a54a1e06f4f..fecfa590c149 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -212,12 +212,13 @@ static inline void kmemleak_load_module(const struct module *mod,
 					const struct load_info *info) { }
 #endif /* CONFIG_DEBUG_KMEMLEAK */
 
-#ifdef CONFIG_KALLSYMS
-#ifdef CONFIG_STACKTRACE_BUILD_ID
+#if defined(CONFIG_KALLSYMS) && defined(CONFIG_STACKTRACE_BUILD_ID)
 void init_build_id(struct module *mod, const struct load_info *info);
-#else /* !CONFIG_STACKTRACE_BUILD_ID */
+#else
 static inline void init_build_id(struct module *mod, const struct load_info *info) { }
 #endif
+
+#ifdef CONFIG_KALLSYMS
 void layout_symtab(struct module *mod, struct load_info *info);
 void add_kallsyms(struct module *mod, const struct load_info *info);
 unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 6c8f1f390cf5..2ee8d2e67068 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -171,8 +171,7 @@ void add_kallsyms(struct module *mod, const struct load_info *info)
 	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
 
 	/* Set up to point into init section. */
-	mod->kallsyms = (struct mod_kallsyms __rcu *)mod->init_layout.base +
-		info->mod_kallsyms_init_off;
+	mod->kallsyms = (void __rcu *)mod->init_layout.base + info->mod_kallsyms_init_off;
 
 	/* The following is safe since this pointer cannot change */
 	rcu_dereference_sched(mod->kallsyms)->symtab = (void *)symsec->sh_addr;
-- 
2.34.1

