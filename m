Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF46F523A34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbiEKQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbiEKQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA00141602
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652286166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hiwl13S5NM3HM0W7mWp+8TFZzRfSH80QjmVZsWuPHhc=;
        b=Pkwb6vkfY6mfikR32UmqN+iGQD8R4UW4b2Jt7eHMoYhueTzariRjqvaPVqES9mjq/Uiq6+
        DJoQ5tW37GMP9Aly+My90fYAx4YQXbpcUjFmAv7annj6/er8SnNElNIIFgQ237VhdcUR7Y
        YbIyggduoxiqe1q6zTR2rGeN4vQiETs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-ExhkFowQOXmwTulpvAZ4gw-1; Wed, 11 May 2022 12:22:44 -0400
X-MC-Unique: ExhkFowQOXmwTulpvAZ4gw-1
Received: by mail-wm1-f72.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so3054041wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Hiwl13S5NM3HM0W7mWp+8TFZzRfSH80QjmVZsWuPHhc=;
        b=cVNPoZbPtnI7gvVvC4cv0xLH004+AZKlPyI8Arh/GbcUzPlvxyBQMMlgkK6iQ0U5p+
         /SacoACoQj2bC0ODmctWjbSKw+6P7yfTXwYqH2IIdjeGVxQg7a1Fj3atewq635sj0H3M
         brECvGuZvTUArLFewwBTqo3FkpzaYQPege73dvYBQkArSu6bR1o5U4iZdM2e9+h1V28b
         qB1lfkpi2GBJr7OlyDzIHZdlEZtD99uyovIIaGwMApBUUm+eV6mrq3GIjBD1fggGUksz
         u7YcGUS4QihdCjJZYHb8Vrl7mj7mv2AuCRWtkA4P9+RWfNGMDvF45++8/PHfLe6OoYO1
         XITg==
X-Gm-Message-State: AOAM530oKssQlsNFdv5wlVdvCjWFadoKIUZc5Vl8oN29vPvmOjCLxd72
        G2ddrTl6X6d/J2rZl62MF2RYMXTiBeUFdr+5DxdxhFTz90CUx0vP2E6EDh9TwtGgKcZO+eHS8e2
        8mhpv/S2qnvev1c+xEULSbDS8
X-Received: by 2002:a5d:6d83:0:b0:20c:7329:7c36 with SMTP id l3-20020a5d6d83000000b0020c73297c36mr24141327wrs.518.1652286163460;
        Wed, 11 May 2022 09:22:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGO4vI4JoCaf4cPeuP3MYjvWKfYId+drtyvlVaFpOby8FpKOxVxJTFkMDVzBcR5zmEc6MJuw==
X-Received: by 2002:a5d:6d83:0:b0:20c:7329:7c36 with SMTP id l3-20020a5d6d83000000b0020c73297c36mr24141308wrs.518.1652286163200;
        Wed, 11 May 2022 09:22:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d48c8000000b0020c5253d907sm2036804wrs.83.2022.05.11.09.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:22:42 -0700 (PDT)
Message-ID: <6986a8dd-7211-fb4d-1d66-5b203cad1aab@redhat.com>
Date:   Wed, 11 May 2022 18:22:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
 <Ynjl4JmLXkA47U8T@localhost.localdomain>
 <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
 <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
 <20220511161052.GA224675@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
In-Reply-To: <20220511161052.GA224675@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.22 18:10, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, May 11, 2022 at 05:11:17PM +0200, David Hildenbrand wrote:
>> On 09.05.22 12:53, Miaohe Lin wrote:
>>> On 2022/5/9 17:58, Oscar Salvador wrote:
>>>> On Mon, May 09, 2022 at 05:04:54PM +0800, Miaohe Lin wrote:
>>>>>>> So that leaves us with either
>>>>>>>
>>>>>>> 1) Fail offlining -> no need to care about reonlining
>>>>>
>>>>> Maybe fail offlining will be a better alternative as we can get rid of many races
>>>>> between memory failure and memory offline? But no strong opinion. :)
>>>>
>>>> If taking care of those races is not an herculean effort, I'd go with
>>>> allowing offlining + disallow re-onlining.
>>>> Mainly because memory RAS stuff.
>>>
>>> This dose make sense to me. Thanks. We can try to solve those races if
>>> offlining + disallow re-onlining is applied. :)
>>>
>>>>
>>>> Now, to the re-onlining thing, we'll have to come up with a way to check
>>>> whether a section contains hwpoisoned pages, so we do not have to go
>>>> and check every single page, as that will be really suboptimal.
>>>
>>> Yes, we need a stable and cheap way to do that.
>>
>> My simplistic approach would be a simple flag/indicator in the memory block devices
>> that indicates that any page in the memory block was hwpoisoned. It's easy to
>> check that during memory onlining and fail it.
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 084d67fd55cc..3d0ef812e901 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -183,6 +183,9 @@ static int memory_block_online(struct memory_block *mem)
>>         struct zone *zone;
>>         int ret;
>>  
>> +       if (mem->hwpoisoned)
>> +               return -EHWPOISON;
>> +
>>         zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
>>                                   start_pfn, nr_pages);
>>  
> 
> Thanks for the idea, a simple flag could work if we don't have to consider
> unpoison.  If we need consider unpoison, we need remember the last hwpoison
> page in the memory block, so mem->hwpoisoned should be the counter of
> hwpoison pages.

Right, but unpoisoning+memory offlining+memory onlining is a yet more
extreme use case we don't have to bother about I think.

> 
>>
>>
>> Once the problematic DIMM would actually get unplugged, the memory block devices
>> would get removed as well. So when hotplugging a new DIMM in the same
>> location, we could online that memory again.
> 
> What about PG_hwpoison flags?  struct pages are also freed and reallocated
> in the actual DIMM replacement?

Once memory is offline, the memmap is stale and is no longer
trustworthy. It gets reinitialize during memory onlining -- so any
previous PG_hwpoison is overridden at least there. In some setups, we
even poison the whole memmap via page_init_poison() during memory offlining.

Apart from that, we should be freeing the memmap in all relevant cases
when removing memory. I remember there are a couple of corner cases, but
we don't really have to care about that.

-- 
Thanks,

David / dhildenb

