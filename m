Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F25310C6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiEWLx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiEWLx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:53:56 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057575002C;
        Mon, 23 May 2022 04:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653306835; x=1684842835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jqh+gNN3cVrlwteu1ArWPaiO3LBoV53Vtl35542DYEk=;
  b=RUqCdN+Ko940tN3IPIMEBFPEbI0viq/1PUVxY5eECPlyLPnoh1+Qlmez
   zyQDmi3KO5azmLSrajofeDeK1KJfV/pneTS30OG2l58VMVXws1Smil2IG
   eYRRWf8wy3MiPAgW00lQgghy/1ckV9fApzkOLFandV5mX+6rq1Vc3M8ej
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 May 2022 04:53:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 04:53:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 04:53:53 -0700
Received: from [10.216.62.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 04:53:49 -0700
Message-ID: <1356d6a4-92a6-80d6-727e-34eac131749e@quicinc.com>
Date:   Mon, 23 May 2022 17:23:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC 2/2] usb: dwc3: Refactor PHY logic to support Multiport
 Controller
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
 <1652963695-10109-3-git-send-email-quic_harshq@quicinc.com>
 <YohZyBw9aIs5i9wC@ripper>
From:   Harsh Agarwal <quic_harshq@quicinc.com>
In-Reply-To: <YohZyBw9aIs5i9wC@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/21/2022 8:47 AM, Bjorn Andersson wrote:
> On Thu 19 May 05:34 PDT 2022, Harsh Agarwal wrote:
>
>> Currently the USB driver supports only single port controller
>> which works with 2 PHYs at max ie HS and SS.
>>
>> But some devices have "multiport" controller where a single
>> controller supports multiple ports and each port have their own
>> PHYs. Refactor PHY logic to support the same.
>>
>> This implementation is compatible with existing glue drivers.
>>
> I would love to see this support land, for various different devices I
> have.
>
> But can you please explain how you tested this on an upstream kernel,
> given that all the Qualcomm phys are implemented in the generic phy
> framework?
>
>
> Also, when I spoke with Jack about this feature recently, he mentioned
> that you need to update GUSB2PHYCFG(i) and GUSB3PIPECTL(i) in e.g.
> dwc3_phy_config(). Is this series complete?

The idea here was to make the core driver compatible with multiport and
with the existing single port controller.
We wanted to get feedback on the current approach.
Ofcourse the code needs refactoring.

Yes for multiport we need to accomodate for GUSB2PHYCFG(i) and 
GUSB3PIPECTL(i).
Will add those changes as well.

>
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c   | 259 +++++++++++++++++++++++++++++++++++-----------
>>   drivers/usb/dwc3/core.h   |   8 +-
>>   drivers/usb/dwc3/drd.c    |   8 +-
>>   drivers/usb/dwc3/gadget.c |   4 +-
>>   4 files changed, 209 insertions(+), 70 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 2682469..8eb6b5b6 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -189,8 +189,8 @@ static void __dwc3_set_mode(struct work_struct *work)
>>   		if (ret) {
>>   			dev_err(dwc->dev, "failed to initialize host\n");
>>   		} else {
>> -			if (dwc->usb2_phy)
>> -				otg_set_vbus(dwc->usb2_phy->otg, true);
>> +			if (dwc->usb2_phy[0])
>> +				otg_set_vbus(dwc->usb2_phy[0]->otg, true);
>>   			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>   			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>>   			if (dwc->dis_split_quirk) {
>> @@ -204,9 +204,13 @@ static void __dwc3_set_mode(struct work_struct *work)
>>   		dwc3_core_soft_reset(dwc);
>>   
>>   		dwc3_event_buffers_setup(dwc);
>> -
>> -		if (dwc->usb2_phy)
>> -			otg_set_vbus(dwc->usb2_phy->otg, false);
>> +		/*
>> +		 * Multiport Controller works only in host mode.
>> +		 * There will only be one pair of HS and SS PHY for the controller operating in
>> +		 * device mode.
>> +		 */
> I think this comment applies to every single place where you operate on
> usb2_phy[0] only. But rather than telling the reader of the code that
> multiport is valid only for host-only setups, wouldn't it be useful to
> prevent the moving to device mode if multiple ports are specified?
>
> Or am I just not finding the place where you do this?
Yeah  maybe adding comment just in one place might be Odd.
Multiport are host mode only, so transitioning to device mode will lead 
to crash or will not be permitted.
We can add checks in dwc3_probe to bail out if it's multiport controller 
and dr_mode is device/OTG.
>
>> +		if (dwc->usb2_phy[0])
>> +			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
>>   		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>>   		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>>   
>> @@ -825,15 +829,20 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
>>   
>>   static void dwc3_core_exit(struct dwc3 *dwc)
>>   {
>> +	int i;
>>   	dwc3_event_buffers_cleanup(dwc);
>>   
>> -	usb_phy_shutdown(dwc->usb2_phy);
>> -	usb_phy_shutdown(dwc->usb3_phy);
>> +	for (i = 0; i < dwc->num_hsphy; i++)
>> +		usb_phy_shutdown(dwc->usb2_phy[i]);
>> +	for (i = 0; i < dwc->num_ssphy; i++)
>> +		usb_phy_shutdown(dwc->usb3_phy[i]);
>>   	phy_exit(dwc->usb2_generic_phy);
>>   	phy_exit(dwc->usb3_generic_phy);
>>   
>> -	usb_phy_set_suspend(dwc->usb2_phy, 1);
>> -	usb_phy_set_suspend(dwc->usb3_phy, 1);
>> +	for (i = 0; i < dwc->num_hsphy; i++)
>> +		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
>> +	for (i = 0; i < dwc->num_ssphy; i++)
>> +		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
>>   	phy_power_off(dwc->usb2_generic_phy);
>>   	phy_power_off(dwc->usb3_generic_phy);
>>   	dwc3_clk_disable(dwc);
>> @@ -1038,7 +1047,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   {
>>   	unsigned int		hw_mode;
>>   	u32			reg;
>> -	int			ret;
>> +	int			ret, i;
>>   
>>   	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>>   
>> @@ -1066,8 +1075,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   		dwc->phys_ready = true;
>>   	}
>>   
>> -	usb_phy_init(dwc->usb2_phy);
>> -	usb_phy_init(dwc->usb3_phy);
>> +	for (i = 0; i < dwc->num_hsphy; i++)
>> +		usb_phy_init(dwc->usb2_phy[i]);
>> +	for (i = 0; i < dwc->num_ssphy; i++)
>> +		usb_phy_init(dwc->usb3_phy[i]);
>>   	ret = phy_init(dwc->usb2_generic_phy);
>>   	if (ret < 0)
>>   		goto err0a;
>> @@ -1112,8 +1123,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   
>>   	dwc3_set_incr_burst_type(dwc);
>>   
>> -	usb_phy_set_suspend(dwc->usb2_phy, 0);
>> -	usb_phy_set_suspend(dwc->usb3_phy, 0);
>> +	for (i = 0; i < dwc->num_hsphy; i++)
>> +		usb_phy_set_suspend(dwc->usb2_phy[i], 0);
>> +	for (i = 0; i < dwc->num_ssphy; i++)
>> +		usb_phy_set_suspend(dwc->usb3_phy[i], 0);
>>   	ret = phy_power_on(dwc->usb2_generic_phy);
>>   	if (ret < 0)
>>   		goto err2;
>> @@ -1234,12 +1247,16 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   	phy_power_off(dwc->usb2_generic_phy);
>>   
>>   err2:
>> -	usb_phy_set_suspend(dwc->usb2_phy, 1);
>> -	usb_phy_set_suspend(dwc->usb3_phy, 1);
>> +	for (i = 0; i < dwc->num_hsphy; i++)
>> +		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
>> +	for (i = 0; i < dwc->num_ssphy; i++)
>> +		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
>>   
>>   err1:
>> -	usb_phy_shutdown(dwc->usb2_phy);
>> -	usb_phy_shutdown(dwc->usb3_phy);
>> +	for (i = 0; i < dwc->num_hsphy; i++)
>> +		usb_phy_shutdown(dwc->usb2_phy[i]);
>> +	for (i = 0; i < dwc->num_ssphy; i++)
>> +		usb_phy_shutdown(dwc->usb3_phy[i]);
>>   	phy_exit(dwc->usb2_generic_phy);
>>   	phy_exit(dwc->usb3_generic_phy);
>>   
>> @@ -1250,52 +1267,166 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   	return ret;
>>   }
>>   
>> +static struct usb_phy *dwc3_core_get_phy_by_handle_with_node(struct device *dev,
>> +	const char *phandle, u8 index, struct device_node *lookup_node)
>> +{
>> +	struct device_node *node;
>> +	struct usb_phy	*phy;
>> +
>> +	node = of_parse_phandle(lookup_node, phandle, index);
>> +	if (!node) {
>> +		dev_err(dev, "failed to get %s phandle in %pOF node\n", phandle,
>> +			dev->of_node);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +	phy = devm_usb_get_phy_by_node(dev, node, NULL);
>> +	of_node_put(node);
>> +	return phy;
>> +}
>> +
>> +static int dwc3_extract_num_phys(struct dwc3 *dwc)
> This doesn't extract the number, it allocates the usb2_phy and usb3_phy
> arrays.

I will push another change where for every "mport" node if the number of 
USB Phy phandle is 1 then increment only num_hsphy.
If it's 2 then increase both num_hsphy, num_ssphy .
Assumption : Every port will have a HSPHY phandle.

>
>> +{
>> +	struct device_node	*ports, *port;
>> +
>> +	/* Find if any "multiport" child is present inside DWC3*/
>> +	for_each_available_child_of_node(dwc->dev->of_node, ports) {
>> +		if (!strcmp(ports->name, "multiport"))
>> +			break;
> If you break you need of_node_put().
>
>> +	}
>> +	if (!ports) {
>> +		dwc->num_hsphy = 1;
>> +		dwc->num_ssphy = 1;
>> +	} else {
>> +		for_each_available_child_of_node(ports, port) {
>> +			dwc->num_hsphy += 1;
>> +			dwc->num_ssphy += 1;
>> +		}
>> +	}
>> +	dev_info(dwc->dev, "Num of HS and SS PHY are %u %u\n", dwc->num_hsphy, dwc->num_ssphy);
>> +
>> +	dwc->usb2_phy = devm_kzalloc(dwc->dev,
>> +		sizeof(*dwc->usb2_phy) * dwc->num_hsphy, GFP_KERNEL);
>> +	if (!dwc->usb2_phy)
>> +		return -ENOMEM;
>> +
>> +	dwc->usb3_phy = devm_kzalloc(dwc->dev,
>> +		sizeof(*dwc->usb3_phy) * dwc->num_ssphy, GFP_KERNEL);
>> +	if (!dwc->usb3_phy)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>>   static int dwc3_core_get_phy(struct dwc3 *dwc)
>>   {
>>   	struct device		*dev = dwc->dev;
>>   	struct device_node	*node = dev->of_node;
>> -	int ret;
>> +	struct device_node	*ports, *port;
>>   
>> -	if (node) {
>> -		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
>> -		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
>> -	} else {
>> -		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>> -		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
>> -	}
>> +	int ret, i = 0;
>>   
>> -	if (IS_ERR(dwc->usb2_phy)) {
>> -		ret = PTR_ERR(dwc->usb2_phy);
>> -		if (ret == -ENXIO || ret == -ENODEV)
>> -			dwc->usb2_phy = NULL;
>> -		else
>> -			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>> +	ret = dwc3_extract_num_phys(dwc);
>> +	if (ret) {
>> +		dev_err(dwc->dev, "Unable to extract number of PHYs\n");
>> +		return ret;
>>   	}
>>   
>> -	if (IS_ERR(dwc->usb3_phy)) {
>> -		ret = PTR_ERR(dwc->usb3_phy);
>> -		if (ret == -ENXIO || ret == -ENODEV)
>> -			dwc->usb3_phy = NULL;
>> -		else
>> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>> +	/* Find if any "multiport" child is present inside DWC3*/
>> +	for_each_available_child_of_node(node, ports) {
>> +		if (!strcmp(ports->name, "multiport"))
>> +			break;
>>   	}
>>   
>> -	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
>> -	if (IS_ERR(dwc->usb2_generic_phy)) {
>> -		ret = PTR_ERR(dwc->usb2_generic_phy);
>> -		if (ret == -ENOSYS || ret == -ENODEV)
>> -			dwc->usb2_generic_phy = NULL;
>> -		else
>> -			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>> -	}
>> +	if (!ports) {
>> +		if (node) {
>> +			dwc->usb2_phy[0] = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
>> +			dwc->usb3_phy[0] = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
>> +		} else {
>> +			dwc->usb2_phy[0] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
>> +			dwc->usb3_phy[0] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
>> +		}
>>   
>> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
>> -	if (IS_ERR(dwc->usb3_generic_phy)) {
>> -		ret = PTR_ERR(dwc->usb3_generic_phy);
>> -		if (ret == -ENOSYS || ret == -ENODEV)
>> -			dwc->usb3_generic_phy = NULL;
>> -		else
>> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>> +		if (IS_ERR(dwc->usb2_phy[0])) {
>> +			ret = PTR_ERR(dwc->usb2_phy[0]);
>> +			if (ret == -ENXIO || ret == -ENODEV)
>> +				dwc->usb2_phy[0] = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>> +		}
>> +
>> +		if (IS_ERR(dwc->usb3_phy[0])) {
>> +			ret = PTR_ERR(dwc->usb3_phy[0]);
>> +			if (ret == -ENXIO || ret == -ENODEV)
>> +				dwc->usb3_phy[0] = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>> +		}
>> +
>> +		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
>> +		if (IS_ERR(dwc->usb2_generic_phy)) {
>> +			ret = PTR_ERR(dwc->usb2_generic_phy);
>> +			if (ret == -ENOSYS || ret == -ENODEV)
>> +				dwc->usb2_generic_phy = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>> +		}
>> +
>> +		dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
>> +		if (IS_ERR(dwc->usb3_generic_phy)) {
>> +			ret = PTR_ERR(dwc->usb3_generic_phy);
>> +			if (ret == -ENOSYS || ret == -ENODEV)
>> +				dwc->usb3_generic_phy = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>> +		}
>> +
>> +	} else {
>> +		pr_info("Multiport node found\n");
> Please remove your debug prints.
Sure
>
>> +		/* Iterate over each port of the MultiPort */
>> +		for_each_available_child_of_node(ports, port) {
>> +			dwc->usb2_phy[i] = dwc3_core_get_phy_by_handle_with_node(dev, "usb-phy",
>> +											0, port);
>> +			dwc->usb3_phy[i] = dwc3_core_get_phy_by_handle_with_node(dev, "usb-phy",
>> +											1, port);
>> +
>> +			if (IS_ERR(dwc->usb2_phy[i])) {
>> +				ret = PTR_ERR(dwc->usb2_phy[i]);
>> +				pr_err("usb2_phy gone %d\n", ret);
>> +				if (ret == -ENXIO || ret == -ENODEV)
>> +					dwc->usb2_phy[i] = NULL;
>> +				else
>> +					return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>> +			}
>> +
>> +			if (IS_ERR(dwc->usb3_phy[i])) {
>> +				ret = PTR_ERR(dwc->usb3_phy[i]);
>> +				pr_err("usb3_phy gone %d\n", ret);
>> +				if (ret == -ENXIO || ret == -ENODEV)
>> +					dwc->usb3_phy[i] = NULL;
>> +				else
>> +					return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>> +			}
>> +			//TODO Write Generic PHY API
> Afaict this isn't a TODO, this is just broken right now?

I have tested these changes against "usb-phy" and not the generic PHY 
approach.
We have "devm_of_get_phy" which can be used for Generic PHY support.
Thanks Pavan for suggesting this.
I will check this on upstream device.

>
> Regards,
> Bjorn
>
>> +			dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
>> +			if (IS_ERR(dwc->usb2_generic_phy)) {
>> +				ret = PTR_ERR(dwc->usb2_generic_phy);
>> +				if (ret == -ENOSYS || ret == -ENODEV)
>> +					dwc->usb2_generic_phy = NULL;
>> +				else
>> +					return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>> +			}
>> +
>> +			//TODO Write Generic PHY API
>> +			dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
>> +			if (IS_ERR(dwc->usb3_generic_phy)) {
>> +				ret = PTR_ERR(dwc->usb3_generic_phy);
>> +				if (ret == -ENOSYS || ret == -ENODEV)
>> +					dwc->usb3_generic_phy = NULL;
>> +				else
>> +					return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>> +			}
>> +			i++;
>> +		}
>>   	}
>>   
>>   	return 0;
>> @@ -1310,8 +1441,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>   	case USB_DR_MODE_PERIPHERAL:
>>   		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>>   
>> -		if (dwc->usb2_phy)
>> -			otg_set_vbus(dwc->usb2_phy->otg, false);
>> +		if (dwc->usb2_phy[0])
>> +			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
>>   		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>>   		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>>   
>> @@ -1322,8 +1453,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>   	case USB_DR_MODE_HOST:
>>   		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
>>   
>> -		if (dwc->usb2_phy)
>> -			otg_set_vbus(dwc->usb2_phy->otg, true);
>> +		if (dwc->usb2_phy[0])
>> +			otg_set_vbus(dwc->usb2_phy[0]->otg, true);
>>   		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>   		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>>   
>> @@ -1673,7 +1804,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>   	struct resource		*res, dwc_res;
>>   	struct dwc3		*dwc;
>>   
>> -	int			ret;
>> +	int			ret, i;
>>   
>>   	void __iomem		*regs;
>>   
>> @@ -1838,13 +1969,17 @@ static int dwc3_probe(struct platform_device *pdev)
>>   	dwc3_debugfs_exit(dwc);
>>   	dwc3_event_buffers_cleanup(dwc);
>>   
>> -	usb_phy_shutdown(dwc->usb2_phy);
>> -	usb_phy_shutdown(dwc->usb3_phy);
>> +	for (i = 0; i < dwc->num_hsphy; i++)
>> +		usb_phy_shutdown(dwc->usb2_phy[i]);
>> +	for (i = 0; i < dwc->num_ssphy; i++)
>> +		usb_phy_shutdown(dwc->usb3_phy[i]);
>>   	phy_exit(dwc->usb2_generic_phy);
>>   	phy_exit(dwc->usb3_generic_phy);
>>   
>> -	usb_phy_set_suspend(dwc->usb2_phy, 1);
>> -	usb_phy_set_suspend(dwc->usb3_phy, 1);
>> +	for (i = 0; i < dwc->num_hsphy; i++)
>> +		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
>> +	for (i = 0; i < dwc->num_ssphy; i++)
>> +		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
>>   	phy_power_off(dwc->usb2_generic_phy);
>>   	phy_power_off(dwc->usb3_generic_phy);
>>   
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 81c486b..3175ed9 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1020,6 +1020,8 @@ struct dwc3_scratchpad_array {
>>    * @usb_psy: pointer to power supply interface.
>>    * @usb2_phy: pointer to USB2 PHY
>>    * @usb3_phy: pointer to USB3 PHY
>> + * @num_hsphy: Number of HS ports controlled by the core
>> + * @num_dsphy: Number of SS ports controlled by the core
>>    * @usb2_generic_phy: pointer to USB2 PHY
>>    * @usb3_generic_phy: pointer to USB3 PHY
>>    * @phys_ready: flag to indicate that PHYs are ready
>> @@ -1147,8 +1149,10 @@ struct dwc3 {
>>   
>>   	struct reset_control	*reset;
>>   
>> -	struct usb_phy		*usb2_phy;
>> -	struct usb_phy		*usb3_phy;
>> +	struct usb_phy		**usb2_phy;
>> +	struct usb_phy		**usb3_phy;
>> +	u32			num_hsphy;
>> +	u32			num_ssphy;
>>   
>>   	struct phy		*usb2_generic_phy;
>>   	struct phy		*usb3_generic_phy;
>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>> index 039bf24..7c9eba6 100644
>> --- a/drivers/usb/dwc3/drd.c
>> +++ b/drivers/usb/dwc3/drd.c
>> @@ -384,8 +384,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>>   		if (ret) {
>>   			dev_err(dwc->dev, "failed to initialize host\n");
>>   		} else {
>> -			if (dwc->usb2_phy)
>> -				otg_set_vbus(dwc->usb2_phy->otg, true);
>> +			if (dwc->usb2_phy[0])
>> +				otg_set_vbus(dwc->usb2_phy[0]->otg, true);
>>   			if (dwc->usb2_generic_phy)
>>   				phy_set_mode(dwc->usb2_generic_phy,
>>   					     PHY_MODE_USB_HOST);
>> @@ -398,8 +398,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>>   		dwc3_event_buffers_setup(dwc);
>>   		spin_unlock_irqrestore(&dwc->lock, flags);
>>   
>> -		if (dwc->usb2_phy)
>> -			otg_set_vbus(dwc->usb2_phy->otg, false);
>> +		if (dwc->usb2_phy[0])
>> +			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
>>   		if (dwc->usb2_generic_phy)
>>   			phy_set_mode(dwc->usb2_generic_phy,
>>   				     PHY_MODE_USB_DEVICE);
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 4f54f0e..c58a67c 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2870,8 +2870,8 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
>>   	union power_supply_propval	val = {0};
>>   	int				ret;
>>   
>> -	if (dwc->usb2_phy)
>> -		return usb_phy_set_power(dwc->usb2_phy, mA);
>> +	if (dwc->usb2_phy[0])
>> +		return usb_phy_set_power(dwc->usb2_phy[0], mA);
>>   
>>   	if (!dwc->usb_psy)
>>   		return -EOPNOTSUPP;
>> -- 
>> 2.7.4
>>
