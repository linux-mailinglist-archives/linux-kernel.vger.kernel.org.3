Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B858C98F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbiHHNeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242958AbiHHNeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:34:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB93E62EE;
        Mon,  8 Aug 2022 06:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5732A61238;
        Mon,  8 Aug 2022 13:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF151C433D7;
        Mon,  8 Aug 2022 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659965654;
        bh=LBRn0PznnW2ya4z0sPhw5JpQP8WyMUBJTDHeeK7woag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNifi5K7Jm7FwC1RVc1vW5qDVCs/ySS9i+m27qTGqtkfGcc4xz6VIhzlEmRxwe8Q3
         nAg/U8GrgNY/rVdyJ2vsNi3bAeQMsMgP0GvmjvZLo/KRbG/B2c6prdd1fINYg9Q5/b
         hljRnV2sqAH2kzmrBMezphZqMNo48qm5m+bxOb928n4i2+dSpwP0wyB/8/DSvMU0DJ
         xa0/qRasW0LXk+hLUkfB7FH5h0xMIW9zV+/Vp65qzeTziTKSC4e63dc0JVZY392KAI
         4ETCV+JK93RyZWT0usaBxXV+lnZGzZKSrr8jxKzKisF6MG69DNA0ff/uu6q62eWWBK
         ommQpb0xEGG+Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oL2tW-0000vp-Iv; Mon, 08 Aug 2022 15:34:11 +0200
Date:   Mon, 8 Aug 2022 15:34:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <YvEQ0hpTRvAPStHU@hovoldconsulting.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-4-johan+linaro@kernel.org>
 <YvEKIJ+GujHt7XvT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvEKIJ+GujHt7XvT@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 03:05:36PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 04, 2022 at 05:09:55PM +0200, Johan Hovold wrote:
> > A recent change added a dependency to the USB host stack and broke
> > gadget-only builds of the driver.
> > 
> > Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> > 
> > Changes in v2
> >  - new patch
> > 
> >  drivers/usb/dwc3/dwc3-qcom.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > index be2e3dd36440..e9364141661b 100644
> > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > @@ -310,8 +310,11 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> >  	 * currently supports only 1 port per controller. So
> >  	 * this is sufficient.
> >  	 */
> > +#ifdef CONFIG_USB
> >  	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> 
> If a gadget driver needs this for some reason, then the #ifdef should be
> put in a .h file, not in a .c file.

Yeah, if we're keeping this long-term then yes, and possibly also
otherwise.

> But step back a minute and ask why a host-config-only function is being
> called when a device is in gadget-only mode?  This feels like a
> design/logic issue in this file, NOT something to paper over with a
> #ifdef in a .c file

We're not as I'm fixing that bug in later in the series. I should
probably have put this one after that fix, but figured fixing the build
was more important than a harder-to-hit NULL-deref due to non-host mode
not being considered when the offending series was merged.

> This implies that if this device is NOT in a host configuration, then
> the suspend path of it is not configured properly at all, as why would
> it be checking or caring about this at all if this is in gadget-only
> mode?

Right, so see path 6/9 which addresses this by only calling this hack
when in host mode:

	https://lore.kernel.org/all/20220804151001.23612-7-johan+linaro@kernel.org/

> Something else is wrong here, let's fix the root problem please.  Maybe
> this driver should just never be built in gadget-only mode, as it is
> never intended to support that option?

The problem is commit 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup
interrupts during suspend"), which I considered simply reverting but as
that breaks suspend completely on some boards I decided to try and fix
it up while we work on a proper long-term solution (i.e. for how the
dwc/xhci layers should be communicating to implement this).

Remember that it took two years and 21 revisions to get to the state
we're at now after you merged the wakeup series in June.

Johan
