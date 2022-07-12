Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAEF571A81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiGLMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiGLMwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:52:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE5F32EF0;
        Tue, 12 Jul 2022 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657630328; x=1689166328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U2Un04XVTmq4xkp4/4A5znANGKPLAF6CfLJmOF8T2vQ=;
  b=WUh62GntfmIVriD0qG3ScSCnQmITP8wbNooeI9m0WWvX5RQ4vWPelNDP
   fjPAHPCC+oahxRlU68MefjN2073MOcWYwP78zF5n+X2+rb9fOiefW8ImI
   mFiJxFRPVDT4uMR1HdY9Bty6FXa65Ufoi1JIFePhUtLBuTOPqc32DuPe8
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 05:52:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 05:52:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 05:52:07 -0700
Received: from [10.216.22.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Jul
 2022 05:52:03 -0700
Message-ID: <78aeec99-60d4-c495-0623-c9450621d23b@quicinc.com>
Date:   Tue, 12 Jul 2022 18:21:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V4] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <1657560808-9795-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=U20bzea7qzuMCgrAApFqBZ_sc9QsRdUZ_xX4ptRas-0w@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=U20bzea7qzuMCgrAApFqBZ_sc9QsRdUZ_xX4ptRas-0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 7/11/2022 11:35 PM, Doug Anderson wrote:
> Hi,
>
> On Mon, Jul 11, 2022 at 10:33 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> In the logic around call to clk_round_rate(), for some corner conditions,
>> get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
>> exact clock rate was not found lowest clock was being returned.
>>
>> Search for suitable clock rate in 2 steps
>> a) exact match or within 2% tolerance
>> b) within 5% tolerance
>> This also takes care of corner conditions.
>>
>> Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>> v4: replaced pr_dbg calls with dev_dbg
>> v3: simplified algorithm further, fixed robot compile warnings
>> v2: removed minor optimisations to make more readable
>> v1: intial patch contained slightly complicated logic
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 89 +++++++++++++++++++++--------------
>>   1 file changed, 54 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 2e23b65..f88b042 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -943,52 +943,71 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>>          return 0;
>>   }
>>
>> -static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>> -                       unsigned int sampling_rate, unsigned int *clk_div)
>> +static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
>> +                       unsigned int *clk_div, unsigned int percent_tol)
>>   {
>> -       unsigned long ser_clk;
>> -       unsigned long desired_clk;
>> -       unsigned long freq, prev;
>> +       unsigned long freq;
>>          unsigned long div, maxdiv;
>> -       int64_t mult;
>> -
>> -       desired_clk = baud * sampling_rate;
>> -       if (!desired_clk) {
>> -               pr_err("%s: Invalid frequency\n", __func__);
>> -               return 0;
>> -       }
>> +       u64 mult;
>> +       unsigned long offset, abs_tol, achieved;
>>
>> +       abs_tol = div_u64((u64)desired_clk * percent_tol, 100);
>>          maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
>> -       prev = 0;
>> -
>> -       for (div = 1; div <= maxdiv; div++) {
>> -               mult = div * desired_clk;
>> -               if (mult > ULONG_MAX)
>> +       div = 1;
>> +       while (div <= maxdiv) {
>> +               mult = (u64)div * desired_clk;
>> +               if (mult != (unsigned long)mult)
>>                          break;
>>
>> -               freq = clk_round_rate(clk, (unsigned long)mult);
>> -               if (!(freq % desired_clk)) {
>> -                       ser_clk = freq;
>> -                       break;
>> -               }
>> +               offset = div * abs_tol;
>> +               freq = clk_round_rate(clk, mult - offset);
>>
>> -               if (!prev)
>> -                       ser_clk = freq;
>> -               else if (prev == freq)
>> +               /* Can only get lower if we're done */
>> +               if (freq < mult - offset)
>>                          break;
>>
>> -               prev = freq;
>> +               /*
>> +                * Re-calculate div in case rounding skipped rates but we
>> +                * ended up at a good one, then check for a match.
>> +                */
>> +               div = DIV_ROUND_CLOSEST(freq, desired_clk);
>> +               achieved = DIV_ROUND_CLOSEST(freq, div);
>> +               if (achieved <= desired_clk + abs_tol &&
>> +                   achieved >= desired_clk - abs_tol) {
>> +                       *clk_div = div;
>> +                       return freq;
>> +               }
>> +
>> +               div = DIV_ROUND_UP(freq, desired_clk);
>>          }
>>
>> -       if (!ser_clk) {
>> -               pr_err("%s: Can't find matching DFS entry for baud %d\n",
>> -                                                               __func__, baud);
>> -               return ser_clk;
>> +       return 0;
>> +}
>> +
>> +static unsigned long get_clk_div_rate(struct clk *clk, struct device *dev,
>> +               unsigned int baud, unsigned int sampling_rate, unsigned int *clk_div)
>> +{
>> +       unsigned long ser_clk;
>> +       unsigned long desired_clk;
>> +
>> +       desired_clk = baud * sampling_rate;
>> +       if (!desired_clk) {
>> +               dev_dbg(dev, "Invalid frequency\n");
>> +               return 0;
>>          }
>>
>> -       *clk_div = ser_clk / desired_clk;
>> -       if (!(*clk_div))
>> -               *clk_div = 1;
>> +       /*
>> +        * try to find a clock rate within 2% tolerance, then within
>> +        */
>> +       ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2);
>> +       if (!ser_clk)
>> +               ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5);
>> +
>> +       if (!ser_clk)
>> +               dev_err(dev, "Couldn't find suitable clock rate for %d\n", desired_clk);
>> +       else
>> +               dev_dbg(dev, "desired_clk-%d, ser_clk-%d, clk_div-%d\n",
>> +                               desired_clk, ser_clk, *clk_div);
> Pretty sure the robot is going to yell at you again here. Here is my
> analysis in detail:
>
> desired_clk
> * type: unsigned long
> * proper format code: %lu
> * marginally acceptable code: %ld
> * format code you used in v3: %lu
> * did robot yell at you about this in v3: no
> * format code you used in v4: %d
> * will robot yell at you in v4: YES
>
> ser_clk:
> * type: unsigned long
> * proper format code: %lu
> * marginally acceptable code: %ld
> * format code you used in v3: %lu
> * did robot yell at you about this in v3: no
> * format code you used in v4: %d
> * will robot yell at you in v4: YES
>
> *clk_div:
> * type: unsigned int
> * proper format code: %u
> * marginally acceptable code: %d
> * format code you used in v3: %lu
> * did robot yell at you about this in v3: YES
> * format code you used in v4: %d
> * will robot yell at you in v4: no
> * should you change it to %u: yes
>
>
> -Doug
Thank you very much.
For some reason robot seems to be more forgiving towards dev_funcs than 
pr_funcs, at least it did not yell at v4.

Also I found usage of %d for uls at many locations.

Made the changes and uploaded V5.

-Vijay/


