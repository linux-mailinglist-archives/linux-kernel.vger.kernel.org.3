Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EEF4BFC11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiBVPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiBVPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:13:09 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33DC122209;
        Tue, 22 Feb 2022 07:12:43 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K32j06Ppqz9sSm;
        Tue, 22 Feb 2022 16:12:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gpL9468prGaD; Tue, 22 Feb 2022 16:12:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K32hw5SKCz9sSp;
        Tue, 22 Feb 2022 16:12:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A87958B78B;
        Tue, 22 Feb 2022 16:12:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VCrlBGaqKa8Y; Tue, 22 Feb 2022 16:12:32 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.78])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 18AE38B779;
        Tue, 22 Feb 2022 16:12:32 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MFCOCK1087472
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 16:12:24 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MFCOYT1087471;
        Tue, 22 Feb 2022 16:12:24 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] module: Rework layout alignment to avoid BUG_ON()s
Date:   Tue, 22 Feb 2022 16:12:20 +0100
Message-Id: <f13c61751da92ca56ea06d5687e567c3468c6ab3.1645542272.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645542272.git.christophe.leroy@csgroup.eu>
References: <cover.1645542272.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645542740; l=4062; s=20211009; h=from:subject:message-id; bh=B6o4h6cERPwa8CFDs6MGboxA58APQg/DlLdWUkJkEqc=; b=MjEJs9vr2b2PO2/bSDy4EMZqDCzumFRIm5sWXqxGq6N3QjK9uccql8N2/C089xWNSVjiOYSatGAA QoTTrAp0AavfrwD/4Nt409AMn/08A7mc5F7g8p4RmJTxpjfe1KpV
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

Perform layout alignment verification up front and WARN_ON()
and fail module loading instead of crashing the machine.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h   |  1 +
 kernel/module/main.c       |  5 +++++
 kernel/module/strict_rwx.c | 28 +++++++++++++++++++---------
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 276e3f49a4ae..f3dcd40f300c 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -187,6 +187,7 @@ void module_enable_nx(const struct module *mod);
 void module_enable_x(const struct module *mod);
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				char *secstrings, struct module *mod);
+bool module_check_misalignment(const struct module *mod);
 
 #ifdef CONFIG_MODULE_SIG
 int module_sig_check(struct load_info *info, int flags);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 47addf849ef7..4876e2beb5b6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2596,6 +2596,9 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	/* This relies on module_mutex for list integrity. */
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 
+	if (module_check_misalignment(mod))
+		goto out_misaligned;
+
 	module_enable_ro(mod, false);
 	module_enable_nx(mod);
 	module_enable_x(mod);
@@ -2609,6 +2612,8 @@ static int complete_formation(struct module *mod, struct load_info *info)
 
 	return 0;
 
+out_misaligned:
+	err = -EINVAL;
 out:
 	mutex_unlock(&module_mutex);
 	return err;
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 6b99be9e88e1..14fbea66f12f 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -42,9 +42,6 @@ static void frob_text(const struct module_layout *layout,
 static void frob_rodata(const struct module_layout *layout,
 		 int (*set_memory)(unsigned long start, int num_pages))
 {
-	BUG_ON(!PAGE_ALIGNED(layout->base));
-	BUG_ON(!PAGE_ALIGNED(layout->text_size));
-	BUG_ON(!PAGE_ALIGNED(layout->ro_size));
 	set_memory((unsigned long)layout->base + layout->text_size,
 		   (layout->ro_size - layout->text_size) >> PAGE_SHIFT);
 }
@@ -52,9 +49,6 @@ static void frob_rodata(const struct module_layout *layout,
 static void frob_ro_after_init(const struct module_layout *layout,
 			int (*set_memory)(unsigned long start, int num_pages))
 {
-	BUG_ON(!PAGE_ALIGNED(layout->base));
-	BUG_ON(!PAGE_ALIGNED(layout->ro_size));
-	BUG_ON(!PAGE_ALIGNED(layout->ro_after_init_size));
 	set_memory((unsigned long)layout->base + layout->ro_size,
 		   (layout->ro_after_init_size - layout->ro_size) >> PAGE_SHIFT);
 }
@@ -62,13 +56,29 @@ static void frob_ro_after_init(const struct module_layout *layout,
 static void frob_writable_data(const struct module_layout *layout,
 			int (*set_memory)(unsigned long start, int num_pages))
 {
-	BUG_ON(!PAGE_ALIGNED(layout->base));
-	BUG_ON(!PAGE_ALIGNED(layout->ro_after_init_size));
-	BUG_ON(!PAGE_ALIGNED(layout->size));
 	set_memory((unsigned long)layout->base + layout->ro_after_init_size,
 		   (layout->size - layout->ro_after_init_size) >> PAGE_SHIFT);
 }
 
+static bool layout_check_misalignment(const struct module_layout *layout)
+{
+	return WARN_ON(!PAGE_ALIGNED(layout->base)) ||
+	       WARN_ON(!PAGE_ALIGNED(layout->text_size)) ||
+	       WARN_ON(!PAGE_ALIGNED(layout->ro_size)) ||
+	       WARN_ON(!PAGE_ALIGNED(layout->ro_after_init_size)) ||
+	       WARN_ON(!PAGE_ALIGNED(layout->size));
+}
+
+bool module_check_misalignment(const struct module *mod)
+{
+	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		return false;
+
+	return layout_check_misalignment(&mod->core_layout) ||
+	       layout_check_misalignment(&mod->data_layout) ||
+	       layout_check_misalignment(&mod->init_layout);
+}
+
 void module_enable_x(const struct module *mod)
 {
 	if (!PAGE_ALIGNED(mod->core_layout.base) ||
-- 
2.34.1

