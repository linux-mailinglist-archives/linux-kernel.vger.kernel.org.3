Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C204480DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 23:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhL1WbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 17:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbhL1WbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 17:31:13 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3CC06175D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 14:31:11 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l17so17381360qtk.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1j64KdCOJUpYIyoP+c5wWtrr6UQqi90Hc6GNU16wjS4=;
        b=NTQPQNJhhC3x50j+xa2tXcb93wAzAKw6eRTqDiaSs09HqKGRhGKvyLiUFmMwHSddja
         ZWtCQsBU5/JrHZuUTMl0sT6puio8v7pBqe5VoyKzQVM77vPsUO/RYIxG6uBZkGziYVV0
         +tDVHSKyrTwsvIuJlImqOXlsJq8k5RiaZbclo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1j64KdCOJUpYIyoP+c5wWtrr6UQqi90Hc6GNU16wjS4=;
        b=Hg9Uk4XfO0cmpixz2Is50gQWP/8VyEHlvOSQaxeA0ULJnykZHru61RFrfr5/lvYsfQ
         Pnof4uV8KqQhMCMYaAMlSa7xL29VisAwWZtoALzZ1CnSrCTdm334Mf4llIx20SAXSpij
         /B7Ojbzx8X/hOL6t/oeVH7cI5WENHIdpM08ZKoBhBimwiddNyMF4KLY/3k4DQws8N2V5
         klnR1Urj+Y+c9hqA/bRSb/gpCIEwZIDckw8AMU4TBcqs1ki2f18RL04MpB+lkVCmhmjU
         wAw8Nr9NM6Nc6Ma4YcpLJSCh/vT9gVz7+OkvZT/imwIk9ABP8OD620lfCAyGGbVEYfWr
         A69Q==
X-Gm-Message-State: AOAM533FGi/p/kU8gB51YQHzVzuZY6YySaDR8fvFMSuqU/ik/sGmOiWv
        ZtAyKvMlelKGcbgyOS/6JWGL2zUCv6md
X-Google-Smtp-Source: ABdhPJza88wU7Ly4R8vIv7wxU/bPFOwNG51CkRTaO1iuareR4UNvjl+abcAWxBL8O2X/vmEfTzALMw==
X-Received: by 2002:a05:622a:449:: with SMTP id o9mr20505202qtx.187.1640730670073;
        Tue, 28 Dec 2021 14:31:10 -0800 (PST)
Received: from fedora.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id i5sm2738407qti.27.2021.12.28.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 14:31:09 -0800 (PST)
From:   Atish Patra <atishp@atishpatra.org>
X-Google-Original-From: Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 5/6] RISC-V: Move spinwait booting method to its own config
Date:   Tue, 28 Dec 2021 14:30:56 -0800
Message-Id: <20211228223057.2772727-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211228223057.2772727-1-atishp@rivosinc.com>
References: <20211228223057.2772727-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spinwait booting method should only be used for platforms with older
firmware without SBI HSM extension or M-mode firmware because spinwait
method can't support cpu hotplug, kexec or sparse hartid. It is better
to move the entire spinwait implementation to its own config which can
be disabled if required. It is enabled by default to maintain backward
compatibility and M-mode Linux.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/Kconfig          | 14 ++++++++++++++
 arch/riscv/kernel/Makefile  |  3 ++-
 arch/riscv/kernel/cpu_ops.c |  8 ++++++++
 arch/riscv/kernel/head.S    |  8 ++++----
 arch/riscv/kernel/head.h    |  2 ++
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 821252b65f89..50c986a446df 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -403,6 +403,20 @@ config RISCV_SBI_V01
 	  This config allows kernel to use SBI v0.1 APIs. This will be
 	  deprecated in future once legacy M-mode software are no longer in use.
 
+config RISCV_BOOT_SPINWAIT
+	bool "Spinwait booting method"
+	depends on SMP
+	default y
+	help
+	  This enables support for booting Linux via spinwait method. In the
+	  spinwait method, all cores randomly jump to Linux. One of the cores
+	  gets chosen via lottery and all other keep spinning on a percpu
+	  variable. This method cannot support CPU hotplug and sparse hartid
+	  scheme. It should be only enabled for M-mode Linux or platforms relying
+	  on older firmware without SBI HSM extension. All other platforms should
+	  rely on ordered booting via SBI HSM extension which gets chosen
+	  dynamically at runtime if the firmware supports it.
+
 config KEXEC
 	bool "Kexec system call"
 	select KEXEC_CORE
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 3397ddac1a30..612556faa527 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -43,7 +43,8 @@ obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP)		+= cpu_ops.o
-obj-$(CONFIG_SMP)		+= cpu_ops_spinwait.o
+
+obj-$(CONFIG_RISCV_BOOT_SPINWAIT) += cpu_ops_spinwait.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index c1e30f403c3b..170d07e57721 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -15,7 +15,15 @@
 const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 
 extern const struct cpu_operations cpu_ops_sbi;
+#ifdef CONFIG_RISCV_BOOT_SPINWAIT
 extern const struct cpu_operations cpu_ops_spinwait;
+#else
+const struct cpu_operations cpu_ops_spinwait = {
+	.name		= "",
+	.cpu_prepare	= NULL,
+	.cpu_start	= NULL,
+};
+#endif
 
 void __init cpu_set_ops(int cpuid)
 {
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 9f16bfe9307e..db062279d9ed 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -259,7 +259,7 @@ pmp_done:
 	li t0, SR_FS
 	csrc CSR_STATUS, t0
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_RISCV_BOOT_SPINWAIT
 	li t0, CONFIG_NR_CPUS
 	blt a0, t0, .Lgood_cores
 	tail .Lsecondary_park
@@ -285,7 +285,7 @@ pmp_done:
 	beq t0, t1, .Lsecondary_start
 
 #endif /* CONFIG_XIP */
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_RISCV_BOOT_SPINWAIT */
 
 #ifdef CONFIG_XIP_KERNEL
 	la sp, _end + THREAD_SIZE
@@ -344,7 +344,7 @@ clear_bss_done:
 	call soc_early_init
 	tail start_kernel
 
-#ifdef CONFIG_SMP
+#if CONFIG_RISCV_BOOT_SPINWAIT
 .Lsecondary_start:
 	/* Set trap vector to spin forever to help debug */
 	la a3, .Lsecondary_park
@@ -371,7 +371,7 @@ clear_bss_done:
 	fence
 
 	tail secondary_start_common
-#endif
+#endif /* CONFIG_RISCV_BOOT_SPINWAIT */
 
 END(_start_kernel)
 
diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
index 5393cca77790..726731ada534 100644
--- a/arch/riscv/kernel/head.h
+++ b/arch/riscv/kernel/head.h
@@ -16,7 +16,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa);
 asmlinkage void __init __copy_data(void);
 #endif
 
+#ifdef CONFIG_RISCV_BOOT_SPINWAIT
 extern void *__cpu_spinwait_stack_pointer[];
 extern void *__cpu_spinwait_task_pointer[];
+#endif
 
 #endif /* __ASM_HEAD_H */
-- 
2.33.1

