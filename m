Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A950924D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382645AbiDTVsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbiDTVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:48:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9065B24F0C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:45:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso2642684ybs.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=l+WC7bxPewzszL+k3JPl9SfRKuFFZeheKk4Z2YSYX0c=;
        b=kH6X+50CXU0B9J23OVjOUG6h5g3c6tr6fH8cfI3rJDJxnXKFPYs2g5h4P6do/Fz+J+
         lFRfXCK96H3wdWyvB5ffVImXGDX+LYiIdPgRyvs1oggf1lBSu868EewZRXzK+5IjpvKu
         hxDQ5CRzyjjeNUZl7gZ2pkqXjk9my9hmFlBdCsUGlE+5nPduCtPa36HksUSIE6zzqdjR
         O5tYeuutq8xFL6Ruhcx56+rCZ3T8UwPLlVQNjC07B8+bqxlTZmgsVnZG989bWAkMua1S
         XWVJWefsf6Z3UjwM54OZKG+wYb7JDMvJk+DPq0QvDFr2oQy53fDzxqJzalqXRqVMu07t
         bBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=l+WC7bxPewzszL+k3JPl9SfRKuFFZeheKk4Z2YSYX0c=;
        b=b3VPP0/WSHzctTEY+OMXMoONiOi8kX7VtG7dhi5HIRAZVapEhfoJPDrVtdET0gPHK7
         ViiZX2ngP0cYAK8N8nVZYp+swNUwoZlV8V8Rk/RXEoNjVtFxDCwA7ZpqSvbQm5WSY+Wm
         OvOvv7nlbGYQsIQPorY//hFeC76sF7iKWetOWNidl1W/0AycBhVqSzK6/qcM6LkbHabn
         KtIMWqwspJEZOItZABGsIaFRCPw3xQ+sbNeHUSPDs/r+pQrJSVMk061jA7Lh2f4jZk7H
         paTBp/PppXA06ehZodkPst0gY7+4Bw73OiAhC/I/THG5WH9V5CAGatSASqIJC6Ds4C9F
         Wr+w==
X-Gm-Message-State: AOAM532GhHf5X0hXhm2GFvmzPQl4d0KEvYA4AfDEspp2yGVOEl0RPF9m
        l4ngk9Sx0jlCRfzIaVDHI6M8r4EfqeTwg6ld3Q==
X-Google-Smtp-Source: ABdhPJwiYgead6QiW2HPaklZtWwWhmlUfQNFZc361RnnmGoFxH14G07w0bYAlUJmXEesM+yXWl6qV1WNWx8SNYvlfw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:2a20:cec4:8f41:cd6f])
 (user=kaleshsingh job=sendgmr) by 2002:a25:40b:0:b0:645:42f6:ad57 with SMTP
 id 11-20020a25040b000000b0064542f6ad57mr8816256ybe.649.1650491114835; Wed, 20
 Apr 2022 14:45:14 -0700 (PDT)
Date:   Wed, 20 Apr 2022 14:42:54 -0700
In-Reply-To: <20220420214317.3303360-1-kaleshsingh@google.com>
Message-Id: <20220420214317.3303360-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220420214317.3303360-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v8 3/6] KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
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
        Zenghui Yu <yuzenghui@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
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

Map the stack pages in the flexible private VA range and allocate
guard pages below the stack as unbacked VA space. The stack is aligned
so that any valid stack address has PAGE_SHIFT bit as 1 - this is used
for overflow detection (implemented in a subsequent patch in the series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
---

Changes in v8:
  - Don't expose hyp_pgtable and kvm_hyp_pgd_mutex. Instead use
    __create_hyp_mappings() helper, per Marc

Changes in v7:
  - Add Fuad's Reviewed-by and Tested-by tags.

Changes in v6:
  - Update call to hyp_alloc_private_va_range() (return val and params)

Changes in v5:
  - Use a single allocation for stack and guard pages to ensure they
    are contiguous, per Marc

Changes in v4:
  - Replace IS_ERR_OR_NULL check with IS_ERR check now that
    hyp_alloc_private_va_range() returns an error for null
    pointer, per Fuad
  - Format comments to < 80 cols, per Fuad

Changes in v3:
  - Handle null ptr in IS_ERR_OR_NULL checks, per Mark


 arch/arm64/include/asm/kvm_asm.h |  1 +
 arch/arm64/include/asm/kvm_mmu.h |  2 ++
 arch/arm64/kvm/arm.c             | 37 +++++++++++++++++++++++++++++---
 arch/arm64/kvm/mmu.c             |  4 ++--
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index d5b0386ef765..2e277f2ed671 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -169,6 +169,7 @@ struct kvm_nvhe_init_params {
 	unsigned long tcr_el2;
 	unsigned long tpidr_el2;
 	unsigned long stack_hyp_va;
+	unsigned long stack_pa;
 	phys_addr_t pgd_pa;
 	unsigned long hcr_el2;
 	unsigned long vttbr;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index a50cbb5ba402..b208da3bebec 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -154,6 +154,8 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 int kvm_share_hyp(void *from, void *to);
 void kvm_unshare_hyp(void *from, void *to);
 int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
+int __create_hyp_mappings(unsigned long start, unsigned long size,
+			  unsigned long phys, enum kvm_pgtable_prot prot);
 int hyp_alloc_private_va_range(size_t size, unsigned long *haddr);
 int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
 			   void __iomem **kaddr,
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 523bc934fe2f..dd257d9f21a2 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1483,7 +1483,6 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1933,14 +1932,46 @@ static int init_hyp_mode(void)
 	 * Map the Hyp stack pages
 	 */
 	for_each_possible_cpu(cpu) {
+		struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
 		char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
-		err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
-					  PAGE_HYP);
+		unsigned long hyp_addr;
 
+		/*
+		 * Allocate a contiguous HYP private VA range for the stack
+		 * and guard page. The allocation is also aligned based on
+		 * the order of its size.
+		 */
+		err = hyp_alloc_private_va_range(PAGE_SIZE * 2, &hyp_addr);
+		if (err) {
+			kvm_err("Cannot allocate hyp stack guard page\n");
+			goto out_err;
+		}
+
+		/*
+		 * Since the stack grows downwards, map the stack to the page
+		 * at the higher address and leave the lower guard page
+		 * unbacked.
+		 *
+		 * Any valid stack address now has the PAGE_SHIFT bit as 1
+		 * and addresses corresponding to the guard page have the
+		 * PAGE_SHIFT bit as 0 - this is used for overflow detection.
+		 */
+		err = __create_hyp_mappings(hyp_addr + PAGE_SIZE, PAGE_SIZE,
+					    __pa(stack_page), PAGE_HYP);
 		if (err) {
 			kvm_err("Cannot map hyp stack\n");
 			goto out_err;
 		}
+
+		/*
+		 * Save the stack PA in nvhe_init_params. This will be needed
+		 * to recreate the stack mapping in protected nVHE mode.
+		 * __hyp_pa() won't do the right thing there, since the stack
+		 * has been mapped in the flexible private VA space.
+		 */
+		params->stack_pa = __pa(stack_page);
+
+		params->stack_hyp_va = hyp_addr + (2 * PAGE_SIZE);
 	}
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7de1e02ebfd1..088e14eae4cf 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -258,8 +258,8 @@ static bool kvm_host_owns_hyp_mappings(void)
 	return true;
 }
 
-static int __create_hyp_mappings(unsigned long start, unsigned long size,
-				 unsigned long phys, enum kvm_pgtable_prot prot)
+int __create_hyp_mappings(unsigned long start, unsigned long size,
+			  unsigned long phys, enum kvm_pgtable_prot prot)
 {
 	int err;
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

