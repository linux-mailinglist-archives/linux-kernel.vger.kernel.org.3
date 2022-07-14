Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A02574643
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiGNIAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiGNIAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:00:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAED22522
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:00:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b9so1153235pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hZvupmqkRAYTvBrFs91h5XDaRVd2eOd2qUWtUN+1M8o=;
        b=XYYlyuW12p66C6THJPXjHlrI6pZHbUC8MmVB7wtvGlnEoP4sc3gK2VqK5Y6GYd+bkN
         fQ7BeqlxZK65dno8VwKCa6bP+H/uZmGyKMMosXOLmel/36VObWA5VWHivKJBAP6hvVln
         yYxWPCIlfXHXxU0BZ22h3BRQ0Ma2rohKY3Vinfc2NyH0ZzM2NnBIQ4hV38yRbScqJDow
         8SzW955wW8SWgjr3nTLEUAgfSyIVoEuBMD9lbT9nWVtV2w3qZrnB3mB1EnB45lZ5n3D3
         5xI015JBH0Goag1N7STVHhxRYIPgeYzUzkRfzLtyU5qDfceoSCgmmHH2d6dcqYtNg5GH
         HYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hZvupmqkRAYTvBrFs91h5XDaRVd2eOd2qUWtUN+1M8o=;
        b=WqLGi8aHbalGWrJim1s0Gnm+U0Fz9wbyaeaXEl4MZwtmhGH2LFFZyeH10Z8Mdv/iUb
         0qSbhjdzzzbJtfzxoVQnDwJiwYYRTKaxCXBdE4xHEDDdnrJQu36VfGh9EUcMfpLGmqfW
         KQjViMXv/H9WcWZBlH50lrYrVLdBzGpOQcJlwGUNkmk1vUPbENUDVJyeqxqNrfwkd90J
         0Zh4+EXseMKhppabUQU686f2dp0SZChMO3BbyFyZvblGtYXXTRPFMZGnWXoRpuiysWza
         rQM7Bbw+QyzrVW25RZiSPzCOZWky7vHs6WenLrb8duo7JoeWDe43oPzskUThOin4DhGy
         ZVmA==
X-Gm-Message-State: AJIora97MeIV7KhyRv8SunK+bjsPpSL8pGFavMvMkUsnfRFZnLllvHvv
        T2SmegxIeMghpnNH/QjmyFY85g0pY/z2cw==
X-Google-Smtp-Source: AGRyM1veVmlkG8CMsJci8DaYwSOG73eVpFgTu9CQkTyeMgPQtAI+ZD6xzy68EZEkylwgBaBF4K9ZGw==
X-Received: by 2002:a63:cf52:0:b0:40d:fb07:a793 with SMTP id b18-20020a63cf52000000b0040dfb07a793mr6884025pgj.576.1657785636808;
        Thu, 14 Jul 2022 01:00:36 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id t187-20020a625fc4000000b0052ab8a92496sm588516pfb.168.2022.07.14.01.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:00:36 -0700 (PDT)
Message-ID: <5df03ae2-6c5d-aa38-4a4d-632c0f484140@bytedance.com>
Date:   Thu, 14 Jul 2022 16:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     yangyicong@hisilicon.com, Josh Don <joshdon@google.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <8e7d75d4-613e-f35e-e932-323789666fb1@huawei.com>
 <4dde05be-8470-5984-0a30-ba077b9fe6bd@bytedance.com>
 <e8a59a8f-1e0c-2bb6-2d1b-4e76f5c511f5@huawei.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <e8a59a8f-1e0c-2bb6-2d1b-4e76f5c511f5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/22 3:15 PM, Yicong Yang Wrote:
> On 2022/7/14 14:58, Abel Wu wrote:
>>
>> On 7/14/22 2:19 PM, Yicong Yang Wrote:
>>> On 2022/7/12 16:20, Abel Wu wrote:
>>>> When SIS_UTIL is enabled, SIS domain scan will be skipped if
>>>> the LLC is overloaded. Since the overloaded status is checked
>>>> in the load balancing at LLC level, the interval is llc_size
>>>> miliseconds. The duration might be long enough to affect the
>>>> overall system throughput if idle cores are out of reach in
>>>> SIS domain scan.
>>>>
>>>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>>>> ---
>>>>    kernel/sched/fair.c | 15 +++++++++------
>>>>    1 file changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index a78d2e3b9d49..cd758b3616bd 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -6392,16 +6392,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>>        struct sched_domain *this_sd;
>>>>        u64 time = 0;
>>>>    -    this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>>> -    if (!this_sd)
>>>> -        return -1;
>>>> -
>>>>        cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>>>    -    if (sched_feat(SIS_PROP) && !has_idle_core) {
>>>> +    if (has_idle_core)
>>>> +        goto scan;
>>>> +
>>>> +    if (sched_feat(SIS_PROP)) {
>>>>            u64 avg_cost, avg_idle, span_avg;
>>>>            unsigned long now = jiffies;
>>>>    +        this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>>> +        if (!this_sd)
>>>> +            return -1;
>>>> +
>>>
>>> I don't follow the change here. True that this_sd is used only in SIS_PROP, but it seems irrelevant with your
>>> commit. Does the position of this make any performance difference?
>>
>> No, this change doesn't make much difference to performance. Are
>> you suggesting that I should make this a separate patch?
>>
> 
> It just makes me think that dereference is unnecessary if this_cpu and target locates in
> the same LLC, since it's already been passed. But since you noticed no difference it may
> have little effect. :)
> 

Hmm.. Not exactly. The sched-domains are cpu private, and this_cpu can
be in another LLC than target.
