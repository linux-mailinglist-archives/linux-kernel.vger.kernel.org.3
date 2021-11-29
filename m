Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF35462575
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhK2Wj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhK2WjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:39:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7F5C093199
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:43:45 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id f206-20020a6238d7000000b004a02dd7156bso11549165pfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=b5JgGPuCh2TG2LeGhuIYMGHt9KrJcP9PayR5x1TbleE=;
        b=NqITDenw5tWBTTe/aJQQIYNa0EDTIYcmwjphFL29klLEgI7fBVy4wkD4I7M9PbTQcy
         o7/n3j771KMetpsvOEH5OyLxO7cyVLIx9QeFZj6meeJnFZBsp4tumOmrYlajP1g4J3mJ
         ZxnYbYofpe8GFzxVrIHH5oPmRwO20oHwJgnUMHMR6fX1ViA+4zRv9mPly9pikf31wnDQ
         GK7nJsXdFFwligJAJdLd0WSkO3Bb8BGyUJSuyQVMemxFY+RlEf5nlh1c90leGkI++/63
         65pUidHcfG8vZmSZMKN8Md3+o8NYCrVbAjTxDGAIUaZhUxLm9teuGe4lFcUJIvQri11E
         3scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=b5JgGPuCh2TG2LeGhuIYMGHt9KrJcP9PayR5x1TbleE=;
        b=zyJrlfC5OKiE9eYkH/9JUp2x2SPggBYckp7oyA4xzgEqq6HGTCwmsXi0Cmt2dLjpEf
         AdGD9iOcnHOdL7HaEQjwUy29lb0OokN7cnLIoXcbVp34qglNwyBVbE0N1Yv1w9iOqjDT
         bini1Z74VDnOCqIT9ZHtXjJrgffR/YjDHoDfSAyYwM+1DeAR0jpt/D+urxRScxh1YMRF
         TL1EZ4IsR79VCN1OKy8Vk2S6HF5idth4IINBoMzP/jh7hnXdfGyrDTzLkaFOWMPGhPQA
         ZzZQ81qkbDwM+v8zXA2OhbtXYHNqQvXOjApkEl9WFw7EPZRyaLZa/yX9BATa21Bk584j
         rlmA==
X-Gm-Message-State: AOAM531Lfbmjvwz5ZgQriQtGhap1mha1Zn0S7xPynCla8NfeI2r6bjcz
        qOPjVl3Ofhfn5MDmp5uiIK32ehn7Rvs=
X-Google-Smtp-Source: ABdhPJwPLKTWfxNp/8QG3imQd7zu+NgkwNkw0OX0ECtjDwjzBoTxcpS4Ckrk0j+awWix360nv6y/HmiBssQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3889:: with SMTP id
 mu9mr836244pjb.160.1638222224720; Mon, 29 Nov 2021 13:43:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 29 Nov 2021 21:43:42 +0000
Message-Id: <20211129214342.1221766-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] RISC-V: Use common riscv_cpuid_to_hartid_mask() for both
 SMP=y and SMP=n
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adam Borowski <kilobyte@angband.pl>,
        Anup Patel <anup.patel@wdc.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use what is currently the SMP=y version of riscv_cpuid_to_hartid_mask()
for both SMP=y and SMP=n to fix a build failure with KVM=m and SMP=n due
to boot_cpu_hartid not being exported.  This also fixes a second bug
where the SMP=n version assumes the sole CPU in the system is in the
incoming mask, which may not hold true in kvm_riscv_vcpu_sbi_ecall() if
the KVM guest VM has multiple vCPUs (on a SMP=n system).

Fixes: 1ef46c231df4 ("RISC-V: Implement new SBI v0.2 extensions")
Reported-by: Adam Borowski <kilobyte@angband.pl>
Cc: stable@vger.kernel.org
Reviewed-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/riscv/include/asm/smp.h | 10 ++--------
 arch/riscv/kernel/setup.c    | 10 ++++++++++
 arch/riscv/kernel/smp.c      | 10 ----------
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index a7d2811f3536..62d0e6e61da8 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -43,7 +43,6 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 void arch_send_call_function_single_ipi(int cpu);
 
 int riscv_hartid_to_cpuid(int hartid);
-void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
 /* Set custom IPI operations */
 void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
@@ -85,13 +84,6 @@ static inline unsigned long cpuid_to_hartid_map(int cpu)
 	return boot_cpu_hartid;
 }
 
-static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
-					      struct cpumask *out)
-{
-	cpumask_clear(out);
-	cpumask_set_cpu(boot_cpu_hartid, out);
-}
-
 static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
 {
 }
@@ -102,6 +94,8 @@ static inline void riscv_clear_ipi(void)
 
 #endif /* CONFIG_SMP */
 
+void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
+
 #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
 bool cpu_has_hotplug(unsigned int cpu);
 #else
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b42bfdc67482..63241abe84eb 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -59,6 +59,16 @@ atomic_t hart_lottery __section(".sdata")
 unsigned long boot_cpu_hartid;
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
+void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
+{
+	int cpu;
+
+	cpumask_clear(out);
+	for_each_cpu(cpu, in)
+		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
+}
+EXPORT_SYMBOL_GPL(riscv_cpuid_to_hartid_mask);
+
 /*
  * Place kernel memory regions on the resource tree so that
  * kexec-tools can retrieve them from /proc/iomem. While there
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 2f6da845c9ae..b5d30ea92292 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -59,16 +59,6 @@ int riscv_hartid_to_cpuid(int hartid)
 	return -ENOENT;
 }
 
-void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
-{
-	int cpu;
-
-	cpumask_clear(out);
-	for_each_cpu(cpu, in)
-		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
-}
-EXPORT_SYMBOL_GPL(riscv_cpuid_to_hartid_mask);
-
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
 	return phys_id == cpuid_to_hartid_map(cpu);
-- 
2.34.0.rc2.393.gf8c9666880-goog

