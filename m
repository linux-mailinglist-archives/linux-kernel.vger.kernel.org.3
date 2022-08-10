Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8258EB65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiHJLkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHJLkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:40:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A903B7F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:40:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB09E33BA5;
        Wed, 10 Aug 2022 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660131609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dM9/ujTiplP6+WzsM5l1rEl1RA+DReEehBMVWDO9Vio=;
        b=xlmur0cOgppaizuupXhA+25x7v76UozykStrcAKiocWxDlJP6DD9CxkZjwUuYrt7XooeFs
        Iroczxv86SYg0T7ZFPuCjDee1v4VVNNFQOcGqOwnsX9r4ash6zV/jjbhcjvrg2B+6fKIc1
        tZPv1q7p+zQ7Pe+o3pU52zTB/nEMRWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660131609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dM9/ujTiplP6+WzsM5l1rEl1RA+DReEehBMVWDO9Vio=;
        b=uEPatot73RTnQpTur6pVJrFAk7tsnuF3hvhxZWOHWvr4E0q8T3UwGfpj6+k6LfpQutXktD
        5AUriQ7z3hXEyhBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 946B513AB3;
        Wed, 10 Aug 2022 11:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tkQ0IxmZ82ImXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 10 Aug 2022 11:40:09 +0000
Message-ID: <f5fd4942-b03e-1d1c-213b-9cd5283ced91@suse.cz>
Date:   Wed, 10 Aug 2022 13:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        pasha.tatashin@soleen.com, sieberf@amazon.com, shakeelb@google.com,
        sjpark@amazon.de, dhowells@redhat.com, willy@infradead.org,
        quic_pkondeti@quicinc.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 16:46, Charan Teja Kalla wrote:
> The below is one path where race between page_ext and  offline of the
> respective memory blocks will cause use-after-free on the access of
> page_ext structure.
> 
> process1		              process2
> ---------                             ---------
> a)doing /proc/page_owner           doing memory offline
> 			           through offline_pages.
> 
> b)PageBuddy check is failed
> thus proceed to get the
> page_owner information
> through page_ext access.
> page_ext = lookup_page_ext(page);
> 
> 				    migrate_pages();
> 				    .................
> 				Since all pages are successfully
> 				migrated as part of the offline
> 				operation,send MEM_OFFLINE notification
> 				where for page_ext it calls:
> 				offline_page_ext()-->
> 				__free_page_ext()-->
> 				   free_page_ext()-->
> 				     vfree(ms->page_ext)
> 			           mem_section->page_ext = NULL
> 
> c) Check for the PAGE_EXT flags
> in the page_ext->flags access
> results into the use-after-free(leading
> to the translation faults).
> 
> As mentioned above, there is really no synchronization between page_ext
> access and its freeing in the memory_offline.
> 
> The memory offline steps(roughly) on a memory block is as below:
> 1) Isolate all the pages
> 2) while(1)
>    try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
> 3) delete the pages from this buddy list.
> 4) Then free page_ext.(Note: The struct page is still alive as it is
> freed only during hot remove of the memory which frees the memmap, which
> steps the user might not perform).
> 
> This design leads to the state where struct page is alive but the struct
> page_ext is freed, where the later is ideally part of the former which
> just representing the page_flags (check [3] for why this design is
> chosen).
> 
> The above mentioned race is just one example __but the problem persists
> in the other paths too involving page_ext->flags access(eg:
> page_is_idle())__. Since offline waits till the last reference on the
> page goes down i.e. any path that took the refcount on the page can make
> the memory offline operation to wait. Eg: In the migrate_pages()
> operation, we do take the extra refcount on the pages that are under
> migration and then we do copy page_owner by accessing page_ext.
> 
> Fix those paths where offline races with page_ext access by maintaining
> synchronization with rcu lock and is achieved in 3 steps:
> 1) Invalidate all the page_ext's of the sections of a memory block by
> storing a flag in the LSB of mem_section->page_ext.
> 
> 2) Wait till all the existing readers to finish working with the
> ->page_ext's with synchronize_rcu(). Any parallel process that starts
> after this call will not get page_ext, through lookup_page_ext(), for
> the block parallel offline operation is being performed.
> 
> 3) Now safely free all sections ->page_ext's of the block on which
> offline operation is being performed.
> 
> Note: If synchronize_rcu() takes time then optimizations can be done in
> this path through call_rcu()[2].
> 
> Thanks to David Hildenbrand for his views/suggestions on the initial
> discussion[1] and Pavan kondeti for various inputs on this patch.
> 
> [1] https://lore.kernel.org/linux-mm/59edde13-4167-8550-86f0-11fc67882107@quicinc.com/
> [2] https://lore.kernel.org/all/a26ce299-aed1-b8ad-711e-a49e82bdd180@quicinc.com/T/#u
> [3] https://lore.kernel.org/all/6fa6b7aa-731e-891c-3efb-a03d6a700efa@redhat.com/
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

<snip>

> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -141,7 +141,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>   	struct page_owner *page_owner;
>   	u64 free_ts_nsec = local_clock();
>   
> -	page_ext = lookup_page_ext(page);
> +	page_ext = page_ext_get(page);
>   	if (unlikely(!page_ext))
>   		return;
>   
> @@ -153,6 +153,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>   		page_owner->free_ts_nsec = free_ts_nsec;
>   		page_ext = page_ext_next(page_ext);
>   	}
> +	page_ext_put();
>   }
>   
>   static inline void __set_page_owner_handle(struct page_ext *page_ext,
> @@ -183,19 +184,26 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>   noinline void __set_page_owner(struct page *page, unsigned short order,
>   					gfp_t gfp_mask)
>   {
> -	struct page_ext *page_ext = lookup_page_ext(page);
> +	struct page_ext *page_ext = page_ext_get(page);
>   	depot_stack_handle_t handle;
>   
>   	if (unlikely(!page_ext))
>   		return;
> +	page_ext_put();
>   
>   	handle = save_stack(gfp_mask);
> +
> +	/* Ensure page_ext is valid after page_ext_put() above */
> +	page_ext = page_ext_get(page);

Why not simply do the save_stack() first and then page_ext_get() just 
once? It should be really rare that it's NULL, so I don't think we save 
much by avoiding an unnecessary save_stack(), while the overhead of 
doing two get/put instead of one will affect every call.

> +	if (unlikely(!page_ext))
> +		return;
>   	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
> +	page_ext_put();
>   }
>   
>   void __set_page_owner_migrate_reason(struct page *page, int reason)
>   {
> -	struct page_ext *page_ext = lookup_page_ext(page);
> +	struct page_ext *page_ext = page_ext_get(page);
>   	struct page_owner *page_owner;
>   
>   	if (unlikely(!page_ext))
> @@ -203,12 +211,13 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
>   
>   	page_owner = get_page_owner(page_ext);
>   	page_owner->last_migrate_reason = reason;
> +	page_ext_put();
>   }
>   
>   void __split_page_owner(struct page *page, unsigned int nr)
>   {
>   	int i;
> -	struct page_ext *page_ext = lookup_page_ext(page);
> +	struct page_ext *page_ext = page_ext_get(page);
>   	struct page_owner *page_owner;
>   
>   	if (unlikely(!page_ext))
> @@ -219,16 +228,24 @@ void __split_page_owner(struct page *page, unsigned int nr)
>   		page_owner->order = 0;
>   		page_ext = page_ext_next(page_ext);
>   	}
> +	page_ext_put();
>   }
>   
>   void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>   {
> -	struct page_ext *old_ext = lookup_page_ext(&old->page);
> -	struct page_ext *new_ext = lookup_page_ext(&newfolio->page);
> +	struct page_ext *old_ext;
> +	struct page_ext *new_ext;
>   	struct page_owner *old_page_owner, *new_page_owner;
>   
> -	if (unlikely(!old_ext || !new_ext))
> +	old_ext = page_ext_get(&old->page);
> +	if (unlikely(!old_ext))
> +		return;
> +
> +	new_ext = page_ext_get(&newfolio->page);

The second one can keep using just lookup_page_ext() and we can have a 
single page_ext_put()? I don't think it would be dangerous in case the 
internals change, as page_ext_put() doesn't have a page parameter anyway 
so it can't be specific to a page.

> +	if (unlikely(!new_ext)) {
> +		page_ext_put();
>   		return;
> +	}
>   
>   	old_page_owner = get_page_owner(old_ext);
>   	new_page_owner = get_page_owner(new_ext);
> @@ -254,6 +271,8 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>   	 */
>   	__set_bit(PAGE_EXT_OWNER, &new_ext->flags);
>   	__set_bit(PAGE_EXT_OWNER_ALLOCATED, &new_ext->flags);
> +	page_ext_put();
> +	page_ext_put();
>   }
>   
>   void pagetypeinfo_showmixedcount_print(struct seq_file *m,
> @@ -307,12 +326,12 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>   			if (PageReserved(page))
>   				continue;
>   
> -			page_ext = lookup_page_ext(page);
> +			page_ext = page_ext_get(page);
>   			if (unlikely(!page_ext))
>   				continue;
>   
>   			if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
> -				continue;
> +				goto loop;
>   
>   			page_owner = get_page_owner(page_ext);
>   			page_mt = gfp_migratetype(page_owner->gfp_mask);
> @@ -323,9 +342,12 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>   					count[pageblock_mt]++;
>   
>   				pfn = block_end_pfn;
> +				page_ext_put();
>   				break;
>   			}
>   			pfn += (1UL << page_owner->order) - 1;
> +loop:
> +			page_ext_put();
>   		}
>   	}
>   
> @@ -435,7 +457,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>   
>   void __dump_page_owner(const struct page *page)
>   {
> -	struct page_ext *page_ext = lookup_page_ext(page);
> +	struct page_ext *page_ext = page_ext_get((void *)page);
>   	struct page_owner *page_owner;
>   	depot_stack_handle_t handle;
>   	gfp_t gfp_mask;
> @@ -452,6 +474,7 @@ void __dump_page_owner(const struct page *page)
>   
>   	if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags)) {
>   		pr_alert("page_owner info is not present (never set?)\n");
> +		page_ext_put();
>   		return;
>   	}
>   
> @@ -482,6 +505,7 @@ void __dump_page_owner(const struct page *page)
>   	if (page_owner->last_migrate_reason != -1)
>   		pr_alert("page has been migrated, last migrate reason: %s\n",
>   			migrate_reason_names[page_owner->last_migrate_reason]);
> +	page_ext_put();
>   }
>   
>   static ssize_t
> @@ -508,6 +532,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   	/* Find an allocated page */
>   	for (; pfn < max_pfn; pfn++) {
>   		/*
> +		 * This temporary page_owner is required so
> +		 * that we can avoid the context switches while holding
> +		 * the rcu lock and copying the page owner information to
> +		 * user through copy_to_user() or GFP_KERNEL allocations.
> +		 */
> +		struct page_owner page_owner_tmp;
> +
> +		/*
>   		 * If the new page is in a new MAX_ORDER_NR_PAGES area,
>   		 * validate the area as existing, skip it if not
>   		 */
> @@ -525,7 +557,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   			continue;
>   		}
>   
> -		page_ext = lookup_page_ext(page);
> +		page_ext = page_ext_get(page);
>   		if (unlikely(!page_ext))
>   			continue;
>   
> @@ -534,14 +566,14 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   		 * because we don't hold the zone lock.
>   		 */
>   		if (!test_bit(PAGE_EXT_OWNER, &page_ext->flags))
> -			continue;
> +			goto loop;
>   
>   		/*
>   		 * Although we do have the info about past allocation of free
>   		 * pages, it's not relevant for current memory usage.
>   		 */
>   		if (!test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags))
> -			continue;
> +			goto loop;
>   
>   		page_owner = get_page_owner(page_ext);
>   
> @@ -550,7 +582,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   		 * would inflate the stats.
>   		 */
>   		if (!IS_ALIGNED(pfn, 1 << page_owner->order))
> -			continue;
> +			goto loop;
>   
>   		/*
>   		 * Access to page_ext->handle isn't synchronous so we should
> @@ -558,13 +590,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   		 */
>   		handle = READ_ONCE(page_owner->handle);
>   		if (!handle)
> -			continue;
> +			goto loop;
>   
>   		/* Record the next PFN to read in the file offset */
>   		*ppos = (pfn - min_low_pfn) + 1;
>   
> +		memcpy(&page_owner_tmp, page_owner, sizeof(struct page_owner));
> +		page_ext_put();
>   		return print_page_owner(buf, count, pfn, page,
> -				page_owner, handle);
> +				&page_owner_tmp, handle);
> +loop:
> +		page_ext_put();
>   	}
>   
>   	return 0;
> @@ -617,18 +653,20 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>   			if (PageReserved(page))
>   				continue;
>   
> -			page_ext = lookup_page_ext(page);
> +			page_ext = page_ext_get(page);
>   			if (unlikely(!page_ext))
>   				continue;
>   
>   			/* Maybe overlapping zone */
>   			if (test_bit(PAGE_EXT_OWNER, &page_ext->flags))
> -				continue;
> +				goto loop;
>   
>   			/* Found early allocated page */
>   			__set_page_owner_handle(page_ext, early_handle,
>   						0, 0);
>   			count++;
> +loop:
> +			page_ext_put();
>   		}
>   		cond_resched();

This is called from init_page_owner() where races with offline are 
impossible, so it's unnecessary. Although it won't hurt.



