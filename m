Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1210B5A5212
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiH2Qpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiH2Qpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:45:45 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA902F671
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:45:43 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x5so6567428qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fDt4IBgtt5exwhmeKX+OT1Q9RovTLDUYtPqjcVD2JHU=;
        b=iToL8uE5DE1tqOsdsobu/E8FmFht38INvZNaS1aWZFtpVp5DmnDAEIq4KnUs5zhAdu
         uzaPlYoUTO5wAgOX5iwvOnsurmIfNdp4EPlpyhxA+CyEYkqONNXEkxac07Sqd0ePgqro
         R+KOIrw/Oq10P3GNBl96SKl+ERU6Rqi/nmyZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fDt4IBgtt5exwhmeKX+OT1Q9RovTLDUYtPqjcVD2JHU=;
        b=nMeuOWS5BhtKcb+3ATD8V2nEBHyioFlGx4N/r+voB1hoRfIzi6aZZgIAkcEwctIK2c
         lUgbzwRl+1b9wGLnWgfUksfcXdBf5yCqsfgEzmrhSZSwA0L0YPzZQxEbWUvE8TvfyAeE
         izQh2z0NIm9Kr09nz+Q+38QyUNcFYisooCCKHoVpbvCbZ5N01/4ZfYg6A81fueCbzhIy
         XOlguZIMg6RP8zVzLpvugIVsXD3ZupXmer8v5l6DsU/rxq5r0lSSiaUuRDYX4FSlZVoR
         A2QxrazMi648zJcTCsJ2h3/lktxaCbAkHE3a4MzRNR8VlzNXPvbVqsLKz1pZ2qpQAXmI
         akrg==
X-Gm-Message-State: ACgBeo3pPPy8IUQdAga3F6B9x1JHuhV5XtpHnAjTcyTmE6r41+3xI2Ix
        BiLAIU71tOlj0uH5dSQQZ5j1fg==
X-Google-Smtp-Source: AA6agR4+RWQgms3oFXpW5BnC2J62dhhNHmynoWse/Pah2gSlvOSjcovV9+ApiaFW1yRHX/Q8mt68hw==
X-Received: by 2002:a05:622a:143:b0:344:95bf:8f02 with SMTP id v3-20020a05622a014300b0034495bf8f02mr10573138qtw.202.1661791541845;
        Mon, 29 Aug 2022 09:45:41 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id s18-20020a05620a255200b006bbc09af9f5sm6516375qko.101.2022.08.29.09.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:45:41 -0700 (PDT)
Message-ID: <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
Date:   Mon, 29 Aug 2022 12:45:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220829134045.GA54589@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederick,

On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
> On Fri, Aug 19, 2022 at 08:48:43PM +0000, Joel Fernandes (Google) wrote:
>> Refresh tested on real ChromeOS userspace and hardware, passes boot time tests
>> and rcuscale tests.
>>
>> Fixes on top of v3:
>> - Fix boot issues due to a race in the lazy RCU logic which caused a missed
>>   wakeup of the RCU GP thread, causing synchronize_rcu() to stall.
>> - Fixed trace_rcu_callback tracepoint
>>
>> I tested power previously [1], I am in the process of testing power again but I
>> wanted share my latest code as others who are testing power as well could use
>> the above fixes.
> 
> Your patch is very likely to be _generally_ useful and therefore,
> the more I look into this, the more I wonder if it is a good idea to rely on
> bypass at all, let alone NOCB. Of course in the long term the goal is to have
> bypass working without NOCB but why even bothering implementing it for nocb
> in the first place?

This was discussed with Paul [1]. Quoting:

----
Joel:
>> Also, does doing so not prevent usage of lazy CBs on systems without
>> NOCB? So if we want to future-proof this, I guess that might not be a
>> good decision.
>
Paul:
> True enough, but would this future actually arrive?  After all, if
> someone cared enough about energy efficiency to use call_rcu_lazy(),
> why wouldn't they also offload callbacks?

Joel: I am not sure, but I also don't mind making it depend on NOCB for now
(see below).

[1] https://www.spinics.net/lists/rcu/msg07908.html
----

While I agree with you that perhaps making it more generic is better, this did
take a significant amount of time, testing and corner case hunting to come up
with, and v5 is also in the works so I'd appreciate if we can do it the
bypass-way and optimize later. Arguably the bypass way is quite simple and
allows us to leverage its effects of rcu_barrier and such. And the API will not
change.

> Several highlights:
> 
> 1) NOCB is most often needed for nohz_full and the latter has terrible power
> management. The CPU 0 is active all the time there.

I see. We don't use nohz_full much. NOCB itself gives good power improvement.

> 2) NOCB without nohz_full has extremely rare usecase (RT niche:
> https://lore.kernel.org/lkml/CAFzL-7vqTX-y06Kc3HaLqRWAYE0d=ms3TzVtZLn0c6ATrKD+Qw@mail.gmail.com/
> )

Really? Android has been using it for a long time. It seems to be quite popular
in the battery-powered space.

> 2) NOCB implies performance issues.

Which kinds of? There is slightly worse boot times, but I'm guessing that's do
with the extra scheduling overhead of the extra threads which is usually not a
problem except that RCU is used in the critical path of boot up (on ChromeOS).

> 3) We are mixing up two very different things in a single list of callbacks:
>    lazy callbacks and flooding callbacks, as a result we are adding lots of
>    off-topic corner cases all around:
>      * a seperate lazy len field to struct rcu_cblist whose purpose is much more
>        general than just bypass/lazy
>      * "lazy" specialized parameters to general purpose cblist management
>        functions

I think just 1 or 2 functions have a new lazy param. It didn't seem too
intrusive to me.

> 4) This is further complexifying bypass core code, nocb timer management, core
>    nocb group management, all of which being already very complicated.

True, I agree, a few more cases to handle for sure, but I think I got them all
now (hopefully).

> 5) The !NOCB implementation is going to be very different
> 
> Ok I can admit one counter argument in favour of using NO_CB:
> 
> -1) The scheduler can benefit from a wake CPU to run the callbacks on behalf of a bunch
> of idle CPUs, instead of waking up that bunch of CPUs. But still we are dealing
> with callbacks that can actually wait...

Yeah that's huge. Significant amount of power improvement seems to come from
idle CPUs not being disturbed and their corresponding timer ticks turned off for
longer periods. That's experimentally confirmed (NO_CB giving significant power
improvement on battery-power systems as compared to !NO_CB).

> 
> So here is a proposal: how about forgetting NOCB for now and instead add a new
> RCU_LAZY_TAIL segment in the struct rcu_segcblist right after RCU_NEXT_TAIL?
> Then ignore that segment until some timer expiry has been met or the CPU is
> known to be busy? Probably some tiny bits need to be tweaked in segcblist
> management functions but probably not that much. And also make sure that entrain()
> queues to RCU_LAZY_TAIL.
> 
> Then the only difference in the case of NOCB is that we add a new timer to the
> nocb group leader instead of a local timer in !NOCB.

It sounds reasonable, but I'll go with Paul on the usecase argument - who would
actually care about lazy CBs outside of power, and would those guys ever use
!NO_CB if they cared about power / battery?

Thanks,

 - Joel



