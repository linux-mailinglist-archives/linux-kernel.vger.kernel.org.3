Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D5353CEC0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbiFCRqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345175AbiFCRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:45:54 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C756424;
        Fri,  3 Jun 2022 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654278202; x=1685814202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E/c77o9OrW6RMELApiHQEq8cGbnVpHSQmXfiuH0BvHM=;
  b=Saq1JvK5AUNnLJaXd1Qu57DSaHTEWtGdRg+MwbetNPsidcfYqHnESD0z
   huCv1iIMD8DPIebI/XF+YMc3Esfw8qYJn8DsTrjy2KpjR5JEN7yTIHok7
   hFz/+nVqG1M7imk7e3C3quy70W4h3sEenvfyMAXO6kRuNLGMxTSLiAENu
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Jun 2022 10:43:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:43:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 3 Jun 2022 10:43:20 -0700
Received: from [10.216.1.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 3 Jun 2022
 10:43:16 -0700
Message-ID: <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com>
Date:   Fri, 3 Jun 2022 23:13:12 +0530
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
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 6/1/2022 9:03 PM, Doug Anderson wrote:
> Hi,
>
> On Wed, Jun 1, 2022 at 3:46 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> Hi,
>>
>> On 6/1/2022 12:58 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Tue, May 31, 2022 at 11:18 AM Vijaya Krishna Nivarthi
>>> <quic_vnivarth@quicinc.com> wrote:
>>>> Add missing initialisation and correct type casting
>>>>
>>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>>>> ---
>>>>    drivers/tty/serial/qcom_geni_serial.c | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>>>> index 4733a23..08f3ad4 100644
>>>> --- a/drivers/tty/serial/qcom_geni_serial.c
>>>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>>>> @@ -943,11 +943,11 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>>>>    static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>>>>                           unsigned int sampling_rate, unsigned int *clk_div)
>>>>    {
>>>> -       unsigned long ser_clk;
>>>> +       unsigned long ser_clk = 0;
>>> In this patch it's not at all obvious why you'd need to init to 0. I
>>> think the "for loop" is guaranteed to run at least once because
>>> "max_div" is known at compile time. ...and currently each time through
>>> the "for" loop you'll always set "ser_clk".
>> Ok, I realised we will never break out of for loop exceeding ULONG_MAX
>> in 1st pass, so yes ser_clk will always be set.
>>
>>> I think in a future patch you'll want to _remove_ this from the for loop:
>>>
>>> if (!prev)
>>>     ser_clk = freq;
>> Intent is to save (and use) 1st freq if we cannot find an exact divider.
>>
>> Isn't it ok?
>>
>> For example please find debug output for a required frequency of 51.2MHz.
>>
>> We try dividers 1, 2, 3 and end up with 52.1MHz the first result.
>>
>> [   18.815432] 20220509 get_clk_div_rate desired_clk:51200000
>> [   18.821081] 20220509 get_clk_div_rate maxdiv:4095
>> [   18.825924] 20220509 get_clk_div_rate div:1
>> [   18.830239] 20220509 get_clk_div_rate freq:52174000
>> [   18.835288] 20220509 get_clk_div_rate div:2
>> [   18.839628] 20220509 get_clk_div_rate freq:100000000
>> [   18.844794] 20220509 get_clk_div_rate div:3
>> [   18.849119] 20220509 get_clk_div_rate freq:100000000
>> [   18.854254] 20220509 get_clk_div_rate reached max frequency breaking...
>> [   18.861072] 20220509 get_clk_div_rate clk_div=1, ser_clk=52174000
>>
>> The behaviour was same earlier too when root_freq table was present.
> Are you certain about the behavior being the same earlier? Before
> commit c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart
> frequency table..."), the behavior was that get_clk_cfg() would return
> 0 if there was no exact match. Then get_clk_div_rate() would see this
> 0 and print an error and return. Then the rest of
> qcom_geni_serial_set_termios() would do nothing at all.
>
> Ah, or I guess what you're saying is that the table historically
> contained "rounded" rates but that clk_round_rate() isn't returning
> nice round rates. OK, but if we truly want to support an inexact
> match, you'd want to pick the rate that reduces the error, not just
> pick the first one. In other words, something like this (untested):
>
> freq = clk_round_rate(clk, mult);
> diff = abs(((long)mult - freq) / div);
> if (diff < best_diff) {
>    best_diff = diff;
>    ser_clk = freq;
>    best_div = div;
> }
I am not sure if its required that freq is a multiple of best_div now 
that we don't have a multiple of desired_clk anyway.

If it is indeed required, with above patch its not guaranteed and 
finding best_div gets little more complicated?

We may have to loop through all available frequencies and dividers?

PFB, a proposed implementation with a 2nd loop. Its tested but I haven't 
been able to optimise it further because it misses corner theoretical 
cases when I try


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

     /*
      * this scenario ideally should be a rare occurrence
      * run through all frequencies and find closest match
      * note that it cannot get better than a difference of 1
      */
     freq = 0;
     best_diff = ULONG_MAX;
     while (true) {
         prev = freq;
         freq = clk_round_rate(clk, freq+1);

         if (freq == prev)
             break;

         for (div = 1; div <= maxdiv; div++) {
             if (!(freq % div)) {
                 diff = abs((long)(freq/div) - desired_clk);
                 if (diff < best_diff) {
                     best_diff = diff;
                     ser_clk = freq;
                     *clk_div = div;
                     if (diff == 1)
                         break;
                 }
             }
         }
     }

     return ser_clk;
}

>
> Why do you need this? Imagine that the desired rate was 50000001 or
> 49999999. The closest match would be to use the rate 100000000 and
> divide it by 2. ...but your existing algorithm would just arbitrarily
> pick the first rate returned.
>
> NOTE also that you could end up with a slightly higher or slightly
> lower clock than requested, right? So it's important to:
> * Do signed math when comparing.
> * Save the "div" instead of trying to recompute it at the end.
>
>
>> The table did contain 51.2MHz and we would exit with same but on call to
>> clk_set_rate(51.2MHz) we were ending up with 52.1MHz
>>
>>> ...and _that's_ when you should init "ser_clk" to 0. Until then I'd
>>> leave it as uninitialized...
>>>
>>> Honestly, I'd throw all the fixes into one series, too.
>> My concern was if there would be a requirement to split the changes.
>>
>> Will put in all in 1 series with Fixes tag.
>>
>>>
>>>>           unsigned long desired_clk;
>>>>           unsigned long freq, prev;
>>>>           unsigned long div, maxdiv;
>>>> -       int64_t mult;
>>>> +       unsigned long long mult;
>>>>
>>>>           desired_clk = baud * sampling_rate;
>>>>           if (!desired_clk) {
>>>> @@ -959,8 +959,8 @@ static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>>>>           prev = 0;
>>>>
>>>>           for (div = 1; div <= maxdiv; div++) {
>>>> -               mult = div * desired_clk;
>>>> -               if (mult > ULONG_MAX)
>>>> +               mult = (unsigned long long)div * (unsigned long long)desired_clk;
>>> I think you only need to cast one of the two. The other will be
>>> up-cast automatically.
>> Will change.
>>>
>>>> +               if (mult > (unsigned long long)ULONG_MAX)
>>> I don't think you need this cast. As far as I know the C language will
>>> "upcast" to the larger of the two types.
>> Will change.
>>>
>>> -Doug
>> Thank you.
>>
>> -Vijay/
>>
