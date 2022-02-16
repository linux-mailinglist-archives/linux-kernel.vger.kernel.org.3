Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B174B8001
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbiBPFWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:22:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344596AbiBPFWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:22:17 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5FA69CF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:22:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso1405020pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Xqqhi8fogx+j8zYjiaq4nvXJRMBIRlwUENP/w8+fQA=;
        b=Za6Z2XMNRyRjgqlDlQ8Ys1YDy73TTFCUMsbPBCBvjncBolqQpeqcN0PeSQumJPTKR1
         PwWMMJTSswr7DIn9CLb34gpze7jjiiRpy1KxPu0cYtw6VsX5ghkjMvgFoqiIjChTlqhb
         QenekP4kI2CtQbms/lCCdCb4LCxcc0G6GrnQQe2u/E8idrmPD2ny9EvlEsZzEYRsuIYc
         sG92LGfci/Nm4AFZzgoJIlAfI5O+zd0bB6aFmT76dRtuMV3pWIiOHxrwmzBrXChS8Yzl
         7uf0LX4bl20i2dNL0fmxLia0EB8BAT/j+GO65tkun4iVSkKdmOvLF+SPc+XCCkyUOUle
         +v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Xqqhi8fogx+j8zYjiaq4nvXJRMBIRlwUENP/w8+fQA=;
        b=wa6wUZ55pEtwkiBYunUFUpnvG2b6rHRAMZUamkY7vSIHBQClmdazznsUFMAgHw5zd9
         CgALaY20qFOmJ/zoAucNFM1a+mJkymZTz8OgtugET2/ibDNZ8i5fFM1oPpDOwTOGzgZB
         q2DmYg77noEqjYjgu0n/OWP6CXmM2WlaEpjlEdK7honwEqxmrCH59VV9XT5GkmzTmK99
         fSif71inEkxCsyGorbYVNYWvr08Gyqqq0hhwIwtcOCUHQhx8+qCTZqwFZSTGJ5QNltLq
         q/qHeA7g2y/f1ybrf7XwPNhRuVfSnmnPsUfj5MOiH+6En2xqh/BmJQ78LQ83fcXC5OLX
         JLhw==
X-Gm-Message-State: AOAM531gfy/6q4rv66BrHqrToT+imdXRsoXd58HHFxLt6GwOSSZ5sdqV
        XgdbxoKN2HYHlPbaYT7DdVgfJQ==
X-Google-Smtp-Source: ABdhPJwBtBVhI3ehd9nHd0bvhj2JtqK5iM5/MfuMDSYVf/7QH0KPYM7UuDIeMXajjgtE3+7ELzrYSw==
X-Received: by 2002:a17:90b:3b52:b0:1b9:cb97:6f0 with SMTP id ot18-20020a17090b3b5200b001b9cb9706f0mr8091769pjb.191.1644988924193;
        Tue, 15 Feb 2022 21:22:04 -0800 (PST)
Received: from localhost.localdomain ([117.248.109.221])
        by smtp.gmail.com with ESMTPSA id ot12sm10775259pjb.22.2022.02.15.21.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 21:22:03 -0800 (PST)
From:   Mayuresh Chitale <mchitale@ventanamicro.com>
To:     palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com
Cc:     anup@brainfault.org, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [RFC PATCH 2/2] riscv: mm: use svinval instructions instead of sfence.vma
Date:   Wed, 16 Feb 2022 10:51:10 +0530
Message-Id: <20220216052110.1053665-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216052110.1053665-1-mchitale@ventanamicro.com>
References: <20220216052110.1053665-1-mchitale@ventanamicro.com>
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

When svinval is supported the local_flush_tlb_page*
functions would prefer to use the following sequence
to optimize the tlb flushes instead of a simple sfence.vma:

sfence.w.inval
svinval.vma
  .
  .
svinval.vma
sfence.inval.ir

The maximum number of consecutive svinval.vma instructions
that can be executed in local_flush_tlb_page* functions is
limited to PTRS_PER_PTE. This is required to avoid soft
lockups and the approach is similar to that used in arm64.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/include/asm/tlbflush.h | 14 +++++++
 arch/riscv/kernel/setup.c         |  1 +
 arch/riscv/mm/Makefile            |  1 +
 arch/riscv/mm/tlb.S               | 53 +++++++++++++++++++++++
 arch/riscv/mm/tlbflush.c          | 70 ++++++++++++++++++++++++++++---
 5 files changed, 133 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/mm/tlb.S

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 801019381dea..9256a1c2ee03 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -22,9 +22,23 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
 }
+
+void riscv_tlbflush_init(void);
+void __riscv_sfence_w_inval(void);
+void __riscv_sfence_inval_ir(void);
+void __riscv_sinval_vma(unsigned long addr);
+void __riscv_sinval_vma_asid(unsigned long addr, unsigned long asid);
+
+/* Check if we can use sinval for tlb flush */
+DECLARE_STATIC_KEY_FALSE(riscv_flush_tlb_svinval);
+#define riscv_use_flush_tlb_svinval() \
+	static_branch_unlikely(&riscv_flush_tlb_svinval)
+
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #define local_flush_tlb_page(addr)		do { } while (0)
+#define riscv_use_flush_tlb_svinval()		do { } while (0)
+#define riscv_tlbflush_init()			do { } while (0)
 #endif /* CONFIG_MMU */
 
 #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b42bfdc67482..5dc79288b0ad 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -295,6 +295,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	riscv_fill_hwcap();
+	riscv_tlbflush_init();
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 7ebaef10ea1b..d3a14d4d144e 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -16,6 +16,7 @@ obj-y += context.o
 
 ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
+obj-$(CONFIG_SMP) += tlb.o
 endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
diff --git a/arch/riscv/mm/tlb.S b/arch/riscv/mm/tlb.S
new file mode 100644
index 000000000000..a530a9012c43
--- /dev/null
+++ b/arch/riscv/mm/tlb.S
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Ventana Micro Sytems.
+ *
+ * Authors:
+ *     Mayuresh Chitale <mchitale@ventanamicro.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+       .text
+       .altmacro
+       .option norelax
+
+
+ENTRY(__riscv_sfence_w_inval)
+       /*
+        * SFENCE.W.INVAL
+        * 0001100 00000 00000 000 00000 1110011
+        */
+       .word 0x18000073
+       ret
+ENDPROC(__riscv_sfence_w_inval)
+
+ENTRY(__riscv_sfence_inval_ir)
+       /*
+        * SFENCE.INVAL.IR
+        * 0001100 00001 00000 000 00000 1110011
+        */
+       .word 0x18100073
+       ret
+ENDPROC(__riscv_sfence_inval_ir)
+ENTRY(__riscv_sinval_vma_asid)
+       /*
+        * rs1 = VMA
+        * rs2 = asid
+        * SFENCE.W.INVAL
+        * 0001011 01011 01010 000 00000 1110011
+        */
+       .word 0x16B50073
+       ret
+ENDPROC(__riscv_sinval_vma_asid)
+ENTRY(__riscv_sinval_vma)
+       /*
+        * rs1 = vma
+        * rs2 = 0
+        * SFENCE.W.INVAL
+        * 0001011 00000 01010 000 00000 1110011
+        */
+       .word 0x16050073
+       ret
+ENDPROC(__riscv_sinval_vma)
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 27a7db8eb2c4..a4659f31b7a1 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "riscv: " fmt
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
+static unsigned long tlb_flush_all_threshold __read_mostly = PTRS_PER_PTE;
+
 static inline void local_flush_tlb_all_asid(unsigned long asid)
 {
 	__asm__ __volatile__ ("sfence.vma x0, %0"
@@ -26,19 +29,61 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
 static inline void local_flush_tlb_range(unsigned long start,
 		unsigned long size, unsigned long stride)
 {
-	if (size <= stride)
-		local_flush_tlb_page(start);
-	else
+	if ((size / stride) <= tlb_flush_all_threshold) {
+		if (riscv_use_flush_tlb_svinval()) {
+			__riscv_sfence_w_inval();
+			while (size) {
+				__riscv_sinval_vma(start);
+				start += stride;
+				if (size > stride)
+					size -= stride;
+				else
+					size = 0;
+			}
+			__riscv_sfence_inval_ir();
+		} else {
+			while (size) {
+				local_flush_tlb_page(start);
+				start += stride;
+				if (size > stride)
+					size -= stride;
+				else
+					size = 0;
+			}
+		}
+	} else {
 		local_flush_tlb_all();
+	}
 }
 
 static inline void local_flush_tlb_range_asid(unsigned long start,
 		unsigned long size, unsigned long stride, unsigned long asid)
 {
-	if (size <= stride)
-		local_flush_tlb_page_asid(start, asid);
-	else
+	if ((size / stride) <= tlb_flush_all_threshold) {
+		if (riscv_use_flush_tlb_svinval()) {
+			__riscv_sfence_w_inval();
+			while (size) {
+				__riscv_sinval_vma_asid(start, asid);
+				start += stride;
+				if (size > stride)
+					size -= stride;
+				else
+					size = 0;
+			}
+			__riscv_sfence_inval_ir();
+		} else {
+			while (size) {
+				local_flush_tlb_page_asid(start, asid);
+				start += stride;
+				if (size > stride)
+					size -= stride;
+				else
+					size = 0;
+			}
+		}
+	} else {
 		local_flush_tlb_all_asid(asid);
+	}
 }
 
 static void __ipi_flush_tlb_all(void *info)
@@ -149,3 +194,16 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
 }
 #endif
+
+DEFINE_STATIC_KEY_FALSE(riscv_flush_tlb_svinval);
+EXPORT_SYMBOL_GPL(riscv_flush_tlb_svinval);
+
+void riscv_tlbflush_init(void)
+{
+	if (riscv_isa_extension_available(NULL, SVINVAL)) {
+		pr_info("Svinval extension supported\n");
+		static_branch_enable(&riscv_flush_tlb_svinval);
+	} else {
+		static_branch_disable(&riscv_flush_tlb_svinval);
+	}
+}
-- 
2.25.1

