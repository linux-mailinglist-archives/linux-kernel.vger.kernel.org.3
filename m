Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358295257E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359255AbiELWkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359242AbiELWkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:40:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB0DFB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:40:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c11so6236735plg.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Var06zhUfSCRGoXl/2YsHbPLCV39KwA7ovVK4YO/gYI=;
        b=lRh8vfKWUKUZwwsK2meeCN8N1RalNIVkqUl9qT9Miv8PTf5mw6HFPPiCt96zBtd98U
         YNkSyfcIAvU5f7F+qhAIzbiUBhVPvLiDVJ/+KurWq6X1DYubUfQ7Q54ZAbE+tK52azF5
         xR1ztL15JY3nvuj2ZkBRnM2YM/xp2wKuf5OpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Var06zhUfSCRGoXl/2YsHbPLCV39KwA7ovVK4YO/gYI=;
        b=EUIoGO8C/+peW5dIDBCsR94aIlsuAwVajQ0O1ijSpDY4Qo8LiNDkH3fDeUamuUIrwq
         ha4sQsli0RPVPRO+6LYpx0FfJan6//SWCdpZh7Ye5MNN2tc9CjqJtYEki3EPHperrLSb
         G81omha9eSV+Sssg39w/7nF23BRlIA4pkXijh8VqfNwTULs847pOL2qV5Od6KePAJXBd
         cMaIrdwQ7iXeP0Ye+r2pz3g4zPj3xhozaCEcXTyMDnhlSK8AU+vJAHDuyQi+UfbxNFSf
         EFeOmAO8GKI9W43/dLYqyzHtM5CEMaV/TazGrwOcLNh4yeuThSip4X/uajnJRKIUsWqO
         SIEA==
X-Gm-Message-State: AOAM5329BANjDhTyHUfCbUTQh3a2wF3m/wlpa0Sb9Z6A820nAXJImr4L
        IQTSEg/Qbk/XZAPd1XA8tRNayw==
X-Google-Smtp-Source: ABdhPJz/0NAzpj2X0qc6+LmD057ToQ+VV6hPC/AZ4GoKWxAxkwvmbJ/ELD8Ga+7cT1wWr4yCeaBWgw==
X-Received: by 2002:a17:902:d2c9:b0:15e:a266:6472 with SMTP id n9-20020a170902d2c900b0015ea2666472mr1736829plc.45.1652395240339;
        Thu, 12 May 2022 15:40:40 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:bc87:9632:bcce:8e17])
        by smtp.gmail.com with UTF8SMTPSA id v21-20020a17090a521500b001d2edf4b513sm275481pjh.56.2022.05.12.15.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 15:40:40 -0700 (PDT)
Date:   Thu, 12 May 2022 15:40:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [v16 2/5] usb: dwc3: core: Host wake up support from system
 suspend
Message-ID: <Yn2M5hrah78jro1C@google.com>
References: <1652379802-8318-1-git-send-email-quic_kriskura@quicinc.com>
 <1652379802-8318-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1652379802-8318-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:53:19PM +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
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
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 30 +++++++++++++++++-------------
>  drivers/usb/dwc3/core.h |  4 ++++
>  drivers/usb/dwc3/host.c | 24 ++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 01115df..8bcabc5 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1785,6 +1785,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, dwc);
>  	dwc3_cache_hwparams(dwc);
> +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
>  
>  	spin_lock_init(&dwc->lock);
>  	mutex_init(&dwc->mutex);
> @@ -1946,10 +1947,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
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
> @@ -1965,6 +1963,15 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  
>  		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>  		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> +
> +		if (!PMSG_IS_AUTO(msg)) {
> +			if (device_may_wakeup(dwc->dev))

I think this should be device_can_wakeup(), i.e. hardware capability instead of
device policy. A drawback of powering the PHYs off is that it causes a high
power consumption of certain peripherals if VBUS is still supplied, so this
should be limited to platforms where the PHYs must be powered off (using wakeup
capability as a proxy for now).


> +				dwc->phy_power_off = false;
> +			else {
> +				dwc->phy_power_off = true;
> +				dwc3_core_exit(dwc);
> +			}
> +		}
>  		break;
>  	case DWC3_GCTL_PRTCAP_OTG:
>  		/* do nothing during runtime_suspend */
> @@ -2008,11 +2015,12 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
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
> @@ -2084,8 +2092,6 @@ static int dwc3_runtime_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	device_init_wakeup(dev, true);
> -
>  	return 0;
>  }
>  
> @@ -2094,8 +2100,6 @@ static int dwc3_runtime_resume(struct device *dev)
>  	struct dwc3     *dwc = dev_get_drvdata(dev);
>  	int		ret;
>  
> -	device_init_wakeup(dev, false);
> -
>  	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 81c486b..37397a8 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1155,6 +1155,9 @@ struct dwc3 {
>  
>  	bool			phys_ready;
>  
> +	unsigned int            hs_phy_mode;
> +	bool			phy_power_off;
> +
>  	struct ulpi		*ulpi;
>  	bool			ulpi_ready;
>  
> @@ -1539,6 +1542,7 @@ int dwc3_core_soft_reset(struct dwc3 *dwc);
>  #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
>  int dwc3_host_init(struct dwc3 *dwc);
>  void dwc3_host_exit(struct dwc3 *dwc);
> +void dwc3_check_phy_speed_mode(struct dwc3 *dwc);
>  #else
>  static inline int dwc3_host_init(struct dwc3 *dwc)
>  { return 0; }
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index f56c30c..e19b40a 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  
>  #include "core.h"
> +#include "../host/xhci.h"
>  
>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>  					int irq, char *name)
> @@ -136,3 +137,26 @@ void dwc3_host_exit(struct dwc3 *dwc)
>  {
>  	platform_device_unregister(dwc->xhci);
>  }
> +
> +void dwc3_check_phy_speed_mode(struct dwc3 *dwc)
> +{
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

I anticipate that it might raise concerns from maintainers that
dwc3_check_phy_speed_mode() accesses xHCI data structures and
registers directly. Could there be a generic HCD API that provides
this functionality (if implemented by the specific HCD)?
