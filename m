Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37A859733D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbiHQPks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbiHQPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:40:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66D0A30F56
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:40:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5A52113E;
        Wed, 17 Aug 2022 08:40:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B62F53F70D;
        Wed, 17 Aug 2022 08:40:32 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     andy.shevchenko@gmail.com, ardb@kernel.org,
        catalin.marinas@arm.com, jvgediya@linux.ibm.com,
        mark.rutland@arm.com, rdunlap@infradead.org, will@kernel.org,
        willy@infradead.org
Subject: [PATCH] arm64: fix rodata=full
Date:   Wed, 17 Aug 2022 16:40:22 +0100
Message-Id: <20220817154022.3974645-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, "rodata=full" has been suppored (but not documented) since
commit:

  c55191e96caa9d78 ("arm64: mm: apply r/o permissions of VM areas to its linear alias as well")

As it's necessary to determine the rodata configuration early during
boot, arm64 has an early_param() handler for this, whereas init/main.c
has a __setup() handler which is run later.

Unfortunately, this split meant that since commit:

  f9a40b0890658330 ("init/main.c: return 1 from handled __setup() functions")

... passing "rodata=full" would result in a spurious warning from the
__setup() handler (though RO permissions would be configured
appropriately).

Further, "rodata=full" has been broken since commit:

  0d6ea3ac94ca77c5 ("lib/kstrtox.c: add "false"/"true" support to kstrtobool()")

... which caused strtobool() to parse "full" as false (in addition to
many other values not documented for the "rodata=" kernel parameter.

This patch fixes this breakage by:

* Moving the core parameter parser to an __early_param(), such that it
  is available early.

* Adding an (optional) arch hook which arm64 can use to parse "full".

* Updating the documentation to mention that "full" is valid for arm64.

* Having the core parameter parser handle "on" and "off" explicitly,
  such that any undocumented values (e.g. typos such as "ful") are
  reported as errors rather than being silently accepted.

Note that __setup() and early_param() have opposite conventions for
their return values, where __setup() uses 1 to indicate a parameter was
handled and early_param() uses 0 to indicate a parameter was handled.

Fixes: f9a40b0890658330 ("init/main.c: return 1 from handled __setup() functions")
Fixes: 0d6ea3ac94ca77c5 ("lib/kstrtox.c: add "false"/"true" support to kstrtobool()")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jagdish Gediya <jvgediya@linux.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 .../admin-guide/kernel-parameters.txt          |  2 ++
 arch/arm64/include/asm/setup.h                 | 17 +++++++++++++++++
 arch/arm64/mm/mmu.c                            | 18 ------------------
 init/main.c                                    | 18 +++++++++++++++---
 4 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d7f30902fda02..426fa892d311a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5331,6 +5331,8 @@
 	rodata=		[KNL]
 		on	Mark read-only kernel memory as read-only (default).
 		off	Leave read-only kernel memory writable for debugging.
+		full	Mark read-only kernel memory and aliases as read-only
+		        [arm64]
 
 	rockchip.usb_uart
 			Enable the uart passthrough on the designated usb port
diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index 6437df6617009..f4af547ef54ca 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -3,6 +3,8 @@
 #ifndef __ARM64_ASM_SETUP_H
 #define __ARM64_ASM_SETUP_H
 
+#include <linux/string.h>
+
 #include <uapi/asm/setup.h>
 
 void *get_early_fdt_ptr(void);
@@ -14,4 +16,19 @@ void early_fdt_map(u64 dt_phys);
 extern phys_addr_t __fdt_pointer __initdata;
 extern u64 __cacheline_aligned boot_args[4];
 
+static inline bool arch_parse_debug_rodata(char *arg)
+{
+	extern bool rodata_enabled;
+	extern bool rodata_full;
+
+	if (arg && !strcmp(arg, "full")) {
+		rodata_enabled = true;
+		rodata_full = true;
+		return true;
+	}
+
+	return false;
+}
+#define arch_parse_debug_rodata arch_parse_debug_rodata
+
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index db7c4e6ae57bb..e7ad44585f40a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -642,24 +642,6 @@ static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
 	vm_area_add_early(vma);
 }
 
-static int __init parse_rodata(char *arg)
-{
-	int ret = strtobool(arg, &rodata_enabled);
-	if (!ret) {
-		rodata_full = false;
-		return 0;
-	}
-
-	/* permit 'full' in addition to boolean options */
-	if (strcmp(arg, "full"))
-		return -EINVAL;
-
-	rodata_enabled = true;
-	rodata_full = true;
-	return 0;
-}
-early_param("rodata", parse_rodata);
-
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __init map_entry_trampoline(void)
 {
diff --git a/init/main.c b/init/main.c
index 91642a4e69be6..1fe7942f5d4a8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1446,13 +1446,25 @@ static noinline void __init kernel_init_freeable(void);
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
 bool rodata_enabled __ro_after_init = true;
+
+#ifndef arch_parse_debug_rodata
+static inline bool arch_parse_debug_rodata(char *str) { return false; }
+#endif
+
 static int __init set_debug_rodata(char *str)
 {
-	if (strtobool(str, &rodata_enabled))
+	if (arch_parse_debug_rodata(str))
+		return 0;
+
+	if (str && !strcmp(str, "on"))
+		rodata_enabled = true;
+	else if (str && !strcmp(str, "off"))
+		rodata_enabled = false;
+	else
 		pr_warn("Invalid option string for rodata: '%s'\n", str);
-	return 1;
+	return 0;
 }
-__setup("rodata=", set_debug_rodata);
+early_param("rodata", set_debug_rodata);
 #endif
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-- 
2.30.2

