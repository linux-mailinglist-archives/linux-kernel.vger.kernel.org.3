Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501D755DD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiF0J0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiF0J0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:26:07 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECBE3893
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:26:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so8860336pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GGeBluyzMDwWankcz62ov0eFQh/t+XNNYdmJUdK00kc=;
        b=I1FBRQPObR8tvLZSuWPHPHhMSKLpHFe935G5RK8uJlgh3bcuYEoSz2ZPFje+q4B06k
         ZIMCOV3FIQdB+Aa2Ejbllj19bg8WVwBoLhfY7bvtRkYhkk1D4vJFr8PTVhgGnOrI5rsP
         5NhfScSNpwaY7SM6GeAcKMr3nHxP9Y3cwbC9bx0Avkqzd+3WAqlHwxvMULqpbHupZ0xM
         9/JEDEDCaBdLinJTJeM8KiFL0+QUbhOzZoJ21EXv2/Dt2sWgd6LDBHo4VNEsvunC7K7w
         MMbWISgt3EhbINVso0GWN4LAumFryKn0egi5dse5rS8wJgVC99SIxZrhHPDxdCCQJ+Z9
         vVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GGeBluyzMDwWankcz62ov0eFQh/t+XNNYdmJUdK00kc=;
        b=GvxSyf/cUg12lg1NqRw9EoZvO5D0va8XtBTlrZ892XqDfDtPmdl7IZrp+QjUTxqbn7
         zIE8iQ0i5j0+iYH4+3C4wedqUcigkec8bAStKvgNtdfkcZd/NjTHDU2BjzQ+8hnbXiUe
         UVAD1vLQna6vwnlGEwdfDYb/dcrw8VtYlU2Agoos9I9h8DC0i/2umpZ1RgDs+uDgMUMu
         2S+2Hoe5Jij2XgysRUHS1khgWljuXLNb69H49TVQWizjEz38gtsoTHtKb1sCDsHBVZ9a
         ldn4Fo7jbdkyslxqmC4VYSPrBTFSqyGj8kucBgs5a4AAz1Wnmxdy01JP77nhk7dyab7+
         RIAQ==
X-Gm-Message-State: AJIora+lo9CxhMUxhPIqiNj5ZeFaX/TqIHNhcB3aJHVl+fJRaWZrL/Zm
        IfEMlwoQGlAEGhhFcuQeOQtRgW9Mj8ykBT+/
X-Google-Smtp-Source: AGRyM1vUpMIAY+Vwo3Z/n9ye7+l7vDRNdBdHTqp1j8ZJZHS9i2Q+Bb8HT2TMMsJKEfs+ULYo22YBCA==
X-Received: by 2002:a17:90b:4b81:b0:1ec:adbe:3b0b with SMTP id lr1-20020a17090b4b8100b001ecadbe3b0bmr14901779pjb.147.1656321965491;
        Mon, 27 Jun 2022 02:26:05 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id bf7-20020a170902b90700b00165105518f6sm6667324plb.287.2022.06.27.02.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:26:05 -0700 (PDT)
Date:   Mon, 27 Jun 2022 17:26:01 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] mm, hwpoison, hugetlb: support saving mechanism
 of raw error pages
Message-ID: <Yrl3qT3V6s9pLuvr@FVFYT0MHHV2J.usts.net>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-5-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623235153.2623702-5-naoya.horiguchi@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 08:51:48AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When handling memory error on a hugetlb page, the error handler tries to
> dissolve and turn it into 4kB pages.  If it's successfully dissolved,
> PageHWPoison flag is moved to the raw error page, so that's all right.
> However, dissolve sometimes fails, then the error page is left as
> hwpoisoned hugepage. It's useful if we can retry to dissolve it to save
> healthy pages, but that's not possible now because the information about
> where the raw error pages is lost.
> 
> Use the private field of a few tail pages to keep that information.  The
> code path of shrinking hugepage pool uses this info to try delayed dissolve.
> In order to remember multiple errors in a hugepage, a singly-linked list
> originated from SUBPAGE_INDEX_HWPOISON-th tail page is constructed.  Only
> simple operations (adding an entry or clearing all) are required and the
> list is assumed not to be very long, so this simple data structure should
> be enough.
> 
> If we failed to save raw error info, the hwpoison hugepage has errors on
> unknown subpage, then this new saving mechanism does not work any more,
> so disable saving new raw error info and freeing hwpoison hugepages.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks for your work on this. I have several quesions below.

> ---
> v1 -> v2:
> - support hwpoison hugepage with multiple errors,
> - moved the new interface functions to mm/memory-failure.c,
> - define additional subpage index SUBPAGE_INDEX_HWPOISON_UNRELIABLE,
> - stop freeing/dissolving hwpoison hugepages with unreliable raw error info,
> - drop hugetlb_clear_page_hwpoison() in dissolve_free_huge_page() because
>   that's done in update_and_free_page(),
> - move setting/clearing PG_hwpoison flag to the new interfaces,
> - checking already hwpoisoned or not on a subpage basis.
> 
> ChangeLog since previous post on 4/27:
> - fixed typo in patch description (by Miaohe)
> - fixed config value in #ifdef statement (by Miaohe)
> - added sentences about "multiple hwpoison pages" scenario in patch
>   description
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  include/linux/hugetlb.h | 13 ++++++
>  mm/hugetlb.c            | 39 +++++++++--------
>  mm/memory-failure.c     | 95 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 125 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e4cff27d1198..ac13c2022517 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -42,6 +42,10 @@ enum {
>  	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
>  	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
>  	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
> +#endif
> +#ifdef CONFIG_MEMORY_FAILURE
> +	SUBPAGE_INDEX_HWPOISON,
> +	SUBPAGE_INDEX_HWPOISON_UNRELIABLE,
>  #endif
>  	__NR_USED_SUBPAGE,
>  };
> @@ -798,6 +802,15 @@ extern int dissolve_free_huge_page(struct page *page);
>  extern int dissolve_free_huge_pages(unsigned long start_pfn,
>  				    unsigned long end_pfn);
>  
> +#ifdef CONFIG_MEMORY_FAILURE
> +extern int hugetlb_clear_page_hwpoison(struct page *hpage);
> +#else
> +static inline int hugetlb_clear_page_hwpoison(struct page *hpage)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>  #ifndef arch_hugetlb_migration_supported
>  static inline bool arch_hugetlb_migration_supported(struct hstate *h)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b7ae5f73f3b2..19ef427aa1e8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1541,17 +1541,15 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
>  
> -	if (hugetlb_vmemmap_alloc(h, page)) {
> -		spin_lock_irq(&hugetlb_lock);
> -		/*
> -		 * If we cannot allocate vmemmap pages, just refuse to free the
> -		 * page and put the page back on the hugetlb free list and treat
> -		 * as a surplus page.
> -		 */
> -		add_hugetlb_page(h, page, true);
> -		spin_unlock_irq(&hugetlb_lock);
> -		return;
> -	}
> +	if (hugetlb_vmemmap_alloc(h, page))
> +		goto fail;
> +
> +	/*
> +	 * Move PageHWPoison flag from head page to the raw error pages,
> +	 * which makes any healthy subpages reusable.
> +	 */
> +	if (unlikely(PageHWPoison(page) && hugetlb_clear_page_hwpoison(page)))
> +		goto fail;
>  
>  	for (i = 0; i < pages_per_huge_page(h);
>  	     i++, subpage = mem_map_next(subpage, page, i)) {
> @@ -1572,6 +1570,16 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>  	} else {
>  		__free_pages(page, huge_page_order(h));
>  	}
> +	return;
> +fail:
> +	spin_lock_irq(&hugetlb_lock);
> +	/*
> +	 * If we cannot allocate vmemmap pages or cannot identify raw hwpoison
> +	 * subpages reliably, just refuse to free the page and put the page
> +	 * back on the hugetlb free list and treat as a surplus page.
> +	 */
> +	add_hugetlb_page(h, page, true);
> +	spin_unlock_irq(&hugetlb_lock);
>  }
>  
>  /*
> @@ -2115,15 +2123,6 @@ int dissolve_free_huge_page(struct page *page)
>  		 */
>  		rc = hugetlb_vmemmap_alloc(h, head);
>  		if (!rc) {
> -			/*
> -			 * Move PageHWPoison flag from head page to the raw
> -			 * error page, which makes any subpages rather than
> -			 * the error page reusable.
> -			 */
> -			if (PageHWPoison(head) && page != head) {
> -				SetPageHWPoison(page);
> -				ClearPageHWPoison(head);
> -			}
>  			update_and_free_page(h, head, false);
>  		} else {
>  			spin_lock_irq(&hugetlb_lock);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index fb3feb1f363e..af571fa6f2af 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1499,6 +1499,97 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>  }
>  
>  #ifdef CONFIG_HUGETLB_PAGE
> +/*
> + * Struct raw_hwp_page represents information about "raw error page",
> + * constructing singly linked list originated from ->private field of
> + * SUBPAGE_INDEX_HWPOISON-th tail page.
> + */
> +struct raw_hwp_page {
> +	struct llist_node node;
> +	struct page *page;
> +};
> +
> +static inline struct llist_head *raw_hwp_list_head(struct page *hpage)
> +{
> +	return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
> +}
> +
> +static inline int raw_hwp_unreliable(struct page *hpage)
> +{
> +	return page_private(hpage + SUBPAGE_INDEX_HWPOISON_UNRELIABLE);
> +}
> +
> +static inline void set_raw_hwp_unreliable(struct page *hpage)
> +{
> +	set_page_private(hpage + SUBPAGE_INDEX_HWPOISON_UNRELIABLE, 1);
> +}

Why not use HPAGEFLAG(HwpoisonUnreliable, hwpoison_unreliable) directly?

> +
> +/*
> + * about race consideration
> + */
> +static inline int hugetlb_set_page_hwpoison(struct page *hpage,
> +					struct page *page)
> +{
> +	struct llist_head *head;
> +	struct raw_hwp_page *raw_hwp;
> +	struct llist_node *t, *tnode;
> +	int ret;
> +
> +	/*
> +	 * Once the hwpoison hugepage has lost reliable raw error info,
> +	 * there is little mean to keep additional error info precisely,
> +	 * so skip to add additional raw error info.
> +	 */
> +	if (raw_hwp_unreliable(hpage))
> +		return -EHWPOISON;
> +	head = raw_hwp_list_head(hpage);
> +	llist_for_each_safe(tnode, t, head->first) {
> +		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
> +
> +		if (p->page == page)
> +			return -EHWPOISON;
> +	}
> +
> +	ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
> +	/* the first error event will be counted in action_result(). */
> +	if (ret)
> +		num_poisoned_pages_inc();
> +
> +	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_KERNEL);

This function can be called in atomic context, GFP_ATOMIC should be used
here.

> +	if (raw_hwp) {
> +		raw_hwp->page = page;
> +		llist_add(&raw_hwp->node, head);

The maximum amount of items in the list is one, right?

> +	} else {
> +		/*
> +		 * Failed to save raw error info.  We no longer trace all
> +		 * hwpoisoned subpages, and we need refuse to free/dissolve
> +		 * this hwpoisoned hugepage.
> +		 */
> +		set_raw_hwp_unreliable(hpage);
> +		return ret;
> +	}
> +	return ret;
> +}
> +
> +inline int hugetlb_clear_page_hwpoison(struct page *hpage)
> +{
> +	struct llist_head *head;
> +	struct llist_node *t, *tnode;
> +
> +	if (raw_hwp_unreliable(hpage))
> +		return -EBUSY;

IIUC, we use head page's PageHWPoison to synchronize hugetlb_clear_page_hwpoison()
and hugetlb_set_page_hwpoison(), right? If so, who can set hwp_unreliable here?

> +	ClearPageHWPoison(hpage);
> +	head = raw_hwp_list_head(hpage);
> +	llist_for_each_safe(tnode, t, head->first) {

Is it possible that a new item is added hugetlb_set_page_hwpoison()  and we do not
traverse it (we have cleared page's PageHWPoison)? Then we ignored a real hwpoison
page, right?

> +		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
> +
> +		SetPageHWPoison(p->page);
> +		kfree(p);
> +	}
> +	llist_del_all(head);

If the above issue exists, moving ClearPageHWPoison(hpage) to here could
fix it. We should clear PageHWPoison carefully since the head page is
also can be poisoned.

Thanks.

> +	return 0;
> +}
> +
>  /*
>   * Called from hugetlb code with hugetlb_lock held.
>   *
> @@ -1533,7 +1624,7 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  		goto out;
>  	}
>  
> -	if (TestSetPageHWPoison(head)) {
> +	if (hugetlb_set_page_hwpoison(head, page)) {
>  		ret = -EHWPOISON;
>  		goto out;
>  	}
> @@ -1585,7 +1676,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  	lock_page(head);
>  
>  	if (hwpoison_filter(p)) {
> -		ClearPageHWPoison(head);
> +		hugetlb_clear_page_hwpoison(head);
>  		res = -EOPNOTSUPP;
>  		goto out;
>  	}
> -- 
> 2.25.1
> 
> 
