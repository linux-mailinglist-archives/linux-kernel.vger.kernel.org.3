Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0CC4BFE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiBVQUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiBVQUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:20:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5132A166A5E;
        Tue, 22 Feb 2022 08:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF8E66174D;
        Tue, 22 Feb 2022 16:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D52C340E8;
        Tue, 22 Feb 2022 16:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645546821;
        bh=OLD5EfTmpMYiOEMJ3Q1Bnfs+3r7pcDmPmir3b5v+Jgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UXZKSJ6sdkdNBcq3biTSeDpciKeScfkVeChp0gjnPAoUU9REYgiOe9v5O0pzP7ZJs
         nRWhO1RSTtgiWBXoKi7yb5nyK4oUEbKZoQqata9cbxpHP4XYri4YtWMgbg7v/GFfSH
         TLr+uPe+faDrznLOQ5O8757i8dgCUEtQ0cxT4EXEpLmhhROzqncPdjOZlPUdD6GfZh
         9Lu5UeXdp64LClJYcTrSon5EF21ik1OxUQda58NN84czi3UiOOX6n5j6D5JLz0Bdds
         sV7ERxUZWd+NMrMIR1K6loVcGmofnVBif3svWjC6DQugjxfcyOAZq6ppuHpHtCYIeN
         /YTQ3cUyXLXOQ==
Date:   Tue, 22 Feb 2022 16:20:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Message-ID: <20220222162016.GA16436@willie-the-truck>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com>
 <YhPUuu+6TPMKjhwk@arm.com>
 <20220222142557.6oykxjz3j7fq4mrn@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222142557.6oykxjz3j7fq4mrn@revolver>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 02:26:03PM +0000, Liam Howlett wrote:
> * Catalin Marinas <catalin.marinas@arm.com> [220221 13:07]:
> > On Fri, Feb 18, 2022 at 02:37:04AM +0000, Liam Howlett wrote:
> > > diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
> > > index 3455ee4acc04..930a0bc4cac4 100644
> > > --- a/arch/arm64/kernel/elfcore.c
> > > +++ b/arch/arm64/kernel/elfcore.c
> > > @@ -8,9 +8,9 @@
> > >  #include <asm/cpufeature.h>
> > >  #include <asm/mte.h>
> > >  
> > > -#define for_each_mte_vma(tsk, vma)					\
> > > +#define for_each_mte_vma(vmi, vma)					\
> > >  	if (system_supports_mte())					\
> > > -		for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)	\
> > > +		for_each_vma(vmi, vma)					\
> > >  			if (vma->vm_flags & VM_MTE)
> > >  
> > >  static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
> > > @@ -65,8 +65,9 @@ Elf_Half elf_core_extra_phdrs(void)
> > >  {
> > >  	struct vm_area_struct *vma;
> > >  	int vma_count = 0;
> > > +	VMA_ITERATOR(vmi, current->mm, 0);
> > >  
> > > -	for_each_mte_vma(current, vma)
> > > +	for_each_mte_vma(vmi, vma)
> > >  		vma_count++;
> > 
> > I'm fine with the patch but it can't be applied to arm64 for-next/mte
> > branch as it won't build and the maple tree doesn't have the MTE
> > patches. Do you have a stable branch with the for_each_vma() iterator?
> 
> The vma iterator uses the maple tree, so this patch would resolve the
> conflict but both branches are needed.

I'm not really sure what to do here, then. I think the conflict is nasty
enough that we should resolve it before the trees reach Linus, but there
doesn't seem to be a way forward other than one of us merging the other
branch. I'd like to avoid having MTE coredump support depend on the maple
tree work.

Is there some way you could provide a branch which implements
for_each_vma() using the old vma list, and then the maple tree series
could switch that over to the maple tree without breaking things?

Will
