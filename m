Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23B24978E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbiAXGWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:22:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58588 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241551AbiAXGWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:22:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5964B80DF2;
        Mon, 24 Jan 2022 06:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAA3C340E5;
        Mon, 24 Jan 2022 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643005328;
        bh=KXoIODYLU0wZly3rYKNFyGFd5LqueIgvEtew+lJP7Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjHjKAzG5ZH6dEjzdaazqYtmfqbxl7DHg1rQqvBGg+H2Lff/oibVi1wmf1CBkHozu
         E364hRxfI/M4HoP0767uabY48VP33W5sQ2VXxcN5MiH6dZIKDSL0h3VHso+izMOZ8Z
         wScaEXhmeawoissNFGJcoQkue5xj4M1Vyq8aFXSo=
Date:   Mon, 24 Jan 2022 07:21:57 +0100
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
Message-ID: <Ye5FhWDUnCfn9LT4@kroah.com>
References: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
 <Ydb79/twbxLDJB8/@kroah.com>
 <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
 <c34ea13b-f7ac-22de-6c5d-5e930853415c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c34ea13b-f7ac-22de-6c5d-5e930853415c@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:01:07AM +0530, Sandeep Maheswaram wrote:
> Hi Greg,
> 
> On 1/7/2022 10:27 AM, Sandeep Maheswaram wrote:
> > 
> > On 1/6/2022 7:55 PM, Greg Kroah-Hartman wrote:
> > > On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram wrote:
> > > > Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> > > > Runtime suspend of phy drivers was failing from DWC3 driver as runtime
> > > > usage value is 2 because the phy is initialized from DWC3 and HCD core.
> > > > DWC3 manages phy in their core drivers. Set this quirk to avoid phy
> > > > initialization in HCD core.
> > > > 
> > > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > > ---
> > > > v5:
> > > > Added comment to explain the change done.
> > > > v4:
> > > > Changed pdev->dev.parent->of_node to sysdev->of_node
> > > > 
> > > >   drivers/usb/host/xhci-plat.c | 8 ++++++++
> > > >   1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/host/xhci-plat.c
> > > > b/drivers/usb/host/xhci-plat.c
> > > > index c1edcc9..e6014d4 100644
> > > > --- a/drivers/usb/host/xhci-plat.c
> > > > +++ b/drivers/usb/host/xhci-plat.c
> > > > @@ -327,6 +327,14 @@ static int xhci_plat_probe(struct
> > > > platform_device *pdev)
> > > >                        &xhci->imod_interval);
> > > >       }
> > > >   +    /*
> > > > +     * Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> > > > +     * DWC3 manages phy in their core drivers. Set this quirk
> > > > to avoid phy
> > > > +     * initialization in HCD core.
> > > > +     */
> > > > +    if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
> > > > +        xhci->quirks |= XHCI_SKIP_PHY_INIT;
> > > > +
> > > Why is this function caring about dwc3 stuff?  Shoudn't this be a
> > > "generic" device property instead of this device-specific one?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > This quirk is set only if required for some controllers (eg: dwc3 &
> > cdns3).
> > 
> > Please check below commit.
> > 
> > https://lore.kernel.org/all/20200918131752.16488-5-mathias.nyman@linux.intel.com/
> > 
> > 
> > 
> > Regards
> > 
> > Sandeep
> > 
> > 
> Please let me know if anything more info needed for this patch.

The merge window ended a few hours ago, give me a few days to catch up
with my pending email queue that I have to review:

$ mdfrm -c ~/mail/todo/
2254 messages in /home/gregkh/mail/todo/

thanks,

greg k-h
