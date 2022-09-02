Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953F5AA6CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 06:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiIBEMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiIBEMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:12:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3172AE9CA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 21:12:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x19so769373pfr.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 21:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6EsoCKG6MwzbB6K63JV7tUwAaNxjzkztUOPbZ6GaGwU=;
        b=jX6UgyUZRPLaYBmbpqOKU1cOZ6w3KtaqXrSg3NpOAEMh/wcA0zGkCz+idkKpxJg4fz
         aSFbRA1Peqn0F/lIwzzPNFICuHmU8+ccKJ1UinTMEy6Q/OnF6pJvMUSHM8RAKYYhB6rc
         lp5YW/GCX1IAhRwgP+cBHJowb7ACcVzwG+dugHV/5vH4APlBRiqfJrBxRLyT0MQqljCm
         qVhbVyXNvcU2IX1N4UdlJLKnkYPKy8c1alXE0cOCbhAnrwKwunQXQXUw/7Vbq37nJf9Y
         caV4zkKL/dZQD9gpeqW/G3+l9jFMRowmJSPuL030Kn3sZaORr8M/4ckU41x2PMglERMO
         0wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6EsoCKG6MwzbB6K63JV7tUwAaNxjzkztUOPbZ6GaGwU=;
        b=DmxgIAF/EnbrC+V5WvDjzVIxF6fop+QgV3YIt3oQomPSPylQ1PKn4a3zNnfeE+GOc0
         hx6ejKoJQ9v7VLegC2zUCyRb0O/kRDZEjxiw/Hz+OQOLhYYBn/ntHNXxGVBlKZqFZoH7
         y3R647Is+PWE1oUkwqr4KOjRemVtqFr1bHLP/xh7yJe/Scle6YWUqkzxaONIR6yXbz1i
         PVXvTzZfsRFF+Ob/CvQDD92rb4Tb1pslgqKa84iLTr7/sClEuyRVwOU/wY5g7got1aRk
         9tYO0fYEncAQdaS92qBSjl1GPD0a6AVitf/hjwGn4L0yuGeoj1OdFw6tRnC2SDa/aEA4
         h9Qg==
X-Gm-Message-State: ACgBeo2SMXnsJmVdGKrWSQMah1PGr2k/FnI00MfyDjRhxVqhHPDDV9A5
        KAoeqTZANi0t/SxsUJdrquJcUA==
X-Google-Smtp-Source: AA6agR7W2Btp3kf/mGEvzKvmbKi7YKqJQHxpcq/gZdz4lhLN10JyWrx1UiOSo/Jj/YSDwOGfy+WoCg==
X-Received: by 2002:a63:6e09:0:b0:430:663:7757 with SMTP id j9-20020a636e09000000b0043006637757mr11126479pgc.340.1662091956192;
        Thu, 01 Sep 2022 21:12:36 -0700 (PDT)
Received: from [10.254.35.190] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id je2-20020a170903264200b001751d0ac555sm412345plb.148.2022.09.01.21.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 21:12:35 -0700 (PDT)
Message-ID: <0ffb0903-431f-88fe-3a56-150b283f5304@bytedance.com>
Date:   Fri, 2 Sep 2022 12:12:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
 <51009414-5ffb-b6ec-a501-7b2514a0f3cc@bytedance.com>
 <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 10:56 PM, Mel Gorman Wrote:
> On Mon, Aug 29, 2022 at 10:11:39PM +0800, Abel Wu wrote:
>> Hi Mel, thanks for reviewing!
>>
> 
> No problem, sorry it took so long.
> 
>>> So, first suggestion is to move this patch to the end of the series as
>>> the other patches are relatively harmless. They could even be merged in
>>> isolation as a cleanup.
>>>
>>> Second, using the other patches as your baseline, include in the
>>> changelog what you tested that showed a benefit, what type of machine
>>> it was and in particular include the number of cores, nodes and the
>>> span of the LLC.  If you measured any regressions, include that as well
>>> and make a call on whether you think the patch wins more than it loses.
>>> The reason to include that information is because the worst corner case
>>> (all CPUs scanned uselessly) costs more the larger the span of LLC is.
>>> If all the testing was done on a 2-core SMT-2 machine, the overhead of the
>>> patch would be negligible but very different if the LLC span is 20 cores.
>>> While the patch is not obviously wrong, it definitely needs better data,
>>> Even if you do not have a large test machine available, it's still helpful
>>> to have it in the changelog because a reviewer like me can decide "this
>>> needs testing on a larger machine".
>>
>> Thanks for your detailed suggestions. I will attach benchmark results
>> along with some analysis next time when posting performance related
>> patches.
>>
> 
> Thanks, include this in the changelog. While I had different figures for
> hackbench, the figures are still fine. I had similar figures for netperf
> (~3-4% regression on some machines but not universal). The tbench figures
> are interesting because for you, it was mostly neutral but I did test
> it with a CascadeLake machine and had worse results and that machine is
> smaller in terms of core counts than yours.
> 
>>>
>>> I did queue this up the entire series for testing and while it sometimes
>>> benefitted, there were large counter-examples. tbench4 on Zen3 showed some
>>> large regressions (e.g. 41% loss on 64 clients with a massive increase in
>>> variability) which has multiple small L3 caches per node. tbench4 (slightly
>>> modified in mmtests to produce a usable metric) in general showed issues
>>> across multiple x86-64 machines both AMD and Intel, multiple generations
>>> with a noticable increase in system CPU usage when the client counts reach
>>> the stage where the machine is close to saturated. perfpipe for some
>>> weird reason showed a large regression apparent regresion on Broadwell
>>> but the variability was also crazy so probably can be ignored. hackbench
>>> overall looked ok so it's possible I'm wrong about the idle_cores hint
>>> being often wrong on that workload and I should double check that. It's
>>> possible the hint is wrong some of the times but right often enough to
>>> either benefit from using an idle core or by finding an idle sibling which
>>> may be preferable to stacking tasks on the same CPU.
>>
>> I attached my test result in one of my replies[1]: netperf showed ~3.5%
>> regression, hackbench improved a lot, and tbench4 drew. I tested several
>> times and the results didn't seem vary much.
>>
>>>
>>> The lack of data and the lack of a note on the potential downside is the
>>> main reason why I'm not acking patch. tbench4 was a particular concern on
>>> my own tests and it's possible a better patch would be a hybrid approach
>>> where a limited search of two cores (excluding target) is allowed even if
>>> SIS_UTIL indicates overload but has_idle_cores is true.
>>>
>>
>> Agreed. And the reason I will exclude this part in v2 is that I plan to
>> make it part of another feature, SIS filter [2]. The latest version of
>> SIS filter (not posted yet but soon) will contain all the idle cpus so
>> we don't need a full scan when has_idle_core. Scanning the filter then
>> is enough. While it may still cost too much if too many false positive
>> bits in the filter. Does this direction make sense to you?
>>
>> [1] https://lore.kernel.org/lkml/eaa543fa-421d-2194-be94-6a5e24a33b37@bytedance.com/
>> [2]
>> https://lore.kernel.org/lkml/20220619120451.95251-1-wuyun.abel@bytedance.com/
>>
> 
> The filter idea is tricky, it will always struggle with "accurate
> information" vs "cost of cpumask update" and what you link indicates that
> it's updated on the tick boundary. That will be relatively cheap but could
> mean that searches near the point of saturation or overload will have
> false positives and negatives which you are already aware of given the
> older series. It does not kill the idea but I would strongly suggest that
> you do the simple thing first. That would yield potentially 3-4 patches
> at the end of the series
> 
> 1. Full scan for cores (this patch effectively)
> 2. Limited scan of 2 cores when SIS_UTIL cuts off but has_idle_cores is true
>     (Compare 1 vs 2 in the changelog, not expected to be a universal win but
>      should have better "worst case" behaviour to be worth merging)

I am afraid I had a hard time on this part, and it would be nice if you
can shed some light on this..

Currently the mainline behavior when has_idle_core:

	nr_idle_scan	0	1	2	...
	nr		0	max	max	...

while this patch makes:

	nr_idle_scan	0	1	2	...
	nr		max	max	max	...

and if limit scan:

	nr_idle_scan	0	1	2	...
	nr		2	2	max	...

anyway, the scan depth for has_idle_core case is not well aligned to
the load. And honestly I'm not sure whether the depth should align to
the load or not, since lower depth can easily put sds->has_idle_core
in vain. Thoughts?

Thanks,
Abel

> 3. Filtered scan tracking idle CPUs as a hint while removing the
>     "limited scan"
>     (Compare 2 vs 3)
> 4. The SIS "de-entrophy" patch that tries to cope with false positives
>     and negatives
>     (Compare 3 vs 4)
> 
> That way if the later patches do not work as expected then they can be
> easily dropped without affecting the rest of the series.
> 
