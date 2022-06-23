Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B05572CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiFWGGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFWGG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:06:26 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0669E19F98;
        Wed, 22 Jun 2022 23:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655964385; x=1687500385;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=kY+gYmv2uINKm3GjTgEhRJAEIxUH+bB/vOSpMyPge0M=;
  b=M6jDUIbRnzSHI2nkhntJLVJTBMFEmk+XMDr+wabTOqf5JXs5kS++ovQY
   5fZhVG+vOCCOofghgjJ4uO84oFRxlsoW2d0wo/THE1uIhspVzYC+8b4Xo
   BtcxDp0w5I7CgdqZ+03Ti6LoG5Yp1ffc8pLdHCu9bjRnDUdWPIWnaBB3Q
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 22 Jun 2022 23:06:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 23:06:24 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 23:06:23 -0700
Received: from [10.242.242.148] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 23:06:18 -0700
Message-ID: <d891e8a9-a4f9-b6c7-8f51-3823f60120fa@quicinc.com>
Date:   Thu, 23 Jun 2022 11:36:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 3/8] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <p.zabel@pengutronix.de>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
 <20220621161126.15883-4-quic_srichara@quicinc.com>
 <c9ec14db-1ddd-7316-4ef6-9d57509f3fad@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <c9ec14db-1ddd-7316-4ef6-9d57509f3fad@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/2022 8:38 PM, Krzysztof Kozlowski wrote:
> On 21/06/2022 18:11, Sricharan R wrote:
>> From: Varadarajan Narayanan <quic_varada@quicinc.com>
>>
>> Add support for the global clock controller found on IPQ5018
>> based devices.
>>
>> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Thank you for your patch. There is something to discuss/improve.
>
>> ---
>>   drivers/clk/qcom/Kconfig       |    7 +
>>   drivers/clk/qcom/Makefile      |    1 +
>>   drivers/clk/qcom/gcc-ipq5018.c | 3995 ++++++++++++++++++++++++++++++++
>>   3 files changed, 4003 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gcc-ipq5018.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index d01436be6d7a..294fb975db85 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -172,6 +172,13 @@ config IPQ_GCC_8074
>>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>>   	  of ipq8074.
>>   
>> +config IPQ_GCC_5018
>> +	tristate "IPQ5018 Global Clock Controller"
>> +	help
>> +	 Support for global clock controller on ipq5018 devices.
>> +	 Say Y if you want to use peripheral devices such as UART, SPI,
>> +	 i2c, USB, SD/eMMC, etc.
>> +
>>   config MSM_GCC_8660
>>   	tristate "MSM8660 Global Clock Controller"
>>   	help
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 671cf5821af1..33ab4ce9b863 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -26,6 +26,7 @@ obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>>   obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>>   obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>>   obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
>> +obj-$(CONFIG_IPQ_GCC_5018) += gcc-ipq5018.o
>>   obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
>>   obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
>>   obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
> (...)
>
>> +
>> +static int gcc_ipq5018_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct regmap *regmap;
>> +	struct qcom_cc_desc ipq5018_desc = gcc_ipq5018_desc;
>> +
>> +	regmap = qcom_cc_map(pdev, &ipq5018_desc);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	clk_alpha_pll_configure(&ubi32_pll_main, regmap, &ubi32_pll_config);
>> +
>> +	ret = qcom_cc_really_probe(pdev, &ipq5018_desc, regmap);
> return qcom_cc_really_probe(....)

  ok.


>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to register ipq5018 GCC clocks\n");
>> +		return ret;
>> +	}
>> +
>> +	dev_info(&pdev->dev, "Registered ipq5018 GCC clocks provider");
> No probe success messages. This pollutes the log and there is other
> infrastructure to check for successful probe.

  ok.


>> +
>> +	return ret;
>> +}
>> +
>> +static struct platform_driver gcc_ipq5018_driver = {
>> +	.probe = gcc_ipq5018_probe,
>> +	.driver = {
>> +		.name   = "qcom,gcc-ipq5018",
>> +		.owner  = THIS_MODULE,
> No need for owner.

  ok.

Regards,
     Sricharan

