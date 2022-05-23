Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E505307DC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbiEWDAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353367AbiEWDAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:00:34 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C989037BE3;
        Sun, 22 May 2022 20:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653274826; x=1684810826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J4ipSCcIrPYgrp2fk5CMEJgY8eNeZ15MGrQe9yURHYg=;
  b=qJdL2BM0JRHtMNxxN4loOZhGpnn350qyKH6CDwFZAZLwKp2x+Q5SRFaS
   ZpdKxTNaPXKS33ghJsMArSRjEyO3CSKViIwD2UKvurkTkLbQQSthq7tXA
   iCkgAfivvN7x36pmQrne0j++QLD7wS+Ec24V55xhBlyZk0uv55NXQGcw3
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 May 2022 20:00:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 19:59:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 19:59:54 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 19:59:51 -0700
Date:   Mon, 23 May 2022 08:29:47 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>
Subject: Re: [RFC 2/2] usb: dwc3: Refactor PHY logic to support Multiport
 Controller
Message-ID: <20220523025947.GB15121@hu-pkondeti-hyd.qualcomm.com>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
 <1652963695-10109-3-git-send-email-quic_harshq@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1652963695-10109-3-git-send-email-quic_harshq@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harsh,

I know that device tree bindings are not locked yet. So feel free to
address/respon to these comments after the bindings are locked.

On Thu, May 19, 2022 at 06:04:55PM +0530, Harsh Agarwal wrote:
> Currently the USB driver supports only single port controller
> which works with 2 PHYs at max ie HS and SS.
> 
> But some devices have "multiport" controller where a single
> controller supports multiple ports and each port have their own
> PHYs. Refactor PHY logic to support the same.
> 
> This implementation is compatible with existing glue drivers.
> 
> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c   | 259 +++++++++++++++++++++++++++++++++++-----------
>  drivers/usb/dwc3/core.h   |   8 +-
>  drivers/usb/dwc3/drd.c    |   8 +-
>  drivers/usb/dwc3/gadget.c |   4 +-
>  4 files changed, 209 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 2682469..8eb6b5b6 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -189,8 +189,8 @@ static void __dwc3_set_mode(struct work_struct *work)
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize host\n");
>  		} else {
> -			if (dwc->usb2_phy)
> -				otg_set_vbus(dwc->usb2_phy->otg, true);
> +			if (dwc->usb2_phy[0])
> +				otg_set_vbus(dwc->usb2_phy[0]->otg, true);
>  			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>  			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>  			if (dwc->dis_split_quirk) {
> @@ -204,9 +204,13 @@ static void __dwc3_set_mode(struct work_struct *work)
>  		dwc3_core_soft_reset(dwc);
>  
>  		dwc3_event_buffers_setup(dwc);
> -
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, false);
> +		/*
> +		 * Multiport Controller works only in host mode.
> +		 * There will only be one pair of HS and SS PHY for the controller operating in
> +		 * device mode.
> +		 */
> +		if (dwc->usb2_phy[0])
> +			otg_set_vbus(dwc->usb2_phy[0]->otg, false);

Fair enough. As per my understanding, the DWC3 controller can't keep one port in
device mode and another port in host mode since GCTL[12:13] bits which control
the port capability direction are controller specific but not port specific.
So it is okay to assume that the controller operating in device mode will only
have one USB2 PHY.

Your comment needs some correction though. We don't need both HS and SS PHY.
having just HS PHY is sufficient, in fact the HS PHY is also optional hence
the NULL check here.

>  		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>  		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>  

<snip>

> @@ -1250,52 +1267,166 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	return ret;
>  }
>  
> +static struct usb_phy *dwc3_core_get_phy_by_handle_with_node(struct device *dev,
> +	const char *phandle, u8 index, struct device_node *lookup_node)
> +{
> +	struct device_node *node;
> +	struct usb_phy	*phy;
> +
> +	node = of_parse_phandle(lookup_node, phandle, index);
> +	if (!node) {
> +		dev_err(dev, "failed to get %s phandle in %pOF node\n", phandle,
> +			dev->of_node);
> +		return ERR_PTR(-ENODEV);
> +	}
> +	phy = devm_usb_get_phy_by_node(dev, node, NULL);
> +	of_node_put(node);
> +	return phy;
> +}
> +
> +static int dwc3_extract_num_phys(struct dwc3 *dwc)
> +{
> +	struct device_node	*ports, *port;
> +
> +	/* Find if any "multiport" child is present inside DWC3*/

nit pick. space after DWC3.

> +	for_each_available_child_of_node(dwc->dev->of_node, ports) {
> +		if (!strcmp(ports->name, "multiport"))
> +			break;
> +	}
> +	if (!ports) {
> +		dwc->num_hsphy = 1;
> +		dwc->num_ssphy = 1;
> +	} else {
> +		for_each_available_child_of_node(ports, port) {
> +			dwc->num_hsphy += 1;
> +			dwc->num_ssphy += 1;
> +		}
> +	}

Would of_get_child_count() work?

I understand that we need to count the number of HS and SS PHY here for two
reasons here.

1. To allocate USB/Generic PHY structures inside dwc3.
2. We need to loop around the phy count to write into GUSB2PHYCFG/GUSB3PIPECTL
registers.

However, is it not possible that a port is HS only and not have any SS PHY
associated. Incrementing dwc->num_ssphy is not entirely correct for every
child. We need to increment dwc->num_ssphy only when get the correct phandle
for SS PHY.

It may be easier to allocate instances as per the child count but increment
dwc->num_ssphy as and when we process phys.

> +	dev_info(dwc->dev, "Num of HS and SS PHY are %u %u\n", dwc->num_hsphy, dwc->num_ssphy);
> +
> +	dwc->usb2_phy = devm_kzalloc(dwc->dev,
> +		sizeof(*dwc->usb2_phy) * dwc->num_hsphy, GFP_KERNEL);
> +	if (!dwc->usb2_phy)
> +		return -ENOMEM;
> +
> +	dwc->usb3_phy = devm_kzalloc(dwc->dev,
> +		sizeof(*dwc->usb3_phy) * dwc->num_ssphy, GFP_KERNEL);
> +	if (!dwc->usb3_phy)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

we have to allocate sufficient instances for generic PHY as well. I understand
that this is a RFC patch at this point but mentioning here so that you plan
accordingly.

> +
>  static int dwc3_core_get_phy(struct dwc3 *dwc)
>  {
>  	struct device		*dev = dwc->dev;
>  	struct device_node	*node = dev->of_node;
> -	int ret;
> +	struct device_node	*ports, *port;
>  
> -	if (node) {
> -		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
> -		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
> -	} else {
> -		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> -		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
> -	}
> +	int ret, i = 0;
>  
> -	if (IS_ERR(dwc->usb2_phy)) {
> -		ret = PTR_ERR(dwc->usb2_phy);
> -		if (ret == -ENXIO || ret == -ENODEV)
> -			dwc->usb2_phy = NULL;
> -		else
> -			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> +	ret = dwc3_extract_num_phys(dwc);
> +	if (ret) {
> +		dev_err(dwc->dev, "Unable to extract number of PHYs\n");
> +		return ret;
>  	}
>  
> -	if (IS_ERR(dwc->usb3_phy)) {
> -		ret = PTR_ERR(dwc->usb3_phy);
> -		if (ret == -ENXIO || ret == -ENODEV)
> -			dwc->usb3_phy = NULL;
> -		else
> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +	/* Find if any "multiport" child is present inside DWC3*/
> +	for_each_available_child_of_node(node, ports) {
> +		if (!strcmp(ports->name, "multiport"))
> +			break;
>  	}
>  
> -	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> -	if (IS_ERR(dwc->usb2_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb2_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb2_generic_phy = NULL;
> -		else
> -			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> -	}
> +	if (!ports) {
> +		if (node) {
> +			dwc->usb2_phy[0] = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
> +			dwc->usb3_phy[0] = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
> +		} else {
> +			dwc->usb2_phy[0] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +			dwc->usb3_phy[0] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
> +		}
>  
> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> -	if (IS_ERR(dwc->usb3_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb3_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb3_generic_phy = NULL;
> -		else
> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +		if (IS_ERR(dwc->usb2_phy[0])) {
> +			ret = PTR_ERR(dwc->usb2_phy[0]);
> +			if (ret == -ENXIO || ret == -ENODEV)
> +				dwc->usb2_phy[0] = NULL;
> +			else
> +				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> +		}
> +
> +		if (IS_ERR(dwc->usb3_phy[0])) {
> +			ret = PTR_ERR(dwc->usb3_phy[0]);
> +			if (ret == -ENXIO || ret == -ENODEV)
> +				dwc->usb3_phy[0] = NULL;
> +			else
> +				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +		}
> +
> +		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> +		if (IS_ERR(dwc->usb2_generic_phy)) {
> +			ret = PTR_ERR(dwc->usb2_generic_phy);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb2_generic_phy = NULL;
> +			else
> +				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> +		}
> +
> +		dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> +		if (IS_ERR(dwc->usb3_generic_phy)) {
> +			ret = PTR_ERR(dwc->usb3_generic_phy);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb3_generic_phy = NULL;
> +			else
> +				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +		}
> +

Would be good to write a common wrapper that gets the USB PHY phandles
and works for each mport (if present) or the fallback case. That wrapper
function should take required arguments and look for usb2/usb3 phy as well as
generic phy.

> +	} else {
> +		pr_info("Multiport node found\n");
> +		/* Iterate over each port of the MultiPort */
> +		for_each_available_child_of_node(ports, port) {
> +			dwc->usb2_phy[i] = dwc3_core_get_phy_by_handle_with_node(dev, "usb-phy",
> +											0, port);
> +			dwc->usb3_phy[i] = dwc3_core_get_phy_by_handle_with_node(dev, "usb-phy",
> +											1, port);
> +
> +			if (IS_ERR(dwc->usb2_phy[i])) {
> +				ret = PTR_ERR(dwc->usb2_phy[i]);
> +				pr_err("usb2_phy gone %d\n", ret);
> +				if (ret == -ENXIO || ret == -ENODEV)
> +					dwc->usb2_phy[i] = NULL;
> +				else
> +					return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> +			}
> +
> +			if (IS_ERR(dwc->usb3_phy[i])) {
> +				ret = PTR_ERR(dwc->usb3_phy[i]);
> +				pr_err("usb3_phy gone %d\n", ret);
> +				if (ret == -ENXIO || ret == -ENODEV)
> +					dwc->usb3_phy[i] = NULL;
> +				else
> +					return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +			}
> +			//TODO Write Generic PHY API
> +			dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> +			if (IS_ERR(dwc->usb2_generic_phy)) {
> +				ret = PTR_ERR(dwc->usb2_generic_phy);
> +				if (ret == -ENOSYS || ret == -ENODEV)
> +					dwc->usb2_generic_phy = NULL;
> +				else
> +					return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> +			}
> +
> +			//TODO Write Generic PHY API
> +			dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> +			if (IS_ERR(dwc->usb3_generic_phy)) {
> +				ret = PTR_ERR(dwc->usb3_generic_phy);
> +				if (ret == -ENOSYS || ret == -ENODEV)
> +					dwc->usb3_generic_phy = NULL;
> +				else
> +					return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +			}
> +			i++;
> +		}
>  	}
>  
>  	return 0;

<snip>

> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 81c486b..3175ed9 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1020,6 +1020,8 @@ struct dwc3_scratchpad_array {
>   * @usb_psy: pointer to power supply interface.
>   * @usb2_phy: pointer to USB2 PHY
>   * @usb3_phy: pointer to USB3 PHY
> + * @num_hsphy: Number of HS ports controlled by the core
> + * @num_dsphy: Number of SS ports controlled by the core
>   * @usb2_generic_phy: pointer to USB2 PHY
>   * @usb3_generic_phy: pointer to USB3 PHY
>   * @phys_ready: flag to indicate that PHYs are ready
> @@ -1147,8 +1149,10 @@ struct dwc3 {
>  
>  	struct reset_control	*reset;
>  
> -	struct usb_phy		*usb2_phy;
> -	struct usb_phy		*usb3_phy;
> +	struct usb_phy		**usb2_phy;
> +	struct usb_phy		**usb3_phy;
> +	u32			num_hsphy;
> +	u32			num_ssphy;
>  
>  	struct phy		*usb2_generic_phy;
>  	struct phy		*usb3_generic_phy;

The generic phy also needs to be supported/handled.

Thanks,
Pavan
