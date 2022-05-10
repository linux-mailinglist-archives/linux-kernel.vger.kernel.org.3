Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97552224D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiEJRZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347945AbiEJRZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A90B046175
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652203284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sAYwIoDrNnaHcJ/cmYSGgWvyKcfiytUv7ZdRENAaBLg=;
        b=BFM8iQzSuQrfrdMjXbvBXSs03IK5SFoldQvB3KuHMkam2TPh8glHNRcN4yFCOc630kLL4C
        bolWFgj3uPbNzUgB1qM9su42IzVmgO8CXWmoW+8zQMWfjffjDo+6hDixQoJMSlRuxDFh1s
        +srTn10/rO+2IUZ+qgEEeHE8bTQkG3g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-dY3izJB7MpS-ZZXkWcqPPw-1; Tue, 10 May 2022 13:21:23 -0400
X-MC-Unique: dY3izJB7MpS-ZZXkWcqPPw-1
Received: by mail-wm1-f69.google.com with SMTP id m26-20020a7bcb9a000000b0039455e871b6so1046046wmi.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sAYwIoDrNnaHcJ/cmYSGgWvyKcfiytUv7ZdRENAaBLg=;
        b=FpLLBn89pPDBbbbx5G8DzENE0YMS0wQL4LFrxSHAN/9RwlQ04GLxfSv8xcMdZPnq4R
         HJLC+0Nxv08pYiuDA4ZyNlu7F46TzNQx4VID4AJdclyDY3fq1qkL7ybC8V5yQ5yI5Z86
         f584rgyaP+GnLo+i4YgpizSn0KHTuXcWunPjaoEG8+aLbO61ShksgiMluxiKwqC/+ZYb
         4+iJYbQKIZvZJPFI1YtDUSCNi8R+uhyMKRVprR/fc7RY8LZtNH2so6eCcUBYW8nmxnNh
         4fysDTLfGYPJ61bkq3yFLqiElB6060D5xU1MI9w4Dz8zXpFKXg1miYy0JS6h3++EBBWw
         jo4w==
X-Gm-Message-State: AOAM531HxDOHP5LihQ59Bdg8/GRcwnn5u6ibupi6g1oTTgj04KIjRqh1
        Chb/ven02GL+onUQEsiZu3ZTWyy/WDaqO9/kNHgGcRq8oNkHraaN4oZ9uQXwxnhI50RPsZP3hg1
        ncbfIUvJpZCORxGZBALZzNZc0
X-Received: by 2002:a7b:c350:0:b0:38c:6d3c:6c8 with SMTP id l16-20020a7bc350000000b0038c6d3c06c8mr984718wmj.45.1652203279958;
        Tue, 10 May 2022 10:21:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAmo0K9QeW/yb3yXjxsgFnbwtW1gimimSuvt8ieLJhcHqq2VC/KNZkuC9hI0Pyj5EsRuTwHg==
X-Received: by 2002:a7b:c350:0:b0:38c:6d3c:6c8 with SMTP id l16-20020a7bc350000000b0038c6d3c06c8mr984687wmj.45.1652203279619;
        Tue, 10 May 2022 10:21:19 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f21-20020a7bcd15000000b003942a244f3dsm2991557wmj.22.2022.05.10.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:21:19 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 17/22] sched/core: fix opencoded cpumask_any_but()
In-Reply-To: <20220510163707.GO76023@worktop.programming.kicks-ass.net>
References: <20220510154750.212913-1-yury.norov@gmail.com>
 <20220510154750.212913-18-yury.norov@gmail.com>
 <20220510163707.GO76023@worktop.programming.kicks-ass.net>
Date:   Tue, 10 May 2022 18:21:18 +0100
Message-ID: <xhsmhv8ud1ey9.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/22 18:37, Peter Zijlstra wrote:
> On Tue, May 10, 2022 at 08:47:45AM -0700, Yury Norov wrote:
>> sched_core_cpu_starting() and sched_core_cpu_deactivate() implement
>> opencoded cpumask_any_but(). Fix it.
>>
>> CC: Ben Segall <bsegall@google.com>
>> CC: Daniel Bristot de Oliveira <bristot@redhat.com>
>> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> CC: Ingo Molnar <mingo@redhat.com>
>> CC: Juri Lelli <juri.lelli@redhat.com>
>> CC: Mel Gorman <mgorman@suse.de>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Steven Rostedt <rostedt@goodmis.org>
>> CC: Valentin Schneider <vschneid@redhat.com>
>> CC: Vincent Guittot <vincent.guittot@linaro.org>
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
>> ---
>>  kernel/sched/core.c | 33 +++++++++++++--------------------
>>  1 file changed, 13 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index f5ebc392493d..9700001948d0 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6125,7 +6125,7 @@ static void queue_core_balance(struct rq *rq)
>>  static void sched_core_cpu_starting(unsigned int cpu)
>>  {
>>      const struct cpumask *smt_mask = cpu_smt_mask(cpu);
>> -	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
>> +	struct rq *rq = cpu_rq(cpu), *core_rq;
>>      unsigned long flags;
>>      int t;
>>
>> @@ -6138,19 +6138,16 @@ static void sched_core_cpu_starting(unsigned int cpu)
>>              goto unlock;
>>
>>      /* find the leader */
>> -	for_each_cpu(t, smt_mask) {
>> -		if (t == cpu)
>> -			continue;
>> -		rq = cpu_rq(t);
>> -		if (rq->core == rq) {
>> -			core_rq = rq;
>> -			break;
>> -		}
>> -	}
>> +	t = cpumask_any_but(smt_mask, cpu);
>> +	if (t >= nr_cpu_ids)
>> +		goto unlock;
>>
>> -	if (WARN_ON_ONCE(!core_rq)) /* whoopsie */
>> +	rq = cpu_rq(t);
>> +	if (WARN_ON_ONCE(rq->core != rq)) /* whoopsie */
>>              goto unlock;
>>
>> +	core_rq = rq;
>> +
>>      /* install and validate core_rq */
>>      for_each_cpu(t, smt_mask) {
>>              rq = cpu_rq(t);
>
> I don't think this is equivalent. Imagine SMT4, with:
>
>   rqN->core_rq = rq0
>
> Now, further suppose smt0-2 are online and we're about to online smt3.
> Then t above is free to be smt2, which then results in insta triggering:
>
> +	if (WARN_ON_ONCE(rq->core != rq)) /* whoopsie */
>
> You seem to have lost how the first loop searches for rq->core.
>

cpumask_any() is actually cpumask_first(), so t should be smt0 in that
case. However, if for some reason rq->core isn't the first online CPU in
smt_mask \ {cpu} (which I think can happen if you offline smt0-1 then
re-online smt0), then yes that splats.

> Please, be more careful. Also, all of this is super cold path don't
> bother with optimizations. Much of the patches you have in this series
> fall under that.

I tend to agree, I do like the cpumask_weight_eq() stuff because it's a low
hanging fruit and can even be autopatched with coccinelle, but the
open-coded stuff in cold paths isn't as relevant (nor as obvious as it may
look :)).

