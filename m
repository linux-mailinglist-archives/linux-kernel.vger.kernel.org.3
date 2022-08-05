Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C366D58AE8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiHEQ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiHEQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:58:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FAC32EE6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:58:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d20so2749162pfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NLL4kuBidHriDUaqB19TDC7qVADAhdtdEXtTU+ALk1g=;
        b=VwCflNCyLVK0cRq6ez8k/kWlkQt39RDyyM3xqDtoNqO3prRLwRyvdWmPyRAYXOG/ai
         bW9A+EPg0MKIYvipEW7R9IAHNSR/sQ0mShwHkUK3KpIBDn6I1SxJnmOn1WrpBuzNl6mL
         TmB6tfS4voluBQtDyeCXUYtZDJ2V8jHb0Nvlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NLL4kuBidHriDUaqB19TDC7qVADAhdtdEXtTU+ALk1g=;
        b=t+OFFqCfVs4VHz/BGM5YLVmYRf9guhQdTpqY/IXyPL7/RlzDEtQ5UUqNI3J2XMZml+
         OgvE2c1zSW91IZ+BorpnuIHADnHqSBnH4W4OIPgSn2ttgXWiHj7h2giGGVuvapLvVH0H
         xupALdSO7rxj1gYBXNyXWftPWUBeTsEtxJs81rytH2Tx4sjQzxFVR2pdby7vbvjYVqMc
         wKJ7K3fbc2qXnCKlWP4eQNgooE4aNxC5GiYv4cAfhxJRMFq9h0Wz4k5LQLqNnWaNtzHk
         oaPaAoaIZZOFsMVCTBNOeafGV6ugjbrJhg9oK8kwRnNxLEIrf1WGfmIlmT97uVkAA7dB
         rJVw==
X-Gm-Message-State: ACgBeo23l7R6F+u8erFkOao5dbCQTTgQZxFAkuaXhmjggjwIQIDjB++l
        vwop+V9ID8igS8jVNoTncancOw==
X-Google-Smtp-Source: AA6agR5LIQMCQBvNRt+MvSw1Bjie4tB4pIfmXGfohcD6qzFKTWPaXDtJ0ZEuoTKXdc0OS7pDpULshg==
X-Received: by 2002:a65:6bcb:0:b0:412:a68d:1083 with SMTP id e11-20020a656bcb000000b00412a68d1083mr6515872pgw.456.1659718718248;
        Fri, 05 Aug 2022 09:58:38 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c59c:1680:614c:3338])
        by smtp.gmail.com with UTF8SMTPSA id u11-20020a17090341cb00b0016be14a776asm3211086ple.286.2022.08.05.09.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 09:58:37 -0700 (PDT)
Date:   Fri, 5 Aug 2022 09:58:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <Yu1MO9sgPslEDAjR@google.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-9-johan+linaro@kernel.org>
 <Yuv7AM/5jtO/pgcm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yuv7AM/5jtO/pgcm@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 09:59:44AM -0700, Matthias Kaehlcke wrote:
> On Thu, Aug 04, 2022 at 05:10:00PM +0200, Johan Hovold wrote:
> > It is the Qualcomm glue wakeup interrupts that may be able to wake the
> > system from suspend and this can now be described in the devicetree.
> > 
> > Move the wakeup-source property handling over from the core driver and
> > instead propagate the capability setting to the core device during
> > probe.
> > 
> > This is needed as there is currently no way for the core driver to query
> > the wakeup setting of the glue device, but it is the core driver that
> > manages the PHY power state during suspend.
> > 
> > Also don't leave the PHYs enabled when system wakeup has been disabled
> > through sysfs.
> > 
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
> 
> Let me explain the rationale for why device_can_wakeup() was used here:
> 
> On QCOM SC7180 based Chromebooks we observe that the onboard USB hub consumes
> ~80 mW during system suspend when the PHYs are disabled, as opposed to ~17 mW
> when the PHYs remain enabled. This is a significant delta when the device is
> on a battery power.
> 
> The initial idea was to leave the PHYs always enabled (in a low power mode),
> but then I dug up commit c4a5153e87fd ("usb: dwc3: core: Power-off core/PHYs
> on system_suspend in host mode"), which provides a rationale for the PHYs
> being powered off:
> 
>   Commit 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during
>   host bus-suspend/resume") updated suspend/resume routines to not
>   power_off and reinit PHYs/core for host mode.
>   It broke platforms that rely on DWC3 core to power_off PHYs to
>   enter low power state on system suspend.
> 
> Unfortunately we don't know which platforms are impacted by this. The idea
> behind using device_can_wakeup() was to use it as a proxy for platforms
> that are *not* impacted. If a platform supports USB wakeup supposedly the
> SoC can enter its low power mode during system suspend with the PHYs
> enabled.
> 
> By now I'm not 100% sure if the above assumption is correct. I recently
> saw allegations that the power consumption of a given QC SoC with USB
> wakeup support drops significantly when wakeup is disabled (i.e. when
> the PHYs are off), but haven't confirmed this yet.

So far power measurements don't support the claim that SoC power
consumption is substantially lower with USB wakeup disabled/the PHYs
off. I asked the person who made that claim to provide more
details/data (the discussion is in an internal forum).
