Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA059F53C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiHXI17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiHXI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:27:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0426E93230;
        Wed, 24 Aug 2022 01:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AC0CB8238E;
        Wed, 24 Aug 2022 08:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C61C433B5;
        Wed, 24 Aug 2022 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661329661;
        bh=Cswsg5zwfQnIxDqhYpbvzbjzMba7/Q3SMHSTlIl4nr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rns/zYsL6l6/nzNgn6OPoDzXGQ9O4PkTAx4ahpmezNfDqJO5X2igsp3OWb0tBrUgL
         od/SBuxqloB/0+k6Urdah49vznJ4jlaF2N1un/Vmv/dW6hpLveHekjs3OZ0vOjybsh
         2lBgIS7aVUUfSARtNBrmNU2YUMqim/pgq/fTwmh0HxyLBN2gncoWfD3bjvag7iF/4+
         WRbUtcdS9S8cgb7z2nfnIHDgObqFywt5sNHEUAus1Qu2RcGBDu0YXI9qRQj07cVa2S
         7lKCYTdMROFIuwSV0YKqE4WBDL0gEGJuptFAYhF1V2/XnIh0yJTNkNFGOzG1f8wfC0
         vU9YZHWbf+zbw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQljk-0003G4-4G; Wed, 24 Aug 2022 10:27:44 +0200
Date:   Wed, 24 Aug 2022 10:27:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: keep PHYs disabled during suspend
Message-ID: <YwXhANZ8l6E9yQDe@hovoldconsulting.com>
References: <20220823124047.14634-1-johan+linaro@kernel.org>
 <YwUdbkyL8GgvLQJA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwUdbkyL8GgvLQJA@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:33:18AM -0700, Matthias Kaehlcke wrote:
> Hi Johan,
> 
> On Tue, Aug 23, 2022 at 02:40:47PM +0200, Johan Hovold wrote:
> > Commit 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system
> > suspend") started leaving the PHYs enabled during suspend for
> > wakeup-capable controllers even though it turns out this had nothing to
> > do with wakeup.
> > 
> > Rather, the wakeup capability flag was (ab-)used as a proxy to configure
> > the suspend behaviour in an attempt to reduce power leakage on some
> > platforms.
> > 
> > Stop abusing the wakeup configuration and restore the 5.19 behaviour of
> > keeping the PHYs powered off during suspend. If needed, a dedicated
> > mechanism for configuring the PHY power state during suspend can be
> > added later.
> > 
> > Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
> > Link: https://lore.kernel.org/r/Yuv7AM/5jtO/pgcm@google.com
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/usb/dwc3/core.c      | 4 ++--
> >  drivers/usb/dwc3/dwc3-qcom.c | 1 -
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 8c8e32651473..0cdb6be720e1 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1983,7 +1983,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> >  		dwc3_core_exit(dwc);
> >  		break;
> >  	case DWC3_GCTL_PRTCAP_HOST:
> > -		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
> > +		if (!PMSG_IS_AUTO(msg)) {
> 
> My assumption was that the PHYs need to be powered for wakeup to work, but
> apparently that isn't the case, wakeup still works on sc7x80 with this part
> of this patch.

Thanks for confirming.

> >  			dwc3_core_exit(dwc);
> >  			break;
> >  		}
> > @@ -2044,7 +2044,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
> >  		spin_unlock_irqrestore(&dwc->lock, flags);
> >  		break;
> >  	case DWC3_GCTL_PRTCAP_HOST:
> > -		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
> > +		if (!PMSG_IS_AUTO(msg)) {
> >  			ret = dwc3_core_init_for_resume(dwc);
> >  			if (ret)
> >  				return ret;
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > index 9a94b1ab8f7a..9995395baa12 100644
> > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > @@ -904,7 +904,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  
> >  	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
> >  	device_init_wakeup(&pdev->dev, wakeup_source);
> > -	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);
> 
> Surprisingly this part breaks wakeup on sc7x80, with the above removal
> of the device_may_wakeup() checks it is not clear to me why wakeup needs
> to be enabled for the core.

I can't explain that behaviour either. This change doesn't affect the
wakeup_path flag and genpd, and notably wakeup still works here with
sc8280xp.

Could it be some Chromium user-space issue in that it expects all
devices on the wakeup path to be wakeup capable? Note that the
xhci-plat driver (e.g. for the descendant xhci-hcd.1.auto device)
unconditionally sets the wakeup-capable flag (but leaves it disabled by
default).

I guess we could do something similar for the dwc3 core device, but we'd
need to figure out if and why that is at all needed first.

Can you verify that the wakeup source (e.g. keyboard) you're using still
has power/wakeup set to "enabled"?

Johan
