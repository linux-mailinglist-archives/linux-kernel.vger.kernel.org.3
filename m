Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EAE5897AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiHDGLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiHDGLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:11:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE5661125;
        Wed,  3 Aug 2022 23:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0B69B8249A;
        Thu,  4 Aug 2022 06:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D482C433D6;
        Thu,  4 Aug 2022 06:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659593508;
        bh=PivNYhd22ovz+3c6fY+dmZ86T6hM9cCpwWw+EopqWP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myg4Gp10acovpgRnnfSKryNqfyVKKViZXK1u0deeL6F4aa6LZ1N8UL9QvwaJ28yo6
         Fygt4uhFxm94uQ3uytn+h5rZBQrvX42egEhWguL0i4eMWtdzmxUUVbcFpe8j/kuHUE
         GxhRYhdEqCmH5o4J4UNNMJMesufhU34SS+FV2S775wjtDUa9bYfFG4oIwZL/2EzXgk
         zIAUZ1SOLoAqvsPvV6TeFTUTrzCXk4mOxCnKH8rXVzbAKbUEOzgh/yyKbwY/TsdMSq
         M8vIZwBt0mweADhcme2s4WcaM++IClUfe1aX+HC24qXMFnMGINPsjFZsElpDisrr0L
         xzgTkGurmr1/g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJU5Y-0003e7-4q; Thu, 04 Aug 2022 08:12:08 +0200
Date:   Thu, 4 Aug 2022 08:12:08 +0200
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
Subject: Re: [PATCH 3/8] usb: dwc3: qcom: fix broken non-host-mode suspend
Message-ID: <YutjOESZRD+4mr3Z@hovoldconsulting.com>
References: <20220802151404.1797-1-johan+linaro@kernel.org>
 <20220802151404.1797-4-johan+linaro@kernel.org>
 <YurIbcXHPF6K3oPa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YurIbcXHPF6K3oPa@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 12:11:41PM -0700, Matthias Kaehlcke wrote:
> On Tue, Aug 02, 2022 at 05:13:59PM +0200, Johan Hovold wrote:
> > A recent commit implementing wakeup support in host mode instead broke
> > suspend for peripheral and OTG mode.
> > 
> > The hack that was added in the suspend path to determine the speed of
> > any device connected to the USB2 bus not only accesses internal driver
> > data for a child device, but also dereferences a NULL pointer when not
> > in host mode and there is no HCD.
> > 
> > As the controller can switch role at any time when in OTG mode, there's
> > no quick fix to this, and since reverting would leave us with broken
> > suspend in host-mode (wakeup triggers immediately), keep the hack for
> > now and only fix the NULL-pointer dereference.
> > 
> > Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/usb/dwc3/dwc3-qcom.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > index be2e3dd36440..b75ff40f75a2 100644
> > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > @@ -301,8 +301,17 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
> >  static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> >  {
> >  	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> > -	struct usb_hcd *hcd = platform_get_drvdata(dwc->xhci);
> >  	struct usb_device *udev;
> > +	struct usb_hcd *hcd;
> > +
> > +	if (qcom->mode != USB_DR_MODE_HOST)
> > +		return USB_SPEED_UNKNOWN;
> 
> Couldn't instead the below block in dwc3_qcom_suspend() be conditional on
> the controller being in host mode?
> 
> 	if (device_may_wakeup(qcom->dev)) {
> 		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
> 		dwc3_qcom_enable_interrupts(qcom);
> 	}

Yeah, the authors clearly didn't consider non-host mode when
implementing this and keeping wakeups disabled in that case probably
doesn't break anything that was ever working.

> I see, the problem is that the role switch could happen at any time as the
> commit message says. With this patch there is also a race though, the role
> switch could happen just after the check and before obtaining 'hcd'.

No, there's no race here as I'm checking the static configuration that
comes from DT. Specifically, I'm not trying to add support for wakeup in
OTG mode, but just prevent suspend from crashing.

I may be possible address also the host-role in OTG mode, but that means
continuing to build on this layer violation.

Note that we're in the suspend callback of the parent so as long as the
drivers for the descendant devices has disabled role switching at this
stage during suspend, we should be good.

But I'm torn about simply ripping this patch out and trying to fix it
up. I want the feature, but the patch adding this clearly wasn't ready
for merging.

I'll take another look at this.

Johan
