Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9018356921A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiGFSqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiGFSqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:46:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E8228704
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:46:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bk26so8203811wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGvdz6Rm9o6IiK39KaZUlJWK5Ze9j+QdwV7tWQUA7MU=;
        b=Li8ztQ8ExNO98qv/gkCCl4oswxBwJHWf8Bm9oWaRjJHFNYPxPlYLiX0mSCO0sOMqOZ
         Jhydkww51gb4Uzdx+NtkZTefyLEIV6NWETM39flo7p/dKteM1j/ggg7MnYCvVObggzGx
         /6ylVdcmljUpSq9OA/i9kO9GcpyjtCl9dga4EYhHfBnP7Q17+zwBX7nU4w7dZBFsqalY
         Yd7k/sCuBcRMkaWfTcuX72xrU6115zPPyaV02AFu/3IWfD56DXTDQ3eyM0oGlHJ8lAU+
         A78ff5CDf76QCWcY5fxSv7JIhD3rFlS+r++abSr30I0PZjAV+bzU7DYvLwYqstqyn6Dj
         x4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGvdz6Rm9o6IiK39KaZUlJWK5Ze9j+QdwV7tWQUA7MU=;
        b=YNQ8poKe40XVKG+OYrWFSp0NVAUib8MojGwR7mLQe0SZSXy5agICQnZwCjYHqdiseH
         29x3dUOwSyRVBjfHfAsyaBSC7mot/2xno+dAJCwzq2a0YrcZhVg/dOdenqIDrqiWRKS0
         WYC8PGGDR/qHe7uoZ6xO5tI+wvXSxXB8gVOJkHBzetQqJ3AMjpe4bLbm/wocBabfj/V6
         +ddAZUXbr2Tukx+R4X9rt+7lvLVL0f+7eFz3pbhi5D+6I8BXTqlbi3Bl3dGH2++qwxCJ
         5wDCcSucGxPLTK1WkHBfTX2BS6zgbgLGpTui8LWeem/Jo6WDd7UiNLv8LUIsbNcdfzA1
         Hztg==
X-Gm-Message-State: AJIora9LWbSBHtY/JU1C8V81U6PIPzGjuXD8+qe1kXWI5+XDZBMVfyLj
        I6CmJC7WIgtmbxbzcnUQkxJd9Q==
X-Google-Smtp-Source: AGRyM1tc8cpgGWi82HnlRM0HYNg5vNvrHP5xofK1RdiRUlhPNGD8kzJ0a8PCmA+MWR+HU7nadb1BmQ==
X-Received: by 2002:a5d:6488:0:b0:203:b628:70d2 with SMTP id o8-20020a5d6488000000b00203b62870d2mr37474998wri.83.1657133194465;
        Wed, 06 Jul 2022 11:46:34 -0700 (PDT)
Received: from henark71.. ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b003a17ab4e7c8sm26876310wmq.39.2022.07.06.11.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:46:33 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>
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
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: [PATCH] riscv: arch-topology: fix default topology reporting
Date:   Wed,  6 Jul 2022 19:45:59 +0100
Message-Id: <20220706184558.2557301-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.0
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

 arch/riscv/include/asm/topology.h | 13 +++++++++++++
 arch/riscv/kernel/Makefile        |  1 +
 arch/riscv/kernel/smpboot.c       |  4 ++++
 arch/riscv/kernel/topology.c      | 32 +++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 arch/riscv/include/asm/topology.h
 create mode 100644 arch/riscv/kernel/topology.c

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
index f1e4948a4b52..d551c7f452d4 100644
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
@@ -161,6 +164,7 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	store_cpu_topology(curr_cpuid);
 	notify_cpu_starting(curr_cpuid);
 	numa_add_cpu(curr_cpuid);
 	update_siblings_masks(curr_cpuid);
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

base-commit: b6f1f2fa2bddd69ff46a190b8120bd440fd50563
-- 
2.37.0

