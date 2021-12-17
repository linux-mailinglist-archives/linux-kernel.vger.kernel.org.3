Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989C547883A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhLQJzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:55:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60254 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhLQJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:55:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A34F7B82777;
        Fri, 17 Dec 2021 09:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB39EC36AE5;
        Fri, 17 Dec 2021 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639734916;
        bh=1aEoMiE6VItuYl5E0WgDp/2okoaLiCtSWiTRyQ3q8uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReP9974co9CvRAsnlP8dFlx3GMTJWG2b/serg4mV7crZMI315zD9wSV2HZMEU/31w
         iRRVu6hMuv0UoNSZxdXmIUQyIAfeWx59fgNCbDAeXPR8ssYfKIi6xROBaV2K22XNBe
         Akm9VxnkMOO7xaLNv7oZnfTO3q3xWf1yU/pwb2kM=
Date:   Fri, 17 Dec 2021 10:55:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com
Subject: Re: [PATCH v4] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk
 for DWC3 controller
Message-ID: <YbxegQPJ6bPcaCRh@kroah.com>
References: <1639724997-21809-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639724997-21809-1-git-send-email-quic_c_sanm@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:39:57PM +0530, Sandeep Maheswaram wrote:
> Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
> usage value is 2 because the phy is initialized from DWC3 and HCD core.
> DWC3 manages phy in their core drivers. Set this quirk to avoid phy
> initialization in HCD core.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> ---
> v4:
> Changed pdev->dev.parent->of_node to sysdev->of_node
> 
>  drivers/usb/host/xhci-plat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index c1edcc9..1a57573 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -327,6 +327,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
>  					 &xhci->imod_interval);
>  	}
>  
> +	if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
> +		xhci->quirks |= XHCI_SKIP_PHY_INIT;

Please put a big comment in here as to why this is being set, that
contains some of the same information you put in your changelog.
Otherwise just reading this code, it is not obvious why this quirk is
being set at all.

thanks,

greg k-h
