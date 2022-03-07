Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C920D4D06E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiCGSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbiCGSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:51:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFD96E367
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:50:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id x11-20020a5b0f0b000000b0062277953037so14183475ybr.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=U0KXh0E1UfE42rPLXuz3Ms4NzPqEuYXKZZtL9fLcEYA=;
        b=nU4RTA3/xhDWfnM8dMSLJKKLbRrMNT3c0ORnHVae1dtm01ActWIdwKtb+4XdGdlWfL
         dy/1kzFpo7DIt5F3glPY4tvNFMHaZDbwC6PVk3ZAvatX334u4JalLNIq5m6iVWhtnW2x
         Yq0g1D3peSs9qAeVur7zzMcTc+qGYOmgoE8BSAckpbzGceepfCq0A/+HiyL+pWj7iiTH
         RJZrzy/96BWG6GCv4E/FRHkMnAQPrcnha/N52RvX5vzsYktYfTJyB7to6Xna/wvIyiJN
         XSayW5jkZJapoyll58iQBJPo9ZrZoBmxddKGdcAmUPZZVz2croqlDmZGSoFPcjUOlDNA
         Kabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=U0KXh0E1UfE42rPLXuz3Ms4NzPqEuYXKZZtL9fLcEYA=;
        b=c7rHxgk6Jkpm++jL13Eq9/8Cs922NNBrFyFVEoN7RI9s1Bzca+/dyDBquq4oqrVWNj
         wrGnbRriUD366eXKg2cZszB0T9Rr+8OHt6dCUsSbeCvdwK/1dKDyIcagRRv3IDSxFWCv
         PH02+17evEVmJ8Xlp/jDeRkuKXcQhH70UiuwqYTtPMVc7UM2Sry0L6AG2qoU7eU9BVMA
         um8WRiZ8TsZy5qzwE7we0Ru2RoKKorYpxh/cEecMTNXaa6+8mbNsQAK+ivBpyFeapQG1
         cSsC/a3g7bF4HFeVxRHH0vPBlnrrgPmgApM+ZJbUz59EyTtMDsAzPG2VXj0M6oKoBcG/
         qRDg==
X-Gm-Message-State: AOAM5332h9zXSaP3Rnn/1lOMPn+6LMyRJRwpoMZ2nd4q+9aBdvvQNGOQ
        JcJyBc8QfWsUHLlw7SQvqkf1nJIE/MfbnvaLVQ==
X-Google-Smtp-Source: ABdhPJz9iBWuUeegmCOa9Cbkl3sUJD62w7+nQrFfm6gUEqY19/bTdAmd6dRquKjJLU6HAR39kZtea75lirYYlPQxOw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:dd66:1e7d:1858:4587])
 (user=kaleshsingh job=sendgmr) by 2002:a05:690c:16:b0:2db:cfed:de0e with SMTP
 id bc22-20020a05690c001600b002dbcfedde0emr6331197ywb.271.1646679015317; Mon,
 07 Mar 2022 10:50:15 -0800 (PST)
Date:   Mon,  7 Mar 2022 10:48:59 -0800
In-Reply-To: <20220307184935.1704614-1-kaleshsingh@google.com>
Message-Id: <20220307184935.1704614-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220307184935.1704614-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 1/8] KVM: arm64: Introduce hyp_alloc_private_va_range()
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
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Scull <ascull@google.com>,
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

hyp_alloc_private_va_range() can be used to reserve private VA ranges
in the nVHE hypervisor. Allocations are aligned based on the order of
the requested size.

This will be used to implement stack guard pages for KVM nVHE hypervisor
(nVHE Hyp mode / not pKVM), in a subsequent patch in the series.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v5:
  - Align private allocations based on the order of their size, per Marc

Changes in v4:
  - Handle null ptr in hyp_alloc_private_va_range() and replace
    IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
  - Fix kernel-doc comments format, per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark


 arch/arm64/include/asm/kvm_mmu.h |  1 +
 arch/arm64/kvm/mmu.c             | 63 +++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 81839e9a8a24..514cfee76597 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -153,6 +153,7 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 int kvm_share_hyp(void *from, void *to);
 void kvm_unshare_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+unsigned long hyp_alloc_private_va_range(size_t size);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
 			   void __iomem **haddr);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index bc2aba953299..ccb2847ee2f4 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -457,22 +457,17 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
 	return 0;
 }
 
-static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
-					unsigned long *haddr,
-					enum kvm_pgtable_prot prot)
+
+/**
+ * hyp_alloc_private_va_range - Allocates a private VA range.
+ * @size:	The size of the VA range to reserve.
+ *
+ * The private VA range is allocated below io_map_base and
+ * aligned based on the order of @size.
+ */
+unsigned long hyp_alloc_private_va_range(size_t size)
 {
 	unsigned long base;
-	int ret = 0;
-
-	if (!kvm_host_owns_hyp_mappings()) {
-		base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
-					 phys_addr, size, prot);
-		if (IS_ERR_OR_NULL((void *)base))
-			return PTR_ERR((void *)base);
-		*haddr = base;
-
-		return 0;
-	}
 
 	mutex_lock(&kvm_hyp_pgd_mutex);
 
@@ -484,29 +479,53 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
 	 *
 	 * The allocated size is always a multiple of PAGE_SIZE.
 	 */
-	size = PAGE_ALIGN(size + offset_in_page(phys_addr));
-	base = io_map_base - size;
+	base = io_map_base - PAGE_ALIGN(size);
+
+	/* Align the allocation based on the order of its size */
+	base = ALIGN_DOWN(base, PAGE_SIZE << get_order(size));
 
 	/*
 	 * Verify that BIT(VA_BITS - 1) hasn't been flipped by
 	 * allocating the new area, as it would indicate we've
 	 * overflowed the idmap/IO address range.
 	 */
-	if ((base ^ io_map_base) & BIT(VA_BITS - 1))
-		ret = -ENOMEM;
+	if (!base || (base ^ io_map_base) & BIT(VA_BITS - 1))
+		base = (unsigned long)ERR_PTR(-ENOMEM);
 	else
 		io_map_base = base;
 
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 
-	if (ret)
-		goto out;
+	return base;
+}
+
+static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
+					unsigned long *haddr,
+					enum kvm_pgtable_prot prot)
+{
+	unsigned long addr;
+	int ret = 0;
+
+	if (!kvm_host_owns_hyp_mappings()) {
+		addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
+					 phys_addr, size, prot);
+		if (IS_ERR((void *)addr))
+			return PTR_ERR((void *)addr);
+		*haddr = addr;
+
+		return 0;
+	}
+
+	size += offset_in_page(phys_addr);
+	addr = hyp_alloc_private_va_range(size);
+	if (IS_ERR((void *)addr))
+		return PTR_ERR((void *)addr);
 
-	ret = __create_hyp_mappings(base, size, phys_addr, prot);
+	ret = __create_hyp_mappings(addr, size, phys_addr, prot);
 	if (ret)
 		goto out;
 
-	*haddr = base + offset_in_page(phys_addr);
+	*haddr = addr + offset_in_page(phys_addr);
 out:
 	return ret;
 }
-- 
2.35.1.616.g0bdcbb4464-goog

