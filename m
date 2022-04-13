Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8F4FFABC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbiDMP6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiDMP6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:58:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C5654B3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:56:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so2318149plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M4yQ1ycSiUY4LFg4d65ixOTD9dqKMYw4YlLa4p4gnoc=;
        b=IHy8LoSo/+3dZ1GBrWG3sY2d55Q2Lp/yGjaDiSLiw+tpzB/1QTMC0GJlEh9wk2LqGK
         b4GNO5cFj0iDjZavUyFvXWdDXgNf7hfmDMyzWVbPswJBSwrn63IENINt9qqHnya5RHiA
         5yssxiYvQU3uy7ZxXBzsYU9tRhS7gwb0owdlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M4yQ1ycSiUY4LFg4d65ixOTD9dqKMYw4YlLa4p4gnoc=;
        b=PhYqNdBTPouGZRZG26GJA5tJ+GyxYXz2hY57LN+k+ezl98wuhrg0rS0yVbUnCJjVFA
         nOovRf/kmbWE/o1k8l+bPH6RwxrghFgfCHPkoe13N4hNIZWo1+DaFKJG9Bap1G1QsUFG
         TB8BUHTXMGjRyUgqOry30mHrz7ubWUufU9lmio9/IllEt0dEjagaj/W4S6lMzffMSQW8
         QfjmN2BHAGC3gQLAHAaPnJOTv/4e3pBIAppqx6VaCpbr3sumsYSo46ja/8tEQHH83LUr
         5qSP6j2Nn/K5fhPoqCEAxJ+0pNeuDVwwnQ+i21eGNm4+nL4EGTRZ5KkyUoUrwxSOWZtY
         +Clg==
X-Gm-Message-State: AOAM530gnCYf3Z4Ah4DfGoZEcLUlL0d72hKh+Y8HGeDAp+GeP8kOLJE4
        1HEMStY/4+vDCUhBRo7XE/wzXA==
X-Google-Smtp-Source: ABdhPJzeYBBUcHlcRv47oyjP3gk/zRcuNDVaq68uvTW0vlxUZLXNuNEKYLyRLPRicCq4CSb8ffb+Ew==
X-Received: by 2002:a17:902:d051:b0:158:5910:d67a with SMTP id l17-20020a170902d05100b001585910d67amr17116579pll.15.1649865385130;
        Wed, 13 Apr 2022 08:56:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6a4f:9277:743f:c648])
        by smtp.gmail.com with UTF8SMTPSA id nl17-20020a17090b385100b001c70883f6ccsm3604591pjb.36.2022.04.13.08.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 08:56:24 -0700 (PDT)
Date:   Wed, 13 Apr 2022 08:56:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
Cc:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_kriskura@quicinc.com,
        quic_vpulyala@quicinc.com
Subject: Re: [PATCH v13 2/6] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <YlbyptYB/VFUDF0Q@google.com>
References: <1649704614-31518-1-git-send-email-quic_c_sanm@quicinc.com>
 <1649704614-31518-3-git-send-email-quic_c_sanm@quicinc.com>
 <YlSVec5+SpdMZWCz@google.com>
 <36d22ad7-7f11-2f63-cd68-5d564476161e@quicinc.com>
 <20220412050018.GB2627@hu-pkondeti-hyd.qualcomm.com>
 <259c9e87-a52e-c063-7901-2c6decd42675@quicinc.com>
 <YlXNd5YkAMW7cbYG@google.com>
 <ee38105f-e2f4-4e40-3c89-224301f1eb12@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee38105f-e2f4-4e40-3c89-224301f1eb12@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 02:38:33PM +0530, Sandeep Maheswaram (Temp) wrote:
> Hi Matthias,
> 
> On 4/13/2022 12:35 AM, Matthias Kaehlcke wrote:
> > On Tue, Apr 12, 2022 at 12:08:02PM +0530, Sandeep Maheswaram (Temp) wrote:
> > > Hi Pavan,
> > > 
> > > On 4/12/2022 10:30 AM, Pavan Kondeti wrote:
> > > > Hi Sandeep,
> > > > 
> > > > On Tue, Apr 12, 2022 at 10:16:39AM +0530, Sandeep Maheswaram (Temp) wrote:
> > > > > Hi Matthias,
> > > > > 
> > > > > On 4/12/2022 2:24 AM, Matthias Kaehlcke wrote:
> > > > > > On Tue, Apr 12, 2022 at 12:46:50AM +0530, Sandeep Maheswaram wrote:
> > > > > > > During suspend read the status of all port and set hs phy mode
> > > > > > > based on current speed. Use this hs phy mode to configure wakeup
> > > > > > > interrupts in qcom glue driver.
> > > > > > > 
> > > > > > > Check wakep-source property for dwc3 core node to set the
> > > > > > s/wakep/wakeup/
> > > > > Okay. Will update in next version.
> > > > > > > wakeup capability. Drop the device_init_wakeup call from
> > > > > > > runtime suspend and resume.
> > > > > > > 
> > > > > > > Also check during suspend if any wakeup capable devices are
> > > > > > > connected to the controller (directly or through hubs), if there
> > > > > > > are none set a flag to indicate that the PHY is powered
> > > > > > > down during suspend.
> > > > > > > 
> > > > > > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > > > > > ---
> > > > > > A per-patch change log would be really helpful for reviewers, even
> > > > > > if it doesn't include older versions.
> > > > > Okay. Will update in next version.
> > > > > > >    drivers/usb/dwc3/core.c | 33 ++++++++++++++++++++-------------
> > > > > > >    drivers/usb/dwc3/core.h |  4 ++++
> > > > > > >    drivers/usb/dwc3/host.c | 25 +++++++++++++++++++++++++
> > > > > > >    3 files changed, 49 insertions(+), 13 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > > > > index 1170b80..effaa43 100644
> > > > > > > --- a/drivers/usb/dwc3/core.c
> > > > > > > +++ b/drivers/usb/dwc3/core.c
> > > > > > > @@ -32,6 +32,7 @@
> > > > > > >    #include <linux/usb/gadget.h>
> > > > > > >    #include <linux/usb/of.h>
> > > > > > >    #include <linux/usb/otg.h>
> > > > > > > +#include <linux/usb/hcd.h>
> > > > > > >    #include "core.h"
> > > > > > >    #include "gadget.h"
> > > > > > > @@ -1723,6 +1724,7 @@ static int dwc3_probe(struct platform_device *pdev)
> > > > > > >    	platform_set_drvdata(pdev, dwc);
> > > > > > >    	dwc3_cache_hwparams(dwc);
> > > > > > > +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
> > > > > > >    	spin_lock_init(&dwc->lock);
> > > > > > >    	mutex_init(&dwc->mutex);
> > > > > > > @@ -1865,6 +1867,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > > > > >    {
> > > > > > >    	unsigned long	flags;
> > > > > > >    	u32 reg;
> > > > > > > +	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
> > > > > > >    	switch (dwc->current_dr_role) {
> > > > > > >    	case DWC3_GCTL_PRTCAP_DEVICE:
> > > > > > > @@ -1877,10 +1880,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > > > > >    		dwc3_core_exit(dwc);
> > > > > > >    		break;
> > > > > > >    	case DWC3_GCTL_PRTCAP_HOST:
> > > > > > > -		if (!PMSG_IS_AUTO(msg)) {
> > > > > > > -			dwc3_core_exit(dwc);
> > > > > > > -			break;
> > > > > > > -		}
> > > > > > > +		dwc3_check_phy_speed_mode(dwc);
> > > > > > >    		/* Let controller to suspend HSPHY before PHY driver suspends */
> > > > > > >    		if (dwc->dis_u2_susphy_quirk ||
> > > > > > > @@ -1896,6 +1896,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > > > > >    		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
> > > > > > >    		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> > > > > > > +
> > > > > > > +		if (!PMSG_IS_AUTO(msg)) {
> > > > > > > +			if (device_may_wakeup(dwc->dev) &&
> > > > > > > +			    usb_wakeup_enabled_descendants(hcd->self.root_hub)) {
> > > > > > You did not answer my question on v12, reposting it:
> > > > > > 
> > > > > >     Did you ever try whether you could use device_children_wakeup_capable() from
> > > > > >     [1] instead of usb_wakeup_enabled_descendants()?
> > > > > > 
> > > > > >     [1] https://patchwork.kernel.org/project/linux-usb/patch/1635753224-23975-2-git-send-email-quic_c_sanm@quicinc.com/#24566065
> > > > > Sorry ..I have replied in mail yesterday but it is not showing up in
> > > > > patchwork link.
> > > > > 
> > > > > Tried with  device_children_wakeup_capable(dwc->dev) instead of
> > > > > usb_wakeup_enabled_descendants and it always returns true even
> > > > > 
> > > > > when no devices are connected.
> > > > > 
> > > > What do you mean by when no devices are connected? There is always
> > > > root hub connected and we should not power down the DWC3 here even
> > > > when remote wakeup for root hub is enabled. Essentially
> > > > usb_wakeup_enabled_descendants() returns true even without any
> > > > physical devices connected.
> > > > 
> > > > What does device_children_wakeup_capable() do? Sorry, I could not
> > > > find this function definition.
> > > > 
> > > > Thanks,
> > > > Pavan
> > > usb_wakeup_enabled_descendants() doesn't consider hubs. It only returns true if any devices
> > > are connected with wakeup capability apart from hubs.
> > Actually it considers hubs:
> > 
> > unsigned usb_wakeup_enabled_descendants(struct usb_device *udev)
> > {
> > 	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
> > 
> > 	return udev->do_remote_wakeup +
> > 		(hub ? hub->wakeup_enabled_descendants : 0);
> > }
> > 
> > 'udev' may or may not be a hub, if 'do_remote_wakeup' is set then the
> > device is considered a wakeup enabled descendant.
> > 
> > And for system suspebd 'do_remote_wakeup' is set based on the wakeup
> > config of the device:
> > 
> > static void choose_wakeup(struct usb_device *udev, pm_message_t msg)
> > {
> > 	...
> > 	w = device_may_wakeup(&udev->dev);
> > 	...
> > 	udev->do_remote_wakeup = w;
> > }
> > 
> > I checked on three systems with different Linux distributions, on all of
> > the wakeup flag of a connected hub is 'disabled'. Wakeup still works, so
> > apparently that flag doesn't really have an impact for child ports.
> > 
> > > If we consider hubs also dwc3 core exit and phy exit will never be called.
> > > 
> > > device_children_wakeup_capable() implementation was shared by Matthias in below thread
> > > https://patchwork.kernel.org/project/linux-usb/patch/1635753224-23975-2-git-send-email-quic_c_sanm@quicinc.com/#24566065
> > > 
> > > Probably device_children_wakeup_capable() is returning true because it considers hubs also.
> > I thought I did a basic test when I sent the patch, I did another (?) one
> > with v13 of your patch set. In this tests with a hub connected the
> > function returns true when an HID device is connected, and false when
> > nothing is connected. The wakeup flag of the hub is disabled (default).
> > 
> > Sandeep, are the wakeup flags of the child hub(s) set to 'enabled' on
> > the system you tested on?
> 
> The wakeup flags of hub is 'disabled' on system I tested.
> 
> What is the input param you are giving to device_children_wakeup_capable() function ?

I passed '&hcd->self.root_hub->dev'

> I was passing the dwc->dev like this device_children_wakeup_capable(dwc->dev) .Is it right?

The DWC doesn't know anything about the connected USB devices, so this only
checks wakeup capability/policy of the DWC itself.
