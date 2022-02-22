Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE794C0019
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiBVR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiBVR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:27:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF48EB7F;
        Tue, 22 Feb 2022 09:26:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52778B81B83;
        Tue, 22 Feb 2022 17:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D42C340E8;
        Tue, 22 Feb 2022 17:26:38 +0000 (UTC)
Date:   Tue, 22 Feb 2022 17:26:35 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Message-ID: <YhUcywqIhmHvX6dG@arm.com>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com>
 <YhPUuu+6TPMKjhwk@arm.com>
 <20220222142557.6oykxjz3j7fq4mrn@revolver>
 <20220222162016.GA16436@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222162016.GA16436@willie-the-truck>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:20:16PM +0000, Will Deacon wrote:
> On Tue, Feb 22, 2022 at 02:26:03PM +0000, Liam Howlett wrote:
> > * Catalin Marinas <catalin.marinas@arm.com> [220221 13:07]:
> > > On Fri, Feb 18, 2022 at 02:37:04AM +0000, Liam Howlett wrote:
> > > > diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
> > > > index 3455ee4acc04..930a0bc4cac4 100644
> > > > --- a/arch/arm64/kernel/elfcore.c
> > > > +++ b/arch/arm64/kernel/elfcore.c
> > > > @@ -8,9 +8,9 @@
> > > >  #include <asm/cpufeature.h>
> > > >  #include <asm/mte.h>
> > > >  
> > > > -#define for_each_mte_vma(tsk, vma)					\
> > > > +#define for_each_mte_vma(vmi, vma)					\
> > > >  	if (system_supports_mte())					\
> > > > -		for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)	\
> > > > +		for_each_vma(vmi, vma)					\
> > > >  			if (vma->vm_flags & VM_MTE)
> > > >  
> > > >  static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
> > > > @@ -65,8 +65,9 @@ Elf_Half elf_core_extra_phdrs(void)
> > > >  {
> > > >  	struct vm_area_struct *vma;
> > > >  	int vma_count = 0;
> > > > +	VMA_ITERATOR(vmi, current->mm, 0);
> > > >  
> > > > -	for_each_mte_vma(current, vma)
> > > > +	for_each_mte_vma(vmi, vma)
> > > >  		vma_count++;
> > > 
> > > I'm fine with the patch but it can't be applied to arm64 for-next/mte
> > > branch as it won't build and the maple tree doesn't have the MTE
> > > patches. Do you have a stable branch with the for_each_vma() iterator?
> > 
> > The vma iterator uses the maple tree, so this patch would resolve the
> > conflict but both branches are needed.
> 
> I'm not really sure what to do here, then. I think the conflict is nasty
> enough that we should resolve it before the trees reach Linus, but there
> doesn't seem to be a way forward other than one of us merging the other
> branch. I'd like to avoid having MTE coredump support depend on the maple
> tree work.
> 
> Is there some way you could provide a branch which implements
> for_each_vma() using the old vma list, and then the maple tree series
> could switch that over to the maple tree without breaking things?

Without a branch, we could apply something like below on top of Liam's
patch and revert it once the maple tree is upstream:

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 930a0bc4cac4..400ec7a902df 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -8,6 +8,13 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>

+#ifndef VMA_ITERATOR
+#define VMA_ITERATOR(name, mm, addr) \
+	struct mm_struct *name = mm
+#define for_each_vma(vmi, vma) \
+	for (vma = vmi->mmap; vma; vma = vma->vm_next)
+#endif
+
 #define for_each_mte_vma(vmi, vma)					\
 	if (system_supports_mte())					\
 		for_each_vma(vmi, vma)					\

-- 
Catalin
