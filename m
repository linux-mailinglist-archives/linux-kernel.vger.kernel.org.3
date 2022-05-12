Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47539525563
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357896AbiELTKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiELTKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A3274A29;
        Thu, 12 May 2022 12:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D7ADB8290E;
        Thu, 12 May 2022 19:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2972C385B8;
        Thu, 12 May 2022 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652382630;
        bh=cnAMAMi9fYJo3US7em6lDWG28E0G0iYdwQhQjunOp9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FnbPoU5nJ4fEo9AA3m5+U8zpLvDz2nxndZrtvgFI58X61AqiSUnnPn5yHypcsW635
         o3iahGjneTuN3CgOqOYzep8qwU7DtC9zz/h25TCV4v3ebR97M//kpIQTK5eNucWfAf
         iyMNWVicBC3FH7DznyHN+2KylEpp4tqPU37GNauk=
Date:   Thu, 12 May 2022 12:10:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-Id: <20220512121029.8157e99756b3172e85ccb474@linux-foundation.org>
In-Reply-To: <Yn0LctZl8dTsezFu@arm.com>
References: <20220512193855.4f6ce32f@canb.auug.org.au>
        <YnzqffV7STYS24Yn@arm.com>
        <188f7cb2-ba21-a53a-828d-7242b17b0c72@linux.alibaba.com>
        <Yn0LctZl8dTsezFu@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 14:28:18 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> > > -	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> > > +	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> > > +	flush_tlb_range(vma, addr, addr + pgsize * ncontig);
> > > +	return orig_pte;
> > >   }
> > 
> > Yes, after checking this fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from
> > get_clear_flush()"), I also realized it will miss TLB flush.
> > 
> > So I am not sure I need send a incremental patch to fix this issue? Or
> > resend my patch set [1] with rebasing on the arm64 changes?
> > 
> > Catalin and Andrew, how do you think? Thanks.
> 
> Andrew folding the diff in is fine by me. I presume the mm patches are
> applied on top of the rest of linux-next (and the arm64 commits).

No, the mm patches are based on
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm master branch,
which is -rc4 or thereabouts.

So one of us needs to ensure that Linus gets that patch after the
second of us merges up.  I can't test it so I nominate you ;) Against
linux-next or the mm-everything branch at
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm?

