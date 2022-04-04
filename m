Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB04F2065
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiDDXpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiDDXpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:45:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4FE6B51C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:43:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mm2-20020a17090b358200b001bf529127dfso443824pjb.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K/C6C11bbKyaV99qw+OE+b8BddCrOUCezOjrhVsGtWE=;
        b=SJM89U7DX9auP5Efty5wonK9wAYJnkGwZ+yCUpzXGngk3AdkiPP/FlEeacVDxTcHzy
         HsBIy2xxwycYfRyIDstlwTVfWpbRJYYCwpohusdMYR6XvAw6QGZ7vLmaKM17K0i2hSog
         eBvgtw8dbSKzt8aCE+rdgLw8bBikRyPjPsyk/ObkMrCuLv7sJe9h0edppM+6naMxpp2Y
         NMpQ7n+Hw52XoL7s5gqA3PVjP9/EfodgNtCX/RvYg4nAWYrw3gDyUyRNHsnnJt3XidSC
         FlkEpXeWnfMVWX3IPZai5/ju+N7azTeX28p0knQDKXyRx0s4srdab1zZOf6j+YU0KEqV
         THPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K/C6C11bbKyaV99qw+OE+b8BddCrOUCezOjrhVsGtWE=;
        b=BJSYYT1AbTZOmFiIxpDdOLBi6I+IatvCOBXrZnRBD7GIBw2dtoC0lrzWQcfDFVc7tm
         sjJQ1n4Pc7sdlLpb5OJAFiSMXE5jbq8iR7DG4CKsMLliWf3qLFkd87fcsmrSOoUH9C3I
         K5d0n69qGR0VSlgSa/GN6pZwa44nPgdEBxHyETshqcFQXgPtmvooWCY6vYDizlgtvFmt
         UlZ1Mu/XQ3vux4TnBJI0WB7Px1+j93k55yFhRbaZAV23IkEGNliZGmyAWUNo+N3qNsXE
         SaEgM7C3jyp8VR4KIXVPVVo+Ycrfb8zGYf0GD8KIxx8vA/gbTwbwFEEcqDHqGsdfQG0G
         G96g==
X-Gm-Message-State: AOAM530WApIZbaF8qqFXBDwwwM6HQ8gfTS67IwhrwsmgBv6RjmpssR2P
        jnTNGkHR047hp/uDyOhIUZRM4YjyIXlJtctw
X-Google-Smtp-Source: ABdhPJzORRgTHWZDqgAJmEQ9S4nEbpi3R6OCs7d6aUuWSbmaM3HnKYNNIS5dFfWTXWVVd/6JvKSw7F30c/15SR2s
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:db48:b0:1ca:ab67:d75 with SMTP
 id u8-20020a17090adb4800b001caab670d75mr74003pjx.1.1649115732725; Mon, 04 Apr
 2022 16:42:12 -0700 (PDT)
Date:   Mon,  4 Apr 2022 23:41:54 +0000
In-Reply-To: <20220404234154.1251388-1-yosryahmed@google.com>
Message-Id: <20220404234154.1251388-6-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220404234154.1251388-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2 5/5] KVM: mips: mm: count KVM page table pages in pagetable stats
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

Count the pages used by KVM in mips for page tables in pagetable stats.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/mips/kvm/mips.c | 1 +
 arch/mips/kvm/mmu.c  | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a25e0b73ee70..e60c1920a408 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -175,6 +175,7 @@ static void kvm_mips_free_gpa_pt(struct kvm *kvm)
 {
 	/* It should always be safe to remove after flushing the whole range */
 	WARN_ON(!kvm_mips_flush_gpa_pt(kvm, 0, ~0));
+	kvm_account_pgtable_pages((void *)kvm->arch.gpa_mm.pgd, -1);
 	pgd_free(NULL, kvm->arch.gpa_mm.pgd);
 }
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 1bfd1b501d82..18da2ac2ded7 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -81,8 +81,10 @@ pgd_t *kvm_pgd_alloc(void)
 	pgd_t *ret;
 
 	ret = (pgd_t *)__get_free_pages(GFP_KERNEL, PGD_ORDER);
-	if (ret)
+	if (ret) {
 		kvm_pgd_init(ret);
+		kvm_account_pgtable_pages((void *)ret, +1);
+	}
 
 	return ret;
 }
@@ -125,6 +127,7 @@ static pte_t *kvm_mips_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
 		pmd_init((unsigned long)new_pmd,
 			 (unsigned long)invalid_pte_table);
 		pud_populate(NULL, pud, new_pmd);
+		kvm_account_pgtable_pages((void *)new_pmd, +1);
 	}
 	pmd = pmd_offset(pud, addr);
 	if (pmd_none(*pmd)) {
@@ -135,6 +138,7 @@ static pte_t *kvm_mips_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
 		new_pte = kvm_mmu_memory_cache_alloc(cache);
 		clear_page(new_pte);
 		pmd_populate_kernel(NULL, pmd, new_pte);
+		kvm_account_pgtable_pages((void *)new_pte, +1);
 	}
 	return pte_offset_kernel(pmd, addr);
 }
@@ -189,6 +193,7 @@ static bool kvm_mips_flush_gpa_pmd(pmd_t *pmd, unsigned long start_gpa,
 
 		if (kvm_mips_flush_gpa_pte(pte, start_gpa, end)) {
 			pmd_clear(pmd + i);
+			kvm_account_pgtable_pages((void *)pte, -1);
 			pte_free_kernel(NULL, pte);
 		} else {
 			safe_to_remove = false;
@@ -217,6 +222,7 @@ static bool kvm_mips_flush_gpa_pud(pud_t *pud, unsigned long start_gpa,
 
 		if (kvm_mips_flush_gpa_pmd(pmd, start_gpa, end)) {
 			pud_clear(pud + i);
+			kvm_account_pgtable_pages((void *)pmd, -1);
 			pmd_free(NULL, pmd);
 		} else {
 			safe_to_remove = false;
@@ -247,6 +253,7 @@ static bool kvm_mips_flush_gpa_pgd(pgd_t *pgd, unsigned long start_gpa,
 
 		if (kvm_mips_flush_gpa_pud(pud, start_gpa, end)) {
 			pgd_clear(pgd + i);
+			kvm_account_pgtable_pages((void *)pud, -1);
 			pud_free(NULL, pud);
 		} else {
 			safe_to_remove = false;
-- 
2.35.1.1094.g7c7d902a7c-goog

