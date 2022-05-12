Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE8524DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354043AbiELNAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354048AbiELM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1359C205F05
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652360397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2JrMfoThymsDO02MSeMolHmmTLKA88WsEI5m8LvBfg=;
        b=d9WKxxlWjzzeJlCNRq8ZhyOQbxTQ4DhHjEfFcgRwKflHKhAYvG5xyVZp377SMmlFH7UEIE
        bQegeuVGGbw+3cOd9O1mPRSPMeAUZDMmtlk4kVKLb52WQjDy6vYJJZYluEXlVD6G7zQ3Nx
        qdQEo53WhjSfNtr556yK/hHwvYstu9o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-t8SHahk5NmuD4JaIyN39Jw-1; Thu, 12 May 2022 08:59:56 -0400
X-MC-Unique: t8SHahk5NmuD4JaIyN39Jw-1
Received: by mail-wr1-f72.google.com with SMTP id v17-20020a056000163100b0020c9b0e9039so2022590wrb.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=D2JrMfoThymsDO02MSeMolHmmTLKA88WsEI5m8LvBfg=;
        b=Q/MuYrYp26dybIfQWPoCFx/zQezgSH2BAXDBDdai3KqGdtBx8Pa28JKwPX6kEAfan0
         5PLmo7TH66cqwe2P1CMwCukr8vglGihpJyUWdDthIYyYh6c8QertAGhM15hWIVw5RcmC
         dRaYrahJwC6vAuf72DuJ8wce84Q+VV3c7j2Y5b5zATSd60H9qvO3Ropqun1zm24gIJHF
         sun1KT6h/yzQXlWqoZKYMxWGP9LGRSYLRPSzrQkIqWy+SQQ+rRlT3KcmO8bp8hbRa+Ec
         As+lIIIaGq2ILP6Lq3rlndOLHtIuCUV1OfRz6hAJVwGtPEgE1IVxFO2Flr40DBKEqVr/
         qRNg==
X-Gm-Message-State: AOAM531T8dNLep2c9hNtJVgr2DmY9bfE7nZ/sCJwXvaTlvFYvw97irzJ
        TTrWg0UIBIK+odVke6a9drW/Ift5GLao1xnMAwz+QcBKKgfGQNvPthh+Pglm/iSGFbwiDOijgqs
        yGBhK7Z332Ago6ELtBun9PzYC
X-Received: by 2002:a05:6000:1f8c:b0:20c:b1cf:2a1c with SMTP id bw12-20020a0560001f8c00b0020cb1cf2a1cmr23720858wrb.368.1652360394725;
        Thu, 12 May 2022 05:59:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyySMI5uuaTZ6hmc801sCsEcJC5N3VFQ3C7b0bAj1U5wTE7Ujj17vGYQ4l/FuSvpYINJ5uSig==
X-Received: by 2002:a05:6000:1f8c:b0:20c:b1cf:2a1c with SMTP id bw12-20020a0560001f8c00b0020cb1cf2a1cmr23720846wrb.368.1652360394467;
        Thu, 12 May 2022 05:59:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c215100b003943558a976sm2796979wml.29.2022.05.12.05.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 05:59:53 -0700 (PDT)
Message-ID: <5b43d8f7-3477-a2c2-028e-e31d40ac932c@redhat.com>
Date:   Thu, 12 May 2022 14:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
 <Ynjl4JmLXkA47U8T@localhost.localdomain>
 <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
 <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
 <20220511161052.GA224675@hori.linux.bs1.fc.nec.co.jp>
 <6986a8dd-7211-fb4d-1d66-5b203cad1aab@redhat.com>
 <20220512063558.GA249122@hori.linux.bs1.fc.nec.co.jp>
 <c424e8a2-a771-e738-396c-24ac907b557f@redhat.com>
 <04781d15-9d87-1763-02fe-e353679c50d7@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
In-Reply-To: <04781d15-9d87-1763-02fe-e353679c50d7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.22 13:13, Miaohe Lin wrote:
> On 2022/5/12 15:28, David Hildenbrand wrote:
>>>>>>
>>>>>> Once the problematic DIMM would actually get unplugged, the memory block devices
>>>>>> would get removed as well. So when hotplugging a new DIMM in the same
>>>>>> location, we could online that memory again.
>>>>>
>>>>> What about PG_hwpoison flags?  struct pages are also freed and reallocated
>>>>> in the actual DIMM replacement?
>>>>
>>>> Once memory is offline, the memmap is stale and is no longer
>>>> trustworthy. It gets reinitialize during memory onlining -- so any
>>>> previous PG_hwpoison is overridden at least there. In some setups, we
>>>> even poison the whole memmap via page_init_poison() during memory offlining.
>>>>
>>>> Apart from that, we should be freeing the memmap in all relevant cases
>>>> when removing memory. I remember there are a couple of corner cases, but
>>>> we don't really have to care about that.
>>>
>>> OK, so there seems no need to manipulate struct pages for hwpoison in
>>> all relevant cases.
>>
>> Right. When offlining a memory block, all we have to do is remember if
>> we stumbled over a hwpoisoned page and rememebr that inside the memory
>> block. Rejecting to online is then easy.
> 
> BTW: How should we deal with the below race window:
> 
> CPU A			CPU B				CPU C
> accessing page while hold page refcnt
> 			memory_failure happened on page
> 							offline_pages
> 							  page can be offlined due to page refcnt
> 							  is ignored when PG_hwpoison is set
> can still access page struct...
> 
> Any in use page (with page refcnt incremented) might be offlined while its content, e.g. flags, private ..., can
> still be accessed if the above race happened. Is this possible? Or am I miss something? Any suggestion to fix it?
> I can't figure out a way yet. :(

I assume you mean that test_pages_isolated() essentially only checks for
PageHWPoison() and doesn't care about the refcount?

That part is very dodgy and it's part of my motivation to question that
whole handling in the first place.


In do_migrate_range(), there is a comment:

"
 HWPoison pages have elevated reference counts so the migration would
 fail on them. It also doesn't make any sense to migrate them in the
 first place. Still try to unmap such a page in case it is still mapped
 (e.g. current hwpoison implementation doesn't unmap KSM pages but keep
 the unmap as the catch all safety net).
"

My assumption would be: if there are any unexpected references on a
hwpoison page, we must fail offlining. Ripping out the page might be
more harmful then just leaving it in place and failing offlining for the
time being.



I am no export on PageHWPoison(). Which guarantees do we have regarding
the page count?

If we succeed in unmapping the page, there shouldn't be any references
from the page tables. We might still have GUP references to such pages,
and it would be fair enough to fail offlining. I remember we try
removing the page from the pagecache etc. to free up these references.
So which additional references do we have that the comment in offlining
code talks about? A single additional one from hwpoison code?

Once we figure that out, we might tweak test_pages_isolated() to also
consider the page count and not rip out random pages that are still
referenced in the system.

-- 
Thanks,

David / dhildenb

