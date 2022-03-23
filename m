Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD1A4E5824
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiCWSJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbiCWSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:09:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356A888E9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:07:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so7173200pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nj3cwmO+pJuGbuCtzw9k+O24u1IZn2oR0F9+b3Xp5Gg=;
        b=VF9oPyr7+7LWZGY8KMwNL/ZHiDC5VqQ+Lm65uz5+hbzlsvrvlDSpKz4pR6QjRVHL80
         dfhvvTegDvay5rIDWR2rDL6ulL2g8l5pTYAEDPtSj7jDRBDExmqx13zlgNRV3T3VvoFV
         86KGRfopizf6CT2KdPovUU7fNClXsuxj9DPNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nj3cwmO+pJuGbuCtzw9k+O24u1IZn2oR0F9+b3Xp5Gg=;
        b=DNihSUse8HJXPoZKHvEaft/5iHpFLbJwZ6DPPewquaQ+9rIwUEXjVoaQ7rMRyB0gPk
         UAbjUqtpNTm+Q6oWvl0ZMWU10FcgErMQoG0+GXU4wRDzJoPvQvMcL53Q49ZX/ZaHC8CH
         vVBt6b5mAiaL5Nzjzk6wdLqtoy4MXuGVIe27N6BuLGNCHbW/EAsccujTtuHUvuzacOp0
         7qD4oVETDp/+0x0OdkZbr73TGsKxZlFo69r0ZCVSb3FQDSbh85ZeFctyvyy3u6+XF1bA
         2tJFQnFqygasCepkMIgwIb7490G24hTbKOcYe/hZIA4mZZ7oh+O95w3+xp6J0PwfAvye
         IoUw==
X-Gm-Message-State: AOAM5307Bv/l6OZOP0FByWOyMD3ULEXel779FZ3gozZW+3jVVdIznWEt
        MQyYJuhPjzq0sXOtkJOB70b4Vg==
X-Google-Smtp-Source: ABdhPJxbqDYgBhYcUxTUl5gRAAV+alUfhK0Feo7/GWoSjE22g0Ka2eMdjD/XRDTq1n1eUl4XbTvgfg==
X-Received: by 2002:a17:902:dac6:b0:154:740a:909f with SMTP id q6-20020a170902dac600b00154740a909fmr1302314plx.76.1648058867576;
        Wed, 23 Mar 2022 11:07:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:877a:10f2:83e7:d6cc])
        by smtp.gmail.com with UTF8SMTPSA id z2-20020aa79902000000b004f75842c97csm579930pff.209.2022.03.23.11.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 11:07:47 -0700 (PDT)
Date:   Wed, 23 Mar 2022 11:07:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH v11 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <YjthzwUldu2+31Pm@google.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
 <1647932876-23249-3-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1647932876-23249-3-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 12:37:53PM +0530, Sandeep Maheswaram wrote:
> During suspend read the status of all port and make sure the PHYs
> are in the correct mode based on current speed.
> Phy interrupt masks are set based on this mode. Keep track of the mode
> of the HS PHY to be able to configure wakeup properly.
> 
> Also check during suspend if any wakeup capable devices are
> connected to the controller (directly or through hubs), if there
> are none set a flag to indicate that the PHY is powered
> down during suspend.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1170b80..232a734 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -32,12 +32,14 @@
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/of.h>
>  #include <linux/usb/otg.h>
> +#include <linux/usb/hcd.h>
>  
>  #include "core.h"
>  #include "gadget.h"
>  #include "io.h"
>  
>  #include "debug.h"
> +#include "../host/xhci.h"
>  
>  #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
>  
> @@ -1861,10 +1863,36 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
>  	return ret;
>  }
>  
> +static void dwc3_set_phy_speed_mode(struct dwc3 *dwc)
> +{
> +
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
> +		reg = readl(&xhci_hcd->op_regs->port_status_base + i * 0x04);

s/0x04/NUM_PORT_REGS/

> +		if (reg & PORT_PE) {
> +			if (DEV_HIGHSPEED(reg) || DEV_FULLSPEED(reg))
> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_HS;
> +			else if (DEV_LOWSPEED(reg))
> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_LS;
> +		}
> +	}
> +	phy_set_mode(dwc->usb2_generic_phy, dwc->hs_phy_mode);
> +}
> +
>  static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  {
>  	unsigned long	flags;
>  	u32 reg;
> +	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
>  
>  	switch (dwc->current_dr_role) {
>  	case DWC3_GCTL_PRTCAP_DEVICE:
> @@ -1877,10 +1905,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		dwc3_core_exit(dwc);
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
> -		if (!PMSG_IS_AUTO(msg)) {
> -			dwc3_core_exit(dwc);
> -			break;
> -		}
> +		dwc3_set_phy_speed_mode(dwc);
>  
>  		/* Let controller to suspend HSPHY before PHY driver suspends */
>  		if (dwc->dis_u2_susphy_quirk ||
> @@ -1896,6 +1921,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  
>  		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>  		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> +
> +		if (!PMSG_IS_AUTO(msg)) {
> +			if (device_may_wakeup(&dwc->xhci->dev) &&

Does the xHCI actually provide the correct information? I think Brian brought
up earlier that xhci-plat always marks the xHCI as wakeup capable, regardless
of whether the specific implementation actually supports wakeup. So a dwc3
without wakeup support would keep the PHY and the dwc3 active during suspend
if wakeup capable devices are connected (unless the admin disabled wakeup),
even though wakeup it doesn't support wakeup.

Using the wakeup capability/policy of the xHCI to make decisions in the dwc3
driver might still be the best we can do with the weird driver split over 3
drivers for dwc3. Maybe the dwc3 could pass the actual capability to wake up
to the xHCI through a property_entry? Then again, it's actually the 'glue'
driver (dwc3-qcom) who knows about the actual wakeup capability, and not the
dwc3 core/host ...

> +			    usb_wakeup_enabled_descendants(hcd->self.root_hub)) {
> +				dwc->phy_power_off = false;
> +			} else {
> +				dwc->phy_power_off = true;
> +				dwc3_core_exit(dwc);
> +			}
> +		}
>  		break;
>  	case DWC3_GCTL_PRTCAP_OTG:
>  		/* do nothing during runtime_suspend */
> @@ -1939,11 +1974,12 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
>  		if (!PMSG_IS_AUTO(msg)) {
> -			ret = dwc3_core_init_for_resume(dwc);
> -			if (ret)
> -				return ret;
> -			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
> -			break;
> +			if (dwc->phy_power_off) {

nit: you could merge this with the outer if condition:

     	       	if (!PMSG_IS_AUTO(msg) && dwc->phy_power_off) {

it's also fine to leave as is.
