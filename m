Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCFC5101C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348315AbiDZPZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347899AbiDZPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:25:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086EB7CE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B34AAB820D5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A29BC385A0;
        Tue, 26 Apr 2022 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650986526;
        bh=3mtKY2swnsLIDfqeSbOdD0VESWHzKKX5nhkvH+Z/6Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k80daLCvmuuBrYU7XZYjtCCEFn5L+H85rBhJUPW0ExOhP3+7KXSQ5O4EzXi1vpBcB
         rN+UCbLRqzvmyICfCuCqDBU46dD+yym1c/pSVqlnv6aA2A0MgRCIvsPuiQHA/pCC4s
         9OjIe+erpZc3ac8QQtrT9lfMhNDJy4tW1QGq/QcDr/4O4HTgKbZKBe2s9NIaWQZBno
         Fw66Zhv938GBO2i/uf3/GenrPQWTzPrLgmv6YOVvY7dc7R2IpJ17yZ0AmkpSqp3fo7
         j4+KONrNCSj7WlW/GzZ9i5xGrKSXY32BLpJkRXI4LQIVl7kn1w5egpV9RS96mgKoio
         108uXLYfu1ZCw==
Date:   Tue, 26 Apr 2022 18:21:57 +0300
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
Message-ID: <YmgOFa3FUUpiANMq@kernel.org>
References: <20220127085608.306306-1-rppt@kernel.org>
 <YmezWeMZSRNRfXyG@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmezWeMZSRNRfXyG@hyeyoo>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hyeonggon,

On Tue, Apr 26, 2022 at 05:54:49PM +0900, Hyeonggon Yoo wrote:
> On Thu, Jan 27, 2022 at 10:56:05AM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > This is a second attempt to make page allocator aware of the direct map
> > layout and allow grouping of the pages that must be mapped at PTE level in
> > the direct map.
> >
> 
> Hello mike, It may be a silly question...
> 
> Looking at implementation of set_memory*(), they only split
> PMD/PUD-sized entries. But why not _merge_ them when all entries
> have same permissions after changing permission of an entry?
> 
> I think grouping __GFP_UNMAPPED allocations would help reducing
> direct map fragmentation, but IMHO merging split entries seems better
> to be done in those helpers than in page allocator.

Maybe, I didn't got as far as to try merging split entries in the direct
map.  IIRC, Kirill sent a patch for collapsing huge pages in the direct map
some time ago, but there still was something that had to initiate the
collapse.

> For example:
> 	1) set_memory_ro() splits 1 RW PMD entry into 511 RW PTE
> 	entries and 1 RO PTE entry.
> 
> 	2) before freeing the pages, we call set_memory_rw() and we have
> 	512 RW PTE entries. Then we can merge it to 1 RW PMD entry.

For this we need to check permissions of all 512 pages to make sure we can
use a PMD entry to map them.
Not sure that doing the scan in each set_memory call won't cause an overall
slowdown.
 
> 	3) after 2) we can do same thing about PMD-sized entries
> 	and merge them into 1 PUD entry if 512 PMD entries have
> 	same permissions.
> 
> [...]
> 
> > Mike Rapoport (3):
> >   mm/page_alloc: introduce __GFP_UNMAPPED and MIGRATE_UNMAPPED
> >   mm/secretmem: use __GFP_UNMAPPED to allocate pages
> >   EXPERIMENTAL: x86/module: use __GFP_UNMAPPED in module_alloc
> > 
> >  arch/Kconfig                   |   7 ++
> >  arch/x86/Kconfig               |   1 +
> >  arch/x86/kernel/module.c       |   2 +-
> >  include/linux/gfp.h            |  13 +++-
> >  include/linux/mmzone.h         |  11 +++
> >  include/trace/events/mmflags.h |   3 +-
> >  mm/internal.h                  |   2 +-
> >  mm/page_alloc.c                | 129 ++++++++++++++++++++++++++++++++-
> >  mm/secretmem.c                 |   8 +-
> >  9 files changed, 162 insertions(+), 14 deletions(-)
> > 
> > 
> > base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Thanks,
> Hyeonggon

-- 
Sincerely yours,
Mike.
