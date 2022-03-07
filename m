Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E04D4D06E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbiCGSvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiCGSvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:51:43 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A058A8B6C9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:50:48 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d81518795fso139690857b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=QBbWsCMipbp44l60Hdnv4XMYOtaR1GdEoMf3jzNsWgs=;
        b=gM0pv/8FCbYZxhqR275beD5eFCkqcNqsMmJ/PCIO9/74PJRIq4bvKL+TExhgPsSV9H
         8IZ+Lx+fTJxGshS8UCfhsyQH8OHdgtqaelSPoEUQ/ZZgA5JZ2XXIk2wDBkSsS09ci/Vm
         nc14x3Fm7A06nDWxKHmLzedW5ynRc/Fk8ZUlE3hox6qPSjvxPdxrqiYDWcslJKOvGQeA
         OLEi1Q/pjI0xTGX5fvu9dT3uMRuEvspchfT3X08k4XOIdO31s3fgNXbgWMurSlR1u5Kp
         TvjBEZJQrm+rwVWO0Is4qUz55KsBhuIJ6FUZJDI0qGpEwtwoJlvpoRx3mLo1+HYZSXBn
         46LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=QBbWsCMipbp44l60Hdnv4XMYOtaR1GdEoMf3jzNsWgs=;
        b=plipWvQLW+f74qFJ/lv5qfUfLUb9wRsfZ+hDgHjqCqeUrM/QBpN6iqEZyT/rjX7WNM
         jn/jFizc3awgn0B06yAx3WHPLpd9Y+rtB5XrSP1766iPswk4bgCxmRINNIsdykGSBS03
         OEQ6AB6GVM0VUJJpoaNPWtjg0RLu+VxAYEl1mBcGgPVbgWUXu3umwaX8+iB8KFKokvmv
         G7hbib0ZwlcB/SetNd2E02jlt8/YNJAhMCrH73TCGXYGD/3YuuCC6Lr0GTZ5unNBh4vQ
         PYNbCZM58MBNGXi9X0GGpFpfSD89AFjGvhXXwTaFchKHuuuWqYeS/RAd8IYrY1ekKVn3
         JkJA==
X-Gm-Message-State: AOAM5308fLYI0q3hdl5wwgC7eynvuoJ534oE9wUsc6nx0jXBKfMOWNoJ
        awgIWWKY1GRvxCiWN/v0+xVkDHS+57Zw92ou6Q==
X-Google-Smtp-Source: ABdhPJxC3SgNVhIeELDphJF5+sDCMc2sK08i+u2Eh85wtEFHg9LLbSQ7mTnrKZENjGb8LjSuT4xNjhZG48kUobrwoQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:dd66:1e7d:1858:4587])
 (user=kaleshsingh job=sendgmr) by 2002:a25:e7c4:0:b0:629:415b:40b5 with SMTP
 id e187-20020a25e7c4000000b00629415b40b5mr4859841ybh.315.1646679047782; Mon,
 07 Mar 2022 10:50:47 -0800 (PST)
Date:   Mon,  7 Mar 2022 10:49:00 -0800
In-Reply-To: <20220307184935.1704614-1-kaleshsingh@google.com>
Message-Id: <20220307184935.1704614-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220307184935.1704614-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 2/8] KVM: arm64: Introduce pkvm_alloc_private_va_range()
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
        Andrew Scull <ascull@google.com>,
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
in the pKVM nVHE hypervisor. Allocations are aligned based on the order of
the requested size.

This will be used to implement stack guard pages for pKVM nVHE hypervisor
(in a subsequent patch in the series).

Credits to Quentin Perret <qperret@google.com> for the idea of moving
private VA allocation out of __pkvm_create_private_mapping()

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

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


 arch/arm64/kvm/hyp/include/nvhe/mm.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mm.c         | 56 ++++++++++++++++++----------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 2d08510c6cc1..4489c3c849de 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -21,6 +21,7 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
 int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
 unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
 					    enum kvm_pgtable_prot prot);
+unsigned long pkvm_alloc_private_va_range(size_t size);
 
 static inline void hyp_vmemmap_range(phys_addr_t phys, unsigned long size,
 				     unsigned long *start, unsigned long *end)
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 526a7d6fa86f..c0943e541a8d 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -37,38 +37,54 @@ static int __pkvm_create_mappings(unsigned long start, unsigned long size,
 	return err;
 }
 
-unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
-					    enum kvm_pgtable_prot prot)
+/**
+ * pkvm_alloc_private_va_range - Allocates a private VA range.
+ * @size:	The size of the VA range to reserve.
+ *
+ * The private VA range is allocated above __io_map_base and
+ * aligned based on the order of @size.
+ */
+unsigned long pkvm_alloc_private_va_range(size_t size)
 {
-	unsigned long addr;
-	int err;
+	unsigned long base, addr;
 
 	hyp_spin_lock(&pkvm_pgd_lock);
 
-	size = PAGE_ALIGN(size + offset_in_page(phys));
-	addr = __io_map_base;
-	__io_map_base += size;
+	/* Align the allocation based on the order of its size */
+	addr = ALIGN(__io_map_base, PAGE_SIZE << get_order(size));
+
+	/* The allocated size is always a multiple of PAGE_SIZE */
+	base = addr + PAGE_ALIGN(size);
 
 	/* Are we overflowing on the vmemmap ? */
-	if (__io_map_base > __hyp_vmemmap) {
-		__io_map_base -= size;
+	if (!addr || base > __hyp_vmemmap)
 		addr = (unsigned long)ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	else
+		__io_map_base = base;
 
-	err = kvm_pgtable_hyp_map(&pkvm_pgtable, addr, size, phys, prot);
-	if (err) {
-		addr = (unsigned long)ERR_PTR(err);
-		goto out;
-	}
-
-	addr = addr + offset_in_page(phys);
-out:
 	hyp_spin_unlock(&pkvm_pgd_lock);
 
 	return addr;
 }
 
+unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
+					    enum kvm_pgtable_prot prot)
+{
+	unsigned long addr;
+	int err;
+
+	size += offset_in_page(phys);
+	addr = pkvm_alloc_private_va_range(size);
+	if (IS_ERR((void *)addr))
+		return addr;
+
+	err = __pkvm_create_mappings(addr, size, phys, prot);
+	if (err)
+		return (unsigned long)ERR_PTR(err);
+
+	return addr + offset_in_page(phys);
+}
+
 int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
 {
 	unsigned long start = (unsigned long)from;
@@ -155,7 +171,7 @@ int hyp_map_vectors(void)
 	bp_base = (void *)__pkvm_create_private_mapping(phys,
 							__BP_HARDEN_HYP_VECS_SZ,
 							PAGE_HYP_EXEC);
-	if (IS_ERR_OR_NULL(bp_base))
+	if (IS_ERR(bp_base))
 		return PTR_ERR(bp_base);
 
 	__hyp_bp_vect_base = bp_base;
-- 
2.35.1.616.g0bdcbb4464-goog

