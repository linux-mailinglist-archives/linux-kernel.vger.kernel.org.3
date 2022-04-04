Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144264F205B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiDDXoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiDDXow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:44:52 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4A969CEB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:42:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q13-20020a638c4d000000b003821725ad66so6328647pgn.23
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iUBYYnkU7CJchuxR3lOvqoVPphRBCh0qszifS0z2hb0=;
        b=Th3RchuViiwMrL8xEdUyolWaFP9EHSqtrabMVLsluz6Av0uhtq0l+VPtlLLz3wm8/F
         R/FvuzzEQBfvNteCCxMg5ChL99EycnrtbVDuzFwhO/N9ywIXjaALM7iS2czWfkUwCQPc
         VnSh+Ou3eJmBmHVIzcBbbSNO4q/sDfJ4m9f4yCJ78hDQMANblW8yG3ZzlUKxk1zngy7x
         OC6JlSI/+wrVKGsU7vn/X0JFA+RTNtP5XZ03RyrkX9CHOI93tk/ukhW1dEv1u958SGoZ
         XIVNqQqYPyZNWupqD5UFI2OeMGaSCgod0Eh41gbF6IOaN5+iePHefJrADl+kn4qXBzlZ
         SCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iUBYYnkU7CJchuxR3lOvqoVPphRBCh0qszifS0z2hb0=;
        b=awfCqYG6VxUfUfjaChOlPh5HelKq83yJh14bVry40xWYzaKJ2lliR0+rAv9WqEpBim
         TUUlbQpmBn5PnQAVyjSvzcnsIiMwB5i4UaAxjDQ3xc04RO753uJfqngny4PyxEzIMdyd
         kKyzmmoxjAF+qzHSMK9D9LyFv5o4LEg0JClyd5e2cl8uk5xEfqABdXwoqF4MdEh6x1Q9
         YdUk4lsNsdUQe+3vyrdZSsTUnH5KP4AExXezLqJi58yyeYixJq9doOOnBUEuFhM/yefX
         4Teyn3Il8RmrOgtUGuXPWyW37wPpOyGC2OTOPnw+WtZv93kGGXOGIpjqp8y15x6aOY2A
         E7jw==
X-Gm-Message-State: AOAM532wbtMq67F6QZBKYGdC/VKAPpvGb7bDGJth2/8H1kOLeHULTID5
        NOSKJJ2QJylSxaE98oJ2tsIvQcykOtDgTLsR
X-Google-Smtp-Source: ABdhPJymGpqpZQotLwNvi6g82KDcXAiQqYHQzWEZeJFKQrAz7QzxfdlcOk5WyldaIY67+U8rZh3KFnCR84iDU0dQ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:db48:b0:1ca:ab67:d75 with SMTP
 id u8-20020a17090adb4800b001caab670d75mr73985pjx.1.1649115729756; Mon, 04 Apr
 2022 16:42:09 -0700 (PDT)
Date:   Mon,  4 Apr 2022 23:41:53 +0000
In-Reply-To: <20220404234154.1251388-1-yosryahmed@google.com>
Message-Id: <20220404234154.1251388-5-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220404234154.1251388-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2 4/5] KVM: riscv: mm: count KVM page table pages in
 pagetable stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     mizhang@google.com, David Matlack <dmatlack@google.com>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Count the pages used by KVM in riscv for page tables in pagetable stats.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/riscv/kvm/mmu.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index f80a34fbf102..fcfb75713750 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -152,6 +152,7 @@ static int stage2_set_pte(struct kvm *kvm, u32 level,
 			next_ptep = kvm_mmu_memory_cache_alloc(pcache);
 			if (!next_ptep)
 				return -ENOMEM;
+			kvm_account_pgtable_pages((void *)next_ptep, +1);
 			*ptep = pfn_pte(PFN_DOWN(__pa(next_ptep)),
 					__pgprot(_PAGE_TABLE));
 		} else {
@@ -229,6 +230,7 @@ static void stage2_op_pte(struct kvm *kvm, gpa_t addr,
 	pte_t *next_ptep;
 	u32 next_ptep_level;
 	unsigned long next_page_size, page_size;
+	struct page *p;
 
 	ret = stage2_level_to_page_size(ptep_level, &page_size);
 	if (ret)
@@ -252,8 +254,13 @@ static void stage2_op_pte(struct kvm *kvm, gpa_t addr,
 		for (i = 0; i < PTRS_PER_PTE; i++)
 			stage2_op_pte(kvm, addr + i * next_page_size,
 					&next_ptep[i], next_ptep_level, op);
-		if (op == STAGE2_OP_CLEAR)
-			put_page(virt_to_page(next_ptep));
+		if (op == STAGE2_OP_CLEAR) {
+			p = virt_to_page(next_ptep);
+			if (page_count(p) == 1)
+				kvm_account_pgtable_pages((void *)next_ptep,
+							  -1);
+			put_page(p);
+		}
 	} else {
 		if (op == STAGE2_OP_CLEAR)
 			set_pte(ptep, __pte(0));
@@ -700,25 +707,27 @@ int kvm_riscv_stage2_map(struct kvm_vcpu *vcpu,
 int kvm_riscv_stage2_alloc_pgd(struct kvm *kvm)
 {
 	struct page *pgd_page;
+	int order;
 
 	if (kvm->arch.pgd != NULL) {
 		kvm_err("kvm_arch already initialized?\n");
 		return -EINVAL;
 	}
 
-	pgd_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
-				get_order(stage2_pgd_size));
+	order = get_order(stage2_pgd_size);
+	pgd_page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
 	if (!pgd_page)
 		return -ENOMEM;
 	kvm->arch.pgd = page_to_virt(pgd_page);
 	kvm->arch.pgd_phys = page_to_phys(pgd_page);
-
+	kvm_account_pgtable_pages((void *)kvm->arch.pgd, +(1UL << order));
 	return 0;
 }
 
 void kvm_riscv_stage2_free_pgd(struct kvm *kvm)
 {
 	void *pgd = NULL;
+	int order;
 
 	spin_lock(&kvm->mmu_lock);
 	if (kvm->arch.pgd) {
@@ -729,8 +738,11 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm)
 	}
 	spin_unlock(&kvm->mmu_lock);
 
-	if (pgd)
-		free_pages((unsigned long)pgd, get_order(stage2_pgd_size));
+	if (pgd) {
+		order = get_order(stage2_pgd_size);
+		kvm_account_pgtable_pages((void *)pgd, -(1UL << order));
+		free_pages((unsigned long)pgd, order);
+	}
 }
 
 void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu)
-- 
2.35.1.1094.g7c7d902a7c-goog

