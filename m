Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB9C59E476
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiHWNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiHWNLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D356134219
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661249461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4DDfGD38WyRMUhL0albSNaRv3lQW2wKYEOnaNdTLlA=;
        b=c9NMoBmWnZX8eJoEMyTxYtUVgh2CJDJpY+xJtq7gKPIJhnFANeF33i1foZpQPrci95FurT
        ux1SumiGKPU9yTXPYXL5kyqq1e00zSFnbuSGkT8Siu5W9MVba0t7+erJnqtEpU97lauVHH
        zLDyYoPu0Twr5QuRZuj4QcKrtpnH/K4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-332-UDb1Xf3FNg6XC55QYse4Rw-1; Tue, 23 Aug 2022 06:07:07 -0400
X-MC-Unique: UDb1Xf3FNg6XC55QYse4Rw-1
Received: by mail-wm1-f71.google.com with SMTP id j22-20020a05600c485600b003a5e4420552so10018475wmo.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=k4DDfGD38WyRMUhL0albSNaRv3lQW2wKYEOnaNdTLlA=;
        b=GEZG3PQ7tTxlSXBCKw8PYE0r1BvtstMo3jkeLT/wcEEtb0Kd9bawS/cu8E7fZWmvy3
         QRgq93jgm31EeY52QdwyzBKwDavCYliXC4miffcx2/TXkukfnDIa5A4EU/PrcdFca4Lh
         1gcvvQsgo9LLj80fO1LbPMm7MZLu5hkekjimw1a7YYcW8iUXBZNrzcj9KIQ2/fMPMTgM
         YMF2DBx+ZOUXYlJ1hVAA99ICBSYQGw0usVSMa3PUfARzKd9+DxN+Z/U4di5iclIP2LUh
         eCqqjD8l1gknS29QFRK8GtQ17E1d5LIqnF3YbA1R1hWLwPWV6JWVzXowxoimS3fczNGn
         YMPA==
X-Gm-Message-State: ACgBeo0mCb9GdQTsZRQpzbLAiYLf/F1ua5cYu1St7/EvV+YZU8NMLHoa
        n2IF5lOSMyQNsu41TcUdAA5dOG8NjZ4uoEWP7NMi0toZYy0heKPs0Tt5MvtnjZysA+ClmTNKyZM
        1PRHRAlhHyp9vDgvlmCG5SmUb
X-Received: by 2002:a5d:6d04:0:b0:225:5a6e:7607 with SMTP id e4-20020a5d6d04000000b002255a6e7607mr4838249wrq.336.1661249226029;
        Tue, 23 Aug 2022 03:07:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5QgVeo9aZdJeSZeBsNU1jnzRMWXtJejk8Sr/CiqW3Vo9vVh/mkrE/ytXRvpg0xCMGSkVRjEw==
X-Received: by 2002:a5d:6d04:0:b0:225:5a6e:7607 with SMTP id e4-20020a5d6d04000000b002255a6e7607mr4838230wrq.336.1661249225685;
        Tue, 23 Aug 2022 03:07:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b003a5c244fc13sm21831085wml.2.2022.08.23.03.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:07:05 -0700 (PDT)
Message-ID: <36925544-8127-fe0c-76e5-49138dff45ae@redhat.com>
Date:   Tue, 23 Aug 2022 12:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Haiyue Wang <haiyue.wang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, apopple@nvidia.com,
        ying.huang@intel.com, songmuchun@bytedance.com,
        naoya.horiguchi@linux.dev, alex.sierra@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-3-haiyue.wang@intel.com>
 <f9bb1faf-3e09-2db4-5210-4cea09654452@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f9bb1faf-3e09-2db4-5210-4cea09654452@huawei.com>
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

On 17.08.22 04:34, Miaohe Lin wrote:
> On 2022/8/16 10:21, Haiyue Wang wrote:
>> The handling Non-LRU pages returned by follow_page() jumps directly, it
>> doesn't call put_page() to handle the reference count, since 'FOLL_GET'
>> flag for follow_page() has get_page() called. Fix the zone device page
>> check by handling the page reference count correctly before returning.
>>
>> And as David reviewed, "device pages are never PageKsm pages". Drop this
>> zone device page check for break_ksm().
>>
>> Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
>> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 
> Thanks for your fixing. LGTM with one nit below. But I have no strong opinion on it.
> So with or without fixing below nit:
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
>> ---
>>  mm/huge_memory.c |  4 ++--
>>  mm/ksm.c         | 12 +++++++++---
>>  mm/migrate.c     | 19 ++++++++++++-------
>>  3 files changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 8a7c1b344abe..b2ba17c3dcd7 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2963,10 +2963,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>>  		/* FOLL_DUMP to ignore special (like zero) pages */
>>  		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>>  
>> -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
>> +		if (IS_ERR_OR_NULL(page))
>>  			continue;
>>  
>> -		if (!is_transparent_hugepage(page))
>> +		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
> 
> !is_transparent_hugepage should already do the work here? IIRC, zone_device_page can't be
> a transhuge page anyway. And only transparent_hugepage is cared here.

I agree.

Can we avoid sending a new version of a patch series as reply to another
patch series (previous version)?


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

