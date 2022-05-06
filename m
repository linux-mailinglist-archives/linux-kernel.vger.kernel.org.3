Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4D51D3E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390321AbiEFJDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiEFJDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:03:09 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524963519
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:59:27 -0700 (PDT)
Date:   Fri, 6 May 2022 17:59:20 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651827566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P1HmSJWhSIX/xlEGz2iSAB8cx2SMZp3jJMtDuWQ7g48=;
        b=qbWXnTqLPh4emRaNAmRy/km7pAH8zEjTqbINWktwnWEh5ztCr6xwox9qQ7kOGRElD7BnZz
        1WK41tAKl75yoHSrJJE0aofwtfubEIjIGcbuIx0PmFJg2e/DOW1CKfDB+uSLlmka4Wcgax
        h7bjWAhZ97wBNl6hMSbhAFSG2IJkqhE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
Message-ID: <20220506085920.GC1356094@u2004>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429142206.294714-4-pizhenwei@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:22:05PM +0800, zhenwei pi wrote:
> In the memory failure procedure, hwpoison_filter has higher priority,
> if memory_filter() filters the error event, there is no need to do
> the further work.

Could you clarify what problem you are trying to solve (what does
"optimize" mean in this context or what is the benefit)?

Now hwpoison_filter() can be called both with *and* without taking page refcount.
It's mainly called *with* taking page refcount in order to make sure that the
actual handling process is executed only for pages that meet a given condition.
IOW, it's important to prevent pages which do not meet the condition from going
ahead to further steps (false-positive is not permitted).  So this type of
callsite should not be omittable.

As for the other case, hwpoison_filter() is also called in hwpoison_inject()
*without* taking page refcount.  This actually has a different nuance and
intended to speculatively filter the injection events before setting
PageHWPoison flag to reduce the noise due to setting PG_hwpoison temporary.
The point is that it's not intended here to filter precisely and this callsite
is omittable.

So in my understanding, we need keep hwpoison_filter() after taking page
refcount as we do now.  Maybe optionally and additionally calling
hwpoison_filter() at the beginning of memory_failure() might be possible,
but I'm not sure yet how helpful...

Thanks,
Naoya Horiguchi

> 
> Cc: Wu Fengguang <fengguang.wu@intel.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  mm/memory-failure.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ece05858568f..a6a27c8b800f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1800,6 +1800,11 @@ int memory_failure(unsigned long pfn, int flags)
>  		goto unlock_mutex;
>  	}
>  
> +	if (hwpoison_filter(p)) {
> +		res = -EOPNOTSUPP;
> +		goto unlock_mutex;
> +	}
> +
>  try_again:
>  	res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
>  	if (hugetlb)
> @@ -1937,15 +1942,6 @@ int memory_failure(unsigned long pfn, int flags)
>  	 */
>  	page_flags = p->flags;
>  
> -	if (hwpoison_filter(p)) {
> -		if (TestClearPageHWPoison(p))
> -			num_poisoned_pages_dec();
> -		unlock_page(p);
> -		put_page(p);
> -		res = -EOPNOTSUPP;
> -		goto unlock_mutex;
> -	}
> -
>  	/*
>  	 * __munlock_pagevec may clear a writeback page's LRU flag without
>  	 * page_lock. We need wait writeback completion for this page or it
> -- 
> 2.20.1
> 
