Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697455841FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiG1Olo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiG1Ok1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:40:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA68467C83
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:38:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F0A71FFCD;
        Thu, 28 Jul 2022 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659019075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H58eHiPkUcryRP+gt9wLL6yKrQ+MGSFaspDH3eNT0Z4=;
        b=DJ644a94EzSRlWdtsG7bXOknogezgnu4QS9e8wE6689tnAKqOrRw/7q4mDad0NG/Hx9Z9k
        tLN8aKe+mgZZj9GxSvg+uaDPoY2cAj+xJQLYRzoyB5lK3xAUSj32NkQyH9BvzgVLkkXgbo
        Nl1yPCn+nkzlqkqO6Lp5RMmhAkitAB4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EACD813A7E;
        Thu, 28 Jul 2022 14:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lPQcN0Kf4mIpZAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 28 Jul 2022 14:37:54 +0000
Date:   Thu, 28 Jul 2022 16:37:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, hocko@suse.com, david@redhat.com,
        quic_pkondeti@quicinc.com, pasha.tatashin@soleen.com,
        sjpark@amazon.de, sieberf@amazon.com, shakeelb@google.com,
        dhowells@redhat.com, willy@infradead.org,
        liuting.0x7c00@bytedance.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YuKfQoOHG1celfBK@dhcp22.suse.cz>
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-07-22 19:45:03, Charan Teja Kalla wrote:
[...]

Thanks for looking into this and improving the changelog. It is much
more easier to follow and also much better to understand.

> FAQ's:
> Q) Should page_ext_[get|put]() needs to be used for every page_ext
> access?
> A) NO, the synchronization is really not needed in all the paths of
> accessing page_ext. One case is where extra refcount is taken on a
> page for which memory block, this pages falls into, offline operation is
> being performed. This extra refcount makes the offline operation not to
> succeed hence the freeing of page_ext.  Another case is where the page
> is already being freed and we do reset its page_owner.

This is just subtlety and something that can get misunderstood over
time. Moreover there is no documentation explaining the difference.
What is the reason to have these two different APIs in the first place.
RCU read side is almost zero cost. So what is the point?

[...]

> Q) Why can't the page_ext is freed in the hot_remove path, where memmap
> is also freed ?
> 
> A) As per David's answers, there are many reasons and a few are:
> 1) Discussions had happened in the past to eventually also use rcu
> protection for handling pfn_to_online_page(). So doing it cleanly here
> is certainly an improvement.
> 
> 2) It's not good having to scatter section online checks all over the
> place in page ext code. Once there is a difference between active vs.
> stale page ext data things get a bit messy and error prone. This is
> already ugly enough in our generic memmap handling code.
> 
> 3) Having on-demand allocations, such as KASAN or page ext from the
> memory online notifier is at least currently cleaner, because we don't
> have to handle each and every subsystem that hooks into that during the
> core memory hotadd/remove phase, which primarily only setups the
> vmemmap, direct map and memory block devices.

I cannot say I agree with this reasoning but whatever.

Few more notes below

> [1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
> Changes in V2:
>    o Use only get/put_page_ext() to get the page_ext in the 
>      required paths. Add proper comments for them.
>    o Use synchronize_rcu() only once instead of calling it for
>      every mem_section::page_ext of a memory block.
>    o Free'd page_ext in 3 steps of invalidate, wait till all the
>      users are finished using and then finally free page_ext.
> 
> Changes in V1:
>    o Used the RCU lock while accessing the page_ext in the paths that
>      can race with the memory offline operation.
>    o Introduced (get|put)_page_ext() function to get the page_ext of page.
>    o https://lore.kernel.org/all/1657810063-28938-1-git-send-email-quic_charante@quicinc.com/
> 
>  include/linux/page_ext.h  | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/page_idle.h | 40 ++++++++++++++++++++++++++---------
>  mm/page_ext.c             | 41 ++++++++++++++++++++++++++++++++----
>  mm/page_owner.c           | 35 +++++++++++++++++++++++--------
>  mm/page_table_check.c     | 10 ++++++---
>  5 files changed, 153 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index fabb2e1..3a35c95 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -5,6 +5,7 @@
>  #include <linux/types.h>
>  #include <linux/stacktrace.h>
>  #include <linux/stackdepot.h>
> +#include <linux/rcupdate.h>
>  
>  struct pglist_data;
>  struct page_ext_operations {
> @@ -36,6 +37,8 @@ struct page_ext {
>  	unsigned long flags;
>  };
>  
> +#define PAGE_EXT_INVALID       (0x1)
> +
>  extern unsigned long page_ext_size;
>  extern void pgdat_page_ext_init(struct pglist_data *pgdat);
>  
> @@ -57,6 +60,11 @@ static inline void page_ext_init(void)
>  
>  struct page_ext *lookup_page_ext(const struct page *page);
>  
> +static inline bool page_ext_invalid(struct page_ext *page_ext)
> +{
> +	return !page_ext || (((unsigned long)page_ext & PAGE_EXT_INVALID) == 1);
> +}
> +

No real reason to expose this into a header file. Nothing but page_ext.c
should know and care about this.

>  static inline struct page_ext *page_ext_next(struct page_ext *curr)
>  {
>  	void *next = curr;
> @@ -64,6 +72,37 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
>  	return next;
>  }
>  
> +/*
> + * This function gives proper page_ext of a memory section
> + * during race with the offline operation on a memory block
> + * this section falls into. Not using this function to get
> + * page_ext of a page, in code paths where extra refcount
> + * is not taken on that page eg: pfn walking, can lead to
> + * use-after-free access of page_ext.
> + */
> +static inline struct page_ext *page_ext_get(struct page *page)
> +{
> +	struct page_ext *page_ext;
> +
> +	rcu_read_lock();
> +	page_ext = lookup_page_ext(page);
> +	if (!page_ext) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +
> +	return page_ext;

If you make this an extern you can actually hide lookup_page_ext and
prevent from future bugs where people are using non serialized API
without realizing that.

[...]
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 3dc715d..404a2eb 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -211,15 +211,17 @@ struct page_ext *lookup_page_ext(const struct page *page)
>  {
>  	unsigned long pfn = page_to_pfn(page);
>  	struct mem_section *section = __pfn_to_section(pfn);
> +	struct page_ext *page_ext = READ_ONCE(section->page_ext);
> +

	WARN_ON_ONCE(!rcu_read_lock_held());

>  	/*
>  	 * The sanity checks the page allocator does upon freeing a
>  	 * page can reach here before the page_ext arrays are
>  	 * allocated when feeding a range of pages to the allocator
>  	 * for the first time during bootup or memory hotplug.
>  	 */
> -	if (!section->page_ext)
> +	if (page_ext_invalid(page_ext))
>  		return NULL;
> -	return get_entry(section->page_ext, pfn);
> +	return get_entry(page_ext, pfn);
>  }
>  
>  static void *__meminit alloc_page_ext(size_t size, int nid)
> @@ -298,9 +300,26 @@ static void __free_page_ext(unsigned long pfn)
>  	ms = __pfn_to_section(pfn);
>  	if (!ms || !ms->page_ext)
>  		return;
> -	base = get_entry(ms->page_ext, pfn);
> +
> +	base = READ_ONCE(ms->page_ext);
> +	if (page_ext_invalid(base))
> +		base = (void *)base - PAGE_EXT_INVALID;

All page_ext accesses should use the same fetched pointer including the
ms->page_ext check. Also page_ext_invalid _must_ be true here otherwise
something bad is going on so I would go with
	if (WARN_ON_ONCE(!page_ext_invalid(base)))
		return;
	base = (void *)base - PAGE_EXT_INVALID;

> +	WRITE_ONCE(ms->page_ext, NULL);
> +
> +	base = get_entry(base, pfn);
>  	free_page_ext(base);
> -	ms->page_ext = NULL;
> +}
> +
-- 
Michal Hocko
SUSE Labs
