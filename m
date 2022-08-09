Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF7458D8C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbiHIMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242036AbiHIMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:31:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE53E081
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gmQkToknuLP2aTCghnh+j9lymTCfagxRDYZaCnLVF8Q=; b=f8IvBl82uCAuJJSOrk08F2VAio
        X/qb7AU21xuMhLG7x7HW7GY1JT9CNEXC28gujzANQmrk7Fyd+z8XrAIwC5InaYkgy+svNSolYbmVy
        vpKWkLD9COjNN2SEFnnMKaDbr8ROq9iNJPTNF/ZP8cBXiawB+/U3Z6qwYv1p1QM8Wf6a+MYpTGX32
        wESjYZkn/7Rg7QyJXMJ7YPue8DyiEMh6sttaaP9fF56RIObiMU+8RP8G+uke8l6CwJWHKuE2RaXcL
        x8dmW1ReF8s9jd9I427fxHJa8ainLUxZh2c6OQ1Mbvaxck9siubSw4rpPrJ7iwE2SxJFCFhQxMa5G
        +OHmN5SA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oLOO3-00FJG7-HM; Tue, 09 Aug 2022 12:31:07 +0000
Date:   Tue, 9 Aug 2022 13:31:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     alex.sierra@amd.com, akpm@linux-foundation.org, hch@lst.de,
        Felix.Kuehling@amd.com, apopple@nvidia.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: re-allow pinning of zero pfns (again)
Message-ID: <YvJTi0fAgl/T4WA4@casper.infradead.org>
References: <166002010021.381133.11357879752637949308.stgit@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166002010021.381133.11357879752637949308.stgit@omen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:42:24PM -0600, Alex Williamson wrote:
> The below referenced commit makes the same error as 1c563432588d ("mm: fix
> is_pinnable_page against a cma page"), re-interpreting the logic to exclude
> pinning of the zero page, which breaks device assignment with vfio.

Perhaps we need to admit we're not as good at boolean logic as we think
we are.

	if (is_device_coherent_page(page))
		return false;
	if (is_zone_movable_page(page))
		return false;
	return is_zero_pfn(page_to_pfn(page));

(or whatever the right logic is ... I just woke up and I'm having
trouble parsing it).

> Link: https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen
> Fixes: f25cbb7a95a2 ("mm: add zone device coherent type memory support")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  include/linux/mm.h |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 18e01474cf6b..772279ed7010 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1544,9 +1544,8 @@ static inline bool is_longterm_pinnable_page(struct page *page)
>  	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
>  		return false;
>  #endif
> -	return !(is_device_coherent_page(page) ||
> -		 is_zone_movable_page(page) ||
> -		 is_zero_pfn(page_to_pfn(page)));
> +	return !(is_device_coherent_page(page) || is_zone_movable_page(page)) ||
> +	       is_zero_pfn(page_to_pfn(page));
>  }
>  #else
>  static inline bool is_longterm_pinnable_page(struct page *page)
> 
> 
> 
