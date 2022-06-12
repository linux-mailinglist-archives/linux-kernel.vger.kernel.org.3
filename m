Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13CE547ABD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiFLPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiFLPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:22:19 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B635C647;
        Sun, 12 Jun 2022 08:22:16 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LLdjM2M0vz9tND;
        Sun, 12 Jun 2022 17:22:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MGK4W9O8n3tt; Sun, 12 Jun 2022 17:22:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LLdjM1KYnz9tFn;
        Sun, 12 Jun 2022 17:22:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 16F5B8B76D;
        Sun, 12 Jun 2022 17:22:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oxDVUVRfU13z; Sun, 12 Jun 2022 17:22:14 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (po16064.idsi0.si.c-s.fr [192.168.6.194])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5B1D8B767;
        Sun, 12 Jun 2022 17:22:14 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25CFM4IU065415
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 12 Jun 2022 17:22:04 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25CFM4e6065406;
        Sun, 12 Jun 2022 17:22:04 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] module: Fix selfAssignment cppcheck warning
Date:   Sun, 12 Jun 2022 17:21:56 +0200
Message-Id: <3c3041d4815d6d6ad5f7ab78b202e192210f6694.1655047308.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655047314; l=2803; s=20211009; h=from:subject:message-id; bh=Ii/yRThss71Bh4QygDM4O7u+M5n7yYzdy6Xemv6OwBE=; b=sBCb5++zfZ+8U6lLVTW6wHL9t5iNaRkN8TCF0oVoSHpDYk+a9/fQhS7cQX23FFb0ik7hf31AbMgA TK2VgtDtD1tPFU1ul0O/fCGqj2mApAXEf6BMtPn8eHRG8cfFJI3q
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

cppcheck reports the following warnings:

kernel/module/main.c:1455:26: warning: Redundant assignment of 'mod->core_layout.size' to itself. [selfAssignment]
   mod->core_layout.size = strict_align(mod->core_layout.size);
                         ^
kernel/module/main.c:1489:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
   mod->init_layout.size = strict_align(mod->init_layout.size);
                         ^
kernel/module/main.c:1493:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
   mod->init_layout.size = strict_align(mod->init_layout.size);
                         ^
kernel/module/main.c:1504:26: warning: Redundant assignment of 'mod->init_layout.size' to itself. [selfAssignment]
   mod->init_layout.size = strict_align(mod->init_layout.size);
                         ^
kernel/module/main.c:1459:26: warning: Redundant assignment of 'mod->data_layout.size' to itself. [selfAssignment]
   mod->data_layout.size = strict_align(mod->data_layout.size);
                         ^
kernel/module/main.c:1463:26: warning: Redundant assignment of 'mod->data_layout.size' to itself. [selfAssignment]
   mod->data_layout.size = strict_align(mod->data_layout.size);
                         ^
kernel/module/main.c:1467:26: warning: Redundant assignment of 'mod->data_layout.size' to itself. [selfAssignment]
   mod->data_layout.size = strict_align(mod->data_layout.size);
                         ^

This is due to strict_align() being a no-op when
CONFIG_STRICT_MODULE_RWX is not selected.

Transform strict_align() macro into an inline function. It will
allow type checking and avoid the selfAssignment warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index bc5507ab8450..ec104c2950c3 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/mm.h>
 
 #ifndef ARCH_SHF_SMALL
 #define ARCH_SHF_SMALL 0
@@ -30,11 +31,13 @@
  * to ensure complete separation of code and data, but
  * only when CONFIG_STRICT_MODULE_RWX=y
  */
-#ifdef CONFIG_STRICT_MODULE_RWX
-# define strict_align(X) PAGE_ALIGN(X)
-#else
-# define strict_align(X) (X)
-#endif
+static inline unsigned int strict_align(unsigned int size)
+{
+	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		return PAGE_ALIGN(size);
+	else
+		return size;
+}
 
 extern struct mutex module_mutex;
 extern struct list_head modules;
-- 
2.35.3

