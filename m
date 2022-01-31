Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05EF4A4ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358147AbiAaSsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:48:01 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:50845 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357574AbiAaSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643654864; x=1675190864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IYhSZ/tzFqcI2juAz94tHNjGagZXt+e1KImDPdpb4Bo=;
  b=r7bZgf3XeY2ddfI0ElDypk5MC+E1lYyowymakwHA8am0INIxp4ybe1th
   GzA64i8u/7tKsAXp/MecWLo+QArKGUBDJ9m0kDk8c8D9ifuOkYAxBrs7o
   qjUQVlj8HAukj1b1VsCFjgH6UgTnMD8u7Rb4tWWUbOTTkPokJ6Hib8s4M
   M=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 31 Jan 2022 10:47:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 10:47:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 31 Jan 2022 10:47:03 -0800
Received: from [10.110.97.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 31 Jan
 2022 10:47:02 -0800
Message-ID: <6a00d247-da34-c499-8d2a-b3f336a3d136@quicinc.com>
Date:   Mon, 31 Jan 2022 10:47:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] input: misc: pm8941-pwrkey: add software key press
 debouncing support
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <skakit@codeaurora.org>
References: <20220127210024.25597-1-quic_amelende@quicinc.com>
 <20220127210024.25597-4-quic_amelende@quicinc.com>
 <CAE-0n53oQEs+GO8+SXf1Zp4RT3FNvFzpDT+jYJA4fub77w+utw@mail.gmail.com>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CAE-0n53oQEs+GO8+SXf1Zp4RT3FNvFzpDT+jYJA4fub77w+utw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2022 2:44 PM, Stephen Boyd wrote:
> Quoting Anjelique Melendez (2022-01-27 13:00:27)
>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>> index 7005aede4f81..bcdbe260b684 100644
>> --- a/drivers/input/misc/pm8941-pwrkey.c
>> +++ b/drivers/input/misc/pm8941-pwrkey.c
> [...]
>> +static int pm8941_pwrkey_sw_debounce_init(struct pm8941_pwrkey *pwrkey)
>> +{
>> +       unsigned int val, addr, mask;
>> +       int error;
>> +
>> +       if (pwrkey->data->has_pon_pbs && !pwrkey->pon_pbs_baseaddr) {
>> +               dev_err(pwrkey->dev, "PON_PBS address missing, can't read HW debounce time\n");
>> +               return 0;
>> +       }
>> +
>> +       if (pwrkey->pon_pbs_baseaddr)
>> +               addr = pwrkey->pon_pbs_baseaddr + PON_DBC_CTL;
>> +       else
>> +               addr = pwrkey->baseaddr + PON_DBC_CTL;
>> +       error = regmap_read(pwrkey->regmap, addr, &val);
>> +       if (error)
>> +               return error;
>> +
>> +       if (pwrkey->subtype >= PON_SUBTYPE_GEN2_PRIMARY)
>> +               mask = 0xf;
>> +       else
>> +               mask = 0x7;
>> +
>> +       pwrkey->sw_debounce_time_us = 2 * USEC_PER_SEC /
>> +                                               (1 << (mask - (val & mask)));
>          pwrkey->sw_debounce_time_us = 2 * USEC_PER_SEC / (1 << (mask
> - (val & mask)));
>
> Nitpick: Put this one one line?

ACK

>
>> +
>> +       dev_dbg(pwrkey->dev, "SW debounce time = %u us\n",
>> +               pwrkey->sw_debounce_time_us);
>> +
>> +       return 0;
>> +}
>> +
>>  static int __maybe_unused pm8941_pwrkey_suspend(struct device *dev)
>>  {
>>         struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);

