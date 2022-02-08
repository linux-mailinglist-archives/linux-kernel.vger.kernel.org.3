Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6703F4AD67C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350135AbiBHL0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349634AbiBHKL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:11:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B02AC03FEC0;
        Tue,  8 Feb 2022 02:11:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41E94B81897;
        Tue,  8 Feb 2022 10:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843F5C004E1;
        Tue,  8 Feb 2022 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644315116;
        bh=1n3zuN5gr1bTke8EYgZWag57jDntKfVyM9A+kTbK258=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUXgqhEpB4JKMbxZIZEz1cMgfHSN8EDdWrvrBz7cnkEtbW3JIAjAgZPTP3PYKuj2r
         LS/tEM5xnusi7ZGNHryugA2yo/GM0+06vcmOipF+N5Ul5g4bG206obaWEaJA4q2Xuk
         ELKSUfRH9Z7IwpFxUMlSNhCXr66s11Ki/Z5jbKJE=
Date:   Tue, 8 Feb 2022 11:11:53 +0100
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
Message-ID: <YgJB6bGm/y7C0oo/@kroah.com>
References: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
 <Ydb79/twbxLDJB8/@kroah.com>
 <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
 <YfE9s06CIv1P3bA/@kroah.com>
 <f45f5952-e31c-5e9d-2560-064199beb29f@quicinc.com>
 <ca306d7c-d816-3cbd-8c65-2c3619739d47@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca306d7c-d816-3cbd-8c65-2c3619739d47@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:34:22PM +0530, Sandeep Maheswaram wrote:
> Hi Greg,
> 
> On 1/27/2022 10:28 AM, Sandeep Maheswaram wrote:
> > 
> > On 1/26/2022 5:55 PM, Greg Kroah-Hartman wrote:
> > > On Fri, Jan 07, 2022 at 10:27:59AM +0530, Sandeep Maheswaram wrote:
> > > > On 1/6/2022 7:55 PM, Greg Kroah-Hartman wrote:
> > > > > On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram wrote:
> > > > > > Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> > > > > > Runtime suspend of phy drivers was failing from DWC3
> > > > > > driver as runtime
> > > > > > usage value is 2 because the phy is initialized from
> > > > > > DWC3 and HCD core.
> > > > > > DWC3 manages phy in their core drivers. Set this quirk to avoid phy
> > > > > > initialization in HCD core.
> > > > > > 
> > > > > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > > > > ---
> > > > > > v5:
> > > > > > Added comment to explain the change done.
> > > > > > v4:
> > > > > > Changed pdev->dev.parent->of_node to sysdev->of_node
> > > > > > 
> > > > > >    drivers/usb/host/xhci-plat.c | 8 ++++++++
> > > > > >    1 file changed, 8 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/usb/host/xhci-plat.c
> > > > > > b/drivers/usb/host/xhci-plat.c
> > > > > > index c1edcc9..e6014d4 100644
> > > > > > --- a/drivers/usb/host/xhci-plat.c
> > > > > > +++ b/drivers/usb/host/xhci-plat.c
> > > > > > @@ -327,6 +327,14 @@ static int xhci_plat_probe(struct
> > > > > > platform_device *pdev)
> > > > > >                         &xhci->imod_interval);
> > > > > >        }
> > > > > > +    /*
> > > > > > +     * Set XHCI_SKIP_PHY_INIT quirk to avoid phy
> > > > > > initialization twice.
> > > > > > +     * DWC3 manages phy in their core drivers. Set this
> > > > > > quirk to avoid phy
> > > > > > +     * initialization in HCD core.
> > > > > > +     */
> > > > > > +    if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
> > > > > > +        xhci->quirks |= XHCI_SKIP_PHY_INIT;
> > > > > > +
> > > > > Why is this function caring about dwc3 stuff?  Shoudn't this be a
> > > > > "generic" device property instead of this device-specific one?
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > This quirk is set only if required for some controllers (eg:
> > > > dwc3 & cdns3).
> > > > 
> > > > Please check below commit.
> > > > 
> > > > https://lore.kernel.org/all/20200918131752.16488-5-mathias.nyman@linux.intel.com/
> > > > 
> > > That commit has nothing to do with a specific "dwc3" quirk anywhere.
> > > Why not set this flag in the specific platform xhci driver instead where
> > > it belongs?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > There is no specific xhci platform driver for dwc3 controllers.
> > 
> > dwc3 controllers use xhci-plat driver .
> > 
> > We can add this quirk in usb/dwc3/host.c as cdns3 does but that requires
> > tying dwc3 and xhci driver .
> > 
> > https://patchwork.kernel.org/project/linux-arm-msm/patch/1633946518-13906-1-git-send-email-sanm@codeaurora.org/
> > 
> > 
> > Regards
> > 
> > Sandeep
> > 
> > 
> Can you suggest any other method to set this quirk for dwc3 controllers.

No idea, sorry.
