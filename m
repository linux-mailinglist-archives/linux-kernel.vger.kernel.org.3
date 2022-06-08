Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC1543BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiFHSre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiFHSrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:47:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0047544F7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9F7WTlgt6YBamSKHdVJHkNHJLYpsk/TcsWBV6+0KbOs=; b=qbW6RhB5j1D316MyVabU+CxWUB
        CEuaPvI2yXgLZLp3YxLiPbZFv9zrvSuS2ajTI31F26R25Kv/sGgOdGVxKB0eImPWPmVpCz+3N0Qjx
        8TrJuMETdfvXCWPE2Tov/ZJkNalg7M1/uQs8rqZ4moR48zyevoE0j565MwLCXn297gZB1QpsetNED
        QIil6e64FOXMWt0cLxN4Inoo0wy1mf7TBtXr8S8JCcrGxir2Nt0XgRXCpFAIhxRadQIOD3diqgORy
        zVg6meYxvNZgvymQQwgDjYjWzUk7upvGjGjTpeaEmLtBxFlFA04iMoHpFUyhxfXWP+zGDvlbpAFYh
        q0guEHWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nz0iB-00CsmT-Gd; Wed, 08 Jun 2022 18:47:23 +0000
Date:   Wed, 8 Jun 2022 19:47:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmscan: don't try to reclaim freed folios
Message-ID: <YqDuu2KBofxl1s49@casper.infradead.org>
References: <20220608141432.23258-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608141432.23258-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 10:14:32PM +0800, Miaohe Lin wrote:
> If folios were freed from under us, there's no need to reclaim them. Skip
> these folios to save lots of cpu cycles and avoid possible unnecessary
> disk I/O.

Yes, but I asked how often this happened, and you said you didn't know.
Do you have any data?  I'm reluctant to make a function which is over
400 LOC already any longer.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v2:
>   use folio_ref_freeze to guard against race with GUP (fast). Many thanks
>   Matthew for pointing this out.
> ---
>  mm/vmscan.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 13d34d9593bb..547ae7ae6ab1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1610,13 +1610,19 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  		folio = lru_to_folio(page_list);
>  		list_del(&folio->lru);
>  
> +		nr_pages = folio_nr_pages(folio);
> +
> +		if (folio_ref_count(folio) == 1 &&
> +		    folio_ref_freeze(folio, 1)) {
> +			/* folio was freed from under us. So we are done. */
> +			goto free_it;
> +		}
> +
>  		if (!folio_trylock(folio))
>  			goto keep;
>  
>  		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
>  
> -		nr_pages = folio_nr_pages(folio);
> -
>  		/* Account the number of base pages */
>  		sc->nr_scanned += nr_pages;
>  
> -- 
> 2.23.0
> 
