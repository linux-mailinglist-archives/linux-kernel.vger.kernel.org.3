Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77A55ABFB9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiICQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiICQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:13:54 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA7457898
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 09:13:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s206so4528559pgs.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BjmiwAV+qkEddhUojBQVUbZIbS/TIGSArMUYW9Y9o7E=;
        b=Srg2KJC/N71EQANb9rpCKaljNyHKDS7vEUW8cxdVSufvipwuHS2pXV3h9zsLGw0upK
         JG4lKrIQZhYaxEZ5JdCBfvxdt/eBk33xYrMUb/oLh5qgnKt+2XImR6B8SkOarGSPdlhR
         eFkvgCK55UXQz0TTua8azNxmM8zgoEL+wfNPlfRJ/7HnQbIJ20x455YKOWjbV9ZGacPG
         3gjGP3V2mXrLb0yiMM/IBPmQT5ga+0Il8BFQGzvthPPa53BZJlH8MEX7eVAYdzYkX09d
         AqAccjeu+iVXuUfnetkcvjFKgEmRgYu3Tnay3I2Z7/moDzkKrIHzSRsrsAz1giTHXVLt
         F0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BjmiwAV+qkEddhUojBQVUbZIbS/TIGSArMUYW9Y9o7E=;
        b=GJIAFetNAL1FmGSeydzKDG04TP7fe9nUXDn/SsqMDeH+rgtXWb/CgLER1756D7HR3e
         BMqaKFOtzjSWFJHaWBjJGRx6C5a00wY0HhDfDC5Mk4+FrxZqYwDCFtBNLZoAJflYJn+f
         duCReD8CHnH2z/8sFZPtb2+4y4BBknI/6imcqAmJkRo7HOdYRUZO9exdHOJho39HvNvQ
         kIGl7KjK2EfGBfN6nh/GkkEj1tNevAsOmY4I7bS8MrfXG3peBzigB4gklKJmmGetyH6m
         VaMzdx/A94LgxfoxsjYd/6JJtaMDgGW2r1Nz30Net0OAw9RxOohuTXCSw8IhbxyMPlAD
         opGA==
X-Gm-Message-State: ACgBeo1FO+eDpT/cEFp9p3SqOi1HbeI2Ro+1BPYkB+CmRlhtbiFYz9TK
        CWnbOmRBha7eTk2nz+hOGGdbOTdOl0qH3A==
X-Google-Smtp-Source: AA6agR5O50NShr8lP4Pd9wJGQ/rR/edtllWgft9wj4e0CuK20DckiSKoCR/ijA7aSsvTcN93AOl46w==
X-Received: by 2002:a63:798c:0:b0:42a:4612:c07b with SMTP id u134-20020a63798c000000b0042a4612c07bmr35014302pgc.519.1662221632869;
        Sat, 03 Sep 2022 09:13:52 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.86.115])
        by smtp.gmail.com with ESMTPSA id 4-20020a620504000000b00537b1aa9191sm4166738pff.178.2022.09.03.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 09:13:52 -0700 (PDT)
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
Subject: [PATCH v9 6/7] RISC-V: Use IPIs for remote TLB flush when possible
Date:   Sat,  3 Sep 2022 21:43:08 +0530
Message-Id: <20220903161309.32848-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220903161309.32848-1-apatel@ventanamicro.com>
References: <20220903161309.32848-1-apatel@ventanamicro.com>
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

If we have specialized interrupt controller (such as AIA IMSIC) which
allows supervisor mode to directly inject IPIs without any assistance
from M-mode or HS-mode then using such specialized interrupt controller,
we can do remote TLB flushes directly from supervisor mode instead of
using the SBI RFENCE calls.

This patch extends remote TLB flush functions to use supervisor mode
IPIs whenever direct supervisor mode IPIs.are supported by interrupt
controller.

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
2.34.1

