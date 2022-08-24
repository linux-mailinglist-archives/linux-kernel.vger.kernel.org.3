Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972AA59FFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiHXQnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiHXQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:41:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0114D2D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:41:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m15so9573396pjj.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6UQFQzWIMsXO0TvDttsqfOV0v+YnUpw24yC7SfNzNmc=;
        b=mYDsAVW1aU4k8MheXoibjYixBApob+/Ft5F8QdMk3X+LrTO6NuWOLhy3xipx/kwxyv
         pW1fBs3gHKCNr9NF8WU8pt2/knAWGD+HwKoxBSMO+hu1oMgC4stVT4NFG06IXNvARd2+
         xPuCa6Og0kJAKoVFkGfnyLuhgL9UApXPYo4sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6UQFQzWIMsXO0TvDttsqfOV0v+YnUpw24yC7SfNzNmc=;
        b=FbHJSzgLD0RxB6nAKs/jjAV2o/PLTBwAcgBkoM3rfljPgVRpwGl1gllwIwZSG8EEbU
         d3pX2qfEUIZ0jr86Hpy7DLLW7A0brhK8nuG4C0WYOB1Wx1H8nBgGsTSDC43CY8rqFOfi
         N+RMgpcUP2y1hnOs0K62GnLs5wfh2CoRVzNDH6MPDxmcgctRziVdTVIpym5m1tvDaiSn
         h/7cZ9wHVvjj/l+xz5o23CSfcWHBfBp18aypEbMtovyeqlOjw1uB07dZOAh9kzUQm+mI
         UsLrcTVxDA/+rdxOQBiC0CdXfFdkP8rzEKuLaebm3suqIQrCjdcYpAAAzxH5iA70bs3v
         wu9Q==
X-Gm-Message-State: ACgBeo2wKmQwQEa10Qt5Qc5we8PEIP8wmCbbXRRfCK/NDGsK3j3C/EUa
        4Bfgw3MZBcDktPMyaYy37D+qYlCOXFNHng==
X-Google-Smtp-Source: AA6agR4Ox2+16RSl4/g10D50pDnJ0eAEz01Nnp/jLZOFEVTkg4IYINoxfPssWRQvepPRPq9b5eTy2w==
X-Received: by 2002:a17:902:e88c:b0:172:cf6c:2801 with SMTP id w12-20020a170902e88c00b00172cf6c2801mr21261555plg.114.1661359312427;
        Wed, 24 Aug 2022 09:41:52 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:fba3:9861:f694:5325])
        by smtp.gmail.com with UTF8SMTPSA id t15-20020a1709027fcf00b0016d5428f041sm12740625plb.199.2022.08.24.09.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 09:41:52 -0700 (PDT)
Date:   Wed, 24 Aug 2022 09:41:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <YwZUzeCTw2BupuMm@google.com>
References: <20220823124047.14634-1-johan+linaro@kernel.org>
 <YwUdbkyL8GgvLQJA@google.com>
 <YwXhANZ8l6E9yQDe@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwXhANZ8l6E9yQDe@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:27:44AM +0200, Johan Hovold wrote:
> On Tue, Aug 23, 2022 at 11:33:18AM -0700, Matthias Kaehlcke wrote:
> > Hi Johan,
> > 
> > On Tue, Aug 23, 2022 at 02:40:47PM +0200, Johan Hovold wrote:
> > > Commit 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system
> > > suspend") started leaving the PHYs enabled during suspend for
> > > wakeup-capable controllers even though it turns out this had nothing to
> > > do with wakeup.
> > > 
> > > Rather, the wakeup capability flag was (ab-)used as a proxy to configure
> > > the suspend behaviour in an attempt to reduce power leakage on some
> > > platforms.
> > > 
> > > Stop abusing the wakeup configuration and restore the 5.19 behaviour of
> > > keeping the PHYs powered off during suspend. If needed, a dedicated
> > > mechanism for configuring the PHY power state during suspend can be
> > > added later.
> > > 
> > > Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
> > > Link: https://lore.kernel.org/r/Yuv7AM/5jtO/pgcm@google.com
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/usb/dwc3/core.c      | 4 ++--
> > >  drivers/usb/dwc3/dwc3-qcom.c | 1 -
> > >  2 files changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 8c8e32651473..0cdb6be720e1 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -1983,7 +1983,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >  		dwc3_core_exit(dwc);
> > >  		break;
> > >  	case DWC3_GCTL_PRTCAP_HOST:
> > > -		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
> > > +		if (!PMSG_IS_AUTO(msg)) {
> > 
> > My assumption was that the PHYs need to be powered for wakeup to work, but
> > apparently that isn't the case, wakeup still works on sc7x80 with this part
> > of this patch.
> 
> Thanks for confirming.
> 
> > >  			dwc3_core_exit(dwc);
> > >  			break;
> > >  		}
> > > @@ -2044,7 +2044,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
> > >  		spin_unlock_irqrestore(&dwc->lock, flags);
> > >  		break;
> > >  	case DWC3_GCTL_PRTCAP_HOST:
> > > -		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
> > > +		if (!PMSG_IS_AUTO(msg)) {
> > >  			ret = dwc3_core_init_for_resume(dwc);
> > >  			if (ret)
> > >  				return ret;
> > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > > index 9a94b1ab8f7a..9995395baa12 100644
> > > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > > @@ -904,7 +904,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
> > >  
> > >  	wakeup_source = of_property_read_bool(dev->of_node, "wakeup-source");
> > >  	device_init_wakeup(&pdev->dev, wakeup_source);
> > > -	device_init_wakeup(&qcom->dwc3->dev, wakeup_source);
> > 
> > Surprisingly this part breaks wakeup on sc7x80, with the above removal
> > of the device_may_wakeup() checks it is not clear to me why wakeup needs
> > to be enabled for the core.
> 
> I can't explain that behaviour either. This change doesn't affect the
> wakeup_path flag and genpd, and notably wakeup still works here with
> sc8280xp.
> 
> Could it be some Chromium user-space issue in that it expects all
> devices on the wakeup path to be wakeup capable? Note that the
> xhci-plat driver (e.g. for the descendant xhci-hcd.1.auto device)
> unconditionally sets the wakeup-capable flag (but leaves it disabled by
> default).
> 
> I guess we could do something similar for the dwc3 core device, but we'd
> need to figure out if and why that is at all needed first.
> 
> Can you verify that the wakeup source (e.g. keyboard) you're using still
> has power/wakeup set to "enabled"?

I confirmed that the wakeup flag of the wakeup source is still enabled when
the wakeup source suspends.

It turns out the dwc3 core wakeup flags are evaluated by:

	int usb_phy_roothub_suspend(struct device *controller_dev,
	                            struct usb_phy_roothub *phy_roothub)
	{
		usb_phy_roothub_power_off(phy_roothub);

		/* keep the PHYs initialized so the device can wake up the system */
		if (device_may_wakeup(controller_dev))
			return 0;

		return usb_phy_roothub_exit(phy_roothub);
	}

'controller_dev' is the dwc3 core. The root hub is un-initialized when wakeup is
disabled. That causes wakeup to fail, and also happens to be the/one cause of
the high power consumption of an onboard USB hub that I mentioned earlier in
another thread.
