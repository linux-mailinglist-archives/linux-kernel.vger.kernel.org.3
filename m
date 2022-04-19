Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA89506454
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbiDSGTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiDSGTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:19:44 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC76BDEFE;
        Mon, 18 Apr 2022 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650349022; x=1681885022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vz/tDXTaR0vEfEzCOIosJitjnMVTXvM83DJOr1MzVeo=;
  b=TINhM2+K/P1c0zQJudyIC+Kz2LHJJI9wE71z9NUdNzdLUTHmJBvSIXoV
   5WpsJKcXbi2YeORA7BUzUW1m5fvTWkyJTcIdZXhEdNL6P2ZDCQ0vMt+8M
   rl/jmspNgRJ0oyXzXldPDqgDQyRYIyjWrDOc/70pCI6AQoe9DaIZE3fnz
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 23:17:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 23:17:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Apr 2022 23:17:00 -0700
Received: from [10.216.55.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Apr
 2022 23:16:53 -0700
Message-ID: <1943a5fb-cf6c-f358-9e27-408792a458ce@quicinc.com>
Date:   Tue, 19 Apr 2022 11:46:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V4] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Content-Language: en-US
To:     Philipp Zabel <p.zabel@pengutronix.de>, <adrian.hunter@intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <ulf.hansson@linaro.org>, <chris@printf.net>,
        <venkatg@codeaurora.org>, <gdjakov@mm-sol.com>,
        <quic_asutoshd@quicinc.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sartgarg@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sayalil@quicinc.com>
References: <1649759983-22035-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1ee3b0619ee976eaf88e7207318770d441418c94.camel@pengutronix.de>
From:   "Sajida Bhanu (Temp)" <quic_c_sbhanu@quicinc.com>
In-Reply-To: <1ee3b0619ee976eaf88e7207318770d441418c94.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review.

Please find the inline comments.

Thanks,

Sajida

On 4/12/2022 4:30 PM, Philipp Zabel wrote:
> On Di, 2022-04-12 at 16:09 +0530, Shaik Sajida Bhanu wrote:
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
>>   drivers/mmc/host/sdhci-msm.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 50c71e0..0e5fb62 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/interconnect.h>
>>   #include <linux/pinctrl/consumer.h>
>> +#include <linux/reset.h>
>>   
>>
>>
>>
>>   #include "sdhci-pltfm.h"
>>   #include "cqhci.h"
>> @@ -2482,6 +2483,39 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>>   	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
>>   }
>>   
>>
>>
>>
>> +static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
>> +{
>> +	struct reset_control *reset;
>> +	int ret = 0;
> No need to initialize ret.
>
>> +
>> +	reset = reset_control_get_optional_exclusive(dev, NULL);
>> +	if (IS_ERR(reset))
>> +		return dev_err_probe(dev, PTR_ERR(reset),
>> +				"unable to acquire core_reset\n");
>> +
>> +	if (!reset)
>> +		return ret;
Here we are returning ret directly if reset is NULL , so ret 
initialization is required.
>> +
>> +	ret = reset_control_assert(reset);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "core_reset assert failed\n");
> Missing reset_control_put(reset) in the error path.
Sure will add
>
>> +
>> +	/*
>> +	 * The hardware requirement for delay between assert/deassert
>> +	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
>> +	 * ~125us (4/32768). To be on the safe side add 200us delay.
>> +	 */
>> +	usleep_range(200, 210);
>> +
>> +	ret = reset_control_deassert(reset);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "core_reset deassert failed\n");
> Same as above. Maybe make both ret = dev_err_probe() and goto ...
In both cases error message is different so I think goto not good idea here.
>
>> +
>> +	usleep_range(200, 210);
> ... here.
>
>> +	reset_control_put(reset);
>> +
>> +	return ret;
>> +}
> regards
> Philipp
