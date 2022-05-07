Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F151E96C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiEGT04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiEGT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:26:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB10186E2
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BC0C6CE0AAD
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 19:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B67C385A5;
        Sat,  7 May 2022 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651951383;
        bh=/yTWTK2657a6e5IKSoTYOVfyFLxzHBO5jGiV0wX7FFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SOj1L/sB+VaWVasrN7Jc3aYe2MKGXDmHVe0w/SJ7crTwSqxdCcYaEIlk726QHZ+Xf
         5Qe9sznmdKULLEQFW0v3pI3RXh/a46WQFbLmJrOMvKoyaQ9kiLAMIdAsPgvKKG2xGQ
         UtCQNxQt83G5SytDB5rFj5Gy+5AXlLQn0EZEc5A0=
Date:   Sat, 7 May 2022 12:23:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: fix is_pinnable_page against on cma page
Message-Id: <20220507122301.3b50eb030f9cd6f047f14352@linux-foundation.org>
In-Reply-To: <20220505064429.2818496-1-minchan@kernel.org>
References: <20220505064429.2818496-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 May 2022 23:44:29 -0700 Minchan Kim <minchan@kernel.org> wrote:

> Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
> so current is_pinnable_page could miss CMA pages which has MIGRATE_
> ISOLATE. It ends up putting CMA pages longterm pinning possible on
> pin_user_pages APIs so CMA allocation fails.
> 
> The CMA allocation path protects the migration type change race
> using zone->lock but what GUP path need to know is just whether the
> page is on CMA area or not rather than exact type. Thus, we don't
> need zone->lock but just checks the migratype in either of
> (MIGRATE_ISOLATE and MIGRATE_CMA).
> 
> Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
> rejecting of pinning the page on MIGRATE_ISOLATE pageblock even
> thouth it's neither CMA nor movable zone if the page is temporarily

"though"

> unmovable. However, the migration failure is general issue, not
> only come from MIGRATE_ISOLATE and the MIGRATE_ISOLATE is also
> transient state like other temporal refcount holding of pages.
> 
> ...
>
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1625,8 +1625,18 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>  #ifdef CONFIG_MIGRATION
>  static inline bool is_pinnable_page(struct page *page)
>  {
> -	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
> -		is_zero_pfn(page_to_pfn(page));
> +#ifdef CONFIG_CMA
> +	/*
> +	 * use volatile to use local variable mt instead of
> +	 * refetching mt value.
> +	 */
> +	volatile int mt = get_pageblock_migratetype(page);
> +
> +	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> +		return false;
> +#endif

Open-coded use of `volatile' draws unwelcome attention.

What are we trying to do here?  Prevent the compiler from rerunning all
of get_pageblock_migratetype() (really __get_pfnblock_flags_mask())
twice?  That would be pretty dumb of it?

Would a suitably-commented something like

	int __mt = get_pageblock_migratetype(page);
	int mt = __READ_ONCE(__mt);

express this better?
	
> +
> +	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
>  }
>  #else
>  static inline bool is_pinnable_page(struct page *page)

