Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233984E3AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiCVIeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiCVId6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:33:58 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E18166211;
        Tue, 22 Mar 2022 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647937951; x=1679473951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tIVU5fTN5x7C6lTP5IxkfGJBP19x1BFBypu6823QLr8=;
  b=AIdpP1GCkdNOwZTm+N5tTKTEKLU4+CEsts+75oI+pDvCYdDhEn+EYtum
   R60FKLIMykSKcz/fsnoUX4I1A+X61IA0H0aOdqzrTkEek5ptTVSLhy2zq
   9tH9qm8jwtGWt5mhIr+q5zyB0GSty8JDvG4pePSikCHJtWw5Gee2U9PKN
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Mar 2022 01:32:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:32:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:32:29 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:32:25 -0700
Date:   Tue, 22 Mar 2022 14:02:21 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v11 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <20220322083221.GJ23316@hu-pkondeti-hyd.qualcomm.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
 <1647932876-23249-3-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1647932876-23249-3-git-send-email-quic_c_sanm@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Hi Sandeep,

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
> +		if (reg & PORT_PE) {
> +			if (DEV_HIGHSPEED(reg) || DEV_FULLSPEED(reg))
> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_HS;
> +			else if (DEV_LOWSPEED(reg))
> +				dwc->hs_phy_mode |= PHY_MODE_USB_HOST_LS;
> +		}
> +	}
> +	phy_set_mode(dwc->usb2_generic_phy, dwc->hs_phy_mode);
> +}

Are these flags cleared somewhere? Also qcom-snps-hs phy driver checks
for (hsphy->mode == PHY_MODE_USB_HOST) condition in qcom_snps_hsphy_suspend
to enable auto-resume. PHY_MODE_USB_HOST_HS/PHY_MODE_USB_HOST_LS flags
are different from PHY_MODE_USB_HOST. Currently this flag is set from
__dwc3_set_mode() when entering host mode. Can you clarify your intention
in calling phy_set_mode() here.

Thanks,
Pavan
