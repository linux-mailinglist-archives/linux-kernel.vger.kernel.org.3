Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D898B4D926C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbiCOCGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbiCOCGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:06:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8932072
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:05:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z3so15060675plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=oPHQ4fpuNGVMU5cEMWbBOa/L8hRoWApLWEbsHSmTWP8=;
        b=KhtD+pDl/35Ko9vnCOYS77yfopBWYEE0UvJLkVkVkh/efJJkxhg7eDMY2+y4KsEH4G
         X9yAmJI3ogvwcPgzzRyTSanX88rp43DrW6Unf+HVno0LfKyv39MR+e9AiE9uvs4E0A53
         CEY1EpLB7ehmlL2zvDOXc34xKkd0G/xx22dbPGe1dyVWIZ6EOw0lQmpYZr/nsiRtgn25
         o2cPTV2qygE4Et8uh44grlGJTOkRD57aQq2s+l2dyLuI3b1cUCdgJMhF+LivNIcTm3zU
         RUuB7QpGDgYU3clRPGHaMVtcN5EVRnGhsvR+DX/HqxIJ5zY+P5CY+FY4yFaIJH1RMZlU
         7m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oPHQ4fpuNGVMU5cEMWbBOa/L8hRoWApLWEbsHSmTWP8=;
        b=yvmE9N6u1l5WFswHJlM5L2E8mCElkIsc6q5DYyXBLAnpk/pC+uwxp3HjQT2x5poNkv
         dFubFYC6+vTjWElUZAr0XGxo94HiBkmONeejqrl2ux0yqLrU5gEtOjGKSnB/Ca7RfwYo
         nDrgIiQizux9LXAr8YFn4hPCbaQQ29q5Uk99E127dDqwPbM1IiuBeoGT7v1upMx6ARsT
         7eSW8tjDls7x5Mwv6DHmQDOnxxmLS6UCgA5AmN5UHGAz5IIaCZdjKUFq1Vq3MQgAek/w
         IhSa3tUzheNd+Sozz0Ck+wII8ktzbRfuLjk+m1Prg3WTxuVaMcgLeUS5NRs2MuHwM0Gu
         Jd/A==
X-Gm-Message-State: AOAM5302iBOW5zLxPiWK7cILato77PXp0j6BYENr/V237bmHl7PNelSF
        mTnRR0YGYvOZe9Ks0AP+jLIs8Q==
X-Google-Smtp-Source: ABdhPJyKGha+8paspERO+T15KTg9Wjk8d6/Fb7mxrZrIX5DlLX7aWwiZGIG+QUHdFNkrt/iXv6Oapg==
X-Received: by 2002:a17:902:e844:b0:151:f805:30ee with SMTP id t4-20020a170902e84400b00151f80530eemr25733850plg.33.1647309904064;
        Mon, 14 Mar 2022 19:05:04 -0700 (PDT)
Received: from [10.93.243.243] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id y6-20020a63ad46000000b003812fedd2desm6288469pgo.24.2022.03.14.19.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 19:05:03 -0700 (PDT)
Message-ID: <5de97c7f-2c71-34d0-9443-27f71960b4dd@bytedance.com>
Date:   Tue, 15 Mar 2022 10:04:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [External] Re: Subject: [PATCH] sched/fair: prioritize normal
 task over sched_idle task with vruntime offset
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Benjamin Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duanxiongchun@bytedance.com, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        zhoufeng.zf@bytedance.com, ligang.bdlg@bytedance.com
References: <f87a8c0d-527d-a9bc-9653-ff955e0e95b4@bytedance.com>
 <20220312120309.GB6235@worktop.programming.kicks-ass.net>
 <a528d7bf-a634-00b6-42ab-dcb516567c34@bytedance.com>
 <20220313090222.GL28057@worktop.programming.kicks-ass.net>
 <e57c7166-b484-0d32-e4e8-5a47ef0bb53c@bytedance.com>
 <CABk29NsBEZ63eQ-avDBHe1LYj+wJNSTkCxPDQ=eTNS9_i9e0NA@mail.gmail.com>
From:   chenying <chenying.kernel@bytedance.com>
In-Reply-To: <CABk29NsBEZ63eQ-avDBHe1LYj+wJNSTkCxPDQ=eTNS9_i9e0NA@mail.gmail.com>
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

在 2022/3/15 8:30, Josh Don 写道:
> On Sun, Mar 13, 2022 at 3:07 AM chenying <chenying.kernel@bytedance.com> wrote:
>>
>> If I set the sched_idle_vruntime_offset to a relatively small value
>> (e.g. 10 minutes), can this issues be avoided?
> 
> That's still long enough to cause lockups.
> 
> Is the issue that you have a large number of sched_idle entities, and
> the occasional latency sensitive thing that wakes up for a short
> duration? Have you considered approaching this from the other
> direction (ie. if we have a latency sensitive thing wake onto a cpu
> running only sched idle stuff, we could change entity placement to
> position the latency sensitive thing further left on the timeline,
> akin to !GENTLE_FAIR_SLEEPERS).

I think this may not guarantee that latency sensitive tasks are always 
to the left of idle tasks. And it may get complicated if a 
latency-sensitive task is woken up onto a cpu which there are already 
multiple latency-sensitive tasks and sched_idle tasks.
