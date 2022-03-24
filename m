Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8DE4E6355
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350158AbiCXM33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243526AbiCXM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:29:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8660A8CCE9;
        Thu, 24 Mar 2022 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648124876; x=1679660876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SO2KgsH5pZ6TNFP9PmhWj87X8+YVC544qe3E7ItN9k0=;
  b=O9u8oUY83+xYaxXF2sKoUCzKi4sYPmH47LvmhwWBjgxCwmq4iTcEqll6
   Xoh+m/mEIhSwNtdKZYSgs5syY1Yw0tj944KJTDnD+FNq3Jh+pK2rM1irn
   +aMxCNLYyIGTRDaYHY3PabJvbqPkrbnoWukZPxhSXjml2fe/yalzSyIhe
   aqzFdm1E2qs9URLe4oy4pa8OBEKhwPh8fITWdnXlOvikouVztx3zkahBM
   xes+dn32NNfeUJwz7IZ30T4a5Osp6i3+K3KZw+2SpIqvg9b3JVspu+AiB
   O8sR4UlFPCjlvhYl4D/ROAHVHhHbA4BSzvbQ74C6EqXSVWAbrZOmHllGe
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238306118"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="238306118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="693306912"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Mar 2022 05:27:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 24 Mar 2022 14:27:50 +0200
Date:   Thu, 24 Mar 2022 14:27:50 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH v3 3/3] usb: dwc: host: add xhci_plat_priv quirk
 XHCI_SKIP_PHY_INIT
Message-ID: <YjxjxplpOpDC2JLs@kuha.fi.intel.com>
References: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
 <1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 12:07:11PM +0530, Sandeep Maheswaram wrote:
> Currently the phy init is done from dwc3 and also xhci which makes the
> runtime_usage value 2 for the phy which causes issue during runtime
> suspend. When we run the below command the runtime_status still shows
> active.
> echo auto > /sys/bus/platform/devices/88e3000.phy/power/control
> 
> dwc3 manages PHY by own DRD driver, so skip the management by
> HCD core by setting this quirk.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
>  drivers/usb/dwc3/host.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index eda8719..d4fcf06 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -13,6 +13,12 @@
>  #include <linux/platform_device.h>
>  
>  #include "core.h"
> +#include <linux/usb/xhci-plat.h>
> +#include <linux/usb/xhci-quirks.h>
> +
> +static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
> +	.quirks = XHCI_SKIP_PHY_INIT,
> +};
>  
>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
>  					int irq, char *name)
> @@ -122,6 +128,13 @@ int dwc3_host_init(struct dwc3 *dwc)
>  		}
>  	}
>  
> +	ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
> +			sizeof(xhci_plat_dwc3_xhci));
> +	if (ret) {
> +		dev_err(dwc->dev, "failed to add data to xHCI\n");
> +		goto err;
> +	}
> +
>  	ret = platform_device_add(xhci);
>  	if (ret) {
>  		dev_err(dwc->dev, "failed to register xHCI device\n");

I think you should just use device property:

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index eda871973d6cc..dbff7b8ed6d5e 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -67,7 +67,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 
 int dwc3_host_init(struct dwc3 *dwc)
 {
-       struct property_entry   props[4];
+       struct property_entry   props[5];
        struct platform_device  *xhci;
        int                     ret, irq;
        int                     prop_idx = 0;
@@ -114,12 +114,12 @@ int dwc3_host_init(struct dwc3 *dwc)
        if (DWC3_VER_IS_WITHIN(DWC3, ANY, 300A))
                props[prop_idx++] = PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
 
-       if (prop_idx) {
-               ret = device_create_managed_software_node(&xhci->dev, props, NULL);
-               if (ret) {
-                       dev_err(dwc->dev, "failed to add properties to xHCI\n");
-                       goto err;
-               }
+       props[prop_idx++] = PROPERTY_ENTRY_BOOL("skip-phy-init");
+
+       ret = device_create_managed_software_node(&xhci->dev, props, NULL);
+       if (ret) {
+               dev_err(dwc->dev, "failed to add properties to xHCI\n");
+               goto err;
        }
 
        ret = platform_device_add(xhci);
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 649ffd861b44e..31ed39d06e29b 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -307,6 +307,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
                device_property_read_u32(tmpdev, "imod-interval-ns",
                                         &xhci->imod_interval);
+
+               if (device_property_read_bool(tmpdev, "skip-phy-init"))
+                       hcd->skip_phy_initialization = 1;
        }
 
        hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);

-- 
heikki
