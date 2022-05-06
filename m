Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0442451D3E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390346AbiEFJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390350AbiEFJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:03:38 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCA864BEA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:59:53 -0700 (PDT)
Date:   Fri, 6 May 2022 17:59:45 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651827592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=It468l5rDEjybV0iEao8CQ9t2I1qPohrUTy4neYSFfI=;
        b=gMcCaOMa4f7ms4z9s1DlZwbAaxS3JIJuSSdco/SY0xMK04TyV99mSm2uLjZYJdxtnf/y4M
        U+BoYDzNv42p2crlpa24TtUUBBSlVyaqW5TjkEYeOU62jXg1sZBnjSf5OmHySayuYlzH1H
        22lIC6qsakbGf0JWoPi2/rMlVG8r5/I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 4/4] mm/memofy-failure.c: add hwpoison_filter for soft
 offline
Message-ID: <20220506085945.GD1356094@u2004>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-5-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429142206.294714-5-pizhenwei@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:22:06PM +0800, zhenwei pi wrote:
> hwpoison_filter is missing in the soft offline path, this leads an
> issue: after enabling the corrupt filter, the user process still has
> a chance to inject hwpoison fault by
> madvise(addr, len, MADV_SOFT_OFFLINE) at PFN which is expected to
> reject.

The motivation is fine to me. Thank you for finding this.

> 
> Cc: Wu Fengguang <fengguang.wu@intel.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  mm/memory-failure.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a6a27c8b800f..6564f5a34658 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2313,7 +2313,9 @@ static void put_ref_page(struct page *page)
>   * @pfn: pfn to soft-offline
>   * @flags: flags. Same as memory_failure().
>   *
> - * Returns 0 on success, otherwise negated errno.
> + * Returns 0 on success
> + *         -EOPNOTSUPP for memory_filter() filtered the error event

Using word hwpoison_filter() rather than memory_filter() seems better to me.

> + *         < 0 otherwise negated errno.
>   *
>   * Soft offline a page, by migration or invalidation,
>   * without killing anything. This is for the case when
> @@ -2350,6 +2352,11 @@ int soft_offline_page(unsigned long pfn, int flags)
>  		return -EIO;
>  	}
>  
> +	if (hwpoison_filter(page)) {
> +		put_ref_page(ref_page);
> +		return -EOPNOTSUPP;
> +	}
> +

Based on the assumption behind hwpoison_filter(), calling it after
get_hwpoison_page() would be better?

Thanks,
Naoya Horiguchi
