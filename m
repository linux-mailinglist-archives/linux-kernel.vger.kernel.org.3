Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7B4BCC3A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 06:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiBTFKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 00:10:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiBTFKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 00:10:49 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57A554AC
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:17 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g1so5830901pfv.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANfiyTNuLH3K34lM7cYA66sM88G94rOT/TdSDWy1dfM=;
        b=JF//wm+M5JXxUvJV+hDol5wxtCo/dr6QmP6nGJJr59C+POPrhWYTsExYv94Md/rcst
         FyA0KcmP0nJ/9MUUBmGG9ivVGVHyFoZE4cX9mSps/3JGn2zevvvrSButE0ZnklortNtH
         +/Hoc+j3IdIG9fR4Qe4CjGCnqNxnOEfK8BTz9xZRPvs3/2/tEBVeuUqnw+I1PFjnpPmi
         J0UiY9ih9f89DZJNeWWKuAvI13hj9vYR54GyM4ho+iBlkldpkKvWUaLMoNU01AHaqVhU
         No6X8xeG3Oiax27NmT5ZmNg0jmdhRZRmJG8Ahv/WuEwnfvGo0AXlpr/EWURLSfkk2vDv
         1zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANfiyTNuLH3K34lM7cYA66sM88G94rOT/TdSDWy1dfM=;
        b=icFz4TuT0otCqGTMfIhB7YDKnjHBd96QEjT2X1ImWPju+rU2ZziLAG9XjZL/eGPGUs
         zZPMrGLwxwg1JUpnGaUUYdP1OSPxOso6T6gc1p6XiSb8JD3oOTYk4wbPk7W7NxxXAt1t
         RlDvTmjyUvreMwys6EX2GcZ3ZI2JPlExwk8oUY9IMWBy6Hoq9m6lu1YTEqSRHIuCKn7A
         3Q5XpQckybxOj99ZtW6cbuqkc6XsLBrLmhSaIh3rcUyqanvdpyyacp2oe3tYwM0PmajV
         3qotJjS6JXu+J+0X+HIZIPypmWii8+uF5L7/UuXZqFi+ig1n598rEg4fSKno33/jv1Lt
         ogbw==
X-Gm-Message-State: AOAM530kKMvW3LD/4twmPcbZWxc8kq7nNWjB1jUsJVnDWJvbyhfAv+Lj
        UaTjT8BtDfAGNzOW/pZz3Ta7uQ==
X-Google-Smtp-Source: ABdhPJyxhEeATiWoZESJ2C1EqKzR67HpxvZCd6735980MXU+LZNqKX6IJmZEyU1IsZh2JHFCSHeMiA==
X-Received: by 2002:a63:2115:0:b0:373:7f7c:8699 with SMTP id h21-20020a632115000000b003737f7c8699mr11626276pgh.156.1645333817186;
        Sat, 19 Feb 2022 21:10:17 -0800 (PST)
Received: from localhost.localdomain ([122.162.118.38])
        by smtp.gmail.com with ESMTPSA id 84sm7602730pfx.181.2022.02.19.21.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:10:16 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 5/6] RISC-V: Use IPIs for remote TLB flush when possible
Date:   Sun, 20 Feb 2022 10:38:53 +0530
Message-Id: <20220220050854.743420-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220220050854.743420-1-apatel@ventanamicro.com>
References: <20220220050854.743420-1-apatel@ventanamicro.com>
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

If IPI calls are injected using SBI IPI calls then remote TLB flush
using SBI RFENCE calls is much faster because using IPIs for remote
TLB flush would still endup as SBI IPI calls with extra processing
on kernel side.

It is now possible to have specialized hardware (such as RISC-V AIA
and RISC-V ACLINT) which allows S-mode software to directly inject
IPIs without any assistance from M-mode runtime firmware.

This patch extends remote TLB flush functions to use IPIs whenever
underlying IPI operations are suitable for remote FENCEs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/mm/tlbflush.c | 93 +++++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 37ed760d007c..27a7db8eb2c4 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -23,14 +23,62 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
 			: "memory");
 }
 
+static inline void local_flush_tlb_range(unsigned long start,
+		unsigned long size, unsigned long stride)
+{
+	if (size <= stride)
+		local_flush_tlb_page(start);
+	else
+		local_flush_tlb_all();
+}
+
+static inline void local_flush_tlb_range_asid(unsigned long start,
+		unsigned long size, unsigned long stride, unsigned long asid)
+{
+	if (size <= stride)
+		local_flush_tlb_page_asid(start, asid);
+	else
+		local_flush_tlb_all_asid(asid);
+}
+
+static void __ipi_flush_tlb_all(void *info)
+{
+	local_flush_tlb_all();
+}
+
 void flush_tlb_all(void)
 {
-	sbi_remote_sfence_vma(NULL, 0, -1);
+	if (riscv_use_ipi_for_rfence())
+		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
+	else
+		sbi_remote_sfence_vma(NULL, 0, -1);
+}
+
+struct flush_tlb_range_data {
+	unsigned long asid;
+	unsigned long start;
+	unsigned long size;
+	unsigned long stride;
+};
+
+static void __ipi_flush_tlb_range_asid(void *info)
+{
+	struct flush_tlb_range_data *d = info;
+
+	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
+}
+
+static void __ipi_flush_tlb_range(void *info)
+{
+	struct flush_tlb_range_data *d = info;
+
+	local_flush_tlb_range(d->start, d->size, d->stride);
 }
 
-static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
-				  unsigned long size, unsigned long stride)
+static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
+			      unsigned long size, unsigned long stride)
 {
+	struct flush_tlb_range_data ftd;
 	struct cpumask *cmask = mm_cpumask(mm);
 	unsigned int cpuid;
 	bool broadcast;
@@ -45,19 +93,34 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
 		unsigned long asid = atomic_long_read(&mm->context.id);
 
 		if (broadcast) {
-			sbi_remote_sfence_vma_asid(cmask, start, size, asid);
-		} else if (size <= stride) {
-			local_flush_tlb_page_asid(start, asid);
+			if (riscv_use_ipi_for_rfence()) {
+				ftd.asid = asid;
+				ftd.start = start;
+				ftd.size = size;
+				ftd.stride = stride;
+				on_each_cpu_mask(cmask,
+						 __ipi_flush_tlb_range_asid,
+						 &ftd, 1);
+			} else
+				sbi_remote_sfence_vma_asid(cmask,
+							   start, size, asid);
 		} else {
-			local_flush_tlb_all_asid(asid);
+			local_flush_tlb_range_asid(start, size, stride, asid);
 		}
 	} else {
 		if (broadcast) {
-			sbi_remote_sfence_vma(cmask, start, size);
-		} else if (size <= stride) {
-			local_flush_tlb_page(start);
+			if (riscv_use_ipi_for_rfence()) {
+				ftd.asid = 0;
+				ftd.start = start;
+				ftd.size = size;
+				ftd.stride = stride;
+				on_each_cpu_mask(cmask,
+						 __ipi_flush_tlb_range,
+						 &ftd, 1);
+			} else
+				sbi_remote_sfence_vma(cmask, start, size);
 		} else {
-			local_flush_tlb_all();
+			local_flush_tlb_range(start, size, stride);
 		}
 	}
 
@@ -66,23 +129,23 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__sbi_tlb_flush_range(mm, 0, -1, PAGE_SIZE);
+	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
+	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PMD_SIZE);
+	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
 }
 #endif
-- 
2.25.1

