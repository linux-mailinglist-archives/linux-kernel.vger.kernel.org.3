Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51923504F17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbiDRK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiDRK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:56:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5E519C26
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:54:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u2so18227657pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gulBS1a3GDwTjV3gPNI1Ld+RqIL2YPtNwx+Ha/YsDb0=;
        b=FGwNqyWxfBjnnV7o8d4tmOubhRr8eZzYJsSS9Xvd01EjT/gwp14zLw0t0G8ms0v1K6
         QBErSvGTW9wFbPLmWRRYXW9qA1ahUrIeDTxusAnNBDY/mKpPLzJEGfA3iaP/UsU0+sY5
         Gb9nAv7P7f1D9vcY2pqQKu5V07QGVbaFmGJCYoSQBXkvgjIpMsDKbbyBDOqX5ns9CbG4
         bVRcQy/KleIK1o/wa/1f3Ylh2SCauA5IwJa9FN4QOzhtlBGWzGLg0zFObb+0b6NQmpF6
         4Ohm6C1rE1bHGqsP1zyT8zXQqItrDZlvvAK5whV5y/3s+SRPnOORqkQDxXtSsfNoBYRy
         LGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gulBS1a3GDwTjV3gPNI1Ld+RqIL2YPtNwx+Ha/YsDb0=;
        b=q/jLZUiavatNd4gxUvu7e/1guuAgZmpp0Kexr5eNE0/JmXb3dZHF8FobMnf0csVomG
         4lJ/UsbUkCaKHyBMyce3zE+D+hMVsJHvPyqUuXmI0vHNh25B5GdP0W0y8QDjV87cUVYn
         q5E0qBONOwDUNWbX3UaNpaKTz6YqxZnlaRIYbXYd2x/3mCkV87lHvb+WYwX/XPvP2bLd
         2VidpKCcYgmiVI3GW+MIQ3XQyeIsqa39DE/t1FuvczhifWS9KN3oXfYdlwGYObHGX8e4
         5wP4D+YfVC1exazIu+ZFUOQ8mYFvtt7JCEoXYisiO/Y978lCDDK8pOrYgicQPvGG5dAp
         gKVg==
X-Gm-Message-State: AOAM530jONmA0AmY4XIHRq4Yffa2YqrXeygu3D9KM1W9SYj2KEWksr3U
        etIJpoLx3c5TuoKrmddjUEdCLA==
X-Google-Smtp-Source: ABdhPJxuX8fre1oRyzLWxGkstaaivQvs3xfUcxaT5Sb+gdlrCQXN7FheZ6kBWZyqeP28yMDxGWhumA==
X-Received: by 2002:a63:2d06:0:b0:39c:f643:8720 with SMTP id t6-20020a632d06000000b0039cf6438720mr9573100pgt.371.1650279251099;
        Mon, 18 Apr 2022 03:54:11 -0700 (PDT)
Received: from localhost.localdomain ([122.172.241.223])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm12986278pfu.202.2022.04.18.03.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:54:10 -0700 (PDT)
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
Subject: [PATCH v6 6/7] RISC-V: Use IPIs for remote TLB flush when possible
Date:   Mon, 18 Apr 2022 16:23:04 +0530
Message-Id: <20220418105305.1196665-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418105305.1196665-1-apatel@ventanamicro.com>
References: <20220418105305.1196665-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
2.25.1

