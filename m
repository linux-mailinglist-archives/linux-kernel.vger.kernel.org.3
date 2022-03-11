Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD244D6A39
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiCKWzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCKWyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:54:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E5EACA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wWQbXRbezK3NRtMtSi3ATf+Wd1xnlwmrtyeo6SDza4g=; b=cscqcGcM1lLDTv+e62zL2JJ8/l
        cjyGSld5RQSrMMzrK/JdnjJVU6L6l3yRd7ZL235Cc91w7HF9VEiyo4+RBu+yHRkTGKLuf/UeNmFtw
        h1kA3VfBe0IKLd04WWWViDYGEDY0I/TyWjwZJMsdrLandRQ7XdxXsaCxuDDSS7AKWnD/omYWWKJOi
        swpIjr2rGRmLSPzOy1kjVyeUJDS45VVrW3b4iD2D/PWN59WP7YeZh1EOi0EeuMXi9vBMMsUCpsoq4
        EAtBAJK/RHJagf/UtFneS5/33r4uOUE2vzUElJUvYzx+1JhK1siaKTTmGhzSH/ThdHQmeVoZv4s3O
        MnDl4fmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSmXf-001usC-TV; Fri, 11 Mar 2022 21:11:19 +0000
Date:   Fri, 11 Mar 2022 21:11:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
Message-ID: <Yiu693LTmhLyo1yu@casper.infradead.org>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-11-david@redhat.com>
 <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com>
 <CAHk-=wjWx_bPBLB=qMMae8Sy3KrO+Kvaf4juPknO5HX-+Ot0XQ@mail.gmail.com>
 <e166e925-508e-3830-574f-59b2d2cf2431@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e166e925-508e-3830-574f-59b2d2cf2431@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 08:36:37PM +0100, David Hildenbrand wrote:
> I used PG_error before, but felt like using a bit that is never ever
> valid to be set/cleared/checked on a subpage would be even a better fit:
> 
> Note the:
> 
>   PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
> 
> whereby PF_ONLY_HEAD translates to:
> 
> "for compound page, callers only ever operate on the head page."
> 
> 
> I can just switch to PG_error, but for the second subpage, PG_waiters
> should be just fine (unless I am missing something important).

I think you're missing something important that almost everybody misses
when looking at this code (including me).

PF_ANY flags can be set on individual pages.
PF_HEAD means "we automatically redirect all operations to the head page".
PF_ONLY_HEAD means "If you try to call this on a tail page, we BUG".
PF_NO_TAIL means "If you try to read this flag on a tail page, we'll
look at the head page instead, but if you try to set/clear this flag
on a tail page, we BUG"
PF_NO_COMPOUND means "We BUG() if you call this on a compound page"

So really, you can reuse any flag as PF_SECOND that isn't PF_ANY.

No, that's not what the documentation currently says.  It should be.
I had a patch to reword it at some point, but I guess it got lost.
The current documentation reads like "We replicate the flag currently
set on the head page to all tail pages", but that just isn't what
the code does.
