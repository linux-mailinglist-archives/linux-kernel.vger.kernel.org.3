Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4304B7870
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243727AbiBOTgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:36:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243697AbiBOTgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:36:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B5B91E9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=liRxA7Be2R6OYlNY16xNdTFCNkvY6XWDtvHFmw5ABlo=; b=U9hAVd/6U9mNdSYuwR3fObXqn4
        j6U4IPsKAorlGQx30QxyZiTlUcRqwYdosMWPJgAJJgedYjeCda3m9HRTjrtod7+BKcQZgvFNXqJJj
        WJxY7ATKpYqntKZErCKp0OjFrK7WDUpbM9lGhUWXCuf4jL+uI/7lLrxplpNFEVoCX8DsFuGjCMOWi
        x89ebTXLLSRGDFKd7LhnfXclgoL56squ3QwhbhyKPQ1BTlT4wqStkNz7qDV4WtW3O5TOWuIRB8WYh
        2sQKMOuSTO7omUJ677MoW1qee4e9W0Z9bc2Ak8ofOs3goFvmM1gQWCJTO+4WxcSZAAi3puu5OQoOW
        lfA7nbNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK3cD-00E7Ua-CJ; Tue, 15 Feb 2022 19:35:57 +0000
Date:   Tue, 15 Feb 2022 19:35:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/13] mm/munlock: rework of mlock+munlock page
 handling
Message-ID: <YgwAnYVfg+38leFs@casper.infradead.org>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 06:18:34PM -0800, Hugh Dickins wrote:
> Andrew, many thanks for including v1 and fixes in mmotm: please now replace
> 
> mm-munlock-delete-page_mlock-and-all-its-works.patch
> mm-munlock-delete-foll_mlock-and-foll_populate.patch
> mm-munlock-delete-munlock_vma_pages_all-allow-oomreap.patch
> mm-munlock-rmap-call-mlock_vma_page-munlock_vma_page.patch
> mm-munlock-replace-clear_page_mlock-by-final-clearance.patch
> mm-munlock-maintain-page-mlock_count-while-unevictable.patch
> mm-munlock-mlock_pte_range-when-mlocking-or-munlocking.patch
> mm-migrate-__unmap_and_move-push-good-newpage-to-lru.patch
> mm-munlock-delete-smp_mb-from-__pagevec_lru_add_fn.patch
> mm-munlock-mlock_page-munlock_page-batch-by-pagevec.patch
> mm-munlock-mlock_page-munlock_page-batch-by-pagevec-fix.patch
> mm-munlock-mlock_page-munlock_page-batch-by-pagevec-fix-2.patch
> mm-munlock-page-migration-needs-mlock-pagevec-drained.patch
> mm-thp-collapse_file-do-try_to_unmapttu_batch_flush.patch
> mm-thp-shrink_page_list-avoid-splitting-vm_locked-thp.patch
> 
> by the following thirteen of v2. As before, some easy fixups will be
> needed to apply in mm/huge_memory.c, but otherwise expected to be clean.
> 
> Many thanks to Vlastimil Babka for his review of 01 through 11, and
> to Matthew Wilcox for graciously volunteering to rebase his over these.

I have now pushed these 13 patches to my for-next branch:

git://git.infradead.org/users/willy/pagecache.git for-next

and rebased my folio patches on top.  Mostly that involved dropping
my mlock-related patches, although there were a few other adjustments
that needed to be made.  That should make Stephen's merge resolution
much easier once Andrew drops v1 of these patches from his tree.

