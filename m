Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40D3574E97
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiGNNFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiGNNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:05:26 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBFD2D1F9;
        Thu, 14 Jul 2022 06:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657803925; x=1689339925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o/uCGcJ47frDAidTP8LfsgkkatSl2wQ4r/QApE2FaGU=;
  b=zESrki1aa27DopVzSh/NxADoXkmLgdzSmFcyGTs5BBAL+eRPovrEtsp8
   CA3h6dEuhHE8/S1vuCECzsi83M4irllxr2ANJMefbuob/aIqBUa4h0n9Z
   a9htUp1eUKkgoqiWaIDoIiXSZZzoo730Lqn2a+SJelYD55ymCBtA4GIWp
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Jul 2022 06:05:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 06:05:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 06:05:24 -0700
Received: from [10.242.7.35] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Jul
 2022 06:05:20 -0700
Message-ID: <1bc53dc5-fc7f-54fd-ab7c-f1e77548b20d@quicinc.com>
Date:   Thu, 14 Jul 2022 18:35:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [V5] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Content-Language: en-CA
To:     Jiri Slaby <jirislaby@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>,
        <gregkh@linuxfoundation.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <dianders@chromium.org>,
        <mka@chromium.org>, <swboyd@chromium.org>
References: <1657629905-24685-1-git-send-email-quic_vnivarth@quicinc.com>
 <b973cfc2-d9a8-5d62-036f-14671cf56799@kernel.org>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <b973cfc2-d9a8-5d62-036f-14671cf56799@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 7/14/2022 4:16 PM, Jiri Slaby wrote:
> On 12. 07. 22, 14:45, Vijaya Krishna Nivarthi wrote:
> ...
>> +static unsigned long get_clk_div_rate(struct clk *clk, struct device 
>> *dev,
>> +        unsigned int baud, unsigned int sampling_rate, unsigned int 
>> *clk_div)
>> +{
>> +    unsigned long ser_clk;
>> +    unsigned long desired_clk;
>> +
>> +    desired_clk = baud * sampling_rate;
>> +    if (!desired_clk) {
>> +        dev_dbg(dev, "Invalid frequency\n");
>> +        return 0;
>>       }
>>   -    *clk_div = ser_clk / desired_clk;
>> -    if (!(*clk_div))
>> -        *clk_div = 1;
>> +    /*
>> +     * try to find a clock rate within 2% tolerance, then within
>
> "then within" ... "5" is missing, perhaps?


Yes :(

Will change.


>
>> +     */
>> +    ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2);
>> +    if (!ser_clk)
>> +        ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5);
>> +
>> +    if (!ser_clk)
>> +        dev_err(dev, "Couldn't find suitable clock rate for %lu\n", 
>> desired_clk);
>> +    else
>> +        dev_dbg(dev, "desired_clk-%lu, ser_clk-%lu, clk_div-%u\n",
>> +                desired_clk, ser_clk, *clk_div);
>>         return ser_clk;
>>   }
>> @@ -1021,8 +1040,8 @@ static void qcom_geni_serial_set_termios(struct 
>> uart_port *uport,
>>       if (ver >= QUP_SE_VERSION_2_5)
>>           sampling_rate /= 2;
>>   -    clk_rate = get_clk_div_rate(port->se.clk, baud,
>> -        sampling_rate, &clk_div);
>> +    clk_rate = get_clk_div_rate(port->se.clk, port->se.dev, baud,
>
> Maybe worth passing whole geni_se (port->se) then?


but then geni_se is a struct; shall we pass port instead?

Alternately move logging to caller?

Thank you.


>
>> +                    sampling_rate, &clk_div);
>>       if (!clk_rate)
>>           goto out_restart_rx;
>
> thanks,
