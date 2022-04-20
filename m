Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED18550924B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382641AbiDTVrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiDTVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:47:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0B447ACD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:44:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb2bc9018aso26937487b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=BogsBXABktFG0DHwrUtlQektCpF/08d5mM7wBisYbxw=;
        b=VWhDwyuJHJN0/FjtTViruyvGpY/7A0N/EpUNuOCFIlLGIggSNj8zqNGljB1QWydW9Z
         74dPKsjOl6IJ863G/qtse8k4sCCJHI/+dy3Sa92WMmPhretB7CoU9Ovg+ZtEw8MuM4W8
         fxg6nZC5P1l/vQYKF07jKASSb7YeD+AXXkT1iZaxi5mMSOZIx+36Sc2A9qtVWZY2uvfG
         LXVU2v06nDrw6kUizukdhKuf9vpgRqrL7ukjvaiU+TyJmPKZPnTMLr3G2sb54H/KIWeB
         v0CYkVOp2pSLrByfdd4MaJjVQ3ND+XiKtUqrRGEGXkjDWzC9GGwMQDEFgl/pJWFYQy+y
         iUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=BogsBXABktFG0DHwrUtlQektCpF/08d5mM7wBisYbxw=;
        b=elaEtQlJMw4l1jw+V/SqM12P8EgF4kNjL8noA7oVtLNxbYDt2GpSMJMFaIB7Zn2F8T
         /7saWMm6/Wiw3EoABr6x/ZPERumhfueeufrvSyCupeetpwdN47DX5/jQvDQGu/cnkLEV
         khcnaXrImn8ihLKFJJB63doFFiJaYFZG4tESlF+KUoVtPvhcyixj2zEKgBDx/vdas6UH
         b9Aqaje1Ld29cvSZMtfiVLKtDGJ84bZ3LYKykcWFDElWG7wV55mNSdYESs/EsGOjw688
         GW4WavA+IT+jhOSFSErqsG0IC921Ct3qfYelzPXZq0VP2kxk1E9N5jq65/ScCy4yy5cV
         d3HQ==
X-Gm-Message-State: AOAM532qLe963PHtIp5dwmB6olWMnHK5Uo0ZVGkJUcjbILkDsiGiSnO6
        zA++O14T17hnrpVB5nCoS3a7L22C7B9YU8cIbA==
X-Google-Smtp-Source: ABdhPJyof3Jv6llhTaTubLM1S8UoZuK++2AYOSCa5aeHhAWWq/dWly3CQhpjzyj/QsdPwQ/9jEoKCbzm+Ua/ft55wg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:2a20:cec4:8f41:cd6f])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:70d:b0:644:b5e4:aa25 with
 SMTP id k13-20020a056902070d00b00644b5e4aa25mr22610620ybt.61.1650491071245;
 Wed, 20 Apr 2022 14:44:31 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:42:53 -0700
In-Reply-To: <20220420214317.3303360-1-kaleshsingh@google.com>
Message-Id: <20220420214317.3303360-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220420214317.3303360-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v8 2/6] KVM: arm64: Introduce pkvm_alloc_private_va_range()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pkvm_hyp_alloc_private_va_range() can be used to reserve private VA ranges
in the pKVM nVHE hypervisor. Allocations are aligned based on the order of
the requested size.

This will be used to implement stack guard pages for pKVM nVHE hypervisor
(in a subsequent patch in the series).

Credits to Quentin Perret <qperret@google.com> for the idea of moving
private VA allocation out of __pkvm_create_private_mapping()

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v8:
  - PAGE_ALIGN the size in __pkvm_create_private_mapping(), per Marc

Changes in v7:
  - Add Fuad's Reviewed-by and Tested-by tags.

Changes in v6:
  - Update kernel-doc for pkvm_alloc_private_va_range() and add
    return description, per Stephen
  - Update pkvm_alloc_private_va_range() to return an int error code,
    per Stephen
  - Update __pkvm_create_private_mapping to return an in error code,
    per Quentin
  - Update callers of __pkvm_create_private_mapping() to handle new
    return value and params.

Changes in v5:
  - Align private allocations based on the order of their size, per Marc

Changes in v4:
  - Handle null ptr in pkvm_alloc_private_va_range() and replace
    IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
  - Fix kernel-doc comments format, per Fuad
  - Format __pkvm_create_private_mapping() prototype args (< 80 col), per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark

Changes in v2:
  - Allow specifying an alignment for the private VA allocations, per Marc


 arch/arm64/kvm/hyp/include/nvhe/mm.h |  6 ++-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c   | 18 ++++++-
 arch/arm64/kvm/hyp/nvhe/mm.c         | 78 ++++++++++++++++++----------
 3 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 2d08510c6cc1..42d8eb9bfe72 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -19,8 +19,10 @@ int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
 int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
 int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
-unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
-					    enum kvm_pgtable_prot prot);
+int __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
+				  enum kvm_pgtable_prot prot,
+				  unsigned long *haddr);
+int pkvm_alloc_private_va_range(size_t size, unsigned long *haddr);
 
 static inline void hyp_vmemmap_range(phys_addr_t phys, unsigned long size,
 				     unsigned long *start, unsigned long *end)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 5e2197db0d32..3cea4b6ac23e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -160,7 +160,23 @@ static void handle___pkvm_create_private_mapping(struct kvm_cpu_context *host_ct
 	DECLARE_REG(size_t, size, host_ctxt, 2);
 	DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 3);
 
-	cpu_reg(host_ctxt, 1) = __pkvm_create_private_mapping(phys, size, prot);
+	/*
+	 * __pkvm_create_private_mapping() populates a pointer with the
+	 * hypervisor start address of the allocation.
+	 *
+	 * However, handle___pkvm_create_private_mapping() hypercall crosses the
+	 * EL1/EL2 boundary so the pointer would not be valid in this context.
+	 *
+	 * Instead pass the allocation address as the return value (or return
+	 * ERR_PTR() on failure).
+	 */
+	unsigned long haddr;
+	int err = __pkvm_create_private_mapping(phys, size, prot, &haddr);
+
+	if (err)
+		haddr = (unsigned long)ERR_PTR(err);
+
+	cpu_reg(host_ctxt, 1) = haddr;
 }
 
 static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index cdbe8e246418..96193cb31a39 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -37,36 +37,60 @@ static int __pkvm_create_mappings(unsigned long start, unsigned long size,
 	return err;
 }
 
-unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
-					    enum kvm_pgtable_prot prot)
+/**
+ * pkvm_alloc_private_va_range - Allocates a private VA range.
+ * @size:	The size of the VA range to reserve.
+ * @haddr:	The hypervisor virtual start address of the allocation.
+ *
+ * The private virtual address (VA) range is allocated above __io_map_base
+ * and aligned based on the order of @size.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+int pkvm_alloc_private_va_range(size_t size, unsigned long *haddr)
 {
-	unsigned long addr;
-	int err;
+	unsigned long base, addr;
+	int ret = 0;
 
 	hyp_spin_lock(&pkvm_pgd_lock);
 
-	size = PAGE_ALIGN(size + offset_in_page(phys));
-	addr = __io_map_base;
-	__io_map_base += size;
+	/* Align the allocation based on the order of its size */
+	addr = ALIGN(__io_map_base, PAGE_SIZE << get_order(size));
 
-	/* Are we overflowing on the vmemmap ? */
-	if (__io_map_base > __hyp_vmemmap) {
-		__io_map_base -= size;
-		addr = (unsigned long)ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	/* The allocated size is always a multiple of PAGE_SIZE */
+	base = addr + PAGE_ALIGN(size);
 
-	err = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, size, phys, prot);
-	if (err) {
-		addr = (unsigned long)ERR_PTR(err);
-		goto out;
+	/* Are we overflowing on the vmemmap ? */
+	if (!addr || base > __hyp_vmemmap)
+		ret = -ENOMEM;
+	else {
+		__io_map_base = base;
+		*haddr = addr;
 	}
 
-	addr = addr + offset_in_page(phys);
-out:
 	hyp_spin_unlock(&pkvm_pgd_lock);
 
-	return addr;
+	return ret;
+}
+
+int __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
+				  enum kvm_pgtable_prot prot,
+				  unsigned long *haddr)
+{
+	unsigned long addr;
+	int err;
+
+	size = PAGE_ALIGN(size + offset_in_page(phys));
+	err = pkvm_alloc_private_va_range(size, &addr);
+	if (err)
+		return err;
+
+	err = __pkvm_create_mappings(addr, size, phys, prot);
+	if (err)
+		return err;
+
+	*haddr = addr + offset_in_page(phys);
+	return err;
 }
 
 int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
@@ -146,7 +170,8 @@ int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot)
 int hyp_map_vectors(void)
 {
 	phys_addr_t phys;
-	void *bp_base;
+	unsigned long bp_base;
+	int ret;
 
 	if (!kvm_system_needs_idmapped_vectors()) {
 		__hyp_bp_vect_base = __bp_harden_hyp_vecs;
@@ -154,13 +179,12 @@ int hyp_map_vectors(void)
 	}
 
 	phys = __hyp_pa(__bp_harden_hyp_vecs);
-	bp_base = (void *)__pkvm_create_private_mapping(phys,
-							__BP_HARDEN_HYP_VECS_SZ,
-							PAGE_HYP_EXEC);
-	if (IS_ERR_OR_NULL(bp_base))
-		return PTR_ERR(bp_base);
+	ret = __pkvm_create_private_mapping(phys, __BP_HARDEN_HYP_VECS_SZ,
+					    PAGE_HYP_EXEC, &bp_base);
+	if (ret)
+		return ret;
 
-	__hyp_bp_vect_base = bp_base;
+	__hyp_bp_vect_base = (void *)bp_base;
 
 	return 0;
 }
-- 
2.36.0.rc0.470.gd361397f0d-goog

