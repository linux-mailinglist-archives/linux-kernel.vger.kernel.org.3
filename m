Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD8563708
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiGAPil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiGAPij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:38:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811893EA98
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656689917; x=1688225917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=85ODJKpSERbExoEc/k6o79OkH2WoiAkmweh7FH1gEWk=;
  b=dKABJT/liemsWw1B63CHvRz0aaXWkDaCtIA9dOiHYVMd0m86C/x4WgRm
   BCwe9ad2ITuNGYN1xUKap/z1TlMIFifRxYZ6j/prMS51M1CdXnWDvdndZ
   +FpbAJEQVEp4b6sFUEvAL9cbIooncbWEBX+ujouWhSuRYgJCD0CR9eBha
   vhGxvpFycH2z0/eI8jGB5EUfdTK8OND3JYTBIzBEP36WUyCQbwLRt3mui
   5GpwvZXCVfIXSj4n7Ql2jcA7vLIKOPY8fPlUAoFSb3gkWf3SK3vG6NUEU
   7DRewJnOvYnU11Rff4mnm23Whz/0uGpvRcl29EdvTIcrP4n9uHDXJiPF7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="263076714"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="263076714"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 08:38:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="734093863"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2022 08:38:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4A53CD9; Fri,  1 Jul 2022 18:38:40 +0300 (EEST)
Date:   Fri, 1 Jul 2022 18:38:40 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220701153840.7g55cazg73ukvr7l@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
 <6cb17661-9436-afbf-38eb-58565bba1a56@kernel.org>
 <20220629005342.3thjt26e6p6znyrh@black.fi.intel.com>
 <1d765bc0-279c-4fd3-91f4-e99e6aef203c@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d765bc0-279c-4fd3-91f4-e99e6aef203c@www.fastmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 07:29:13PM -0700, Andy Lutomirski wrote:
> 
> 
> On Tue, Jun 28, 2022, at 5:53 PM, Kirill A. Shutemov wrote:
> > On Tue, Jun 28, 2022 at 04:42:40PM -0700, Andy Lutomirski wrote:
> >> On 6/10/22 07:35, Kirill A. Shutemov wrote:
> >> 
> >> > +	/* Update CR3 to get LAM active */
> >> > +	switch_mm(current->mm, current->mm, current);
> >> 
> >> Can you at least justify this oddity?  When changing an LDT, we use a
> >> dedicated mechanism.  Is there a significant benefit to abusing switch_mm
> >> for this?
> >
> > I'm not sure I follow. LAM mode is set in CR3. switch_mm() has to handle
> > it anyway to context switch. Why do you consider it abuse?
> >
> >> 
> >> Also, why can't we enable LAM on a multithreaded process?  We can change an
> >> LDT, and the code isn't even particularly complicated.
> >
> > I reworked this in v4[1] and it allows multithreaded processes. Have you
> > got that version?
> >
> > Intel had issue with mail server, but I assumed it didn't affect my
> > patchset since I see it in the archive.
> >
> 
> I didn’t notice it. Not quite sure what the issue was. Could just be
> incompetence on my part.
> 
> I think that’s the right idea, except that I think you shouldn’t use
> switch_mm for this. Just update the LAM bits directly.   Once you read
> mm_cpumask, you should be guaranteed (see next paragraph) that, for each
> CPU that isn’t in the set, if it switches to the new mm, it will notice
> the new LAM.
> 
> I say “should be” because I think smp_wmb() is insufficient. You’re
> ordering a write with a subsequent read, which needs smp_mb().

I think it is better to put smp_mb() to make it explicit.

Does the fixup below look okay?

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 2d70d75e207f..8da54e7b6f98 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -367,4 +367,30 @@ static inline void __native_tlb_flush_global(unsigned long cr4)
 	native_write_cr4(cr4 ^ X86_CR4_PGE);
 	native_write_cr4(cr4);
 }
+
+#ifdef CONFIG_X86_64
+static inline u64 tlbstate_lam_cr3_mask(void)
+{
+	u64 lam = this_cpu_read(cpu_tlbstate.lam);
+
+	return lam << X86_CR3_LAM_U57_BIT;
+}
+
+static inline void set_tlbstate_lam_cr3_mask(u64 mask)
+{
+	this_cpu_write(cpu_tlbstate.lam, mask >> X86_CR3_LAM_U57_BIT);
+}
+
+#else
+
+static inline u64 tlbstate_lam_cr3_mask(void)
+{
+	return 0;
+}
+
+static inline void set_tlbstate_lam_cr3_mask(u64 mask)
+{
+}
+#endif
+
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 427ebef3f64b..cd2b03fe94c4 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -745,15 +745,16 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 static void enable_lam_func(void *mm)
 {
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	unsigned long lam_mask;
 
 	if (loaded_mm != mm)
 		return;
 
-	/* Counterpart of smp_wmb() in prctl_enable_tagged_addr() */
-	smp_rmb();
+	lam_mask = READ_ONCE(loaded_mm->context.lam_cr3_mask);
 
 	/* Update CR3 to get LAM active on the CPU */
-	switch_mm(loaded_mm, loaded_mm, current);
+	write_cr3(__read_cr3() | lam_mask);
+	set_tlbstate_lam_cr3_mask(lam_mask);
 }
 
 static bool lam_u48_allowed(void)
@@ -805,7 +806,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	}
 
 	/* Make lam_cr3_mask and untag_mask visible on other CPUs */
-	smp_wmb();
+	smp_mb();
 
 	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
 out:
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c5c4f76329c2..d9a2acdae90f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -486,31 +486,6 @@ void cr4_update_pce(void *ignored)
 static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
 #endif
 
-#ifdef CONFIG_X86_64
-static inline u64 tlbstate_lam_cr3_mask(void)
-{
-	u64 lam = this_cpu_read(cpu_tlbstate.lam);
-
-	return lam << X86_CR3_LAM_U57_BIT;
-}
-
-static inline void set_tlbstate_lam_cr3_mask(u64 mask)
-{
-	this_cpu_write(cpu_tlbstate.lam, mask >> X86_CR3_LAM_U57_BIT);
-}
-
-#else
-
-static inline u64 tlbstate_lam_cr3_mask(void)
-{
-	return 0;
-}
-
-static inline void set_tlbstate_lam_cr3_mask(u64 mask)
-{
-}
-#endif
-
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -581,7 +556,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * provides that full memory barrier and core serializing
 	 * instruction.
 	 */
-	if (real_prev == next && prev_lam == new_lam) {
+	if (real_prev == next) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
-- 
 Kirill A. Shutemov
