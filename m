Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C3E4A4EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357270AbiAaSpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:45:12 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:41657 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355479AbiAaSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643654710; x=1675190710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j5y1snEaO6AOruLnHqQPXIrcC16jxOnZMbLx94IskSc=;
  b=hP/tLzWr5RXVH6YirkAnzswK1nFl0JPnHLgiQqOLUEc92W79fdmlGRns
   S6lf7vkEd264n/SLj76KaT3/2dXV4WkPMmeRBOndxHoo62FZo+l5l893k
   qfqKLWL/R5OsaawK7/1k0qLKolyUAOolYdmvIzM6k5y1htj/Cejlo2iuD
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 31 Jan 2022 10:45:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 10:45:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 31 Jan 2022 10:44:49 -0800
Received: from [10.110.97.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 31 Jan
 2022 10:44:48 -0800
Message-ID: <ee4a8076-4db3-ae77-b837-3b14c37a7e6a@quicinc.com>
Date:   Mon, 31 Jan 2022 10:44:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/4] input: misc: pm8941-pwrkey: add support for PON
 GEN3 base addresses
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <skakit@codeaurora.org>
References: <20220127210024.25597-1-quic_amelende@quicinc.com>
 <20220127210024.25597-3-quic_amelende@quicinc.com>
 <CAE-0n50UzVw4wqpV1v-T3k2if+m6jv-Tx7+N2kD4O=J60zmuoA@mail.gmail.com>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CAE-0n50UzVw4wqpV1v-T3k2if+m6jv-Tx7+N2kD4O=J60zmuoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2022 2:41 PM, Stephen Boyd wrote:
> Quoting Anjelique Melendez (2022-01-27 13:00:25)
>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>> index e0240db12d4f..7005aede4f81 100644
>> --- a/drivers/input/misc/pm8941-pwrkey.c
>> +++ b/drivers/input/misc/pm8941-pwrkey.c
>> @@ -200,15 +207,21 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>                         dev_err(&pdev->dev, "failed to locate regmap\n");
>>                         return -ENODEV;
>>                 }
>> +       }
>>
>> -               error = of_property_read_u32(parent->of_node,
>> -                                            "reg", &pwrkey->baseaddr);
>> -       } else {
>> -               error = of_property_read_u32(pdev->dev.of_node, "reg",
>> -                                            &pwrkey->baseaddr);
>> +       addr = of_get_address(regmap_node, 0, NULL, NULL);
>> +       if (!addr) {
>> +               dev_err(&pdev->dev, "reg property missing\n");
>> +               return -EINVAL;
>> +       }
>> +       pwrkey->baseaddr = be32_to_cpu(*addr);
> Isn't this supposed to be be32_to_cpup(addr)?

ah yes! Will update in v3!

>
>> +
>> +       if (pwrkey->data->has_pon_pbs) {
>> +               /* PON_PBS base address is optional */
>> +               addr = of_get_address(regmap_node, 1, NULL, NULL);
>> +               if (addr)
>> +                       pwrkey->pon_pbs_baseaddr = be32_to_cpu(*addr);
> Isn't this supposed to be be32_to_cpup(addr)?

Ack

>
>>         }
>> -       if (error)
>> -               return error;
>>
>>         pwrkey->irq = platform_get_irq(pdev, 0);
>>         if (pwrkey->irq < 0)

