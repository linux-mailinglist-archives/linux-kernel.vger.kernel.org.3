Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E814E5AA924
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiIBHxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiIBHxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:53:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58296B5A4E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:53:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1411DD6E;
        Fri,  2 Sep 2022 00:53:43 -0700 (PDT)
Received: from [192.168.1.162] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7EB23F766;
        Fri,  2 Sep 2022 00:53:34 -0700 (PDT)
Message-ID: <6281126b-3b93-86fa-25d6-d637b6c7dd87@arm.com>
Date:   Fri, 2 Sep 2022 09:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com>
 <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
 <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 12:02, Peter Zijlstra wrote:
> On Mon, Aug 29, 2022 at 10:08:13AM +0200, Peter Zijlstra wrote:
>> On Mon, Aug 29, 2022 at 07:54:50AM +0200, Dietmar Eggemann wrote:
>>> From: Vincent Donnefort <vincent.donnefort@arm.com>

[...]

>>> +extern unsigned int sched_pelt_lshift;
>>> +
>>> +/*
>>> + * absolute time   |1      |2      |3      |4      |5      |6      |
>>> + * @ mult = 1      --------****************--------****************-
>>> + * @ mult = 2      --------********----------------********---------
>>> + * @ mult = 4      --------****--------------------****-------------
>>> + * clock task mult
>>> + * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
>>> + * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
>>> + *
>>> + */
>>> +static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
>>> +{
>>> +	delta <<= READ_ONCE(sched_pelt_lshift);
>>> +
>>> +	rq->clock_task_mult += delta;
>>> +
>>> +	update_rq_clock_pelt(rq, delta);
>>> +}
>>
>> Hurmph... I'd almost go write you something like
>> static_call()/static_branch() but for immediates.
>>
>> That said; given there's only like 3 options, perhaps a few
>> static_branch() instances work just fine ?
> 
> Also, I'm not at all sure about exposing that as an official sysctl.
> 
> How about something like so?

[...]

>  void update_rq_clock(struct rq *rq)
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -101,3 +101,6 @@ SCHED_FEAT(LATENCY_WARN, false)
>  
>  SCHED_FEAT(ALT_PERIOD, true)
>  SCHED_FEAT(BASE_SLICE, true)
> +
> +SCHED_FEAT(PELT_M2, false)
> +SCHED_FEAT(PELT_M4, false)

The sched features interface would definitely be much less official but
I think it's not useful for Android since they don't mount debugfs anymore.

[...]
