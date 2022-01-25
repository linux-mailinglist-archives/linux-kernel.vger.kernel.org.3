Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1139349B980
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241940AbiAYRAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:00:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38304 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587156AbiAYQ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:58:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 651D9B81913
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942B9C340E0;
        Tue, 25 Jan 2022 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643129894;
        bh=I+ef37gDpw0j39EXTaSOMc1BVOQf5hfN3THc7cxFln4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNch9TQEHH/tkZsu3oImGUVpi5zTGrQuB98uq8baxAzs5rnN9gpXoLpPbrzc0+fD5
         rDrkMSNvpYO7pF3Bz8B3FttaIRxkLLJXcKv6AlXE0rR9W39fksYPrBfWlbDoqwEtFO
         TT1Q1CwbWX6aPx7ujSHkR+1DuvlFry5AuwywBzHILMAS4mV+xyXD2rjl6ATni7xkIG
         adoTUQtxiQg7oSmaU3ZB/sRFfJH6CqEIo6GkDeSsk5JiHirXKb8ZZmeae8BTDHSGF7
         QKxDjm8m3Bahe9kYNO+jGZbEUbkFsmD7YD0w6Rsssx62FRk5fsL1LMKDiJ0sH1AzLY
         OubmcVw9t+nyg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH 1/3] riscv: introduce unified static key mechanism for CPU features
Date:   Wed, 26 Jan 2022 00:50:34 +0800
Message-Id: <20220125165036.987-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125165036.987-1-jszhang@kernel.org>
References: <20220125165036.987-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 8a107ed18b0d..65c63023c8a8 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -148,3 +148,6 @@ PHONY += rv64_randconfig
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
index d959d207a40d..09331abfa70c 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/of.h>
+#include <asm/cpufeature.h>
 #include <asm/processor.h>
 #include <asm/hwcap.h>
 #include <asm/smp.h>
@@ -22,6 +23,15 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
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
@@ -59,6 +69,17 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
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
@@ -148,4 +169,6 @@ void __init riscv_fill_hwcap(void)
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

