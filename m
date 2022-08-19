Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE915599D50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349331AbiHSODH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349328AbiHSOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:02:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EEE100F0E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id s11so5760038edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eHs+z8DwNs709gkux1J21T7x+ZKZRefKINTUPP0jqqE=;
        b=MiVkDd4ypsClXPfrJblJPX1o05V2XlMgkABPNa+ANz5bpPHj3bz+KUWKPLbj4eMh2e
         Rf+Yfig8Yqutna/Gl1ZlvDAYMbONm2a1faNbFHIgth+0jnO5iCoOoiGUO2cdhbMbPcoX
         NMC2DiHTYwuBlGQ0fm+hNXHeNI+FOZwopJW5bb9kQ/vLNIsHRnM3VsLkUoUfyPkguFPn
         DdTu45vwCCHA2KHOEW12+Ilk7iklf/ig1tuAmHI2WDQHVgWZwZRBHOq+P9Rx6AdrUeSA
         /uUw748nFBk8M/HHgh89LcniBs/ZOywQ1MUrAVWqnhGA8R57j5Uu3Etgfl+IUxWQLBCC
         crfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eHs+z8DwNs709gkux1J21T7x+ZKZRefKINTUPP0jqqE=;
        b=F16PfevaaFS1p57HJl4m9zhnjgpJ/BH+ZEPhh4kRV4/C1z49fpO7Tlrez+WH3BcSix
         z71Ads+AgOf49tjJ70H/2CEGz4dSQJf2rqpA2/X0UCPI7T+lNUTQNWaMbFKZAYyJtUsg
         Dl6HQyecAV/wZS+dZ0oUV16dE2Trc0ebVvL89jHmTn9Om5b5/6cGcURL3nB59o2EhNZ8
         7g4HQtZyMwHgCBXe48VUNgfGi+h+2PCyX2ykn1BtsBw8IANPwG/UTtLSBMqpi4aK4nDu
         3OTCOwTQdeslIaxE3KVv+XyTVKJKj5lUSZpyKx+yqL4WSUXzDbqgn61cFSXL3UPetgS3
         V1AQ==
X-Gm-Message-State: ACgBeo28MKf7vVU8ouH8nJAYB2UkYI105XtJBE33CLFiPwMeFP65v3xE
        JGtQ0o2vd/rUraDOFOhyo+22fQ==
X-Google-Smtp-Source: AA6agR63VI1qC3a/Avg6iK+EkZbCELYZLImNqOEsToeYNls3s6oXmzXpKEmehFYJbdsLBfBuKZi0RQ==
X-Received: by 2002:a05:6402:1044:b0:446:27c1:49a4 with SMTP id e4-20020a056402104400b0044627c149a4mr4331991edu.53.1660917776492;
        Fri, 19 Aug 2022 07:02:56 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073c9d68ca0dsm1434287ejb.133.2022.08.19.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:02:56 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH 3/4] riscv: KVM: Apply insn-def to hfence encodings
Date:   Fri, 19 Aug 2022 16:02:49 +0200
Message-Id: <20220819140250.3892995-4-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819140250.3892995-1-ajones@ventanamicro.com>
References: <20220819140250.3892995-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
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

Introduce hfence instruction encodings and apply them to KVM's use.
With the self-documenting nature of the instruction encoding macros,
and a spec always within arm's reach, it's safe to remove the
comments, so we do that too.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/insn-def.h |   8 ++
 arch/riscv/kvm/tlb.c              | 117 ++++--------------------------
 2 files changed, 21 insertions(+), 104 deletions(-)

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index 4cd0208068dd..cd1c0d365f47 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -79,4 +79,12 @@
 #define RS1(v)		__REG(v)
 #define RS2(v)		__REG(v)
 
+#define OPCODE_SYSTEM	OPCODE(115)
+
+#define HFENCE_VVMA(vaddr, asid)	\
+	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17), RD(0), vaddr, asid)
+
+#define HFENCE_GVMA(gaddr, vmid)	\
+	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49), RD(0), gaddr, vmid)
+
 #endif /* __ASM_INSN_DEF_H */
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 1a76d0b1907d..f742a0d888e1 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -12,22 +12,7 @@
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
 #include <asm/csr.h>
-
-/*
- * Instruction encoding of hfence.gvma is:
- * HFENCE.GVMA rs1, rs2
- * HFENCE.GVMA zero, rs2
- * HFENCE.GVMA rs1
- * HFENCE.GVMA
- *
- * rs1!=zero and rs2!=zero ==> HFENCE.GVMA rs1, rs2
- * rs1==zero and rs2!=zero ==> HFENCE.GVMA zero, rs2
- * rs1!=zero and rs2==zero ==> HFENCE.GVMA rs1
- * rs1==zero and rs2==zero ==> HFENCE.GVMA
- *
- * Instruction encoding of HFENCE.GVMA is:
- * 0110001 rs2(5) rs1(5) 000 00000 1110011
- */
+#include <asm/insn-def.h>
 
 void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
 					  gpa_t gpa, gpa_t gpsz,
@@ -41,31 +26,14 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
 	}
 
 	for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
-		/*
-		 * rs1 = a0 (GPA >> 2)
-		 * rs2 = a1 (VMID)
-		 * HFENCE.GVMA a0, a1
-		 * 0110001 01011 01010 000 00000 1110011
-		 */
-		asm volatile ("srli a0, %0, 2\n"
-			      "add a1, %1, zero\n"
-			      ".word 0x62b50073\n"
-			      :: "r" (pos), "r" (vmid)
-			      : "a0", "a1", "memory");
+		asm volatile (HFENCE_GVMA("%0", "%1")
+		: : "r" (pos >> 2), "r" (vmid) : "memory");
 	}
 }
 
 void kvm_riscv_local_hfence_gvma_vmid_all(unsigned long vmid)
 {
-	/*
-	 * rs1 = zero
-	 * rs2 = a0 (VMID)
-	 * HFENCE.GVMA zero, a0
-	 * 0110001 01010 00000 000 00000 1110011
-	 */
-	asm volatile ("add a0, %0, zero\n"
-		      ".word 0x62a00073\n"
-		      :: "r" (vmid) : "a0", "memory");
+	asm volatile(HFENCE_GVMA("zero", "%0") : : "r" (vmid) : "memory");
 }
 
 void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
@@ -79,45 +47,16 @@ void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
 	}
 
 	for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
-		/*
-		 * rs1 = a0 (GPA >> 2)
-		 * rs2 = zero
-		 * HFENCE.GVMA a0
-		 * 0110001 00000 01010 000 00000 1110011
-		 */
-		asm volatile ("srli a0, %0, 2\n"
-			      ".word 0x62050073\n"
-			      :: "r" (pos) : "a0", "memory");
+		asm volatile(HFENCE_GVMA("%0", "zero")
+		: : "r" (pos >> 2) : "memory");
 	}
 }
 
 void kvm_riscv_local_hfence_gvma_all(void)
 {
-	/*
-	 * rs1 = zero
-	 * rs2 = zero
-	 * HFENCE.GVMA
-	 * 0110001 00000 00000 000 00000 1110011
-	 */
-	asm volatile (".word 0x62000073" ::: "memory");
+	asm volatile(HFENCE_GVMA("zero", "zero") : : : "memory");
 }
 
-/*
- * Instruction encoding of hfence.gvma is:
- * HFENCE.VVMA rs1, rs2
- * HFENCE.VVMA zero, rs2
- * HFENCE.VVMA rs1
- * HFENCE.VVMA
- *
- * rs1!=zero and rs2!=zero ==> HFENCE.VVMA rs1, rs2
- * rs1==zero and rs2!=zero ==> HFENCE.VVMA zero, rs2
- * rs1!=zero and rs2==zero ==> HFENCE.VVMA rs1
- * rs1==zero and rs2==zero ==> HFENCE.VVMA
- *
- * Instruction encoding of HFENCE.VVMA is:
- * 0010001 rs2(5) rs1(5) 000 00000 1110011
- */
-
 void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
 					  unsigned long asid,
 					  unsigned long gva,
@@ -134,17 +73,8 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
 	for (pos = gva; pos < (gva + gvsz); pos += BIT(order)) {
-		/*
-		 * rs1 = a0 (GVA)
-		 * rs2 = a1 (ASID)
-		 * HFENCE.VVMA a0, a1
-		 * 0010001 01011 01010 000 00000 1110011
-		 */
-		asm volatile ("add a0, %0, zero\n"
-			      "add a1, %1, zero\n"
-			      ".word 0x22b50073\n"
-			      :: "r" (pos), "r" (asid)
-			      : "a0", "a1", "memory");
+		asm volatile(HFENCE_VVMA("%0", "%1")
+		: : "r" (pos), "r" (asid) : "memory");
 	}
 
 	csr_write(CSR_HGATP, hgatp);
@@ -157,15 +87,7 @@ void kvm_riscv_local_hfence_vvma_asid_all(unsigned long vmid,
 
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
-	/*
-	 * rs1 = zero
-	 * rs2 = a0 (ASID)
-	 * HFENCE.VVMA zero, a0
-	 * 0010001 01010 00000 000 00000 1110011
-	 */
-	asm volatile ("add a0, %0, zero\n"
-		      ".word 0x22a00073\n"
-		      :: "r" (asid) : "a0", "memory");
+	asm volatile(HFENCE_VVMA("zero", "%0") : : "r" (asid) : "memory");
 
 	csr_write(CSR_HGATP, hgatp);
 }
@@ -184,15 +106,8 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
 	for (pos = gva; pos < (gva + gvsz); pos += BIT(order)) {
-		/*
-		 * rs1 = a0 (GVA)
-		 * rs2 = zero
-		 * HFENCE.VVMA a0
-		 * 0010001 00000 01010 000 00000 1110011
-		 */
-		asm volatile ("add a0, %0, zero\n"
-			      ".word 0x22050073\n"
-			      :: "r" (pos) : "a0", "memory");
+		asm volatile(HFENCE_VVMA("%0", "zero")
+		: : "r" (pos) : "memory");
 	}
 
 	csr_write(CSR_HGATP, hgatp);
@@ -204,13 +119,7 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
 
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
-	/*
-	 * rs1 = zero
-	 * rs2 = zero
-	 * HFENCE.VVMA
-	 * 0010001 00000 00000 000 00000 1110011
-	 */
-	asm volatile (".word 0x22000073" ::: "memory");
+	asm volatile(HFENCE_VVMA("zero", "zero") : : : "memory");
 
 	csr_write(CSR_HGATP, hgatp);
 }
-- 
2.37.1

