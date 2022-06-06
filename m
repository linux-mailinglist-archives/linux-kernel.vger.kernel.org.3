Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8C53E773
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239000AbiFFNaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239121AbiFFNaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:30:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A64ECFE1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:30:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g205so12691661pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a6THwbekRoD/OZeM515RpGdmDznAEQ2m0S86eTQP2nM=;
        b=1/DASdY+kvY8TlD39JuG2crsUbgapeBdNKmyGXcC8hEVF0+ZsqmHt218btZ87BxpUX
         k765uHjOIiz/IreEUQItmAku9D9qgTnHcO4Ixh2fCyqF+pbbRPv6cK2StQ5L8KIHYOTq
         Z0W4iO1OWOm0+uF8e9W8wcyRjN1IXWICP59YrmWvZcJ7RakN84CR5I78NDGeRiKsdpnn
         MPQSKyEXrTfqLVZp5wOk8F3kIUyMNZjaRQ1oDvos8sSPfAFTb8RkCDQbOvKeJIXmyKnB
         KbiWe3/syU27gCzg2IWL55UQ6wMwgOQ9yHfEbxnCe0m8tpGpWzW+5mVDaSu49CovRs/N
         RpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a6THwbekRoD/OZeM515RpGdmDznAEQ2m0S86eTQP2nM=;
        b=NaMry+4IfZ875BbyNiuoJ5L5P0VkH1dCkimpxzYbpcV1Np+N1MihG2kpWLRCMNKeqi
         n/Bv46l/A1YSVRKxsTNs+QA6OvVdcvIzp8Xn6/12olmmkTk+V8Zg/bqSQlF3OtsIFnpM
         9VF0eNvMZnjQtW+g53ozmxzZR1KGasWjMwspDw5r1w6nbg0l5wcJmyLCyUAsPGUwqdDJ
         +Wuk8zPbvs0SYc6OsiaMVPmgujObVaC1C5mtBccscrlELMcve8TcZcRryuuS/QQ5bwWL
         AJzogXEHqCgMJEzAt4JAYILJVuWNVd+PeySznhSqjiJ1N1ru6yGgYONPDyU4IzaR5I0k
         /27A==
X-Gm-Message-State: AOAM533jKRaBhfpdN5KUo5gGT2QX97od2dXWr0oj89rZnoUygCwY1hYn
        wGYdkyP0iQ/R8WrBL/zob3EXbQ==
X-Google-Smtp-Source: ABdhPJxPbOJ9HngGe22LmSxuN0462AtcqqoZu6JjvBWF7RcJEYRGvysjzM2D7BIYICUfhv6cokZ8OA==
X-Received: by 2002:aa7:9217:0:b0:518:367d:fa85 with SMTP id 23-20020aa79217000000b00518367dfa85mr90933633pfo.9.1654522204614;
        Mon, 06 Jun 2022 06:30:04 -0700 (PDT)
Received: from [10.254.91.102] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b001e31803540fsm10010260pju.6.2022.06.06.06.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 06:30:04 -0700 (PDT)
Message-ID: <f7c09fd3-d09b-bd66-2bf1-0163fa8e5817@bytedance.com>
Date:   Mon, 6 Jun 2022 21:29:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2] mm: memcontrol: add {pgscan,pgsteal}_{kswapd,direct}
 items in memory.stat of cgroup v2
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220604082209.55174-1-zhengqi.arch@bytedance.com>
 <Yp3tLNi0wybMw7La@dhcp22.suse.cz>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Yp3tLNi0wybMw7La@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/6 8:03 PM, Michal Hocko wrote:
> On Sat 04-06-22 16:22:09, Qi Zheng wrote:
>> There are already statistics of {pgscan,pgsteal}_kswapd and
>> {pgscan,pgsteal}_direct of memcg event here, but now only the
>> sum of the two is displayed in memory.stat of cgroup v2.
>>
>> In order to obtain more accurate information during monitoring
>> and debugging, and to align with the display in /proc/vmstat,
>> it better to display {pgscan,pgsteal}_kswapd and
>> {pgscan,pgsteal}_direct separately.
>>
>> Also, for forward compatibility, we still display pgscan and
>> pgsteal items so that it won't break existing applications.
> 
> I do not remember why we have chosen to report cumulative stats rather
> than the direct and kswapd parts. Looking back when Roman has introduced
> those (http://lkml.kernel.org/r/1494530183-30808-1-git-send-email-guro@fb.com)
> I do not see any discussion around that. So it was likely just not
> a priority.
> 
> I have just one question. Say we even decide to have a per memcg kswapd
> in some form, would we report that into the same counter?

IMO, I would like it can be reported into the same counter.

> 
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Acked-by: Muchun Song <songmuchun@bytedance.com>
> 
> In any case
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

> 
> One nit below
> [...]
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 0d3fe0a0c75a..fd78c4d6bbc7 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1460,6 +1460,28 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
>>   	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
>>   }
>>   
> 
> I would just add the following for clarity

OK, will do.

> 
> /* Subset of vm_event_item to report for memcg event stats */
>> +static const unsigned int memcg_vm_event_stat[] = {
>> +	PGSCAN_KSWAPD,
>> +	PGSCAN_DIRECT,
>> +	PGSTEAL_KSWAPD,
>> +	PGSTEAL_DIRECT,
>> +	PGFAULT,
>> +	PGMAJFAULT,
>> +	PGREFILL,
>> +	PGACTIVATE,
>> +	PGDEACTIVATE,
>> +	PGLAZYFREE,
>> +	PGLAZYFREED,
>> +#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>> +	ZSWPIN,
>> +	ZSWPOUT,
>> +#endif
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	THP_FAULT_ALLOC,
>> +	THP_COLLAPSE_ALLOC,
>> +#endif
>> +};
> 

-- 
Thanks,
Qi
