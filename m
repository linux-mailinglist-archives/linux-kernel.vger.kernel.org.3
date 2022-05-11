Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160F4522BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiEKF3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiEKF3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:29:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763A5244F25
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:29:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g8so1042071pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=vX8kU5dDtoUlOaOjPewPBy5WMgZbRU9QbOjMsuKkwPQ=;
        b=ttd7dKbtokSaBSOmQpfR0H6Z85wovzmFLole9+Y8CYPbgLeE36VAN9w8HtLY8DkBPl
         xhlN1ceJA+pjrGfNxdcSu8aT5w5/boJrrejCsvIqZix3+IqP+jQteSRSRESa2HdyPS0N
         ru3Im2+pgSvZ60LQka89WuV/X35xd6NaJA2xS7wQvVq1xHygXNc/ybzwmLl5JvT7XYgs
         KqKdALQcmsvzb4w6qQHlUF0S2GRGl/s2ZBUmg/uysbRg6W0CABFTa6gierOu+0vjAyLS
         30BmV2rawQ8BzBxlzlv0Fft15RzTpBeDuhGFq6ifa6a0ewfhPg9Y0jci//Sbgnf3UUzi
         Ql4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=vX8kU5dDtoUlOaOjPewPBy5WMgZbRU9QbOjMsuKkwPQ=;
        b=48/hMypHN1fGseA4GAMhwpfvuNMabWT+80S/HHjNLn7FrE6AGOO9b7tNz4xZC0viYa
         fL4afKk/3YoBQCHO+xL/AnPuNUu6xnSlwkV0w+1I3RcP179ofu3kmcr4zQw3t39wn+ts
         oUGncZ5b7DexNvQZnSlYM6pwgKg+c+V9Fwzu2Sd++5IqXIvGMuORsVbOcLdLUmX3OEt1
         XDUAHsjkqQwlSBa6K32spRMd/8cV1OiYywh2DGo2pU0CWf4BrW8ILlrX4nvZbPgiiDRY
         HiHevUP87LSuvJkM5DElAXyJ28cC/2de0AAiqrvJo5OCRHf6pK43woowDumuMjA98EoB
         JZSg==
X-Gm-Message-State: AOAM533ZJSyQf0U9gdgBFVCKuaQUdL3Phpsg2R8jWniaeuWsrrbh7aVB
        vP9Yn0Ste6gNnvPJHtrMiqPtlg==
X-Google-Smtp-Source: ABdhPJzJRqbk28HmtAfwF2fJgnv1gN/OfvWO1CakPBnCAwvak5ugwxZw3vGXsERhJcwZxjgB3VIqxA==
X-Received: by 2002:a63:ed43:0:b0:3ab:54ea:9914 with SMTP id m3-20020a63ed43000000b003ab54ea9914mr19920395pgk.172.1652246941995;
        Tue, 10 May 2022 22:29:01 -0700 (PDT)
Received: from [10.254.203.126] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7850b000000b0050dc76281fbsm518381pfn.213.2022.05.10.22.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 22:29:01 -0700 (PDT)
Message-ID: <e2834c8f-7d82-5a8f-9a09-60e08c3b91a7@bytedance.com>
Date:   Wed, 11 May 2022 13:28:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] mm: fix missing handler for __GFP_NOWARN
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akinobu.mita@gmail.com, vbabka@suse.cz, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rostedt@goodmis.org
References: <20220510113809.80626-1-zhengqi.arch@bytedance.com>
 <ed212c6b-a10a-0267-fb20-9a1691b9ba45@bytedance.com>
In-Reply-To: <ed212c6b-a10a-0267-fb20-9a1691b9ba45@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/11 1:12 PM, Qi Zheng wrote:
> 
> 
> On 2022/5/10 7:38 PM, Qi Zheng wrote:
>> We expect no warnings to be issued when we specify __GFP_NOWARN, but
>> currently in paths like alloc_pages() and kmalloc(), there are still
>> some warnings printed, fix it.
> 
> Hi Andrew,
> 
> Maybe we only need to deal with memory allocation failures, such as
> should_fail() (This leads to deadlock in PATCH[2/2]). These 
> WARN_ON_ONCE()s report usage problems and should not be printed. If they

such as WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1),
gfp_flags).

> are printed, we should fix these usage problems.
> 
> Thanks,
> Qi
> 
> 
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/fault-inject.h |  2 ++
>>   lib/fault-inject.c           |  3 +++
>>   mm/failslab.c                |  3 +++
>>   mm/internal.h                | 11 +++++++++++
>>   mm/page_alloc.c              | 22 ++++++++++++----------
>>   5 files changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
>> index 2d04f6448cde..9f6e25467844 100644
>> --- a/include/linux/fault-inject.h
>> +++ b/include/linux/fault-inject.h
>> @@ -20,6 +20,7 @@ struct fault_attr {
>>       atomic_t space;
>>       unsigned long verbose;
>>       bool task_filter;
>> +    bool no_warn;
>>       unsigned long stacktrace_depth;
>>       unsigned long require_start;
>>       unsigned long require_end;
>> @@ -39,6 +40,7 @@ struct fault_attr {
>>           .ratelimit_state = RATELIMIT_STATE_INIT_DISABLED,    \
>>           .verbose = 2,                        \
>>           .dname = NULL,                        \
>> +        .no_warn = false,                    \
>>       }
>>   #define DECLARE_FAULT_ATTR(name) struct fault_attr name = 
>> FAULT_ATTR_INITIALIZER
>> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
>> index ce12621b4275..423784d9c058 100644
>> --- a/lib/fault-inject.c
>> +++ b/lib/fault-inject.c
>> @@ -41,6 +41,9 @@ EXPORT_SYMBOL_GPL(setup_fault_attr);
>>   static void fail_dump(struct fault_attr *attr)
>>   {
>> +    if (attr->no_warn)
>> +        return;
>> +
>>       if (attr->verbose > 0 && __ratelimit(&attr->ratelimit_state)) {
>>           printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure.\n"
>>                  "name %pd, interval %lu, probability %lu, "
>> diff --git a/mm/failslab.c b/mm/failslab.c
>> index f92fed91ac23..58df9789f1d2 100644
>> --- a/mm/failslab.c
>> +++ b/mm/failslab.c
>> @@ -30,6 +30,9 @@ bool __should_failslab(struct kmem_cache *s, gfp_t 
>> gfpflags)
>>       if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
>>           return false;
>> +    if (gfpflags & __GFP_NOWARN)
>> +        failslab.attr.no_warn = true;
>> +
>>       return should_fail(&failslab.attr, s->object_size);
>>   }
>> diff --git a/mm/internal.h b/mm/internal.h
>> index cf16280ce132..7a268fac6559 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -35,6 +35,17 @@ struct folio_batch;
>>   /* Do not use these with a slab allocator */
>>   #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
>> +#define WARN_ON_ONCE_GFP(cond, gfp)    ({                \
>> +    static bool __section(".data.once") __warned;            \
>> +    int __ret_warn_once = !!(cond);                    \
>> +                                    \
>> +    if (unlikely(!(gfp & __GFP_NOWARN) && __ret_warn_once && 
>> !__warned)) { \
>> +        __warned = true;                    \
>> +        WARN_ON(1);                        \
>> +    }                                \
>> +    unlikely(__ret_warn_once);                    \
>> +})
>> +
>>   void page_writeback_init(void);
>>   static inline void *folio_raw_mapping(struct folio *folio)
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 0e42038382c1..2bf4ce4d0e2f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3722,7 +3722,7 @@ struct page *rmqueue(struct zone *preferred_zone,
>>        * We most definitely don't want callers attempting to
>>        * allocate greater than order-1 page units with __GFP_NOFAIL.
>>        */
>> -    WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>> +    WARN_ON_ONCE_GFP((gfp_flags & __GFP_NOFAIL) && (order > 1), 
>> gfp_flags);
>>       do {
>>           page = NULL;
>> @@ -3799,6 +3799,9 @@ static bool __should_fail_alloc_page(gfp_t 
>> gfp_mask, unsigned int order)
>>               (gfp_mask & __GFP_DIRECT_RECLAIM))
>>           return false;
>> +    if (gfp_mask & __GFP_NOWARN)
>> +        fail_page_alloc.attr.no_warn = true;
>> +
>>       return should_fail(&fail_page_alloc.attr, 1 << order);
>>   }
>> @@ -4346,7 +4349,8 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned 
>> int order,
>>        */
>>       /* Exhausted what can be done so it's blame time */
>> -    if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
>> +    if (out_of_memory(&oc) ||
>> +        WARN_ON_ONCE_GFP(gfp_mask & __GFP_NOFAIL, gfp_mask)) {
>>           *did_some_progress = 1;
>>           /*
>> @@ -4902,8 +4906,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned 
>> int order,
>>        * We also sanity check to catch abuse of atomic reserves being 
>> used by
>>        * callers that are not in atomic context.
>>        */
>> -    if (WARN_ON_ONCE((gfp_mask & (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
>> -                (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)))
>> +    if (WARN_ON_ONCE_GFP((gfp_mask & 
>> (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM)) ==
>> +                (__GFP_ATOMIC|__GFP_DIRECT_RECLAIM), gfp_mask))
>>           gfp_mask &= ~__GFP_ATOMIC;
>>   retry_cpuset:
>> @@ -5117,7 +5121,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned 
>> int order,
>>            * All existing users of the __GFP_NOFAIL are blockable, so 
>> warn
>>            * of any new users that actually require GFP_NOWAIT
>>            */
>> -        if (WARN_ON_ONCE(!can_direct_reclaim))
>> +        if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>>               goto fail;
>>           /*
>> @@ -5125,7 +5129,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned 
>> int order,
>>            * because we cannot reclaim anything and only can loop waiting
>>            * for somebody to do a work for us
>>            */
>> -        WARN_ON_ONCE(current->flags & PF_MEMALLOC);
>> +        WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
>>           /*
>>            * non failing costly orders are a hard requirement which we
>> @@ -5133,7 +5137,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned 
>> int order,
>>            * so that we can identify them and convert them to something
>>            * else.
>>            */
>> -        WARN_ON_ONCE(order > PAGE_ALLOC_COSTLY_ORDER);
>> +        WARN_ON_ONCE_GFP(order > PAGE_ALLOC_COSTLY_ORDER, gfp_mask);
>>           /*
>>            * Help non-failing allocations by giving them access to memory
>> @@ -5379,10 +5383,8 @@ struct page *__alloc_pages(gfp_t gfp, unsigned 
>> int order, int preferred_nid,
>>        * There are several places where we assume that the order value 
>> is sane
>>        * so bail out early if the request is out of bound.
>>        */
>> -    if (unlikely(order >= MAX_ORDER)) {
>> -        WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
>> +    if (WARN_ON_ONCE_GFP(order >= MAX_ORDER, gfp))
>>           return NULL;
>> -    }
>>       gfp &= gfp_allowed_mask;
>>       /*
> 

-- 
Thanks,
Qi
