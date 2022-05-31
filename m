Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C69539491
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345954AbiEaP5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345990AbiEaP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F63C11A2F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654012624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gS8n2iVxHBQIo0RL5ntHyiyEAcZKa8wm7aA/yDRIJ7g=;
        b=P5AAuCYBrUxrTKKIsF/3EjEra5Q5Ihd4tjEGPweJitjqv9mz0eLl/YnQVoFMsdyQ7j2u1N
        ekYe6bIFbMtnFhS3qnrnJcjjz9/oYMhvngJk24VAtx7s+o8lVQGbz3dIT2+2VMU1Cpl4Pn
        8vqSCqLX4zG07T1mSxoRWTTp5ICq+F4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-S6Wyk3m3M4SYNrfRz2d5XQ-1; Tue, 31 May 2022 11:57:03 -0400
X-MC-Unique: S6Wyk3m3M4SYNrfRz2d5XQ-1
Received: by mail-wm1-f71.google.com with SMTP id n18-20020a05600c3b9200b0039746f3d9faso6228260wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gS8n2iVxHBQIo0RL5ntHyiyEAcZKa8wm7aA/yDRIJ7g=;
        b=D9CCWT9wfY1rA0Yn6AM8wwaX2xPKuo5wIyChLbMlQ8toPkU1Azw473jUGvUTfz4yvG
         +qTBJSTMuaTA9pLp3hhp/PvA+chR7L3YcGQN7GgO65ifksMJH6X643naNRLK2SDFtzE1
         ORr76se/u/dwDOUtBgVcQ8Ylcv8C0PFZlXXneUoKgpPGNyVbElTBUSVFyFJtfk2ZW5Ot
         IIlz1FUbY+RhqZN5XZm2GJ3SgUYk64B1BUjtfGEfDpSdyjMgIs2j/qkAFfe8BN4qQvZB
         vKIbvTweNt3rVVcd3R0SCI9To1df2GmodRTo91hzXzSGwjUqM6+8nxMVpnXbz86vDS7a
         z+bQ==
X-Gm-Message-State: AOAM530xTlEQfzISG5btqceDMdJNo12M7qTNsEhCHHDU4zDlTbSSx1fl
        /xP0lPNY4S6rvyxRL+8aa+bW6piRR8tYrd+Bv3CLPehZneCQzz8qFMrhlRGx1RcnQYVulxK+Mwl
        31TMTXw7Js9Mrd1bB/JKKbtdKd9pbdgSfbguCGqQdcKtIAk1rTZe4B/p9v8WyjgtFFxRqijFI1T
        /8
X-Received: by 2002:a5d:6e03:0:b0:20f:ca43:badc with SMTP id h3-20020a5d6e03000000b0020fca43badcmr40043632wrz.547.1654012621126;
        Tue, 31 May 2022 08:57:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuiRWaXB3VVS8+cKXGzDU8evfojOEwEsaq9A9CHUlQTEDlO7MIgFdLWIgQw33urdfzWYPUFQ==
X-Received: by 2002:a5d:6e03:0:b0:20f:ca43:badc with SMTP id h3-20020a5d6e03000000b0020fca43badcmr40043611wrz.547.1654012620897;
        Tue, 31 May 2022 08:57:00 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c410700b003942a244edfsm2456133wmi.36.2022.05.31.08.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 08:57:00 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
In-Reply-To: <20220531135532.GA3332@suse.de>
References: <20220527090544.527411-1-dtcccc@linux.alibaba.com>
 <xhsmhleuj7zve.mognet@vschneid.remote.csb>
 <1d0eb8f4-e474-86a9-751a-7c2e1788df85@linux.alibaba.com>
 <xhsmhilpl9azq.mognet@vschneid.remote.csb> <20220531135532.GA3332@suse.de>
Date:   Tue, 31 May 2022 16:56:59 +0100
Message-ID: <xhsmhfskp8zlg.mognet@vschneid.remote.csb>
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

On 31/05/22 14:55, Mel Gorman wrote:
> On Tue, May 31, 2022 at 12:50:49PM +0100, Valentin Schneider wrote:
>> >> With all that in mind, I'm curious whether your patch is functionaly close
>> >> to the below.
>> >> 
>> >> ---
>> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> >> index 66c4e5922fe1..ffd43264722a 100644
>> >> --- a/kernel/sched/core.c
>> >> +++ b/kernel/sched/core.c
>> >> @@ -3836,7 +3836,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>> >>   	 * the soon-to-be-idle CPU as the current CPU is likely busy.
>> >>   	 * nr_running is checked to avoid unnecessary task stacking.
>> >>   	 */
>> >> -	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
>> >> +	if (cpu_rq(cpu)->nr_running <= 1)
>> >>   		return true;
>> >>   
>> >>   	return false;
>> >
>> > It's a little different. This may bring extra IPIs when nr_running == 1 
>> > and the current task on wakee cpu is not the target wakeup task (i.e., 
>> > rq->curr == another_task && rq->curr != p). Then this another_task may 
>> > be disturbed by IPI which is not expected. So IMO the promise by 
>> > WF_ON_CPU is necessary.
>> 
>> You're right, actually taking a second look at that WF_ON_CPU path,
>> shouldn't the existing condition be:
>> 
>> 	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
>> 
>> ? Per the p->on_rq and p->on_cpu ordering, if we have WF_ON_CPU here then
>> we must have !p->on_rq, so the deactivate has happened, thus the task
>> being alone on the rq implies nr_running==0.
>> 
>> @Mel, do you remember why you went for <=1 here? I couldn't find any clues
>> on the original posting.
>> 
>
> I don't recall exactly why I went with <= 1 there but I may not have
> considered the memory ordering of on_rq and nr_running and the comment
> above it is literally what I was thinking at the time. I think you're
> right and that check can be !cpu_rq(cpu)->nr_running.
>

Thanks!

So I'm thinking we could first make that into

	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)

Then building on this, we can generalize using the wakelist to any remote
idle CPU (which on paper isn't as much as a clear win as just WF_ON_CPU,
depending on how deeply idle the CPU is...)

We need the cpu != this_cpu check, as that's currently served by the
WF_ON_CPU check (AFAIU we can only observe p->on_cpu in there for remote
tasks).

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 66c4e5922fe1..60038743f2f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3830,13 +3830,20 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	if (!cpus_share_cache(smp_processor_id(), cpu))
 		return true;
 
+	if (cpu == smp_processor_id())
+		return false;
+
 	/*
 	 * If the task is descheduling and the only running task on the
 	 * CPU then use the wakelist to offload the task activation to
 	 * the soon-to-be-idle CPU as the current CPU is likely busy.
 	 * nr_running is checked to avoid unnecessary task stacking.
+	 *
+	 * Note that we can only get here with (wakee) p->on_rq=0,
+	 * p->on_cpu can be whatever, we've done the dequeue, so
+	 * the wakee has been accounted out of ->nr_running
 	 */
-	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
+	if (!cpu_rq(cpu)->nr_running)
 		return true;
 
 	return false;

