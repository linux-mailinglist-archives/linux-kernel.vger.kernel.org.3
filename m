Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFF5A9C8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiIAQHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiIAQHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:07:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5886B8D2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:07:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g14so13776399qto.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=exC6YY5zWRwfyIDcwOV/QzXSEf/bvkhfxpYyDtTJv38=;
        b=RC8G2iP3Qz9ef0HlJibnz5RMtMYN0kFgkvXzu/0RYxDmJ2BYVdycg4Z0M/NPkJPifl
         Stx4OybWmlicuifPeVvdHT8Q/hviplEO6ZtAmVio7GkbFfYslOOcRmWJJUaJNZWcpCg7
         eSIY3nz1oUCqIRvroOgOu4zUqjzrl95Ey3BvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=exC6YY5zWRwfyIDcwOV/QzXSEf/bvkhfxpYyDtTJv38=;
        b=uYeI30b02eSSctIXlAjaHqhCMwfx9PRrZXfxkGnYF61KSVZC9fPLlgvINrp2m7G7wE
         FDCQuI02obQFcWNM/iV3LbeqyMBIEu2Wzl2d+ri9rCURKD/vpJpyF4CDJxB+fKMZfPtD
         AZPMHV+X+lvw1RufSbzA83TBY323oQuGHS1E7LAi92lnPRHHhoEX0KVmzfF6Liwwjfhe
         U/LwJwCZARNwsuq0g4vPxa4PYHJApHV4+4VQitWqYmnYFqcNrhSoSBkZdLWZUXBxCMnn
         Ws39AM/yK+f0fui+cRnbuCna1g0cpp2ccS5nYfn8pO1UJAFeNHHMxdTZsgoY7OdFW4zA
         POlQ==
X-Gm-Message-State: ACgBeo2SCj1aN/NVKjDADrBrkvL8N4cE7z6ljHzUakoejUkEayo58/Y9
        Wp4UK/HnKhP9AvCG2ThlOXuY7g==
X-Google-Smtp-Source: AA6agR59WsOFotPEzy5AIS7rCnUJWQeP6vcmOBUIDhQmX7v1s9LezD2tI6+xpuRIlahHZggnPecElQ==
X-Received: by 2002:ac8:5989:0:b0:343:4e22:c09b with SMTP id e9-20020ac85989000000b003434e22c09bmr23564499qte.520.1662048430057;
        Thu, 01 Sep 2022 09:07:10 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bp44-20020a05622a1bac00b0034355a352d1sm10241880qtb.92.2022.09.01.09.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:07:09 -0700 (PDT)
Message-ID: <edf7f0c9-6e17-be83-69bb-0ec421a3a352@joelfernandes.org>
Date:   Thu, 1 Sep 2022 12:07:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
References: <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen> <20220830162244.GA73392@lothringen>
 <Yw4+g/0yEf7fpHrh@pc636> <20220901112947.GA105556@lothringen>
 <YxCejoKH8dGIeW22@pc636> <20220901151350.GC105556@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220901151350.GC105556@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2022 11:13 AM, Frederic Weisbecker wrote:
> On Thu, Sep 01, 2022 at 01:59:10PM +0200, Uladzislau Rezki wrote:
>> On Thu, Sep 01, 2022 at 01:29:47PM +0200, Frederic Weisbecker wrote:
>>> On Tue, Aug 30, 2022 at 06:44:51PM +0200, Uladzislau Rezki wrote:
>>>> Hello, Frederic.
>>>>
>>>>>
>>>>> Although who knows, may be some periodic file operation while idle are specific
>>>>> to Android. I'll try to trace lazy callbacks while idle and the number of grace
>>>>> periods associated.
>>>>>
>>>>>
>>>> Everything related to lazy call-backs is about not waking "nocb"
>>>> kthreads in order to offload one or i should say few callbacks
>>>> because it is more or less useless. Currently if incoming callback
>>>> is the only one, it will kick a GP whereas a GP will kick nocb_kthread
>>>> to offload.
>>>
>>> Not sure this is only about not waking "nocb" kthreads. The grace period
>>> kthread is also awaken in !NOCB and has quite some work to do. And there,
>>> having a server expands the issue because you may have a lot of CPUs's extended
>>> quiescent states to check.
>>>
>> I mean here the following combination: NOCB + call_rcu_lazy() tandem.
>> The !NOCB is not about power save, IMHO. Because it implies callbacks
>> to be processed on CPUs they are landed.
> 
> I'm sorry but I still feel confused reading that !NOCB is not about power
> save. To me everything is about power save. NOCB just appears to help optimizing
> it without significant tradeoff on some given workloads.

Right, I think Fred is coming from the reasonable perspective of "Save power by
making !NOCB RCU do less" (i.e. delay softirq, main GP thread, QS reports etc)
which I think is also valid (not sure how much power that saves on servers but
sounds reasonable to measure). When you hack your implementation to test that,
it would be reasonable to also apply the old FAST NOHZ patch and measure
with/without that.

> 
>> In this scenario you can not let the EAS scheduler to find a more
>> efficient CPU for further handling.
> 
> Sure but that doesn't mean there wouldn't be a power saving gain anyway.

Yes there might be.

Thanks,

 - Joel
