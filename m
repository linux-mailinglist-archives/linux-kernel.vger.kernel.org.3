Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D525F494A68
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241341AbiATJK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241319AbiATJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:10:24 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FFCC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:10:24 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id f4-20020a4ac484000000b002e3e221d769so1606894ooq.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJk4b/xcyk8TbILg9v6pKfeA3aW2zvFe/CieAccUwMI=;
        b=fh88Ka60uxDGZBv3RVD38dibfyHiDAZh9d5wb+FyltxAlj3cs58CLnVLvzNOsz+/4i
         JxHczDEyZVzjXRzm8jpNJcSOZVVxINLxu1iFp+TDV1fYFt51cjZ8XsRAAKhev84nL5tE
         SA5eHNRvvHfkdQpUsjlK3tNt0gnPKQuqGdLBrZBWBQz9Aleri+IVaGcs9ZPynANehceY
         QOHz2/5bZh09eEGpAcizKNQlTYvVxEMbg3SvivjZbIKBMJUdKHzfQnDpv9wxF0TxKYbC
         5gOwHAazjOWcw7ald0zkWDN7VNR90Uh3Hfx2i/HZPZZGcU2sZbGdIaYGhjb1EYHRkFDd
         +sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJk4b/xcyk8TbILg9v6pKfeA3aW2zvFe/CieAccUwMI=;
        b=ECauvToYtwyuC7IY/Bc0bxTGqL02lre/8kqgV7AiLw4Qydk7MrHhX1Bh2ZLYp4HHgF
         YuHT1FBm6Z4BHA2+xDZnW88gP3Vsuwn/kbJYeGFMJ/KJzyoRm0Ahvbl5Cu9u5yrGZ7mS
         0PkeIbFDG5dAVnPU8I62dpqOpYCEicq6zNhKnez3r64LqYzAYO3i8u2OFaX1xRm5qvG3
         ds97pLEy+ZC4FwCKcSyTnXK2ejuYedjAUi06PC9Vi9P8RG0FGqV5XQ85Qr41uKklBRRA
         VAdi/Bn2OE9ww9nSEmAxrnY9xVMrshEfsqEaCxgvrRHeLWTgNAUQXpVmHyvubBcbXn1/
         KJaw==
X-Gm-Message-State: AOAM5320rikR5SzLC4NKTAHv2MtiIe/JnTzGrIYe0k0I6LgsKaNXdAxf
        mIiA97Lh1cvbgq9tGA0GAiBWlveb+sdBcg==
X-Google-Smtp-Source: ABdhPJwOz9PXJtwwxTmokIldnLFwjMci0CGdx8265e/x8c9VWrTlaHf56di+59tuuWDe+6kxLvN6WA==
X-Received: by 2002:a4a:374c:: with SMTP id r73mr19369221oor.68.1642669823177;
        Thu, 20 Jan 2022 01:10:23 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id i12sm944766oot.25.2022.01.20.01.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 01:10:22 -0800 (PST)
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
Subject: [PATCH v3 1/6] RISC-V: Avoid using per cpu array for ordered booting
Date:   Thu, 20 Jan 2022 01:09:13 -0800
Message-Id: <20220120090918.2646626-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220120090918.2646626-1-atishp@rivosinc.com>
References: <20220120090918.2646626-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently both order booting and spinwait approach uses a per cpu
array to update stack & task pointer. This approach will not work for the
following cases.
1. If NR_CPUs are configured to be less than highest hart id.
2. A platform has sparse hartid.

This issue can be fixed for ordered booting as the booting cpu brings up
one cpu at a time using SBI HSM extension which has opaque parameter
that is unused until now.

Introduce a common secondary boot data structure that can store the stack
and task pointer. Secondary harts will use this data while booting up
to setup the sp & tp.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/cpu_ops_sbi.h | 25 +++++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  3 +++
 arch/riscv/kernel/cpu_ops_sbi.c      | 26 ++++++++++++++++++++------
 arch/riscv/kernel/head.S             | 19 ++++++++++---------
 4 files changed, 58 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpu_ops_sbi.h

diff --git a/arch/riscv/include/asm/cpu_ops_sbi.h b/arch/riscv/include/asm/cpu_ops_sbi.h
new file mode 100644
index 000000000000..56e4b76d09ff
--- /dev/null
+++ b/arch/riscv/include/asm/cpu_ops_sbi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021 by Rivos Inc.
+ */
+#ifndef __ASM_CPU_OPS_SBI_H
+#define __ASM_CPU_OPS_SBI_H
+
+#ifndef __ASSEMBLY__
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/threads.h>
+
+/**
+ * struct sbi_hart_boot_data - Hart specific boot used during booting and
+ *			       cpu hotplug.
+ * @task_ptr: A pointer to the hart specific tp
+ * @stack_ptr: A pointer to the hart specific sp
+ */
+struct sbi_hart_boot_data {
+	void *task_ptr;
+	void *stack_ptr;
+};
+#endif
+
+#endif /* ifndef __ASM_CPU_OPS_SBI_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 253126e4beef..df0519a64eaf 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -12,6 +12,7 @@
 #include <asm/kvm_host.h>
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
+#include <asm/cpu_ops_sbi.h>
 
 void asm_offsets(void);
 
@@ -468,4 +469,6 @@ void asm_offsets(void)
 	DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));
 
 	OFFSET(KERNEL_MAP_VIRT_ADDR, kernel_mapping, virt_addr);
+	OFFSET(SBI_HART_BOOT_TASK_PTR_OFFSET, sbi_hart_boot_data, task_ptr);
+	OFFSET(SBI_HART_BOOT_STACK_PTR_OFFSET, sbi_hart_boot_data, stack_ptr);
 }
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index 685fae72b7f5..dae29cbfe550 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -7,13 +7,22 @@
 
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/sched/task_stack.h>
 #include <asm/cpu_ops.h>
+#include <asm/cpu_ops_sbi.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
 
 extern char secondary_start_sbi[];
 const struct cpu_operations cpu_ops_sbi;
 
+/*
+ * Ordered booting via HSM brings one cpu at a time. However, cpu hotplug can
+ * be invoked from multiple threads in parallel. Define a per cpu data
+ * to handle that.
+ */
+DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
+
 static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
 			      unsigned long priv)
 {
@@ -55,14 +64,19 @@ static int sbi_hsm_hart_get_status(unsigned long hartid)
 
 static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 {
-	int rc;
 	unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
 	int hartid = cpuid_to_hartid_map(cpuid);
-
-	cpu_update_secondary_bootdata(cpuid, tidle);
-	rc = sbi_hsm_hart_start(hartid, boot_addr, 0);
-
-	return rc;
+	unsigned long hsm_data;
+	struct sbi_hart_boot_data *bdata = &per_cpu(boot_data, cpuid);
+
+	/* Make sure tidle is updated */
+	smp_mb();
+	bdata->task_ptr = tidle;
+	bdata->stack_ptr = task_stack_page(tidle) + THREAD_SIZE;
+	/* Make sure boot data is updated */
+	smp_mb();
+	hsm_data = __pa(bdata);
+	return sbi_hsm_hart_start(hartid, boot_addr, hsm_data);
 }
 
 static int sbi_cpu_prepare(unsigned int cpuid)
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 604d60292dd8..bc24a90ede1c 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -11,6 +11,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/csr.h>
+#include <asm/cpu_ops_sbi.h>
 #include <asm/hwcap.h>
 #include <asm/image.h>
 #include "efi-header.S"
@@ -167,15 +168,15 @@ secondary_start_sbi:
 	la a3, .Lsecondary_park
 	csrw CSR_TVEC, a3
 
-	slli a3, a0, LGREG
-	la a4, __cpu_up_stack_pointer
-	XIP_FIXUP_OFFSET a4
-	la a5, __cpu_up_task_pointer
-	XIP_FIXUP_OFFSET a5
-	add a4, a3, a4
-	add a5, a3, a5
-	REG_L sp, (a4)
-	REG_L tp, (a5)
+	/* a0 contains the hartid & a1 contains boot data */
+	li a2, SBI_HART_BOOT_TASK_PTR_OFFSET
+	XIP_FIXUP_OFFSET a2
+	add a2, a2, a1
+	REG_L tp, (a2)
+	li a3, SBI_HART_BOOT_STACK_PTR_OFFSET
+	XIP_FIXUP_OFFSET a3
+	add a3, a3, a1
+	REG_L sp, (a3)
 
 .Lsecondary_start_common:
 
-- 
2.30.2

