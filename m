Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A8649BC03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiAYTYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:24:49 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:13638 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiAYTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643138678; x=1674674678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uJ9S2I9JwIcsZP3Xg/NZAPRy9Xc3MsaKcTkgUlFWqcQ=;
  b=KIbcWQm4tptz1WSlYFCodAjdzNjGdcU9qRj6gEaCm1TXrkQvgT0FuW0s
   PkEX5qWHA5ylEQis7FT4RF6UrR6Bci3Kp+Td6G4vWBFZC4Qg4eV8LBBjr
   bosYehPmHZ88x+2DP7djZBMT5QNx/Rs/dMDwtG82RnsZHs4vQNdANahY2
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Jan 2022 11:24:37 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:24:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 11:24:36 -0800
Received: from [10.110.14.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 25 Jan
 2022 11:24:35 -0800
Message-ID: <15868e85-d48e-e2a8-a8da-c7b87c22564a@quicinc.com>
Date:   Tue, 25 Jan 2022 11:24:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] input: misc: pm8941-pwrkey: add software key press
 debouncing support
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <collinsd@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <skakit@codeaurora.org>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
 <20220120204132.17875-2-quic_amelende@quicinc.com>
 <CAE-0n508nxF_c9pzsTaQfSi42ZGQXkqb3NyQebuMBec2DCV0KA@mail.gmail.com>
 <efa57fd8-d2ac-4c02-04ac-c62315b3b28c@quicinc.com>
 <CAE-0n51GUGskL17MGhk-=-dbdPU_3ChE37Hbzq6VBZc2Ge0vkA@mail.gmail.com>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CAE-0n51GUGskL17MGhk-=-dbdPU_3ChE37Hbzq6VBZc2Ge0vkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2022 11:33 AM, Stephen Boyd wrote:
> Quoting Anjelique Melendez (2022-01-21 16:04:13)
>>
>> On 1/20/2022 8:08 PM, Stephen Boyd wrote:
>>> Quoting Anjelique Melendez (2022-01-20 12:41:33)
>>>> @@ -200,15 +268,21 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>>>                         dev_err(&pdev->dev, "failed to locate regmap\n");
>>>>                         return -ENODEV;
>>>>                 }
>>>> +       }
>>>>
>>>> -               error = of_property_read_u32(parent->of_node,
>>>> -                                            "reg", &pwrkey->baseaddr);
>>>> -       } else {
>>>> -               error = of_property_read_u32(pdev->dev.of_node, "reg",
>>>> -                                            &pwrkey->baseaddr);
>>>> +       addr = of_get_address(regmap_node, 0, NULL, NULL);
>>>> +       if (!addr) {
>>>> +               dev_err(&pdev->dev, "reg property missing\n");
>>>> +               return -EINVAL;
>>>> +       }
>>>> +       pwrkey->baseaddr = be32_to_cpu(*addr);
>>> Can this hunk be split off? A new API is used and it doesn't look
>>> relevant to this patch.
>> In PMK8350 and following chips the reg property will have the pon hlos address first,
>> followed by a second pon pbs address. This change is needed so that both the older chipsets
>> and the newer can be used regardless of how many reg addresses are being used.
> Got it, but do we ned to change to of_get_address() in this patch? I was
> suggesting that the change to the new API be done first so that it's
> clearer what's going on with the change in address location.

Ok, makes sense. Will separate this into it's own patch for v2.

>>>> +
>>>> +       if (pwrkey->data->has_pon_pbs) {
>>>> +               /* PON_PBS base address is optional */
>>>> +               addr = of_get_address(regmap_node, 1, NULL, NULL);
>>>> +               if (addr)
>>>> +                       pwrkey->pon_pbs_baseaddr = be32_to_cpu(*addr);
>>>>         }
>>>> -       if (error)
>>>> -               return error;
>>>>
>>>>         pwrkey->irq = platform_get_irq(pdev, 0);
>>>>         if (pwrkey->irq < 0)
>>>> @@ -217,7 +291,14 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>>>         error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_REV2,
>>>>                             &pwrkey->revision);
>>>>         if (error) {
>>>> -               dev_err(&pdev->dev, "failed to set debounce: %d\n", error);
>>>> +               dev_err(&pdev->dev, "failed to read revision: %d\n", error);
>>> Nice error message fix!
> This can be split off to a different patch as well.

Will do.

>>>> +               return error;
>>>> +       }
>>>> +
>>>> +       error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_SUBTYPE,
>>>> +                           &pwrkey->subtype);
>>>> +       if (error) {
>>>> +               dev_err(&pdev->dev, "failed to read subtype: %d\n", error);
>>>>                 return error;
>>>>         }
>>>>
>>>> @@ -255,6 +336,12 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>>>                 }
>>>>         }
>>>>
>>>> +       if (pwrkey->data->needs_sw_debounce) {
>>>> +               error = pm8941_pwrkey_sw_debounce_init(pwrkey);
>>>> +               if (error)
>>>> +                       return error;
>>>> +       }
>>>> +
>>>>         if (pwrkey->data->pull_up_bit) {
>>>>                 error = regmap_update_bits(pwrkey->regmap,
>>>>                                            pwrkey->baseaddr + PON_PULL_CTL,
>>>> @@ -316,6 +403,8 @@ static const struct pm8941_data pwrkey_data = {
>>>>         .phys = "pm8941_pwrkey/input0",
>>>>         .supports_ps_hold_poff_config = true,
>>>>         .supports_debounce_config = true,
>>>> +       .needs_sw_debounce = true,
>>> needs_sw_debounce is always true? Why is it even an option then?
>> As of right now the "needs_sw_debounce" property is being used for a sw work around for a hw
>> problem. We anticipate that chips in the future will fix this hw problem and we would then have
>> devices where needs_sw_debounce would be set to false.
> Hmm ok. Why can't future chips be supported in this series? What happens
> if nobody ever adds support for the new chips? We're left with this
> condition that looks like dead code.

Sure, makes sense. Will remove "needs_sw_debounce" property for V2.
