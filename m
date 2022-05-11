Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707E5523D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbiEKTaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbiEKT3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:29:47 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6FF29CA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:29:44 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nos1g-0004fe-3q; Wed, 11 May 2022 21:29:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 03/12] riscv: implement module alternatives
Date:   Wed, 11 May 2022 21:29:12 +0200
Message-Id: <20220511192921.2223629-4-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511192921.2223629-1-heiko@sntech.de>
References: <20220511192921.2223629-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows alternatives to also be applied when loading modules
and follows the implementation of other architectures (e.g. arm64).

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
---
 arch/riscv/errata/sifive/errata.c    | 14 +++++++++-----
 arch/riscv/include/asm/alternative.h |  3 +++
 arch/riscv/kernel/alternative.c      | 18 +++++++++++++----
 arch/riscv/kernel/module.c           | 29 ++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 4fe03ac41fd7..3e39587a49dc 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/bug.h>
 #include <asm/patch.h>
@@ -54,7 +55,8 @@ static struct errata_info_t errata_list[ERRATA_SIFIVE_NUMBER] = {
 	},
 };
 
-static u32 __init sifive_errata_probe(unsigned long archid, unsigned long impid)
+static u32 __init_or_module sifive_errata_probe(unsigned long archid,
+						unsigned long impid)
 {
 	int idx;
 	u32 cpu_req_errata = 0;
@@ -66,7 +68,7 @@ static u32 __init sifive_errata_probe(unsigned long archid, unsigned long impid)
 	return cpu_req_errata;
 }
 
-static void __init warn_miss_errata(u32 miss_errata)
+static void __init_or_module warn_miss_errata(u32 miss_errata)
 {
 	int i;
 
@@ -79,9 +81,11 @@ static void __init warn_miss_errata(u32 miss_errata)
 	pr_warn("----------------------------------------------------------------\n");
 }
 
-void __init sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
-				     unsigned long archid, unsigned long impid,
-				     unsigned int stage)
+void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
+					       struct alt_entry *end,
+					       unsigned long archid,
+					       unsigned long impid,
+					       unsigned int stage)
 {
 	struct alt_entry *alt;
 	u32 cpu_req_errata = sifive_errata_probe(archid, impid);
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 0ff550667e94..0859529ff08e 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -20,8 +20,10 @@
 #include <asm/hwcap.h>
 
 #define RISCV_ALTERNATIVES_BOOT		0 /* alternatives applied during regular boot */
+#define RISCV_ALTERNATIVES_MODULE	1 /* alternatives applied during module-init */
 
 void __init apply_boot_alternatives(void);
+void apply_module_alternatives(void *start, size_t length);
 
 struct alt_entry {
 	void *old_ptr;		 /* address of original instruciton or data  */
@@ -43,6 +45,7 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 #else /* CONFIG_RISCV_ALTERNATIVE */
 
 static inline void apply_boot_alternatives(void) { }
+static inline void apply_module_alternatives(void *start, size_t length) { }
 
 #endif /* CONFIG_RISCV_ALTERNATIVE */
 
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 02db62f55bac..223770b3945c 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/uaccess.h>
 #include <asm/alternative.h>
@@ -23,7 +24,7 @@ static struct cpu_manufacturer_info_t {
 
 static void (*vendor_patch_func)(struct alt_entry *begin, struct alt_entry *end,
 				 unsigned long archid, unsigned long impid,
-				 unsigned int stage) __initdata;
+				 unsigned int stage) __initdata_or_module;
 
 static inline void __init riscv_fill_cpu_mfr_info(void)
 {
@@ -58,9 +59,9 @@ static void __init init_alternative(void)
  * a feature detect on the boot CPU). No need to worry about other CPUs
  * here.
  */
-static void __init _apply_alternatives(struct alt_entry *begin,
-				       struct alt_entry *end,
-				       unsigned int stage)
+static void __init_or_module _apply_alternatives(struct alt_entry *begin,
+						 struct alt_entry *end,
+						 unsigned int stage)
 {
 	if (!vendor_patch_func)
 		return;
@@ -81,3 +82,12 @@ void __init apply_boot_alternatives(void)
 			    (struct alt_entry *)__alt_end,
 			    RISCV_ALTERNATIVES_BOOT);
 }
+
+#ifdef CONFIG_MODULES
+void apply_module_alternatives(void *start, size_t length)
+{
+	_apply_alternatives((struct alt_entry *)start,
+			    (struct alt_entry *)(start + length),
+			    RISCV_ALTERNATIVES_MODULE);
+}
+#endif
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index c29cef90d1dd..91fe16bfaa07 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -11,6 +11,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
+#include <asm/alternative.h>
 #include <asm/sections.h>
 
 /*
@@ -427,3 +428,31 @@ void *module_alloc(unsigned long size)
 				    __builtin_return_address(0));
 }
 #endif
+
+static const Elf_Shdr *find_section(const Elf_Ehdr *hdr,
+				    const Elf_Shdr *sechdrs,
+				    const char *name)
+{
+	const Elf_Shdr *s, *se;
+	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
+		if (strcmp(name, secstrs + s->sh_name) == 0)
+			return s;
+	}
+
+	return NULL;
+}
+
+int module_finalize(const Elf_Ehdr *hdr,
+		    const Elf_Shdr *sechdrs,
+		    struct module *me)
+{
+	const Elf_Shdr *s;
+
+	s = find_section(hdr, sechdrs, ".alternative");
+	if (s)
+		apply_module_alternatives((void *)s->sh_addr, s->sh_size);
+
+	return 0;
+}
-- 
2.35.1

