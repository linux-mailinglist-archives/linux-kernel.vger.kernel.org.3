Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09983591BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbiHMQFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbiHMQFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:05:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAEFD10F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 09:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 082A0B80916
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 16:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04721C433C1;
        Sat, 13 Aug 2022 16:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406742;
        bh=4J42o8wzYgxh688G1hCQTDBxBmpRo7DCqxyEvYQsMKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxA/z4nk2WIvM4oapN2esQkxdftt7fFkLIkWpDqOBI/yVQm0WQASGNbXrbL0E3jNp
         XmzCxsJ/ZFzkxSfO7x4VXzfSLUHJ38ZWkU84yJcSf7mvhhZImPtfC983YsjhJYwF3x
         8hZKijx8Il2fDL29dcsqti05BaalGpU6G4+Q7OueByKpGKqJViCA3cynHGpdmNCvsL
         cG6Uba59DtdJtwbjO6eCWy/FCsSsyfPOR7OpRF1hTcx4mvvsq1T+M8IHHxHYYEooDZ
         gHCx2UHwZ4+ciRCvKqOerQPyN9CDNVMYi/eX2utpGMaSpnfIOdWCgZjSqmYobG1OW6
         wmcZOAkBDGehw==
Date:   Sat, 13 Aug 2022 19:05:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Aaron Lu <aaron.lu@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] x86/mm/cpa: merge small mappings whenever
 possible
Message-ID: <YvfLxuflw2ctHFWF@kernel.org>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
 <YvSKpCWhAz+2Y220@ip-172-31-24-42.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvSKpCWhAz+2Y220@ip-172-31-24-42.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On Thu, Aug 11, 2022 at 04:50:44AM +0000, Hyeonggon Yoo wrote:
> On Mon, Aug 08, 2022 at 10:56:45PM +0800, Aaron Lu wrote:
> > This is an early RFC. While all reviews are welcome, reviewing this code
> > now will be a waste of time for the x86 subsystem maintainers. I would,
> > however, appreciate a preliminary review from the folks on the to and cc
> > list. I'm posting it to the list in case anyone else is interested in
> > seeing this early version.
> > 
> 
> Hello Aaron!
> 
> +Cc Mike Rapoport, who has been same problem. [1]

Thanks Hyeonggon!
 
> There is also LPC discussion (with different approach on this problem)
> [2], [4]
> 
> and performance measurement when all pages are 4K/2M. [3]
> 
> [1] https://lore.kernel.org/linux-mm/20220127085608.306306-1-rppt@kernel.org/
> [2] https://www.youtube.com/watch?v=egC7ZK4pcnQ
> [3] https://lpc.events/event/11/contributions/1127/attachments/922/1792/LPC21%20Direct%20map%20management%20.pdf
> [4] https://lwn.net/Articles/894557/
> 
> > Dave Hansen: I need your ack before this goes to the maintainers.
> > 
> > Here it goes:
> > 
> > On x86_64, Linux has direct mapping of almost all physical memory. For
> > performance reasons, this mapping is usually set as large page like 2M
> > or 1G per hardware's capability with read, write and non-execute
> > protection.
> > 
> > There are cases where some pages have to change their protection to RO
> > and eXecutable, like pages that host module code or bpf prog. When these
> > pages' protection are changed, the corresponding large mapping that
> > cover these pages will have to be splitted into 4K first and then
> > individual 4k page's protection changed accordingly, i.e. unaffected
> > pages keep their original protection as RW and NX while affected pages'
> > protection changed to RO and X.
> > 
> > There is a problem due to this split: the large mapping will remain
> > splitted even after the affected pages' protection are changed back to
> > RW and NX, like when the module is unloaded or bpf progs are freed.
> > After system runs a long time, there can be more and more large mapping
> > being splitted, causing more and more dTLB misses and overall system
> > performance getting hurt[1].
> > 
> > For this reason, people tried some techniques to reduce the harm of
> > large mapping beling splitted, like bpf_prog_pack[2] which packs
> > multiple bpf progs into a single page instead of allocating and changing
> > one page's protection for each bpf prog. This approach made large
> > mapping split happen much fewer.
> > 
> > This patchset addresses this problem in another way: it merges
> > splitted mappings back to a large mapping when protections of all entries
> > of the splitted small mapping page table become same again, e.g. when the
> > page whose protection was changed to RO+X now has its protection changed
> > back to RW+NX due to reasons like module unload, bpf prog free, etc. and
> > all other entries' protection are also RW+NX.
> >
> 
> I tried very similar approach few months ago (for toy implementation) [5],
> and the biggest obstacle to this approach was: you need to be extremely sure
> that the page->nr_same_prot is ALWAYS correct.
> 
> For example, in arch/x86/include/asm/kfence.h [6], it clears and set
> _PAGE_PRESENT without going through CPA, which can simply break the count.
> 
> [5] https://github.com/hygoni/linux/tree/merge-mapping-v1r3
> [6] https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/kfence.h#L56
> 
> I think we may need to hook set_pte/set_pmd/etc and use proper
> synchronization primitives when changing init_mm's page table to go
> further on this approach.
> 
> > One final note is, with features like bpf_prog_pack etc., there can be
> > much fewer large mapping split IIUC; also, this patchset can not help
> > when the page which has its protection changed keeps in use. So my take
> > on this large mapping split problem is: to get the most value of keeping
> > large mapping intact, features like bpf_prog_pack is important. This
> > patchset can help to further reduce large mapping split when in use page
> > that has special protection set finally gets released.

I'm not sure automatic collapse of large pages in the direct map will
actually trigger frequently. 

Consider for example pages allocated for modules, that have adjusted
protection bits. This pages could be scattered all over and even when they
are freed, chances there will be a contiguous 2M chunk are quite low...

I believe that to reduce the fragmentation of the direct map the 4K pages
with changed protection should be allocated from a cache of large pages, as
I did on older version of secretmem or as Rick implemented in his vmalloc
and PKS series.

Then CPA may provide a method for explicitly collapsing a large page, so
that such cache can call this method when an entire large page becomes
free.

> > [1]: http://lkml.kernel.org/r/CAPhsuW4eAm9QrAxhZMJu-bmvHnjWjuw86gFZzTHRaMEaeFhAxw@mail.gmail.com
> > [2]: https://lore.kernel.org/lkml/20220204185742.271030-1-song@kernel.org/
> > 
> > Aaron Lu (4):
> >   x86/mm/cpa: restore global bit when page is present
> >   x86/mm/cpa: merge splitted direct mapping when possible
> >   x86/mm/cpa: add merge event counter
> >   x86/mm/cpa: add a test interface to split direct map
> > 
> >  arch/x86/mm/pat/set_memory.c  | 411 +++++++++++++++++++++++++++++++++-
> >  include/linux/mm_types.h      |   6 +
> >  include/linux/page-flags.h    |   6 +
> >  include/linux/vm_event_item.h |   2 +
> >  mm/vmstat.c                   |   2 +
> >  5 files changed, 420 insertions(+), 7 deletions(-)
> > 
> > -- 
> > 2.37.1
> > 
> > 

-- 
Sincerely yours,
Mike.
