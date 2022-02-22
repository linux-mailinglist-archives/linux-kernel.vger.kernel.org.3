Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228364BF5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiBVKY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiBVKYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:24:23 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851AC1598D2;
        Tue, 22 Feb 2022 02:23:58 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K2wHh2GJxz9sS4;
        Tue, 22 Feb 2022 11:23:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jxVYnHUx8S-W; Tue, 22 Feb 2022 11:23:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K2wHd57kTz9sSP;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E47E8B764;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id X5UJTYpoUT3A; Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7962C8B778;
        Tue, 22 Feb 2022 11:23:41 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MANWiT1075630
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:23:32 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MANW7r1075629;
        Tue, 22 Feb 2022 11:23:32 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Fixup for e5973a14d187 ("module: Move strict rwx support to a separate file")
Date:   Tue, 22 Feb 2022 11:23:26 +0100
Message-Id: <2c21af8d7dec7f76c0888f5487d0070b21060747.1645525354.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cab881354cedd64c53ce4e35ef8c86806baad99c.1645525354.git.christophe.leroy@csgroup.eu>
References: <cab881354cedd64c53ce4e35ef8c86806baad99c.1645525354.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645525381; l=3547; s=20211009; h=from:subject:message-id; bh=mLhyWEWSW/LPZmLaaZtAyoj0qoyMiE2w/STsvCOO5SQ=; b=TPhW276FZApI2vNw+S/EoGUx5IaX+EIkQtxffrvizLBGgr/zqQGeo+NpYOYV32NVwNqtcqY2xprZ 7DC638YbCDqoBmrCsb/iA3rSkogZ5DCggsl1dyJYGKryT2I8lwBK
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

Fixes: e5973a14d187 ("module: Move strict rwx support to a separate file")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h   | 14 ++++----------
 kernel/module/strict_rwx.c | 13 +++++++------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 97d9faec3a9a..6a54a1e06f4f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -181,22 +181,16 @@ void frob_text(const struct module_layout *layout, int (*set_memory)(unsigned lo
 #endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
 #ifdef CONFIG_STRICT_MODULE_RWX
-void frob_rodata(const struct module_layout *layout,
-		 int (*set_memory)(unsigned long start, int num_pages));
-void frob_ro_after_init(const struct module_layout *layout,
-			int (*set_memory)(unsigned long start, int num_pages));
-void frob_writable_data(const struct module_layout *layout,
-			int (*set_memory)(unsigned long start, int num_pages));
 void module_enable_ro(const struct module *mod, bool after_init);
 void module_enable_nx(const struct module *mod);
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				char *secstrings, struct module *mod);
 
 #else /* !CONFIG_STRICT_MODULE_RWX */
-static void module_enable_nx(const struct module *mod) { }
-static void module_enable_ro(const struct module *mod, bool after_init) {}
-static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-				       char *secstrings, struct module *mod)
+static inline void module_enable_nx(const struct module *mod) { }
+static inline void module_enable_ro(const struct module *mod, bool after_init) {}
+static inline int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+					      char *secstrings, struct module *mod)
 {
 	return 0;
 }
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index c642889f8e77..bfee740f4bc1 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -6,12 +6,13 @@
  */
 
 #include <linux/module.h>
+#include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include "internal.h"
 
-void frob_rodata(const struct module_layout *layout,
-		 int (*set_memory)(unsigned long start, int num_pages))
+static void frob_rodata(const struct module_layout *layout,
+			int (*set_memory)(unsigned long start, int num_pages))
 {
 	BUG_ON(!PAGE_ALIGNED(layout->base));
 	BUG_ON(!PAGE_ALIGNED(layout->text_size));
@@ -20,8 +21,8 @@ void frob_rodata(const struct module_layout *layout,
 		   (layout->ro_size - layout->text_size) >> PAGE_SHIFT);
 }
 
-void frob_ro_after_init(const struct module_layout *layout,
-			int (*set_memory)(unsigned long start, int num_pages))
+static void frob_ro_after_init(const struct module_layout *layout,
+			       int (*set_memory)(unsigned long start, int num_pages))
 {
 	BUG_ON(!PAGE_ALIGNED(layout->base));
 	BUG_ON(!PAGE_ALIGNED(layout->ro_size));
@@ -30,8 +31,8 @@ void frob_ro_after_init(const struct module_layout *layout,
 		   (layout->ro_after_init_size - layout->ro_size) >> PAGE_SHIFT);
 }
 
-void frob_writable_data(const struct module_layout *layout,
-			int (*set_memory)(unsigned long start, int num_pages))
+static void frob_writable_data(const struct module_layout *layout,
+			       int (*set_memory)(unsigned long start, int num_pages))
 {
 	BUG_ON(!PAGE_ALIGNED(layout->base));
 	BUG_ON(!PAGE_ALIGNED(layout->ro_after_init_size));
-- 
2.34.1

