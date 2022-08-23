Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7791D59E837
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245600AbiHWQ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245719AbiHWQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0285140BD8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661261278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xEnBNd4+cIp13UQCQJVZGzjaWrbYja7AskgIKoRiLmQ=;
        b=Hhj9u7NyQ+3ELTBqUleP8l88wjccp1EKfbTp2ZlhZ4EAL6+cRXEf7koskR8NAx3pn4/f/p
        m8FMYjm7l+Uqq5yktRMi/EwiIfDZuGW94RWNGeYv9yV+j8Ev8XE2rzFLroUWMfN/IQID5d
        IMFIZ7GWLf5IX8mF4u62Nyw1Kt++thg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-148-2DrCs6gXPFKz18C8U2E6XA-1; Tue, 23 Aug 2022 09:27:56 -0400
X-MC-Unique: 2DrCs6gXPFKz18C8U2E6XA-1
Received: by mail-wr1-f72.google.com with SMTP id v27-20020adfa1db000000b002252854ec99so2223212wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=xEnBNd4+cIp13UQCQJVZGzjaWrbYja7AskgIKoRiLmQ=;
        b=s2Jp0IrE1Zaz/Azia0g3bPpXFVshm0opePBLECQD2btCsV6cHAu71WKQ8d3JHBV0qa
         r6Ntspc9I8nMJ9UcM8CLxa0KD8FjOdNdhlGR5e0jrytlhS49kbjcHDldmfEMKi36BR1m
         xEZF4IP8FoMfo5iA5C0Q9an8HFl0YkAA0oQq3YbuZ/zIl2kOzA+ikIKAuO6a+ijZh8M1
         sYEhfnzDj8S+KbbvnA4rJ5OXy2dC/8WaxxP/0d7b5EAP4dcJzEgoUfIULMOKO/3CO/2D
         YhMS4LGkr0omixF7zS3A2YyObX8xJ3frxSirsSvK8Vgh4BtpPZNUZA2eTFtfEGL1IYWa
         zBmw==
X-Gm-Message-State: ACgBeo0t5XjUSSs2HKwaswNm5ml9LK8CGH50UUPEQf1VDhVv+OP/wU59
        kfi2Eyodhz6LswZ+LRgVHiv5liGXujuq8p4ABJdrEcWdFXiyUNuKOF7nZmjiX32YRXeDlivqj2M
        SsBL9O1BNGbNqdGtgUjahGgYd
X-Received: by 2002:a05:600c:214d:b0:3a5:ce18:bb71 with SMTP id v13-20020a05600c214d00b003a5ce18bb71mr2314059wml.1.1661261275673;
        Tue, 23 Aug 2022 06:27:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5cTxOYtyt12dFDB/n905jeqB8HL8PdTX4iMu3IGDvk0bXNH/Hnnk6Ga8iSPemsrOsGCAwQrw==
X-Received: by 2002:a05:600c:214d:b0:3a5:ce18:bb71 with SMTP id v13-20020a05600c214d00b003a5ce18bb71mr2314040wml.1.1661261275387;
        Tue, 23 Aug 2022 06:27:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id k13-20020a7bc30d000000b003a5c75bd36fsm20997519wmj.10.2022.08.23.06.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 06:27:54 -0700 (PDT)
Message-ID: <1206b559-2917-2ce0-6c54-ec78727b826d@redhat.com>
Date:   Tue, 23 Aug 2022 15:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 2/2] mm: fix the handling Non-LRU pages returned by
 follow_page
Content-Language: en-US
To:     "Wang, Haiyue" <haiyue.wang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "naoya.horiguchi@linux.dev" <naoya.horiguchi@linux.dev>,
        "alex.sierra@amd.com" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
 <20220816022102.582865-1-haiyue.wang@intel.com>
 <20220816022102.582865-3-haiyue.wang@intel.com>
 <f9bb1faf-3e09-2db4-5210-4cea09654452@huawei.com>
 <36925544-8127-fe0c-76e5-49138dff45ae@redhat.com>
 <BYAPR11MB3495477AF580B94D1EA75108F7709@BYAPR11MB3495.namprd11.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <BYAPR11MB3495477AF580B94D1EA75108F7709@BYAPR11MB3495.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.22 15:26, Wang, Haiyue wrote:
>> -----Original Message-----
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Tuesday, August 23, 2022 18:07
>> To: Miaohe Lin <linmiaohe@huawei.com>; Wang, Haiyue <haiyue.wang@intel.com>; linux-mm@kvack.org;
>> linux-kernel@vger.kernel.org
>> Cc: akpm@linux-foundation.org; apopple@nvidia.com; Huang, Ying <ying.huang@intel.com>;
>> songmuchun@bytedance.com; naoya.horiguchi@linux.dev; alex.sierra@amd.com; Felix Kuehling
>> <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH v6 2/2] mm: fix the handling Non-LRU pages returned by follow_page
>>
>> On 17.08.22 04:34, Miaohe Lin wrote:
>>> On 2022/8/16 10:21, Haiyue Wang wrote:
>>>> The handling Non-LRU pages returned by follow_page() jumps directly, it
>>>> doesn't call put_page() to handle the reference count, since 'FOLL_GET'
>>>> flag for follow_page() has get_page() called. Fix the zone device page
>>>> check by handling the page reference count correctly before returning.
>>>>
>>>> And as David reviewed, "device pages are never PageKsm pages". Drop this
>>>> zone device page check for break_ksm().
>>>>
>>>> Fixes: 3218f8712d6b ("mm: handling Non-LRU pages returned by vm_normal_pages")
>>>> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
>>>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>
>>> Thanks for your fixing. LGTM with one nit below. But I have no strong opinion on it.
>>> So with or without fixing below nit:
>>>
>>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>>>
>>>> ---
>>>>  mm/huge_memory.c |  4 ++--
>>>>  mm/ksm.c         | 12 +++++++++---
>>>>  mm/migrate.c     | 19 ++++++++++++-------
>>>>  3 files changed, 23 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 8a7c1b344abe..b2ba17c3dcd7 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2963,10 +2963,10 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>>>>  		/* FOLL_DUMP to ignore special (like zero) pages */
>>>>  		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>>>>
>>>> -		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
>>>> +		if (IS_ERR_OR_NULL(page))
>>>>  			continue;
>>>>
>>>> -		if (!is_transparent_hugepage(page))
>>>> +		if (is_zone_device_page(page) || !is_transparent_hugepage(page))
>>>
>>> !is_transparent_hugepage should already do the work here? IIRC, zone_device_page can't be
>>> a transhuge page anyway. And only transparent_hugepage is cared here.
>>
>> I agree.
> 
> OK, will remove it in next version.
> 
>>
>> Can we avoid sending a new version of a patch series as reply to another
>> patch series (previous version)?
> 
> Don't use '--in-reply-to=' when running 'git send-email' ? 

Yes. That makes it easier top identify versions of patch series, without
having to dig down into an ever-growing thread.

-- 
Thanks,

David / dhildenb

