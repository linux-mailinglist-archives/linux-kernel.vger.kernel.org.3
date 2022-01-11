Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8348AF54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiAKOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbiAKOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:19:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913CEC06173F;
        Tue, 11 Jan 2022 06:19:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50080B818B8;
        Tue, 11 Jan 2022 14:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3E2C36AED;
        Tue, 11 Jan 2022 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641910750;
        bh=YGpfU0T5TMVEAJUhIJ8qeHRWWlDJCyc9jmkWB12IIak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wo/bVdHRsgJTO46ku6p0Mh9xzxMddcZv7cdpKApShHXpJm/FU6GA7N0GAlvQeLI+q
         S5UX1kJoeLLETSEGeeKnPmhhaOks4Q9RND1hwPjZxNCAsibfzcwHLV/yFLeLICpAIg
         klsV/vxNmTEFqubIXgSYe96z10DLF+YQE4+3zvfj1MMTFyrVzGHMPwJi7eQ50AaKlz
         HrnMxheWkyq9EwMHWDKuGrq7UXZ/y4HPqfOBih8d608GocPGeJbpeEHA9COf0p1+iJ
         APiZW7088zymHOg5SS453dGCrGAEsxRDsvCyJIHBkpWGnxgEVDxTkYpLmpPA/wLZuR
         u9AolW9m6v0lg==
Date:   Tue, 11 Jan 2022 14:19:02 +0000
From:   Will Deacon <will@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 1/9] mm: x86, arm64: add arch_has_hw_pte_young()
Message-ID: <20220111141901.GA10338@willie-the-truck>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-2-yuzhao@google.com>
 <20220105104526.GA3015@willie-the-truck>
 <YdYDzKvYbBwjfU3W@google.com>
 <20220106103009.GA4420@willie-the-truck>
 <Ydfq051mnCeZjG3G@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydfq051mnCeZjG3G@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 12:25:07AM -0700, Yu Zhao wrote:
> On Thu, Jan 06, 2022 at 10:30:09AM +0000, Will Deacon wrote:
> > On Wed, Jan 05, 2022 at 01:47:08PM -0700, Yu Zhao wrote:
> > > On Wed, Jan 05, 2022 at 10:45:26AM +0000, Will Deacon wrote:
> > > > On Tue, Jan 04, 2022 at 01:22:20PM -0700, Yu Zhao wrote:
> > > > > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > > > > index 870c39537dd0..56e4ef5d95fa 100644
> > > > > --- a/arch/arm64/tools/cpucaps
> > > > > +++ b/arch/arm64/tools/cpucaps
> > > > > @@ -36,6 +36,7 @@ HAS_STAGE2_FWB
> > > > >  HAS_SYSREG_GIC_CPUIF
> > > > >  HAS_TLB_RANGE
> > > > >  HAS_VIRT_HOST_EXTN
> > > > > +HW_AF
> > > > >  HW_DBM
> > > > >  KVM_PROTECTED_MODE
> > > > >  MISMATCHED_CACHE_TYPE
> > > > 
> > > > As discussed in the previous threads, we really don't need the complexity
> > > > of the additional cap for the arm64 part. Please can you just use the
> > > > existing code instead? It's both simpler and, as you say, it's equivalent
> > > > for existing hardware.
> > > > 
> > > > That way, this patch just ends up being a renaming exercise and we're all
> > > > good.
> > > 
> > > No, renaming alone isn't enough. A caller needs to disable preemption
> > > before calling system_has_hw_af(), and I don't think it's reasonable
> > > to ask this caller to do it on x86 as well.
> > > 
> > > It seems you really prefer not to have HW_AF. So the best I can
> > > accommodate, considering other potential archs, e.g., risc-v (I do
> > > plan to provide benchmark results on risc-v, btw), is:
> > > 
> > >   static inline bool arch_has_hw_pte_young(bool local)
> > >   {
> > > 	bool hw_af;
> > > 
> > >   	if (local) {
> > >   		WARN_ON(preemptible());
> > >   		return cpu_has_hw_af();
> > >   	}
> > >   
> > > 	preempt_disable();
> > >   	hw_af = system_has_hw_af();
> > > 	preempt_enable();
> > > 
> > > 	return hw_af;
> > >   }
> > > 
> > > Or please give me something else I can call without disabling
> > > preemption, sounds good?
> > 
> > Sure thing, let me take a look. Do you have your series on a public git
> > tree someplace?
> 
> Thanks!
> 
> This patch (updated) on Gerrit:
> https://linux-mm-review.googlesource.com/c/page-reclaim/+/1500/1

How about folding in something like the diff below? I've basically removed
that 'bool local' argument and dropped the preemptible() check from the
arm64 code.

Will

--->8

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 280123916fc2..990358eca359 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -998,27 +998,14 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
  * the pte is old and cannot be marked young. So we always end up with zeroed
  * page after fork() + CoW for pfn mappings. We don't always have a
  * hardware-managed access flag on arm64.
- *
- * The system-wide support isn't used when involving correctness and therefore
- * is allowed to be flaky.
  */
-static inline bool arch_has_hw_pte_young(bool local)
-{
-	WARN_ON(local && preemptible());
-
-	return cpu_has_hw_af();
-}
-#define arch_has_hw_pte_young		arch_has_hw_pte_young
+#define arch_has_hw_pte_young		cpu_has_hw_af
 
 /*
  * Experimentally, it's cheap to set the access flag in hardware and we
  * benefit from prefaulting mappings as 'old' to start with.
  */
-static inline bool arch_wants_old_prefaulted_pte(void)
-{
-	return arch_has_hw_pte_young(true);
-}
-#define arch_wants_old_prefaulted_pte	arch_wants_old_prefaulted_pte
+#define arch_wants_old_prefaulted_pte	cpu_has_hw_af
 
 static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
 {
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index c60b16f8b741..3908780fc408 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1398,7 +1398,7 @@ static inline bool arch_has_pfn_modify_check(void)
 }
 
 #define arch_has_hw_pte_young arch_has_hw_pte_young
-static inline bool arch_has_hw_pte_young(bool local)
+static inline bool arch_has_hw_pte_young(void)
 {
 	return true;
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 599cc232d5c4..0bd1beadb545 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -260,15 +260,12 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 
 #ifndef arch_has_hw_pte_young
 /*
- * Return whether the accessed bit is supported by the local CPU or system-wide.
+ * Return whether the accessed bit is supported by the local CPU.
  *
- * This stub assumes accessing thru an old PTE triggers a page fault.
+ * This stub assumes accessing through an old PTE triggers a page fault.
  * Architectures that automatically set the access bit should overwrite it.
- *
- * Note that the system-wide support can be flaky and therefore shouldn't be
- * used when involving correctness.
  */
-static inline bool arch_has_hw_pte_young(bool local)
+static inline bool arch_has_hw_pte_young(void)
 {
 	return false;
 }
diff --git a/mm/memory.c b/mm/memory.c
index ead6c7d4b9a1..1f02de6d51e4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2743,7 +2743,7 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	 * On architectures with software "accessed" bits, we would
 	 * take a double page fault, so mark it accessed here.
 	 */
-	if (!arch_has_hw_pte_young(true) && !pte_young(vmf->orig_pte)) {
+	if (!arch_has_hw_pte_young() && !pte_young(vmf->orig_pte)) {
 		pte_t entry;
 
 		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
