Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4D05AAAD6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiIBJEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiIBJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6656EA61CC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662109471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paxwFROiQn9wOtjKP9jQhB8HGgVytBOJmG9Pfk5FrI8=;
        b=Ym7QC7urelg04VilciKN2ySDVCwsYyn3c0r5pboX/r4+eY8jp/RjOJJ5xfsD39EeZ0Ai2v
        xWpbBg5NBgFyJstmDyhwZMg/0VYc/Ss47IbkoyCgK5G8sgzryAbe6Qavhiw0XhLWT41fD3
        CDuw8yfn/WcrIeeqYf1n7jrkqneshsQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-319-mfPD1UO0MDmeXy6N3EmjQw-1; Fri, 02 Sep 2022 05:04:30 -0400
X-MC-Unique: mfPD1UO0MDmeXy6N3EmjQw-1
Received: by mail-wm1-f72.google.com with SMTP id j19-20020a05600c1c1300b003ab73e4c45dso282339wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=paxwFROiQn9wOtjKP9jQhB8HGgVytBOJmG9Pfk5FrI8=;
        b=uTiFso8/+XuL3Hua7eBcGFE/5xKJJIl1ynVp+Ww1SEIwciECZVZTuOOSRvBCdb4oa6
         ggp/XKt2iM78mPxrUS7eV+bwFIO4ExSfp5x71yQWyH2qjs3F1HCOdADES3eVAxZc+nt0
         9cqC6YoUIMpLwSsqnZAJZ6XBJAnpf9e2YULlEaC3apLmNOThLZcjk0tsffoP3GLjIUQH
         vobd+vmAMGxi4iml5wP9F2WFyP40yRbpPE453uY1fWA3NY6gJyS+iQNieqA5371sw9k9
         GHPvhHyHYjxn+4QQdDffswBt5rTOKXEPjGEGJX6D6mRFwiEai9E/qn6WMrFJfkiZbwvo
         HqOw==
X-Gm-Message-State: ACgBeo3OFB7H3Dn1XJaxgjlMgeWHjwrnQS1J8H/8YN2YR1ohlmVuDB/J
        wRwMYj7fB+e9d39sU5J4yAhUMrc1sAr/E645TtAKrQHmfkG6wRbf3ymxElO6JRKPT5p8gaK2E86
        39eDf3yx5TIM/+fB517jS7qMh
X-Received: by 2002:a5d:47a8:0:b0:226:f124:ad74 with SMTP id 8-20020a5d47a8000000b00226f124ad74mr5404359wrb.18.1662109469324;
        Fri, 02 Sep 2022 02:04:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7o0F14ZjvEQ5J/Rss8luacwzgiVxFd0EhKqD9UZ3nWybxgIF5Tgqi1IhueaMgSHkye0kMBjw==
X-Received: by 2002:a5d:47a8:0:b0:226:f124:ad74 with SMTP id 8-20020a5d47a8000000b00226f124ad74mr5404340wrb.18.1662109469068;
        Fri, 02 Sep 2022 02:04:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:4800:2077:1bf6:40e7:2833? (p200300cbc714480020771bf640e72833.dip0.t-ipconnect.de. [2003:cb:c714:4800:2077:1bf6:40e7:2833])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003a5ca627333sm7456722wmc.8.2022.09.02.02.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 02:04:28 -0700 (PDT)
Message-ID: <2e7945e5-b0b0-bc44-c5eb-48d67532f78f@redhat.com>
Date:   Fri, 2 Sep 2022 11:04:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] mm: add pageblock_aligned() macro
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
References: <20220902064751.17890-1-wangkefeng.wang@huawei.com>
 <20220902064751.17890-2-wangkefeng.wang@huawei.com>
 <e0405abb-d1ea-977b-6d16-859a56bf3027@redhat.com>
 <79d05f57-8b3a-2450-43bf-f45de53a8c8e@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <79d05f57-8b3a-2450-43bf-f45de53a8c8e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.09.22 11:02, Kefeng Wang wrote:
> 
> On 2022/9/2 16:42, David Hildenbrand wrote:
>> On 02.09.22 08:47, Kefeng Wang wrote:
>>> Add pageblock_aligned() and use it to simplify code.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>> [...]
>>
>>> -	unsigned long nr_pgmask = pageblock_nr_pages - 1;
>>>  	int nid = zone_to_nid(zone);
>>>  	unsigned long nr_pages = 0;
>>>  	int zid = zone_idx(zone);
>>> @@ -1977,7 +1974,7 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
>>>  		if (!deferred_pfn_valid(pfn)) {
>>>  			page = NULL;
>>>  			continue;
>>> -		} else if (!page || !(pfn & nr_pgmask)) {
>> I didn't sleep too well this night and am tired, please tell me why I'm
>> wrong :)
> Wish you have a good reset :)

Thanks, the headache isn't helping :D

>> "pfn & (pageblock_nr_pages - 1)" is true if the pageblock is not aligned
>>
>> E.g., pfn = 1, pageblock_nr_pages = 512
>>
>> pfn & (pageblock_nr_pages - 1)
>> -> 1 & (512 - 1)
>> -> 1 & 511
>> -> true
>>
>> "!(pfn & (pageblock_nr_pages - 1))" is true if the pageblock is aligned
>> -> !(true)
>> -> false
>>
>>
>> However, "!pageblock_aligned(1)" = true
>>
>>
>>> +		} else if (!page || !pageblock_aligned(pfn)) {
> 
> pageblock_aligned(pfn) IS_ALIGNED((unsigned long)(pfn), pageblock_nr_pages)
> 
> #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0) (((pfn) &
> (pageblock_nr_pages - 1)) == 0) -> ((1 & 512 -1) == 0) -> ((1 & 511) ==
> 0) -> ((511) == 0) -> false
> right ? 

yes ... and inverting that would give you "true", which is not what we want?


Again, sorry if I'm wrong ...

-- 
Thanks,

David / dhildenb

