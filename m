Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8156A51EEEC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbiEHQUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiEHQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:20:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085CBB7E3
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3CD3B80DBE
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 16:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDC1C385C0;
        Sun,  8 May 2022 16:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652026595;
        bh=1D217r1rSI/uUeSIUljN5J553Ajo8zPgW0SHZ2rk+io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bkxkj8L1JiFS7MiCImm50YEZA/y0LoDC6dK+ZhYwc59l2AdRol9CFhGrkpuAUDYjy
         Wdv7f9x4kCNhOQdPCB4cKzmvR8VRc1tJchGSEuv5jGbQ2/8WhXcS3CBxGK07H1P2S0
         feZH21gUL3s8D9XG0WkxWHeDVH2G5SlXZkg8nE1O+Wl5lAFCBfEhtsmKSCyMtarMww
         Y6MF9P2PeoJi937nqmfY8bazzEtLdNZ8/3bLh/+Wd2I2D0zhnaFhx6DQG/fF7KUW0y
         hK2FqBj+6hTibsMrhxPSE8UthdSkITPTWpFTtX8MJBE1il89sfJrAeHsnWFfBmWWLE
         zCQK2m8bJ9Xkw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v2 2/4] riscv: introduce unified static key mechanism for CPU features
Date:   Mon,  9 May 2022 00:07:47 +0800
Message-Id: <20220508160749.984-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220508160749.984-1-jszhang@kernel.org>
References: <20220508160749.984-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, riscv has several features why may not be supported on all
riscv platforms, for example, FPU, SV48 and so on. To support unified
kernel Image style, we need to check whether the feature is suportted
or not. If the check sits at hot code path, then performance will be
impacted a lot. static key can be used to solve the issue. In the past
FPU support has been converted to use static key mechanism. I believe
we will have similar cases in the future.

Similar as arm64 does(in fact, some code is borrowed from arm64), this
patch tries to add an unified mechanism to use static keys for all
the cpu features by implementing an array of default-false static keys
and enabling them when detected. The cpus_have_*_cap() check uses the
static keys if riscv_const_caps_ready is finalized, otherwise the
compiler generates the bitmap test.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Makefile                 |  3 +
 arch/riscv/include/asm/cpufeature.h | 94 +++++++++++++++++++++++++++++
 arch/riscv/kernel/cpufeature.c      | 23 +++++++
 arch/riscv/tools/Makefile           | 22 +++++++
 arch/riscv/tools/cpucaps            |  5 ++
 arch/riscv/tools/gen-cpucaps.awk    | 40 ++++++++++++
 6 files changed, 187 insertions(+)
 create mode 100644 arch/riscv/include/asm/cpufeature.h
 create mode 100644 arch/riscv/tools/Makefile
 create mode 100644 arch/riscv/tools/cpucaps
 create mode 100755 arch/riscv/tools/gen-cpucaps.awk

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7d81102cffd4..f4df67369d84 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -154,3 +154,6 @@ PHONY += rv64_randconfig
 rv64_randconfig:
 	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/64-bit.config \
 		-f $(srctree)/Makefile randconfig
+
+archprepare:
+	$(Q)$(MAKE) $(build)=arch/riscv/tools kapi
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
new file mode 100644
index 000000000000..d80ddd2f3b49
--- /dev/null
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#ifndef __ASM_CPUFEATURE_H
+#define __ASM_CPUFEATURE_H
+
+#include <asm/cpucaps.h>
+
+#include <linux/bug.h>
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+
+extern DECLARE_BITMAP(cpu_hwcaps, RISCV_NCAPS);
+extern struct static_key_false cpu_hwcap_keys[RISCV_NCAPS];
+extern struct static_key_false riscv_const_caps_ready;
+
+static __always_inline bool system_capabilities_finalized(void)
+{
+	return static_branch_likely(&riscv_const_caps_ready);
+}
+
+/*
+ * Test for a capability with a runtime check.
+ *
+ * Before the capability is detected, this returns false.
+ */
+static inline bool cpus_have_cap(unsigned int num)
+{
+	if (num >= RISCV_NCAPS)
+		return false;
+	return test_bit(num, cpu_hwcaps);
+}
+
+/*
+ * Test for a capability without a runtime check.
+ *
+ * Before capabilities are finalized, this returns false.
+ * After capabilities are finalized, this is patched to avoid a runtime check.
+ *
+ * @num must be a compile-time constant.
+ */
+static __always_inline bool __cpus_have_const_cap(int num)
+{
+	if (num >= RISCV_NCAPS)
+		return false;
+	return static_branch_unlikely(&cpu_hwcap_keys[num]);
+}
+
+/*
+ * Test for a capability without a runtime check.
+ *
+ * Before capabilities are finalized, this will BUG().
+ * After capabilities are finalized, this is patched to avoid a runtime check.
+ *
+ * @num must be a compile-time constant.
+ */
+static __always_inline bool cpus_have_final_cap(int num)
+{
+	if (system_capabilities_finalized())
+		return __cpus_have_const_cap(num);
+	else
+		BUG();
+}
+
+/*
+ * Test for a capability, possibly with a runtime check.
+ *
+ * Before capabilities are finalized, this behaves as cpus_have_cap().
+ * After capabilities are finalized, this is patched to avoid a runtime check.
+ *
+ * @num must be a compile-time constant.
+ */
+static __always_inline bool cpus_have_const_cap(int num)
+{
+	if (system_capabilities_finalized())
+		return __cpus_have_const_cap(num);
+	else
+		return cpus_have_cap(num);
+}
+
+static inline void cpus_set_cap(unsigned int num)
+{
+	if (num >= RISCV_NCAPS) {
+		pr_warn("Attempt to set an illegal CPU capability (%d >= %d)\n",
+			num, RISCV_NCAPS);
+	} else {
+		__set_bit(num, cpu_hwcaps);
+	}
+}
+
+#endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1b2d42d7f589..e6c72cad0c1c 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/of.h>
+#include <asm/cpufeature.h>
 #include <asm/processor.h>
 #include <asm/hwcap.h>
 #include <asm/smp.h>
@@ -25,6 +26,15 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
 #endif
 
+DECLARE_BITMAP(cpu_hwcaps, RISCV_NCAPS);
+EXPORT_SYMBOL(cpu_hwcaps);
+
+DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, RISCV_NCAPS);
+EXPORT_SYMBOL(cpu_hwcap_keys);
+
+DEFINE_STATIC_KEY_FALSE(riscv_const_caps_ready);
+EXPORT_SYMBOL(riscv_const_caps_ready);
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -62,6 +72,17 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
 }
 EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
 
+static void __init enable_cpu_capabilities(void)
+{
+	int i;
+
+	for (i = 0; i < RISCV_NCAPS; i++) {
+		if (!cpus_have_cap(i))
+			continue;
+		static_branch_enable(&cpu_hwcap_keys[i]);
+	}
+}
+
 void __init riscv_fill_hwcap(void)
 {
 	struct device_node *node;
@@ -236,4 +257,6 @@ void __init riscv_fill_hwcap(void)
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
 		static_branch_enable(&cpu_hwcap_fpu);
 #endif
+	enable_cpu_capabilities();
+	static_branch_enable(&riscv_const_caps_ready);
 }
diff --git a/arch/riscv/tools/Makefile b/arch/riscv/tools/Makefile
new file mode 100644
index 000000000000..932b4fe5c768
--- /dev/null
+++ b/arch/riscv/tools/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+
+gen := arch/$(ARCH)/include/generated
+kapi := $(gen)/asm
+
+kapi-hdrs-y := $(kapi)/cpucaps.h
+
+targets += $(addprefix ../../../,$(gen-y) $(kapi-hdrs-y))
+
+PHONY += kapi
+
+kapi:   $(kapi-hdrs-y) $(gen-y)
+
+# Create output directory if not already present
+_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+
+quiet_cmd_gen_cpucaps = GEN     $@
+      cmd_gen_cpucaps = mkdir -p $(dir $@) && \
+                     $(AWK) -f $(filter-out $(PHONY),$^) > $@
+
+$(kapi)/cpucaps.h: $(src)/gen-cpucaps.awk $(src)/cpucaps FORCE
+	$(call if_changed,gen_cpucaps)
diff --git a/arch/riscv/tools/cpucaps b/arch/riscv/tools/cpucaps
new file mode 100644
index 000000000000..cb1ff2747859
--- /dev/null
+++ b/arch/riscv/tools/cpucaps
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Internal CPU capabilities constants, keep this list sorted
+
+HAS_NO_FPU
diff --git a/arch/riscv/tools/gen-cpucaps.awk b/arch/riscv/tools/gen-cpucaps.awk
new file mode 100755
index 000000000000..52a1e1b064ad
--- /dev/null
+++ b/arch/riscv/tools/gen-cpucaps.awk
@@ -0,0 +1,40 @@
+#!/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+# gen-cpucaps.awk: riscv cpucaps header generator
+#
+# Usage: awk -f gen-cpucaps.awk cpucaps.txt
+
+# Log an error and terminate
+function fatal(msg) {
+	print "Error at line " NR ": " msg > "/dev/stderr"
+	exit 1
+}
+
+# skip blank lines and comment lines
+/^$/ { next }
+/^#/ { next }
+
+BEGIN {
+	print "#ifndef __ASM_CPUCAPS_H"
+	print "#define __ASM_CPUCAPS_H"
+	print ""
+	print "/* Generated file - do not edit */"
+	cap_num = 0
+	print ""
+}
+
+/^[vA-Z0-9_]+$/ {
+	printf("#define RISCV_%-30s\t%d\n", $0, cap_num++)
+	next
+}
+
+END {
+	printf("#define RISCV_NCAPS\t\t\t\t%d\n", cap_num)
+	print ""
+	print "#endif /* __ASM_CPUCAPS_H */"
+}
+
+# Any lines not handled by previous rules are unexpected
+{
+	fatal("unhandled statement")
+}
-- 
2.34.1

