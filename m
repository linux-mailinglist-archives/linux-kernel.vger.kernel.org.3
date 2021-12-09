Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C4E46E8D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhLINOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234153AbhLINOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639055429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HLYQrYTvDhJOhX5Nedd5N7Rr2EdTZuNtpoWym2CdMY=;
        b=ECKeRDqijIPpNAbtJLrdQk7Yd1YtverHIIRKa2i7UvNz2VqUx873L0B3maQzim+mgm6gJi
        /M9bhdqEs7QcZENuh8WNsPaXhyf1YAuyCwYNjG+oWiWXwmzJI2lxrElFQKMe+eGlqp4GX8
        eIzFoKYaahh4HySTJ0x/a8ghwCHdiQk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-UqH0bl6FMte7ocDMXH8ahw-1; Thu, 09 Dec 2021 08:10:28 -0500
X-MC-Unique: UqH0bl6FMte7ocDMXH8ahw-1
Received: by mail-wr1-f69.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso1397037wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 05:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=4HLYQrYTvDhJOhX5Nedd5N7Rr2EdTZuNtpoWym2CdMY=;
        b=s5FkwDUQu9+Jwxv33vOUEo6TdkPNhLyk2HQAddvn1Y2km6653kj4kt1Is2OhCUPUKA
         LV+9ASaP1hEApr7pwRJk8EeIULs9Yx4XYSaoALdJe2g/xHEDWn3t2rivk8MiMomuH/6l
         LGWgnZkaRAK3fhrsO3t1M9BZA/+B66X1SPQNcVt6vODctSorPs8iaevyJff0I9F+i3QZ
         eWlWl1oZwOXcBscAUIA5mTnVkjIdFb7TwjirupoaqshD2bG5jVSGNqjMl+Pa/GqBwU7f
         +5cOStuOWidbnwpwWsqWZV8DfTishg57uu1h/RAS/fu1I6WqsLf+k8c6uAKa7T+jYcrv
         Tp+g==
X-Gm-Message-State: AOAM531Jtc8ZPa8Rh4z7R9EtiCJQAYZfZYjnMGGmFjNVRcrYAgmKkL/P
        RuMXF7UBSBguJa68UAUAWU/KDd/OwIKzhzBtvvqRzEbwniC+eycSP2drgtRRzVPTwR8bm2W0zsM
        Av4BfQWxDDZQV0lS289JOUo1j
X-Received: by 2002:a1c:7e04:: with SMTP id z4mr7156667wmc.134.1639055427545;
        Thu, 09 Dec 2021 05:10:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrB5QtFpLgO2F74/dDZiIBur1ghv6Xdy5HbLQ6yvADLrjOQvdxb0Lke24kA67qhYJRwDXfWQ==
X-Received: by 2002:a1c:7e04:: with SMTP id z4mr7156624wmc.134.1639055427304;
        Thu, 09 Dec 2021 05:10:27 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ded.dip0.t-ipconnect.de. [79.242.61.237])
        by smtp.gmail.com with ESMTPSA id j40sm5732030wms.16.2021.12.09.05.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 05:10:26 -0800 (PST)
Message-ID: <a5e172db-2be9-c5bc-a43e-9e9a1fb2a69c@redhat.com>
Date:   Thu, 9 Dec 2021 14:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RESEND v2 3/5] mm_zone: add function to check if managed
 dma zone exists
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@lst.de, robin.murphy@arm.com,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-4-bhe@redhat.com>
 <0a9bc228-21ba-abe3-d9c8-b9d52b936366@redhat.com>
 <20211209130210.GB3050@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211209130210.GB3050@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.21 14:02, Baoquan He wrote:
> On 12/07/21 at 12:23pm, David Hildenbrand wrote:
>> On 07.12.21 04:07, Baoquan He wrote:
>>> In some places of the current kernel, it assumes that dma zone must have
>>> managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
>>> E.g in kdump kernel of x86_64, only low 1M is presented and locked down
>>> at very early stage of boot, so that there's no managed pages at all in
>>> DMA zone. This exception will always cause page allocation failure if page
>>> is requested from DMA zone.
>>>
>>> Here add function has_managed_dma() and the relevant helper functions to
>>> check if there's DMA zone with managed pages. It will be used in later
>>> patches.
>>>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>  include/linux/mmzone.h | 21 +++++++++++++++++++++
>>>  mm/page_alloc.c        | 11 +++++++++++
>>>  2 files changed, 32 insertions(+)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 58e744b78c2c..82d23e13e0e5 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -998,6 +998,18 @@ static inline bool zone_is_zone_device(struct zone *zone)
>>>  }
>>>  #endif
>>>  
>>> +#ifdef CONFIG_ZONE_DMA
>>> +static inline bool zone_is_dma(struct zone *zone)
>>> +{
>>> +	return zone_idx(zone) == ZONE_DMA;
>>> +}
>>> +#else
>>> +static inline bool zone_is_dma(struct zone *zone)
>>> +{
>>> +	return false;
>>> +}
>>> +#endif
>>> +
>>>  /*
>>>   * Returns true if a zone has pages managed by the buddy allocator.
>>>   * All the reclaim decisions have to use this function rather than
>>> @@ -1046,6 +1058,7 @@ static inline int is_highmem_idx(enum zone_type idx)
>>>  #endif
>>>  }
>>>  
>>> +bool has_managed_dma(void);
>>>  /**
>>>   * is_highmem - helper function to quickly check if a struct zone is a
>>>   *              highmem zone or not.  This is an attempt to keep references
>>> @@ -1131,6 +1144,14 @@ extern struct zone *next_zone(struct zone *zone);
>>>  			; /* do nothing */		\
>>>  		else
>>>  
>>> +#define for_each_managed_zone(zone)		        \
>>> +	for (zone = (first_online_pgdat())->node_zones; \
>>> +	     zone;					\
>>> +	     zone = next_zone(zone))			\
>>> +		if (!managed_zone(zone))		\
>>> +			; /* do nothing */		\
>>> +		else
>>> +
>>>  static inline struct zone *zonelist_zone(struct zoneref *zoneref)
>>>  {
>>>  	return zoneref->zone;
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index c5952749ad40..ac0ea42a4e5f 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -9459,4 +9459,15 @@ bool take_page_off_buddy(struct page *page)
>>>  	spin_unlock_irqrestore(&zone->lock, flags);
>>>  	return ret;
>>>  }
>>> +
>>> +bool has_managed_dma(void)
>>> +{
>>> +	struct zone *zone;
>>> +
>>> +	for_each_managed_zone(zone) {
>>> +		if (zone_is_dma(zone))
>>> +			return true;
>>> +	}
>>> +	return false;
>>> +}
>>
>> Wouldn't it be "easier/faster" to just iterate online nodes and directly
>> obtain the ZONE_DMA, checking if there are managed pages?
> 
> Thanks, Dave.
> 
> Please check for_each_managed_zone(), it is iterating online nodes and
> it's each managed zone. 
> 
> Is below what you are suggesting? The only difference is I introduced
> for_each_managed_zone() which can be reused later if needed. Not sure if
> I got your suggestion correctly.
> 
> bool has_managed_dma(void)
> {
>         struct pglist_data *pgdat;
>         struct zone *zone;
>         enum zone_type i, j;
> 
>         for_each_online_pgdat(pgdat) {
>                 for (i = 0; i < MAX_NR_ZONES - 1; i++) {          
>                         struct zone *zone = &pgdat->node_zones[i];
>                         if (zone_is_dma(zone))                                                                                                    
>                                 return true;
>                 }
>         }
>         return false;
> 
> }


Even simpler, no need to iterate over zones at all, only over nodes:

#ifdef CONFIG_ZONE_DMA
bool has_managed_dma(void)
{
	struct pglist_data *pgdat;

	for_each_online_pgdat(pgdat) {
		struct zone *zone = &pgdat->node_zones[ZONE_DMA];

		if (managed_zone(zone)
			return true;
	}
	return false;
}
#endif /* CONFIG_ZONE_DMA */

Without CONFIG_ZONE_DMA, simply provide a dummy in the header that
returns false.

-- 
Thanks,

David / dhildenb

