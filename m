Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40D84A9EDB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377499AbiBDSVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:21:01 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:12986 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234002AbiBDSU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643998859; x=1675534859;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QNQNR8pSD+bvmM7QVunNiubutry5FOQGRyE/RWkBNGQ=;
  b=RTcirssTTj+yIsmm6lDPWOtmS7Qyx7Q/dq4qMCCKmdpPumLLwiSS4Dqr
   3S4f4iRJ6uLfwM2dbWYd2sJiSRLfGmyOMEghw4IRGGUZjEUaYRNZUfIZ8
   jXOmLYkrMHeVnN4o463mB91hhKdXDL4xeK8OxeaTXVINfnRbTKcXb9NgB
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Feb 2022 10:20:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 10:20:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 4 Feb 2022 10:20:58 -0800
Received: from [10.110.74.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 4 Feb 2022
 10:20:58 -0800
Message-ID: <8ccb18ce-5d86-47dd-dec1-8fc1c27dcba1@quicinc.com>
Date:   Fri, 4 Feb 2022 10:20:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] input: misc: pm8941-pwrkey: add support for PON
 GEN3 base addresses
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <skakit@codeaurora.org>
References: <20220203010804.20883-2-quic_amelende@quicinc.com>
 <20220203010804.20883-3-quic_amelende@quicinc.com>
 <CAE-0n51vAD-_0e0sBKECfx51B2a6-BK59LnRp6uGHejU_f3rGQ@mail.gmail.com>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CAE-0n51vAD-_0e0sBKECfx51B2a6-BK59LnRp6uGHejU_f3rGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2022 1:16 PM, Stephen Boyd wrote:
> Quoting Anjelique Melendez (2022-02-02 17:08:05)
>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>> index e0240db12d4f..2a42a676b021 100644
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
>> +       pwrkey->baseaddr = be32_to_cpup(*addr);
>> +
>> +       if (pwrkey->data->has_pon_pbs) {
>> +               /* PON_PBS base address is optional */
>> +               addr = of_get_address(regmap_node, 1, NULL, NULL);
>> +               if (addr)
>> +                       pwrkey->pon_pbs_baseaddr = be32_to_cpup(*addr);
> 
> With the deref dropped.
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

ACK
