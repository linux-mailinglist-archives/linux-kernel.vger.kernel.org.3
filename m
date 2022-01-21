Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F804962EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350761AbiAUQhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:37:11 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35224 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344800AbiAUQhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:37:05 -0500
Received: from p508fcef5.dip0.t-ipconnect.de ([80.143.206.245] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nAwuI-0008GA-QQ; Fri, 21 Jan 2022 17:36:58 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 04/14] riscv: implement module alternatives
Date:   Fri, 21 Jan 2022 17:36:08 +0100
Message-Id: <20220121163618.351934-5-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121163618.351934-1-heiko@sntech.de>
References: <20220121163618.351934-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows alternatives to also be applied when loading modules
and follows the implementation of other architectures (e.g. arm64).

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/include/asm/alternative.h |  3 ++-
 arch/riscv/kernel/alternative.c      | 16 ++++++++++++---
 arch/riscv/kernel/module.c           | 29 ++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 811bdd8027db..f0657b1b3174 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -18,8 +18,10 @@
 #include <asm/hwcap.h>
 
 #define RISCV_ALTERNATIVES_BOOT		0 /* alternatives applied during regular boot */
+#define RISCV_ALTERNATIVES_MODULE	1 /* alternatives applied during module-init */
 
 void __init apply_boot_alternatives(void);
+void apply_module_alternatives(void *start, size_t length);
 
 struct alt_entry {
 	void *old_ptr;		 /* address of original instruciton or data  */
@@ -37,6 +39,5 @@ struct errata_checkfunc_id {
 void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			      unsigned long archid, unsigned long impid,
 			      unsigned int stage);
-
 #endif
 #endif
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index ead00c508266..e1849faa2fa1 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/cpu.h>
 #include <linux/uaccess.h>
 #include <asm/alternative.h>
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
index 68a9e3d1fe16..a778abd5b8b9 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -11,6 +11,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
+#include <asm/alternative.h>
 #include <asm/sections.h>
 
 static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
@@ -416,3 +417,31 @@ void *module_alloc(unsigned long size)
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
2.30.2

