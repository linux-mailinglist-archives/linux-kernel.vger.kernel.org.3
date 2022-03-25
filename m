Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE44E6EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348288AbiCYHZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbiCYHZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:25:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5492929821;
        Fri, 25 Mar 2022 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648193008; x=1679729008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t2cm6FUqVnb6HFIvoRE1nNyfNP+uxM9hF5kat0eAGC4=;
  b=caD/Csp2ZtsLpSbyp0TMp5Lzunm7qDfkf6EWNLN2JmWoioaWhq3CB1/v
   Cv2h7Q82KiFM4PATlIv33pq5iXUw/9JwhXuFMbzRwBoNQ42g/kkfJgsTF
   VLdxM2SAJKO/bQA2kbsp34gTdAm3M40aPGJYSajxRm0Z35SqZYhd+9ZRy
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Mar 2022 00:23:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 00:23:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 00:23:22 -0700
Received: from [10.216.31.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 25 Mar
 2022 00:22:42 -0700
Message-ID: <f88d2318-38fa-1db2-37c8-39693b321306@quicinc.com>
Date:   Fri, 25 Mar 2022 12:52:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V2] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Content-Language: en-US
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "chris@printf.net" <chris@printf.net>,
        "gdjakov@mm-sol.com" <gdjakov@mm-sol.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>
References: <1646926823-5362-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <YiqMZouVVEtVNrlV@ripper>
 <SJ0PR02MB844961406A5030D86AAFC71ACD109@SJ0PR02MB8449.namprd02.prod.outlook.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <SJ0PR02MB844961406A5030D86AAFC71ACD109@SJ0PR02MB8449.namprd02.prod.outlook.com>
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


On 3/15/2022 2:47 PM, Sajida Bhanu (Temp) (QUIC) wrote:
> Hi,
>
> Thanks for the review.
>
> Please find the inline comments.
>
> Thanks,
> Sajida
>> -----Original Message-----
>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Sent: Friday, March 11, 2022 5:10 AM
>> To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
>> Cc: adrian.hunter@intel.com; agross@kernel.org; ulf.hansson@linaro.org;
>> p.zabel@pengutronix.de; chris@printf.net; gdjakov@mm-sol.com; linux-
>> mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Asutosh Das (QUIC) <quic_asutoshd@quicinc.com>;
>> Ram Prakash Gupta (QUIC) <quic_rampraka@quicinc.com>; Pradeep
>> Pragallapati (QUIC) <quic_pragalla@quicinc.com>; Sarthak Garg (QUIC)
>> <quic_sartgarg@quicinc.com>; Nitin Rawat (QUIC)
>> <quic_nitirawa@quicinc.com>; Sayali Lokhande (QUIC)
>> <quic_sayalil@quicinc.com>
>> Subject: Re: [PATCH V2] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for
>> SDHC
>>
>> On Thu 10 Mar 07:40 PST 2022, Shaik Sajida Bhanu wrote:
>>
>>> Reset GCC_SDCC_BCR register before every fresh initilazation. This
>>> will reset whole SDHC-msm controller, clears the previous power
>>> control states and avoids, software reset timeout issues as below.
>>>
>> Nice, we've gotten reports about this from time to time.
>>
>>> [ 5.458061][ T262] mmc1: Reset 0x1 never completed.
>>> [ 5.462454][ T262] mmc1: sdhci: ============ SDHCI REGISTER DUMP
>>> =========== [ 5.469065][ T262] mmc1: sdhci: Sys addr: 0x00000000 |
>>> Version:
>>> 0x00007202
>>> [ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt:
>>> 0x00000000
>>> [ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode:
>>> 0x00000000
>>> [ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl:
>>> 0x00000000
>>> [ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap:
>>> 0x00000000 [ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 |
>>> Clock: 0x00000003 [ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 |
>> Int stat:
>>> 0x00000000
>>> [ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab:
>>> 0x00000000
>>> [ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int:
>>> 0x00000000
>>> [ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
>>> [ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
>>> [ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]:
>>> 0x00000000
>>> [ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]:
>>> 0x00000000
>>> [ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000 [ 5.559651][
>>> T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER
>>> DUMP-----------
>>> [ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg:
>>> 0x6000642c |
>>> DLL cfg2: 0x0020a000
>>> [ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl:
>>> 0x00010800 | DDR cfg: 0x80040873
>>> [ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 :
>>> 0xf88218a8 Vndr func3: 0x02626040
>> Please ignore the line length "limit" and leave these unwrapped.
>>
> Sure
>>> Fixes: 0eb0d9f4de34 ("mmc: sdhci-msm: Initial support for Qualcomm
>>> chipsets")
>> This as well, and please drop the empty line between Fixes: and Signed-off-
>> by:.
>>
> Sure
>>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>>> ---
>>>
>>> Changes since V1:
>>>      - Added fixes tag as suggested by Ulf Hansson.
>>>      - Replaced devm_reset_control_get() with
>>>        devm_reset_control_get_optional_exclusive() as suggested by
>>>        Ulf Hansson.
>>> ---
>>>   drivers/mmc/host/sdhci-msm.c | 48
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 48 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-msm.c
>>> b/drivers/mmc/host/sdhci-msm.c index 50c71e0..cb33c9a 100644
>>> --- a/drivers/mmc/host/sdhci-msm.c
>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>> @@ -17,6 +17,7 @@
>>>   #include <linux/regulator/consumer.h>  #include
>>> <linux/interconnect.h>  #include <linux/pinctrl/consumer.h>
>>> +#include <linux/reset.h>
>>>
>>>   #include "sdhci-pltfm.h"
>>>   #include "cqhci.h"
>>> @@ -284,6 +285,7 @@ struct sdhci_msm_host {
>>>      bool uses_tassadar_dll;
>>>      u32 dll_config;
>>>      u32 ddr_config;
>>> +   struct reset_control *core_reset;
>> As you only reset the controller once, during probe, this can be a local
>> variable in sdhci_msm_gcc_reset().
> Hi,
>
> In future if any requirement to reset gcc , for example if we want to reset gcc as a part of hardware reset then we can use this core_reset right.
>
> Thanks,
> Sajida
>>>      bool vqmmc_enabled;
>>>   };
>>>
>>> @@ -2482,6 +2484,45 @@ static inline void
>> sdhci_msm_get_of_property(struct platform_device *pdev,
>>>      of_property_read_u32(node, "qcom,dll-config",
>>> &msm_host->dll_config);  }
>>>
>>> +static int sdhci_msm_gcc_reset(struct platform_device *pdev,
>> You don't need pdev here, take a struct deivce * in and pass &pdev->dev.
> Ok
>>> +          struct sdhci_host *host)
>>> +{
>>> +   struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +   struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>> +   int ret = 0;
>>> +
>>> +   msm_host->core_reset =
>>> +devm_reset_control_get_optional_exclusive(&pdev->dev,
>> "core_reset");
>>
>> No need to hold onto that, so use the non-devm variant and free the reset at
>> the end of the function.
> Sorry didn't get this.
> Can you please point me any reference for this.

Hi,

Can you please help with comment on this.

Thanks,

Sajida

>>> +   if (IS_ERR(msm_host->core_reset)) {
>>> +           ret = PTR_ERR(msm_host->core_reset);
>>> +           dev_err(&pdev->dev, "core_reset unavailable (%d)\n", ret);
>>> +           msm_host->core_reset = NULL;
>> return dev_err_probe(&pdev->dev, PTR_ERR(msm_host->core_reset),
>> "unable to acquire core_reset\n");
>>
>>> +   }
>>> +   if (msm_host->core_reset) {
>> If you flip this around as:
>>
>>        if (!msm_host->core_reset)
>>                return 0;
>>
>> You don't need to zero-initialize ret, use goto and indent this block.
> Sure
>>> +           ret = reset_control_assert(msm_host->core_reset);
>>> +           if (ret) {
>>> +                   dev_err(&pdev->dev, "core_reset assert failed
>> (%d)\n",
>>> +                                           ret);
>>> +                   goto out;
>> return dev_err_probe();
>>
> Sure
>>> +           }
>>> +           /*
>>> +            * The hardware requirement for delay between
>> assert/deassert
>>> +            * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
>>> +            * ~125us (4/32768). To be on the safe side add 200us delay.
>>> +            */
>>> +           usleep_range(200, 210);
>>> +
>>> +           ret = reset_control_deassert(msm_host->core_reset);
>>> +           if (ret) {
>>> +                   dev_err(&pdev->dev, "core_reset deassert failed
>> (%d)\n",
>>> +                                           ret);
>>> +                   goto out;
>> return dev_err_probe()
> Sure
>>> +           }
>>> +           usleep_range(200, 210);
>> The comment above says that we need to hold reset for 125us, is this delay
>> in here in error or should the comment above mention that this needs to be
>> done after deasserting the reset as well?
> Yes we need delay after deasserting the reset as well.
>>> +   }
>>> +
>>> +out:
>>> +   return ret;
>> With above, you can return 0 here.
>>
>>> +}
>>>
>>>   static int sdhci_msm_probe(struct platform_device *pdev)  { @@
>>> -2529,6 +2570,13 @@ static int sdhci_msm_probe(struct platform_device
>>> *pdev)
>>>
>>>      msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>>>
>>> +   ret = sdhci_msm_gcc_reset(pdev, host);
>>> +   if (ret) {
>>> +           dev_err(&pdev->dev, "core_reset assert/deassert failed
>> (%d)\n",
>>> +                                   ret);
>> You just printed in sdhci_msm_gcc_reset(), no need to print again.
>>
>> Regards,
>> Bjorn
>>
> Okay Sure
>>> +           goto pltfm_free;
>>> +   }
>>> +
>>>      /* Setup SDCC bus voter clock. */
>>>      msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>>>      if (!IS_ERR(msm_host->bus_clk)) {
>>> --
>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>>> member of Code Aurora Forum, hosted by The Linux Foundation
>>>
