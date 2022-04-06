Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9D74F6177
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiDFOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiDFOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:07:25 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E940C218D92;
        Wed,  6 Apr 2022 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649238415; x=1680774415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k30NW3oH5aIyNVH7D5psD8nWjzpjRL4SLC4BFhm/zsc=;
  b=APGvTSOqZoQB/Yp+wUmzIgLLRLp+UN7r6wZMoS+O9xUiJ7tk643v6EkF
   8p0FzIUHv6NBmFHP5mzPZFkcwTERaIUkRVMvPbTbDrP5iOfaZXDpn7NP+
   OcI5r28mgMYFprGqjkx9Crn9cTn6MJ93yqgeRF6flVRIo8ycTc93u60Oe
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Apr 2022 02:46:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 02:46:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 02:46:53 -0700
Received: from [10.216.35.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 02:46:46 -0700
Message-ID: <6813f01b-f8f5-0e81-5edd-f9375981ebcd@quicinc.com>
Date:   Wed, 6 Apr 2022 15:16:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V3] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <quic_asutoshd@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_pragalla@quicinc.com>,
        <quic_sartgarg@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_sayalil@quicinc.com>, <agross@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1648710182-31899-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <YkX2BrTjgexrIHtR@ripper>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <YkX2BrTjgexrIHtR@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2022 12:12 AM, Bjorn Andersson wrote:
> On Thu 31 Mar 00:03 PDT 2022, Shaik Sajida Bhanu wrote:
>
>> Reset GCC_SDCC_BCR register before every fresh initilazation. This will
>> reset whole SDHC-msm controller, clears the previous power control
>> states and avoids, software reset timeout issues as below.
>>
>> [ 5.458061][ T262] mmc1: Reset 0x1 never completed.
>> [ 5.462454][ T262] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
>> [ 5.469065][ T262] mmc1: sdhci: Sys addr: 0x00000000 | Version: 0x00007202
>> [ 5.475688][ T262] mmc1: sdhci: Blk size: 0x00000000 | Blk cnt: 0x00000000
>> [ 5.482315][ T262] mmc1: sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
>> [ 5.488927][ T262] mmc1: sdhci: Present: 0x01f800f0 | Host ctl: 0x00000000
>> [ 5.495539][ T262] mmc1: sdhci: Power: 0x00000000 | Blk gap: 0x00000000
>> [ 5.502162][ T262] mmc1: sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
>> [ 5.508768][ T262] mmc1: sdhci: Timeout: 0x00000000 | Int stat: 0x00000000
>> [ 5.515381][ T262] mmc1: sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
>> [ 5.521996][ T262] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
>> [ 5.528607][ T262] mmc1: sdhci: Caps: 0x362dc8b2 | Caps_1: 0x0000808f
>> [ 5.535227][ T262] mmc1: sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
>> [ 5.541841][ T262] mmc1: sdhci: Resp[0]: 0x00000000 | Resp[1]: 0x00000000
>> [ 5.548454][ T262] mmc1: sdhci: Resp[2]: 0x00000000 | Resp[3]: 0x00000000
>> [ 5.555079][ T262] mmc1: sdhci: Host ctl2: 0x00000000
>> [ 5.559651][ T262] mmc1: sdhci_msm: ----------- VENDOR REGISTER DUMP-----------
>> [ 5.566621][ T262] mmc1: sdhci_msm: DLL sts: 0x00000000 | DLL cfg: 0x6000642c | DLL cfg2: 0x0020a000
>> [ 5.575465][ T262] mmc1: sdhci_msm: DLL cfg3: 0x00000000 | DLL usr ctl: 0x00010800 | DDR cfg: 0x80040873
>> [ 5.584658][ T262] mmc1: sdhci_msm: Vndr func: 0x00018a9c | Vndr func2 : 0xf88218a8 Vndr func3: 0x02626040
>>
>> Fixes: 0eb0d9f4de34 ("mmc: sdhci-msm: Initial support for Qualcomm chipsets")
>> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
>> ---
>>
>> Changes since V2:
>> 	- Dropped new line after fixes tag as suggested by Bjorn
>> 	  Andersson.
>> 	- Passed device structure instead of passing platform_device
>> 	  structure as a argument for sdhci_msm_gcc_reset() as suggested
>> 	  by Bjorn Andersson.
>> 	- Replaced dev_err() with dev_err_probe() as suggested by Bjorn
>> 	  Andersson.
> Thanks, looks much better. Still some things I would like to see
> improved below.
Sure
>> Changes since V1:
>> 	- Added fixes tag as suggested by Ulf Hansson.
>> 	- Replaced devm_reset_control_get() with
>> 	  devm_reset_control_get_optional_exclusive() as suggested by
>> 	  Ulf Hansson.
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 50c71e0..e15e789 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/interconnect.h>
>>   #include <linux/pinctrl/consumer.h>
>> +#include <linux/reset.h>
>>   
>>   #include "sdhci-pltfm.h"
>>   #include "cqhci.h"
>> @@ -284,6 +285,7 @@ struct sdhci_msm_host {
>>   	bool uses_tassadar_dll;
>>   	u32 dll_config;
>>   	u32 ddr_config;
>> +	struct reset_control *core_reset;
>>   	bool vqmmc_enabled;
>>   };
>>   
>> @@ -2482,6 +2484,39 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>>   	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>>   }
>>   
>> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +	int ret = 0;
> First use of this variable is an assignment, so no need to initialize it
> here.
Sure
>> +
>> +	msm_host->core_reset = devm_reset_control_get_optional_exclusive(dev, "core_reset");
> reset-names will only be used to identify resets and hence there's no
> reason to include "_reset" in the identifier.
>
> If this is the only reset for the controller, there's actually no reason
> for identifying it, you can omit reset-names from the binding and just
> pass NULL here (to get the first resets = <>).
ok Sure
>> +	if (IS_ERR(msm_host->core_reset))
>> +		return dev_err_probe(dev, PTR_ERR(msm_host->core_reset),
>> +				"unable to acquire core_reset\n");
>> +
>> +	if (!msm_host->core_reset)
>> +		return 0;
>> +
>> +	ret = reset_control_assert(msm_host->core_reset);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "core_reset assert failed\n");
>> +
>> +	/*
>> +	 * The hardware requirement for delay between assert/deassert
>> +	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
>> +	 * ~125us (4/32768). To be on the safe side add 200us delay.
>> +	 */
>> +	usleep_range(200, 210);
>> +
>> +	ret = reset_control_deassert(msm_host->core_reset);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
>> +
>> +	usleep_range(200, 210);
>> +
> sdhci_msm_gcc_reset() is only called once during probe(), so there's no
> reason to carry the reset_control pointer in struct sdhci_msm_host. Make
> it a local variable and use reset_control_get_optional_exclusive() and
> reset_control_put() the reset here before returning.
>
> Regards,
> Bjorn
Sure Thanks for the review.
>> +	return 0;
>> +}
>>   
>>   static int sdhci_msm_probe(struct platform_device *pdev)
>>   {
>> @@ -2529,6 +2564,10 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>   
>>   	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>>   
>> +	ret = sdhci_msm_gcc_reset(&pdev->dev, host);
>> +	if (ret)
>> +		goto pltfm_free;
>> +
>>   	/* Setup SDCC bus voter clock. */
>>   	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>>   	if (!IS_ERR(msm_host->bus_clk)) {
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>
