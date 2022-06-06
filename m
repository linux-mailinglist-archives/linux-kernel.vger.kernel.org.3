Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4C153EDBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiFFSTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiFFSTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:19:13 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08FEDF76;
        Mon,  6 Jun 2022 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654539551; x=1686075551;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YZQGXZpI9rTtyvTmtBEtIuiY7pUKk8RF6e/r0K/TTGI=;
  b=DWpSJ3ljgAz6XRR+PN49hK9+I5qeVHnAkmGTXbEusnz34xpNcWpEGQFG
   8h9tQMnmTHfPRuo1fDv0G9tpRl3FoKhJZS85imNb1uwK45mi94l3VO/9q
   FldjNAqIw1igMPx42oUzEAg26OcWhYH+64Fo6N68US85gTukPRsWyuL1N
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jun 2022 11:19:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 11:19:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 11:19:10 -0700
Received: from [10.216.6.183] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 11:19:06 -0700
Message-ID: <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com>
Date:   Mon, 6 Jun 2022 23:49:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
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
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 6/4/2022 12:10 AM, Doug Anderson wrote:
> Hi,
>
> On Fri, Jun 3, 2022 at 10:43 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>>
>> Ah, or I guess what you're saying is that the table historically
>> contained "rounded" rates but that clk_round_rate() isn't returning
>> nice round rates. OK, but if we truly want to support an inexact
>> match, you'd want to pick the rate that reduces the error, not just
>> pick the first one. In other words, something like this (untested):
>>
>> freq = clk_round_rate(clk, mult);
>> diff = abs(((long)mult - freq) / div);
>> if (diff < best_diff) {
>>     best_diff = diff;
>>     ser_clk = freq;
>>     best_div = div;
>> }
>> I am not sure if its required that freq is a multiple of best_div now
>> that we don't have a multiple of desired_clk anyway.
> How about just this (untested):
>
> freq = clk_round_rate(clk, mult);
> candidate_div = max(1, DIV_ROUND_CLOSEST(freq, desired_clk));
> candidate_freq = freq / candidate_div;
> diff = abs((long)desired_clk - candidate_freq);
> if (diff < best_diff) {
>    best_diff = diff;
>    ser_clk = freq;
>    best_div = candidate_div;
> }

I am afraid this still doesn't guarantee that ser_clk is a multiple of 
best_div

I tested it with a function simulates clk_round_rate.

static unsigned long clk_round_rate_test(struct clk *clk, unsigned long 
in_freq)
{
     unsigned long root_freq[6] = {105, 204, 303, 402, 501, 602};
     int i;

     for (i = 0; i < 6; i++) {
         if (root_freq[i] >= in_freq)
             return root_freq[i];
     }
     return root_freq[6];
}

     {
         unsigned long ser_clk;
         unsigned long desired_clk;
         unsigned long freq;
         int div_round_closest;
         unsigned long div;
         unsigned long mult;
         unsigned long candidate_div, candidate_freq;

         unsigned long diff, best_diff, best_div;
         unsigned long one;

         desired_clk = 100;
         one = 1;
         best_diff = ULONG_MAX;
         pr_err("\ndesired_clk-%d\n", desired_clk);
         for (div = 1; div <= 10; div++) {
             mult = div * desired_clk;

             freq = clk_round_rate_test(clk, mult);
             div_round_closest = DIV_ROUND_CLOSEST(freq, desired_clk);
             candidate_div = max(one, (unsigned long)div_round_closest);
             candidate_freq = freq / candidate_div;
             diff = abs((long)desired_clk - candidate_freq);
             pr_err("div-%d, mult-%d, freq-%d, div_round_closest-%d, 
candidate_div-%d, candidate_freq-%d, diff-%d\n",
                 div, mult, freq, div_round_closest, candidate_div, 
candidate_freq, diff);
             if (diff < best_diff) {
                 pr_err("This is best so far\n");
                 best_diff = diff;
                 ser_clk = freq;
                 best_div = candidate_div;
             }
         }
         pr_err("\nbest_diff-%d, ser_clk-%d, best_div-%d\n",
             best_diff, ser_clk, best_div);
     }

And here is the output

[   17.835167] desired_clk-100
[   17.839567] div-1, mult-100, freq-105, div_round_closest-1, 
candidate_div-1, candidate_freq-105, diff-5
[   17.849220] This is best so far
[   17.852458] div-2, mult-200, freq-204, div_round_closest-2, 
candidate_div-2, candidate_freq-102, diff-2
[   17.862104] This is best so far
[   17.865345] div-3, mult-300, freq-303, div_round_closest-3, 
candidate_div-3, candidate_freq-101, diff-1
[   17.874995] This is best so far
[   17.878237] div-4, mult-400, freq-402, div_round_closest-4, 
candidate_div-4, candidate_freq-100, diff-0
[   17.887882] This is best so far
[   17.891118] div-5, mult-500, freq-501, div_round_closest-5, 
candidate_div-5, candidate_freq-100, diff-0
[   17.900770] div-6, mult-600, freq-602, div_round_closest-6, 
candidate_div-6, candidate_freq-100, diff-0
[   17.910415] div-7, mult-700, freq-602, div_round_closest-6, 
candidate_div-6, candidate_freq-100, diff-0
[   17.920057] div-8, mult-800, freq-602, div_round_closest-6, 
candidate_div-6, candidate_freq-100, diff-0
[   17.929703] div-9, mult-900, freq-602, div_round_closest-6, 
candidate_div-6, candidate_freq-100, diff-0
[   17.939353] div-10, mult-1000, freq-602, div_round_closest-6, 
candidate_div-6, candidate_freq-100, diff-0
[   17.949181]
[   17.949181] best_diff-0, ser_clk-402, best_div-4

Please note that we go past cases when we have an divider that can 
exactly divide the frequency(105/1, 204/2, 303/3) and end up with one 
that doesn't.

It seems like we need to run through all dividers to find one that can 
divide output freq from clk_round_rate and among those choose smallest 
delta.

In regular bootup 2nd loop was required only for 51200000. For others 
1843200, 153600, 1st loop worked fine.

Thank you.

>
> Here:
>
> freq: a freq we can definitely make
>
> candidate_div: the best number to divide freq by to get the desired clock.
>
> candidate_freq: the frequency we'll end up if we divide freq by
> candidate_div. We want this to be close to desired_clk.
>
> diff: how far away the candidate_freq is away from what we want.
>
> best_diff: how far away the best candidate was from what we wanted.
>
> ser_clk: What we should pass to clk_set_rate() to get the best candidate.
>
> best_div: What we should use as a divider to get the best candidate.
>
>
> -Doug
