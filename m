Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A946543B90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiFHSeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiFHSeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:34:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C4052B38;
        Wed,  8 Jun 2022 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654713246; x=1686249246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TCHgKfGL6SwdtEXF9yG6KExDLDWVpIA58RokKr10mL0=;
  b=tVFl/y9WU73XvMSJl+kAyiqEcdNbFM2I0aLnZGKiR1NMybwApY7RR2mj
   eg0xFHYMJEzRchym7sfhickvHicZ9TSEYNwwo1xt4u9OrobWFySWT3dFP
   x46BZAYzzEcENg77p26TwycHjcBdO7is/3Fad3fQgu9ZhQij+lLcfu6Jx
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jun 2022 11:34:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 11:34:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 11:34:05 -0700
Received: from [10.216.5.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 11:34:01 -0700
Message-ID: <765a170c-d335-d626-0609-7d0f3967b71d@quicinc.com>
Date:   Thu, 9 Jun 2022 00:03:57 +0530
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
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=Wytm9EYu=4ndN+En2AFEgPK9NjrUMbFPA_h6TwyxGCYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 6/8/2022 12:55 AM, Doug Anderson wrote:
> Hi,
>
> On Tue, Jun 7, 2022 at 10:40 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> Hi,
>>
>> On 6/7/2022 1:29 AM, Doug Anderson wrote:
>>
>> My only concern continues to be...
>>
>> Given ser_clk is the final frequency that this function is going to
>> return and best_div is going to be the clk_divider, is it ok if the
>> divider cant divide the frequency exactly?
>>
>> In other words, Can this function output combinations like (402,4)
>> (501,5) ?
>>
>> If ok, then we can go ahead with this patch or even previous perhaps.
> I don't see why not. You're basically just getting a resulting clock
> that's not an integral "Hz", right?
>
> So if "baud" is 9600 and sampling_rate is 16 then desired_clk is (9600
> * 16) = 153600
>
> Let's imagine that we do all the math and we finally decide that our
> best bet is with the rate 922000 and a divider of 6. That means that
> the actual clock we'll make is 153666.67 when we _wanted_ 153600.
> There's no reason it needs to be integral, though, and 153666.67 would
> still be better than making 160000.
>
Thank you for clarification.
>>> power?)
>> Actually power saving was the anticipation behind returning first
>> frequency in original patch, when we cant find exact frequency.
> Right, except that if you just pick the first clock you find it would
> be _wildly_ off. I guess if you really want to do this the right way,
> you need to set a maximum tolerance and pick the first rate you find
> that meets that tolerance. Random web search for "uart baud rate
> tolerance" makes me believe that +/- 5% deviation is OK, but to be
> safe you probably want something lower. Maybe 2%? So if the desired
> clock is within 2% of a clock you can make, can you just pick that
> one?
Ok, 2% seems good.
>
>>>> Please note that we go past cases when we have an divider that can
>>>> exactly divide the frequency(105/1, 204/2, 303/3) and end up with one
>>>> that doesn't.
>>> Ah, good point. Luckily that's a 1-line fix, right?
>> Apologies, I could not figure out how.
> Ah, sorry. Not quite 1 line, but this (untested)
>
>
> freq = clk_round_rate(clk, mult);
>
> if (freq % desired_clk == 0) {
>   ser_clk = freq;
>   best_div = freq / desired_clk;
>   break;
> }
>
> candidate_div = max(1, DIV_ROUND_CLOSEST(freq, desired_clk));
> candidate_freq = freq / candidate_div;
> diff = abs((long)desired_clk - candidate_freq);
> if (diff < best_diff) {
>    best_diff = diff;
>    ser_clk = freq;
>    best_div = candidate_div;
> }

But then once again, we would likely need 2 loops because while we are 
ok with giving up on search for best_div on finding something within 2% 
tolerance, we may not want to give up on exact match (freq % desired_clk 
== 0 )

So how about something like this with 2 loops (more optimised than 
previous version with 2 loops)? (untested)


     maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
     prev = 0;

     /* run through quicker loop anticipating to find an exact match */
     for (div = 1; div <= maxdiv; div++) {
         mult = (unsigned long long)div * desired_clk;
         if (mult > ULONG_MAX)
             break;

         freq = clk_round_rate(clk, max((unsigned long)mult, prev+1));
         if (!(freq % desired_clk)) {
             *clk_div = freq / desired_clk;
             return freq;
         }

         if (prev && prev == freq)
             break;

         prev = freq;
     }

     pr_warn("Can't find exact match frequency and divider\n");

     freq = 0;
     best_diff = ULONG_MAX;
     prev_candidate_div = -1;
     while (true) {
         prev = freq;
         freq = clk_round_rate(clk, freq+1);

         if (freq == prev)
             break; /* end of table */

         candidate_div = DIV_ROUND_CLOSEST(freq, desired_clk);
         /*
          * Since the frequencies are increasing, previous is better
          * if we have same divider, proceed to next in table
          */
         if (prev_candidate_div == candidate_div)
             continue;
         prev_candidate_div = candidate_div;

         if (candidate_div)
             candidate_freq = freq / candidate_div;
         else
             candidate_freq = freq;

         diff = abs((long)desired_clk - candidate_freq);
         if (diff < best_diff) {
             best_diff = diff;
             ser_clk = freq;
             *clk_div = candidate_div;
             if (diff * 50 < ser_clk) {
                 two_percent_tolerance = true;
                 break;
             }
         }
     }

     if (!two_percent_tolerance) {
         pr_warn("Can't find frequency within 2 percent tolerance\n");
     }

     return ser_clk;
}

Thank you.

