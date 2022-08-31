Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C595A844B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiHaRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiHaRZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:25:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC17E13D0D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso8407988wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fizBC8NpPcL0RO1q/LLq/Re49C8DURQi6bNhDvOLByc=;
        b=Thjp/7LoSdR+BA8d4yQIMpuR3obWObcLBIt6v4+66n8/RxuUlNGmfr8JsCtgZr3Qkf
         6SwmSnpvcy5sXxN29DLz7+SYjrCRgF8X7up11Jis86GrFvuAe/fMDfgBCrxha2l3dsj1
         U5auAhYkh7aZK6d6iRezooRAPPqNdUH6xaYsfCskyMW4OV4kkhiTwucnFEc/Aa2eFrlq
         mFjo1g4k5Dgk27rwbVrIGryJd7B3RNrvTw4LI05x7s6O37XTLXwlSo5C+NR1rOV5O406
         WajxWdao5ciVkP/uSbxsp+5D/6TcoXgYBUJMx4CLVyJMh8eMQr9sIv5EItpjBTdZmddB
         8VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fizBC8NpPcL0RO1q/LLq/Re49C8DURQi6bNhDvOLByc=;
        b=QZ+iebZxB/Sib0gAh0aQKW5MeC8z+UMzISBXacejnx5UKbVcHR5WiYeHtmu6AodGyM
         XfHi80mL397iCRbXcDSFVgv68W26qEGGdk0ykdL0zxc+zO9vimjm6mqNj4N2UMt4zaAw
         Gv7OR9C2DMbSieSh4+yjnbp1vJXjz3JBUc3Zn7sdHBlhsg1aE4NYb7xDOy4pxt5tU8SI
         tNHlTuJ65wMbvXE4InhqpPnDWXFLQuRX8+2y8fX/Jhl9fuXkKo/Hd245SOCk3WVE17gK
         ieXX/jAyrcIoO0pRjSPyP5OUjGXQipSZ7NHEl8a6mDhx1Cosjr4ANHS5E8sp91QBPTDq
         NdVw==
X-Gm-Message-State: ACgBeo1H9WbVQ23tycTlADFLv2gUkuHG4AQp6JqyDJjrX+vG1kI0iF+A
        ItfyIpWpL+Kbog7dUdVEKFUTww==
X-Google-Smtp-Source: AA6agR5wAvxqhLqol7jiXr6Zv4bFSqdk46xUnBeQG+Zqq51F5hJLLyZGiw6lcSeEZ7PZ2SDRjRt8hw==
X-Received: by 2002:a05:600c:28cd:b0:3a5:4f45:b927 with SMTP id h13-20020a05600c28cd00b003a54f45b927mr2728838wmd.90.1661966707060;
        Wed, 31 Aug 2022 10:25:07 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d456b000000b0021f15514e7fsm14899052wrc.0.2022.08.31.10.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:25:06 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH v2 3/4] riscv: KVM: Apply insn-def to hfence encodings
Date:   Wed, 31 Aug 2022 19:24:59 +0200
Message-Id: <20220831172500.752195-4-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831172500.752195-1-ajones@ventanamicro.com>
References: <20220831172500.752195-1-ajones@ventanamicro.com>
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
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/insn-def.h |  10 +++
 arch/riscv/kvm/tlb.c              | 129 ++++--------------------------
 2 files changed, 27 insertions(+), 112 deletions(-)

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index 2dcd1d4781bf..86c1f602413b 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -83,4 +83,14 @@
 #define __RS1(v)	__REG(v)
 #define __RS2(v)	__REG(v)
 
+#define OPCODE_SYSTEM	OPCODE(115)
+
+#define HFENCE_VVMA(vaddr, asid)				\
+	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),		\
+	       __RD(0), RS1(vaddr), RS2(asid))
+
+#define HFENCE_GVMA(gaddr, vmid)				\
+	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(49),		\
+	       __RD(0), RS1(gaddr), RS2(vmid))
+
 #endif /* __ASM_INSN_DEF_H */
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 1a76d0b1907d..1ce3394b3acf 100644
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
@@ -40,32 +25,14 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
 		return;
 	}
 
-	for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
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
-	}
+	for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+		asm volatile (HFENCE_GVMA(%0, %1)
+		: : "r" (pos >> 2), "r" (vmid) : "memory");
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
+	asm volatile(HFENCE_GVMA(zero, %0) : : "r" (vmid) : "memory");
 }
 
 void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
@@ -78,46 +45,16 @@ void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
 		return;
 	}
 
-	for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order)) {
-		/*
-		 * rs1 = a0 (GPA >> 2)
-		 * rs2 = zero
-		 * HFENCE.GVMA a0
-		 * 0110001 00000 01010 000 00000 1110011
-		 */
-		asm volatile ("srli a0, %0, 2\n"
-			      ".word 0x62050073\n"
-			      :: "r" (pos) : "a0", "memory");
-	}
+	for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+		asm volatile(HFENCE_GVMA(%0, zero)
+		: : "r" (pos >> 2) : "memory");
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
+	asm volatile(HFENCE_GVMA(zero, zero) : : : "memory");
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
@@ -133,19 +70,9 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
 
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
-	for (pos = gva; pos < (gva + gvsz); pos += BIT(order)) {
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
-	}
+	for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+		asm volatile(HFENCE_VVMA(%0, %1)
+		: : "r" (pos), "r" (asid) : "memory");
 
 	csr_write(CSR_HGATP, hgatp);
 }
@@ -157,15 +84,7 @@ void kvm_riscv_local_hfence_vvma_asid_all(unsigned long vmid,
 
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
+	asm volatile(HFENCE_VVMA(zero, %0) : : "r" (asid) : "memory");
 
 	csr_write(CSR_HGATP, hgatp);
 }
@@ -183,17 +102,9 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
 
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
-	for (pos = gva; pos < (gva + gvsz); pos += BIT(order)) {
-		/*
-		 * rs1 = a0 (GVA)
-		 * rs2 = zero
-		 * HFENCE.VVMA a0
-		 * 0010001 00000 01010 000 00000 1110011
-		 */
-		asm volatile ("add a0, %0, zero\n"
-			      ".word 0x22050073\n"
-			      :: "r" (pos) : "a0", "memory");
-	}
+	for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+		asm volatile(HFENCE_VVMA(%0, zero)
+		: : "r" (pos) : "memory");
 
 	csr_write(CSR_HGATP, hgatp);
 }
@@ -204,13 +115,7 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
 
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
-	/*
-	 * rs1 = zero
-	 * rs2 = zero
-	 * HFENCE.VVMA
-	 * 0010001 00000 00000 000 00000 1110011
-	 */
-	asm volatile (".word 0x22000073" ::: "memory");
+	asm volatile(HFENCE_VVMA(zero, zero) : : : "memory");
 
 	csr_write(CSR_HGATP, hgatp);
 }
-- 
2.37.2

