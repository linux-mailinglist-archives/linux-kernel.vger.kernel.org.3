Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9044E6BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357221AbiCYBPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357206AbiCYBPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:15:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D26A02D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 18:13:36 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KPkcM5KT6zcbnG;
        Fri, 25 Mar 2022 09:13:23 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 09:13:34 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Mar 2022 09:13:34 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux@armlinux.org.uk>, <alexander.sverdlin@nokia.com>,
        <ardb@kernel.org>, <linus.walleij@linaro.org>, <nico@fluxnic.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: module: Add all unwind tables when load module
Date:   Fri, 25 Mar 2022 09:12:52 +0800
Message-ID: <20220325011252.55844-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For EABI stack unwinding, when loading .ko module
the EXIDX sections will be added to a unwind_table list.

However not all EXIDX sections are added because EXIDX
sections are searched by hardcoded section names.

For functions in other sections such as .ref.text
or .kprobes.text, gcc generates seprated EXIDX sections
(such as .ARM.exidx.ref.text or .ARM.exidx.kprobes.text).

These extra EXIDX sections are not loaded, so when unwinding
functions in these sections, we will failed with:

	unwind: Index not found xxx

To fix that, I refactor the code for searching and adding
EXIDX sections:

- Check section type to search EXIDX tables (0x70000001)
instead of strcmp() the hardcoded names. Then find the
corresponding text sections by their section names.

- Add a unwind_table list in module->arch to save their own
unwind_table instead of the fixed-lenth array.

- Save .ARM.exidx.init.text section ptr, because it should
be cleaned after module init.

Now all EXIDX sections of .ko can be added correctly.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/arm/include/asm/module.h | 17 ++------
 arch/arm/include/asm/unwind.h |  1 +
 arch/arm/kernel/module.c      | 73 +++++++++++++++++------------------
 3 files changed, 40 insertions(+), 51 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index cfffae67c04e..8139b6a33a22 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -3,20 +3,10 @@
 #define _ASM_ARM_MODULE_H
 
 #include <asm-generic/module.h>
-
-struct unwind_table;
+#include <asm/unwind.h>
 
 #ifdef CONFIG_ARM_UNWIND
-enum {
-	ARM_SEC_INIT,
-	ARM_SEC_DEVINIT,
-	ARM_SEC_CORE,
-	ARM_SEC_EXIT,
-	ARM_SEC_DEVEXIT,
-	ARM_SEC_HOT,
-	ARM_SEC_UNLIKELY,
-	ARM_SEC_MAX,
-};
+#define ELF_SECTION_UNWIND 0x70000001
 #endif
 
 #define PLT_ENT_STRIDE		L1_CACHE_BYTES
@@ -36,7 +26,8 @@ struct mod_plt_sec {
 
 struct mod_arch_specific {
 #ifdef CONFIG_ARM_UNWIND
-	struct unwind_table *unwind[ARM_SEC_MAX];
+	struct unwind_table unwind_list;
+	struct unwind_table *init_table;
 #endif
 #ifdef CONFIG_ARM_MODULE_PLTS
 	struct mod_plt_sec	core;
diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index 0f8a3439902d..b51f85417f58 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -24,6 +24,7 @@ struct unwind_idx {
 
 struct unwind_table {
 	struct list_head list;
+	struct list_head mod_list;
 	const struct unwind_idx *start;
 	const struct unwind_idx *origin;
 	const struct unwind_idx *stop;
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 549abcedf795..272f9bdeb1ed 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -459,46 +459,36 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 #ifdef CONFIG_ARM_UNWIND
 	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 	const Elf_Shdr *sechdrs_end = sechdrs + hdr->e_shnum;
-	struct mod_unwind_map maps[ARM_SEC_MAX];
-	int i;
+	struct unwind_table *table_list = &mod->arch.unwind_list;
 
-	memset(maps, 0, sizeof(maps));
+	INIT_LIST_HEAD(&table_list->mod_list);
+	mod->arch.init_table = NULL;
 
 	for (s = sechdrs; s < sechdrs_end; s++) {
-		const char *secname = secstrs + s->sh_name;
+		const unsigned int sectype = s->sh_type;
 
 		if (!(s->sh_flags & SHF_ALLOC))
 			continue;
 
-		if (strcmp(".ARM.exidx.init.text", secname) == 0)
-			maps[ARM_SEC_INIT].unw_sec = s;
-		else if (strcmp(".ARM.exidx", secname) == 0)
-			maps[ARM_SEC_CORE].unw_sec = s;
-		else if (strcmp(".ARM.exidx.exit.text", secname) == 0)
-			maps[ARM_SEC_EXIT].unw_sec = s;
-		else if (strcmp(".ARM.exidx.text.unlikely", secname) == 0)
-			maps[ARM_SEC_UNLIKELY].unw_sec = s;
-		else if (strcmp(".ARM.exidx.text.hot", secname) == 0)
-			maps[ARM_SEC_HOT].unw_sec = s;
-		else if (strcmp(".init.text", secname) == 0)
-			maps[ARM_SEC_INIT].txt_sec = s;
-		else if (strcmp(".text", secname) == 0)
-			maps[ARM_SEC_CORE].txt_sec = s;
-		else if (strcmp(".exit.text", secname) == 0)
-			maps[ARM_SEC_EXIT].txt_sec = s;
-		else if (strcmp(".text.unlikely", secname) == 0)
-			maps[ARM_SEC_UNLIKELY].txt_sec = s;
-		else if (strcmp(".text.hot", secname) == 0)
-			maps[ARM_SEC_HOT].txt_sec = s;
+		if (sectype == ELF_SECTION_UNWIND) {
+			const char *secname = secstrs + s->sh_name;
+			const char *txtname = strcmp(".ARM.exidx", secname) == 0 ?
+				".text" : secname + strlen(".ARM.exidx");
+			const Elf_Shdr *txt_sec = find_mod_section(hdr, sechdrs, txtname);
+
+			if (txt_sec) {
+				struct unwind_table *table =
+					unwind_table_add(s->sh_addr,
+							s->sh_size,
+							txt_sec->sh_addr,
+							txt_sec->sh_size);
+				list_add(&table->mod_list, &table_list->mod_list);
+				/* save init table for module_arch_freeing_init */
+				if (strcmp(".ARM.exidx.init.text", secname) == 0)
+					mod->arch.init_table = table;
+			}
+		}
 	}
-
-	for (i = 0; i < ARM_SEC_MAX; i++)
-		if (maps[i].unw_sec && maps[i].txt_sec)
-			mod->arch.unwind[i] =
-				unwind_table_add(maps[i].unw_sec->sh_addr,
-					         maps[i].unw_sec->sh_size,
-					         maps[i].txt_sec->sh_addr,
-					         maps[i].txt_sec->sh_size);
 #endif
 #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
 	s = find_mod_section(hdr, sechdrs, ".pv_table");
@@ -519,11 +509,13 @@ void
 module_arch_cleanup(struct module *mod)
 {
 #ifdef CONFIG_ARM_UNWIND
-	int i;
+	struct unwind_table *tmp;
+	struct unwind_table *n;
 
-	for (i = 0; i < ARM_SEC_MAX; i++) {
-		unwind_table_del(mod->arch.unwind[i]);
-		mod->arch.unwind[i] = NULL;
+	list_for_each_entry_safe(tmp, n,
+			&mod->arch.unwind_list.mod_list, mod_list) {
+		list_del(&tmp->mod_list);
+		unwind_table_del(tmp);
 	}
 #endif
 }
@@ -531,7 +523,12 @@ module_arch_cleanup(struct module *mod)
 void __weak module_arch_freeing_init(struct module *mod)
 {
 #ifdef CONFIG_ARM_UNWIND
-	unwind_table_del(mod->arch.unwind[ARM_SEC_INIT]);
-	mod->arch.unwind[ARM_SEC_INIT] = NULL;
+	struct unwind_table *init = mod->arch.init_table;
+
+	if (init) {
+		mod->arch.init_table = NULL;
+		list_del(&init->mod_list);
+		unwind_table_del(init);
+	}
 #endif
 }
-- 
2.17.1

