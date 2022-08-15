Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713CA593146
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbiHOPGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiHOPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:06:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBACE1E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:06:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE31934625;
        Mon, 15 Aug 2022 15:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660575979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=utrJaRaymMRe3G+7juB8TSn2ZYM3faQ2hWK/cW5/8Ec=;
        b=U5a/tjkgHtP8Ql010G/Aeji7dj11jLlbIjqgZKYtwqShrsuiLYrwa7FIT+ZWGxPrx+JL0f
        a4h86m3vfwDRU/HmXbC8oHsNMWAO/SR2hajA7Ry5PS0HloPwbOmdjz6Im1gsLz1HZ2hHRD
        6IOTqjaXEPDr8yI5z3oPQ3G+996uqf4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D2D913A99;
        Mon, 15 Aug 2022 15:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RAMxIOtg+mKpcAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 15 Aug 2022 15:06:19 +0000
Date:   Mon, 15 Aug 2022 17:06:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        pasha.tatashin@soleen.com, sieberf@amazon.com, shakeelb@google.com,
        sjpark@amazon.de, dhowells@redhat.com, willy@infradead.org,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <Yvpg6odyDsXrjw5i@dhcp22.suse.cz>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-08-22 20:16:43, Charan Teja Kalla wrote:
[...]
> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> index fabb2e1..0e259da 100644
> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
[...]
> @@ -87,5 +83,14 @@ static inline void page_ext_init_flatmem_late(void)
>  static inline void page_ext_init_flatmem(void)
>  {
>  }
> +
> +static inline struct page *page_ext_get(struct page *page)

struct page_ext *

> +{
> +	return NULL;
> +}
> +
> +static inline void page_ext_put(void)
> +{
> +}
>  #endif /* CONFIG_PAGE_EXTENSION */
>  #endif /* __LINUX_PAGE_EXT_H */
[...]
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 3dc715d..91d7bd2 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -9,6 +9,7 @@
>  #include <linux/page_owner.h>
>  #include <linux/page_idle.h>
>  #include <linux/page_table_check.h>
> +#include <linux/rcupdate.h>
>  
>  /*
>   * struct page extension
> @@ -59,6 +60,10 @@
>   * can utilize this callback to initialize the state of it correctly.
>   */
>  
> +#ifdef CONFIG_SPARSEMEM
> +#define PAGE_EXT_INVALID       (0x1)
> +#endif
> +
>  #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
>  static bool need_page_idle(void)
>  {
> @@ -84,6 +89,7 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
>  unsigned long page_ext_size = sizeof(struct page_ext);
>  
>  static unsigned long total_usage;
> +static struct page_ext *lookup_page_ext(const struct page *page);
>  
>  static bool __init invoke_need_callbacks(void)
>  {
> @@ -125,6 +131,37 @@ static inline struct page_ext *get_entry(void *base, unsigned long index)
>  	return base + page_ext_size * index;
>  }
>  
> +/*
> + * This function gives proper page_ext of a memory section
> + * during race with the offline operation on a memory block
> + * this section falls into. Not using this function to get
> + * page_ext of a page, in code paths where extra refcount
> + * is not taken on that page eg: pfn walking, can lead to
> + * use-after-free access of page_ext.

I do not think this is really useful comment, it goes into way too much
detail about memory hotplug yet not enough to actually understand the
interaction because there are no references to the actual
synchronization scheme. I would go with something like:

/*
 * Get a page_ext associated with the given page. Returns NULL if
 * no such page_ext exists otherwise ensures that the page_ext will
 * stay alive until page_ext_put is called.
 * This implies a non-sleeping context.
 */
> + */
> +struct page_ext *page_ext_get(struct page *page)
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
> +}
> +
> +/*
> + * Must be called after work is done with the page_ext received
> + * with page_ext_get().
> + */
> +
> +void page_ext_put(void)
> +{
> +	rcu_read_unlock();
> +}

Thinking about this some more I am not sure this is a good interface. It
doesn't have any reference to the actual object this is called for. This
is nicely visible in __folio_copy_owner which just calles page_ext_put()
twice because there are 2 page_exts and I can already see how somebody
might get confused this is just an error and send a patch to drop one of
them.

I do understand why you went this way because having a parameter which
is not used will likely lead to the same situation. On the other hand it
could be annotated to not raise warnings. One potential way to
workaround that would be

void page_ext_put(struct page_ext *page_ext)
{
	if (unlikely(!page_ext))
		return;
	
	rcu_read_unlock();
}

which would help to make the api slightly more robust in case somebody
does page_ext_put in a branch where page_ext_get returns NULL.

No strong opinion on that though. WDYI?

>  #ifndef CONFIG_SPARSEMEM
>  
>  
[...]
> @@ -183,19 +184,26 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>  noinline void __set_page_owner(struct page *page, unsigned short order,
>  					gfp_t gfp_mask)
>  {
> -	struct page_ext *page_ext = lookup_page_ext(page);
> +	struct page_ext *page_ext = page_ext_get(page);
>  	depot_stack_handle_t handle;
>  
>  	if (unlikely(!page_ext))
>  		return;

Either add a comment like this
	/* save_stack can sleep in general so we have to page_ext_put */
> +	page_ext_put();
>  
>  	handle = save_stack(gfp_mask);

or just drop the initial page_ext_get altogether. This function is
called only when page_ext is supposed to be initialized and !page_ext
case above should be very unlikely. Or is there any reason to keep this?

> +
> +	/* Ensure page_ext is valid after page_ext_put() above */
> +	page_ext = page_ext_get(page);
> +	if (unlikely(!page_ext))
> +		return;
>  	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
> +	page_ext_put();
>  }
>  
[...]
> @@ -558,13 +590,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  		 */
>  		handle = READ_ONCE(page_owner->handle);
>  		if (!handle)
> -			continue;
> +			goto loop;
>  
>  		/* Record the next PFN to read in the file offset */
>  		*ppos = (pfn - min_low_pfn) + 1;
>  
> +		memcpy(&page_owner_tmp, page_owner, sizeof(struct page_owner));
> +		page_ext_put();

why not
		page_owner_tmp = *page_owner;

>  		return print_page_owner(buf, count, pfn, page,
> -				page_owner, handle);
> +				&page_owner_tmp, handle);
> +loop:
> +		page_ext_put();
>  	}
>  
>  	return 0;

Otherwise looks good to me.

Thanks!
-- 
Michal Hocko
SUSE Labs
