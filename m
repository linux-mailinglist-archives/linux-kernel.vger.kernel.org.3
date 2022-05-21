Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5EE52F7EB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiEUDPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiEUDPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:15:14 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFE515F6C6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:15:12 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id bm18-20020a056820189200b0035f7e56a3dfso1813681oob.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNN8TxLrp9oa2r9tlbjnmFP7nBbkS+PNqWrKGzIa8k8=;
        b=n1JG0kJlIyerxwlrlhyJfPCcRmsyIjBSXbWhbG/Tr5ilnfqW29ENeLGAyUnF3DG8F3
         wH7P1bqYN/jebiGreGaLEWjmPWBG32KoQ3rpg7mvBa7iYe06NQqirVc6wd6oqROqF6oy
         dbqYqJRQyJCzql8ByuM4g469/GV9QZuVUV2XATyNL/r4KIZGMcgKyFIWOfMl/huChMRp
         aFcMs3e1+X9MrDWB6N+l/APNGcpqZCm9oZWb/2GcxY+MUgchgB7ZgMawA5hwqVgx08ai
         1mUBjzmonOE6jA9FeXsBd/NReXvOD+OQ17S3Bxd+0Ekx1tpjcoeQWoXQE+ZoEUSxKUOP
         hluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNN8TxLrp9oa2r9tlbjnmFP7nBbkS+PNqWrKGzIa8k8=;
        b=x+qsLTa58g4lhBT2EnwSn5EuU6jUnJfa4rN0LhfYkq2UCUrn3Q1abAeh0A0ncps+iP
         73xTg9ot0wQ10v9+si1Tfd+KpO3DQ2yaJ+gtLldBEKyGdr6/qW8QKbRA/uMOhqF4TfTZ
         WkYIMUItEzspuby0VgKQxdKKq4VTUzLCdMJZMfN0WCS8rbUiVZmUpwndcCoA1/LdZZV1
         kEvCDTXhFTiqP+g86UwF9S6CCcdQDWPzeXgUWId8vaXshoH/JM0f211RDR66Vv31R9B0
         3a0AKb3uuFq0FbZHrwLBG2WPjvpf4QS08rV19fnMuCWFTIYL6HdJ3cZHdFE2vZzA9NGB
         TuZw==
X-Gm-Message-State: AOAM531d9VGRMmsdwk7bIYZSAgz6GUNbU7DtQtk1pEpmj/g5XDDb0IHj
        iRXFy9XbG/EIyLyBesH29dcMig==
X-Google-Smtp-Source: ABdhPJy6dHniM2CAewv124fR4BSAaV6lIrEzzZlXmrfu7PuNUW0o9ik9hvqjCoj7XF6X8+M5GuIeZg==
X-Received: by 2002:a4a:968e:0:b0:324:22c6:1a31 with SMTP id s14-20020a4a968e000000b0032422c61a31mr5373097ooi.93.1653102911186;
        Fri, 20 May 2022 20:15:11 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o66-20020acaf045000000b00325cda1ff8dsm1824907oih.12.2022.05.20.20.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 20:15:10 -0700 (PDT)
Date:   Fri, 20 May 2022 20:17:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com
Subject: Re: [RFC 2/2] usb: dwc3: Refactor PHY logic to support Multiport
 Controller
Message-ID: <YohZyBw9aIs5i9wC@ripper>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
 <1652963695-10109-3-git-send-email-quic_harshq@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652963695-10109-3-git-send-email-quic_harshq@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 May 05:34 PDT 2022, Harsh Agarwal wrote:

> Currently the USB driver supports only single port controller
> which works with 2 PHYs at max ie HS and SS.
> 
> But some devices have "multiport" controller where a single
> controller supports multiple ports and each port have their own
> PHYs. Refactor PHY logic to support the same.
> 
> This implementation is compatible with existing glue drivers.
> 

I would love to see this support land, for various different devices I
have.

But can you please explain how you tested this on an upstream kernel,
given that all the Qualcomm phys are implemented in the generic phy
framework?


Also, when I spoke with Jack about this feature recently, he mentioned
that you need to update GUSB2PHYCFG(i) and GUSB3PIPECTL(i) in e.g.
dwc3_phy_config(). Is this series complete?

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

I think this comment applies to every single place where you operate on
usb2_phy[0] only. But rather than telling the reader of the code that
multiport is valid only for host-only setups, wouldn't it be useful to
prevent the moving to device mode if multiple ports are specified?

Or am I just not finding the place where you do this?

> +		if (dwc->usb2_phy[0])
> +			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
>  		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>  		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>  
> @@ -825,15 +829,20 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
>  
>  static void dwc3_core_exit(struct dwc3 *dwc)
>  {
> +	int i;
>  	dwc3_event_buffers_cleanup(dwc);
>  
> -	usb_phy_shutdown(dwc->usb2_phy);
> -	usb_phy_shutdown(dwc->usb3_phy);
> +	for (i = 0; i < dwc->num_hsphy; i++)
> +		usb_phy_shutdown(dwc->usb2_phy[i]);
> +	for (i = 0; i < dwc->num_ssphy; i++)
> +		usb_phy_shutdown(dwc->usb3_phy[i]);
>  	phy_exit(dwc->usb2_generic_phy);
>  	phy_exit(dwc->usb3_generic_phy);
>  
> -	usb_phy_set_suspend(dwc->usb2_phy, 1);
> -	usb_phy_set_suspend(dwc->usb3_phy, 1);
> +	for (i = 0; i < dwc->num_hsphy; i++)
> +		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
> +	for (i = 0; i < dwc->num_ssphy; i++)
> +		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
>  	phy_power_off(dwc->usb2_generic_phy);
>  	phy_power_off(dwc->usb3_generic_phy);
>  	dwc3_clk_disable(dwc);
> @@ -1038,7 +1047,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  {
>  	unsigned int		hw_mode;
>  	u32			reg;
> -	int			ret;
> +	int			ret, i;
>  
>  	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>  
> @@ -1066,8 +1075,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  		dwc->phys_ready = true;
>  	}
>  
> -	usb_phy_init(dwc->usb2_phy);
> -	usb_phy_init(dwc->usb3_phy);
> +	for (i = 0; i < dwc->num_hsphy; i++)
> +		usb_phy_init(dwc->usb2_phy[i]);
> +	for (i = 0; i < dwc->num_ssphy; i++)
> +		usb_phy_init(dwc->usb3_phy[i]);
>  	ret = phy_init(dwc->usb2_generic_phy);
>  	if (ret < 0)
>  		goto err0a;
> @@ -1112,8 +1123,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  
>  	dwc3_set_incr_burst_type(dwc);
>  
> -	usb_phy_set_suspend(dwc->usb2_phy, 0);
> -	usb_phy_set_suspend(dwc->usb3_phy, 0);
> +	for (i = 0; i < dwc->num_hsphy; i++)
> +		usb_phy_set_suspend(dwc->usb2_phy[i], 0);
> +	for (i = 0; i < dwc->num_ssphy; i++)
> +		usb_phy_set_suspend(dwc->usb3_phy[i], 0);
>  	ret = phy_power_on(dwc->usb2_generic_phy);
>  	if (ret < 0)
>  		goto err2;
> @@ -1234,12 +1247,16 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	phy_power_off(dwc->usb2_generic_phy);
>  
>  err2:
> -	usb_phy_set_suspend(dwc->usb2_phy, 1);
> -	usb_phy_set_suspend(dwc->usb3_phy, 1);
> +	for (i = 0; i < dwc->num_hsphy; i++)
> +		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
> +	for (i = 0; i < dwc->num_ssphy; i++)
> +		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
>  
>  err1:
> -	usb_phy_shutdown(dwc->usb2_phy);
> -	usb_phy_shutdown(dwc->usb3_phy);
> +	for (i = 0; i < dwc->num_hsphy; i++)
> +		usb_phy_shutdown(dwc->usb2_phy[i]);
> +	for (i = 0; i < dwc->num_ssphy; i++)
> +		usb_phy_shutdown(dwc->usb3_phy[i]);
>  	phy_exit(dwc->usb2_generic_phy);
>  	phy_exit(dwc->usb3_generic_phy);
>  
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

This doesn't extract the number, it allocates the usb2_phy and usb3_phy
arrays.

> +{
> +	struct device_node	*ports, *port;
> +
> +	/* Find if any "multiport" child is present inside DWC3*/
> +	for_each_available_child_of_node(dwc->dev->of_node, ports) {
> +		if (!strcmp(ports->name, "multiport"))
> +			break;

If you break you need of_node_put().

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
> +	} else {
> +		pr_info("Multiport node found\n");

Please remove your debug prints.

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

Afaict this isn't a TODO, this is just broken right now?

Regards,
Bjorn

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
> @@ -1310,8 +1441,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  	case USB_DR_MODE_PERIPHERAL:
>  		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, false);
> +		if (dwc->usb2_phy[0])
> +			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
>  		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>  		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>  
> @@ -1322,8 +1453,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  	case USB_DR_MODE_HOST:
>  		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
>  
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, true);
> +		if (dwc->usb2_phy[0])
> +			otg_set_vbus(dwc->usb2_phy[0]->otg, true);
>  		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>  		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>  
> @@ -1673,7 +1804,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  	struct resource		*res, dwc_res;
>  	struct dwc3		*dwc;
>  
> -	int			ret;
> +	int			ret, i;
>  
>  	void __iomem		*regs;
>  
> @@ -1838,13 +1969,17 @@ static int dwc3_probe(struct platform_device *pdev)
>  	dwc3_debugfs_exit(dwc);
>  	dwc3_event_buffers_cleanup(dwc);
>  
> -	usb_phy_shutdown(dwc->usb2_phy);
> -	usb_phy_shutdown(dwc->usb3_phy);
> +	for (i = 0; i < dwc->num_hsphy; i++)
> +		usb_phy_shutdown(dwc->usb2_phy[i]);
> +	for (i = 0; i < dwc->num_ssphy; i++)
> +		usb_phy_shutdown(dwc->usb3_phy[i]);
>  	phy_exit(dwc->usb2_generic_phy);
>  	phy_exit(dwc->usb3_generic_phy);
>  
> -	usb_phy_set_suspend(dwc->usb2_phy, 1);
> -	usb_phy_set_suspend(dwc->usb3_phy, 1);
> +	for (i = 0; i < dwc->num_hsphy; i++)
> +		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
> +	for (i = 0; i < dwc->num_ssphy; i++)
> +		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
>  	phy_power_off(dwc->usb2_generic_phy);
>  	phy_power_off(dwc->usb3_generic_phy);
>  
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
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 039bf24..7c9eba6 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -384,8 +384,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize host\n");
>  		} else {
> -			if (dwc->usb2_phy)
> -				otg_set_vbus(dwc->usb2_phy->otg, true);
> +			if (dwc->usb2_phy[0])
> +				otg_set_vbus(dwc->usb2_phy[0]->otg, true);
>  			if (dwc->usb2_generic_phy)
>  				phy_set_mode(dwc->usb2_generic_phy,
>  					     PHY_MODE_USB_HOST);
> @@ -398,8 +398,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>  		dwc3_event_buffers_setup(dwc);
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>  
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, false);
> +		if (dwc->usb2_phy[0])
> +			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
>  		if (dwc->usb2_generic_phy)
>  			phy_set_mode(dwc->usb2_generic_phy,
>  				     PHY_MODE_USB_DEVICE);
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 4f54f0e..c58a67c 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -2870,8 +2870,8 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
>  	union power_supply_propval	val = {0};
>  	int				ret;
>  
> -	if (dwc->usb2_phy)
> -		return usb_phy_set_power(dwc->usb2_phy, mA);
> +	if (dwc->usb2_phy[0])
> +		return usb_phy_set_power(dwc->usb2_phy[0], mA);
>  
>  	if (!dwc->usb_psy)
>  		return -EOPNOTSUPP;
> -- 
> 2.7.4
> 
