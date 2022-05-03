Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD6D517CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiECEse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiECEsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:48:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1952E3E5C3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 21:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABD23B81A52
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779C6C385A4;
        Tue,  3 May 2022 04:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651553096;
        bh=eIdjs4XODuZ7/ywGfqv6zqyfmOwof/f8BJ/NNK9JEy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CL7JZyokbdHXQ2/8cwW60cI6U3wDZB6DI8RpKc/QwVC84fl9U/0ObwYuJdKMKrA0B
         iWe2ZiqQgOy9i1CHcSoZZn6ESi9hZUD3gE1fTi3QAGxprYRBCMEhjc2KMP05eAOrpq
         8dwYTA/6lJxDG0NAghPF1z6qEoT5BTcJEOnklfEPgUMJgUgDcq5D8HMgRz5X7UMixk
         eoQEKm364GbzEy3dUrvpGFDSySRNuFFbdC5atPfO2FluBFvnLcUjtMmFD/V2Hh6NC2
         ShJjiwTaYQSWw/E7hA3yX+wNDNE9XfxZoG5+wX95spUZszJxhpqH4MNu/yrnT+Isrx
         3TRaX4L7RNdvg==
Date:   Mon, 2 May 2022 21:44:48 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 0/3] Prototype for direct map awareness in page
 allocator
Message-ID: <YnCzQJk8Mu1848tG@kernel.org>
References: <20220127085608.306306-1-rppt@kernel.org>
 <YmezWeMZSRNRfXyG@hyeyoo>
 <YmgOFa3FUUpiANMq@kernel.org>
 <20220430134415.GA25819@ip-172-31-27-201.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430134415.GA25819@ip-172-31-27-201.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 01:44:16PM +0000, Hyeonggon Yoo wrote:
> On Tue, Apr 26, 2022 at 06:21:57PM +0300, Mike Rapoport wrote:
> > Hello Hyeonggon,
> > 
> > On Tue, Apr 26, 2022 at 05:54:49PM +0900, Hyeonggon Yoo wrote:
> > > On Thu, Jan 27, 2022 at 10:56:05AM +0200, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > Hi,
> > > > 
> > > > This is a second attempt to make page allocator aware of the direct map
> > > > layout and allow grouping of the pages that must be mapped at PTE level in
> > > > the direct map.
> > > >
> > > 
> > > Hello mike, It may be a silly question...
> > > 
> > > Looking at implementation of set_memory*(), they only split
> > > PMD/PUD-sized entries. But why not _merge_ them when all entries
> > > have same permissions after changing permission of an entry?
> > > 
> > > I think grouping __GFP_UNMAPPED allocations would help reducing
> > > direct map fragmentation, but IMHO merging split entries seems better
> > > to be done in those helpers than in page allocator.
> >
> > Maybe, I didn't got as far as to try merging split entries in the direct
> > map.  IIRC, Kirill sent a patch for collapsing huge pages in the direct map
> > some time ago, but there still was something that had to initiate the
> > collapse.
> 
> But in this case buddy allocator's view of direct map is quite limited.
> It cannot merge 2M entries to 1G entry as it does not support
> big allocations. Also it cannot merge entries of pages freed in boot process
> as they weren't allocated from page allocator.
> 
> And it will become harder when pages in MIGRATE_UNMAPPED is borrowed
> from another migrate type....
> 
> So it would be nice if we can efficiently merge mappings in
> change_page_attr_set(). this approach can handle cases above.
> 
> I think in this case grouping allocations and merging mappings
> should be done separately.

I've added the provision to merge the mappings in __free_one_page() because
at that spot we know for sure we can replace multiple PTEs with a single
PMD.

I'm not saying there should be no additional mechanism for collapsing
direct map pages, but I don't know when and how it should be invoked.
 
> > > For example:
> > > 	1) set_memory_ro() splits 1 RW PMD entry into 511 RW PTE
> > > 	entries and 1 RO PTE entry.
> > > 
> > > 	2) before freeing the pages, we call set_memory_rw() and we have
> > > 	512 RW PTE entries. Then we can merge it to 1 RW PMD entry.
> > 
> > For this we need to check permissions of all 512 pages to make sure we can
> > use a PMD entry to map them.
> 
> Of course that may be slow. Maybe one way to optimize this is using some bits
> in struct page, something like: each bit of page->direct_map_split (unsigned long)
> is set when at least one entry in (PTRS_PER_PTE = 512)/(BITS_PER_LONG = 64) = 8 entries
> has special permissions.
> 
> Then we just need to set the corresponding bit when splitting mappings and
> iterate 8 entries when changing permission back again. (and then unset the bit when 8 entries has
> usual permissions). we can decide to merge by checking if page->direct_map_split is zero.
> 
> When scanning, 8 entries would fit into one cacheline.
> 
> Any other ideas?
> 
> > Not sure that doing the scan in each set_memory call won't cause an overall
> > slowdown.
> 
> I think we can evaluate it by measuring boot time and bpf/module
> load/unload time.
> 
> Is there any other workload that is directly affected
> by performance of set_memory*()?
> 
> > > 	3) after 2) we can do same thing about PMD-sized entries
> > > 	and merge them into 1 PUD entry if 512 PMD entries have
> > > 	same permissions.
> > > [...]
> > > > Mike Rapoport (3):
> > > >   mm/page_alloc: introduce __GFP_UNMAPPED and MIGRATE_UNMAPPED
> > > >   mm/secretmem: use __GFP_UNMAPPED to allocate pages
> > > >   EXPERIMENTAL: x86/module: use __GFP_UNMAPPED in module_alloc
> > > -- 
> > > Thanks,
> > > Hyeonggon
> > 
> > -- 
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
