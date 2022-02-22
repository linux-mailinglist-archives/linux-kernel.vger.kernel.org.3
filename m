Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D67D4BF646
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiBVKjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiBVKjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:39:42 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8BE1520E6;
        Tue, 22 Feb 2022 02:39:17 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K2wdc0fVsz9sT9;
        Tue, 22 Feb 2022 11:39:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2O9RG79dWjM2; Tue, 22 Feb 2022 11:39:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K2wdb6RWSz9sT4;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C9B608B77C;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wfwOKewn2RBv; Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A445D8B764;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MAd66I1076205
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:39:06 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MAd6pm1076204;
        Tue, 22 Feb 2022 11:39:06 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] module: Have kernel/module/ dedicated to CONFIG_MODULES
Date:   Tue, 22 Feb 2022 11:38:55 +0100
Message-Id: <fae2502b6492059cfd9bbf2c3b5a00e8048f5b90.1645526008.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645526008.git.christophe.leroy@csgroup.eu>
References: <cover.1645526008.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645526317; l=2248; s=20211009; h=from:subject:message-id; bh=U293g+lTgs0inrdbxXPK4v+1d094S6shdcVBALPrnlM=; b=eS6Qa+cXgZONSOWXof3UZfhfQvOyNb0IZDb3SEsE87arTGp2VLmxbBJKhpokG3Rxc27SrWQTKdnT rHGJ9CLnDY0czeMhIdpGMQYH+XdLne82cw6tJNtjXYeWSny1BUYJ
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

Move signature.c back into kernel/ because it is used by
more than modules.

Then build kernel/module/ only when CONFIG_MODULES is selected.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Ideally this patch should be squashed in Aaron's series patch 1
---
 kernel/Makefile                                   | 3 ++-
 kernel/module/Makefile                            | 5 +----
 kernel/{module/signature.c => module_signature.c} | 0
 3 files changed, 3 insertions(+), 5 deletions(-)
 rename kernel/{module/signature.c => module_signature.c} (100%)

diff --git a/kernel/Makefile b/kernel/Makefile
index 04cb6932c0d3..717075b65deb 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -52,7 +52,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
-obj-y += module/
+obj-$(CONFIG_MODULES) += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
@@ -66,6 +66,7 @@ ifneq ($(CONFIG_SMP),y)
 obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
+obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index b57953bd47eb..5fe90d246fcc 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -7,12 +7,10 @@
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_main.o := n
 
-obj-$(CONFIG_MODULES) += main.o
+obj-y += main.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
-obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
-ifdef CONFIG_MODULES
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
@@ -20,4 +18,3 @@ obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PROC_FS) += procfs.o
 obj-$(CONFIG_SYSFS) += sysfs.o
 obj-$(CONFIG_MODVERSIONS) += version.o
-endif
diff --git a/kernel/module/signature.c b/kernel/module_signature.c
similarity index 100%
rename from kernel/module/signature.c
rename to kernel/module_signature.c
-- 
2.34.1

