Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300F258B70E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiHFQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiHFQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:51:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC8DDEAB;
        Sat,  6 Aug 2022 09:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66711B8060E;
        Sat,  6 Aug 2022 16:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A1FC433C1;
        Sat,  6 Aug 2022 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659804691;
        bh=VnrvTUGe1dNVc7jCq++HzAzCuD0PNW0MzC6BQG5Rie0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLeitvsKx6r79fikRlCnosNLcf8K9LipyoCIFpBtEP3Qqpm2Zvw5IGzmvNKQPsGXh
         fQTiU8aMGNwKqM+lHmg0Zgkxly4nHrNUtDLe+LDsZVl5ZIMWK0wW0FMnxgLzrgMZmO
         mh51bz3Z0a2G17zjqFcpwa/BciVvT5bW8rWpnuzaxmg0hhkE3dnfRlNAoyD0BeoEfT
         5a+CD0lqpjvmOYXNQLkmHug5QaIopA4inT1xCWUciau5ZwQuEkMDtrbnUckFyA73MO
         HBzl3+Mlo+sMw/KvShy2YrywC0DTTxg9pZhUco0316sdtI5ryoDx5OmaO1ZcI+uE4s
         pPHKlLl34NhuQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oKN1p-0003Uh-Rx; Sat, 06 Aug 2022 18:51:58 +0200
Date:   Sat, 6 Aug 2022 18:51:57 +0200
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/9] usb: dwc3: qcom: fix gadget-only builds
Message-ID: <Yu6cLSRcSEDZ24lY@hovoldconsulting.com>
References: <20220804151001.23612-1-johan+linaro@kernel.org>
 <20220804151001.23612-4-johan+linaro@kernel.org>
 <20220806141536.GD14384@thinkpad>
 <Yu6RBQNSatiwu1WV@hovoldconsulting.com>
 <20220806164250.GK14384@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806164250.GK14384@thinkpad>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 10:12:50PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Aug 06, 2022 at 06:04:21PM +0200, Johan Hovold wrote:
> > On Sat, Aug 06, 2022 at 07:45:36PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 04, 2022 at 05:09:55PM +0200, Johan Hovold wrote:
> > > > A recent change added a dependency to the USB host stack and broke
> > > > gadget-only builds of the driver.
> > > > 
> > > > Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> > > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > > --`-
> > > > 
> > > > Changes in v2
> > > >  - new patch
> > > > 
> > > >  drivers/usb/dwc3/dwc3-qcom.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> > > > index be2e3dd36440..e9364141661b 100644
> > > > --- a/drivers/usb/dwc3/dwc3-qcom.c
> > > > +++ b/drivers/usb/dwc3/dwc3-qcom.c
> > > > @@ -310,8 +310,11 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> > > >  	 * currently supports only 1 port per controller. So
> > > >  	 * this is sufficient.
> > > >  	 */
> > > > +#ifdef CONFIG_USB
> > > >  	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> > > > -
> > > > +#else
> > > > +	udev = NULL;
> > > > +#endif
> > > 
> > > Perhaps the check should be moved to the caller instead? This function still
> > > references "usb_hcd" struct and I don't think that's intended for gadget only
> > > mode.
> > 
> > That wouldn't help with the build failure, which is what this patch is
> > addressing.
> > 
> 
> I should've put it clearly. You should guard the entire function and not just
> usb_hub_find_child(). This way it becomes clear that this whole function depends
> on the USB host functionality. Like,
> 
> #ifdef CONFIG_USB
> static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> {
> ...
> }
> #elif
> static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> {
> 	return USB_SPEED_UNKNOWN
> }
> #endif

Yeah, that's what Krishna suggested but I wanted to keep the ifdeffery
minimal when fixing the build failure (we generally try to avoid adding
stub functions to implementation files).

Non-host mode was clearly never considered when adding the function in
question as the code blows up otherwise regardless of whether CONFIG_USB
is enabled or not (and a later patch in the series addresses that).

But I'll revisit this too in a couple of weeks.

Thanks for reviewing.

Johan
