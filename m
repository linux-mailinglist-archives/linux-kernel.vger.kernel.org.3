Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA6466E06
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377631AbhLBXyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:54:46 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:28314 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235895AbhLBXyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638489082; x=1670025082;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5n6q2/Rbj2ukEZYtRo5At8pfzMCBHu1MQ/yClJAd4kY=;
  b=kSRNCG/AMNbno2FJeFDDjV2Nx0FMwAA7amiAo42j19Bi2YZLi0EM50Zm
   1gdYq57up1mVeTxejUu1Wc6XlgbSOR4Rnw/+UL9bRp9TZWpEFJazGA0jK
   1muKsahL0ha6hvanCWktoe5kgI4xXZTC6E+N0yXdgItY5FdVYGgA6SQwg
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Dec 2021 15:51:22 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 15:51:22 -0800
Received: from [10.46.160.247] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 2 Dec 2021
 15:51:20 -0800
Subject: Re: [PATCH] spmi: pmic-arb: Add support for PMIC v7
To:     Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>
References: <20211201072718.3969011-1-vkoul@kernel.org>
 <20211202230624.C05F3C00446@smtp.kernel.org>
From:   David Collins <quic_collinsd@quicinc.com>
Message-ID: <9161450a-40e0-c84f-f529-c903d6f1d722@quicinc.com>
Date:   Thu, 2 Dec 2021 15:51:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211202230624.C05F3C00446@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 3:06 PM, Stephen Boyd wrote:
> Quoting Vinod Koul (2021-11-30 23:27:18)
>> @@ -1169,8 +1270,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>>         pmic_arb = spmi_controller_get_drvdata(ctrl);
>>         pmic_arb->spmic = ctrl;
>>  
>> +       /*
>> +        * Don't use devm_ioremap_resource() as the resources are shared in
>> +        * PMIC v7 onwards, so causing failure when mapping
>> +        */
>>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
>> -       core = devm_ioremap_resource(&ctrl->dev, res);
>> +       core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
> 
> What does this mean? We have two nodes in DT that have the same reg
> properties? How does that work?

PMIC Arbiter v7 has two SPMI bus master interfaces.  These are used to
communicate with two sets of PMICs.  The SPMI interfaces operate
independently; however, they share some register address ranges (e.g.
one common one is used for APID->PPID mapping).  The most
straightforward way to handle this is to treat them as two independent
top-level DT devices.

In this case the "cnfg" address is used in the DT node name as that is
unique between the two instances.

Here are the DT nodes used downstream on a target with PMIC Arbiter v7:

spmi0_bus: qcom,spmi@c42d000 {
	compatible = "qcom,spmi-pmic-arb";
	reg = <0xc42d000 0x4000>,
	      <0xc400000 0x3000>,
	      <0xc500000 0x400000>,
	      <0xc440000 0x80000>,
	      <0xc4c0000 0x10000>;
	reg-names = "cnfg", "core", "chnls", "obsrvr", "intr";
	interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-names = "periph_irq";
	interrupt-controller;
	#interrupt-cells = <4>;
	#address-cells = <2>;
	#size-cells = <0>;
	cell-index = <0>;
	qcom,channel = <0>;
	qcom,ee = <0>;
	qcom,bus-id = <0>;
};

spmi1_bus: qcom,spmi@c432000 {
	compatible = "qcom,spmi-pmic-arb";
	reg = <0xc432000 0x4000>,
	      <0xc400000 0x3000>,
	      <0xc500000 0x400000>,
	      <0xc440000 0x80000>,
	      <0xc4d0000 0x10000>;
	reg-names = "cnfg", "core", "chnls", "obsrvr", "intr";
	interrupts-extended = <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
	interrupt-names = "periph_irq";
	interrupt-controller;
	#interrupt-cells = <4>;
	#address-cells = <2>;
	#size-cells = <0>;
	cell-index = <0>;
	qcom,channel = <0>;
	qcom,ee = <0>;
	qcom,bus-id = <1>;
};

Note the inclusion of a new DT property: "qcom,bus-id".  This was
defined in a DT binding patch that isn't present in Vinod's submission.
Here is its definition:

- qcom,bus-id : Specifies which SPMI bus instance to use.  This property
		is only applicable for PMIC arbiter version 7 and
		beyond.
		Support values: 0 = primary bus, 1 = secondary bus
		Assumed to be 0 if unspecified.

Take care,
David
