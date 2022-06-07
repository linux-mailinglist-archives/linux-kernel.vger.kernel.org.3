Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06437540A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352359AbiFGSRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 14:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348716AbiFGR5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:57:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E789340D1;
        Tue,  7 Jun 2022 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654623637; x=1686159637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+B4Iq6G37tAIJlQY0aVggAP2/4atVoACS5r1tyjM8L0=;
  b=R/yYwROjOMH2nY4mjpS/Xg8WvFgVV4UiSb71qGC6n6BVJWV1nKGAN79P
   2NZEAYd6J47eN6Q0pteZBbKPlK3tKqYy5eJmUs8jqIiWeg05kRMh/rjST
   ZzQwql+bwGHTutPznZF5TPQwpiiy2Leq8pF80W2KxXWGhlrctTJiknbo6
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 10:40:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 10:40:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 10:40:32 -0700
Received: from [10.216.0.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 7 Jun 2022
 10:40:29 -0700
Message-ID: <da18c508-f32e-fece-6392-e6a95f7c7968@quicinc.com>
Date:   Tue, 7 Jun 2022 23:10:25 +0530
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
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
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

On 6/7/2022 1:29 AM, Doug Anderson wrote:
> Hi,
>
> On Mon, Jun 6, 2022 at 11:19 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> Hi,
>>
>>
>> On 6/4/2022 12:10 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, Jun 3, 2022 at 10:43 AM Vijaya Krishna Nivarthi
>>> <quic_vnivarth@quicinc.com> wrote:
>>>> Ah, or I guess what you're saying is that the table historically
>>>> contained "rounded" rates but that clk_round_rate() isn't returning
>>>> nice round rates. OK, but if we truly want to support an inexact
>>>> match, you'd want to pick the rate that reduces the error, not just
>>>> pick the first one. In other words, something like this (untested):
>>>>
>>>> freq = clk_round_rate(clk, mult);
>>>> diff = abs(((long)mult - freq) / div);
>>>> if (diff < best_diff) {
>>>>      best_diff = diff;
>>>>      ser_clk = freq;
>>>>      best_div = div;
>>>> }
>>>> I am not sure if its required that freq is a multiple of best_div now
>>>> that we don't have a multiple of desired_clk anyway.
>>> How about just this (untested):
>>>
>>> freq = clk_round_rate(clk, mult);
>>> candidate_div = max(1, DIV_ROUND_CLOSEST(freq, desired_clk));
>>> candidate_freq = freq / candidate_div;
>>> diff = abs((long)desired_clk - candidate_freq);
>>> if (diff < best_diff) {
>>>     best_diff = diff;
>>>     ser_clk = freq;
>>>     best_div = candidate_div;
>>> }
>> I am afraid this still doesn't guarantee that ser_clk is a multiple of
>> best_div
> OK. ...I guess my question would be: does it matter for some reason?
> "ser_clk" is just a local variable in this function. Who cares if it's
> not a multiple of best_div? This is why we're keeping track of
> "best_div" in the first place, so that later in the function instead
> of:
>
> *clk_div = ser_clk / desired_clk;
> if (!(*clk_div))
>    *clk_div = 1;
>
> You just do:
>
> *clk_div = best_div;

My only concern continues to be...

Given ser_clk is the final frequency that this function is going to 
return and best_div is going to be the clk_divider, is it ok if the 
divider cant divide the frequency exactly?

In other words, Can this function output combinations like (402,4)  
(501,5) ?

If ok, then we can go ahead with this patch or even previous perhaps.

>
>> I tested it with a function simulates clk_round_rate.
>>
>> static unsigned long clk_round_rate_test(struct clk *clk, unsigned long
>> in_freq)
>> {
>>       unsigned long root_freq[6] = {105, 204, 303, 402, 501, 602};
>>       int i;
>>
>>       for (i = 0; i < 6; i++) {
>>           if (root_freq[i] >= in_freq)
>>               return root_freq[i];
>>       }
>>       return root_freq[6];
>> }
>>
>>       {
>>           unsigned long ser_clk;
>>           unsigned long desired_clk;
>>           unsigned long freq;
>>           int div_round_closest;
>>           unsigned long div;
>>           unsigned long mult;
>>           unsigned long candidate_div, candidate_freq;
>>
>>           unsigned long diff, best_diff, best_div;
>>           unsigned long one;
>>
>>           desired_clk = 100;
>>           one = 1;
>>           best_diff = ULONG_MAX;
>>           pr_err("\ndesired_clk-%d\n", desired_clk);
>>           for (div = 1; div <= 10; div++) {
>>               mult = div * desired_clk;
>>
>>               freq = clk_round_rate_test(clk, mult);
>>               div_round_closest = DIV_ROUND_CLOSEST(freq, desired_clk);
>>               candidate_div = max(one, (unsigned long)div_round_closest);
>>               candidate_freq = freq / candidate_div;
>>               diff = abs((long)desired_clk - candidate_freq);
>>               pr_err("div-%d, mult-%d, freq-%d, div_round_closest-%d,
>> candidate_div-%d, candidate_freq-%d, diff-%d\n",
>>                   div, mult, freq, div_round_closest, candidate_div,
>> candidate_freq, diff);
>>               if (diff < best_diff) {
>>                   pr_err("This is best so far\n");
>>                   best_diff = diff;
>>                   ser_clk = freq;
>>                   best_div = candidate_div;
>>               }
>>           }
>>           pr_err("\nbest_diff-%d, ser_clk-%d, best_div-%d\n",
>>               best_diff, ser_clk, best_div);
>>       }
>>
>> And here is the output
>>
>> [   17.835167] desired_clk-100
>> [   17.839567] div-1, mult-100, freq-105, div_round_closest-1,
>> candidate_div-1, candidate_freq-105, diff-5
>> [   17.849220] This is best so far
>> [   17.852458] div-2, mult-200, freq-204, div_round_closest-2,
>> candidate_div-2, candidate_freq-102, diff-2
>> [   17.862104] This is best so far
>> [   17.865345] div-3, mult-300, freq-303, div_round_closest-3,
>> candidate_div-3, candidate_freq-101, diff-1
>> [   17.874995] This is best so far
>> [   17.878237] div-4, mult-400, freq-402, div_round_closest-4,
>> candidate_div-4, candidate_freq-100, diff-0
>> [   17.887882] This is best so far
>> [   17.891118] div-5, mult-500, freq-501, div_round_closest-5,
>> candidate_div-5, candidate_freq-100, diff-0
>> [   17.900770] div-6, mult-600, freq-602, div_round_closest-6,
>> candidate_div-6, candidate_freq-100, diff-0
>> [   17.910415] div-7, mult-700, freq-602, div_round_closest-6,
>> candidate_div-6, candidate_freq-100, diff-0
>> [   17.920057] div-8, mult-800, freq-602, div_round_closest-6,
>> candidate_div-6, candidate_freq-100, diff-0
>> [   17.929703] div-9, mult-900, freq-602, div_round_closest-6,
>> candidate_div-6, candidate_freq-100, diff-0
>> [   17.939353] div-10, mult-1000, freq-602, div_round_closest-6,
>> candidate_div-6, candidate_freq-100, diff-0
>> [   17.949181]
>> [   17.949181] best_diff-0, ser_clk-402, best_div-4
> That doesn't look like a terrible result. I guess nominally 602 is a
> better approximation, but if we're accepting that we're not going to
> have an exact rate anyway then maybe being off by that tiny amount
> doesn't matter and we'd do better with the slow clock (maybe saves
> power?)
Actually power saving was the anticipation behind returning first 
frequency in original patch, when we cant find exact frequency.
>
>> Please note that we go past cases when we have an divider that can
>> exactly divide the frequency(105/1, 204/2, 303/3) and end up with one
>> that doesn't.
> Ah, good point. Luckily that's a 1-line fix, right?

Apologies, I could not figure out how.

Thank you.

>
>
> -Doug
