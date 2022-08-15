Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B765927E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiHOCzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiHOCzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:55:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69ED13E16
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:55:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s206so5537480pgs.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=l3/9EJ74G2pmcx1c7VMD7J6lmg4Dcu7ie7GoEh53Ago=;
        b=O3abV5j9/2Z/vRKk8br5NoXjIwsqtyhRf0E31VDqXZjozadH2V8JTCgxI6X3jishpz
         3D6/lNY4nyHg4SmNJZxtildDhb+8AyJdstSP9uah8mCUBxc5yHWtcMzDdgVcRna7xmYt
         qShKU7uyGtuFAu93y9htAZi0JOhaF8ZNqPwSDd45ZoNUU5950OXBrGktSgLMAzSzRqvd
         eOkqqkoTkjIrcpgsJG73jJnALiKNkUbiK+Qr3sFHosTOxZMJbq/PMekjvBigGb2Jv5lr
         O//bnvQ6bSugT92r4wycHx9l7lESgdNKKMfDoCW6bSevQ/6r9O8QTwSIp7hpQ4DRbqLG
         Bgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=l3/9EJ74G2pmcx1c7VMD7J6lmg4Dcu7ie7GoEh53Ago=;
        b=xHJwHiM62zkXqsTxWO7pP7Ds9YcqOAlpXPGA8iLLQMouGEc8i+U9a4Gcg5HNR3Y7Lb
         ksea/LDI5x0U8SSf9EuVFXVXFhkcp2jPCxAslWcHqGxr5t209K6ID3P9FcvG3DR131V7
         gy5aHE6Pje1qxhnc3gPnndDbV0Huo9bj2yBXwoJwfg17pHyzKvInhvGXSRJmNP+Eb+D5
         2LitDojXj47Sdv/Deuj66WyE0C015UvG5zPMmE28nrKeqelXqCU/mb17oBWK8+gxp8oe
         XGakTNdckSiBAgR7rR4lfvw/geiw1Rw+a8bYIax7kzpthTamP4gcaWPw1X22Hkzn4kBt
         ZE4g==
X-Gm-Message-State: ACgBeo3AOLxSCv+uadfOwjgWcu5AThbyajBecNXepvDpelb7zhv2tDHk
        WOfsYC9pUWvwrAfdObiToW5yvQ==
X-Google-Smtp-Source: AA6agR5oYSjpePrtxraA+t0t4D351HahwLrskBuhdbGOvifhJ7kuTTdtbTd1ubozlSs2tFJctgsuJA==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df2 with SMTP id z2-20020a056a00240200b0052c81cf8df2mr14281557pfh.40.1660532101270;
        Sun, 14 Aug 2022 19:55:01 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902a50100b0016bb24f5d19sm6015640plq.209.2022.08.14.19.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 19:55:01 -0700 (PDT)
Message-ID: <31a0e9d4-9e7a-1331-16a0-562fb4ce3350@bytedance.com>
Date:   Mon, 15 Aug 2022 10:54:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Content-Language: en-US
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <8e7d75d4-613e-f35e-e932-323789666fb1@huawei.com>
 <4dde05be-8470-5984-0a30-ba077b9fe6bd@bytedance.com>
 <CADjb_WQA7av8xCiUkTAHn2tQbGPeed1sMD=WWJ3DfCG-aRhKSA@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CADjb_WQA7av8xCiUkTAHn2tQbGPeed1sMD=WWJ3DfCG-aRhKSA@mail.gmail.com>
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

On 8/4/22 5:59 PM, Chen Yu Wrote:
> On Thu, Jul 14, 2022 at 3:11 PM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
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
>>>>    kernel/sched/fair.c | 15 +++++++++------
>>>>    1 file changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index a78d2e3b9d49..cd758b3616bd 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -6392,16 +6392,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>>       struct sched_domain *this_sd;
>>>>       u64 time = 0;
>>>>
>>>> -    this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>>> -    if (!this_sd)
>>>> -            return -1;
>>>> -
>>>>       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>>>
>>>> -    if (sched_feat(SIS_PROP) && !has_idle_core) {
>>>> +    if (has_idle_core)
>>>> +            goto scan;
>>>> +
>>>> +    if (sched_feat(SIS_PROP)) {
>>>>               u64 avg_cost, avg_idle, span_avg;
>>>>               unsigned long now = jiffies;
>>>>
>>>> +            this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>>> +            if (!this_sd)
>>>> +                    return -1;
>>>> +
>>>
>>> I don't follow the change here. True that this_sd is used only in SIS_PROP, but it seems irrelevant with your
>>> commit. Does the position of this make any performance difference?
>>
>> No, this change doesn't make much difference to performance. Are
>> you suggesting that I should make this a separate patch?
>>
> I took a look at this patch again before I start a OLTP test. I
> thought the position change of
> dereference sd_llc might not be closely connected with current change
> as Yicong mentioned.

OK, I will make it a separate patch. But before that I'd prefer wait
for more comments :)

> Besides, after moving the dereference inside SIS_PROP, we might do
> cpumask_and() no matter whether
> sd_llc is valid or not, which might be of extra cost?
> 
I think it might be irrelevant whether the local sd_llc is valid or
not, since all we care about is target sd_llc if !SIS_PROP.

Best Regards,
Abel
