Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F038349C995
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbiAZMZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:25:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49754 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbiAZMZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:25:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1984DB81CBB;
        Wed, 26 Jan 2022 12:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240A7C340E3;
        Wed, 26 Jan 2022 12:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643199926;
        bh=LEmuz0iDH1iogcBanvIn+OqS5lY1EbahPHRPxL6nifk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vO4veg9JTHiSb2719N6wyiIBx+hK1D8lPbRNAOKHBFLF6Wpp/gKp1ToGQWCmlkxMA
         lsoiMdEIfelcUzmtXBZ/oLns4zx2CF2Qk7w99xvLY9iqYql+VvqyDwWqUbMvOwKcdA
         96k8/k+VnZ8t1Y61Cp9VFOP9V8aOdDR+2Mg3tbeo=
Date:   Wed, 26 Jan 2022 13:25:23 +0100
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
Message-ID: <YfE9s06CIv1P3bA/@kroah.com>
References: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
 <Ydb79/twbxLDJB8/@kroah.com>
 <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:27:59AM +0530, Sandeep Maheswaram wrote:
> 
> On 1/6/2022 7:55 PM, Greg Kroah-Hartman wrote:
> > On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram wrote:
> > > Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> > > Runtime suspend of phy drivers was failing from DWC3 driver as runtime
> > > usage value is 2 because the phy is initialized from DWC3 and HCD core.
> > > DWC3 manages phy in their core drivers. Set this quirk to avoid phy
> > > initialization in HCD core.
> > > 
> > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > ---
> > > v5:
> > > Added comment to explain the change done.
> > > v4:
> > > Changed pdev->dev.parent->of_node to sysdev->of_node
> > > 
> > >   drivers/usb/host/xhci-plat.c | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > > index c1edcc9..e6014d4 100644
> > > --- a/drivers/usb/host/xhci-plat.c
> > > +++ b/drivers/usb/host/xhci-plat.c
> > > @@ -327,6 +327,14 @@ static int xhci_plat_probe(struct platform_device *pdev)
> > >   					 &xhci->imod_interval);
> > >   	}
> > > +	/*
> > > +	 * Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> > > +	 * DWC3 manages phy in their core drivers. Set this quirk to avoid phy
> > > +	 * initialization in HCD core.
> > > +	 */
> > > +	if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
> > > +		xhci->quirks |= XHCI_SKIP_PHY_INIT;
> > > +
> > Why is this function caring about dwc3 stuff?  Shoudn't this be a
> > "generic" device property instead of this device-specific one?
> > 
> > thanks,
> > 
> > greg k-h
> 
> This quirk is set only if required for some controllers (eg: dwc3 & cdns3).
> 
> Please check below commit.
> 
> https://lore.kernel.org/all/20200918131752.16488-5-mathias.nyman@linux.intel.com/

That commit has nothing to do with a specific "dwc3" quirk anywhere.
Why not set this flag in the specific platform xhci driver instead where
it belongs?

thanks,

greg k-h
