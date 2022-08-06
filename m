Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26758B6D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiHFQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiHFQcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E029FD22;
        Sat,  6 Aug 2022 09:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA45C61192;
        Sat,  6 Aug 2022 16:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00EDC433C1;
        Sat,  6 Aug 2022 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659803566;
        bh=nExtxcU67wWQEEy3txkAlZxXlPijgKhaUiJHYPpUROI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2WctJ1Lb1oLCpqQKx2wa6a1Xy4t5fVBNZOujhC/kiNzq3TrmwKiRiczzAN0y3j32
         gSt9eXNYOvRBPzdY4drngIApYb8RSfOOJocp2zJEpTzzL06l4ycVNjBTC9HzLcQCh6
         bSp/AZBTx8w8Ddst9SWUH/Hzz4y555e0eWKo9ij4wiwbIXZQMDtV0UVwg+yXqekaH6
         6kcSkkFaZn2/3Sudr1t4BYhqtzXRaYgC2CzAI8YxFr8D5BPHejWhdyN6x3D739ORWv
         HSMwEUaHVPqwd9/B9vQgJiaZfB3VDUId1H6wvA74wG9S+jDnW08+qJOum++5WIvg+o
         cCMy07rIiWGSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oKMjg-0003QW-Gq; Sat, 06 Aug 2022 18:33:13 +0200
Date:   Sat, 6 Aug 2022 18:33:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] usb: dwc3: qcom: fix wakeup implementation
Message-ID: <Yu6XyIZT9XU2Qs4l@hovoldconsulting.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-9-johan+linaro@kernel.org>
 <20220806145719.GG14384@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806145719.GG14384@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 08:27:19PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Aug 04, 2022 at 05:10:00PM +0200, Johan Hovold wrote:
> > It is the Qualcomm glue wakeup interrupts that may be able to wake the
> > system from suspend and this can now be described in the devicetree.
> > 
> > Move the wakeup-source property handling over from the core driver and
> > instead propagate the capability setting to the core device during
> > probe.

> The "wakeup-source" property is still defined in the DWC binding, so other
> platform glue drivers are free to assume that wakeup capability is handled by
> the DWC driver.

No, just because the binding says that the hardware supports something
doesn't mean it's implemented. And in this case it isn't.

There's no core support for wakeup and this is just used to determine
the PHY power state during suspend (see my reply to Matthias).

But this is also why I initially suggested reverting the binding change
until some platform actually turns out to need it.
 
> > This is needed as there is currently no way for the core driver to query
> > the wakeup setting of the glue device, but it is the core driver that
> > manages the PHY power state during suspend.
> > 
> > Also don't leave the PHYs enabled when system wakeup has been disabled
> > through sysfs.
> > 
> 
> Can you please elaborate on how this is handled in the patch?

Generally device_can_wakeup() should not be used to make policy
decisions (e.g. whether to power of the PHYs) as this should be
configurable through sysfs which is honoured by device_may_wakeup().

But I'll revisit this in a couple of weeks. We should probably just
revert the patch that made the PHY power state depend on
device_can_wakeup() as it apparently isn't needed for wakeup at all.

> > Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/usb/dwc3/core.c      | 5 ++---
> >  drivers/usb/dwc3/dwc3-qcom.c | 6 +++++-
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 16d1f328775f..8c8e32651473 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1822,7 +1822,6 @@ static int dwc3_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, dwc);
> >  	dwc3_cache_hwparams(dwc);
> > -	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
> >  
> >  	spin_lock_init(&dwc->lock);
> >  	mutex_init(&dwc->mutex);
> > @@ -1984,7 +1983,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> >  		dwc3_core_exit(dwc);
> >  		break;
> >  	case DWC3_GCTL_PRTCAP_HOST:
> > -		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
> > +		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
> >  			dwc3_core_exit(dwc);
> >  			break;
> >  		}
> > @@ -2045,7 +2044,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
> >  		spin_unlock_irqrestore(&dwc->lock, flags);
> >  		break;
> >  	case DWC3_GCTL_PRTCAP_HOST:
> > -		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
> > +		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
> >  			ret = dwc3_core_init_for_resume(dwc);
> >  			if (ret)
> >  				return ret;
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > index 6ae0b7fc4e2c..b05f67d206d2 100644
> > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > @@ -786,6 +786,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  	struct resource		*res, *parent_res = NULL;
> >  	int			ret, i;
> >  	bool			ignore_pipe_clk;
> > +	bool			wakeup_source;
> >  
> >  	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
> >  	if (!qcom)
> > @@ -901,7 +902,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto interconnect_exit;
> >  
> > -	device_init_wakeup(&pdev->dev, 1);
> > +	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
> > +	device_init_wakeup(&pdev->dev, wakeup_source);
> > +	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);
> > +
> >  	qcom->is_suspended = false;
> >  	pm_runtime_set_active(dev);
> >  	pm_runtime_enable(dev);
> > -- 
> > 2.35.1

Johan
