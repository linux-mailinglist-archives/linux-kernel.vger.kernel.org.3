Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF9F46BA0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhLGL10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:27:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbhLGL1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638876234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74Y/qtU/NzDU9JVs7Ek3lFSv5mYSLDKoIQSdar7thHY=;
        b=YnUdDAJuBkLR0ibV7xfys33/qbL4QPQDRUDQAri+guwVGEnxTHNwUhBdixmIY6UNtJjFGd
        AUK9tcz8u/ZiH14pQqvPth3uX/m2GTJ6arTzApZV9GGZPAlkOJc3jwKZCtwGUnn9r6r/+L
        gkhzlf3t9Hbfy8OXrSscmPTcsOyOzbI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-VH0XQdK2NYqFGawqdMv5rw-1; Tue, 07 Dec 2021 06:23:53 -0500
X-MC-Unique: VH0XQdK2NYqFGawqdMv5rw-1
Received: by mail-wr1-f71.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so2845427wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 03:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=74Y/qtU/NzDU9JVs7Ek3lFSv5mYSLDKoIQSdar7thHY=;
        b=LOZL+yztLEvXNj7LUjlKp2PzjPcv1jzV0qkvgMRRamydbGSkB1f2Mntg8svb3uQfjP
         C4uw+jgRh7zu4X6ZC2a7TFvivvEsjOasz9UnwYdOyAfolVjV8pbMzRTTGgeUhmPVZkoy
         rbEH/F6HN4YJZcgIOkJK3NekxvntONTvP331ciV4jcEpfybWIVHY01TuCAweYWBe2u8e
         vlWgDD3F8j+kYTh1DRXTCboMvrvFnrWGIXCkfEeJpVqZ4KMxu50jfz3VbsYkJ0xiWo+c
         e/NL2djsLNOtCFUycVty1oG8NPqrIb481cBt08stQZuihjrBPiAxSapA1fdmJF0NEqFr
         r2TQ==
X-Gm-Message-State: AOAM530OaBQCxhtY1JfKDyhRwicjkP4rgKl/gm7Ea4ta/YGP8j5AtrFM
        wfHtatUxnp5NnPjXg7Cub4MLLEQZ9uAvYmde2KyuS6xSVUbgxElP0HmZlTCVJOm7wojIFMLf2Cn
        41UGfc++H0ltPh8Tv4ztAfmUK
X-Received: by 2002:adf:cc91:: with SMTP id p17mr50686244wrj.589.1638876232690;
        Tue, 07 Dec 2021 03:23:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKIzi4kWo76ww2Twy+VEhA0j7bpmm1UW47vyNKvMbdvSJtbaj5TVX1rWh7uHf3WXLePL+RQg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr50686211wrj.589.1638876232461;
        Tue, 07 Dec 2021 03:23:52 -0800 (PST)
Received: from [192.168.3.132] (p4ff23e57.dip0.t-ipconnect.de. [79.242.62.87])
        by smtp.gmail.com with ESMTPSA id k37sm2365944wms.21.2021.12.07.03.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 03:23:51 -0800 (PST)
Message-ID: <0a9bc228-21ba-abe3-d9c8-b9d52b936366@redhat.com>
Date:   Tue, 7 Dec 2021 12:23:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RESEND v2 3/5] mm_zone: add function to check if managed
 dma zone exists
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-4-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211207030750.30824-4-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.21 04:07, Baoquan He wrote:
> In some places of the current kernel, it assumes that dma zone must have
> managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
> E.g in kdump kernel of x86_64, only low 1M is presented and locked down
> at very early stage of boot, so that there's no managed pages at all in
> DMA zone. This exception will always cause page allocation failure if page
> is requested from DMA zone.
> 
> Here add function has_managed_dma() and the relevant helper functions to
> check if there's DMA zone with managed pages. It will be used in later
> patches.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/mmzone.h | 21 +++++++++++++++++++++
>  mm/page_alloc.c        | 11 +++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 58e744b78c2c..82d23e13e0e5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -998,6 +998,18 @@ static inline bool zone_is_zone_device(struct zone *zone)
>  }
>  #endif
>  
> +#ifdef CONFIG_ZONE_DMA
> +static inline bool zone_is_dma(struct zone *zone)
> +{
> +	return zone_idx(zone) == ZONE_DMA;
> +}
> +#else
> +static inline bool zone_is_dma(struct zone *zone)
> +{
> +	return false;
> +}
> +#endif
> +
>  /*
>   * Returns true if a zone has pages managed by the buddy allocator.
>   * All the reclaim decisions have to use this function rather than
> @@ -1046,6 +1058,7 @@ static inline int is_highmem_idx(enum zone_type idx)
>  #endif
>  }
>  
> +bool has_managed_dma(void);
>  /**
>   * is_highmem - helper function to quickly check if a struct zone is a
>   *              highmem zone or not.  This is an attempt to keep references
> @@ -1131,6 +1144,14 @@ extern struct zone *next_zone(struct zone *zone);
>  			; /* do nothing */		\
>  		else
>  
> +#define for_each_managed_zone(zone)		        \
> +	for (zone = (first_online_pgdat())->node_zones; \
> +	     zone;					\
> +	     zone = next_zone(zone))			\
> +		if (!managed_zone(zone))		\
> +			; /* do nothing */		\
> +		else
> +
>  static inline struct zone *zonelist_zone(struct zoneref *zoneref)
>  {
>  	return zoneref->zone;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..ac0ea42a4e5f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9459,4 +9459,15 @@ bool take_page_off_buddy(struct page *page)
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  	return ret;
>  }
> +
> +bool has_managed_dma(void)
> +{
> +	struct zone *zone;
> +
> +	for_each_managed_zone(zone) {
> +		if (zone_is_dma(zone))
> +			return true;
> +	}
> +	return false;
> +}

Wouldn't it be "easier/faster" to just iterate online nodes and directly
obtain the ZONE_DMA, checking if there are managed pages?


-- 
Thanks,

David / dhildenb

