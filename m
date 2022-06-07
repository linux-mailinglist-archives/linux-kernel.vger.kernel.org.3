Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E04541AB1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380765AbiFGVf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376619AbiFGU1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C791D8705
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C5B612F2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F75C385A5;
        Tue,  7 Jun 2022 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654626778;
        bh=6EWeMUW4V3uJswyhJrlu4wS327ebt1gLFVtjQxZ6kwc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pl0ITDp9k28djGN0qnztfygHz/ItO1iNYIxf2ZyNiMyFwJ2nWuUlWCIy6OpRtHl+d
         C1/GjByo284UIQ7QGt6iyzD0bB23lhLejK9IXqu3J8LrAVWvuU+fbuCAxL0wXRTrKC
         B5EmdlY3zLwNP+mHzd8A3GT74eASErBQfosc3fg0=
Date:   Tue, 7 Jun 2022 11:32:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH] mm/page_alloc: make calling prep_compound_head more
 reliable
Message-Id: <20220607113257.84b1bdd993f19be26b8c4944@linux-foundation.org>
In-Reply-To: <20220607144157.36411-1-linmiaohe@huawei.com>
References: <20220607144157.36411-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Let's cc Joao.

On Tue, 7 Jun 2022 22:41:57 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> compound_pincount_ptr is stored at first tail page instead of second tail
> page now.

"now"?  Some identifiable commit did this?

> And if it or some other field changes again in the future, data
> overwritten might happen. Calling prep_compound_head() outside the loop
> to prevent such possible issue. No functional change intended.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6772,17 +6772,8 @@ static void __ref memmap_init_compound(struct page *head,
>  		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
>  		prep_compound_tail(head, pfn - head_pfn);
>  		set_page_count(page, 0);
> -
> -		/*
> -		 * The first tail page stores compound_mapcount_ptr() and
> -		 * compound_order() and the second tail page stores
> -		 * compound_pincount_ptr(). Call prep_compound_head() after
> -		 * the first and second tail pages have been initialized to
> -		 * not have the data overwritten.
> -		 */
> -		if (pfn == head_pfn + 2)
> -			prep_compound_head(head, order);
>  	}
> +	prep_compound_head(head, order);
>  }
>  
>  void __ref memmap_init_zone_device(struct zone *zone,

