Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027114C0EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiBWJBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiBWJBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:01:51 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A47D01B;
        Wed, 23 Feb 2022 01:01:23 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K3VQ70lyVz9sSZ;
        Wed, 23 Feb 2022 10:01:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jdG7GfnuMEwY; Wed, 23 Feb 2022 10:01:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K3VQ61tzDz9sSg;
        Wed, 23 Feb 2022 10:01:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C4998B77B;
        Wed, 23 Feb 2022 10:01:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id agD9yOZTGzRn; Wed, 23 Feb 2022 10:01:18 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.181])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C48D38B778;
        Wed, 23 Feb 2022 10:01:17 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21N919LP1126400
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 10:01:09 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21N919Id1126399;
        Wed, 23 Feb 2022 10:01:09 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] module: Rename debug_align() as strict_align()
Date:   Wed, 23 Feb 2022 10:01:01 +0100
Message-Id: <d87f09e80033551bef2fb775919643095af08ed2.1645605431.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645605431.git.christophe.leroy@csgroup.eu>
References: <cover.1645605431.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645606851; l=4185; s=20211009; h=from:subject:message-id; bh=7vA1x7q8Ldlupqg2MhGqeakAq8DBo60Yar/6GUgEfr8=; b=Ijs+ZWkilyjM/vmO2UOSJnJ3T/XWDzxkyh6Wh85drpl7LeFuZvjYsnpGjt7obUCI/s3JDyilIwIk 6/uh9pUdCfi1NRVXehM2JQ8XKWHQLQgyX84OKvNbqADdybhzVT8o
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

debug_align() was added by commit 84e1c6bb38eb ("x86: Add RO/NX
protection for loadable kernel modules")

At that time the config item was CONFIG_DEBUG_SET_MODULE_RONX.

But nowadays it has changed to CONFIG_STRICT_MODULE_RWX and
debug_align() is confusing because it has nothing to do with
DEBUG.

Rename it strict_align()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h |  4 ++--
 kernel/module/kallsyms.c |  4 ++--
 kernel/module/main.c     | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index e94defbeda00..cbc268af23ae 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -26,9 +26,9 @@
  * only when CONFIG_STRICT_MODULE_RWX=y
  */
 #ifdef CONFIG_STRICT_MODULE_RWX
-# define debug_align(X) PAGE_ALIGN(X)
+# define strict_align(X) PAGE_ALIGN(X)
 #else
-# define debug_align(X) (X)
+# define strict_align(X) (X)
 #endif
 
 extern struct mutex module_mutex;
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index b6d49bb5afed..23034b50f8f5 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -139,7 +139,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	mod->core_layout.size += strtab_size;
 	info->core_typeoffs = mod->core_layout.size;
 	mod->core_layout.size += ndst * sizeof(char);
-	mod->core_layout.size = debug_align(mod->core_layout.size);
+	mod->core_layout.size = strict_align(mod->core_layout.size);
 
 	/* Put string table section at end of init part of module. */
 	strsect->sh_flags |= SHF_ALLOC;
@@ -154,7 +154,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	mod->init_layout.size += sizeof(struct mod_kallsyms);
 	info->init_typeoffs = mod->init_layout.size;
 	mod->init_layout.size += nsrc * sizeof(char);
-	mod->init_layout.size = debug_align(mod->init_layout.size);
+	mod->init_layout.size = strict_align(mod->init_layout.size);
 }
 
 /*
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2f950b986785..6e3a6b4efd21 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1447,19 +1447,19 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		}
 		switch (m) {
 		case 0: /* executable */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->core_layout.size = strict_align(mod->core_layout.size);
 			mod->core_layout.text_size = mod->core_layout.size;
 			break;
 		case 1: /* RO: text and ro-data */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->core_layout.size = strict_align(mod->core_layout.size);
 			mod->core_layout.ro_size = mod->core_layout.size;
 			break;
 		case 2: /* RO after init */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->core_layout.size = strict_align(mod->core_layout.size);
 			mod->core_layout.ro_after_init_size = mod->core_layout.size;
 			break;
 		case 4: /* whole core */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->core_layout.size = strict_align(mod->core_layout.size);
 			break;
 		}
 	}
@@ -1481,11 +1481,11 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		}
 		switch (m) {
 		case 0: /* executable */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
+			mod->init_layout.size = strict_align(mod->init_layout.size);
 			mod->init_layout.text_size = mod->init_layout.size;
 			break;
 		case 1: /* RO: text and ro-data */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
+			mod->init_layout.size = strict_align(mod->init_layout.size);
 			mod->init_layout.ro_size = mod->init_layout.size;
 			break;
 		case 2:
@@ -1496,7 +1496,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			mod->init_layout.ro_after_init_size = mod->init_layout.ro_size;
 			break;
 		case 4: /* whole init */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
+			mod->init_layout.size = strict_align(mod->init_layout.size);
 			break;
 		}
 	}
-- 
2.34.1

