Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3958B01A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiHES5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbiHES5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1366A5A884
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659725825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38HMOlpiHz3hAI7+jcYvoHMIUhKTjvFP/aWFO5JyZUs=;
        b=NA5xk7nBGxY7S5Ui0byHXMEhwPEW5iMZJIt+m7ZwA6/IQFwSC2kw6B/1DqrtKBjFYAlAbJ
        YSJRRLKKNapajujn/L2kRyKcwv4gKxezQ7QT/5R64D/7AVPOHscpgbA3i1QtGgDyWw3IIY
        GVYOhWDXz2wFwA4jFdS9rhYQadQinQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-9_dNNs6NNuqIxfOk6S5YfA-1; Fri, 05 Aug 2022 14:57:03 -0400
X-MC-Unique: 9_dNNs6NNuqIxfOk6S5YfA-1
Received: by mail-wm1-f69.google.com with SMTP id 18-20020a05600c029200b003a500b612e2so1578419wmk.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 11:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=38HMOlpiHz3hAI7+jcYvoHMIUhKTjvFP/aWFO5JyZUs=;
        b=KCN8sXB3inF4HNDGulH8VJ+QoIUzm44rVqWxebnTdF8PHGIil3jGOXUIbTruxIco/Q
         rkHqX7RflzrfQSsV8ObACbIXDb1gV+7kg6vji0k/CakksdX0ElubHYglc0Akx46T7UbW
         AA4QRUCGOWbQ7qggEc8snlmW6LEQ09vRwIINC+6C2pqMzvxnrDVzvYLT9pA9RPIB9ppv
         6tLib8FqUxDWZ3vm9ydxzTbLNgcgJI6ukOmh9MtcjHyRylYaeqFiSSAn07TIN3u+d03E
         bBaMYOfW9UUANWTUb15fhJh9sEns016A4IDJQjEJv3bbLREY7q97C5OK5J2GWvrzXzOJ
         5Qcw==
X-Gm-Message-State: ACgBeo3x4mL2rCL0u3KZ9ebN9owDwSwG5MuX14kKlgo928Q+Mm/eCyxF
        GzDh60R0J1OG4nTTEfZRY0V76/O8TsszPL2RhvR9JBc1/8DflCeNANj2ggMbZ8gXZhiKHV5+6Sd
        pmvaQAZEYDukR5/MucimqG8cK
X-Received: by 2002:a5d:5081:0:b0:220:6262:be0b with SMTP id a1-20020a5d5081000000b002206262be0bmr4863596wrt.228.1659725822066;
        Fri, 05 Aug 2022 11:57:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4KFDPpXTnLc9xcWmV5EbrjJoKCLSsWZAX9+Qv0fALjuvgGAb/bq9BvB7bwLwfeM2udXcmh0A==
X-Received: by 2002:a5d:5081:0:b0:220:6262:be0b with SMTP id a1-20020a5d5081000000b002206262be0bmr4863590wrt.228.1659725821805;
        Fri, 05 Aug 2022 11:57:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id b4-20020adff904000000b0021e9fafa601sm4458360wrr.22.2022.08.05.11.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:57:01 -0700 (PDT)
Message-ID: <73050e64-e40f-0c94-be96-316d1e8d5f3b@redhat.com>
Date:   Fri, 5 Aug 2022 20:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-2-david@redhat.com> <Yu1eCsMqa641zj5C@xz-m1.local>
 <Yu1gHnpKRZBhSTZB@monkey> <c2a3b903-099c-4b79-6923-8b288d404c51@redhat.com>
 <Yu1ie559zt8VvDc1@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/2] mm/hugetlb: fix hugetlb not supporting
 write-notify
In-Reply-To: <Yu1ie559zt8VvDc1@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.22 20:33, Mike Kravetz wrote:
> On 08/05/22 20:25, David Hildenbrand wrote:
>> On 05.08.22 20:23, Mike Kravetz wrote:
>>> On 08/05/22 14:14, Peter Xu wrote:
>>>> On Fri, Aug 05, 2022 at 01:03:28PM +0200, David Hildenbrand wrote:
>>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>>> index 61e6135c54ef..462a6b0344ac 100644
>>>>> --- a/mm/mmap.c
>>>>> +++ b/mm/mmap.c
>>>>> @@ -1683,6 +1683,13 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
>>>>>  	if ((vm_flags & (VM_WRITE|VM_SHARED)) != ((VM_WRITE|VM_SHARED)))
>>>>>  		return 0;
>>>>>  
>>>>> +	/*
>>>>> +	 * Hugetlb does not require/support writenotify; especially, it does not
>>>>> +	 * support softdirty tracking.
>>>>> +	 */
>>>>> +	if (is_vm_hugetlb_page(vma))
>>>>> +		return 0;
>>>>
>>>> I'm kind of confused here..  you seems to be fixing up soft-dirty for
>>>> hugetlb but here it's explicitly forbidden.
>>>>
>>>> Could you explain a bit more on why this patch is needed if (assume
>>>> there'll be a working) patch 2 being provided?
>>>>
>>>
>>> No comments on the patch, but ...
>>>
>>> Since it required little thought, I ran the test program on next-20220802 and
>>> was surprised that the issue did not recreate.  Even added a simple printk
>>> to make sure we were getting into vma_wants_writenotify with a hugetlb vma.
>>> We were.
>>
>>
>> ... does your config have CONFIG_MEM_SOFT_DIRTY enabled?
>>
> 
> No, Duh!
> 
> FYI - Some time back, I started looking at adding soft dirty support for
> hugetlb mappings.  I did not finish that work.  But, I seem to recall
> places where code was operating on hugetlb mappings when perhaps it should
> not.
> 
> Perhaps, it would also be good to just disable soft dirty for hugetlb at
> the source?

I thought about that as well. But I came to the conclusion that without
patch #2, hugetlb VMAs cannot possibly support write-notify, so there is
no need to bother in vma_wants_writenotify() at all.

The "root" would be places where we clear VM_SOFTDIRTY. That should only
be fs/proc/task_mmu.c:clear_refs_write() IIRC.

So I don't particularly care, I consider this patch a bit cleaner and
more generic, but I can adjust clear_refs_write() instead of there is a
preference.

-- 
Thanks,

David / dhildenb

