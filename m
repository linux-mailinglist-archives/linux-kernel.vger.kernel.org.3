Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857A4547AD3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiFLPdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiFLPdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:33:33 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30C71FCDD;
        Sun, 12 Jun 2022 08:33:31 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LLdyL4Wxdz9tND;
        Sun, 12 Jun 2022 17:33:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eknzzkiQ2Vxt; Sun, 12 Jun 2022 17:33:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LLdyL3R5Fz9tFn;
        Sun, 12 Jun 2022 17:33:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C6FF8B76D;
        Sun, 12 Jun 2022 17:33:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bcVSCS3LNj_0; Sun, 12 Jun 2022 17:33:30 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (po16064.idsi0.si.c-s.fr [192.168.6.194])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 24C0C8B767;
        Sun, 12 Jun 2022 17:33:30 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25CFXKk9070302
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 12 Jun 2022 17:33:20 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25CFXKG7070301;
        Sun, 12 Jun 2022 17:33:20 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] module: Fix "warning: variable 'exit' set but not used"
Date:   Sun, 12 Jun 2022 17:33:20 +0200
Message-Id: <a7e1cf121cc52969878d0450b273e7fa10043835.1655047991.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655047996; l=1716; s=20211009; h=from:subject:message-id; bh=LQHsvDZxdtPGyxK4kLcZMc4XILopXjVtdWTqz6awXSw=; b=YFO6mFFEmb/uqVSKc0m9nMFOGGjxNbXBbzNKiZoPPpTUrut+sQwptrE57lcDC5BfFQP0PuWGkT8h TAqf8Im6C7BPFSEV23+u+5daSNdSVVo0Xtj6bvzXX4/wj5QQ4T1G
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

When CONFIG_MODULE_UNLOAD is not selected, 'exit' is
set but never used.

It is not possible to replace the #ifdef CONFIG_MODULE_UNLOAD by
IS_ENABLED(CONFIG_MODULE_UNLOAD) because mod->exit doesn't exist
when CONFIG_MODULE_UNLOAD is not selected.

And because of the rcu_read_lock_sched() section it is not easy
to regroup everything in a single #ifdef. Let's regroup partially
and add missing #ifdef to completely opt out the use of
'exit' when CONFIG_MODULE_UNLOAD is not selected.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..0548151dd933 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2939,24 +2939,25 @@ static void cfi_init(struct module *mod)
 {
 #ifdef CONFIG_CFI_CLANG
 	initcall_t *init;
+#ifdef CONFIG_MODULE_UNLOAD
 	exitcall_t *exit;
+#endif
 
 	rcu_read_lock_sched();
 	mod->cfi_check = (cfi_check_fn)
 		find_kallsyms_symbol_value(mod, "__cfi_check");
 	init = (initcall_t *)
 		find_kallsyms_symbol_value(mod, "__cfi_jt_init_module");
-	exit = (exitcall_t *)
-		find_kallsyms_symbol_value(mod, "__cfi_jt_cleanup_module");
-	rcu_read_unlock_sched();
-
 	/* Fix init/exit functions to point to the CFI jump table */
 	if (init)
 		mod->init = *init;
 #ifdef CONFIG_MODULE_UNLOAD
+	exit = (exitcall_t *)
+		find_kallsyms_symbol_value(mod, "__cfi_jt_cleanup_module");
 	if (exit)
 		mod->exit = *exit;
 #endif
+	rcu_read_unlock_sched();
 
 	cfi_module_add(mod, mod_tree.addr_min);
 #endif
-- 
2.35.3

