Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6853A32E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352436AbiFAKrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352409AbiFAKqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:46:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258B7E1FA;
        Wed,  1 Jun 2022 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654080395; x=1685616395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b5qedcwIh/YsEv38RoqMhtjohICmIZUWqBvAcbBcEqs=;
  b=S9TG9S7iCHfCZfS3pit+G9vczBbx4kAMbf34eb/L6zRv0KveC7NtAKhk
   Tj7Ttg6gNT1axznRH86iRLSOhLK+bQRn5/ONIMeGNkwzMJxsnc2DMtPo/
   9+7lOYqE2asqERx3HZGoHjZ3ElmsXPlBL87eUeIwKywoV1mHIPmQGc9J7
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jun 2022 03:46:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:46:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 03:46:34 -0700
Received: from [10.216.8.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 03:46:29 -0700
Message-ID: <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com>
Date:   Wed, 1 Jun 2022 16:15:59 +0530
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
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
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

On 6/1/2022 12:58 AM, Doug Anderson wrote:
> Hi,
>
> On Tue, May 31, 2022 at 11:18 AM Vijaya Krishna Nivarthi
> <quic_vnivarth@quicinc.com> wrote:
>> Add missing initialisation and correct type casting
>>
>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 4733a23..08f3ad4 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -943,11 +943,11 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>>   static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>>                          unsigned int sampling_rate, unsigned int *clk_div)
>>   {
>> -       unsigned long ser_clk;
>> +       unsigned long ser_clk = 0;
> In this patch it's not at all obvious why you'd need to init to 0. I
> think the "for loop" is guaranteed to run at least once because
> "max_div" is known at compile time. ...and currently each time through
> the "for" loop you'll always set "ser_clk".

Ok, I realised we will never break out of for loop exceeding ULONG_MAX 
in 1st pass, so yes ser_clk will always be set.

> I think in a future patch you'll want to _remove_ this from the for loop:
>
> if (!prev)
>    ser_clk = freq;

Intent is to save (and use) 1st freq if we cannot find an exact divider.

Isn't it ok?

For example please find debug output for a required frequency of 51.2MHz.

We try dividers 1, 2, 3 and end up with 52.1MHz the first result.

[   18.815432] 20220509 get_clk_div_rate desired_clk:51200000
[   18.821081] 20220509 get_clk_div_rate maxdiv:4095
[   18.825924] 20220509 get_clk_div_rate div:1
[   18.830239] 20220509 get_clk_div_rate freq:52174000
[   18.835288] 20220509 get_clk_div_rate div:2
[   18.839628] 20220509 get_clk_div_rate freq:100000000
[   18.844794] 20220509 get_clk_div_rate div:3
[   18.849119] 20220509 get_clk_div_rate freq:100000000
[   18.854254] 20220509 get_clk_div_rate reached max frequency breaking...
[   18.861072] 20220509 get_clk_div_rate clk_div=1, ser_clk=52174000

The behaviour was same earlier too when root_freq table was present.

The table did contain 51.2MHz and we would exit with same but on call to 
clk_set_rate(51.2MHz) we were ending up with 52.1MHz

>
> ...and _that's_ when you should init "ser_clk" to 0. Until then I'd
> leave it as uninitialized...
>
> Honestly, I'd throw all the fixes into one series, too.

My concern was if there would be a requirement to split the changes.

Will put in all in 1 series with Fixes tag.

>
>
>>          unsigned long desired_clk;
>>          unsigned long freq, prev;
>>          unsigned long div, maxdiv;
>> -       int64_t mult;
>> +       unsigned long long mult;
>>
>>          desired_clk = baud * sampling_rate;
>>          if (!desired_clk) {
>> @@ -959,8 +959,8 @@ static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>>          prev = 0;
>>
>>          for (div = 1; div <= maxdiv; div++) {
>> -               mult = div * desired_clk;
>> -               if (mult > ULONG_MAX)
>> +               mult = (unsigned long long)div * (unsigned long long)desired_clk;
> I think you only need to cast one of the two. The other will be
> up-cast automatically.
Will change.
>
>
>> +               if (mult > (unsigned long long)ULONG_MAX)
> I don't think you need this cast. As far as I know the C language will
> "upcast" to the larger of the two types.
Will change.
>
>
> -Doug

Thank you.

-Vijay/

