Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6CF50DACC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiDYIEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241525AbiDYIEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BED916592
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650873681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkFL9MtFyT2jXWP8u3N7pMFr8N/9sIoY1jitbMrwBaU=;
        b=H9DsJAvroYqx0MR3rT3DywpuY6i1Oa0D6l/YjhWGsfhqk5tEBKsFxhQhdp5p335jKZfs5Z
        XOyvkothtOB3/Y1UDzJ8ddZjs2BvQ5hIKLRccx3JaO/Hh2DaFblalQ3xc6TdITYugKpP36
        Yzi8/ALdwQmx09l1Nk95bBQqOXlGQG8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-lghXcPsgOWygJsRWlyaemQ-1; Mon, 25 Apr 2022 04:01:18 -0400
X-MC-Unique: lghXcPsgOWygJsRWlyaemQ-1
Received: by mail-wr1-f70.google.com with SMTP id v13-20020adfc5cd000000b0020ad3580cd0so713368wrg.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VkFL9MtFyT2jXWP8u3N7pMFr8N/9sIoY1jitbMrwBaU=;
        b=2Bb4k/TGefOH/TC0wSQ8JhHbNHzpOyxZRZUNuZEk/Rmv7kPmNSeHrGG0EWSC0AaO1M
         HTJCGa4SvC5kQrOQoImnjdUb1pCfza1wBhXf57czkPoLn5GUv1BIR1hdwBZmyxLA0S6A
         NpsH4LPfl/kddzszSg7D9uz+0HDM1ANY07WYo00YQl8QBvTBzWkZZG3pptLsPRqjMLhx
         3vEFdazPY4a5aBM16yDlWwLQ0JgGEJ9/Pwfox4ODs7Qcb6uob74HX9vuj/eU8yslwKJ9
         g11Q5j662cQDqD9/7Xe+3bNiqHnmGGWk0/LoMywcEYYPyCCt5Nc6KrBKp0xWCTbFieP9
         gmkA==
X-Gm-Message-State: AOAM533ztR2UhnSMXwdFi1F7BeF0zlFEO4rk/ezrzqFVZjxSVjeErGE/
        OV0I+ZC10nWaJmw5aXZWncPchAH4p2nXeu9ASg4QGfvUGKVTZmN6wnfNQkm5Gb2egvtkaZQiBXH
        3KnzgywbFKhOhy1vDSXxcV8/j
X-Received: by 2002:a5d:48cc:0:b0:206:d17:10aa with SMTP id p12-20020a5d48cc000000b002060d1710aamr13450860wrs.460.1650873677002;
        Mon, 25 Apr 2022 01:01:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3U6o+KLtF6TTm6TP8Ie2A4MlAJBrMQWQjM0y9V7eVJ1bBnn+UdwsTUpos/soo1CkyUGZC7w==
X-Received: by 2002:a5d:48cc:0:b0:206:d17:10aa with SMTP id p12-20020a5d48cc000000b002060d1710aamr13450834wrs.460.1650873676659;
        Mon, 25 Apr 2022 01:01:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:490d:ed6a:8b22:223a? (p200300cbc700fc00490ded6a8b22223a.dip0.t-ipconnect.de. [2003:cb:c700:fc00:490d:ed6a:8b22:223a])
        by smtp.gmail.com with ESMTPSA id c13-20020adfa30d000000b0020adc82de11sm1755331wrb.26.2022.04.25.01.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:01:08 -0700 (PDT)
Message-ID: <a64b1987-1f98-db78-c0e4-189690d7a45d@redhat.com>
Date:   Mon, 25 Apr 2022 10:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if swap
 read fails
Content-Language: en-US
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tim C Chen <tim.c.chen@intel.com>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-2-linmiaohe@huawei.com>
 <8aeebc2f0b2a251d3d70402cd0edf063ba911013.camel@intel.com>
 <f88412b4-83db-e594-fc48-2f4b8b9f3be8@redhat.com>
 <6c6694965fa3e6d85d78d56703090f227a55bb83.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6c6694965fa3e6d85d78d56703090f227a55bb83.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 09:55, ying.huang@intel.com wrote:
> On Mon, 2022-04-25 at 09:49 +0200, David Hildenbrand wrote:
>> On 25.04.22 09:41, ying.huang@intel.com wrote:
>>> Hi, Miaohe,
>>>
>>> On Sun, 2022-04-24 at 17:11 +0800, Miaohe Lin wrote:
>>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>>>> page filled with random data is mapped into user address space.  In case
>>>> of error, a special swap entry indicating swap read fails is set to the
>>>> page table.  So the swapcache page can be freed and the user won't end up
>>>> with a permanently mounted swap because a sector is bad.  And if the page
>>>> is accessed later, the user process will be killed so that corrupted data
>>>> is never consumed.  On the other hand, if the page is never accessed, the
>>>> user won't even notice it.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  include/linux/swap.h    |  7 ++++++-
>>>>  include/linux/swapops.h | 10 ++++++++++
>>>>  mm/memory.c             |  5 ++++-
>>>>  mm/swapfile.c           | 11 +++++++++++
>>>>  4 files changed, 31 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>> index 5553189d0215..b82c196d8867 100644
>>>> --- a/include/linux/swap.h
>>>> +++ b/include/linux/swap.h
>>>> @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
>>>>   * actions on faults.
>>>>   */
>>>>
>>>> +#define SWP_SWAPIN_ERROR_NUM 1
>>>> +#define SWP_SWAPIN_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
>>>> +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
>>>> +			     SWP_PTE_MARKER_NUM)
>>>>
>>>>
>>>
>>> It appears wasteful to use another swap device number. 
>>
>> Do we really care?
>>
>> We currently use 5 bits for swap types, so we have a total of 32.
>>
>> SWP_HWPOISON_NUM -> 1
>> SWP_MIGRATION_NUM -> 3
>> SWP_PTE_MARKER_NUM -> 1
>> SWP_DEVICE_NUM -> 4
>> SWP_SWAPIN_ERROR_NUM -> 1
>>
>> Which would leave us with 32 - 10 = 22 swap devices. IMHO that's plenty
>> for real life scenarios.
> 
> Creating multiple swap partitions on one disk can improve the
> scalability of swap subsystem, although we usually don't have so many
> disks for swap. 

Exactly, and IMHO if we have 22 or 23 doesn't make a real difference
here ...

-- 
Thanks,

David / dhildenb

