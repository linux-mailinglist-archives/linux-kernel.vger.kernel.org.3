Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743FC4EC553
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbiC3NQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344304AbiC3NQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACD702FFFE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648646088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldezc9GK3QLkJKuWMQhPgYUN/ziZJCuKDduMpDPTgac=;
        b=emGF+PUqS8xbuG/al2Chln071JwVy95OLtSyubSOvayZuICqTGvL06WXX3B+5kQ6a6e8Pv
        tUg2t8U9rvHqwB2EeQhhuEXmtBS+xiY/aP3GdlxvojNl2vIBCpjnRI5k5lRShy780r2vCI
        I6aSTcE0W5xRW3m7gMfFW9uJkj6Sd+Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-yPfonb3mPUuvm8Zswtt61g-1; Wed, 30 Mar 2022 09:14:47 -0400
X-MC-Unique: yPfonb3mPUuvm8Zswtt61g-1
Received: by mail-wm1-f70.google.com with SMTP id c126-20020a1c3584000000b00380dee8a62cso7901321wma.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ldezc9GK3QLkJKuWMQhPgYUN/ziZJCuKDduMpDPTgac=;
        b=i1Mcz2P6epGLzPwHNRil+J5ZkRMVvIY99cWIVABaHqKnFW7CZQfpny3X0w2q/hvj4C
         tG1FrSW8SB8zWC0aaJY25LOmS8/k2vO3gojNljZC/mcVUo7awm+VzUctbhNWF3hD8605
         m07KbxOOsbFbIXGU+yUMAOhtgnkUKgzIxxKuw3lqOc/7veBuhW7rib7QKQkXvQafnMIc
         HC0w4BiI5OwKb9ZpXYPUYZGUNQPjk7kJurm9Qx01WOmrqzg3znwiOyuAuLJGr95pd1P1
         HTvTV1BrcPb5gxaBA+AshZhEjJAttfaruJdxOeJCuQWVptKvWoo8yEAHBz6JwVTXL8Pr
         RWDQ==
X-Gm-Message-State: AOAM531cr9ulTCAc+QWX/TxiNjqiw7WycJmIIsUyI8ACvnHp6o7IkceM
        n0Poj9XeoX1ANoFTB45Lg+FXEU48bZjqEWOQc6RlD8BWtxbKigYlRyoIzsuOcInQt0dYKa3arfx
        p7MfoLqIdQ/pbRMD7awcL+65P
X-Received: by 2002:adf:ec04:0:b0:205:8537:af5c with SMTP id x4-20020adfec04000000b002058537af5cmr35250511wrn.357.1648646085674;
        Wed, 30 Mar 2022 06:14:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycL6xQGmW2GqfiTku9O+trJ1+RLopcuDW1jwFCh03mQc+leccCBpVASZhSVjleB7q+OdHkgw==
X-Received: by 2002:adf:ec04:0:b0:205:8537:af5c with SMTP id x4-20020adfec04000000b002058537af5cmr35250495wrn.357.1648646085406;
        Wed, 30 Mar 2022 06:14:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2200:178b:7244:2a1f:b5d8? (p200300cbc7052200178b72442a1fb5d8.dip0.t-ipconnect.de. [2003:cb:c705:2200:178b:7244:2a1f:b5d8])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0038e389ab62esm1998504wms.9.2022.03.30.06.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 06:14:44 -0700 (PDT)
Message-ID: <57639524-b930-c31b-196b-bafae8c4e374@redhat.com>
Date:   Wed, 30 Mar 2022 15:14:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/2] mm: fix contiguous memmap assumptions about split
 page
Content-Language: en-US
To:     Chen Wandun <chenwandun@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org
References: <20220330102534.1053240-1-chenwandun@huawei.com>
 <20220330102534.1053240-2-chenwandun@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220330102534.1053240-2-chenwandun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.22 12:25, Chen Wandun wrote:
> It isn't true for only SPARSEMEM configs to assume that a compound page
> has virtually contiguous page structs, so use nth_page to iterate each
> page.

Is this actually a "fix" or rather a preparation for having very large
compound pages (>= MAX_ORDER) that we'd be able to split?

Naive me would think that we'd currently only have order < MAX_ORDER,
and consequently would always fall into a single memory section where
the memmap is contiguous.

> 
> Inspired by:
> https://lore.kernel.org/linux-mm/20220204195852.1751729-8-willy@infradead.org/
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/compaction.c  | 6 +++---
>  mm/huge_memory.c | 2 +-
>  mm/page_alloc.c  | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c3e37aa9ff9e..ddff13b968a2 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -87,7 +87,7 @@ static unsigned long release_freepages(struct list_head *freelist)
>  static void split_map_pages(struct list_head *list)
>  {
>  	unsigned int i, order, nr_pages;
> -	struct page *page, *next;
> +	struct page *page, *next, *tmp;
>  	LIST_HEAD(tmp_list);
>  
>  	list_for_each_entry_safe(page, next, list, lru) {
> @@ -101,8 +101,8 @@ static void split_map_pages(struct list_head *list)
>  			split_page(page, order);
>  
>  		for (i = 0; i < nr_pages; i++) {
> -			list_add(&page->lru, &tmp_list);
> -			page++;
> +			tmp = nth_page(page, i);
> +			list_add(&tmp->lru, &tmp_list);
>  		}
>  	}
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2fe38212e07c..d77fc2ad581d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2297,7 +2297,7 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>  static void __split_huge_page_tail(struct page *head, int tail,
>  		struct lruvec *lruvec, struct list_head *list)
>  {
> -	struct page *page_tail = head + tail;
> +	struct page *page_tail = nth_page(head, tail);
>  
>  	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f648decfe39d..855211dea13e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3513,7 +3513,7 @@ void split_page(struct page *page, unsigned int order)
>  	VM_BUG_ON_PAGE(!page_count(page), page);
>  
>  	for (i = 1; i < (1 << order); i++)
> -		set_page_refcounted(page + i);
> +		set_page_refcounted(nth_page(page, i));
>  	split_page_owner(page, 1 << order);
>  	split_page_memcg(page, 1 << order);
>  }


-- 
Thanks,

David / dhildenb

