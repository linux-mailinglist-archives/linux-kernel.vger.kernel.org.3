Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892064FC633
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243481AbiDKU4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbiDKU4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:56:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6B8183A9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:54:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso473086pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MeANwaP9JmwAACnbLRdVWJXdi5Dvn5w5kJMXuz3gK1s=;
        b=BOB11IonNKDbW3yU7EG5l64H0Tl6YTrTZaZDHtydQ99KH9fVm92GzrOdjqnbcqGN3s
         xp2nZi9Q5ES9g34kUo76o9rPWocYwjWS0TCOqbV8u23LyBHH7VpKfkX8rclYarIvxPbS
         H38N/3n2yTR2cyz2wAM+NOFs1iPi3ixdOudn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MeANwaP9JmwAACnbLRdVWJXdi5Dvn5w5kJMXuz3gK1s=;
        b=IffGRQEzYZkdSQ+2Ibu/tGJv1iw3k2sGcSje4LOkriUjzXRT/BpY5Mr0RJNEaCewPH
         QeLxcL/xuasgDhFyyzy82gMYpyxLy8s9WptkRi9tpCxkQk3vFePdtwhaiXtImxeV1OgI
         PrLiCVlTkOIbhrLVPKTdwyYWnm2q8rYIQ9040/kVYxbSnLXhLIQtYbDNHxONAyHddn+e
         HyV+fNQOL1JHAQbsk+5DfcPQnHnVffWVk5v553p357MO3ZilvvP9Be/Ap/ymklvGpIXR
         jOXgtMA2fh/2bFTdHiTkjO+/ssYWoC8ar1BSFQccY4SKg/Uc4bI81mLyw/c3Ho3U4czQ
         7pTw==
X-Gm-Message-State: AOAM5310J20HK69sSb/6CWAxMMQxLSuV2Dvn/Toz8cn5QEh8zN/tok0s
        kRk50mGhbkZfAF4x4GAj6mg/2g==
X-Google-Smtp-Source: ABdhPJxqIC9qD7T4GjpjdQlFYQuLPa3Mfns68bxMr9u32io0hAAWyIOerUZLr3L2lBq63+JQ520nPA==
X-Received: by 2002:a17:902:8bcc:b0:158:20f8:392 with SMTP id r12-20020a1709028bcc00b0015820f80392mr17341328plo.93.1649710459909;
        Mon, 11 Apr 2022 13:54:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:eb96:76ba:e2a1:2442])
        by smtp.gmail.com with UTF8SMTPSA id u17-20020a056a00159100b004faef351ebcsm35077269pfk.45.2022.04.11.13.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 13:54:19 -0700 (PDT)
Date:   Mon, 11 Apr 2022 13:54:17 -0700
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
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v13 2/6] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <YlSVec5+SpdMZWCz@google.com>
References: <1649704614-31518-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649704614-31518-3-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649704614-31518-3-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:46:50AM +0530, Sandeep Maheswaram wrote:
> During suspend read the status of all port and set hs phy mode
> based on current speed. Use this hs phy mode to configure wakeup
> interrupts in qcom glue driver.
> 
> Check wakep-source property for dwc3 core node to set the

s/wakep/wakeup/

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

A per-patch change log would be really helpful for reviewers, even
if it doesn't include older versions.

>  drivers/usb/dwc3/core.c | 33 ++++++++++++++++++++-------------
>  drivers/usb/dwc3/core.h |  4 ++++
>  drivers/usb/dwc3/host.c | 25 +++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1170b80..effaa43 100644
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
> +			    usb_wakeup_enabled_descendants(hcd->self.root_hub)) {

You did not answer my question on v12, reposting it:

  Did you ever try whether you could use device_children_wakeup_capable() from
  [1] instead of usb_wakeup_enabled_descendants()?

  [1] https://patchwork.kernel.org/project/linux-usb/patch/1635753224-23975-2-git-send-email-quic_c_sanm@quicinc.com/#24566065

> +				dwc->phy_power_off = false;
> +			} else {
> +				dwc->phy_power_off = true;
> +				dwc3_core_exit(dwc);
> +			}
> +		}
>  		break;
>  	case DWC3_GCTL_PRTCAP_OTG:
>  		/* do nothing during runtime_suspend */
> @@ -1939,11 +1949,12 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
>  		if (!PMSG_IS_AUTO(msg)) {
> -			ret = dwc3_core_init_for_resume(dwc);
> -			if (ret)
> -				return ret;
> -			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> -			break;
> +			if (dwc->phy_power_off) {
> +				ret = dwc3_core_init_for_resume(dwc);
> +				if (ret)
> +					return ret;
> +				dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> +			}
>  		}
>  		/* Restore GUSB2PHYCFG bits that were modified in suspend */
>  		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
> @@ -2015,8 +2026,6 @@ static int dwc3_runtime_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	device_init_wakeup(dev, true);
> -
>  	return 0;
>  }
>  
> @@ -2025,8 +2034,6 @@ static int dwc3_runtime_resume(struct device *dev)
>  	struct dwc3     *dwc = dev_get_drvdata(dev);
>  	int		ret;
>  
> -	device_init_wakeup(dev, false);
> -
>  	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 5c9d467..6a5845f 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1154,6 +1154,9 @@ struct dwc3 {
>  
>  	bool			phys_ready;
>  
> +	unsigned int            hs_phy_mode;
> +	bool			phy_power_off;
> +
>  	struct ulpi		*ulpi;
>  	bool			ulpi_ready;
>  
> @@ -1537,6 +1540,7 @@ int dwc3_core_soft_reset(struct dwc3 *dwc);
>  #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>  int dwc3_host_init(struct dwc3 *dwc);
>  void dwc3_host_exit(struct dwc3 *dwc);
> +void dwc3_check_phy_speed_mode(struct dwc3 *dwc);
>  #else
>  static inline int dwc3_host_init(struct dwc3 *dwc)
>  { return 0; }
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index eda8719..7f22675 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  
>  #include "core.h"
> +#include "../host/xhci.h"
>  
>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>  					int irq, char *name)
> @@ -138,3 +139,27 @@ void dwc3_host_exit(struct dwc3 *dwc)
>  {
>  	platform_device_unregister(dwc->xhci);
>  }
> +
> +void dwc3_check_phy_speed_mode(struct dwc3 *dwc)
> +{
> +

delete empty line

> +	int i, num_ports;
> +	u32 reg;
> +	struct usb_hcd	*hcd = platform_get_drvdata(dwc->xhci);
> +	struct xhci_hcd	*xhci_hcd = hcd_to_xhci(hcd);
> +
> +	dwc->hs_phy_mode = 0;
> +
> +	reg = readl(&xhci_hcd->cap_regs->hcs_params1);
> +
> +	num_ports = HCS_MAX_PORTS(reg);
> +	for (i = 0; i < num_ports; i++) {
> +		reg = readl(&xhci_hcd->op_regs->port_status_base + i * NUM_PORT_REGS);
> +		if (reg & PORT_PE) {
> +			if (DEV_HIGHSPEED(reg) || DEV_FULLSPEED(reg))
> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_HS;
> +			else if (DEV_LOWSPEED(reg))
> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_LS;
> +		}
> +	}
> +}
> -- 
> 2.7.4
> 
