Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE78F4F9DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiDHUHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbiDHUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:07:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8DC3504B9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:05:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso7520070ybs.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=esUaOXgWpneeDOe1nHSsJFtoUVHLKNAUZwk+yTUnDdM=;
        b=IHzrsZW7/q3+tEZC29qIaCKrteJifI3LPzC8FMKtlG6sg3D3XkHzpF5KGjv+e5/NhV
         6lEaVR8Crd2tdksjW6hvrrrKyMMVfPZh0oV1fWsNdjpTlEX4KRQBfVIMRjCSEctPpt4K
         WUdqmieif6ozxcp6hvhIBN4d+lNvCAXGaecrB9GfIU/1ASsl7wODGe4dCpXGnAqq7gck
         8IA54iJ5GFDM6mT6yvePQuM1mBUG1OwobOsI3rPtiQndmcU/8PqOT3D31ke4tkcsZpU1
         K6Fb8dK4Uz1h9V4cdBubVhxnYNx5LgNgykvPYiiuhjvIONbDP7586D+liVFRDOhBGiAc
         nnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=esUaOXgWpneeDOe1nHSsJFtoUVHLKNAUZwk+yTUnDdM=;
        b=5Bce8ytFysNvGROZog8Bi1dwFqNZCI2nFXq6aw1WrG6wg6wZ6gkCh71LuVqTPrfU/r
         E7or/jEkBY+r2+i4cKzsC10ThyZuuaGy5RfXnGAw71K8L4HELOZrOYXIB1mR2y0ILTHi
         A+Lsyme9hyQ6y1swBl4huompl1Yd1xBBvVGaAvFyUgHH0K4AMHCKtkUKLWW9FZkRgy48
         7VMnQSrck0cr3PB5BcxAO1XCWeGRqa6kZnxgUc/q/bmBfTd5O5Yx7Z94QD6b9yx+Qcv5
         wA2a9WvKhqA94Fi4O20yxGfyeCt5W8fksof3WwqD40sHXeqrEyRQORbFR56W30MVtNtv
         2IMw==
X-Gm-Message-State: AOAM5333uJmP9NKI7LTy0h2poq/xvKnPLFy/89qD5JPa/43Qv0n3otTf
        xfAcJrJg8qCfSc1d54ELtingW9/PD6Prb53kVQ==
X-Google-Smtp-Source: ABdhPJz/3Xcw9SE5/vQgYOnTDGnnPlY2m9VAKUmssImoSjztfyhXAryYWgmW8RSAso7gPCjapDD1N/7fFM1zmonZTg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:f0ed:c8a:dab7:ecc2])
 (user=kaleshsingh job=sendgmr) by 2002:a25:8e90:0:b0:637:3d1f:cc39 with SMTP
 id q16-20020a258e90000000b006373d1fcc39mr15648078ybl.321.1649448301801; Fri,
 08 Apr 2022 13:05:01 -0700 (PDT)
Date:   Fri,  8 Apr 2022 13:03:25 -0700
In-Reply-To: <20220408200349.1529080-1-kaleshsingh@google.com>
Message-Id: <20220408200349.1529080-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v7 2/6] KVM: arm64: Introduce pkvm_alloc_private_va_range()
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
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
index cdbe8e246418..670f11349070 100644
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
+	size += offset_in_page(phys);
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
2.35.1.1178.g4f1659d476-goog

