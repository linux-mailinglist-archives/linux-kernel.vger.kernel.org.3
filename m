Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53551496876
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiAVAEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:04:16 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:20322 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbiAVAEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642809856; x=1674345856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=412XE3+ZU6VfbItTPkPm2CDt5Bp3HWe4215R2q4Oq6k=;
  b=g6Ak6FE4G2W/yGDgyaIrA4o00UVIGTSKJIlXVHCaHkiMJNycWHb3GU0w
   Ij8/hrMVgYaxqxSHTau03+B8IAjdI0pxaRaZHCaiHUYzrVaoioG2XlBRv
   K+9Uz9df8A6hGS3t+MylDwcHU9VBNLo86EI1m3tARi6mxjcq7X6wlE9nC
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jan 2022 16:04:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 16:04:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 21 Jan 2022 16:04:14 -0800
Received: from [10.110.112.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 21 Jan
 2022 16:04:13 -0800
Message-ID: <efa57fd8-d2ac-4c02-04ac-c62315b3b28c@quicinc.com>
Date:   Fri, 21 Jan 2022 16:04:13 -0800
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
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CAE-0n508nxF_c9pzsTaQfSi42ZGQXkqb3NyQebuMBec2DCV0KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2022 8:08 PM, Stephen Boyd wrote:
> Quoting Anjelique Melendez (2022-01-20 12:41:33)
>> From: David Collins <collinsd@codeaurora.org>
>>
>> On certain PMICs, an unexpected assertion of KPDPWR_DEB (the
>> positive logic hardware debounced power key signal) may be seen
>> during the falling edge of KPDPWR_N (i.e. a power key press) when
>> it occurs close to the rising edge of SLEEP_CLK.  This then
>> triggers a spurious KPDPWR interrupt.
>>
>> Handle this issue by adding software debouncing support to ignore
>> key events that occur within the hardware debounce delay after the
>> most recent key release event.
>>
>> Change-Id: Ifa3809935c01aab9078ba2302397bc9ebf390021
> Please remove change-id when upstreaming.

Will remove change-id from other 2 patches as well.

>
>> Signed-off-by: David Collins <collinsd@codeaurora.org>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
>> index 33609603245d..b912ce00ce1c 100644
>> --- a/drivers/input/misc/pm8941-pwrkey.c
>> +++ b/drivers/input/misc/pm8941-pwrkey.c
>> @@ -126,19 +144,65 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
>>         struct pm8941_pwrkey *pwrkey = _data;
>>         unsigned int sts;
>>         int error;
>> +       u64 elapsed_us;
>> +
>> +       if (pwrkey->sw_debounce_time_us) {
>> +               elapsed_us = ktime_us_delta(ktime_get(),
>> +                                           pwrkey->last_release_time);
>> +               if (elapsed_us < pwrkey->sw_debounce_time_us) {
> Perhaps storing last_release_time + sw_debounce_time_us via
> ktime_add_us() in the struct would be better. Then this line would be
>
> 	if (ktime_before(debounce_end, ktime_get()))
>
> and we'd avoid a division when converting to microseconds to compare
> time.

Sure this can be done!

>> +                       dev_dbg(pwrkey->dev, "ignoring key event received after %llu us, debounce time=%u us\n",
>> +                               elapsed_us, pwrkey->sw_debounce_time_us);
>> +                       return IRQ_HANDLED;
>> +               }
>> +       }
>>
>>         error = regmap_read(pwrkey->regmap,
>>                             pwrkey->baseaddr + PON_RT_STS, &sts);
> Nitpick: I'd prefer this be on one line. And 'ret' or 'err' be used as
> it's shorter.

ACK

>
>>         if (error)
>>                 return IRQ_HANDLED;
>>
>> -       input_report_key(pwrkey->input, pwrkey->code,
>> -                        sts & pwrkey->data->status_bit);
>> +       sts &= pwrkey->data->status_bit;
>> +
>> +       if (pwrkey->sw_debounce_time_us && !sts)
>> +               pwrkey->last_release_time = ktime_get();
>> +
>> +       input_report_key(pwrkey->input, pwrkey->code, sts);
>>         input_sync(pwrkey->input);
>>
>>         return IRQ_HANDLED;
>>  }
>>
>> +static int pm8941_pwrkey_sw_debounce_init(struct pm8941_pwrkey *pwrkey)
>> +{
>> +       unsigned int val, addr;
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
>> +               pwrkey->sw_debounce_time_us = 2 * USEC_PER_SEC /
>> +                                               (1 << (0xf - (val & 0xf)));
>> +       else
>> +               pwrkey->sw_debounce_time_us = 2 * USEC_PER_SEC /
>> +                                               (1 << (0x7 - (val & 0x7)));
> Can we have one more local variable like 'mask' or 'offset'. Then the
> code would be easier to read
>
> 	if (pwrkey->subtype >= PON_SUBTYPE_GEN2_PRIMARY)
> 		mask = 0xf;
> 	else
> 		mask = 0x7
> 	
> 	pwrkey->sw_debounce_time_us = 2 * USEC_PER_SEC / (1 << mask - (val & 0x7));

Sure not a problem!

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
>> @@ -167,6 +231,8 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>         struct pm8941_pwrkey *pwrkey;
>>         bool pull_up;
>>         struct device *parent;
>> +       struct device_node *regmap_node;
>> +       const __be32 *addr;
>>         u32 req_delay;
>>         int error;
>>
>> @@ -188,8 +254,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>         pwrkey->data = of_device_get_match_data(&pdev->dev);
>>
>>         parent = pdev->dev.parent;
>> +       regmap_node = pdev->dev.of_node;
>>         pwrkey->regmap = dev_get_regmap(parent, NULL);
>>         if (!pwrkey->regmap) {
>> +               regmap_node = parent->of_node;
>>                 /*
>>                  * We failed to get regmap for parent. Let's see if we are
>>                  * a child of pon node and read regmap and reg from its
>> @@ -200,15 +268,21 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
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
> Can this hunk be split off? A new API is used and it doesn't look
> relevant to this patch.

In PMK8350 and following chips the reg property will have the pon hlos address first,
followed by a second pon pbs address. This change is needed so that both the older chipsets
and the newer can be used regardless of how many reg addresses are being used.

>
>> +
>> +       if (pwrkey->data->has_pon_pbs) {
>> +               /* PON_PBS base address is optional */
>> +               addr = of_get_address(regmap_node, 1, NULL, NULL);
>> +               if (addr)
>> +                       pwrkey->pon_pbs_baseaddr = be32_to_cpu(*addr);
>>         }
>> -       if (error)
>> -               return error;
>>
>>         pwrkey->irq = platform_get_irq(pdev, 0);
>>         if (pwrkey->irq < 0)
>> @@ -217,7 +291,14 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>         error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_REV2,
>>                             &pwrkey->revision);
>>         if (error) {
>> -               dev_err(&pdev->dev, "failed to set debounce: %d\n", error);
>> +               dev_err(&pdev->dev, "failed to read revision: %d\n", error);
> Nice error message fix!
>
>> +               return error;
>> +       }
>> +
>> +       error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_SUBTYPE,
>> +                           &pwrkey->subtype);
>> +       if (error) {
>> +               dev_err(&pdev->dev, "failed to read subtype: %d\n", error);
>>                 return error;
>>         }
>>
>> @@ -255,6 +336,12 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>>                 }
>>         }
>>
>> +       if (pwrkey->data->needs_sw_debounce) {
>> +               error = pm8941_pwrkey_sw_debounce_init(pwrkey);
>> +               if (error)
>> +                       return error;
>> +       }
>> +
>>         if (pwrkey->data->pull_up_bit) {
>>                 error = regmap_update_bits(pwrkey->regmap,
>>                                            pwrkey->baseaddr + PON_PULL_CTL,
>> @@ -316,6 +403,8 @@ static const struct pm8941_data pwrkey_data = {
>>         .phys = "pm8941_pwrkey/input0",
>>         .supports_ps_hold_poff_config = true,
>>         .supports_debounce_config = true,
>> +       .needs_sw_debounce = true,
> needs_sw_debounce is always true? Why is it even an option then?

As of right now the "needs_sw_debounce" property is being used for a sw work around for a hw
problem. We anticipate that chips in the future will fix this hw problem and we would then have
devices where needs_sw_debounce would be set to false.

>
>> +       .has_pon_pbs = false,
>>  };
>>
>>  static const struct pm8941_data resin_data = {

