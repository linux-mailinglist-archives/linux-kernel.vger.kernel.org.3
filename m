Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2824B6307
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiBOFpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:45:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiBOFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:45:29 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CF770F5A;
        Mon, 14 Feb 2022 21:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644903920; x=1676439920;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ombo381yTECr2++CC6IrhFb5/8w8RFX970kix5v4qaQ=;
  b=Jy7QQJRdQlc6mJ+M0+R9pbVfj9ONMWOQGC/c9bQWPBCVKM7R1qd8ANuc
   HZCyXn6Oy99GsXHRT/rWXCbP/S2+TcCJEvUHPxeL++kx6O3xckuzdfR7y
   UpPe4QwLGeJ1dh1gkSX8Dqu/QeC50oifzIo2D8cCPbe4kLteEZN+yh0ax
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Feb 2022 21:45:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 21:45:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 21:45:19 -0800
Received: from [10.216.16.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 21:45:16 -0800
Message-ID: <151d2942-7b47-8d5c-8caa-3b88895b2abf@quicinc.com>
Date:   Tue, 15 Feb 2022 11:15:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 4/8] clk: qcom: Add A7 PLL support for SDX65
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1644821987-27343-1-git-send-email-quic_rohiagar@quicinc.com>
 <20220214084214.GD3494@thinkpad>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <20220214084214.GD3494@thinkpad>
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


On 2/14/2022 2:12 PM, Manivannan Sadhasivam wrote:
> On Mon, Feb 14, 2022 at 12:29:47PM +0530, Rohit Agarwal wrote:
>> Add support for PLL found in Qualcomm SDX65 platforms which is used to
>> provide clock to the Cortex A7 CPU via a mux. This PLL can provide high
>> frequency clock to the CPU above 1GHz as compared to the other sources
>> like GPLL0.
>>
>> In this driver, the power domain is attached to the cpudev. This is
>> required for CPUFreq functionality and there seems to be no better place
>> to do other than this driver (no dedicated CPUFreq driver).
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig  | 6 +++---
>>   drivers/clk/qcom/a7-pll.c | 1 +
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 6cd0634..1904ba1 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -29,11 +29,11 @@ config QCOM_A53PLL
>>   	  devices.
>>   
>>   config QCOM_A7PLL
>> -	tristate "SDX55 A7 PLL"
>> +	tristate "SDX55 like A7 PLL"
> A7 PLL driver for SDX55 and SDX65
Will do.
>
>>   	help
>> -	  Support for the A7 PLL on SDX55 devices. It provides the CPU with
>> +	  Support for the A7 PLL on SDX55 like devices. It provides the CPU with
>>   	  frequencies above 1GHz.
>> -	  Say Y if you want to support higher CPU frequencies on SDX55
>> +	  Say Y if you want to support higher CPU frequencies on SDX55 like
> Say Y if you want to support higher CPU frequencies on devices such as SDX55 and
> SDX65.
Will do.
> Thanks,
> Mani
>
>>   	  devices.
>>   
>>   config QCOM_CLK_APCS_MSM8916
>> diff --git a/drivers/clk/qcom/a7-pll.c b/drivers/clk/qcom/a7-pll.c
>> index c4a53e5..adb2121 100644
>> --- a/drivers/clk/qcom/a7-pll.c
>> +++ b/drivers/clk/qcom/a7-pll.c
>> @@ -84,6 +84,7 @@ static int qcom_a7pll_probe(struct platform_device *pdev)
>>   
>>   static const struct of_device_id qcom_a7pll_match_table[] = {
>>   	{ .compatible = "qcom,sdx55-a7pll" },
>> +	{ .compatible = "qcom,sdx65-a7pll" },
>>   	{ }
>>   };
>>   MODULE_DEVICE_TABLE(of, qcom_a7pll_match_table);
>> -- 
>> 2.7.4
>>
