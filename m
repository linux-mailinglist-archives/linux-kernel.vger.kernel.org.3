Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC46B5A5ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiH3EcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3EcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:32:16 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA79E0F6;
        Mon, 29 Aug 2022 21:32:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27U4VvBY037487;
        Mon, 29 Aug 2022 23:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661833917;
        bh=9j/HRj1Q1IgYRTogG7mi/ufdMf2truZfzuvnA3Ze6Ag=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=SyzpHtcnyhOwqdeML/0eju1hkB+g8+LHE3jZBLBKu+GPBJSUa+k8wWlzJX0wqs//T
         YbDPKb1lkuRoKZfoX9xGbCVHjmfg7sYzxUdrRCSHwSYNfGKMy2FQw6p7+YZ5xCneBD
         5MK7L0tauBuaK847vrKLo+cpYIRGuteFGTHc/xsc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27U4VvN2108195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 23:31:57 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 29
 Aug 2022 23:31:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 29 Aug 2022 23:31:56 -0500
Received: from [10.24.69.241] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27U4Vqpj036934;
        Mon, 29 Aug 2022 23:31:53 -0500
Message-ID: <533a4186-62b1-ce7b-e097-9fb04be8f018@ti.com>
Date:   Tue, 30 Aug 2022 10:01:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
CC:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 2/2] phy: ti: gmii-sel: Add support for CPSW5G GMII SEL
 in J7200
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>
References: <20220822065631.27933-1-s-vadapalli@ti.com>
 <20220822065631.27933-3-s-vadapalli@ti.com>
 <655c39a3-cf5f-6dd7-3c1a-61ebeae915bd@kernel.org>
 <7dd27795-11d0-3147-ed86-959ff3e89df4@ti.com>
 <8ef8b2f8-a1c1-b277-22b1-6e951e8dfc72@kernel.org>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <8ef8b2f8-a1c1-b277-22b1-6e951e8dfc72@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roger,

On 29/08/22 18:13, Roger Quadros wrote:
> Siddharth,
> 
> On 29/08/2022 07:53, Siddharth Vadapalli wrote:
>> Hello Roger,
>>
>> On 25/08/22 13:11, Roger Quadros wrote:
>>> Hi Siddharth,
>>>
>>> On 22/08/2022 09:56, Siddharth Vadapalli wrote:
>>>> Each of the CPSW5G ports in J7200 support additional modes like QSGMII.
>>>> Add a new compatible for J7200 to support the additional modes.
>>>>
>>>> In TI's J7200, each of the CPSW5G ethernet interfaces can act as a
>>>> QSGMII or QSGMII-SUB port. The QSGMII interface is responsible for
>>>> performing auto-negotiation between the MAC and the PHY while the rest of
>>>> the interfaces are designated as QSGMII-SUB interfaces, indicating that
>>>> they will not be taking part in the auto-negotiation process.
>>>>
>>>> To indicate the interface which will serve as the main QSGMII interface,
>>>> add a property "ti,qsgmii-main-ports", whose value indicates the
>>>> port number of the interface which shall serve as the main QSGMII
>>>> interface. The rest of the interfaces are then assigned QSGMII-SUB mode by
>>>> default.
>>>
>>> Can you please describe here why you are using "ti,qsgmii-main-ports" instead
>>> of "ti,qsgmii-main-port" as there can be only one main port per PHY instance?
>>
>> Thank you for reviewing the patch. I am using "ports" instead of "port"
>> because I plan to add support for CPSW9G on TI's J721e device in the
>> future patches. CPSW9G (8 external ports) supports up to two QSGMII main
>> ports. For CPSW9G, by specifying the two main ports in the device tree,
>> it is possible to configure the CTRLMMR_ENETx_CTRL register for each of
>> the 8 ports, with the two QSGMII main ports being configured as main
>> ports in the CTRLMMR_ENETx_CTRL register and the rest of them being
>> configured as sub ports. Since I will be using the same property
>> "ti,qsgmii-main-ports" for CPSW9G as well, the property will be an array
>> of 2 values for CPSW9G. Therefore, I am using "ports" instead of "port".
>> Please let me know if this is fine.
>>
> 
> OK. Please mention this in commit message.

I will mention that the property ti,qsgmii-main-ports is used to
configure the CTRLMMR_ENETx_CTRL register and that it is possible
depending on the device for there to be more than one main port which is
why the property is an array of values.

Would it be sufficient to mention the above in the commit message?
Please let me know.

> 
>>>
>>>>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> ---
>>>>  drivers/phy/ti/phy-gmii-sel.c | 40 ++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 37 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
>>>> index d0ab69750c6b..270083606b14 100644
>>>> --- a/drivers/phy/ti/phy-gmii-sel.c
>>>> +++ b/drivers/phy/ti/phy-gmii-sel.c
>>>> @@ -22,6 +22,12 @@
>>>>  #define AM33XX_GMII_SEL_MODE_RMII	1
>>>>  #define AM33XX_GMII_SEL_MODE_RGMII	2
>>>>  
>>>> +/* J72xx SoC specific definitions for the CONTROL port */
>>>> +#define J72XX_GMII_SEL_MODE_QSGMII	4
>>>> +#define J72XX_GMII_SEL_MODE_QSGMII_SUB	6
>>>> +
>>>> +#define PHY_GMII_PORT(n)	BIT((n) - 1)
>>>> +
>>>>  enum {
>>>>  	PHY_GMII_SEL_PORT_MODE = 0,
>>>>  	PHY_GMII_SEL_RGMII_ID_MODE,
>>>> @@ -43,6 +49,7 @@ struct phy_gmii_sel_soc_data {
>>>>  	u32 features;
>>>>  	const struct reg_field (*regfields)[PHY_GMII_SEL_LAST];
>>>>  	bool use_of_data;
>>>> +	u64 extra_modes;
>>>>  };
>>>>  
>>>>  struct phy_gmii_sel_priv {
>>>> @@ -53,6 +60,7 @@ struct phy_gmii_sel_priv {
>>>>  	struct phy_gmii_sel_phy_priv *if_phys;
>>>>  	u32 num_ports;
>>>>  	u32 reg_offset;
>>>> +	u32 qsgmii_main_ports;
>>>>  };
>>>>  
>>>>  static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
>>>> @@ -88,10 +96,17 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
>>>>  		gmii_sel_mode = AM33XX_GMII_SEL_MODE_MII;
>>>>  		break;
>>>>  
>>>> +	case PHY_INTERFACE_MODE_QSGMII:
>>>> +		if (!(soc_data->extra_modes & BIT(PHY_INTERFACE_MODE_QSGMII)))
>>>> +			goto unsupported;
>>>> +		if (if_phy->priv->qsgmii_main_ports & BIT(if_phy->id - 1))
>>>> +			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII;
>>>> +		else
>>>> +			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII_SUB;
>>>> +		break;
>>>> +
>>>>  	default:
>>>> -		dev_warn(dev, "port%u: unsupported mode: \"%s\"\n",
>>>> -			 if_phy->id, phy_modes(submode));
>>>> -		return -EINVAL;
>>>> +		goto unsupported;
>>>>  	}
>>>>  
>>>>  	if_phy->phy_if_mode = submode;
>>>> @@ -123,6 +138,11 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
>>>>  	}
>>>>  
>>>>  	return 0;
>>>> +
>>>> +unsupported:
>>>> +	dev_warn(dev, "port%u: unsupported mode: \"%s\"\n",
>>>> +		 if_phy->id, phy_modes(submode));
>>>> +	return -EINVAL;
>>>>  }
>>>>  
>>>>  static const
>>>> @@ -188,6 +208,13 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 = {
>>>>  	.regfields = phy_gmii_sel_fields_am654,
>>>>  };
>>>>  
>>>> +static const
>>>> +struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
>>>> +	.use_of_data = true,
>>>> +	.regfields = phy_gmii_sel_fields_am654,
>>>> +	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
>>>> +};
>>>> +
>>>>  static const struct of_device_id phy_gmii_sel_id_table[] = {
>>>>  	{
>>>>  		.compatible	= "ti,am3352-phy-gmii-sel",
>>>> @@ -209,6 +236,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
>>>>  		.compatible	= "ti,am654-phy-gmii-sel",
>>>>  		.data		= &phy_gmii_sel_soc_am654,
>>>>  	},
>>>> +	{
>>>> +		.compatible	= "ti,j7200-cpsw5g-phy-gmii-sel",
>>>> +		.data		= &phy_gmii_sel_cpsw5g_soc_j7200,
>>>> +	},
>>>>  	{}
>>>>  };
>>>>  MODULE_DEVICE_TABLE(of, phy_gmii_sel_id_table);
>>>> @@ -350,6 +381,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>>>>  	struct device_node *node = dev->of_node;
>>>>  	const struct of_device_id *of_id;
>>>>  	struct phy_gmii_sel_priv *priv;
>>>> +	u32 main_ports = 1;
>>>>  	int ret;
>>>>  
>>>>  	of_id = of_match_node(phy_gmii_sel_id_table, pdev->dev.of_node);
>>>> @@ -363,6 +395,8 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>>>>  	priv->dev = &pdev->dev;
>>>>  	priv->soc_data = of_id->data;
>>>>  	priv->num_ports = priv->soc_data->num_ports;
>>>> +	of_property_read_u32_array(node, "ti,qsgmii-main-ports", &main_ports, 1);
>>>
>>> of_property_read_u32_array can return error and you are not doing any sanity checks.
>>> This should fail if "ti,qsgmii-main-ports" is not present or out of bounds if port mode is QSGMII.
>>
>> In the scenario that the user doesn't want to use QSGMII mode, the
>> property will not be mentioned in the device tree. In the phy-gmii-sel
>> driver, the call to of_property_read_u32_array() will return an error
>> since the optional ti,qsgmii-main-ports property doesn't exist in the
>> device tree. However, the main_ports variable has already been
>> initialized to 1 and in case of Non-QSGMII modes, the main_ports
>> variable will not even be used. If the mode is QSGMII and the user
>> forgets to mention the ti,qsgmii-main-ports property in the device tree,
>> then the default value of 1 is used.
>>
>> Since the of_property_read_u32_array() function doesn't overwrite
>> main_ports variable if the ti,qsgmii-main-ports property is not present
>> in the device tree, the value of main_ports will continue to remain 1
>> even in the case where of_property_read_u32_array() errors out.
>>
>> In the other scenario where the user mentions a value that is smaller or
>> greater than the allowed value for "ti,qsgmii-main-ports" property, I
>> have added bindings to ensure that make dtbs_check fails. This will
>> enforce the bounds on the property.
> 
> This I'm not sure about. dtbs_check is not always run at build time and we cannot
> depend on that.

If that's the case, then I will enforce a check in the phy-gmii-sel
driver as well. Thank you for letting me know.

> 
>>
>> For the above reasons, I think that the return value of the call to
>> of_property_read_u32_array() can be safely ignored, and the value of
>> main_ports doesn't need to be validated within the driver as it is being
>> enforced in the bindings.
>>
>>>
>>> How is this going to scale if you are going to have multiple main ports?
>>> Let's say you increase it to 2 in the future. won't this break with -EOVERFLOW for older
>>> DTs where you had only 1 u32.
>>
>> For multiple main ports (like CPSW9G for example), I had planned to add
>> an IF-ELSE condition to check the compatible (I plan to add a new
>> compatible for J721e which uses CPSW9G) and then call
>> of_property_read_u32_array() with either 1 or 2 values to be read based
>> on the compatible.
> 
> In that case please use of_property_read_u32 for the case where you know only there is only 1 value.

Yes I will do that. Thank you for reviewing the patch.

Regards,
Siddharth.
