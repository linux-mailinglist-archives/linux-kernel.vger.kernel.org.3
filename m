Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5D598AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbiHRRon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245444AbiHRRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:44:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200696DF83;
        Thu, 18 Aug 2022 10:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2A0061483;
        Thu, 18 Aug 2022 17:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9FFC433D6;
        Thu, 18 Aug 2022 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660844671;
        bh=F0dLsyFk+o04xQlOLvO9/Ou9gm/M3ttHAiXvV1wwzFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xAmI1EyszQXo/zES8oOcW78m1v9hPkneNL/rjhzSZ9vcX+mr3e9hDWl1mEwUqAZZE
         QT3SQTI+ZC4OvKT3hwqJbnhVbthdhfnF9gjCZicApPv1s9PLqQ06nusOsIPkftvmBQ
         RZ5XuI9CVOdHuIh1osj/84BrTy6ageTDQaLCEceM=
Date:   Thu, 18 Aug 2022 19:44:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
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
        Matthias Kaehlcke <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/9] usb: dwc3: qcom: fix gadget-only builds
Message-ID: <Yv56fFpuUsxCSxJ8@kroah.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-4-johan+linaro@kernel.org>
 <YvEKIJ+GujHt7XvT@kroah.com>
 <YvEQ0hpTRvAPStHU@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvEQ0hpTRvAPStHU@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 03:34:10PM +0200, Johan Hovold wrote:
> On Mon, Aug 08, 2022 at 03:05:36PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 04, 2022 at 05:09:55PM +0200, Johan Hovold wrote:
> > > A recent change added a dependency to the USB host stack and broke
> > > gadget-only builds of the driver.
> > > 
> > > Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > > 
> > > Changes in v2
> > >  - new patch
> > > 
> > >  drivers/usb/dwc3/dwc3-qcom.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > > index be2e3dd36440..e9364141661b 100644
> > > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > > @@ -310,8 +310,11 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> > >  	 * currently supports only 1 port per controller. So
> > >  	 * this is sufficient.
> > >  	 */
> > > +#ifdef CONFIG_USB
> > >  	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> > 
> > If a gadget driver needs this for some reason, then the #ifdef should be
> > put in a .h file, not in a .c file.
> 
> Yeah, if we're keeping this long-term then yes, and possibly also
> otherwise.
> 
> > But step back a minute and ask why a host-config-only function is being
> > called when a device is in gadget-only mode?  This feels like a
> > design/logic issue in this file, NOT something to paper over with a
> > #ifdef in a .c file
> 
> We're not as I'm fixing that bug in later in the series. I should
> probably have put this one after that fix, but figured fixing the build
> was more important than a harder-to-hit NULL-deref due to non-host mode
> not being considered when the offending series was merged.
> 
> > This implies that if this device is NOT in a host configuration, then
> > the suspend path of it is not configured properly at all, as why would
> > it be checking or caring about this at all if this is in gadget-only
> > mode?
> 
> Right, so see path 6/9 which addresses this by only calling this hack
> when in host mode:
> 
> 	https://lore.kernel.org/all/20220804151001.23612-7-johan+linaro@kernel.org/
> 
> > Something else is wrong here, let's fix the root problem please.  Maybe
> > this driver should just never be built in gadget-only mode, as it is
> > never intended to support that option?
> 
> The problem is commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup
> interrupts during suspend"), which I considered simply reverting but as
> that breaks suspend completely on some boards I decided to try and fix
> it up while we work on a proper long-term solution (i.e. for how the
> dwc/xhci layers should be communicating to implement this).
> 
> Remember that it took two years and 21 revisions to get to the state
> we're at now after you merged the wakeup series in June.

Very good point.  This is a mess, thanks for cleaning it up.  I've
applied this series now and will get it into 6.0-final, hopefully all
should be good now.

thanks for doing this work.

greg k-h
