Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1A51D988
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiEFNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240638AbiEFNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:46:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C224942
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:42:25 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a191so6168357pge.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PfUI54DC+Rd4JhaHhM79SH7hCQA6BnGmIDFJn3u5zLM=;
        b=aKsXfyC6aHrcUWOwO7G7UYAV68+b8gHqoJddnLu0t/IA7s7HawCsFCGO/Kujg873Y6
         KVD3LFFVeuekk+wEAOPy1Y6U1hO5gUa0jLOw8Bvc5N02CNRvkanaEg2w/JG5wka+Oslx
         ydesijDYApsY+LM85LShGfEnGycGRv/VEdWYUy9FfhhdzljJFiBXPOyi/Pa35WArWkKX
         BhCl/GlGG23ObBA0eoXzfYFXawe6ko9nCA940pYhFh0G0ZTDtWM5vfpTM+6JW1Njun30
         ZsFjAFyFgMjFBHj+GWTjf33CG4KH/W+9w3UtvRGjoUgC8vdqfTBth8M1FRYVYh8Z+xd5
         8xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PfUI54DC+Rd4JhaHhM79SH7hCQA6BnGmIDFJn3u5zLM=;
        b=hFITML5VZ7J46R49GXa01JiiWbfGTGhK7JqwXH4ga+UgzSxrmNcGGNfGmiA2/V6TvM
         jEfr0PYrB0lUifj94Ksv0wKgsk+VZlivblJ3F7fwz8zp5PvVBvrMMGkfYeAwSY6W5UtS
         NKdZuKHm49xFepqq6B6JJaI7XHOICYM2iJeXUd/VM0ZkLZI8HmcG8a6oPt3wcvkN5pQ4
         BUPIB+mKKHu3qb3stTmXznITBOVBQvHaozObN0h/LAMkTP9013HR6YT8LeqGQ3OOPpvH
         0Lma1a7nD7QjaF3W2m7fcKx/ysPEa7cYC9Ue2ya2HuEk6gv2kujjlsF09K60Ld7dHvFc
         2n2A==
X-Gm-Message-State: AOAM533TzilbPUBUmGhnRLyEPdq5FDWrFTTgifVv4xa1sJfLiO40e4P4
        FQwSD663lyYVEhH7O7JqzEYPC3PzIIRuZA==
X-Google-Smtp-Source: ABdhPJySJILodY6XqJPjPbH87bJIVRNRr+CgOPpU7dPLFadY++HIHQRCjgCYnQukNaA1I2A/cUztMg==
X-Received: by 2002:a63:8449:0:b0:3c6:4145:6a1c with SMTP id k70-20020a638449000000b003c641456a1cmr2839205pgd.590.1651844544773;
        Fri, 06 May 2022 06:42:24 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s14-20020a056a001c4e00b0050dc76281fesm3333258pfw.216.2022.05.06.06.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 06:42:24 -0700 (PDT)
Message-ID: <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
Date:   Fri, 6 May 2022 21:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wu Fengguang <fengguang.wu@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-4-pizhenwei@bytedance.com>
 <20220506085920.GC1356094@u2004>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220506085920.GC1356094@u2004>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/22 16:59, Naoya Horiguchi wrote:
> On Fri, Apr 29, 2022 at 10:22:05PM +0800, zhenwei pi wrote:
>> In the memory failure procedure, hwpoison_filter has higher priority,
>> if memory_filter() filters the error event, there is no need to do
>> the further work.
> 
> Could you clarify what problem you are trying to solve (what does
> "optimize" mean in this context or what is the benefit)?
> 

OK. The background of this work:
As well known, the memory failure mechanism handles memory corrupted 
event, and try to send SIGBUS to the user process which uses this 
corrupted page.

For the virtualization case, QEMU catches SIGBUS and tries to inject MCE 
into the guest, and the guest handles memory failure again. Thus the 
guest gets the minimal effect from hardware memory corruption.

The further step I'm working on:
1, try to modify code to decrease poisoned pages in a single place 
(mm/memofy-failure.c: simplify num_poisoned_pages_dec in this series).

2, try to use page_handle_poison() to handle SetPageHWPoison() and 
num_poisoned_pages_inc() together. It would be best to call 
num_poisoned_pages_inc() in a single place too. I'm not sure if this is 
possible or not, please correct me if I misunderstand.

3, introduce memory failure notifier list in memory-failure.c: notify 
the corrupted PFN to someone who registers this list.
If I can complete [1] and [2] part, [3] will be quite easy(just call 
notifier list after increasing poisoned page).

4, introduce memory recover VQ for memory balloon device, and registers 
memory failure notifier list. During the guest kernel handles memory 
failure, balloon device gets notified by memory failure notifier list, 
and tells the host to recover the corrupted PFN(GPA) by the new VQ.

5, host side remaps the corrupted page(HVA), and tells the guest side to 
unpoison the PFN(GPA). Then the guest fixes the corrupted page(GPA) 
dynamically.

Because [4] and [5] are related to balloon device, also CC Michael, 
David and Jason.

> Now hwpoison_filter() can be called both with *and* without taking page refcount.
> It's mainly called *with* taking page refcount in order to make sure that the
> actual handling process is executed only for pages that meet a given condition.
> IOW, it's important to prevent pages which do not meet the condition from going
> ahead to further steps (false-positive is not permitted).  So this type of
> callsite should not be omittable.
> 
> As for the other case, hwpoison_filter() is also called in hwpoison_inject()
> *without* taking page refcount.  This actually has a different nuance and
> intended to speculatively filter the injection events before setting
> PageHWPoison flag to reduce the noise due to setting PG_hwpoison temporary.
> The point is that it's not intended here to filter precisely and this callsite
> is omittable.
> 
> So in my understanding, we need keep hwpoison_filter() after taking page
> refcount as we do now.  Maybe optionally and additionally calling
> hwpoison_filter() at the beginning of memory_failure() might be possible,
> but I'm not sure yet how helpful...
> 
> Thanks,
> Naoya Horiguchi
> 
>>
>> Cc: Wu Fengguang <fengguang.wu@intel.com>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   mm/memory-failure.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index ece05858568f..a6a27c8b800f 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1800,6 +1800,11 @@ int memory_failure(unsigned long pfn, int flags)
>>   		goto unlock_mutex;
>>   	}
>>   
>> +	if (hwpoison_filter(p)) {
>> +		res = -EOPNOTSUPP;
>> +		goto unlock_mutex;
>> +	}
>> +
>>   try_again:
>>   	res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
>>   	if (hugetlb)
>> @@ -1937,15 +1942,6 @@ int memory_failure(unsigned long pfn, int flags)
>>   	 */
>>   	page_flags = p->flags;
>>   
>> -	if (hwpoison_filter(p)) {
>> -		if (TestClearPageHWPoison(p))
>> -			num_poisoned_pages_dec();
>> -		unlock_page(p);
>> -		put_page(p);
>> -		res = -EOPNOTSUPP;
>> -		goto unlock_mutex;
>> -	}
>> -
>>   	/*
>>   	 * __munlock_pagevec may clear a writeback page's LRU flag without
>>   	 * page_lock. We need wait writeback completion for this page or it
>> -- 
>> 2.20.1
>>

-- 
zhenwei pi
