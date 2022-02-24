Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493BE4C2345
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiBXFRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBXFRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:17:46 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDB1193DC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:17:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d306e372e5so11848457b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=zjkrHmiNRPu+xkjmRYtl/GGfGVxWhgBcWrDndSQY1ZI=;
        b=Q95PhZkuTj3mTiQTdWyA/cas59PM8HotrPoSBHBleUFfsGDZ+H8BDlNMcgFVXhTr9r
         /MI8YF1TH+9h5XzoX87kUd9gLIBzeivRDhdtwBvEaGcsB9JIMdTif9wH8Ad+3bWvCj4E
         qzBrRM/9BbZcs3edkYZnI0yYE9ptbzZ4KXUgpc+Y7Nqw5MVFoSG5XqrjLWTQV8HMt+PU
         /PN37+AdvRXsrKuxDxtHwLhYEQp8vJyCDk/iWAK7AsShDriIEyv7qTS3glTu3GBYpGBG
         tLPs8x375wqy623V/UueGb+TWcfsv+OZzuNSMLTGNBT1RgPIQsiBrqEFpIhGFXthhpQd
         CNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=zjkrHmiNRPu+xkjmRYtl/GGfGVxWhgBcWrDndSQY1ZI=;
        b=bCc1O58h6qpEbPQycW8K1eI701j8IU8WBlMiSXbK41/wo1mHx8tRjXx0gNSQcrFQUT
         K2KH92nju9RejUpgHwfX9V4mg9TurfxfgoV5/x/bJwSVr9brVeHoUaj0MXQstsQwksf0
         2lZZ3H4OGYhSFV/tXfkg5jjr6BRqax0+aP0hM/cuNdI2Dct2pguIoN9E3V3OjYfqlK68
         DcktyhiX+mEcgDPmUKiEEK6YmqTI7O/y0w8LlEWHVNNbHGTWYMhoJcr11pGaEoJv353E
         f7ZvAHaq6jLeXYVrYtf9P53JlrUNx3LHy4EQbyxFkXiKdNmVTLLeogD1f94dZGDL62nJ
         s9uA==
X-Gm-Message-State: AOAM530Dm1L1JTYlf/aIp8mbvWv7m9qY2YlZVnEXsS+mR8Di9qm9Fy2M
        lDojtbvQ+wuvbVL1UQCMb0txBPRURCg59Y5zMQ==
X-Google-Smtp-Source: ABdhPJwTsQs5w3bWg3HLZfUpV1mRpvUXTrwenTjM/5KRDY/s/xsywaNBh5k6hbdm6EBRXI1pEfunZGxTVf+s4otTCg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:415c:9be0:c461:440a])
 (user=kaleshsingh job=sendgmr) by 2002:a25:6911:0:b0:624:5f4b:2a01 with SMTP
 id e17-20020a256911000000b006245f4b2a01mr1014225ybc.303.1645679836014; Wed,
 23 Feb 2022 21:17:16 -0800 (PST)
Date:   Wed, 23 Feb 2022 21:13:37 -0800
In-Reply-To: <20220224051439.640768-1-kaleshsingh@google.com>
Message-Id: <20220224051439.640768-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220224051439.640768-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 2/8] KVM: arm64: Introduce pkvm_alloc_private_va_range()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pkvm_hyp_alloc_private_va_range() can be used to reserve private VA ranges
in the pKVM nVHE hypervisor (). Also update __pkvm_create_private_mapping()
to allow specifying an alignment for the private VA mapping.

These will be used to implement stack guard pages for pKVM nVHE hypervisor
(in a subsequent patch in the series).

Credits to Quentin Perret <qperret@google.com> for the idea of moving
private VA allocation out of __pkvm_create_private_mapping()

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark

Changes in v2:
  - Allow specifying an alignment for the private VA allocations, per Marc

 arch/arm64/kvm/hyp/include/nvhe/mm.h |  3 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   |  5 +--
 arch/arm64/kvm/hyp/nvhe/mm.c         | 51 ++++++++++++++++++----------
 arch/arm64/kvm/mmu.c                 |  2 +-
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 2d08510c6cc1..05d06ad00347 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -20,7 +20,8 @@ int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
 int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
 unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
-					    enum kvm_pgtable_prot prot);
+					size_t align, enum kvm_pgtable_prot prot);
+unsigned long pkvm_alloc_private_va_range(size_t size, size_t align);
 
 static inline void hyp_vmemmap_range(phys_addr_t phys, unsigned long size,
 				     unsigned long *start, unsigned long *end)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 5e2197db0d32..96b2312a0f1d 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -158,9 +158,10 @@ static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ct
 {
 	DECLARE_REG(phys_addr_t, phys, host_ctxt, 1);
 	DECLARE_REG(size_t, size, host_ctxt, 2);
-	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
+	DECLARE_REG(size_t, align, host_ctxt, 3);
+	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 4);
 
-	cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, prot);
+	cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, align, prot);
 }
 
 static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 526a7d6fa86f..f35468ec639d 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -37,26 +37,46 @@ static int __pkvm_create_mappings(unsigned long start, unsigned long size,
 	return err;
 }
 
-unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
-					    enum kvm_pgtable_prot prot)
+/*
+ * Allocates a private VA range above __io_map_base.
+ *
+ * @size:	The size of the VA range to reserve.
+ * @align:	The required alignment for the allocation.
+ */
+unsigned long pkvm_alloc_private_va_range(size_t size, size_t align)
 {
-	unsigned long addr;
-	int err;
+	unsigned long base, addr;
 
 	hyp_spin_lock(&pkvm_pgd_lock);
 
-	size = PAGE_ALIGN(size + offset_in_page(phys));
-	addr = __io_map_base;
-	__io_map_base += size;
+	addr = ALIGN(__io_map_base, align);
+
+	/* The allocated size is always a multiple of PAGE_SIZE */
+	base = addr + PAGE_ALIGN(size);
 
 	/* Are we overflowing on the vmemmap ? */
-	if (__io_map_base > __hyp_vmemmap) {
-		__io_map_base -= size;
+	if (base > __hyp_vmemmap)
 		addr = (unsigned long)ERR_PTR(-ENOMEM);
+	else
+		__io_map_base = base;
+
+	hyp_spin_unlock(&pkvm_pgd_lock);
+
+	return addr;
+}
+
+unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
+					size_t align, enum kvm_pgtable_prot prot)
+{
+	unsigned long addr;
+	int err;
+
+	size += offset_in_page(phys);
+	addr = pkvm_alloc_private_va_range(size, align);
+	if (IS_ERR((void *)addr))
 		goto out;
-	}
 
-	err = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, size, phys, prot);
+	err = __pkvm_create_mappings(addr, size, phys, prot);
 	if (err) {
 		addr = (unsigned long)ERR_PTR(err);
 		goto out;
@@ -64,8 +84,6 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 
 	addr = addr + offset_in_page(phys);
 out:
-	hyp_spin_unlock(&pkvm_pgd_lock);
-
 	return addr;
 }
 
@@ -152,11 +170,10 @@ int hyp_map_vectors(void)
 		return 0;
 
 	phys = __hyp_pa(__bp_harden_hyp_vecs);
-	bp_base = (void *)__pkvm_create_private_mapping(phys,
-							__BP_HARDEN_HYP_VECS_SZ,
-							PAGE_HYP_EXEC);
+	bp_base = (void *)__pkvm_create_private_mapping(phys, __BP_HARDEN_HYP_VECS_SZ,
+							PAGE_SIZE, PAGE_HYP_EXEC);
 	if (IS_ERR_OR_NULL(bp_base))
-		return PTR_ERR(bp_base);
+		return bp_base ? PTR_ERR(bp_base) : -ENOMEM;
 
 	__hyp_bp_vect_base = bp_base;
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index fc09536c8197..298e6d8439ef 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -505,7 +505,7 @@ int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 
 	if (!kvm_host_owns_hyp_mappings()) {
 		addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
-					 phys_addr, size, prot);
+					 phys_addr, size, align, prot);
 		if (IS_ERR_OR_NULL((void *)addr))
 			return addr ? PTR_ERR((void *)addr) : -ENOMEM;
 		*haddr = addr;
-- 
2.35.1.473.g83b2b277ed-goog

