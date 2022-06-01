Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19C53A358
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352207AbiFAK7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345062AbiFAK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E85081997
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654081134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76NerlyuCUFch8j/71h+02HBOx9GG120yMGBjCVbdqo=;
        b=gtgrefTNVmwsDU3WRbsIelnNA0Q9yR8rNqhNmYXtCKMLdxeXO4IS35oG6sNHNc0SzIRNJ1
        FXO02tuisycQbLyICfh6I7tvim74utnmob3iFpakdL4LKDzSnn/vgLo6TM3TVT8XyFvn9d
        YX6Z/XHNGygkcggE+E6pM+T2/FkB7Vc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-oqtoMs5dNDaOk3zdNKjMSw-1; Wed, 01 Jun 2022 06:58:53 -0400
X-MC-Unique: oqtoMs5dNDaOk3zdNKjMSw-1
Received: by mail-wm1-f70.google.com with SMTP id o3-20020a05600c510300b0039743540ac7so736993wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=76NerlyuCUFch8j/71h+02HBOx9GG120yMGBjCVbdqo=;
        b=oXkoUPx3KSgWAWqjiOBMo4Aty+Ptb7AYFSdz6yirzgyZzAyOOFNbN0bOrhDPBJon2U
         btmPTdDR0TNLkoDsZ81WnjT7Wef42OwR3tf3ZFmnRaaW/Azui09XJCdiWbP0YD/beUOx
         UqS+4JvCjpeoQhDgTnOj5NT15Xc1m5ON3M3N9SzHdF+Ft/ynvsEPe8rU1pqmujNw66JQ
         sR6KJnxnrCO1xPnAI0SPoR7WzFOet4+Xkaf34vfcZrIS2GFk2N+AgfapppDX29x9hPwi
         0drooFddIR4AjAd2YBNif1LkoPzY0u2VrVkd27aWNndQMHckquA35RhOO8Ob1MNuxajF
         /t8g==
X-Gm-Message-State: AOAM531QhcPqQ85/nJwX3fB0atYxj7oR2Elr71u7jGnJaA21K6bOdiQE
        VuxxrdbO3FRgNwLWLdT5O0fGHcMgVBYAg7OG1gkpRakPleFFAf7TmJbIQ4i+B0M7iddGUSvyQqq
        WqyK3j9e9LbVv1BIGNhRbb6bp6lsgs43keeULqSNF8LVZ4Y8//Mawm3bb+GCVh8cNhIr39bMjA7
        o/
X-Received: by 2002:a05:6000:168b:b0:20f:d4b4:572b with SMTP id y11-20020a056000168b00b0020fd4b4572bmr39803235wrd.107.1654081130652;
        Wed, 01 Jun 2022 03:58:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjjEtcw7szK2s/kfQophKBR7w8seij0vcAQQEg7y2SjNToEs2guxyryd7faueJD9FJMvQAmg==
X-Received: by 2002:a05:6000:168b:b0:20f:d4b4:572b with SMTP id y11-20020a056000168b00b0020fd4b4572bmr39803199wrd.107.1654081130236;
        Wed, 01 Jun 2022 03:58:50 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b0039756cdc8e1sm1612682wmo.37.2022.06.01.03.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:58:49 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tianchen Ding <dtcccc@linux.alibaba.com>,
        Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
In-Reply-To: <a5d04748-b34b-3b92-fb1d-bf85c2019cc3@linux.alibaba.com>
References: <20220527090544.527411-1-dtcccc@linux.alibaba.com>
 <xhsmhleuj7zve.mognet@vschneid.remote.csb>
 <1d0eb8f4-e474-86a9-751a-7c2e1788df85@linux.alibaba.com>
 <xhsmhilpl9azq.mognet@vschneid.remote.csb> <20220531135532.GA3332@suse.de>
 <xhsmhfskp8zlg.mognet@vschneid.remote.csb>
 <a5d04748-b34b-3b92-fb1d-bf85c2019cc3@linux.alibaba.com>
Date:   Wed, 01 Jun 2022 11:58:48 +0100
Message-ID: <xhsmhczfs8xav.mognet@vschneid.remote.csb>
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

On 01/06/22 13:54, Tianchen Ding wrote:
> On 2022/5/31 23:56, Valentin Schneider wrote:
>
>> Thanks!
>> 
>> So I'm thinking we could first make that into
>> 
>> 	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
>> 
>> Then building on this, we can generalize using the wakelist to any remote
>> idle CPU (which on paper isn't as much as a clear win as just WF_ON_CPU,
>> depending on how deeply idle the CPU is...)
>> 
>> We need the cpu != this_cpu check, as that's currently served by the
>> WF_ON_CPU check (AFAIU we can only observe p->on_cpu in there for remote
>> tasks).
>> 
>> ---
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 66c4e5922fe1..60038743f2f1 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3830,13 +3830,20 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>>   	if (!cpus_share_cache(smp_processor_id(), cpu))
>>   		return true;
>>   
>> +	if (cpu == smp_processor_id())
>> +		return false;
>> +
>>   	/*
>>   	 * If the task is descheduling and the only running task on the
>>   	 * CPU then use the wakelist to offload the task activation to
>>   	 * the soon-to-be-idle CPU as the current CPU is likely busy.
>>   	 * nr_running is checked to avoid unnecessary task stacking.
>> +	 *
>> +	 * Note that we can only get here with (wakee) p->on_rq=0,
>> +	 * p->on_cpu can be whatever, we've done the dequeue, so
>> +	 * the wakee has been accounted out of ->nr_running
>>   	 */
>> -	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
>> +	if (!cpu_rq(cpu)->nr_running)
>>   		return true;
>>   
>>   	return false;
>
> Hi Valentin. I've done a simple unixbench test (Pipe-based Context 
> Switching) on my x86 machine with full threads (104).
>
>               old            patch1           patch1+patch2
> score       7825.4     7500(more)-8000          9061.6
>
> patch1: use !cpu_rq(cpu)->nr_running instead of cpu_rq(cpu)->nr_running <= 1
> patch2: ignore WF_ON_CPU check
>
> The score of patch1 is not stable. I've tested for many times and the 
> score is floating between about 7500-8000 (more at 7500).
>
> patch1 means more strict limit on using wakelist. But it may cause 
> performance regression.
>
> It seems that, using wakelist properly can help improve wakeup 
> performance, but using it too much may cause more IPIs. It's a trade-off 
> about how strict the ttwu_queue_cond() is.
>
> Anyhow, I think patch2 should be a pure improvement. What's your idea?

Thanks for separately testing these two.

I take it the results for patch1 are noticeably more swingy than the
baseline? (FWIW boxplots are usually a nice way to summarize those sort of
results).

WF_ON_CPU && nr_running == 1 means the wakee is scheduling out *and* there
is another task queued, I'm guessing that's relatively common in your
unixbench scenario...

Either way, I think we want to keep the two changes separate for the sake
of testing and bisecting.

