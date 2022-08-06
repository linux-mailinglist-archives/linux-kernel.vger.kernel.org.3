Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B76458B6C3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiHFQWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiHFQWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD111154;
        Sat,  6 Aug 2022 09:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D190F61154;
        Sat,  6 Aug 2022 16:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EEAC433D6;
        Sat,  6 Aug 2022 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659802931;
        bh=B6rbe4yCofemCFAJcjJszIFDl+tuNOh58ShiJfQERfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQilBDDy3mJ0lGbi2LYchi2RNGI/D3IN7mXfAZc2sDnY5ohY4W97tTUIdDUp+smhy
         IQ+aGYBUXfmRtCgrZXlXl4VN1pF/rCRUa//m3ZEccN2aBLN1SE77tkhXRYfz6yQaNw
         KJgNuFeeMNouU20BuZF3AADuYmjv5g1/iMj7rQaYHpoxAwYqUplZ3pFV+6GVsl2Rfj
         curCJLgBzOnKRtBQO80pS6hwSahuZg0WBCDhTsZcslM+on4GKU1RHDG67AB8brfild
         NlEfAfFXNMLhuCY0ycpxPn+w+KtY3s5V9C3o2zxorQAHaStssfIBYH2uWf9fP0eE8Q
         qOQR5qR9lEJlQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oKMZR-0003Nm-P6; Sat, 06 Aug 2022 18:22:38 +0200
Date:   Sat, 6 Aug 2022 18:22:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] usb: dwc3: qcom: fix wakeup implementation
Message-ID: <Yu6VTYn2/cG79dvl@hovoldconsulting.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-9-johan+linaro@kernel.org>
 <Yuv7AM/5jtO/pgcm@google.com>
 <Yu1MO9sgPslEDAjR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu1MO9sgPslEDAjR@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 09:58:35AM -0700, Matthias Kaehlcke wrote:
> On Thu, Aug 04, 2022 at 09:59:44AM -0700, Matthias Kaehlcke wrote:
> > On Thu, Aug 04, 2022 at 05:10:00PM +0200, Johan Hovold wrote:
> > > It is the Qualcomm glue wakeup interrupts that may be able to wake the
> > > system from suspend and this can now be described in the devicetree.
> > > 
> > > Move the wakeup-source property handling over from the core driver and
> > > instead propagate the capability setting to the core device during
> > > probe.
> > > 
> > > This is needed as there is currently no way for the core driver to query
> > > the wakeup setting of the glue device, but it is the core driver that
> > > manages the PHY power state during suspend.
> > > 
> > > Also don't leave the PHYs enabled when system wakeup has been disabled
> > > through sysfs.
> > > 
> > > Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/usb/dwc3/core.c      | 5 ++---
> > >  drivers/usb/dwc3/dwc3-qcom.c | 6 +++++-
> > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 16d1f328775f..8c8e32651473 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -1822,7 +1822,6 @@ static int dwc3_probe(struct platform_device *pdev)
> > >  
> > >  	platform_set_drvdata(pdev, dwc);
> > >  	dwc3_cache_hwparams(dwc);
> > > -	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
> > >  
> > >  	spin_lock_init(&dwc->lock);
> > >  	mutex_init(&dwc->mutex);
> > > @@ -1984,7 +1983,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >  		dwc3_core_exit(dwc);
> > >  		break;
> > >  	case DWC3_GCTL_PRTCAP_HOST:
> > > -		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
> > > +		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
> > 
> > Let me explain the rationale for why device_can_wakeup() was used here:
> > 
> > On QCOM SC7180 based Chromebooks we observe that the onboard USB hub consumes
> > ~80 mW during system suspend when the PHYs are disabled, as opposed to ~17 mW
> > when the PHYs remain enabled. This is a significant delta when the device is
> > on a battery power.
> > 
> > The initial idea was to leave the PHYs always enabled (in a low power mode),
> > but then I dug up commit c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs
> > on system_suspend in host mode"), which provides a rationale for the PHYs
> > being powered off:
> > 
> >   Commit 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during
> >   host bus-suspend/resume") updated suspend/resume routines to not
> >   power_off and reinit PHYs/core for host mode.
> >   It broke platforms that rely on DWC3 core to power_off PHYs to
> >   enter low power state on system suspend.
> > 
> > Unfortunately we don't know which platforms are impacted by this. The idea
> > behind using device_can_wakeup() was to use it as a proxy for platforms
> > that are *not* impacted. If a platform supports USB wakeup supposedly the
> > SoC can enter its low power mode during system suspend with the PHYs
> > enabled.
> > 
> > By now I'm not 100% sure if the above assumption is correct. I recently
> > saw allegations that the power consumption of a given QC SoC with USB
> > wakeup support drops significantly when wakeup is disabled (i.e. when
> > the PHYs are off), but haven't confirmed this yet.
> 
> So far power measurements don't support the claim that SoC power
> consumption is substantially lower with USB wakeup disabled/the PHYs
> off. I asked the person who made that claim to provide more
> details/data (the discussion is in an internal forum).

Thanks for the background on this. So clearly it has nothing to with
supporting wakeup as the commit summary claimed, and this should
probably never have been made to depend on wakeup capability either.

I'll revisit this after the merge window, but perhaps we should just rip
this out completely and use a more descriptive property to configure the
PHY suspend state. But depending on the results from your internal
measurements, perhaps not even that is needed.

Johan
