Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62354506B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244550AbiDSLtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351870AbiDSLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BF9033E2A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650368820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeAwfDT3x/Rkm2EZaznjRquYozKkI6xYPbRZ5Up9SYY=;
        b=UMcrEASlevZRgOi3Oh4EI9BnV4DwvTEDosbq3tHvMS59DZLaGtBKcFlfEQyCEDKoeOR5Yg
        tM2VhJPad4SZlwl4yImJcLY9WdKOXmiumPYp/pKd/AtujY8ytxSyJimkm/qaXDLmzb8QAe
        WYbBc0sCVqgnHKC3z9FO3ZJxuq5atIc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-2j09k9h_PX2sYlr1S0kg9w-1; Tue, 19 Apr 2022 07:46:59 -0400
X-MC-Unique: 2j09k9h_PX2sYlr1S0kg9w-1
Received: by mail-wm1-f69.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso1205892wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SeAwfDT3x/Rkm2EZaznjRquYozKkI6xYPbRZ5Up9SYY=;
        b=HimJqEGuY3ZMRjory8DbczxhqRrYi8mNZVt1nbwQFUlSuM3lzdWbZrrLFZIYItrE9g
         YkvVlf8ZypgpJkkR148ril1WGTrh3IRwSBL5Hryce9Z+VrYyVWKSskrG1++og9gB/o8P
         znnKXqwyIoRU3iZNSW4tV+LYBSIn6KETRTg6teGY/UHJ+zrH0D5JUESWryUOG7yWB5LW
         XWQL2X0SCMuHFuqrz/uXZk2vDjji6N5fz2OtCSKgZ23qUzI5midpvk/UTNRMFc2qaCmT
         FyYOmEJiRnIC46a9Ha6DX9gd3sagqSquq6wIflgHWsJkAWPdLF80YqEp3ays1CysWPLw
         1M+A==
X-Gm-Message-State: AOAM532CRoMddcTSzqFHtsVAAnAwWYx/Q4W+A6pbza5UdRSORMNDEuzb
        Wk8DCGO4tjr70MAjfAQ0TRfZXrjVoDSxFDCN69L1SWr11+DXmv0LyR17O0Tsqt0YUdVG7CIz84P
        4ITLGC8oV9nqZa0mvqkumt8Ez
X-Received: by 2002:a05:600c:4fd4:b0:392:91a7:acd3 with SMTP id o20-20020a05600c4fd400b0039291a7acd3mr11673227wmq.102.1650368818212;
        Tue, 19 Apr 2022 04:46:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDHXgAK0Ww+2rxrpDBFaWLh+Ig7M7331tmL3UVxIV72/e+ThWk1Oi28F4sEHs/+V1SMbpmHA==
X-Received: by 2002:a05:600c:4fd4:b0:392:91a7:acd3 with SMTP id o20-20020a05600c4fd400b0039291a7acd3mr11673208wmq.102.1650368817960;
        Tue, 19 Apr 2022 04:46:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm13814890wri.111.2022.04.19.04.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 04:46:57 -0700 (PDT)
Message-ID: <c901938d-efcc-6a94-bbf4-93e7f4c2ea7d@redhat.com>
Date:   Tue, 19 Apr 2022 13:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        rcampbell@nvidia.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <b57fea1e-5c9b-f47e-f565-16b54f1e8782@redhat.com>
 <1b614ac3-02c0-ec66-b51a-e9b7e1a375ad@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1b614ac3-02c0-ec66-b51a-e9b7e1a375ad@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.22 13:21, Miaohe Lin wrote:
> On 2022/4/19 15:37, David Hildenbrand wrote:
>> On 16.04.22 05:05, Miaohe Lin wrote:
>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>>> page filled with random data is mapped into user address space. In case
>>> of error, a special swap entry indicating swap read fails is set to the
>>> page table. So the swapcache page can be freed and the user won't end up
>>> with a permanently mounted swap because a sector is bad. And if the page
>>> is accessed later, the user process will be killed so that corrupted data
>>> is never consumed. On the other hand, if the page is never accessed, the
>>> user won't even notice it.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>> v2:
>>>   use special swap entry to avoid permanently mounted swap
>>>   free the bad page in swapcache
>>> ---
>>>  include/linux/swap.h    |  7 ++++++-
>>>  include/linux/swapops.h | 10 ++++++++++
>>>  mm/memory.c             |  5 ++++-
>>>  mm/swapfile.c           | 11 +++++++++++
>>>  4 files changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index d112434f85df..03c576111737 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
>>>   * actions on faults.
>>>   */
>>>  
>>> +#define SWAP_READ_ERROR_NUM 1
>>> +#define SWAP_READ_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
>>> +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
>>> +			     SWP_PTE_MARKER_NUM)
>>
>> Does anything speak against reusing the hwpoison marker? At least from a
>> program POV it's similar "the previously well defined content at this
>> user space address is no longer readable/writable".
> 
> Looks like a good idea. :)
> 
>>
>> I recall that we can just set the pfn to 0 for the hwpoison marker.
>>
>> There is e.g., check_hwpoisoned_entry() and it just stops if it finds
>> "pfn=0".
> 
> Do you mean that we should set the pfn to 0 for the hwpoison marker so that we can
> distinguish swapin error case from real hwpoison case?

I am not sure if we really have to distinguish. However, "0" seems to
make sense to indicate "this is not an actual problematic PFN, the
information is simply no longer around due to a hardware issue.

-- 
Thanks,

David / dhildenb

