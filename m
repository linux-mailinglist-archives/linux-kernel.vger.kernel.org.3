Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5810B49CA02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiAZMrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbiAZMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:47:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F30C06161C;
        Wed, 26 Jan 2022 04:47:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C282B81CBB;
        Wed, 26 Jan 2022 12:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6868FC340E8;
        Wed, 26 Jan 2022 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643201261;
        bh=kIGlnjBGTh6zIi8iQ/JDAw3h8p25VHindX4jPD66GFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0uK1RuCsPKh/QTSlnPL83IiSk78/+JZRoyeh57+QWFfbiRqccJNrgZ0Dnf2b9Yo/
         h6uDeuhPyLLAnVAXxgaDZYMBu/P9N2EvxozlGidQXpwtQHl46uz1RzltIpzFVZQQ2E
         EJknWiOb1z2UziaYloaM9xMyZjiX2Ys9vS8lY/io=
Date:   Wed, 26 Jan 2022 13:47:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com
Subject: Re: [PATCH v10 1/6] usb: host: xhci: plat: Add suspend quirk for
 dwc3 controller
Message-ID: <YfFC6tdv3YR/pJRB@kroah.com>
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
 <1642398248-21753-2-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642398248-21753-2-git-send-email-quic_c_sanm@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:14:03AM +0530, Sandeep Maheswaram wrote:
> During suspend check if any wakeup capable devices are connected to the
> controller (directly or through hubs), and set the wakeup enable property
> for xhci plat device.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> Change device_set_wakeup_capable to device_set_wakeup_enable as 
> wakeup capable false was deleting the sysfs property.
> 
>  drivers/usb/host/xhci-plat.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index c1edcc9..1c8fadb 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -431,6 +431,14 @@ static int xhci_plat_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> +static void xhci_dwc3_suspend_quirk(struct usb_hcd *hcd, struct device *dev)
> +{
> +	if (usb_wakeup_enabled_descendants(hcd->self.root_hub))
> +		device_set_wakeup_enable(dev, true);
> +	else
> +		device_set_wakeup_enable(dev, false);
> +}
> +
>  static int __maybe_unused xhci_plat_suspend(struct device *dev)
>  {
>  	struct usb_hcd	*hcd = dev_get_drvdata(dev);
> @@ -440,6 +448,10 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
>  	ret = xhci_priv_suspend_quirk(hcd);
>  	if (ret)
>  		return ret;
> +
> +	if (of_device_is_compatible(dev->parent->of_node, "snps,dwc3"))
> +		xhci_dwc3_suspend_quirk(hcd, dev);

I still think that checking for this type of thing needs to be in the
platform specific driver, not in the generic one.

thanks,

greg k-h
