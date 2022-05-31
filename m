Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA3A539013
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343955AbiEaLvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241631AbiEaLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 302B39969F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653997869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sp61j0jOxh675zEwHGRAuiHfrRaXXimDo3bMjlhAKxY=;
        b=OAW4Rqb8pQmdLVEdBh98uxYvXxygQrn7z6v1Nkd2b3XuiSuxaBVZuATbv0YqsYNlwmw04+
        oxMiMWpYyDVHWzWJT9xxKZN2G/JjLazi/ae/avBCfxpe+1r4khIf6JS9nvIrdHjBOAXwyP
        fs75AukyUx/rYA1gjur3whLuPqFAeJY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-1EHks0CWNJyMB8m5cGKi9Q-1; Tue, 31 May 2022 07:51:07 -0400
X-MC-Unique: 1EHks0CWNJyMB8m5cGKi9Q-1
Received: by mail-wr1-f71.google.com with SMTP id d6-20020adfe886000000b00210316ee45eso845139wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sp61j0jOxh675zEwHGRAuiHfrRaXXimDo3bMjlhAKxY=;
        b=DzLEPw0vnyJgbakfuDWl+QO/Dl82PMyloLoH2pwrR2zVcelpMYAglbyq+3Ov54wmQ0
         1M/nIGf1+Gl3Xox+e9TzfYJXsJtDwhKPzv9GUeWX/FjbymLlLQLQC+pyVvaFdb350m7+
         Vav54C7sZHPlHnJXFMsvddN38uB4RxyUKEUl+gj6PIwj89aKHnIRntaesSr7ifuu3eq8
         4jdLMSXYjBkr4mVHGGKHoRPATeKor5tQZBPX78s3FDhjzl51G4BCIVKtwfiit4pemCoA
         xWyXW74OnYKIYeALUtGlGQOR/Fn08pVpSDrt8nDzQVhfIyii9i2Mds8Sd1yCNu8DqCPb
         cWFw==
X-Gm-Message-State: AOAM533ssvwxm4CET/V0GdHbCV2FdfL8gUzYP17LPCXdxt1JESP/IkcU
        kZ9Bmu3Da346LQF0+aA11c0L2zNU4YciDVLUKiXoFsgDSge2yAEhsTdaaPetlpNol5cSVI4jPnA
        sjCtpQMVf3EracX/u5ptejuO6O1mrxfqIS9EJutVtXUYg6rskHhUr/luTXObb5nOJugpEL2aFsT
        1a
X-Received: by 2002:adf:ce03:0:b0:210:32ec:50fd with SMTP id p3-20020adfce03000000b0021032ec50fdmr8804148wrn.407.1653997866448;
        Tue, 31 May 2022 04:51:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUFDadQtEAW830R/53OnbX6GxA6MYGsy0Xd0Ict3qfIsNSiTbQk4A+/7hK8lbrXp+LCJlgPQ==
X-Received: by 2002:adf:ce03:0:b0:210:32ec:50fd with SMTP id p3-20020adfce03000000b0021032ec50fdmr8804120wrn.407.1653997866117;
        Tue, 31 May 2022 04:51:06 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id g12-20020adfd1ec000000b0020c5253d8f2sm8381245wrd.62.2022.05.31.04.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 04:51:05 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
In-Reply-To: <1d0eb8f4-e474-86a9-751a-7c2e1788df85@linux.alibaba.com>
References: <20220527090544.527411-1-dtcccc@linux.alibaba.com>
 <xhsmhleuj7zve.mognet@vschneid.remote.csb>
 <1d0eb8f4-e474-86a9-751a-7c2e1788df85@linux.alibaba.com>
Date:   Tue, 31 May 2022 12:50:49 +0100
Message-ID: <xhsmhilpl9azq.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/22 15:20, Tianchen Ding wrote:
> On 2022/5/31 00:24, Valentin Schneider wrote:
>> 
>> This feels a bit like a generalization of
>> 
>>    2ebb17717550 ("sched/core: Offload wakee task activation if it the wakee is descheduling")
>> 
>> Given rq->curr is updated before prev->on_cpu is cleared, the waker
>> executing ttwu_queue_cond() can observe:
>> 
>>    p->on_rq=0
>>    p->on_cpu=1
>>    rq->curr=swapper/x (aka idle task)
>> 
>> So your addition of available_idle_cpu() in ttwu_queue_cond() (sort of)
>> matches that when invoked via:
>> 
>>          if (smp_load_acquire(&p->on_cpu) &&
>>              ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
>>                  goto unlock;
>> 
>> but it also affects
>> 
>>          ttwu_queue(p, cpu, wake_flags);
>> 
>> at the tail end of try_to_wake_up().
>
> Yes. This part is what we mainly want to affect. The above WF_ON_CPU is 
> not our point.
>

Right.

>> 
>> With all that in mind, I'm curious whether your patch is functionaly close
>> to the below.
>> 
>> ---
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 66c4e5922fe1..ffd43264722a 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3836,7 +3836,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>>   	 * the soon-to-be-idle CPU as the current CPU is likely busy.
>>   	 * nr_running is checked to avoid unnecessary task stacking.
>>   	 */
>> -	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
>> +	if (cpu_rq(cpu)->nr_running <= 1)
>>   		return true;
>>   
>>   	return false;
>
> It's a little different. This may bring extra IPIs when nr_running == 1 
> and the current task on wakee cpu is not the target wakeup task (i.e., 
> rq->curr == another_task && rq->curr != p). Then this another_task may 
> be disturbed by IPI which is not expected. So IMO the promise by 
> WF_ON_CPU is necessary.

You're right, actually taking a second look at that WF_ON_CPU path,
shouldn't the existing condition be:

	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)

? Per the p->on_rq and p->on_cpu ordering, if we have WF_ON_CPU here then
we must have !p->on_rq, so the deactivate has happened, thus the task
being alone on the rq implies nr_running==0.

@Mel, do you remember why you went for <=1 here? I couldn't find any clues
on the original posting.

