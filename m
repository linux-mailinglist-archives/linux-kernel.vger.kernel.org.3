Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA154F215
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380656AbiFQHjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380606AbiFQHje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1630674D9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655451572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+5SsZD18lshkaJTIGXbLP4b4u9kGlHi/piJMfKgDzY=;
        b=ET6ibx+2rM/9AJf+Kq59as8D+Dmb0StqL9cdf4iZKCj8q7vKqJWxZ31k+ejVWy5xl+d50W
        Fx8aGK62GxrxfksLy2zPrIgZbm/ZY5BYKEyjzcEKZT/N6l3lMikQCsH9rINu4RT7OADLIQ
        upo1b7oQLghz0q902QS6hjL2Xf8cN9Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-b7ojr2BnMDKroeNd8vvemQ-1; Fri, 17 Jun 2022 03:39:30 -0400
X-MC-Unique: b7ojr2BnMDKroeNd8vvemQ-1
Received: by mail-wr1-f69.google.com with SMTP id e21-20020adfa455000000b0021b80b12356so200226wra.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3+5SsZD18lshkaJTIGXbLP4b4u9kGlHi/piJMfKgDzY=;
        b=2ih83nS4P85NGouVVBgab2H/7uyWI6vbXCM0rbnc6XWOxsIJfjbAbK1uEXBFNfWJIs
         FTf4DgAYmzzhh3B1C9AfQSpvSvHXtxtkzCe0HI53ZJd1HU2U4vYh2SEiXLXrhqN4woMQ
         jSywN79kpqqhmZZ3A1gu2p0tMM7A/wMCDjupFTFTD+Cp0s0d5b8jLyo4oXHZh55Td2Xz
         IMzgEe35qWrUIksxaUfsAKU7lS0Wudql2fyFxaJniqN4M7UT8V9pORrgpEeqe40NZDwF
         tDnJcajOMYU1JYVQwyWcv9+RbmIwYlu2d8HcKcQZVD42fAnZp81RHaFTWHbpKAmlz4qv
         32Ug==
X-Gm-Message-State: AJIora+rjfmYWiVd5CyEObCsJhQ3D4RM03bH7NFypXbMSAXOi1tiQBGL
        4N3oKI6X/UeoRZeyjuRrbMW3InQrb7Z9oLce6KLstexjfKCcN+rUL+PK6deHygmEx+yZeRCB7AH
        QTbVCdnkDq4VK3k6k+c9dn4sl
X-Received: by 2002:a05:6000:1446:b0:218:5a5d:6cb5 with SMTP id v6-20020a056000144600b002185a5d6cb5mr7894932wrx.629.1655451569407;
        Fri, 17 Jun 2022 00:39:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOXholaP7tYyWm5CZMrTvW0X9DDD/xBPQEaFSdwM9qdJGWAdTNqg6dY1Q7JtEhufau2RKJsw==
X-Received: by 2002:a05:6000:1446:b0:218:5a5d:6cb5 with SMTP id v6-20020a056000144600b002185a5d6cb5mr7894909wrx.629.1655451569140;
        Fri, 17 Jun 2022 00:39:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:7e00:bb5b:b526:5b76:5824? (p200300cbc70a7e00bb5bb5265b765824.dip0.t-ipconnect.de. [2003:cb:c70a:7e00:bb5b:b526:5b76:5824])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b0039c4506bd25sm5300383wmb.14.2022.06.17.00.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:39:28 -0700 (PDT)
Message-ID: <79a1ca29-de8e-6456-460b-a9099340fec4@redhat.com>
Date:   Fri, 17 Jun 2022 09:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqqPjkh9r8ZrH0r@localhost.localdomain>
 <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
 <YqwVTT+50vt5WpeG@localhost.localdomain>
 <YqwtCu2Ura+skV3B@FVFYT0MHHV2J.usts.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YqwtCu2Ura+skV3B@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.22 09:28, Muchun Song wrote:
> On Fri, Jun 17, 2022 at 07:46:53AM +0200, Oscar Salvador wrote:
>> On Thu, Jun 16, 2022 at 09:30:33AM +0200, David Hildenbrand wrote:
>>> IIRC, that was used to skip these patches on the offlining path before
>>> we provided the ranges to offline_pages().
>>
>> Yeah, it was designed for that purpose back then.
>>
>>> I'd not mess with PG_reserved, and give them a clearer name, to not
>>> confuse them with other, ordinary, vmemmap pages that are not
>>> self-hosted (maybe in the future we might want to flag all vmemmap pages
>>> with a new type?).
>>
>> Not sure whether a new type is really needed, or to put it another way, I
>> cannot see the benefit.
>>
>>>
>>> I'd just try reusing the flag PG_owner_priv_1. And eventually, flag all
>>> (v)memmap pages with a type PG_memmap. However, the latter would be
>>> optional and might not be strictly required
>>>
>>>
>>> So what think could make sense is
>>>
>>> /* vmemmap pages that are self-hosted and cannot be optimized/freed. */
>>> PG_vmemmap_self_hosted = PG_owner_priv_1,
>>
>> Sure, I just lightly tested the below, and seems to work, but not sure
>> whether that is what you are referring to.
>> @Munchun: thoughts?
>>
> 
> I think it works and fits my requirement.
> 
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index e66f7aa3191d..a4556afd7bda 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -193,6 +193,11 @@ enum pageflags {
>>  
>>  	/* Only valid for buddy pages. Used to track pages that are reported */
>>  	PG_reported = PG_uptodate,
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +	/* For self-hosted memmap pages */
>> +	PG_vmemmap_self_hosted = PG_owner_priv_1,
>> +#endif
>>  };
>>  
>>  #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
>> @@ -628,6 +633,10 @@ PAGEFLAG_FALSE(SkipKASanPoison, skip_kasan_poison)
>>   */
>>  __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
>>  
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +PAGEFLAG(Vmemmap_self_hosted, vmemmap_self_hosted, PF_ANY)
>> +#endif
>> +
>>  /*
>>   * On an anonymous page mapped into a user virtual memory area,
>>   * page->mapping points to its anon_vma, not to a struct address_space;
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 1089ea8a9c98..e2de7ed27e9e 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -101,6 +101,14 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
>>  {
>>  	unsigned long vmemmap_addr = (unsigned long)head;
>>  	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
>> +	struct mem_section *ms = __pfn_to_section(page_to_pfn(head));
>> +	struct page *memmap;
>> +
>> +	memmap = sparse_decode_mem_map(ms->section_mem_map,
>> +				       pfn_to_section_nr(page_to_pfn(head)));
>> +
>> +	if (PageVmemmap_self_hosted(memmap))
>> +		return;
> 
> I think here needs a loop if it is a 1GB page (spans multiple sections).
> Right?  Here is an implementation based on another approach. But I think
> your implementation is more simpler and efficient.  Would you mind me
> squash your diff into my patch and with your "Co-developed-by"?

Due to hugtlb alignment requirements, and the vmemmap pages being at the
start of the hotplugged memory region, I think that cannot currently
happen. Checking the first vmemmap page might be good enough for now,
and probably for the future.

-- 
Thanks,

David / dhildenb

