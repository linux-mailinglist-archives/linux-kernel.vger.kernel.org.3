Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF74BABA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbiBQVUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:20:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiBQVUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:20:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF597EB1A;
        Thu, 17 Feb 2022 13:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WzcmJYTIYrt9kZZ5GGnt4kb1vTdwO2pIR1DRHbAVjto=; b=BRr57bJUnkXthQmfSEQhMh8yjo
        8s5Mp2aio7M9Je92WKqFlEfEiDJ47kRZMnqZDWf5Tt/jyTVvzGL2Uo8pfmg5o1R1d38VqPAETJujs
        5YnjPtNTdeK9cThGWI+U373VpJCsg4wysXtlbpjePKfMYLRlZv624MCM3K67NdbBAmW3VUOZx4dO5
        ahTLzmeaYx7AL+C2LCm1vIdnLqlpWHICxMPa+RsqbgV5tMA6PJ6lEeSI0wZXaz1lmCdHsHGxCyPbx
        XLQ/PR1DGJ+XjSoPGX4Tz4RMeYbto3/hBzlgio7eT1o/QYUkEBteK6ZhzkaPwBM4BhhBBpVULIHVg
        DLEBI7tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKoBj-00FxRX-2d; Thu, 17 Feb 2022 21:19:43 +0000
Date:   Thu, 17 Feb 2022 21:19:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm@kvack.org,
        William Kucharski <william.kucharski@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Christoph Hellwig <hch@lst.de>, Hugh Dickins <hughd@google.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the folio
 tree
Message-ID: <Yg6778VW5JX512GL@casper.infradead.org>
References: <20220215180043.23879691@canb.auug.org.au>
 <YgumpQrC+cuYe91H@casper.infradead.org>
 <20220216172109.72fd0a38@canb.auug.org.au>
 <Yg1hf0iHdKcjnq6l@casper.infradead.org>
 <20220217163026.5e48ccb1@canb.auug.org.au>
 <20220216215124.169c42a52e31575cedc4dea5@linux-foundation.org>
 <20220217173810.0addd3ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217173810.0addd3ed@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 05:38:10PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 16 Feb 2022 21:51:24 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 17 Feb 2022 16:30:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > 
> > > On Wed, 16 Feb 2022 20:41:35 +0000 Matthew Wilcox <willy@infradead.org> wrote:  
> > > >
> > > > So where do we go from here?  I can see ways of resolving this if
> > > > Andrew switches to git, but he won't, so that's out.  Perhaps I can
> > > > publish a git tree of Hugh's mlock patches and Christoph's series,
> > > > and you can pull that before Andrew's tree so git resolves the conflicts
> > > > early before trying to resolve conflicts against my tree?  
> > > 
> > > My response for any other subsystem would be that you need to go
> > > through the maintainer's tree.  In this case that means feeding a patch
> > > series to Andrew and updating that patch series.
> > > 
> > > Alternatively, you need to find someone (with Andrew's agreement) who
> > > can maintain a git tree that includes all Andrew's MM patches and any
> > > other topic branches and deals with all the conflicts and can feed it
> > > all to Linus.  Linux-next would also include that tree/branch.
> > > 
> > > Andrew, do you have any comments?  
> > 
> > Let's try Matthew's idea - I'll get Hugh's and Christoph's series via
> > linux-next and shall figure out the rest.
> 
> OK, but I am on vacation from tomorrow until Feb 28th, so I will assume
> you will have it all ready for me by then.

I assume you mean that you'll do one last pull and release a
next-20220218, rather than saying that the next release will be
next-20220229?

I have pushed out f82e2137bc1e to infradead/for-next.  xfstests currently
running.  It includes:

Alex Sierra (10):
      mm: add zone device coherent type memory support
      mm: add device coherent vma selection for memory migration
      mm/gup: fail get_user_pages for LONGTERM dev coherent type
      drm/amdkfd: add SPM support for SVM
      drm/amdkfd: coherent type as sys mem on migration to ram
      lib: test_hmm add ioctl to get zone device type
      lib: test_hmm add module param for zone device type
      lib: add support for device coherent type in test_hmm
      tools: update hmm-test to support device coherent type
      tools: update test_hmm script to support SP config

Alistair Popple (2):
      mm: remove the vma check in migrate_vma_setup()
      mm/gup: migrate device coherent pages when pinning instead of failing

Christoph Hellwig (14):
      mm: remove a pointless CONFIG_ZONE_DEVICE check in memremap_pages
      mm: remove the __KERNEL__ guard from <linux/mm.h>
      mm: remove pointless includes from <linux/hmm.h>
      mm: move free_devmap_managed_page to memremap.c
      mm: simplify freeing of devmap managed pages
      mm: don't include <linux/memremap.h> in <linux/mm.h>
      mm: remove the extra ZONE_DEVICE struct page refcount
      fsdax: depend on ZONE_DEVICE || FS_DAX_LIMITED
      mm: generalize the pgmap based page_free infrastructure
      mm: refactor check_and_migrate_movable_pages
      mm: refactor the ZONE_DEVICE handling in migrate_vma_insert_page
      mm: refactor the ZONE_DEVICE handling in migrate_vma_pages
      mm: move the migrate_vma_* device migration code into its own file
      mm: build migrate_vma_* for all configs with ZONE_DEVICE support

Hugh Dickins (13):
      mm/munlock: delete page_mlock() and all its works
      mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE
      mm/munlock: delete munlock_vma_pages_all(), allow oomreap
      mm/munlock: rmap call mlock_vma_page() munlock_vma_page()
      mm/munlock: replace clear_page_mlock() by final clearance
      mm/munlock: maintain page->mlock_count while unevictable
      mm/munlock: mlock_pte_range() when mlocking or munlocking
      mm/migrate: __unmap_and_move() push good newpage to LRU
      mm/munlock: delete smp_mb() from __pagevec_lru_add_fn()
      mm/munlock: mlock_page() munlock_page() batch by pagevec
      mm/munlock: page migration needs mlock pagevec drained
      mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)
      mm/thp: shrink_page_list() avoid splitting VM_LOCKED THP

Matthew Wilcox (Oracle) (83):
[skipped]

Mike Rapoport (1):
      arch: Add pmd_pfn() where it is missing

William Kucharski (1):
      mm/readahead: Align file mappings for non-DAX


I squashed in the various -fix patches that were in the akpm or next
trees.  I hope I didn't miss anything important.

https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next
if anyone wants to browse and tell me if I messed something up.
