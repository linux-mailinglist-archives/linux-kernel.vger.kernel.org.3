Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F834C0EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiBWJCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbiBWJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:01:54 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D10C7D03D;
        Wed, 23 Feb 2022 01:01:27 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K3VQ86RHvz9sSg;
        Wed, 23 Feb 2022 10:01:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0TBq8AJ9C2fF; Wed, 23 Feb 2022 10:01:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K3VQ61vRLz9sSm;
        Wed, 23 Feb 2022 10:01:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F4348B77E;
        Wed, 23 Feb 2022 10:01:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lE6qHMcVs3_R; Wed, 23 Feb 2022 10:01:18 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.181])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C9FFD8B77A;
        Wed, 23 Feb 2022 10:01:17 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21N918uk1126388
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 10:01:08 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21N918Nv1126387;
        Wed, 23 Feb 2022 10:01:08 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] module: Make module_enable_x() independent of CONFIG_ARCH_HAS_STRICT_MODULE_RWX
Date:   Wed, 23 Feb 2022 10:00:58 +0100
Message-Id: <d6181f7fe1a7c090ccb682c1b4eae0d55f3cb455.1645605431.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645605431.git.christophe.leroy@csgroup.eu>
References: <cover.1645605431.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645606850; l=3303; s=20211009; h=from:subject:message-id; bh=OQaKbGQAs8NmWaYgD6baLRXfPKkjfM+Yqzj32Z5NiPI=; b=mtIzch6mbIoLZZCcVDEAagjea5d6azhOqm0HEgvB6SuaQ6feu1/Wtj0T5+T/TgKPWazIMahOpMVd /jRUnEX4BPAGZrkNAggdjxvBweDEbPYMTFPW5ZRlOyYUZDeBrQNJ
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

module_enable_x() has nothing to do with CONFIG_ARCH_HAS_STRICT_MODULE_RWX
allthough by coincidence architectures who need module_enable_x() are
selection CONFIG_ARCH_HAS_STRICT_MODULE_RWX.

Enable module_enable_x() for everyone everytime. If an architecture
already has module text set executable, it's a no-op.

Don't check text_size alignment. When CONFIG_STRICT_MODULE_RWX is set
the verification is already done in frob_rodata(). When
CONFIG_STRICT_MODULE_RWX is not set it is not a big deal to have the
start of data as executable. Just make sure we entirely get the last
page when the boundary is not aligned.

And don't BUG on misaligned base as some architectures like nios2
use kmalloc() for allocating modules. So just bail out in that case.
If that's a problem, a page fault will occur later anyway.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h |  6 ++----
 kernel/module/main.c     | 12 +++++-------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 3fc139d5074b..972bc811dcd2 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -23,9 +23,9 @@
 /*
  * Modules' sections will be aligned on page boundaries
  * to ensure complete separation of code and data, but
- * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
+ * only when CONFIG_STRICT_MODULE_RWX=y
  */
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
+#ifdef CONFIG_STRICT_MODULE_RWX
 # define debug_align(X) PAGE_ALIGN(X)
 #else
 # define debug_align(X) (X)
@@ -175,10 +175,8 @@ static inline struct module *mod_find(unsigned long addr)
 }
 #endif /* CONFIG_MODULES_TREE_LOOKUP */
 
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
 void frob_text(const struct module_layout *layout, int (*set_memory)(unsigned long start,
 								     int num_pages));
-#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
 #ifdef CONFIG_STRICT_MODULE_RWX
 void module_enable_ro(const struct module *mod, bool after_init);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 0749afdc34b5..44e80b4e56db 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1144,24 +1144,22 @@ resolve_symbol_wait(struct module *mod,
  * CONFIG_STRICT_MODULE_RWX block below because they are needed regardless of
  * whether we are strict.
  */
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
 void frob_text(const struct module_layout *layout,
 	       int (*set_memory)(unsigned long start, int num_pages))
 {
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
 	set_memory((unsigned long)layout->base,
-		   layout->text_size >> PAGE_SHIFT);
+		   PAGE_ALIGN(layout->text_size) >> PAGE_SHIFT);
 }
 
 static void module_enable_x(const struct module *mod)
 {
+	if (!PAGE_ALIGNED(mod->core_layout.base) ||
+	    !PAGE_ALIGNED(mod->init_layout.base))
+		return;
+
 	frob_text(&mod->core_layout, set_memory_x);
 	frob_text(&mod->init_layout, set_memory_x);
 }
-#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
-static void module_enable_x(const struct module *mod) { }
-#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
 void __weak module_memfree(void *module_region)
 {
-- 
2.34.1

