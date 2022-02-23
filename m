Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F1E4C0F52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiBWJjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiBWJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:39:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5725A5AE;
        Wed, 23 Feb 2022 01:39:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18568616CA;
        Wed, 23 Feb 2022 09:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2C2C340E7;
        Wed, 23 Feb 2022 09:39:21 +0000 (UTC)
Date:   Wed, 23 Feb 2022 09:39:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Message-ID: <YhYAxb85oDSYJyw0@arm.com>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com>
 <YhPUuu+6TPMKjhwk@arm.com>
 <20220222142557.6oykxjz3j7fq4mrn@revolver>
 <20220222162016.GA16436@willie-the-truck>
 <YhUcywqIhmHvX6dG@arm.com>
 <20220222185401.jntcd4g62pamfxvr@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222185401.jntcd4g62pamfxvr@revolver>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 06:54:38PM +0000, Liam Howlett wrote:
> * Catalin Marinas <catalin.marinas@arm.com> [220222 12:26]:
> > On Tue, Feb 22, 2022 at 04:20:16PM +0000, Will Deacon wrote:
> > > On Tue, Feb 22, 2022 at 02:26:03PM +0000, Liam Howlett wrote:
> > > > The vma iterator uses the maple tree, so this patch would resolve the
> > > > conflict but both branches are needed.
> > > 
> > > I'm not really sure what to do here, then. I think the conflict is nasty
> > > enough that we should resolve it before the trees reach Linus, but there
> > > doesn't seem to be a way forward other than one of us merging the other
> > > branch. I'd like to avoid having MTE coredump support depend on the maple
> > > tree work.
> > > 
> > > Is there some way you could provide a branch which implements
> > > for_each_vma() using the old vma list, and then the maple tree series
> > > could switch that over to the maple tree without breaking things?
> > 
> > Without a branch, we could apply something like below on top of Liam's
> > patch and revert it once the maple tree is upstream:
> > 
> > diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
> > index 930a0bc4cac4..400ec7a902df 100644
> > --- a/arch/arm64/kernel/elfcore.c
> > +++ b/arch/arm64/kernel/elfcore.c
> > @@ -8,6 +8,13 @@
> >  #include <asm/cpufeature.h>
> >  #include <asm/mte.h>
> > 
> > +#ifndef VMA_ITERATOR
> > +#define VMA_ITERATOR(name, mm, addr) \
> > +	struct mm_struct *name = mm
> > +#define for_each_vma(vmi, vma) \
> > +	for (vma = vmi->mmap; vma; vma = vma->vm_next)
> > +#endif
> > +
> >  #define for_each_mte_vma(vmi, vma)					\
> >  	if (system_supports_mte())					\
> >  		for_each_vma(vmi, vma)					\
> 
> Note that the current VMA_ITERATOR takes a new type and not the mm.

Well, in you proposed fix, it does take current->mm.

> Since I am removing the linked list (mm->mmap and vma->vm_next), then
> the build will fail if this patch and the maple tree branch exist
> together.  The iterator may also not start at the start of the list (but
> usually does) and may not run through the entire list; see
> vma_for_each_range() in the patch set.

My hack above is only temporary to allow building the arm64 tree on its
own (no maple tree branch) and with your patch on top. In -next, when
merged with the maple tree branch, the VMA_ITERATOR macro is already
defined and the above hack skipped. We'll revert this hack around -rc1.

Note that the hack above is only in the arm64 elfcore.c, not a generic
API solution.

-- 
Catalin
