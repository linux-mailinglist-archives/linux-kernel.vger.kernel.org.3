Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AD84E2C53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350302AbiCUPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350303AbiCUPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:32:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CE4169B26
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J/lTHS/ESbpMkBjmmSGXD7aVVwe5+onP+1fVkUHYzpg=; b=BJxaqjqFxD68gr8Nr8dZC2BPcv
        ml9J29lnqxjIbPfwfWRMOPk0udm15BAHWVEXcETCJJUV0tk8LiR8hXW/uoRe9stOY1rBsStGrIEd0
        hDFuPQ2Oi7HlauLma/UeXSPtJ/aWOxrcMJg1QsfMMz/ETHcv3JkqZM4fMcAnFhpgnF9eNTywfiqmU
        ZiVLQP2CEYYbKjdcp/6PoL5Uvo1Q95TDgWT5jfvghUv0xDJzpDEjmYS32TBDebhK6QzL+R6Hvk5U4
        t5AxJz4e/B8FIpuguY/SQ2LJlc2YP+fx06t9K2/mnv7x8I7on9J8oF2QKr730K3riQUbs8o2tkrwr
        BpdgAA5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWK09-00AhYf-5j; Mon, 21 Mar 2022 15:31:21 +0000
Date:   Mon, 21 Mar 2022 15:31:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [GIT PULL] Folio patches for 5.18 (MM part)
Message-ID: <YjiaSbUBLJP+9Jtt@casper.infradead.org>
References: <Yjh+EuacJURShtJI@casper.infradead.org>
 <9ae0a8e4-41b7-04f4-4435-17cbba9850fb@redhat.com>
 <d5676cf0-30f9-8497-95a8-332767dede46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5676cf0-30f9-8497-95a8-332767dede46@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 04:24:08PM +0100, David Hildenbrand wrote:
> On 21.03.22 16:16, David Hildenbrand wrote:
> > On 21.03.22 14:30, Matthew Wilcox wrote:
> >> Hi Linus,
> >>
> >> This is the first of two folio-related pull requests for this merge
> >> window.  This is the MM side of things and we had some unfortunate
> >> complex merge conflicts to resolve.  I decided to redo my changes on
> >> top of Hugh's and Christoph's patches, so I'm the one sending the
> >> pull request.
> >>
> >> The following changes since commit f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3:
> >>
> >>   Merge tag 'mmc-v5.17-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc (2022-02-16 12:09:22 -0800)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18
> >>
> >> for you to fetch changes up to 5063f22c914e3e5f2239cf91f4986042dc705bde:
> >>
> >>   mm/damon: minor cleanup for damon_pa_young (2022-03-16 10:09:50 -0400)
> >>
> >> ----------------------------------------------------------------
> >> Folio changes for 5.18
> >>
> >> Several of us had overlapping, conflicting changes to the MM this
> >> round, and I volunteered to send the pull request.
> >>
> >>  - Hugh rewrote how munlock works to massively reduce the contention
> >>    on i_mmap_rwsem:
> >>    https://lore.kernel.org/linux-mm/8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com/
> >>  - Christoph sorted out the page refcount mess for ZONE_DEVICE pages:
> >>    https://lore.kernel.org/linux-mm/20220210072828.2930359-1-hch@lst.de/
> >>  - I converted GUP to use folios and make pincount available for order-1
> >>    pages.
> >>  - I converted a few more truncation functions to use folios
> >>  - I converted page_vma_mapped_walk to use PFNs instead of pages
> >>  - I converted rmap_walk to use folios
> >>  - I converted most of shrink_page_list() to use a folio
> >>  - I added support for creating large folios in readahead
> >>
> >> ----------------------------------------------------------------
> >> Alex Sierra (10):
> >>       mm: add zone device coherent type memory support
> >>       mm: add device coherent vma selection for memory migration
> >>       mm/gup: fail get_user_pages for LONGTERM dev coherent type
> >>       drm/amdkfd: add SPM support for SVM
> >>       drm/amdkfd: coherent type as sys mem on migration to ram
> >>       lib: test_hmm add ioctl to get zone device type
> >>       lib: test_hmm add module param for zone device type
> >>       lib: add support for device coherent type in test_hmm
> >>       tools: update hmm-test to support device coherent type
> >>       tools: update test_hmm script to support SP config
> >>
> >> Alistair Popple (2):
> >>       mm: remove the vma check in migrate_vma_setup()
> >>       mm/gup: migrate device coherent pages when pinning instead of failing
> > 
> > ... I thought DEVICE_COHERENT is still under development?
> > 
> 
> After verifying that I'm not daydreaming [1] (and realizing that I had
> review comments to some of these patches that have not been resolved
> yet) and also not spotting these change in your changelog above, I
> assume this stuff was included by mistake. NACK to merging
> DEVICE_COHERENT at this point.
> 
> [1] https://lkml.kernel.org/r/20220310172633.9151-1-alex.sierra@amd.com

That patch ("split vm_normal_pages for LRU and non-LRU handling") isn't
included in this pull request.  The patches I have were those sent by
Christoph here:

https://lore.kernel.org/linux-mm/20220210072828.2930359-1-hch@lst.de/

I can drop any patches that you have objections to, but I don't see
any objections from you to any patches in that list.
