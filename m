Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2541C473594
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbhLMUEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:04:01 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41556 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhLMUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:04:00 -0500
Received: by mail-ot1-f45.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so18653668otl.8;
        Mon, 13 Dec 2021 12:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+VkbINDZ3982NbklJtQQFI+CicmdRJDGJAAh3xSd9Q=;
        b=dpVnZT81pZiMgEsp2nrNZ41l/5+XWzVKzr7JlCx9HEjISj3RBtmqgmuW0nF+aMQELz
         CrO+tYVi6aZ1TG1p0HR55MPN8RFQZV9E0A9S9YS7FouifYUEkgG4UZIzUb28UsDUClAk
         6ei/aBSfH9habOmntVLNuL5MZhrLULWk5fMZmU28u4kpxFRE9mWLmdL+mh9FrcVAg+kc
         Sd/Sro5Ki6st3IoPDrwCo1E7UxVJcvkJCe4Kjx2ylpLZWO2F8CeMz51WHG6F2v5C64LG
         khjJRxlr36WlmcPQIASzKoY0zjKGq4ykZ+1Dksl/6HB9q1sTjbqpeKDPsjvipyizSjr/
         4DEQ==
X-Gm-Message-State: AOAM530AZJM06DMYBPSoAMEugA3tHmCyCgCTl7ylr4bxx2xyxxJDwWtp
        /3F65NkPn1RpnJ0cn4J53Q==
X-Google-Smtp-Source: ABdhPJywftm6gboxmNC9EyDFlLflvbyYC+iKdPeAALWUM3Qhb8d9nY858CYgewg4q2ZFvDuTCjjq0A==
X-Received: by 2002:a05:6830:3195:: with SMTP id p21mr614011ots.56.1639425838637;
        Mon, 13 Dec 2021 12:03:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h3sm2326962oon.34.2021.12.13.12.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:03:57 -0800 (PST)
Received: (nullmailer pid 1478068 invoked by uid 1000);
        Mon, 13 Dec 2021 20:03:56 -0000
Date:   Mon, 13 Dec 2021 14:03:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, greg@kroah.com,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_psodagud@quicinc.com, quic_satyap@quicinc.com,
        quic_pheragu@quicinc.com, quic_rjendra@quicinc.com,
        quic_sibis@quicinc.com, quic_saipraka@quicinc.com
Subject: Re: [PATCH V2 4/8] usb: dwc3: drd: Register the eud connector child
 node for dwc3
Message-ID: <YbenLLPUYVX50CJc@robh.at.kernel.org>
References: <cover.1638430506.git.quic_schowdhu@quicinc.com>
 <bcb48839a520b8bfc9b09e7a26ba8a8459ab602d.1638430506.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb48839a520b8bfc9b09e7a26ba8a8459ab602d.1638430506.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:21:23PM +0530, Souradeep Chowdhury wrote:
> Register the child node for dwc3 which is the "eud_usb_connector".
> The eud driver will be able to switch the usb role from device to
> host and vice versa using the role switch property of dwc3 node.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  drivers/usb/dwc3/drd.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index d7f7683..b4ea55c 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/extcon.h>
> +#include <linux/of_platform.h>
>  #include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> @@ -164,6 +165,27 @@ static int dwc3_otg_get_irq(struct dwc3 *dwc)
>  	return irq;
>  }
>  
> +static int dwc3_register_eud(struct dwc3 *dwc)
> +{
> +	struct device		*dev = dwc->dev;
> +	struct device_node	*np = dev->of_node;
> +	int                     ret;
> +
> +	of_get_child_by_name(np, "eud_usb_connector");

Connector nodes are named 'connector' or possibly 'usb-connector'. If 
you are creating an ABI with the node name, it should be documented. 
However, it's preferred to use 'compatible' for identifying nodes rather 
than a node name.

> +	if (!np) {
> +		dev_dbg(dev, "no usb_connector child node specified\n");
> +		return 0;
> +	}
> +
> +	ret = of_platform_populate(np, NULL, NULL, dev);

But why is any of this needed. The connector doesn't have a driver (I 
expect eventually we will) and the EUD device is not a child.

> +	if (ret) {
> +		dev_err(dev, "failed to register usb_connector - %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  void dwc3_otg_init(struct dwc3 *dwc)
>  {
>  	u32 reg;
> @@ -580,6 +602,10 @@ int dwc3_drd_init(struct dwc3 *dwc)
>  		ret = dwc3_setup_role_switch(dwc);
>  		if (ret < 0)
>  			return ret;
> +
> +		ret = dwc3_register_eud(dwc);
> +		if (ret < 0)
> +			return ret;
>  	} else if (dwc->edev) {
>  		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
>  		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
> -- 
> 2.7.4
> 
> 
