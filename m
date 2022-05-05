Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5276F51BBBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352305AbiEEJVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352230AbiEEJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:20:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101CA4C42A;
        Thu,  5 May 2022 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651742241; x=1683278241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EiuwdT1DQIksm0VaK6BDVdizKr2lpUkrZBCHOGjwGow=;
  b=c+t2brdzrLmIfofKUelL7O03gAJZByfNHjJm/XocYhJ6ZfjgrnNzKv08
   3O2valWXeKbNfdBD3UewrhSVuJMLfO9TBRm3GE+G2SBkNOwCyyCoKXevv
   LVvKoux0lUK93O05uw+kmKKbLIpYXNRrpeLo94mw/Ig0+oNWDE68peARG
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 May 2022 02:17:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 02:17:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 02:17:19 -0700
Received: from [10.216.61.109] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 5 May 2022
 02:17:14 -0700
Message-ID: <7775ff60-7b17-3c67-ecdd-c85e343e7808@quicinc.com>
Date:   Thu, 5 May 2022 14:47:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V5] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <adrian.hunter@intel.com>, <p.zabel@pengutronix.de>,
        <chris@printf.net>, <venkatg@codeaurora.org>, <gdjakov@mm-sol.com>,
        <quic_asutoshd@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rampraka@quicinc.com>, <quic_pragalla@quicinc.com>,
        <quic_sartgarg@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_sayalil@quicinc.com>
References: <1650816153-23797-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <CAPDyKFp=p+m2YSYJne=4TyejgYD-6OoARc=NkaFJOpora1r9iA@mail.gmail.com>
 <CAPDyKFq5LFk9im7eeyd5Qcohb+3uCJTGTTYLB98wK=YXCipLNA@mail.gmail.com>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <CAPDyKFq5LFk9im7eeyd5Qcohb+3uCJTGTTYLB98wK=YXCipLNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2022 4:07 PM, Ulf Hansson wrote:
> On Wed, 27 Apr 2022 at 16:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On Sun, 24 Apr 2022 at 18:02, Shaik Sajida Bhanu
>> <quic_c_sbhanu@quicinc.com> wrote:
>>> Reset GCC_SDCC_BCR register before every fresh initilazation. This will
>>> reset whole SDHC-msm controller, clears the previous power control
>>> states and avoids, software reset timeout issues as below.
>>>
>>> [ 5.458061][ T262] mmc1: Reset 0x1 never completed.
>>> [ 5.462454][ T262] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>>> [ 5.469065][ T262] mmc1: sdhci: Sys addr: 0x00000000 | Version: 0x00007202
>>> [ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt: 0x00000000
>>> [ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
>>> [ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl: 0x00000000
>>> [ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap: 0x00000000
>>> [ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
>>> [ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 | Int stat: 0x00000000
>>> [ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
>>> [ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>>> [ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
>>> [ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
>>> [ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]: 0x00000000
>>> [ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]: 0x00000000
>>> [ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000
>>> [ 5.559651][ T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP-----------
>>> [ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg: 0x6000642c | DLL cfg2: 0x0020a000
>>> [ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl: 0x00010800 | DDR cfg: 0x80040873
>>> [ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88218a8 Vndr func3: 0x02626040
>>>
>>> Fixes: 0eb0d9f4de34 ("mmc: sdhci-msm: Initial support for Qualcomm chipsets")
>>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>> So this looks good to me, but I can't apply it until I get a patch
>> that updates the DT doc too.
> Okay, so since we are (I have already queued the patches for v5.19)
> moving the DT bindings into the yaml format, I decided to queue
> $subject patch, as is, for fixes. Moreover, I added a stable tag to
> it.
>
> Please send and patch on top of the new yaml based DT bindings to add
> the property for the reset.
>
> Thanks and kind regards
> Uffe
>
>
>> Kind regards
>> Uffe

Hi,

Sure Thank you.

Sure will post the YAML based DT bindings for resets changes once base 
YAML changes merged.

Thanks,

Sajida

>>
>>> ---
>>>
>>> Changes since V4:
>>>          - Called reset_control_put() in error path.
>>>
>>> Changes since V3:
>>>          - Used reset controller local variable as suggested by
>>>            Bjorn Andersson.
>>>          - Passed NULL as a parameter to
>>>            devm_reset_control_get_optional_exclusive() as suggested by
>>>            Bjorn Andersson.
>>>          - Replaced devm_reset_control_get_optional_exclusive() with
>>>            reset_control_get_optional_exclusive() and called
>>>            reset_control_put() before returning to clear the reset
>>>            controller as suggested by Bjorn Andersson.
>>>
>>> Changes since V2:
>>>          - Dropped new line after fixes tag as suggested by Bjorn
>>>            Andersson.
>>>          - Passed device structure instead of passing platform_device
>>>            structure as a argument for sdhci_msm_gcc_reset() as suggested
>>>            by Bjorn Andersson.
>>>          - Replaced dev_err() with dev_err_probe() as suggested by Bjorn
>>>            Andersson.
>>>
>>> Changes since V1:
>>>          - Added fixes tag as suggested by Ulf Hansson.
>>>          - Replaced devm_reset_control_get() with
>>>            devm_reset_control_get_optional_exclusive() as suggested by
>>>            Ulf Hansson.
>>> ---
>>>   drivers/mmc/host/sdhci-msm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 42 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>> index 50c71e0..ff9f5b6 100644
>>> --- a/drivers/mmc/host/sdhci-msm.c
>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>> @@ -17,6 +17,7 @@
>>>   #include <linux/regulator/consumer.h>
>>>   #include <linux/interconnect.h>
>>>   #include <linux/pinctrl/consumer.h>
>>> +#include <linux/reset.h>
>>>
>>>   #include "sdhci-pltfm.h"
>>>   #include "cqhci.h"
>>> @@ -2482,6 +2483,43 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>>>          of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>>>   }
>>>
>>> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
>>> +{
>>> +       struct reset_control *reset;
>>> +       int ret = 0;
>>> +
>>> +       reset = reset_control_get_optional_exclusive(dev, NULL);
>>> +       if (IS_ERR(reset))
>>> +               return dev_err_probe(dev, PTR_ERR(reset),
>>> +                               "unable to acquire core_reset\n");
>>> +
>>> +       if (!reset)
>>> +               return ret;
>>> +
>>> +       ret = reset_control_assert(reset);
>>> +       if (ret) {
>>> +               reset_control_put(reset);
>>> +               return dev_err_probe(dev, ret, "core_reset assert failed\n");
>>> +       }
>>> +
>>> +       /*
>>> +        * The hardware requirement for delay between assert/deassert
>>> +        * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
>>> +        * ~125us (4/32768). To be on the safe side add 200us delay.
>>> +        */
>>> +       usleep_range(200, 210);
>>> +
>>> +       ret = reset_control_deassert(reset);
>>> +       if (ret) {
>>> +               reset_control_put(reset);
>>> +               return dev_err_probe(dev, ret, "core_reset deassert failed\n");
>>> +       }
>>> +
>>> +       usleep_range(200, 210);
>>> +       reset_control_put(reset);
>>> +
>>> +       return ret;
>>> +}
>>>
>>>   static int sdhci_msm_probe(struct platform_device *pdev)
>>>   {
>>> @@ -2529,6 +2567,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>>
>>>          msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>>>
>>> +       ret = sdhci_msm_gcc_reset(&pdev->dev, host);
>>> +       if (ret)
>>> +               goto pltfm_free;
>>> +
>>>          /* Setup SDCC bus voter clock. */
>>>          msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>>>          if (!IS_ERR(msm_host->bus_clk)) {
>>> --
>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>>> of Code Aurora Forum, hosted by The Linux Foundation
>>>
