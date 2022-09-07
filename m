Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A645AFA51
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiIGC4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIGC4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:56:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C407F0A6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:56:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i9so3668076qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8Hov7IcVx/B7b9bwAwFPiaMdYKRwrKvRA1PUcIT81uA=;
        b=RiyJMPZkSlURBfVjeX9ou+JOhz7b+gVRNvFHKxnqFXJGbfBdLM1gPG+1sC53OmGACI
         3a24ZCcjyB/r7ZRtljaAXKHJpWsMR7Dhfj5KJd2KOLq1a2os+IgmmpG7QmTAdgkUeOvn
         1ADu6hFSFGl2czVX+GFso+EjyS+mYRH36JjIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8Hov7IcVx/B7b9bwAwFPiaMdYKRwrKvRA1PUcIT81uA=;
        b=r5Bgx6eef6nEdCAoz1hKMIFvhB40vNRyQ82aTlVg3JK3QpV7umjlvBs3Cz+DXICih6
         zmSdl/Lt6ZlvuRhX9hyBXYk7d1fCYGgylIc2ZRHw83HCd6Ss6Z6XQH83usHyJ2OBNiJ3
         SuW3NQuOU+vb5VrA104HxlsxrlsKnjTkH5jM7vjhayP7MfkHLKXg26X12v7xmsgAD9rr
         10ani/J4ZoVpZORjKnxkirKKHxWXapFV8N9x2uS1ZF5qpr+PKuErwMm5s1B6C7Hddtoc
         bLjdYz7/5KkKKRXFiCRc3YQlax/wGnkULq+bUDN79S2pBQ1axm5yvkb86kqKg7KIXAdT
         4kBA==
X-Gm-Message-State: ACgBeo35ESkfa9qmkNAg1nEmt/8CimkMWuTRLEboJk7OIgejh2MslAj3
        BcK7dyW94xPBTR7ip7wTQY+1WQ==
X-Google-Smtp-Source: AA6agR7P6x0pjzyF0xSF4UgrTmPl1Pp548QPKGMoQBamMrZIyKN/mO3jw8B26rBSF7wbRHOGYDF7yA==
X-Received: by 2002:a05:620a:1590:b0:6be:6c26:469b with SMTP id d16-20020a05620a159000b006be6c26469bmr1294067qkk.415.1662519362670;
        Tue, 06 Sep 2022 19:56:02 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id l22-20020a05620a28d600b006bbc3724affsm14090000qkp.45.2022.09.06.19.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 19:56:02 -0700 (PDT)
Message-ID: <8812ea75-ef14-0d5d-19d8-bda70394b41a@joelfernandes.org>
Date:   Tue, 6 Sep 2022 22:56:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen> <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
 <64f5770c-df37-8975-200d-7908de23fa73@joelfernandes.org>
 <da45d265-52f9-6314-7fcd-ea71e2bf4cec@joelfernandes.org>
 <4f6061f0-0de7-2916-dc6e-9f5af9b944c0@joelfernandes.org>
 <20220906191110.GA187950@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220906191110.GA187950@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2022 3:11 PM, Frederic Weisbecker wrote:
> On Tue, Sep 06, 2022 at 12:43:52PM -0400, Joel Fernandes wrote:
>> On 9/6/2022 12:38 PM, Joel Fernandes wrote:
>> Ah, now I know why I got confused. I *used* to flush the bypass list before when
>> !lazy CBs showed up. Paul suggested this is overkill. In this old overkill
>> method, I was missing a wake up which was likely causing the boot regression.
>> Forcing a wake up fixed that. Now in v5 I make it such that I don't do the flush
>> on a !lazy rate-limit.
>>
>> I am sorry for the confusion. Either way, in my defense this is just an extra
>> bit of code that I have to delete. This code is hard. I have mostly relied on a
>> test-driven development. But now thanks to this review and I am learning the
>> code more and more...
> 
> Yeah this code is hard.
> 
> Especially as it's possible to flush from both sides and queue the timer
> from both sides. And both sides read the bypass/lazy counter locklessly.
> But only call_rcu_*() can queue/increase the bypass size whereas only
> nocb_gp_wait() can cancel the timer. Phew!
> 

Haha, Indeed ;-)

> Among the many possible dances between rcu_nocb_try_bypass()
> and nocb_gp_wait(), I haven't found a way yet for the timer to be
> set to LAZY when it should be BYPASS (or other kind of accident such
> as an ignored callback).
> In the worst case we may arm an earlier timer than necessary
> (RCU_NOCB_WAKE_BYPASS instead of RCU_NOCB_WAKE_LAZY for example).
> 
> Famous last words...

Agreed.

On the issue of regressions with non-lazy things being treated as lazy, I was
thinking of adding a bounded-time-check to:

[PATCH v5 08/18] rcu: Add per-CB tracing for queuing, flush and invocation.

Where, if a non-lazy CB takes an abnormally long time to execute (say it was
subject to a race-condition), it would splat. This can be done because I am
tracking the queue-time in the rcu_head in that patch.

On another note, boot time regressions show up pretty quickly (at least on
ChromeOS) when non-lazy things become lazy and so far with the latest code it
has fortunately been pretty well behaved.

Thanks,

 - Joel
