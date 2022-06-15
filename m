Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0C054CF83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356957AbiFOROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357979AbiFOROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:14:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC5D1A828
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:14:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so2741527pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NpbkGIIAT9U+dUlMWmDOrmdJZkG9VKb6160l0wJULSU=;
        b=IM78OQJNArX9cZ/L3qOPxd2HTvfuMrK0kXUFCb1vzwMzpsuFbJEfuerjHEhXIjdou/
         VLRZ+81OdjXf65hLqU2yr0HqMMRDEbiwhvpaOeRqErjLr9JOtY6RLyv39G81IXL03DS2
         OxmAHvbzanywYIaY9S/SQ9Rn9m1qFKN17n00KGmg3FrqQ+8xRp5MThDZSZHUsghju+p3
         SdPlLfMxnE8Jt/6rNKnO1GfW4WfFlZR6++e1JDYbNckLusfl2INx/7C4DLTail+GYf13
         mfxzeOjfN2GIp644lw4s5z0Tv90iwcGpXCUZF8og+YDWEcG2Obnc9uXZLgNAVK7rZzoX
         JNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NpbkGIIAT9U+dUlMWmDOrmdJZkG9VKb6160l0wJULSU=;
        b=an4ELncynPsQUypG3TvjM5Rym5ow5aV33qR/B62OK0C14VSPKLyuY4Ek1IjI2W3L3Q
         CzL6niJwDsAJB79vw9GzjOCq1FCtLbBDJGHONjS3k8RcD2JZ3PSRJUEuC3NqlGHJS9mL
         VioJXGMjrcs4HZFbFLXozkmOyUBsNG2h2VN+reBO4ysPGfuZsYrzbd3IR5eRuAGzHq0S
         HCCVP7Q4G5zB9pJbwJ9gZjVXrM2wPtofCjLUETaaF9f9hAwhDwTR/SdOH36jbbAlZlsj
         QTDfdpC8BkK+t8pS9zbWMAHXIMCnuYMKYpvC/V0BU6v80W2694H1UxepJF2u3S9Qy7nH
         adDw==
X-Gm-Message-State: AJIora+oKV3jSWWul6xLd9IJD0ervcKHgxCX8HPxC4ZQ97ObuxD5BODc
        3XY/Hz3Nt6SdG5ODWn7UdO2a0g==
X-Google-Smtp-Source: AGRyM1vyYhE47wnJ4w8exikqpAv43fy9wiWJLEqNdCJVP7Gs0YisdsJCe8kE464+tKvoj30lI4wFzw==
X-Received: by 2002:a17:903:234a:b0:167:997f:bc4c with SMTP id c10-20020a170903234a00b00167997fbc4cmr382877plh.120.1655313239421;
        Wed, 15 Jun 2022 10:13:59 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902778a00b0015e8d4eb282sm9565242pll.204.2022.06.15.10.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:13:58 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:13:55 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, aarcange@redhat.com,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm/khugepaged: try to free transhuge swapcache when
 possible
Message-ID: <YqoTU7SNM7d3MlNs@google.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-8-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611084731.55155-8-linmiaohe@huawei.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 16:47, Miaohe Lin wrote:
> Transhuge swapcaches won't be freed in __collapse_huge_page_copy().
> It's because release_pte_page() is not called for these pages and
> thus free_page_and_swap_cache can't grab the page lock. These pages
> won't be freed from swap cache even if we are the only user until
> next time reclaim. It shouldn't hurt indeed, but we could try to
> free these pages to save more memory for system.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swap.h | 5 +++++
>  mm/khugepaged.c      | 1 +
>  mm/swap.h            | 5 -----
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 8672a7123ccd..ccb83b12b724 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -456,6 +456,7 @@ static inline unsigned long total_swapcache_pages(void)
>  	return global_node_page_state(NR_SWAPCACHE);
>  }
>  
> +extern void free_swap_cache(struct page *page);
>  extern void free_page_and_swap_cache(struct page *);
>  extern void free_pages_and_swap_cache(struct page **, int);
>  /* linux/mm/swapfile.c */
> @@ -540,6 +541,10 @@ static inline void put_swap_device(struct swap_info_struct *si)
>  /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
>  #define free_swap_and_cache(e) is_pfn_swap_entry(e)
>  
> +static inline void free_swap_cache(struct page *page)
> +{
> +}
> +
>  static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
>  {
>  	return 0;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ee0a719c8be9..52109ad13f78 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -756,6 +756,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>  	list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
>  		list_del(&src_page->lru);
>  		release_pte_page(src_page);
> +		free_swap_cache(src_page);
>  	}
>  }

Aside: in __collapse_huge_page_isolate() (and also here) why can't we just check
PageCompound(page) && page == compound_head(page) to only act on compound pages
once? AFAIK this would alleviate this compound_pagelist business..

Anyways, as-is, free_page_and_swap_cache() won't be able to do
try_to_free_swap(), since it can't grab page lock, put it will call put_page().
I think (?) the last page ref might be dropped in release_pte_page(), so should
free_swap_cache() come before it?

>  
> diff --git a/mm/swap.h b/mm/swap.h
> index 0193797b0c92..863f6086c916 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct page *page,
>  void delete_from_swap_cache(struct page *page);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>  				  unsigned long end);
> -void free_swap_cache(struct page *page);
>  struct page *lookup_swap_cache(swp_entry_t entry,
>  			       struct vm_area_struct *vma,
>  			       unsigned long addr);
> @@ -81,10 +80,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
>  	return NULL;
>  }
>  
> -static inline void free_swap_cache(struct page *page)
> -{
> -}
> -
>  static inline void show_swap_cache_info(void)
>  {
>  }
> -- 
> 2.23.0
> 
> 
