Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970B04A695A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiBBAuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243564AbiBBAuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:50:04 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192E7C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:50:04 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id t69-20020a627848000000b004cb24c27d5aso9867474pfc.21
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=LW0CGWCdKGNybf5BvgByl5slEYTpalX7lGLuyFTmzzE=;
        b=KF/N+QYr4iO95cCpL1G4uzy3+ivkEMfpIpF7KmjMsjT6UFuAiLOkDkuFPC+4P2sUlY
         ihpRqaIjOz4kN6/89V2YCtvtnEp6CgO2lgyYbLPfV92eWmU/hBojGwPjCs3FwKyZsXrX
         yuoY9faMjNWzQpgzPtwNASEsZCoeIVq40P6nCQwX4KrJmIivrRIFkVMNC4gBhgu7QdQK
         nzJ5R1NlpEyjMBzZKMCYYmm8a4J05RK4Y1u2dvI4M0nezvomCbEtKSi+IA/jtC0k80d9
         fXLvxpGVAcj1/8GzA0YN4YJezqs8Fe3DTGszxuuV5bau90Ty1COT15DCtwmt2tWIfHVv
         EWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=LW0CGWCdKGNybf5BvgByl5slEYTpalX7lGLuyFTmzzE=;
        b=ggVbW38rdwooX2rBaAhq9/zgv9dvwuPk59R9mTTRMvBdMp/mQLmfYOn4GkU6/nKtjm
         jyaFeIlRWMCsMMS+3mdgHXvg1/xQrrkV6y2CIdFYTiJDPVUgu4JLCYQ+8u5xha7EjE9q
         S0zuCS9UApJU7cd/jhy4Pz+O8Fd6U+IErf97hsF+i0hPXoUJrcR4ULb5a8g/6uFPwe3Y
         tTDAeTdP4Bx2XDzHvcZ6ArV565aMGYjbK2coPBohw7Mljxz0ci+Ulsx8zGfWo7G45xMi
         fyBHhVNNyH8tl/RC9ILsHFCYtjkmbK+f7Emn7fYUoWJOY7aFQRL6yPv9cYQVcKyA5XNz
         rdfA==
X-Gm-Message-State: AOAM532A0mtlBYVP2iCbiZn16CG3c/253kMKx3MpBuSy5ytpPLjsStNe
        qGWH+mAq1zhZhPjWgKLXvzhdC4fGOHU=
X-Google-Smtp-Source: ABdhPJz2wdcFwYzdK82hva9pUCt+iTHlqo2myaKtJAqY+WJziu6dFA2uGVEY5NWktaR6JfhrV1Ro8gjVAm8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2cf:: with SMTP id
 b15mr13593957pft.0.1643763003513; Tue, 01 Feb 2022 16:50:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Feb 2022 00:49:43 +0000
In-Reply-To: <20220202004945.2540433-1-seanjc@google.com>
Message-Id: <20220202004945.2540433-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220202004945.2540433-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 3/5] KVM: x86: Use __try_cmpxchg_user() to update guest PTE
 A/D bits
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        syzbot+6cde2282daa792c49ab8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the recently introduced __try_cmpxchg_user() to update guest PTE A/D
bits instead of mapping the PTE into kernel address space.  The VM_PFNMAP
path is broken as it assumes that vm_pgoff is the base pfn of the mapped
VMA range, which is conceptually wrong as vm_pgoff is the offset relative
to the file and has nothing to do with the pfn.  The horrific hack worked
for the original use case (backing guest memory with /dev/mem), but leads
to accessing "random" pfns for pretty much any other VM_PFNMAP case.

Fixes: bd53cb35a3e9 ("X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs")
Debugged-by: Tadeusz Struk <tadeusz.struk@linaro.org>
Tested-by: Tadeusz Struk <tadeusz.struk@linaro.org>
Reported-by: syzbot+6cde2282daa792c49ab8@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 45 +---------------------------------
 1 file changed, 1 insertion(+), 44 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 5b5bdac97c7b..551de15f342f 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -143,49 +143,6 @@ static bool FNAME(is_rsvd_bits_set)(struct kvm_mmu *mmu, u64 gpte, int level)
 	       FNAME(is_bad_mt_xwr)(&mmu->guest_rsvd_check, gpte);
 }
 
-static int FNAME(cmpxchg_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			       pt_element_t __user *ptep_user, unsigned index,
-			       pt_element_t orig_pte, pt_element_t new_pte)
-{
-	int npages;
-	pt_element_t ret;
-	pt_element_t *table;
-	struct page *page;
-
-	npages = get_user_pages_fast((unsigned long)ptep_user, 1, FOLL_WRITE, &page);
-	if (likely(npages == 1)) {
-		table = kmap_atomic(page);
-		ret = CMPXCHG(&table[index], orig_pte, new_pte);
-		kunmap_atomic(table);
-
-		kvm_release_page_dirty(page);
-	} else {
-		struct vm_area_struct *vma;
-		unsigned long vaddr = (unsigned long)ptep_user & PAGE_MASK;
-		unsigned long pfn;
-		unsigned long paddr;
-
-		mmap_read_lock(current->mm);
-		vma = find_vma_intersection(current->mm, vaddr, vaddr + PAGE_SIZE);
-		if (!vma || !(vma->vm_flags & VM_PFNMAP)) {
-			mmap_read_unlock(current->mm);
-			return -EFAULT;
-		}
-		pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
-		paddr = pfn << PAGE_SHIFT;
-		table = memremap(paddr, PAGE_SIZE, MEMREMAP_WB);
-		if (!table) {
-			mmap_read_unlock(current->mm);
-			return -EFAULT;
-		}
-		ret = CMPXCHG(&table[index], orig_pte, new_pte);
-		memunmap(table);
-		mmap_read_unlock(current->mm);
-	}
-
-	return (ret != orig_pte);
-}
-
 static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 				  struct kvm_mmu_page *sp, u64 *spte,
 				  u64 gpte)
@@ -284,7 +241,7 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 		if (unlikely(!walker->pte_writable[level - 1]))
 			continue;
 
-		ret = FNAME(cmpxchg_gpte)(vcpu, mmu, ptep_user, index, orig_pte, pte);
+		ret = __try_cmpxchg_user(ptep_user, &orig_pte, pte, fault);
 		if (ret)
 			return ret;
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

