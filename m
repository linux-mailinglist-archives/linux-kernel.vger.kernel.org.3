Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEFF530A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiEWHqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiEWHqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:46:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5C118365;
        Mon, 23 May 2022 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291993; x=1684827993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GBEc9inSQIuJDxFn/5G8FQEzVuF5U+vRz+5PVwdFc7Q=;
  b=qBn5rGfK/B5Gv0mUDYoLKdCwv5gjIYSzfNzcP2suUNNLItQutEyG3/Tw
   OuWu4OYjjvFHzWE8qHuW6o7RpWkk+Nh+RNpsKifwzUq9tpPtxzbILaIQ1
   tXCkURFveD4qDIfTrRlkeQDQG5xz3MSm2Zij2PeXNw+Yje6tWb7OZh69j
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 May 2022 00:08:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:08:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 00:08:18 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 00:08:14 -0700
Date:   Mon, 23 May 2022 12:38:10 +0530
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
Message-ID: <20220523070810.GC15121@hu-pkondeti-hyd.qualcomm.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

<snip>

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

we have devm_of_phy_get() API that takes both device and device_node (could be
other than device-of_node). This API you have to use for the generic PHY, so
we can have a similar wrapper with devm_of_usb_get_phy_by_phandle() which
takes device and device_node as arguments.

> +static int dwc3_extract_num_phys(struct dwc3 *dwc)
> +{
> +	struct device_node	*ports, *port;
> +
> +	/* Find if any "multiport" child is present inside DWC3*/
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

Like I said above, devm_of_phy_get() is what needs to be used if we want to
re-use the same block of code that works for existing and multiport case.

Thanks,
Pavan
