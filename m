Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568FF54B218
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbiFNNNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiFNNN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:13:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3F93668B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BtkNA8bnFXUJxG1GIdprNfyVDGg3vDC4/9ZoY+WLPSM=; b=Z2ye09vqFR1lmMOiossGHXii+D
        1wF8QAsAmmHJj97pPcgWinAavHDonjKZM6REYxB3Fe2if2x9jCl0cbMyAPGBYqfkQdhOlutpC4EPT
        WEqg+GhmvFzyu+30/QaPmJaNJtPBFG5EzWD9U4QNP2LnnnsHhWyP0wrX4axmyrpPhMpMcQfUTJXJ+
        g6SHnuQTwJ/3xY7ux3tdAvN4Do2w/i7fj/me18UCKVYbYwSU4s5uSb2YOwhQOFDzLmYOEgAB7we3G
        fI9tpreRaRNLkklkScS2+JOmvG1hcfm7nr64LdAbhh7BZLLoncG6LGypsiNLogMp1cj1+2+PCHib4
        ZiajdU0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o16M4-000BS0-J6; Tue, 14 Jun 2022 13:13:12 +0000
Date:   Tue, 14 Jun 2022 14:13:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/page_alloc: make calling prep_compound_head more
 reliable
Message-ID: <YqiJaOiGnUzzB1+W@casper.infradead.org>
References: <20220607144157.36411-1-linmiaohe@huawei.com>
 <20220607113257.84b1bdd993f19be26b8c4944@linux-foundation.org>
 <65e5da9c-32d1-17d7-d8c6-96cbfac23fec@oracle.com>
 <4a30f026-789a-9235-2fbd-f553e4d7b45d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a30f026-789a-9235-2fbd-f553e4d7b45d@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 08:17:35PM +0800, Miaohe Lin wrote:
> +++ b/mm/page_alloc.c
> @@ -6771,13 +6771,18 @@ static void __ref memmap_init_compound(struct page *head,
>                 set_page_count(page, 0);
> 
>                 /*
> -                * The first tail page stores compound_mapcount_ptr() and
> -                * compound_order() and the second tail page stores
> -                * compound_pincount_ptr(). Call prep_compound_head() after
> -                * the first and second tail pages have been initialized to
> -                * not have the data overwritten.
> +                * The first tail page stores compound_mapcount_ptr(),
> +                * compound_order() and compound_pincount_ptr(). Call
> +                * prep_compound_head() after the first tail page have
> +                * been initialized to not have the data overwritten.
> +                *
> +                * Note the idea to make this right after we initialize
> +                * the offending tail pages is trying to take advantage
> +                * of the likelihood of those tail struct pages being
> +                * cached given that we will read them right after in
> +                * prep_compound_head().

It's not that we'll read them again, it's that the cacheline will still
be in cache, and therefore dirty.

Honestly, I don't think we need this extra explanation in a comment.
Just change the first paragraph to reflect reality and leave it at that.

>                  */
> -               if (pfn == head_pfn + 2)
> +               if (unlikely(pfn == head_pfn + 1))

We definitely don't need the unlikely here.

>                         prep_compound_head(head, order);
>         }
>  }
> 
> Or am I miss something?
> 
> Thanks!
> 
> > .
> > 
> 
