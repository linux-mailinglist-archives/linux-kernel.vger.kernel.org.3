Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC756AE17
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiGGWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbiGGWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:05:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A06F2CC8A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:04:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o4so28141686wrh.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7E7EjtLMLS23T2bsvt4SNELdhBh6QzAyNMiy3mGJiIQ=;
        b=IpDj5afJY9kCBQK/vOv90bAyHCUlUto7onzuO/nC3gDHXS58GwaZXLBMRi1NpV8ze2
         7b17aX7eg5pNGdN+ljCBcQEc7Flzi0KrNPzi/DSS83gxm/xyJ6d8Y10aQ11y5TH8tSm7
         qxtNVNxZoHIHsKaon5dlXSvMpW9bZI5FVCtqvHtnlP/HB2Wrg8hCLpJp20X1soauPaZK
         P6wZGFi3ZwZviCg8NdSlenWNPuXDtvx6V91JHpVX/vU12PqONkh1XKjIVuPe/Qsc7Scw
         3xn/BvmyMLVj2asQTVoDw2k2nLgR7SK989r2ZPBZIJK8ddDzmN3y0lb0xRMqXv3YSmq0
         gvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7E7EjtLMLS23T2bsvt4SNELdhBh6QzAyNMiy3mGJiIQ=;
        b=uhvBfQj37fo/4vWi1MiZCanRyofHijNNF/tIGoNVUcr8HxXg37QFYq5n5FnnXCKLLE
         g1YynnqbSlhXb5iWaBtQXhzHO0Uer2TBxMjZ5R9EE1YgoAkGYDDP7v6NVH9cQX+6zIcN
         9Kx3DQDJuF1tLHzZOF16u9U1EOav2ZYlGflL9iB5dUhoX+i+SdlghelmWmJvIKxnuR94
         U9JqFSBc/pqB/zBFTMfnTr8G0i1NK+iPUGvQlI2qxXsjDZ4mCIwgZjCUjKZ9ZOSsZi2n
         FVSaFVGG8Whgn8OerbiFKPQAwiUmAHbQ91LJ9dgzJVGSqSslCxg+8o2EA79RUcJGB0AZ
         sOdQ==
X-Gm-Message-State: AJIora+mMnogC0huarh5es2Nk4Vr2sON2feFGJwbEszy9KwkfyFKB3fE
        DCgkKdSD1ikWcbOh7X+E8YchsA==
X-Google-Smtp-Source: AGRyM1vvwbxzDYSubtFunJO4nqpmeLLb8LTkGF5ahzlCzgxU+DSPa3gNVAuFvhOqaznOY1rAHaAZfA==
X-Received: by 2002:a5d:5c05:0:b0:21d:83b4:d339 with SMTP id cc5-20020a5d5c05000000b0021d83b4d339mr40615wrb.611.1657231497860;
        Thu, 07 Jul 2022 15:04:57 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm38625743wrb.70.2022.07.07.15.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:04:57 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Changbin Du <changbin.du@intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: [RFC 1/4] riscv: arch-topology: fix default topology reporting
Date:   Thu,  7 Jul 2022 23:04:34 +0100
Message-Id: <20220707220436.4105443-2-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220707220436.4105443-1-mail@conchuod.ie>
References: <20220707220436.4105443-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

RISC-V has no sane defaults to fall back on where there is no cpu-map
in the devicetree.
Without sane defaults, the package, core and thread IDs are all set to
-1. This causes user-visible inaccuracies for tools like hwloc/lstopo
which rely on the sysfs cpu topology files to detect a system's
topology.

Add sane defaults in ~the exact same way as ARM64.

CC: stable@vger.kernel.org
Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
Link: https://github.com/open-mpi/hwloc/issues/536
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Sudeep suggested that this be backported rather than the changes to
the devicetrees adding cpu-map since that property is optional.
That patchset is still valid in it's own right.

Changes since v1:
- removed the GENERIC_ARCH_TOPOLOGY dependancy on SMP
- removed a duplicate call to update_siblings_masks()
---
 arch/riscv/Kconfig                |  2 +-
 arch/riscv/include/asm/topology.h | 13 +++++++++++++
 arch/riscv/kernel/Makefile        |  1 +
 arch/riscv/kernel/smpboot.c       |  5 ++++-
 arch/riscv/kernel/topology.c      | 32 +++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/topology.h
 create mode 100644 arch/riscv/kernel/topology.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2af0701b7518..4b6c2fdbb57c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -52,7 +52,7 @@ config RISCV
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE
 	select EDAC_SUPPORT
-	select GENERIC_ARCH_TOPOLOGY if SMP
+	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_EARLY_IOREMAP
diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
new file mode 100644
index 000000000000..36bc6ecda898
--- /dev/null
+++ b/arch/riscv/include/asm/topology.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries
+ */
+
+#ifndef _ASM_RISCV_TOPOLOGY_H
+#define _ASM_RISCV_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+void store_cpu_topology(unsigned int cpuid);
+
+#endif /* _ASM_RISCV_TOPOLOGY_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index c71d6591d539..9518882ba6f9 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
+obj-y	+= topology.o
 obj-y	+= probes/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index f1e4948a4b52..a8239b4b61f3 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -32,6 +32,7 @@
 #include <asm/sections.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
+#include <asm/topology.h>
 
 #include "head.h"
 
@@ -40,6 +41,8 @@ static DECLARE_COMPLETION(cpu_running);
 void __init smp_prepare_boot_cpu(void)
 {
 	init_cpu_topology();
+
+	store_cpu_topology(smp_processor_id());
 }
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
@@ -161,9 +164,9 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	store_cpu_topology(curr_cpuid);
 	notify_cpu_starting(curr_cpuid);
 	numa_add_cpu(curr_cpuid);
-	update_siblings_masks(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
 
 	/*
diff --git a/arch/riscv/kernel/topology.c b/arch/riscv/kernel/topology.c
new file mode 100644
index 000000000000..db72862bd5b5
--- /dev/null
+++ b/arch/riscv/kernel/topology.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries
+ *
+ * Based on the arm64 version, which was in turn based on arm32, which was
+ * ultimately based on sh's.
+ * The arm64 version was listed as:
+ * Copyright (C) 2011,2013,2014 Linaro Limited.
+ */
+
+#include <linux/arch_topology.h>
+#include <linux/topology.h>
+#include <asm/topology.h>
+
+void store_cpu_topology(unsigned int cpuid)
+{
+	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
+
+	if (cpuid_topo->package_id != -1)
+		goto topology_populated;
+
+	cpuid_topo->thread_id = -1;
+	cpuid_topo->core_id = cpuid;
+	cpuid_topo->package_id = cpu_to_node(cpuid);
+
+	pr_debug("CPU%u: package %d core %d thread %d\n",
+		 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
+		 cpuid_topo->thread_id);
+
+topology_populated:
+	update_siblings_masks(cpuid);
+}
-- 
2.37.0

