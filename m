Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC65A6C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiH3Skp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiH3Skd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:40:33 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4E0275CF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:40:30 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r6so9266272qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ujKtYZWkqPWJ0rAahC5tNvpJoUsawP+7mlaKliAMVqw=;
        b=Vg342SWCgXX6Ws9hP2+aHD/F+KzEVh4IaHzkG9irtTiDxx0BEkKg7sBZir7Rrr8FbH
         WA48FFHScmF/1986/uWWQ4p1p4nb15Ii5qIX0zoVmXOzfs5pISG0RruUzrFfdTGQ+dAQ
         BTLzeGkE9XuInhqsV7uTZ6E1BnWcu4rEAs8B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ujKtYZWkqPWJ0rAahC5tNvpJoUsawP+7mlaKliAMVqw=;
        b=u7NTp7oHBBQDljSMA4mts+wwxEscrlMvenGEk9GUzbeBlmq4/8vVdS5dIonKqQrgAI
         XXGIVktxeiuraHw8UDXG4m8cUp0uLLgiqlrPNLEnn0iGKSdZOKNJRRARRzuMYbodg0tz
         0Vr8Px2ABzoyZEkSzoYD3ZQz5qDaaCvW+zvmqx3ug+iWz6bz8ueTLyB+d8k3JbPQa88C
         FCVlE8ppxjeU7dE44OWFnjxXWG7zkzL2HWBiQIu6zcYHXehpmKrJtsRZeIgMKax/ucUC
         nuErxNZsayysz/wfYiDkLdeUeLsKoz29ntzoKd26HXe7E7uiXq2DYDy5/F/8T19s/zZl
         9INA==
X-Gm-Message-State: ACgBeo1mkeqK9WwCaVIWffwvw9RkkQIdiwNvQt6Di6zudUSsd7Wm1VLv
        BN8/KuIKDSki6QZfKq1rhlT8lw==
X-Google-Smtp-Source: AA6agR53BILwU6j8+ChzRZxYFHFCKAkOenTMkx9tNaQV0tVFgO4LyWwIybXNECZh9UmcvV7OiaXUaw==
X-Received: by 2002:a05:622a:1302:b0:344:8a9d:817d with SMTP id v2-20020a05622a130200b003448a9d817dmr15966873qtk.339.1661884829807;
        Tue, 30 Aug 2022 11:40:29 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id m10-20020a05620a290a00b006bb87c4833asm8790543qkp.109.2022.08.30.11.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 11:40:29 -0700 (PDT)
Message-ID: <606288d9-5d59-ad7d-c945-e8418b375c51@joelfernandes.org>
Date:   Tue, 30 Aug 2022 14:40:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
 <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220830102619.GB58291@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220830102619.GB58291@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederick,

On 8/30/2022 6:26 AM, Frederic Weisbecker wrote:
> On Mon, Aug 29, 2022 at 04:36:40PM -0400, Joel Fernandes wrote:
[..]
>>>>> 2) NOCB without nohz_full has extremely rare usecase (RT niche:
>>>>> https://lore.kernel.org/lkml/CAFzL-7vqTX-y06Kc3HaLqRWAYE0d=ms3TzVtZLn0c6ATrKD+Qw@mail.gmail.com/
>>>>> )
>>>>
>>>> Really? Android has been using it for a long time. It seems to be quite popular
>>>> in the battery-powered space.
>>>
>>> It's really sad that this is the first time I hear about that. I've been working
>>> on this code for years now without this usecase in mind. And yet it's fundamental.
>>>
>>> I asked several times around about other usecases of rcu_nocbs than nohz_full=
>>> and nobody reported that. I can hardly even google a significant link
>>> between power saving and rcu_nocbs=
>>>
>>> If this is really used that way for a long time then it's a cruel disconnection
>>> between users and developers.
>>
>> I was not involved with Android or RCU back then. But my guess is I
>> don't think it was enabled with the intent of saving power, it is just
>> that using RCU_NO_CB_CPU has become the way to go to keep dynick-idle
>> CPUs undisturbed: https://paulmck.livejournal.com/66807.html . Paul ,
>> +Dietmar Eggemann can probably provide more history.
> 
> Thanks for the pointer!

No problem. Paul proves to us that any and every bit of writing effort pays off
in one way or the other :-D.

>>>>> 2) NOCB implies performance issues.
>>>>
>>>> Which kinds of? There is slightly worse boot times, but I'm guessing that's do
>>>> with the extra scheduling overhead of the extra threads which is usually not a
>>>> problem except that RCU is used in the critical path of boot up (on ChromeOS).
>>>
>>> I never measured it myself but executing callbacks on another CPUs, with
>>> context switches and locking can only involve significant performance issues if callbacks
>>> are frequent. So it's a tradeoff between power and performance.
>>
>> In my testing of benchmarks on real systems with 8-16 CPUs, the
>> performance hit is down in the noise. It is possible though that maybe
>> one can write a non-realistic synthetic test to force the performance
>> issues, but I've not seen it in the real world. Maybe on
>> networking-heavy servers with lots of cores, you'll see it but their
>> batteries if any would be pretty big :-).
> 
> Yeah I suspect this should have an impact on servers. And even servers may
> deserve idleness sometimes.

Sure. I think I am pretty sure you will see power savings on servers but I guess
the big question is will you regress server workloads with those savings. I do
remember, Eric Dumazet from Google posting to LKML that callback flooding can
happen on servers.

>>>>> 3) We are mixing up two very different things in a single list of callbacks:
>>>>>    lazy callbacks and flooding callbacks, as a result we are adding lots of
>>>>>    off-topic corner cases all around:
>>>>>      * a seperate lazy len field to struct rcu_cblist whose purpose is much more
>>>>>        general than just bypass/lazy
>>>>>      * "lazy" specialized parameters to general purpose cblist management
>>>>>        functions
>>>>
>>>> I think just 1 or 2 functions have a new lazy param. It didn't seem too
>>>> intrusive to me.
>>>
>>> What bothers me is that struct cblist has a general purpose and we are adding a field
>>> and a parameter that is relevant to only one specialized user.
>>
>> To Paul's point, we can change it to a flag I think. The 3 states are:
>> - no CBs.
>> - All lazy
>> - All non-lazy
> 
> Yeah that makes sense, should we take the generic direction!

Sure, thanks.

>>
>> Or, worse case, we can move the flag to the per-cpu rcu_data
>> structure, I think. Does that alleviate your concern?
>>
>>>>> 4) This is further complexifying bypass core code, nocb timer management, core
>>>>>    nocb group management, all of which being already very complicated.
>>>>
>>>> True, I agree, a few more cases to handle for sure, but I think I got them all
>>>> now (hopefully).
>>>
>>> Now I'm worried about maintainability. Hence why I'd rather see a generic code
>>> for them all if possible.
>>
>> Maintainability is a concern for any new code. I rely a lot on testing
>> both synthetic, and real-world. I have spent a lot of time on test
>> code on this.
> 
> And I thank you for that. I've always been terrible at performance/power/latency
> testing so I'm always relieved when others take over on that :)

Thanks, appreciate it.

>>>
>>> Note I'm not stricly opposed to the current approach. But I can't say I'm
>>> comfortable with it.
>>
>> Maybe we can find a way in the code to see what can be changed. One
>> concern you rightly raised is the length variables , but I think
>> that's not a blocker.
> 
> That's just a detail indeed. If we proceed with the current NOCB approach I'll
> give a deeper review.
> 
>>
>>> Can we do a simple test? Would it be possible to affine every rcuo%c/%d kthread
>>> to the corresponding CPU%d? For example affine rcuop/1 to CPU 1, rcuop/2 to
>>> CPU2, etc... And then relaunch your measurements on top of that?
>>
>> We already did that and it does not help, it makes things worse. The
>> decision of where to run RCU threads is best left to the scheduler
>> (for both performance and power).
> 
> That's the point, we want to artificially remove NOCB advantages to get
> a behaviour close to !NOCB, so that we know if it's worth expanding the
> patchset to !NOCB.
> Let me clarify. The point of NOCB, powerwise, is that the RCU kthreads
> track and execute the callbacks to an optimized selection of CPUs, thanks to the
> scheduler. And the new lazy flow optimize that further.
> 
> Now we would like to know if call_rcu_lazy() also works on !NOCB. But we have
> no way to test that right now because we only have an implemention for NOCB.

I am happy to try this, but I want to make a counter-suggestion. You can 'hack'
a behavior similar to call_rcu_lazy() by just increasing jiffiest_till_first_fqs
to 24 or 48 (via boot param). The downside of doing this, you'll slow down
synchronize_rcu() and tracing will be slow. That can be remedied by passing
rcupdate.rcu_expedited boot parameter to speed up synchronous_rcu(). However, it
will still slow down *all* call_rcu(). Neverthless, its a neat trick to see the
light at the end of the tunnel but not for product.

Would it be possible for you try this out with some workloads on a server, or
even the server just being idle?

Just to mention - the power savings between NO_CB and !NO_CB is enormous for us
(40% !!). We attributed this directly to the tick not getting turned off and the
hardware SoC thus not entering a deeper SoC-wide lower state (known as package
C-state). While a server does not typically have an SoC, I suspect *some* power
savings at least.

> But if we affine each rcuop/%d to their corresponding CPU%d, we get a behaviour
> that is close to !NOCB because then the scheduler doesn't help anymore and
> callbacks are executed locally (the only difference is that we do context
> switches, locking and and we still have rcuog around but still, that
> should give a rough idea of what we get with !NOCB).
> 
> Therefore if you test your measurements again before and after your patchset,
> both with each rcuop/%d affine to their CPU%d counterpart, you should get a
> comparison of before VS after your patchset on what would be an implementation
> on !NOCB.

My suspicion is that if I did this experiment on my hardware, it will still not
give  you a good idea of what a server will see. Because I don't have those kind
of  workloads or many-CPU hardware. So it may not be that representative of what
the !NOCB world wants. Further, my hardware is an Intel SoC which is more
integrated than a typical server board so SoC-wide power savings might not be
representative of the server hardware. However, I am happy to try out your
suggestion out of respect for you, if you still feel its worth doing.

Thanks,

 - Joel




