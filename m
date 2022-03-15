Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6704D9313
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbiCODdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbiCODds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:33:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95C488B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LX0E2les13YpXYBTKiKwQRB41rW+42lYHTDGzHdEAYU=; b=AJtxFRchW7D27kGcK6oYZmF5sA
        XonPIJLddVIcOM02rq5l+CPZAvswzV8R0vLGibH1n7vDtNBi+gm0lpOHdTI8nd6bcE/Ek6ASTfm24
        yiJ0EYKcNa7cX75sXm10TtJOKSou5cdiBjj4gA5LMqyPZyDJ1ZRU7fhIIyqyAjT5EWxdPJCil+RKd
        W5ZQnQj1V5z0lzKNjpi2q6oZ2+UCkhn6CX2vevQTuW3ooFUnhiwRikZDoYpLgqwr+CaELRGcUl7dj
        DuRyLHWcQU2iD+7P2DJilra4pXNGTl+F+1IqVcgdzEeKgkte+s1UX9rzFVrKVR4pRAlvNMyY4m+r+
        RirbJIMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTxuy-004e5z-Dd; Tue, 15 Mar 2022 03:32:16 +0000
Date:   Tue, 15 Mar 2022 03:32:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Yang <andrew.yang@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Subject: Re: [PATCH] mm/migrate: fix race between lock page and clear
 PG_Isolated
Message-ID: <YjAIwAT6PnQnbckn@casper.infradead.org>
References: <20220315030515.20263-1-andrew.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315030515.20263-1-andrew.yang@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:05:15AM +0800, Andrew Yang wrote:
> When memory is tight, system may start to compact memory for large
> continuous memory demands. If one process tries to lock a memory page
> that is being locked and isolated for compaction, it may wait a long time
> or even forever. This is because compaction will perform non-atomic
> PG_Isolated clear while holding page lock, this may overwrite PG_waiters
> set by the process that can't obtain the page lock and add itself to the
> waiting queue to wait for the lock to be unlocked.
> 
> CPU1                            CPU2
> lock_page(page); (successful)
>                                 lock_page(); (failed)
> __ClearPageIsolated(page);      SetPageWaiters(page) (may be overwritten)
> unlock_page(page);
> 
> The solution is to not perform non-atomic operation on page flags while
> holding page lock.
> 
> Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
> ---
>  include/linux/page-flags.h |  2 +-
>  mm/migrate.c               | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 1c3b6e5c8bfd..64a84a9835cb 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -918,7 +918,7 @@ PAGE_TYPE_OPS(Guard, guard)
>  
>  extern bool is_free_buddy_page(struct page *page);
>  
> -__PAGEFLAG(Isolated, isolated, PF_ANY);
> +PAGEFLAG(Isolated, isolated, PF_ANY);

Agreed.  Further, page cannot be a tail page (this is implied by the
get_page_unless_zero() as tailpages have a zero refcount, and it
is assumed by __PageMovable() as page->mapping is undefined for tail
pages).  So this can actually be:

+PAGEFLAG(Isolated, isolated, PF_NO_TAIL);

I considered PF_ONLY_HEAD, but there are a lot more places that _check_
PageIsolated() and I don't want to prove that they're all definitely
working on head pages.

