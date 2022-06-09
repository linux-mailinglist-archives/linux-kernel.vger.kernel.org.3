Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1795453B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbiFISIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbiFISI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:08:28 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8EB194BFC;
        Thu,  9 Jun 2022 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654798102; x=1686334102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RlBNIvoycybee5OdSn9wESzBDW5U1rv7sgD4z0EOSQo=;
  b=WrJocN5G+JzbP1cE6y7MBSahzUVNDWubHp1pd58D4WXytIWs0uTROH9+
   ezzjNjIZwQAPfddnhRU7ZuB4e48/nnD7kZPDmCVtnO6MoMteif6Mql1UP
   Sx1wgXgPC75suURTrvduCLImr46Q4EQPr2LkG9b9LaooI3s1txdYgUO7L
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Jun 2022 11:08:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 11:08:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 9 Jun 2022 11:08:19 -0700
Received: from [10.216.5.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 9 Jun 2022
 11:08:15 -0700
Message-ID: <349a6a9b-28a9-e859-0db2-d216553d8ad5@quicinc.com>
Date:   Thu, 9 Jun 2022 23:38:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: minor fixes to
 get_clk_div_rate()
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Stephen Boyd" <swboyd@chromium.org>
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
 <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com>
 <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
 <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com>
 <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
 <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com>
 <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
 <da18c508-f32e-fece-6392-e6a95f7c7968@quicinc.com>
 <CAD=FV=Wytm9EYu=4ndN+En2AFEgPK9NjrUMbFPA_h6TwyxGCYA@mail.gmail.com>
 <765a170c-d335-d626-0609-7d0f3967b71d@quicinc.com>
 <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Re-sending as my earlier message bounced.


On 6/9/2022 4:07 AM, Doug Anderson wrote:
> Hi,
>
> On Wed, Jun 8, 2022 at 11:34 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> Hi,
>>
>>
>> On 6/8/2022 12:55 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Tue, Jun 7, 2022 at 10:40 AM Vijaya Krishna Nivarthi
>>> <quic_vnivarth@quicinc.com> wrote:
>>>> Hi,
>>>>
>>>> On 6/7/2022 1:29 AM, Doug Anderson wrote:
>>>>
>>>> My only concern continues to be...
>>>>
>>>> Given ser_clk is the final frequency that this function is going to
>>>> return and best_div is going to be the clk_divider, is it ok if the
>>>> divider cant divide the frequency exactly?
>>>>
>>>> In other words, Can this function output combinations like (402,4)
>>>> (501,5) ?
>>>>
>>>> If ok, then we can go ahead with this patch or even previous perhaps.
>>> I don't see why not. You're basically just getting a resulting clock
>>> that's not an integral "Hz", right?
>>>
>>> So if "baud" is 9600 and sampling_rate is 16 then desired_clk is (9600
>>> * 16) = 153600
>>>
>>> Let's imagine that we do all the math and we finally decide that our
>>> best bet is with the rate 922000 and a divider of 6. That means that
>>> the actual clock we'll make is 153666.67 when we _wanted_ 153600.
>>> There's no reason it needs to be integral, though, and 153666.67 would
>>> still be better than making 160000.
>>>
>> Thank you for clarification.
>>>>> power?)
>>>> Actually power saving was the anticipation behind returning first
>>>> frequency in original patch, when we cant find exact frequency.
>>> Right, except that if you just pick the first clock you find it would
>>> be _wildly_ off. I guess if you really want to do this the right way,
>>> you need to set a maximum tolerance and pick the first rate you find
>>> that meets that tolerance. Random web search for "uart baud rate
>>> tolerance" makes me believe that +/- 5% deviation is OK, but to be
>>> safe you probably want something lower. Maybe 2%? So if the desired
>>> clock is within 2% of a clock you can make, can you just pick that
>>> one?
>> Ok, 2% seems good.
>>>>>> Please note that we go past cases when we have an divider that can
>>>>>> exactly divide the frequency(105/1, 204/2, 303/3) and end up with one
>>>>>> that doesn't.
>>>>> Ah, good point. Luckily that's a 1-line fix, right?
>>>> Apologies, I could not figure out how.
>>> Ah, sorry. Not quite 1 line, but this (untested)
>>>
>>>
>>> freq = clk_round_rate(clk, mult);
>>>
>>> if (freq % desired_clk == 0) {
>>>    ser_clk = freq;
>>>    best_div = freq / desired_clk;
>>>    break;
>>> }
>>>
>>> candidate_div = max(1, DIV_ROUND_CLOSEST(freq, desired_clk));
>>> candidate_freq = freq / candidate_div;
>>> diff = abs((long)desired_clk - candidate_freq);
>>> if (diff < best_diff) {
>>>     best_diff = diff;
>>>     ser_clk = freq;
>>>     best_div = candidate_div;
>>> }
>> But then once again, we would likely need 2 loops because while we are
>> ok with giving up on search for best_div on finding something within 2%
>> tolerance, we may not want to give up on exact match (freq % desired_clk
>> == 0 )
> Ah, it took me a while to understand why two loops. It's because in
> one case you're trying multiplies and in the other you're bumping up
> to the next closest clock rate. I don't think you really need to do
> that. Just test the (rate - 2%) and the rate. How about this (only
> lightly tested):
>
>      ser_clk = 0;
>      maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
>      div = 1;
>      while (div < maxdiv) {
div <= maxdiv ?
>          mult = (unsigned long long)div * desired_clk;
>          if (mult != (unsigned long)mult)
>              break;
>
>          two_percent = mult / 50;
>
>          /*
>           * Loop requesting (freq - 2%) and possibly (freq).
>           *
>           * We'll keep track of the lowest freq inexact match we found
>           * but always try to find a perfect match. NOTE: this algorithm
>           * could miss a slightly better freq if there's more than one
>           * freq between (freq - 2%) and (freq) but (freq) can't be made
>           * exactly, but that's OK.
>           *
>           * This absolutely relies on the fact that the Qualcomm clock
>           * driver always rounds up.
>           */
>          test_freq = mult - two_percent;
>          while (test_freq <= mult) {
>              freq = clk_round_rate(clk, test_freq);
>
>              /*
>               * A dead-on freq is an insta-win. This implicitly
>               * handles when "freq == mult"
>               */
>              if (!(freq % desired_clk)) {
>                  *clk_div = freq / desired_clk;
>                  return freq;
>              }
>
>              /*
>               * Only time clock framework doesn't round up is if
>               * we're past the max clock rate. We're done searching
>               * if that's the case.
>               */
>              if (freq < test_freq)
>                  return ser_clk;
>
>              /* Save the first (lowest freq) within 2% */
>              if (!ser_clk && freq <= mult + two_percent) {
>                  ser_clk = freq;
>                  *clk_div = div;
>              }
My last concern is with search happening only within 2% tolerance.

Do we fail otherwise?

This real case has best tolerance of 1.9%.

[   17.963672] 20220530 desired_clk-51200000
[   21.193550] 20220530 returning ser_clk-52174000, div-1, diff-974000

Seems close.

Thank you.
>
>              /*
>               * If we already rounded up past mult then this will
>               * cause the loop to exit. If not then this will run
>               * the loop a second time with exactly mult.
>               */
>              test_freq = max(freq + 1, mult);
>          }
>
>          /*
>           * test_freq will always be bigger than mult by at least 1.
>           * That means we can get the next divider with a DIV_ROUND_UP.
>           * This has the advantage of skipping by a whole bunch of divs
>           * If the clock framework already bypassed them.
>           */
>          div = DIV_ROUND_UP(test_freq, desired_clk);
>          }
>
>      return ser_clk;
