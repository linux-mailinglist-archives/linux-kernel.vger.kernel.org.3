Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244A0547B44
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiFLRpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 13:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiFLRoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 13:44:44 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41518636D;
        Sun, 12 Jun 2022 10:44:43 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LLhsg2xgfz9tNF;
        Sun, 12 Jun 2022 19:44:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hz7mTX_y_0za; Sun, 12 Jun 2022 19:44:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LLhsf28KJz9tNG;
        Sun, 12 Jun 2022 19:44:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 34CA98B76D;
        Sun, 12 Jun 2022 19:44:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JAt_bVPXGUS8; Sun, 12 Jun 2022 19:44:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (po16064.idsi0.si.c-s.fr [192.168.6.194])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E87A88B767;
        Sun, 12 Jun 2022 19:44:37 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25CHiSBY082468
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 12 Jun 2022 19:44:28 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25CHiRSG082467;
        Sun, 12 Jun 2022 19:44:27 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] module: Fix ERRORs reported by checkpatch.pl
Date:   Sun, 12 Jun 2022 19:44:25 +0200
Message-Id: <ad08695b528a812c83ff563d3bcaf3f7038fecb0.1655055854.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655055865; l=2617; s=20211009; h=from:subject:message-id; bh=/NbpAV1FJWQCDWmmp4q8rCj2ZqxtZl4UOu7nYWHPdH8=; b=Kwn5MW9s3AcTHHmKG5lSnyO6JcaHqdaW7sveD1oWmdTHbFGve4nT9hukSCnwMcqHmrb7SNMSG7vD jQErwX6aCPTUfH0XVoFQorz1uYGYo+0PezX7xPYTSRqqFQCjsAXc
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

Checkpatch reports following errors:

ERROR: do not use assignment in if condition
+	if ((colon = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {

ERROR: do not use assignment in if condition
+		if ((mod = find_module_all(name, colon - name, false)) != NULL)

ERROR: do not use assignment in if condition
+			if ((ret = find_kallsyms_symbol_value(mod, name)) != 0)

ERROR: do not initialise globals to 0
+int modules_disabled = 0;

ERROR: do not use assignment in if condition
+	if (wait_event_interruptible_timeout(module_wq,

Fix them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/kallsyms.c | 9 ++++++---
 kernel/module/main.c     | 6 +++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..fe3636bde605 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -457,14 +457,17 @@ unsigned long module_kallsyms_lookup_name(const char *name)
 
 	/* Don't lock: we're in enough trouble already. */
 	preempt_disable();
-	if ((colon = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
-		if ((mod = find_module_all(name, colon - name, false)) != NULL)
+	colon = strnchr(name, MODULE_NAME_LEN, ':');
+	if (colon) {
+		mod = find_module_all(name, colon - name, false);
+		if (mod)
 			ret = find_kallsyms_symbol_value(mod, colon + 1);
 	} else {
 		list_for_each_entry_rcu(mod, &modules, list) {
 			if (mod->state == MODULE_STATE_UNFORMED)
 				continue;
-			if ((ret = find_kallsyms_symbol_value(mod, name)) != 0)
+			ret = find_kallsyms_symbol_value(mod, name);
+			if (ret)
 				break;
 		}
 	}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 0548151dd933..36747941817f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -119,7 +119,7 @@ static void mod_update_bounds(struct module *mod)
 }
 
 /* Block module loading/unloading? */
-int modules_disabled = 0;
+int modules_disabled;
 core_param(nomodule, modules_disabled, bint, 0);
 
 /* Waiting for a module to finish initializing? */
@@ -1111,9 +1111,9 @@ resolve_symbol_wait(struct module *mod,
 	const struct kernel_symbol *ksym;
 	char owner[MODULE_NAME_LEN];
 
+	ksym = resolve_symbol(mod, info, name, owner);
 	if (wait_event_interruptible_timeout(module_wq,
-			!IS_ERR(ksym = resolve_symbol(mod, info, name, owner))
-			|| PTR_ERR(ksym) != -EBUSY,
+			!IS_ERR(ksym) || PTR_ERR(ksym) != -EBUSY,
 					     30 * HZ) <= 0) {
 		pr_warn("%s: gave up waiting for init of module %s.\n",
 			mod->name, owner);
-- 
2.35.3

