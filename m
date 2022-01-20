Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4340E494A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359563AbiATJKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiATJKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:10:30 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81482C061747
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:10:30 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q186so8432864oih.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFwewVM58+2tq+yTNwly9EQyDBStKSfx5R0O8a2jQ1Y=;
        b=CzLpLAPB4NhqdBGuF7ECJtJDs1om9RXn+imZtcoHIsJCsFuqMI0guCM0jO/S5nSzl4
         xQNSyJnsf2Zmfqmef8aNSoRA1kevydclZCrfiGCDhqA4RLIc5KQ1Q5ny28tnRqYQ+3F+
         RkKUXenaqsmiHEJLkP2FlahKmfMdU3hL5KY8tZTKNWaLu1hCIUxym23oJPWs322nb3sO
         D1LrtyalvBKfxf16o6CdjOWWRlMHWWlFYOWbSpy3K566GO/WXHduzZk3bZ4tQmwNwLv/
         kSroO2Jzn4+bWnM1rJ4XcqHZahUfCUBXZL0uZJXjX375UuSCA+/RXjOJk1W7UY+3sTjy
         6tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFwewVM58+2tq+yTNwly9EQyDBStKSfx5R0O8a2jQ1Y=;
        b=4yfo+4FIAdy6bGIAXtkRSluVCTf7e5D5z6nNR7eIiwDo4U1h8l5jiNOhdapDeL3pbm
         CJKbpuqNb66hmnhi3kY47JDq7w7Clt1Uirg7PMqFvweQvM9j+QzZvdZaL1bpGPkyhZRV
         JKfAdJzsiE0Yiu35Dz8iupmL9C8n2nHK+zHLKTQXZ/rv4wsqlpRbpsNXX5Y5KLnxA+Gi
         u02svNRaywG07ctQrt2tc1ENKLG7ygpn5L1zCSOpYWfbpBUeUOdjGSqQySYn8i9X2szP
         Nn7ON8fRzFJFHEP64QdXhkh8/2+ZODF3vpyn5PDxKhGw1QwVF8yAyhzed0TvqaZ5Db+M
         XeSQ==
X-Gm-Message-State: AOAM530qw5coeTWAP0TsMAwoaij7jFR0EJEu7AzUGSfioyINswL9dg+b
        fywvLrOVBoiHoAakHFmx+TpUbRcJ3m38NQ==
X-Google-Smtp-Source: ABdhPJxVpNOMy8G3muQ6jQB1378rRqKKtah+ir1/4ZvgG/QYQBLAi4vSNC88qHQOuTvsGtX12RiNNA==
X-Received: by 2002:a05:6808:14ca:: with SMTP id f10mr6766500oiw.162.1642669829575;
        Thu, 20 Jan 2022 01:10:29 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id i12sm944766oot.25.2022.01.20.01.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 01:10:29 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 5/6] RISC-V: Move spinwait booting method to its own config
Date:   Thu, 20 Jan 2022 01:09:17 -0800
Message-Id: <20220120090918.2646626-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120090918.2646626-1-atishp@rivosinc.com>
References: <20220120090918.2646626-1-atishp@rivosinc.com>
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

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/Kconfig          | 14 ++++++++++++++
 arch/riscv/kernel/Makefile  |  3 ++-
 arch/riscv/kernel/cpu_ops.c |  8 ++++++++
 arch/riscv/kernel/head.S    |  8 ++++----
 arch/riscv/kernel/head.h    |  2 ++
 5 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4602cfe92a20..61afe4f1ad1e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -404,6 +404,20 @@ config RISCV_SBI_V01
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
index 824aaeb5b951..2dfeea56d5fe 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -258,7 +258,7 @@ pmp_done:
 	li t0, SR_FS
 	csrc CSR_STATUS, t0
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_RISCV_BOOT_SPINWAIT
 	li t0, CONFIG_NR_CPUS
 	blt a0, t0, .Lgood_cores
 	tail .Lsecondary_park
@@ -284,7 +284,7 @@ pmp_done:
 	beq t0, t1, .Lsecondary_start
 
 #endif /* CONFIG_XIP */
-#endif /* CONFIG_SMP */
+#endif /* CONFIG_RISCV_BOOT_SPINWAIT */
 
 #ifdef CONFIG_XIP_KERNEL
 	la sp, _end + THREAD_SIZE
@@ -343,7 +343,7 @@ clear_bss_done:
 	call soc_early_init
 	tail start_kernel
 
-#ifdef CONFIG_SMP
+#if CONFIG_RISCV_BOOT_SPINWAIT
 .Lsecondary_start:
 	/* Set trap vector to spin forever to help debug */
 	la a3, .Lsecondary_park
@@ -370,7 +370,7 @@ clear_bss_done:
 	fence
 
 	tail .Lsecondary_start_common
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
2.30.2

