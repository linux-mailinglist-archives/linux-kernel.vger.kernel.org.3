Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B3557379
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiFWHDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiFWHDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:03:24 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70C243AE2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:03:23 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 184so18282098pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aw6abvU+RPzbpQ8yEGTaFOYy5BKz6zLvhQlXywKJAts=;
        b=21tn1zwaXhP0ni7W1wrOh//pEXWMkviVafEg0WOvGlHNk+RbUMN4MF/wvq9kmiim68
         tj0BJgSvhCXNbmSkSDbCs1nm5ug3sW6IW+NXRJ3Veh/eTWUxC5aVbdXyPbXZswq8MXsd
         FdyM4XC08GIB4CDLUZFifoNxZ1Eyi/XPAZFiz3V6kX19HH5w6KBHMC2blBfI8YOM7dLk
         +aU6lF6AOpZC27jlnEQGGBsVVVo/YAihTpOF76TfhTzUq3JPpmgY5hlgOOhKxQFPGqUW
         ECdn3kUIXXx/WMkCUIaJAUi4iOSwHq3VCi+b4shJ4BDnf/0qjA1EIntzauMAezBrOL2o
         XIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aw6abvU+RPzbpQ8yEGTaFOYy5BKz6zLvhQlXywKJAts=;
        b=p/UBXeMU6cHBgSmqdE+MpQzmVD86QpC8cEDTij/8vkh19pH4CKYea9T07aXPPILU9F
         eRAhG95q5KClLBgwMiP7AXivZqQZBqir01EcbGAkdw1jWNcsYuz1DCl5NnHNwjSKZrOw
         FmM20t5kTu/C7FLHZKnv93mETDe3+TS6jz/P1h2hT5af/Ughg+8g2M1WDDnwCpwLNJ8w
         sgwiWO0cRiC0K4sKwabXS4WekYDObgsS5cTfOEic+Io/IU4k4bsdIydNDPRUeWzR2rDO
         j3+t+qXAcrhzHX0RqqGqCfZusIDtUrMou6jL0qE8cMV0bCxffugSAdq3eSE+Tcx7RKXy
         bDXg==
X-Gm-Message-State: AJIora93XfOASTHeNTujutqs/l4Ec39zOBrDTzznk1ubyeQAzzF8lF+u
        /xEboKDOPYTl89TUL9lcGwC/1RvW/1D6iiuvYI4=
X-Google-Smtp-Source: AGRyM1uD5dXjR9FOuAYlSZOsFirIagjIw4HW8RiDBf7Bfm4Lodi0/bba/WnFntnJWaDIMstTpr1sWQ==
X-Received: by 2002:a05:6a00:1584:b0:51c:7932:975a with SMTP id u4-20020a056a00158400b0051c7932975amr39474941pfk.80.1655967803360;
        Thu, 23 Jun 2022 00:03:23 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id y21-20020a056a00191500b005252867671esm5485715pfi.66.2022.06.23.00.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 00:03:23 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:03:18 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] mm/huge_memory: add helper
 __get_deferred_split_queue
Message-ID: <YrQQNs42R519/P8X@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-14-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-14-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:24AM +0800, Miaohe Lin wrote:
> Add helper __get_deferred_split_queue to remove the duplicated codes of
> getting ds_queue. No functional change intended.
>

Sorry, I suggest dropping this change since I have reworked the code here [1].

[1] https://lore.kernel.org/all/20220621125658.64935-7-songmuchun@bytedance.com/

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0030b4f67cd9..de8155ff584c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -555,25 +555,23 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>  	return pmd;
>  }
>  
> -#ifdef CONFIG_MEMCG
> -static inline struct deferred_split *get_deferred_split_queue(struct page *page)
> +static inline struct deferred_split *__get_deferred_split_queue(struct pglist_data *pgdat,
> +								struct mem_cgroup *memcg)
>  {
> -	struct mem_cgroup *memcg = page_memcg(compound_head(page));
> -	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
> -
> +#ifdef CONFIG_MEMCG
>  	if (memcg)
>  		return &memcg->deferred_split_queue;
> -	else
> -		return &pgdat->deferred_split_queue;
> +#endif
> +	return &pgdat->deferred_split_queue;
>  }
> -#else
> +
>  static inline struct deferred_split *get_deferred_split_queue(struct page *page)
>  {
> +	struct mem_cgroup *memcg = page_memcg(compound_head(page));
>  	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
>  
> -	return &pgdat->deferred_split_queue;
> +	return __get_deferred_split_queue(pgdat, memcg);
>  }
> -#endif
>  
>  void prep_transhuge_page(struct page *page)
>  {
> @@ -2774,31 +2772,22 @@ void deferred_split_huge_page(struct page *page)
>  static unsigned long deferred_split_count(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
> -	struct pglist_data *pgdata = NODE_DATA(sc->nid);
> -	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
> +	struct deferred_split *ds_queue;
>  
> -#ifdef CONFIG_MEMCG
> -	if (sc->memcg)
> -		ds_queue = &sc->memcg->deferred_split_queue;
> -#endif
> +	ds_queue = __get_deferred_split_queue(NODE_DATA(sc->nid), sc->memcg);
>  	return READ_ONCE(ds_queue->split_queue_len);
>  }
>  
>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
> -	struct pglist_data *pgdata = NODE_DATA(sc->nid);
> -	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
> +	struct deferred_split *ds_queue;
>  	unsigned long flags;
>  	LIST_HEAD(list), *pos, *next;
>  	struct page *page;
>  	int split = 0;
>  
> -#ifdef CONFIG_MEMCG
> -	if (sc->memcg)
> -		ds_queue = &sc->memcg->deferred_split_queue;
> -#endif
> -
> +	ds_queue = __get_deferred_split_queue(NODE_DATA(sc->nid), sc->memcg);
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	/* Take pin on all head pages to avoid freeing them under us */
>  	list_for_each_safe(pos, next, &ds_queue->split_queue) {
> -- 
> 2.23.0
> 
> 
