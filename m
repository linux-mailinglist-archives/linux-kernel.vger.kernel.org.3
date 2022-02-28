Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A024C6BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiB1MFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiB1MFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:05:40 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1800817E28
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:04:59 -0800 (PST)
Date:   Mon, 28 Feb 2022 21:04:48 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646049897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q1MJ8jXt8CRUuDZRl3QeZdqpRp5teAOKdkqZb44fYZI=;
        b=MXF4vhaI0lP1IgMok1yrUhPiWMMuJcw0xT7KyvONBR3PtiGZ0VcAJ7JaCAJ4qjcxxbp3Mb
        CQVZ2KbAviEkCaOoSJ3kZ1UnXOxnXxupUg01+MYcFzKTivvRFLdRnF9Xplx+ln5NJxU+qa
        utLXmJ26Ig7VnBeHTx6X/q/QEFgaGPw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        david@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] mm/memory-failure.c: fix memory failure race with
 memory offline
Message-ID: <20220228120448.GA1142923@u2004>
References: <20220226094034.23938-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220226094034.23938-1-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 05:40:34PM +0800, Miaohe Lin wrote:
> There is a theoretical race window between memory failure and memory
> offline. Think about the below scene:
> 
>   CPU A					  CPU B
> memory_failure				offline_pages
>   mutex_lock(&mf_mutex);
>   TestSetPageHWPoison(p)
> 					  start_isolate_page_range
> 					    has_unmovable_pages
> 					      --PageHWPoison is movable
> 					  do {
> 					    scan_movable_pages
> 					    do_migrate_range
> 					      --PageHWPoison isn't migrated
> 					  }
> 					  test_pages_isolated
> 					    --PageHWPoison is isolated
> 					remove_memory
>   access page... bang
>   ...
> 
> When PageHWPoison is set, the page could be offlined anytime regardless
> of the page refcnt. It's bacause start_isolate_page_range treats HWPoison
> page as movable and already isolated, so the page range can be successfully
> isolated. soft_offline_page and unpoison_memory have the similar race. Fix
> this by using get_online_mems + put_online_mems pair to guard aginst memory
> offline when doing memory failure.

Sounds convincing to me. Thanks for identifying. Is this problem reproduced
in your testing, or just picked out by code inspection?

> 
> There is a even worse race window. If the page refcnt is held, then memory
> failure happens, the page could be offlined while it's still in use. So The
> assumption that a page can not be offlined when the page refcnt is held is
> now broken. This theoretical race window could happen in every vm activity.
> But this race window might be too small to fix.

Yes, hwpoisoned pages can now be offlined while they have refcount > 0.
I think that they need to be categorize into two groups based on
whether the error page was successfully handled or not.

If a error page is successfully handled, then page_handle_poison() succeeded
and the refcount should be one (which is held only by hwpoison subsystem
itself, so there should be no other reference to it), so it should be safely
offlined as we do now.  But if error handling failed, the hwpoisoned page
have any value and there could remain some reference to it.  So we might
better to make offline_pages() fail for such "failed handling" pages, or for
all hwpoisoned pages with refcount more than one?

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5444a8ef4867..b85232a64104 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1702,6 +1702,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	if (!sysctl_memory_failure_recovery)
>  		panic("Memory failure on page %lx", pfn);
> 
> +	get_online_mems();
>  	mutex_lock(&mf_mutex);
> 
>  	p = pfn_to_online_page(pfn);
> @@ -1894,11 +1895,13 @@ int memory_failure(unsigned long pfn, int flags)
>  identify_page_state:
>  	res = identify_page_state(pfn, p, page_flags);
>  	mutex_unlock(&mf_mutex);
> +	put_online_mems();
>  	return res;
>  unlock_page:
>  	unlock_page(p);
>  unlock_mutex:
>  	mutex_unlock(&mf_mutex);
> +	put_online_mems();
>  	return res;
>  }
>  EXPORT_SYMBOL_GPL(memory_failure);
> @@ -2058,6 +2061,7 @@ int unpoison_memory(unsigned long pfn)
>  	if (!pfn_valid(pfn))
>  		return -ENXIO;
> 
> +	get_online_mems();
>  	p = pfn_to_page(pfn);
>  	page = compound_head(p);
> 
> @@ -2114,6 +2118,7 @@ int unpoison_memory(unsigned long pfn)
> 
>  unlock_mutex:
>  	mutex_unlock(&mf_mutex);
> +	put_online_mems();
>  	return ret;
>  }
>  EXPORT_SYMBOL(unpoison_memory);
> @@ -2278,10 +2283,12 @@ int soft_offline_page(unsigned long pfn, int flags)
>  	if (flags & MF_COUNT_INCREASED)
>  		ref_page = pfn_to_page(pfn);
> 
> +	get_online_mems();

I felt that {get,put}_online_mems() can be put together with takeing/freeing
mf_mutex with some wrapper lock/unlock function, which slightly improves
code readability (developers won't have to care about two locking separately).
That requires moving mutex_lock(&mf_mutex), which could have non-trivial
change, but maybe that's not so bad.

Thanks,
Naoya Horiguchi

>  	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
>  	page = pfn_to_online_page(pfn);
>  	if (!page) {
>  		put_ref_page(ref_page);
> +		put_online_mems();
>  		return -EIO;
>  	}
> 
> @@ -2291,13 +2298,12 @@ int soft_offline_page(unsigned long pfn, int flags)
>  		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
>  		put_ref_page(ref_page);
>  		mutex_unlock(&mf_mutex);
> +		put_online_mems();
>  		return 0;
>  	}
> 
>  retry:
> -	get_online_mems();
>  	ret = get_hwpoison_page(page, flags);
> -	put_online_mems();
> 
>  	if (ret > 0) {
>  		ret = soft_offline_in_use_page(page);
> @@ -2310,6 +2316,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>  	}
> 
>  	mutex_unlock(&mf_mutex);
> +	put_online_mems();
> 
>  	return ret;
>  }
> ---
> 2.23.0
> 
