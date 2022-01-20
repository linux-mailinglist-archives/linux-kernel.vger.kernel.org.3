Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D11E494A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbiATJKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbiATJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:10:27 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BB4C061401
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:10:27 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q186so8432687oih.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+MybGqOdAP1f+I+3ngFKmwsZE3uBIeB4Cg8mcfvl/M=;
        b=nbxCuy9rfeSAYyoUegS2xkDPxVgS6b5g+1/HSi01tjHbhPNPHu1ISZNLDqa4pa5Oq1
         tKf7geKbxFQItVuTyMMeMWPNDpEiISuU4GntKaRiXp8SHMiNLUkUnoyZB/HMIO66QuET
         9lo5KHyqSTUY9dzrm3EiwHDIhWjNF7d8Z7zerLsDJgtFkSTVYGTk42G64eA4iV5aYy1N
         GotWaHQDOOvsLdumAV6VV+5MSJZrqkhxLYcxEBSUuku4ThR0ryFYGQU7hYGSgKhcpgid
         9HyfQvCRaCn7/Qeagh6qFtYL1JPKqEbkb0AsZbcr+69AgLEOzWr+GuGm8bSXnxFHxlkr
         UsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+MybGqOdAP1f+I+3ngFKmwsZE3uBIeB4Cg8mcfvl/M=;
        b=NS2PKxdvsGrF/O9i0kszMsM/16EqcfXZbDE/1bwGeu6MeymY+q944Uyl7WpzRa59qy
         u7nTZJpVMSNCbSHSOIbEOAyB+8uJ56mPgGXk/n1kiW88VLV/ZOSjjFiDcSeV0/NS93qU
         a79+mPNpCYS2jV46deBbGNNkv1ze+Dua0t38WsbS03vHj+LiKh9vah+WDzE/9MZyxcGz
         n0HDAxpB6WnkhgAz9ByqmXOWxSVzbYqVwYw3Ay3fdQeqnG0usAkDwtVf/qz+KtDJBG30
         /ds3IV7DPfC4/VUx8uK4viix+jRaovx2XNNq74pB0NxjCratTPln+gugNs5sVR1RCmdk
         Hr6w==
X-Gm-Message-State: AOAM530+9uX+hxwr5Co9Fkx0CxAjVm+JQIoUQ3V37mAXNuZdiq12F30W
        dijfwGfvwOP+qT4GTXgfRq6lvXO3P4x4KA==
X-Google-Smtp-Source: ABdhPJxebiYyqqlCLofVZDbcl4nIXzK65lvUMid5IGiCe80uhXYOf7ppWcd5JDvsr0ypIrkEaALJzw==
X-Received: by 2002:a05:6808:1881:: with SMTP id bi1mr6882680oib.111.1642669826388;
        Thu, 20 Jan 2022 01:10:26 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id i12sm944766oot.25.2022.01.20.01.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 01:10:25 -0800 (PST)
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
Subject: [PATCH v3 3/6] RISC-V: Use __cpu_up_stack/task_pointer only for spinwait method
Date:   Thu, 20 Jan 2022 01:09:15 -0800
Message-Id: <20220120090918.2646626-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120090918.2646626-1-atishp@rivosinc.com>
References: <20220120090918.2646626-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __cpu_up_stack/task_pointer array is only used for spinwait method
now. The per cpu array based lookup is also fragile for platforms with
discontiguous/sparse hartids. The spinwait method is only used for
M-mode Linux or older firmwares without SBI HSM extension. For general
Linux systems, ordered booting method is preferred anyways to support
cpu hotplug and kexec.

Make sure that __cpu_up_stack/task_pointer is only used for spinwait
method. Take this opportunity to rename it to
__cpu_spinwait_stack/task_pointer to emphasize the purpose as well.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/cpu_ops.h     |  2 --
 arch/riscv/kernel/cpu_ops.c          | 16 ----------------
 arch/riscv/kernel/cpu_ops_spinwait.c | 27 ++++++++++++++++++++++++++-
 arch/riscv/kernel/head.S             |  4 ++--
 arch/riscv/kernel/head.h             |  4 ++--
 5 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/include/asm/cpu_ops.h b/arch/riscv/include/asm/cpu_ops.h
index a8ec3c5c1bd2..134590f1b843 100644
--- a/arch/riscv/include/asm/cpu_ops.h
+++ b/arch/riscv/include/asm/cpu_ops.h
@@ -40,7 +40,5 @@ struct cpu_operations {
 
 extern const struct cpu_operations *cpu_ops[NR_CPUS];
 void __init cpu_set_ops(int cpu);
-void cpu_update_secondary_bootdata(unsigned int cpuid,
-				   struct task_struct *tidle);
 
 #endif /* ifndef __ASM_CPU_OPS_H */
diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
index 3f5a38b03044..c1e30f403c3b 100644
--- a/arch/riscv/kernel/cpu_ops.c
+++ b/arch/riscv/kernel/cpu_ops.c
@@ -8,31 +8,15 @@
 #include <linux/of.h>
 #include <linux/string.h>
 #include <linux/sched.h>
-#include <linux/sched/task_stack.h>
 #include <asm/cpu_ops.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
 
 const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 
-void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
-void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
-
 extern const struct cpu_operations cpu_ops_sbi;
 extern const struct cpu_operations cpu_ops_spinwait;
 
-void cpu_update_secondary_bootdata(unsigned int cpuid,
-				   struct task_struct *tidle)
-{
-	int hartid = cpuid_to_hartid_map(cpuid);
-
-	/* Make sure tidle is updated */
-	smp_mb();
-	WRITE_ONCE(__cpu_up_stack_pointer[hartid],
-		   task_stack_page(tidle) + THREAD_SIZE);
-	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
-}
-
 void __init cpu_set_ops(int cpuid)
 {
 #if IS_ENABLED(CONFIG_RISCV_SBI)
diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
index b2c957bb68c1..346847f6c41c 100644
--- a/arch/riscv/kernel/cpu_ops_spinwait.c
+++ b/arch/riscv/kernel/cpu_ops_spinwait.c
@@ -6,11 +6,36 @@
 #include <linux/errno.h>
 #include <linux/of.h>
 #include <linux/string.h>
+#include <linux/sched/task_stack.h>
 #include <asm/cpu_ops.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
 
 const struct cpu_operations cpu_ops_spinwait;
+void *__cpu_spinwait_stack_pointer[NR_CPUS] __section(".data");
+void *__cpu_spinwait_task_pointer[NR_CPUS] __section(".data");
+
+static void cpu_update_secondary_bootdata(unsigned int cpuid,
+				   struct task_struct *tidle)
+{
+	int hartid = cpuid_to_hartid_map(cpuid);
+
+	/*
+	 * The hartid must be less than NR_CPUS to avoid out-of-bound access
+	 * errors for __cpu_spinwait_stack/task_pointer. That is not always possible
+	 * for platforms with discontiguous hartid numbering scheme. That's why
+	 * spinwait booting is not the recommended approach for any platforms
+	 * booting Linux in S-mode and can be disabled in the future.
+	 */
+	if (hartid == INVALID_HARTID || hartid >= NR_CPUS)
+		return;
+
+	/* Make sure tidle is updated */
+	smp_mb();
+	WRITE_ONCE(__cpu_spinwait_stack_pointer[hartid],
+		   task_stack_page(tidle) + THREAD_SIZE);
+	WRITE_ONCE(__cpu_spinwait_task_pointer[hartid], tidle);
+}
 
 static int spinwait_cpu_prepare(unsigned int cpuid)
 {
@@ -28,7 +53,7 @@ static int spinwait_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 	 * selects the first cpu to boot the kernel and causes the remainder
 	 * of the cpus to spin in a loop waiting for their stack pointer to be
 	 * setup by that main cpu.  Writing to bootdata
-	 * (i.e __cpu_up_stack_pointer) signals to the spinning cpus that they
+	 * (i.e __cpu_spinwait_stack_pointer) signals to the spinning cpus that they
 	 * can continue the boot process.
 	 */
 	cpu_update_secondary_bootdata(cpuid, tidle);
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index bc24a90ede1c..1f11de45df9c 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -346,9 +346,9 @@ clear_bss_done:
 	csrw CSR_TVEC, a3
 
 	slli a3, a0, LGREG
-	la a1, __cpu_up_stack_pointer
+	la a1, __cpu_spinwait_stack_pointer
 	XIP_FIXUP_OFFSET a1
-	la a2, __cpu_up_task_pointer
+	la a2, __cpu_spinwait_task_pointer
 	XIP_FIXUP_OFFSET a2
 	add a1, a3, a1
 	add a2, a3, a2
diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
index aabbc3ac3e48..5393cca77790 100644
--- a/arch/riscv/kernel/head.h
+++ b/arch/riscv/kernel/head.h
@@ -16,7 +16,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa);
 asmlinkage void __init __copy_data(void);
 #endif
 
-extern void *__cpu_up_stack_pointer[];
-extern void *__cpu_up_task_pointer[];
+extern void *__cpu_spinwait_stack_pointer[];
+extern void *__cpu_spinwait_task_pointer[];
 
 #endif /* __ASM_HEAD_H */
-- 
2.30.2

