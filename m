Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B15A6C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiH3SrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiH3SrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:47:04 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430B67C93
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:47:02 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l5so9385621qvs.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XaXlF349lOKckpeRFZDQNo5GwNs0MMYghB0K5tskEEA=;
        b=v2Em28vJsFBxBufUF/UfGuZsx0qmO1twBw6Du9kdtlLTlSUTLRWLJKsvNJuHfTNxNt
         0UOo8jfgTrVj7vUnWZYdWCHIqLtLRaryAknxGqPmsUtfipNUWVah4oHCUMWxbP8qMvP3
         YcEWVHQsCqmn6Jbi8oT3NZkdRTDcEMh0U2EbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XaXlF349lOKckpeRFZDQNo5GwNs0MMYghB0K5tskEEA=;
        b=rWWY6JFHAPRBCoqptA4t7K3Sdqwjr54UM6laNvltz3ll6DgioO5K96DeGzK2xB4R2O
         hoZaMrhHT3R5ZWcVtynrQKBWaQsUU9U8F1V7YN5IrxssOrUirkPnI1mt1qsSbMF7pz1d
         tpzlSiNQjn1lX7xFl09zf8IczQZsTbsEo9wRvUcI1CCS69fz93UmzOECRo2XJOweI66Q
         ItpvkWqWVNfgf4mAvp0bR917khCRv9ve2Wxbp2s6+Eewio2WVni18V+43Fiy+e1Ow9fz
         yQFaSqe0LFHub/vrWdka4eN2x+483IQ4JUL9S27aYIUDmHB7s2FEfhVj7ymboSXQ022t
         QJaw==
X-Gm-Message-State: ACgBeo11O2HDh1aEGtL3q5v7t+Xkv8mCpLra36TocxEPVpphZbZyei71
        L3pCbXWlQuR1XY34iJOjtfrIBA==
X-Google-Smtp-Source: AA6agR4oKF8hpWH3cMJA+GxQhC85lxseU3x3imVzSGoaVv3jtv/sBtxUEAAXMdXk9mmAVhkeq7jAbg==
X-Received: by 2002:a05:6214:ccf:b0:499:72d:ccf9 with SMTP id 15-20020a0562140ccf00b00499072dccf9mr7640496qvx.116.1661885221571;
        Tue, 30 Aug 2022 11:47:01 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id l5-20020a37f905000000b006af3f3b385csm8448512qkj.98.2022.08.30.11.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 11:47:01 -0700 (PDT)
Message-ID: <de01d018-c2c7-95a5-2bf6-9128ba9dd133@joelfernandes.org>
Date:   Tue, 30 Aug 2022 14:46:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen> <20220830162244.GA73392@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220830162244.GA73392@lothringen>
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



On 8/30/2022 12:22 PM, Frederic Weisbecker wrote:
> On Tue, Aug 30, 2022 at 06:03:16PM +0200, Frederic Weisbecker wrote:
>> On Tue, Aug 30, 2022 at 04:43:43AM -0700, Paul E. McKenney wrote:
>>> On Tue, Aug 30, 2022 at 12:53:24PM +0200, Frederic Weisbecker wrote:
>>>> On Mon, Aug 29, 2022 at 01:42:02PM -0700, Paul E. McKenney wrote:
>>>>> On Mon, Aug 29, 2022 at 04:36:40PM -0400, Joel Fernandes wrote:
>>>>>> On Mon, Aug 29, 2022 at 3:46 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>>>>>>> On Mon, Aug 29, 2022 at 12:45:40PM -0400, Joel Fernandes wrote:
>>>>>>>> On 8/29/2022 9:40 AM, Frederic Weisbecker wrote:
>>>>>
>>>>> [ . .  . ]
>>>>>
>>>>>>>>> 2) NOCB implies performance issues.
>>>>>>>>
>>>>>>>> Which kinds of? There is slightly worse boot times, but I'm guessing that's do
>>>>>>>> with the extra scheduling overhead of the extra threads which is usually not a
>>>>>>>> problem except that RCU is used in the critical path of boot up (on ChromeOS).
>>>>>>>
>>>>>>> I never measured it myself but executing callbacks on another CPUs, with
>>>>>>> context switches and locking can only involve significant performance issues if callbacks
>>>>>>> are frequent. So it's a tradeoff between power and performance.
>>>>>>
>>>>>> In my testing of benchmarks on real systems with 8-16 CPUs, the
>>>>>> performance hit is down in the noise. It is possible though that maybe
>>>>>> one can write a non-realistic synthetic test to force the performance
>>>>>> issues, but I've not seen it in the real world. Maybe on
>>>>>> networking-heavy servers with lots of cores, you'll see it but their
>>>>>> batteries if any would be pretty big :-).
>>>>>
>>>>> To Frederic's point, if you have enough servers, even a 1% decrease in
>>>>> power consumption is a very big deal.  ;-)
>>>>
>>>> The world has enough servers, for that matters ;-)
>>>
>>> True enough!  Now you need only demonstrate that call_rcu_lazy() for
>>> !rcu_nocbs servers would actually deliver that 1%.  ;-)
>>
>> Well, !rcu_nocbs is not only used by server but also by pretty much
>> everything else, except android IIUC. I can't really measure the whole
>> world but I don't see how the idleness of a server/router/desktop/embedded/rt/hpc
>> device differs from the idleness of an android device.
>>
>> But ok I'll try to measure that.
> 
> Although who knows, may be some periodic file operation while idle are specific
> to Android. I'll try to trace lazy callbacks while idle and the number of grace
> periods associated.

One potential usecase could be logging if the logger is opening and closing log
files during logging updates. Uladzislau reported this on Android, that a system
logger was doing file open/close and triggering RCU that way (file table,
dentry, inode code all queue RCU callbacks).

Thanks,

 - Joel

