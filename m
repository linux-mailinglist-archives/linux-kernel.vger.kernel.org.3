Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C94B928C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiBPUlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:41:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiBPUlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:41:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E668B12620;
        Wed, 16 Feb 2022 12:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q6SDldfLhgxU5LdnUC335Cw30Q8Jsl/JGRM/JCUr/Yw=; b=VRaSLwfcbHlqJGtV0RppVHYDOO
        hHUJp9NtaMxktrU6rnTYZE3vFIYX2CKSqrln+u0c6Qysarqd4RAA+0bb7wSM+fImc9ThPc1DJ18zJ
        O6GmSuBr1cIHr8IbZwcTOothiAzX8DbTeGbqKsIbp6ISrY5aZZgJFrS6UAZWnRTJE8nzAI/p8WWFV
        F3tN+neQTuBMqV/RGgrMvegWcJaC8fxrHAcz0/IYAzRrQczA8HFP076KVmdRQ9nfOzAR7bhautmVb
        cFRI7bd218ab9EMIjE1uJrFy4KwRs2FLzdpFXZkZJt3ES9vZrA7Nv+qnIwHHzNLOb3ha9tT3ciMAj
        vTIv59Tg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKR7H-00F1oj-1f; Wed, 16 Feb 2022 20:41:35 +0000
Date:   Wed, 16 Feb 2022 20:41:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the folio
 tree
Message-ID: <Yg1hf0iHdKcjnq6l@casper.infradead.org>
References: <20220215180043.23879691@canb.auug.org.au>
 <YgumpQrC+cuYe91H@casper.infradead.org>
 <20220216172109.72fd0a38@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216172109.72fd0a38@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 05:21:09PM +1100, Stephen Rothwell wrote:
> Hi Matthew,
> 
> On Tue, 15 Feb 2022 13:12:05 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Feb 15, 2022 at 06:00:43PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the block tree got conflicts in:
> > > 
> > >   include/linux/mm.h
> > >   include/linux/rmap.h
> > >   mm/gup.c
> > >   mm/huge_memory.c
> > >   mm/internal.h
> > >   mm/memory-failure.c
> > >   mm/migrate.c
> > >   mm/mlock.c
> > >   mm/rmap.c
> > >   mm/vmscan.c
> > > 
> > > There is no way I can figure out in a reasonable time (or at all
> > > probably) the resolution needed here.  You guys need to get together
> > > and figure out how the folio tree changes are going to progress to
> > > Linus' tree.
> > > 
> > > I have gone back and used the folio tree from next-20220204 again for
> > > today.  
> > 
> > Thanks!
> > 
> > My plan is to take v2 of Hugh's mlock rewrite into my tree today and
> > redo the folio changes on top of those.  That should reduce the amount
> > of conflict between akpm's tree and the folio tree to the usual
> > managable amount.  Let's see how that goes.
> > 
> 
> It looks like Andrew now has a new version of Hugh's patches and there
> are quite a few other conflicts as well (see my attempt at mm/gup.c).

Well, this is all kinds of messy.  It seems like git doesn't notice that
both Andrew and I have the same patches (obviously they're different
commit IDs).  And some of the patches in Andrew's tree are based on
Hugh's changes (eg "mm: enable MADV_DONTNEED for hugetlb mappings"
depends on "mm/munlock: delete munlock_vma_pages_all(), allow oomreap")

So a lot of the conflicts would be resolved if Andrew dropped Hugh's
patches, but it would introduce new ones.  There are also a number of
other patches which I could resolve the conflicts manually, mostly
hch's enthusiastic refactorings.

List of conflicts and how I would resolve them:
 - mm/huge_memory: remove stale page_trans_huge_mapcount()
   Textual conflict resolution
 - mm: don't include <linux/memremap.h> in <linux/mm.h>
   Need to move folio_is_device_private90 to linux/memremap.h
 - Not entirely sure why there's a conflict with
   remove_migration_ptes(), take my version.
 - mm: refactor check_and_migrate_movable_pages
   mm/gup: fail get_user_pages for LONGTERM dev coherent type
   mm/gup: migrate device coherent pages when pinning instead of failing
   Completely wrecked my patches.
 - mm/huge_memory: remove stale locking logic from __split_huge_pmd()
   Minor wreckage; mostly I converted code which David deleted.
 - mm: thp: fix wrong cache flush in remove_migration_pmd()
   Textual conflict
 - mm/munlock: rmap call mlock_vma_page() munlock_vma_page()
   I included this patch; if Andrew drops it, the problem goes away
 - mm: handle uninitialized numa nodes gracefully
   Purely textual conflict
 - mm: enable MADV_DONTNEED for hugetlb mappings
   Take the version from Andrew's tree
 - mm/memory-failure.c: rework the try_to_unmap logic in hwpoison_user_mappings
()
   Should be a straightforward resolution -- replacing 'hpage' with 'folio'
   as the first argument to try_to_unmap().
 - mm: move the migrate_vma_* device migration code into its own file
   The folio changes need to follow the rename.
 - mm/rmap: convert from atomic_t to refcount_t on anon_vma->refcount
   Purely textual conflict
 - mm: fix race between MADV_FREE reclaim and blkdev direct IO read
   This one's a bit messy; needs converting from page APIs to folio APIs
 - mm/fs: remove inode_congested()
   Purely textual conflict

So where do we go from here?  I can see ways of resolving this if
Andrew switches to git, but he won't, so that's out.  Perhaps I can
publish a git tree of Hugh's mlock patches and Christoph's series,
and you can pull that before Andrew's tree so git resolves the conflicts
early before trying to resolve conflicts against my tree?
