Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46571474912
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhLNRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:15:36 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:11262 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233758AbhLNRPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639502135; x=1671038135;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=V3ZUoQpiArCEzg9uDWxQEPmkSZnIQmzZmlxrBFeYcTE=;
  b=CKKRAcrUbaR2Y0WcVBE4SgetYhnl7EgXY7nWzRYxIcAiX3AtDWabjEE1
   1NxxeO8796zFFmjbgvMox3lB8rZExolDbfN5rgsY0anvwzCq/JfC7Xdgp
   IctMbcSB6Yjyo1tBejurLd1pEc9yUcV7n9ZlIhvOXbxoH2Pn3AqF3IupL
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Dec 2021 09:15:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:15:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 14 Dec 2021 09:15:33 -0800
Received: from [10.216.27.180] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 14 Dec
 2021 09:15:26 -0800
Subject: Re: [PATCH v5 3/5] pinctrl: qcom: Extract chip specific LPASS LPI
 code
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <rohitkr@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-4-git-send-email-quic_srivasam@quicinc.com>
 <CAHp75Vd=47Tv9Sf+styPhxS2=O1H2KUDeKQXTULUYU5fDgGwwA@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <0f6621e5-f014-27c9-be8b-6c32ab994304@quicinc.com>
Date:   Tue, 14 Dec 2021 22:45:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd=47Tv9Sf+styPhxS2=O1H2KUDeKQXTULUYU5fDgGwwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/8/2021 11:58 AM, Andy Shevchenko wrote:
Thanks for your time Andy!!!
> On Wed, Dec 8, 2021 at 2:39 AM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
>> Extract the chip specific SM8250 data from the LPASS LPI pinctrl driver
>> to allow reusing the common code in the addition of subsequent
>> platforms.
> ...
>
>> @@ -661,8 +454,10 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
>>
>>          return ret;
>>   }
>> +EXPORT_SYMBOL(lpi_pinctrl_probe);
>> +
> Stray change.
>
> ...

okay. will remove it.

>
>> +#ifndef __PINCTRL_LPASS_LPI_H__
>> +#define __PINCTRL_LPASS_LPI_H__
> Missed headers.
> At least bits.h.
>
> ...
Okay. will add.
>> +#define NO_SLEW                                -1
> Naming sucks for the header.
>
> LPI_NO_SLEW ?

Actually it's already mainline code. Just these patches are 
rearrangement of old code.

still do you suggest to change?

>
> ...
>
>> +struct lpi_pingroup {
>> +       const char *name;
>> +       const unsigned int *pins;
>> +       unsigned int npins;
>> +       unsigned int pin;
>> +       /* Bit offset in slew register for SoundWire pins only */
>> +       int slew_offset;
>> +       unsigned int *funcs;
>> +       unsigned int nfuncs;
>> +};
> Are you going to convert this to use struct group_desc?
>
> ...
>
>> +       LPI_MUX__,
> Strange naming. Besides, if it is the terminator, drop the comma.
okay will remove comma. but name is from existing code.
>
