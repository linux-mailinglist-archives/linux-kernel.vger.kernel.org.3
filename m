Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5FF468187
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354600AbhLDAs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:48:59 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:29965 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234629AbhLDAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638578734; x=1670114734;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3uDvDaKjfRB27QO9dwvq+A8APyKVmN41OQnpi07JGyE=;
  b=MeT2SFUz7VJR4kucpOFUFHfUZecuoKaBM8yKlPzLCV0t2Hoh+MgE7qY9
   NWAMKpJfLJwkPGBpJat4jr9TFmowy9eL0Y9kiQjedKVk0rRmrD7m2Q+ir
   p2YjuBKxNerYoYWSEg0TY2Hbg0WMUxcN7JyebptrsaR5RiteJjhK8hUIi
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Dec 2021 16:45:34 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 16:45:33 -0800
Received: from [10.46.160.247] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 3 Dec 2021
 16:45:31 -0800
Subject: Re: [PATCH] spmi: pmic-arb: Add support for PMIC v7
To:     Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
References: <20211201072718.3969011-1-vkoul@kernel.org>
 <20211202230624.C05F3C00446@smtp.kernel.org>
 <9161450a-40e0-c84f-f529-c903d6f1d722@quicinc.com>
 <20211203031323.211E5C00446@smtp.kernel.org>
From:   David Collins <quic_collinsd@quicinc.com>
Message-ID: <1fb0553b-eca5-a537-4dc3-77437feffc69@quicinc.com>
Date:   Fri, 3 Dec 2021 16:45:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211203031323.211E5C00446@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 7:13 PM, Stephen Boyd wrote:
> Quoting David Collins (2021-12-02 15:51:18)
>> On 12/2/21 3:06 PM, Stephen Boyd wrote:
>>> Quoting Vinod Koul (2021-11-30 23:27:18)
>>>> @@ -1169,8 +1270,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>>>>         pmic_arb = spmi_controller_get_drvdata(ctrl);
>>>>         pmic_arb->spmic = ctrl;
>>>>  
>>>> +       /*
>>>> +        * Don't use devm_ioremap_resource() as the resources are shared in
>>>> +        * PMIC v7 onwards, so causing failure when mapping
>>>> +        */
>>>>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
>>>> -       core = devm_ioremap_resource(&ctrl->dev, res);
>>>> +       core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
>>>
>>> What does this mean? We have two nodes in DT that have the same reg
>>> properties? How does that work?
>>
>> PMIC Arbiter v7 has two SPMI bus master interfaces.  These are used to
>> communicate with two sets of PMICs.  The SPMI interfaces operate
>> independently; however, they share some register address ranges (e.g.
>> one common one is used for APID->PPID mapping).
> 
> It looks like the two SPMI busses share the mapping table which is OK
> because it's read-only but then the 'chnls' and 'obsrvr' regions are
> also shared. There must be some global lock in place to make sure the
> two controllers aren't writing to the same register in there? Or are we
> saved because the mapping table splits the regions between the two
> busses?

No global lock is present or needed.  The 'chnls' and 'obsvr' region
registers are indexed by APID.  Both SPMI buses use the same APID
numbering space.  However, that numbering space is segmented, e.g. APID
0-767 corresponds to SPMI0 bus and APID 768-1023 corresponds to SPMI1
bus.  Therefore, there are no circumstances where both buses could be
writing to the same set of registers.

The base and size of these segments is read from registers based upon
the "qcom,bus-id" property values:

>>>> +	if (hw_ver >= PMIC_ARB_VERSION_V7_MIN) {
>>>> +		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V7;
>>>> +
>>>> +		of_property_read_u32(pdev->dev.of_node, "qcom,bus-id", &pmic_arb->bus_instance);
>>>> +		if (pmic_arb->bus_instance > 1) {
>>>> +			err = -EINVAL;
>>>> +			dev_err(&ctrl->dev, "invalid bus instance: %d\n", pmic_arb->bus_instance);
>>>> +			goto err_put_ctrl;
>>>> +		}
>>>> +
>>>> +		if (pmic_arb->bus_instance == 0) {
>>>> +			pmic_arb->base_apid = 0;
>>>> +			pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES) &
>>>> +							     PMIC_ARB_FEATURES_PERIPH_MASK;
>>>> +		} else {
>>>> +			pmic_arb->base_apid = readl_relaxed(core + PMIC_ARB_FEATURES) &
>>>> +							     PMIC_ARB_FEATURES_PERIPH_MASK;
>>>> +			pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES1) &
>>>> +							     PMIC_ARB_FEATURES_PERIPH_MASK;
>>>> +		}
>>>> +
>>>> +	}

Note that the specific register(s) that need to be read differ based on
the bus instance (0 or 1).  The 'base_apid' and 'apid_count' elements
are then used in various callback functions when indexing into regions
with a common numbering space.


>> The most
>> straightforward way to handle this is to treat them as two independent
>> top-level DT devices.
>>
>> In this case the "cnfg" address is used in the DT node name as that is
>> unique between the two instances.
> 
> Nice trick. The reg properties aren't supposed to change order though so
> we shouldn't do that.

Why does the ordering of "reg" entries matter?  "reg-names" defines what
each of the entries corresponds to (independent of the ordering).  Is
there a policy/requirement specified somewhere about the ordering of
"reg" entries when "reg-names" is a required property?


>> Here are the DT nodes used downstream on a target with PMIC Arbiter v7:
>>
>> spmi0_bus: qcom,spmi@c42d000 {
>>         compatible = "qcom,spmi-pmic-arb";
>>         reg = <0xc42d000 0x4000>,
>>               <0xc400000 0x3000>,
>>               <0xc500000 0x400000>,
>>               <0xc440000 0x80000>,
>>               <0xc4c0000 0x10000>;
>>         reg-names = "cnfg", "core", "chnls", "obsrvr", "intr";
>>         interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
>>         interrupt-names = "periph_irq";
>>         interrupt-controller;
>>         #interrupt-cells = <4>;
>>         #address-cells = <2>;
>>         #size-cells = <0>;
>>         cell-index = <0>;
>>         qcom,channel = <0>;
>>         qcom,ee = <0>;
>>         qcom,bus-id = <0>;
>> };
>>
>> spmi1_bus: qcom,spmi@c432000 {
>>         compatible = "qcom,spmi-pmic-arb";
>>         reg = <0xc432000 0x4000>,
>>               <0xc400000 0x3000>,
>>               <0xc500000 0x400000>,
>>               <0xc440000 0x80000>,
>>               <0xc4d0000 0x10000>;
>>         reg-names = "cnfg", "core", "chnls", "obsrvr", "intr";
>>         interrupts-extended = <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
>>         interrupt-names = "periph_irq";
>>         interrupt-controller;
>>         #interrupt-cells = <4>;
>>         #address-cells = <2>;
>>         #size-cells = <0>;
>>         cell-index = <0>;
>>         qcom,channel = <0>;
>>         qcom,ee = <0>;
>>         qcom,bus-id = <1>;
>> };
> 
> It feels like we should make a parent node that holds the core, chnls,
> obsrvr reg properties with a new compatible string and then have two
> child nodes for each bus. Then the various PMICs can hang off those two
> different bus nodes. Of course, it needs DT review to make sure nothing
> else goes wrong.

We considered this alternative DT layout when implementing PMIC arbiter
v7 support downstream.  The benefit is allowing common register ranges
to be specified once instead of in both SPMI bus nodes.  However, this
approach has several downsides.

It results in substantially more complex device tree binding
documentation that requires a different layout for SPMI buses for PMIC
arbiter v7 (and above) vs early versions even though support can be
provided with only a minimal modification (i.e. "qcom,bus-id").
Complexity is also increased inside of the spmi-pmic-arb driver.  There,
special data structures and logic would be needed to handle the shared
vs independent register addresses and data.

The SPMI framework currently uses a one-to-one mapping between SPMI
buses and struct device pointers.  This would not work if the new
top-level node represents the true struct device and the per-bus
subnodes are not true devices.  Also, platform_get_resource_byname()
(used in the spmi-pmic-arb probe function) needs a struct
platform_device pointer to read address ranges using "reg" +
"reg-names".  That wouldn't work for the subnodes.

I suppose that "compatible" could be specified for the top-level node
and the per bus subnodes so that all three get probed as struct devices.
 However, that makes things even more complicated and convoluted in the
driver (and DT).

I would prefer to stay with the approach of the two bus instances being
specified independently in DT.

Note that the clk-imx8qxp-lpcg driver has a similar situation where
multiple drivers need to map addresses in the same region.  Commit [1]
documents the requirement.  The details of the problem where
devm_platform_ioremap_resource() cannot be used in place of
devm_ioremap() were discussed in this thread [2].


>> Note the inclusion of a new DT property: "qcom,bus-id".  This was
>> defined in a DT binding patch that isn't present in Vinod's submission.
>> Here is its definition:
>>
>> - qcom,bus-id : Specifies which SPMI bus instance to use.  This property
>>                 is only applicable for PMIC arbiter version 7 and
>>                 beyond.
>>                 Support values: 0 = primary bus, 1 = secondary bus
>>                 Assumed to be 0 if unspecified.
>>
> 
> How is it used in the driver? Does something care what is primary and
> what is secondary?

See above for the code snippet where "qcom,bus-id" is read.

Thanks,
David

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=249fce6f3ab0dbd98caa9bc8ea4b50fa709e786a
[2]: https://lkml.org/lkml/2019/12/4/260
