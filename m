Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910A3569102
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiGFRpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiGFRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:44:39 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717B32C133;
        Wed,  6 Jul 2022 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657129450; x=1688665450;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C21R6YwpZ6S+qazhFSa7FqJfh0q5us7JeiD6mUwqoN8=;
  b=cH7mHP/OS5MMT+W++9i7U7v9qv3T7cGfYyPE0LtD2qRYQiAVXLtJZCPI
   2MDBJf1WnP91DsoemcndDIiP+2ba2TsTz2wRMlOdqKMqS0EUARH7brs6H
   HzjFG+QC1mPb0WA9urmuj6k6w0nyXXhnGA/eRQ5F/jDAULJZl2GysERZI
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 06 Jul 2022 10:44:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:44:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Jul 2022 10:44:07 -0700
Received: from [10.216.39.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Jul 2022
 10:44:02 -0700
Message-ID: <69e3fec3-bd49-8877-f1f8-453b09b8c940@quicinc.com>
Date:   Wed, 6 Jul 2022 23:13:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>,
        "Vijaya Krishna Nivarthi (Temp)" <vnivarth@qti.qualcomm.com>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Stephen Boyd" <swboyd@chromium.org>
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UXP+dfYEHpsS_djnWYxNVUS__2Uu5Mmxt2G4T=vfSSQQ@mail.gmail.com>
 <BL0PR02MB4564A1EC37911A464BBEC260FABD9@BL0PR02MB4564.namprd02.prod.outlook.com>
 <CAD=FV=XCgsyTRT-T5jKN6c7tJ=du8gbpkMccm2VZpz+TFWyLsw@mail.gmail.com>
 <BL0PR02MB45643EEB3C1571E0F2364B8FFABE9@BL0PR02MB4564.namprd02.prod.outlook.com>
 <CAD=FV=Up_NNd5RNJ+xLrPOHfPb_YG1ut=BjU=O2yP8w2hG9Ugw@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=Up_NNd5RNJ+xLrPOHfPb_YG1ut=BjU=O2yP8w2hG9Ugw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 7/6/2022 8:56 PM, Doug Anderson wrote:
> Hi,
>
> On Mon, Jul 4, 2022 at 11:57 AM Vijaya Krishna Nivarthi (Temp)
> <vnivarth@qti.qualcomm.com> wrote:
>> Hi,
>>
>>
>>> -----Original Message-----
>>> From: Doug Anderson <dianders@chromium.org>
>>> Sent: Friday, July 1, 2022 8:38 PM
>>> To: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>
>>> Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Konrad
>>> Dybcio <konrad.dybcio@somainline.org>; Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; linux-arm-
>>> msm <linux-arm-msm@vger.kernel.org>; linux-serial@vger.kernel.org; LKML
>>> <linux-kernel@vger.kernel.org>; Mukesh Savaliya (QUIC)
>>> <quic_msavaliy@quicinc.com>; Matthias Kaehlcke <mka@chromium.org>;
>>> Stephen Boyd <swboyd@chromium.org>
>>> Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
>>> otherwise could return a sub-optimal clock rate.
>>>
>>> WARNING: This email originated from outside of Qualcomm. Please be wary
>>> of any links or attachments, and do not enable macros.
>>>
>>> Hi,
>>>
>>> On Fri, Jul 1, 2022 at 4:04 AM Vijaya Krishna Nivarthi (Temp) (QUIC)
>>> <quic_vnivarth@quicinc.com> wrote:
>>>> Hi,
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Doug Anderson <dianders@chromium.org>
>>>>> Sent: Thursday, June 30, 2022 4:45 AM
>>>>> To: Vijaya Krishna Nivarthi (Temp) (QUIC)
>>>>> <quic_vnivarth@quicinc.com>
>>>>> Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org;
>>>>> Konrad Dybcio <konrad.dybcio@somainline.org>; Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>;
>>>>> linux-arm- msm <linux-arm-msm@vger.kernel.org>;
>>>>> linux-serial@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>;
>>>>> Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com>; Matthias
>>>>> Kaehlcke <mka@chromium.org>; Stephen Boyd
>>> <swboyd@chromium.org>
>>>>> Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix
>>>>> get_clk_div_rate() which otherwise could return a sub-optimal clock rate.
>>>>>
>>>>>
>>>>>
>>>>>> +                               /* Save the first (lowest freq) within tolerance */
>>>>>> +                               ser_clk = freq;
>>>>>> +                               *clk_div = new_div;
>>>>>> +                               /* no more search for exact match required in 2nd run
>>> */
>>>>>> +                               if (!exact_match)
>>>>>> +                                       break;
>>>>>> +                       }
>>>>>> +               }
>>>>>>
>>>>>> -               prev = freq;
>>>>>> +               div = freq / desired_clk + 1;
>>>>> Can't you infinite loop now?
>>>>>
>>>>> Start with:
>>>>>
>>>>> desired_clk = 10000
>>>>> div = 1
>>>>> percent_tol = 2
>>>>>
>>>>>
>>>>> Now:
>>>>>
>>>>> mult = 10000
>>>>> offset = 200
>>>>> test_freq = 9800
>>>>> freq = 9800
>>>>> div = 9800 / 10000 + 1 = 0 + 1 = 1
>>>>>
>>>>> ...and then you'll loop again with "div = 1", won't you? ...or did I
>>>>> get something wrong in my analysis? This is the reason my proposed
>>>>> algorithm had two loops.
>>>>>
>>>>>
>>>> I went back to your proposed algorithm and made couple of simple
>>> changes, and it seemed like what we need.
>>>> a) look only for exact match once a clock rate within tolerance is
>>>> found
>>>> b) swap test_freq and freq at end of while loops to make it run as
>>>> desired
>>>>
>>>>
>>>>          maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
>>>>          div = 1;
>>>>
>>>>          while (div < maxdiv) {
>>>>                  mult = (unsigned long long)div * desired_clk;
>>>>                  if (mult != (unsigned long)mult)
>>>>                          break;
>>>>
>>>>                  if (ser_clk)
>>>>                          offset = 0;
>>>>                  ===================a=====================
>>>>                  else
>>>>                          offset = div_u64(mult * percent_tol, 100);
>>>>
>>>>                  /*
>>>>                   * Loop requesting (freq - 2%) and possibly (freq).
>>>>                   *
>>>>                   * We'll keep track of the lowest freq inexact match we found
>>>>                   * but always try to find a perfect match. NOTE: this algorithm
>>>>                   * could miss a slightly better freq if there's more than one
>>>>                   * freq between (freq - 2%) and (freq) but (freq) can't be made
>>>>                   * exactly, but that's OK.
>>>>                   *
>>>>                   * This absolutely relies on the fact that the Qualcomm clock
>>>>                   * driver always rounds up.
>>>>                   */
>>>>                  test_freq = mult - offset;
>>>>                  while (test_freq <= mult) {
>>>>                          freq = clk_round_rate(clk, test_freq);
>>>>
>>>>                          /*
>>>>                           * A dead-on freq is an insta-win. This implicitly
>>>>                           * handles when "freq == mult"
>>>>                           */
>>>>                          if (!(freq % desired_clk)) {
>>>>                                  *clk_div = freq / desired_clk;
>>>>                                  return freq;
>>>>                          }
>>>>
>>>>                          /*
>>>>                           * Only time clock framework doesn't round up is if
>>>>                           * we're past the max clock rate. We're done searching
>>>>                           * if that's the case.
>>>>                           */
>>>>                          if (freq < test_freq)
>>>>                                  return ser_clk;
>>>>
>>>>                          /* Save the first (lowest freq) within tolerance */
>>>>                          if (!ser_clk && freq <= mult + offset) {
>>>>                                  ser_clk = freq;
>>>>                                  *clk_div = div;
>>>>                          }
>>>>
>>>>                          /*
>>>>                           * If we already rounded up past mult then this will
>>>>                           * cause the loop to exit. If not then this will run
>>>>                           * the loop a second time with exactly mult.
>>>>                           */
>>>>                          test_freq = max(test_freq + 1, mult);
>>>>                                                       ====b====
>>>>                  }
>>>>
>>>>                  /*
>>>>                   * freq will always be bigger than mult by at least 1.
>>>>                   * That means we can get the next divider with a DIV_ROUND_UP.
>>>>                   * This has the advantage of skipping by a whole bunch of divs
>>>>                   * If the clock framework already bypassed them.
>>>>                   */
>>>>                  div = DIV_ROUND_UP(freq, desired_clk);
>>>>                                                         ===b==
>>>>          }
>>>>
>>>>
>>>> Will also drop exact_match now.
>>>>
>>>> Will upload v3 after testing.
>>> The more I've been thinking about it, the more I wonder if we even need the
>>> special case of looking for an exact match at all. It feels like we should choose
>>> one: we either look for the best match or we look for the one with the
>>> lowest clock source rate. The weird half-half approach that we have right
>>> now feels like over-engineering and complicates things.
>>>
>>> How about this (again, only lightly tested). Worst case if we _truly_ need a
>>> close-to-exact match we could pass a tolerance of 0 in and we'd get
>>> something that's nearly exact, though I'm not suggesting we actually do that.
>>> If we think 2% is good enough then we should just accept the first (and
>>> lowest clock rate) 2% match we find.
>>>
>>>      abs_tol = div_u64((u64)desired_clk * percent_tol, 100);
>>>      maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
>>>      div = 1;
>>>      while (div <= maxdiv) {
>>>          mult = (u64)div * desired_clk;
>>>          if (mult != (unsigned long)mult)
>>>              break;
>>>
>>>          offset = div * abs_tol;
>>>          freq = clk_round_rate(clk, mult - offset);
>>>
>>>          /* Can only get lower if we're done */
>>>          if (freq < mult - offset)
>>>              break;
>>>
>>>          /*
>>>           * Re-calculate div in case rounding skipped rates but we
>>>           * ended up at a good one, then check for a match.
>>>           */
>>>          div = DIV_ROUND_CLOSEST(freq, desired_clk);
>>>          achieved = DIV_ROUND_CLOSEST(freq, div);
>>>          if (achieved <= desired_clk + abs_tol &&
>>>              achieved >= desired_clk - abs_tol) {
>>>              *clk_div = div;
>>>              return freq;
>>>          }
>>>
>>>          /*
>>>           * Always increase div by at least one, but we'll go more than
>>>           * one if clk_round_rate() gave us something higher.
>>>           */
>>>          div = DIV_ROUND_UP(max(freq, (unsigned long)mult) + 1, desired_clk);
>> Wouldn’t DIV_ROUND_UP(freq, desired_clk) suffice here?
>> freq >= mult-offset, else we would have hit break.
> No. As you say, freq >= "mult-offset". That means that freq could be
> == "mult-offset", right? If offset > 0 then freq could be < mult. Then
> your DIV_ROUND_UP() would just take you right back to where you
> started the loop with and you'd end up with an infinite loop, wouldn't
> you?
>
Probably No.

( (freq >= mult-offset) && (freq <= mult) ) =>

( (freq >= mult-offset) && (freq <= mult+offset) )

would mean that

div = DIV_ROUND_CLOSEST(freq, desired_clk);
evaluates to original div and we are within tolerance and hence we can return and hence don't even reach DIV_ROUND_UP?

Please note that freq can skip any multiples and land up anywhere.

As long as it has not gone beyond clock rate table, either it lands 
within tolerance of nearest multiple of desired_clk (in which case we 
return)

OR

We move on to next div = (freq/desired_clk + 1)


I retract div++, I was mistaken to believe that DIV_ROUND_UP(freq, 
desired_clk) would be same as div++.

Thank you.

>> Additionally if freq <= mult we would have hit return.
>> So always freq > mult?
>>
>> And hence div++ would do the same?
> I thought about it and I decided that it might not if the clock
> framework skipped a whole bunch. Let's see if I can give an example.
>
> Let's say
> * "desired_clk" is 10000
> * "percent_tol" is 2 (abs_tol = 200)
> * We can make clocks 17000, 20000, 25000.
>
> First time through the loop:
>
> mult = 10000
> offset = 200
> freq = 17000
> div = 2
> achieved = 8500 (not within tolerance)
>
> ...at the end of the loop if we do "div++" then we'll end up with
> div=3 for the next loop and we'll miss finding 20000.
> ...but if we do my math, we end up with:
>
> DIV_ROUND_UP(max(17000, 10000) + 1, 10000)
> DIV_ROUND_UP(17000 + 1, 10000)
> DIV_ROUND_UP(17000, 10000)
> 2
>
> ...and that's exactly what we want.
>
>
> Here's an example showing why the line "div = DIV_ROUND_CLOSEST(freq,
> desired_clk)" is important:
>
> * "desired_clk" is 10000
> * "percent_tol" is 2 (abs_tol = 200)
> * We can make clocks 19600, 25000.
>
> mult = 10000
> offset = 200
> freq = 19600
> div = 2
> achieved = 9800
>
> Returns 19600 and div=2
>
>
> Here's an example showing how the clock framework rounding lets us
> skip some "div"s without missing anything important:
>
> * "desired_clk" is 10000
> * "percent_tol" is 2 (abs_tol = 200)
> * We can make clocks 24000, 30000.
>
> mult = 25000
> offset = 200
> freq = 24000
> div = 2
> achieved = 12000 (not within tolerance)
>
> div = DIV_ROUND_UP(max(24000, 10000) + 1, 10000)
> div = 3
>
> mult = 30000
> offset = 600
> freq = 30000
> div = 3
>
> -Doug
