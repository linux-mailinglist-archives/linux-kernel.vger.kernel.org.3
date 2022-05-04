Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CBC51AC9D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376737AbiEDSWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376723AbiEDSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:22:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E14BB8D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:46:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i17so2053109pla.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LtWHuThIe0dcxXuedbVwJNy12A4ZYyFgKdzHIm7dues=;
        b=Vfd0Sq+Wzp1oZDscK9nncqtb62H1YcTv5jc/nrwigR2VKbA6OkaPGroKpsj3kv+sQX
         CljNkT1bNmxMDGjq+o9fjKGuaLTIC4SyMK+odZjHhr3K0OYaEBpx/i/hY8xb5QBJQABp
         PGTH7AkFPEj6DI0rmw/JchSqtuazrYVhS9GOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LtWHuThIe0dcxXuedbVwJNy12A4ZYyFgKdzHIm7dues=;
        b=Kik2wcPPMM+nh74+ePssZ+Tw9LNbC2LUG/bZzeGekDio4LapKZbIOv+bbWMnrOj8qc
         KehEFxzhmFV/owxrFhZGeTy8kqKwFb8UQimFGrsrmdYV3bTwDOeKFj8RE93zYyy2pZWI
         GHhuSa55R4tUa/LPRSmGEehHkMb0zP1UktfyaMdUcQkhFlyFOs6Gp4A8xYslwFtfCde9
         Fcoei2uZEUyLGlkYSq8DDywGgEQdNk+PQocXN6NO2zSxtOJd7iVXG3cddst+suunUCJf
         8RvbRTQk0JGnA2DNdbLfrGBkPALD1DZeBElXdR1pA2w90+kWnuxdKUQncYnM/JWIcFqD
         NxTw==
X-Gm-Message-State: AOAM532EfwhqiU6FSLRh59CpjMd2KxSdq12VJXNaBt2GWep705Mf/XnS
        9IMWsY4ZoQ7cIY+dIbG0zpHfaw==
X-Google-Smtp-Source: ABdhPJzGjN/OiaZWZXI+A5qznvKAV8N/38y/N4mbFxjfX9tWUyAGv9EtHXHEYW/GLFF2lvfgq/eYSg==
X-Received: by 2002:a17:90b:2249:b0:1dc:7905:c4bf with SMTP id hk9-20020a17090b224900b001dc7905c4bfmr730381pjb.62.1651686392625;
        Wed, 04 May 2022 10:46:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:35b6:c77b:be04:3bd5])
        by smtp.gmail.com with UTF8SMTPSA id q26-20020a63505a000000b003aa8b87feb5sm15538347pgl.0.2022.05.04.10.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 10:46:32 -0700 (PDT)
Date:   Wed, 4 May 2022 10:46:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_kriskura@quicinc.com,
        quic_vpulyala@quicinc.com
Subject: Re: [PATCH v14 3/7] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <YnK79i3NiTdMmC98@google.com>
References: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
 <1650395470-31333-4-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650395470-31333-4-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 12:41:06AM +0530, Sandeep Maheswaram wrote:
> During suspend read the status of all port and set hs phy mode
> based on current speed. Use this hs phy mode to configure wakeup
> interrupts in qcom glue driver.
> 
> Check wakeup-source property for dwc3 core node to set the
> wakeup capability. Drop the device_init_wakeup call from
> runtime suspend and resume.
> 
> Also check during suspend if any wakeup capable devices are
> connected to the controller (directly or through hubs), if there
> are none set a flag to indicate that the PHY is powered
> down during suspend.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
> v14:
> Used device_children_wakeup_capable instead of usb_wakeup_enabled_descendants.
> 
> v13:
> Changed dwc3_set_phy_speed_mode to dwc3_check_phy_speed_mode.
> Removed device_init_wakeup calls from dwc3_runtime_suspend and dwc3_runtime_resume
> as we have a new dt property wakeup-source.
> 
> 
>  drivers/usb/dwc3/core.c | 33 ++++++++++++++++++++-------------
>  drivers/usb/dwc3/core.h |  4 ++++
>  drivers/usb/dwc3/host.c | 24 ++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1170b80..898aa66 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -32,6 +32,7 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/of.h>
>  #include <linux/usb/otg.h>
> +#include <linux/usb/hcd.h>
>  
>  #include "core.h"
>  #include "gadget.h"
> @@ -1723,6 +1724,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, dwc);
>  	dwc3_cache_hwparams(dwc);
> +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
>  
>  	spin_lock_init(&dwc->lock);
>  	mutex_init(&dwc->mutex);
> @@ -1865,6 +1867,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  {
>  	unsigned long	flags;
>  	u32 reg;
> +	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
>  
>  	switch (dwc->current_dr_role) {
>  	case DWC3_GCTL_PRTCAP_DEVICE:
> @@ -1877,10 +1880,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		dwc3_core_exit(dwc);
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
> -		if (!PMSG_IS_AUTO(msg)) {
> -			dwc3_core_exit(dwc);
> -			break;
> -		}
> +		dwc3_check_phy_speed_mode(dwc);
>  
>  		/* Let controller to suspend HSPHY before PHY driver suspends */
>  		if (dwc->dis_u2_susphy_quirk ||
> @@ -1896,6 +1896,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  
>  		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>  		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> +
> +		if (!PMSG_IS_AUTO(msg)) {
> +			if (device_may_wakeup(dwc->dev) &&
> +			    device_children_wakeup_capable(&hcd->self.root_hub->dev)) {
> +				dwc->phy_power_off = false;
> +			} else {
> +				dwc->phy_power_off = true;
> +				dwc3_core_exit(dwc);

I found that shutting the PHYs down during suspend leads to high power
consumption of a downstream hub (about 80mW vs 15mW when the PHYs are
not shut down).

It would be interesting to know if this also impacts other non-hub
peripherals. Unfortunately I can't test that, the hub on my system is
soldered to the board.

I understand that shutting the PHYs down might be beneficial in terms
of power on some systems, however on those I'm looking at we'd strongly
prefer to save the 65mW of power consumed by the hub, rather than
whatever smaller amount of power that is saved by powering down the
PHYs.

Could we introduce a sysfs attribute (or some other sort of knob) to
allow the admin to configure whether the PHYs should remain on or off
during suspend? That is assuming that it is actually desirable to power
them off on some systems.
