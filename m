Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2C58CCA3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiHHRWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiHHRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:22:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5AB15FF8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:22:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h132so9137834pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ISRmfPuzAq5iPA9W7SoAaYtOXEzjnhWi555d7SJED8=;
        b=nY3cdk1gWCUthARunn+1V5ONlEaJCy1aeQA+5MIdzACrZnvUMxuvRRGrBP8vmXW716
         KEwygp7xRisTAS1k8qmj7xeHcaG4KkSGfbHhM8pBHkUFiJaS/v3cwWb9su+SqtTlAZu/
         k3I2I1qk80aFlw2YsI5Ai9QRQDlq/U3MgxLDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ISRmfPuzAq5iPA9W7SoAaYtOXEzjnhWi555d7SJED8=;
        b=UnLUxFt/S4xppRAAY1NLHHTiMHL2erwd300vzMiU74sGLQCltApVs0NojRJJLZ2I0d
         KnmGP0ARHQKyA5k7UvxejoYCXhWlvoeVg+bmPTL7qHjEkFflx3o4cFdFNtifH3Atja6t
         IDZe/DwMT821xU4IKY2UebopfdLuZ6jAuLyR9lrADJmm8Ck1zeeFkh6eWJ3x5al+iJQr
         u4aOZZ6JreLN8VpRTt/Gcoo+SI39ztW2DyiDDcfeTh8Rr7eIZoZa6RuGIkrLhS27qDMm
         ZsgzFZoCBnYmRJc/nKdvix3/8IMhukEDntLtdGLhmE5rl9eKEl9Jn0N60AgD1lP1bQXr
         y1HQ==
X-Gm-Message-State: ACgBeo3iJpjZbufbDFOfAWQT5U3xC7gQoDiaAxNjYIkIGR8utUey8z2E
        UK6vL5ZvA152pwmoRke3fGt09Q==
X-Google-Smtp-Source: AA6agR66v0hA8Eemx2dKzdaVrT6+rtDHvVGdEsmUWrdfx899jKGr/hzPQxI3VEKvhRUidNhEM1Uhzg==
X-Received: by 2002:a63:2244:0:b0:41d:a9c4:e83 with SMTP id t4-20020a632244000000b0041da9c40e83mr1943438pgm.271.1659979331250;
        Mon, 08 Aug 2022 10:22:11 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:7a1:96b:e08b:5ba0])
        by smtp.gmail.com with UTF8SMTPSA id cp2-20020a170902e78200b0016db7f49cc2sm9008576plb.115.2022.08.08.10.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 10:22:10 -0700 (PDT)
Date:   Mon, 8 Aug 2022 10:22:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <YvFGP90eyXoPbcy8@google.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-9-johan+linaro@kernel.org>
 <Yuv7AM/5jtO/pgcm@google.com>
 <Yu1MO9sgPslEDAjR@google.com>
 <Yu6VTYn2/cG79dvl@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yu6VTYn2/cG79dvl@hovoldconsulting.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 06:22:37PM +0200, Johan Hovold wrote:
> On Fri, Aug 05, 2022 at 09:58:35AM -0700, Matthias Kaehlcke wrote:
> > On Thu, Aug 04, 2022 at 09:59:44AM -0700, Matthias Kaehlcke wrote:
> > > On Thu, Aug 04, 2022 at 05:10:00PM +0200, Johan Hovold wrote:
> > > > It is the Qualcomm glue wakeup interrupts that may be able to wake the
> > > > system from suspend and this can now be described in the devicetree.
> > > > 
> > > > Move the wakeup-source property handling over from the core driver and
> > > > instead propagate the capability setting to the core device during
> > > > probe.
> > > > 
> > > > This is needed as there is currently no way for the core driver to query
> > > > the wakeup setting of the glue device, but it is the core driver that
> > > > manages the PHY power state during suspend.
> > > > 
> > > > Also don't leave the PHYs enabled when system wakeup has been disabled
> > > > through sysfs.
> > > > 
> > > > Fixes: 649f5c842ba3 ("usb: dwc3: core: Host wake up support from system suspend")
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > ---
> > > >  drivers/usb/dwc3/core.c      | 5 ++---
> > > >  drivers/usb/dwc3/dwc3-qcom.c | 6 +++++-
> > > >  2 files changed, 7 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index 16d1f328775f..8c8e32651473 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -1822,7 +1822,6 @@ static int dwc3_probe(struct platform_device *pdev)
> > > >  
> > > >  	platform_set_drvdata(pdev, dwc);
> > > >  	dwc3_cache_hwparams(dwc);
> > > > -	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
> > > >  
> > > >  	spin_lock_init(&dwc->lock);
> > > >  	mutex_init(&dwc->mutex);
> > > > @@ -1984,7 +1983,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > >  		dwc3_core_exit(dwc);
> > > >  		break;
> > > >  	case DWC3_GCTL_PRTCAP_HOST:
> > > > -		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
> > > > +		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
> > > 
> > > Let me explain the rationale for why device_can_wakeup() was used here:
> > > 
> > > On QCOM SC7180 based Chromebooks we observe that the onboard USB hub consumes
> > > ~80 mW during system suspend when the PHYs are disabled, as opposed to ~17 mW
> > > when the PHYs remain enabled. This is a significant delta when the device is
> > > on a battery power.
> > > 
> > > The initial idea was to leave the PHYs always enabled (in a low power mode),
> > > but then I dug up commit c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs
> > > on system_suspend in host mode"), which provides a rationale for the PHYs
> > > being powered off:
> > > 
> > >   Commit 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during
> > >   host bus-suspend/resume") updated suspend/resume routines to not
> > >   power_off and reinit PHYs/core for host mode.
> > >   It broke platforms that rely on DWC3 core to power_off PHYs to
> > >   enter low power state on system suspend.
> > > 
> > > Unfortunately we don't know which platforms are impacted by this. The idea
> > > behind using device_can_wakeup() was to use it as a proxy for platforms
> > > that are *not* impacted. If a platform supports USB wakeup supposedly the
> > > SoC can enter its low power mode during system suspend with the PHYs
> > > enabled.
> > > 
> > > By now I'm not 100% sure if the above assumption is correct. I recently
> > > saw allegations that the power consumption of a given QC SoC with USB
> > > wakeup support drops significantly when wakeup is disabled (i.e. when
> > > the PHYs are off), but haven't confirmed this yet.
> > 
> > So far power measurements don't support the claim that SoC power
> > consumption is substantially lower with USB wakeup disabled/the PHYs
> > off. I asked the person who made that claim to provide more
> > details/data (the discussion is in an internal forum).
> 
> Thanks for the background on this. So clearly it has nothing to with
> supporting wakeup as the commit summary claimed, and this should
> probably never have been made to depend on wakeup capability either.

To be clear, there are two different (supposed) impacts on suspend power:

1. with the PHYs powered off an onboard hub on SC7180/SC7280 boards draws
   ~80mW during system suspend, vs. ~17mW with the PHYs being on. This is
   confirmed.

   For SC7180/SC7280 Chrome OS boards in particular it would be ok to
   power the PHYs off based on device_may_wakeup(), since Chrome OS
   leaves USB wakeup enabled, hence the PHYs would remain powered as
   desired.

   However boards that opt for disabling USB wakeup could be impacted
   by increased power consumption of USB peripherals, as seen with the
   hub of SC7180/SC7280 Chrome OS boards.

2. with the PHYs on during system suspend allegedly some QC SoCs can't
   reach their lowest power mode (commit c4a5153e87fd). I don't know
   which SoCs are impacted.

   Someone from QC claims that SC7280 has significantly lower power
   consumption with "USB wakeup disabled", so far this has not been
   confirmed by my colleague who takes power measurements, I'm in
   the process of clarifying what "USB wakeup disabled" exactly
   means in this context (e.g. no wakeup source flag vs. no wakeup
   capable device plugged).

> I'll revisit this after the merge window, but perhaps we should just rip
> this out completely and use a more descriptive property to configure the
> PHY suspend state. But depending on the results from your internal
> measurements, perhaps not even that is needed.

Ok, I'll keep you posted on power findings on our side, though that will
only cover SC7180/SC7280.
