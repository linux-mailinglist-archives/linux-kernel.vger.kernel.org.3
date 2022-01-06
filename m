Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668B44865FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbiAFO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbiAFO0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:26:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BBDC061245;
        Thu,  6 Jan 2022 06:26:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E916B821D0;
        Thu,  6 Jan 2022 14:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46F0C36AE0;
        Thu,  6 Jan 2022 14:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641479162;
        bh=uXWGqLH59n+MPGqFFacV1Z+a8kQaXFKV9ygc4/AdANA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JywDOCK1dUn5A/ekeJhiJjDizHisUI8wf779pn7gRpQGyFoB1zL1S6EqkUHdIMUDB
         W4oUi29mPQdpMoUUKnO3Rh85zMgpJhcKF5ZGyxd3CuSCrUou/RT2/gqzecP5xgTsC5
         nnlOqOv7Ytd1a2s723bbbEfUKWtFEj2S0NIRJZjc=
Date:   Thu, 6 Jan 2022 15:25:59 +0100
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
Subject: Re: [PATCH v5] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk
 for DWC3 controller
Message-ID: <Ydb79/twbxLDJB8/@kroah.com>
References: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram wrote:
> Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
> usage value is 2 because the phy is initialized from DWC3 and HCD core.
> DWC3 manages phy in their core drivers. Set this quirk to avoid phy
> initialization in HCD core.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
> v5:
> Added comment to explain the change done.
> v4:
> Changed pdev->dev.parent->of_node to sysdev->of_node
> 
>  drivers/usb/host/xhci-plat.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index c1edcc9..e6014d4 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -327,6 +327,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  					 &xhci->imod_interval);
>  	}
>  
> +	/*
> +	 * Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> +	 * DWC3 manages phy in their core drivers. Set this quirk to avoid phy
> +	 * initialization in HCD core.
> +	 */
> +	if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
> +		xhci->quirks |= XHCI_SKIP_PHY_INIT;
> +

Why is this function caring about dwc3 stuff?  Shoudn't this be a
"generic" device property instead of this device-specific one?

thanks,

greg k-h
