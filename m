Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DFF5AB70F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbiIBRCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiIBRBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:01:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0213DB7CE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:01:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q63so2441044pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Su+dsdcpKuRfup/BhsX87oNpiePy7DEXUs63rjehEaY=;
        b=KLnVSWtomAnhLo0pq73SJeNRBQSDLJfIaRsTg8uiS86qckEByuYJw47yP+v7Q9idYT
         WvPcg0sXMfREPwpm1xMsb/lHOB27NnFgCjH2L5EIt7ZPMlmHPBkhHyadMWMQ232o0zwa
         K4xosfpalFGdEE40Vi+FxEzYiBqaVSf8H5rzV8MSq392MnGA8J0FFRcdZDUP96MYUbu1
         8+gt4P/0sMNbDR1tw7EUGBHIwViGboRQpsIBDcsAfMK/Dp4gVRMoH87Mf5DVnBpNdF7q
         FBWGx8KwOiSXe/inpkpCqcqeXLMJrJgeXDzFMvQ1NWoqKYloz9dViFMddNWY6RbLh5ew
         5oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Su+dsdcpKuRfup/BhsX87oNpiePy7DEXUs63rjehEaY=;
        b=8AmgrahqZ7UIGdC5yI3WyU7gX7BWa3ePo9AngHnNHEGwBprAnX92+zyEHEu58iIgP0
         iUO1GUTe9HlCkDNYDrq0+UZAe/kfq0ynAQSYH9/u8ERhOSeb26fZTuU1VVyQXxgzxQ/I
         PUWssOXlcY4DQKbIctJPNWdtuCKUi3cTxRWEzeC2iwSdpjPB3tamJszxc3bvMQzjDZRP
         WZtckvBwbT7tLODQh+cXTecQ+LHxbaoiLa/2sta3xQCHb0t3GqCTX4WKlhNsCJEwz3dy
         pmE2la5J29oAZTorRLfJn83xoI4ZmnEsmP8L+Ljz6NLPjDRXe3py33b2nTpasmovvO9i
         Zhaw==
X-Gm-Message-State: ACgBeo16Kw9Y1GqwxxiRXq3dfdfKBZlpVVTBLv3l4cVCkvREh45YDkN3
        E5c5Sv13ebOWKYqaTO9nUbzfDw==
X-Google-Smtp-Source: AA6agR6Ave9zbkVSjlZNRhdmS8luMf/rm3AkYoo0a9S+xrfdpphbvbioMvCY+PLiiQasurVI/Ov7tA==
X-Received: by 2002:a05:6a00:88a:b0:53a:b7a0:ea3a with SMTP id q10-20020a056a00088a00b0053ab7a0ea3amr14504597pfj.21.1662138111845;
        Fri, 02 Sep 2022 10:01:51 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([171.76.83.155])
        by smtp.gmail.com with ESMTPSA id w10-20020a65534a000000b0043014f9a4c9sm1638800pgr.93.2022.09.02.10.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:01:51 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/3] RISC-V: KVM: Use Svinval for local TLB maintenance when available
Date:   Fri,  2 Sep 2022 22:31:30 +0530
Message-Id: <20220902170131.32334-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902170131.32334-1-apatel@ventanamicro.com>
References: <20220902170131.32334-1-apatel@ventanamicro.com>
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

We should prefer HINVAL.GVMA and HINVAL.VVMA instruction for local TLB
maintenance when underlying host supports Svinval extension.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/insn-def.h | 20 +++++++++++
 arch/riscv/kvm/tlb.c              | 60 ++++++++++++++++++++++++-------
 2 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
index 8fe9036efb68..246a627d16ee 100644
--- a/arch/riscv/include/asm/insn-def.h
+++ b/arch/riscv/include/asm/insn-def.h
@@ -110,4 +110,24 @@
 	__ASM_STR(.error "hlv.d requires 64-bit support")
 #endif
 
+#define SINVAL_VMA(vaddr, asid)					\
+	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(11),		\
+	       __RD(0), RS1(vaddr), RS2(asid))
+
+#define SFENCE_W_INVAL()					\
+	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(12),		\
+	       __RD(0), __RS1(0), __RS2(0))
+
+#define SFENCE_INVAL_IR()					\
+	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(12),		\
+	       __RD(0), __RS1(0), __RS2(1))
+
+#define HINVAL_VVMA(vaddr, asid)				\
+	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(19),		\
+	       __RD(0), RS1(vaddr), RS2(asid))
+
+#define HINVAL_GVMA(gaddr, vmid)				\
+	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(51),		\
+	       __RD(0), RS1(gaddr), RS2(vmid))
+
 #endif /* __ASM_INSN_DEF_H */
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 1ce3394b3acf..309d79b3e5cd 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -12,8 +12,12 @@
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
 #include <asm/csr.h>
+#include <asm/hwcap.h>
 #include <asm/insn-def.h>
 
+#define has_svinval()	\
+	static_branch_unlikely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_SVINVAL])
+
 void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
 					  gpa_t gpa, gpa_t gpsz,
 					  unsigned long order)
@@ -25,9 +29,17 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
 		return;
 	}
 
-	for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
-		asm volatile (HFENCE_GVMA(%0, %1)
-		: : "r" (pos >> 2), "r" (vmid) : "memory");
+	if (has_svinval()) {
+		asm volatile (SFENCE_W_INVAL() ::: "memory");
+		for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+			asm volatile (HINVAL_GVMA(%0, %1)
+			: : "r" (pos >> 2), "r" (vmid) : "memory");
+		asm volatile (SFENCE_INVAL_IR() ::: "memory");
+	} else {
+		for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+			asm volatile (HFENCE_GVMA(%0, %1)
+			: : "r" (pos >> 2), "r" (vmid) : "memory");
+	}
 }
 
 void kvm_riscv_local_hfence_gvma_vmid_all(unsigned long vmid)
@@ -45,9 +57,17 @@ void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
 		return;
 	}
 
-	for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
-		asm volatile(HFENCE_GVMA(%0, zero)
-		: : "r" (pos >> 2) : "memory");
+	if (has_svinval()) {
+		asm volatile (SFENCE_W_INVAL() ::: "memory");
+		for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+			asm volatile(HINVAL_GVMA(%0, zero)
+			: : "r" (pos >> 2) : "memory");
+		asm volatile (SFENCE_INVAL_IR() ::: "memory");
+	} else {
+		for (pos = gpa; pos < (gpa + gpsz); pos += BIT(order))
+			asm volatile(HFENCE_GVMA(%0, zero)
+			: : "r" (pos >> 2) : "memory");
+	}
 }
 
 void kvm_riscv_local_hfence_gvma_all(void)
@@ -70,9 +90,17 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
 
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
-	for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
-		asm volatile(HFENCE_VVMA(%0, %1)
-		: : "r" (pos), "r" (asid) : "memory");
+	if (has_svinval()) {
+		asm volatile (SFENCE_W_INVAL() ::: "memory");
+		for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+			asm volatile(HINVAL_VVMA(%0, %1)
+			: : "r" (pos), "r" (asid) : "memory");
+		asm volatile (SFENCE_INVAL_IR() ::: "memory");
+	} else {
+		for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+			asm volatile(HFENCE_VVMA(%0, %1)
+			: : "r" (pos), "r" (asid) : "memory");
+	}
 
 	csr_write(CSR_HGATP, hgatp);
 }
@@ -102,9 +130,17 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
 
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
-	for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
-		asm volatile(HFENCE_VVMA(%0, zero)
-		: : "r" (pos) : "memory");
+	if (has_svinval()) {
+		asm volatile (SFENCE_W_INVAL() ::: "memory");
+		for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+			asm volatile(HINVAL_VVMA(%0, zero)
+			: : "r" (pos) : "memory");
+		asm volatile (SFENCE_INVAL_IR() ::: "memory");
+	} else {
+		for (pos = gva; pos < (gva + gvsz); pos += BIT(order))
+			asm volatile(HFENCE_VVMA(%0, zero)
+			: : "r" (pos) : "memory");
+	}
 
 	csr_write(CSR_HGATP, hgatp);
 }
-- 
2.34.1

