Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F295F52413F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349497AbiEKXzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiEKXzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:55:04 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745406FD3A;
        Wed, 11 May 2022 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652313299; x=1683849299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=djoNJ50KR+AFBmKpoCbyO4jjNOYnBtA+kMqhid4fp1A=;
  b=ofVj1TUvUACSYehN7FLHJfCWGZGRezsPN9fMjqaAjmpPF1E4U6RL/dC2
   vTNqYRkVEUIxUFXNO7ENNB5RQ7dAWDzo/W6g7riy6zDTI7qdYSzb+eEnT
   fnZyiaV63OBdscqlRy0GPJrJvkdx/vUBvJnLKDf5anKVOSGVSoYJtzBHk
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 May 2022 16:54:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 16:54:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 16:54:58 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 16:54:52 -0700
Date:   Thu, 12 May 2022 05:24:48 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_vpulyala@quicinc.com>
Subject: Re: [v15 2/6] usb: host: xhci-plat: Enable wakeup based on children
 wakeup status
Message-ID: <20220511235448.GA11722@hu-pkondeti-hyd.qualcomm.com>
References: <1651740973-7944-1-git-send-email-quic_kriskura@quicinc.com>
 <1651740973-7944-3-git-send-email-quic_kriskura@quicinc.com>
 <YnVAZSZYQvIJxOHv@google.com>
 <20220509033843.GB9170@hu-pkondeti-hyd.qualcomm.com>
 <20220511015101.GB23843@hu-pkondeti-hyd.qualcomm.com>
 <YnvcMe+irsndtcV0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YnvcMe+irsndtcV0@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:54:25AM -0700, Matthias Kaehlcke wrote:
> On Wed, May 11, 2022 at 07:21:01AM +0530, Pavan Kondeti wrote:
> > On Mon, May 09, 2022 at 09:08:43AM +0530, Pavan Kondeti wrote:
> > > On Fri, May 06, 2022 at 08:36:31AM -0700, Matthias Kaehlcke wrote:
> > > > On Thu, May 05, 2022 at 02:26:09PM +0530, Krishna Kurapati wrote:
> > > > > device_wakeup_path() tells if any of the children devices needs
> > > > > wakeup. Use this hint to enable/disable wakeup of our device. This
> > > > > helps the parent device of xhci-plat (like sysdev) to retrieve
> > > > > the wakeup setting via device_wakeup_path().
> > > > > 
> > > > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > > > ---
> > > > >  drivers/usb/host/xhci-plat.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > > > > index 649ffd8..ad585fa 100644
> > > > > --- a/drivers/usb/host/xhci-plat.c
> > > > > +++ b/drivers/usb/host/xhci-plat.c
> > > > > @@ -415,6 +415,14 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
> > > > >  	if (pm_runtime_suspended(dev))
> > > > >  		pm_runtime_resume(dev);
> > > > >  
> > > > > +	if (device_wakeup_path(dev)) {
> > > > > +		if (!device_may_wakeup(dev))
> > > > > +			device_wakeup_enable(dev);
> > > > > +	} else {
> > > > > +		if (device_may_wakeup(dev))
> > > > > +			device_wakeup_disable(dev);
> > > > > +	}
> > > > 
> > > > This code is not self-explantatory and deserves a comment.
> > > > 
> > > > Enabling/disabling wakeup for the purpose if signalling is a bit of a
> > > > hack. It might be an acceptable hack as long as it has no side effects.
> > > > However with the current implementation the wakeup state of the xHCI can
> > > > be different after resuming than it was before going to suspend:
> > > > 
> > > > after boot
> > > >   grep -h xhci /sys/class/wakeup/*/name
> > > >     => xhci-hcd.14.auto
> > > > 
> > > > after suspend w/o wakeup capable device
> > > >   grep -h xhci /sys/class/wakeup/*/name
> > > >     => no results
> > > > 
> > > > after suspend with wakeup capable device
> > > >   grep -h xhci /sys/class/wakeup/*/name
> > > >     => xhci-hcd.14.auto
> > > > 
> > > > The hack shouldn't alter the wakeup state 'persistently', i.e. you'll have
> > > > to restore it on resume, as in Pavan does in his reply to '[PATCH v14 2/7]
> > > > PM / wakeup: Add device_children_wakeup_capable()' (it needs to be done
> > > > conditionally though).
> > > 
> > > I am worried that we are not doing the right thing here. why should the
> > > xhci-plat goes against the wishes of the user space policy here? Can we NOT
> > > just do anything here? If some one wants xhci-plat to wakeup all the time,
> > > dwc3 will be configured to wakeup the system provided that the support is
> > > available. This way we don't break any existing users of xhci-plat i.e not
> > > enabling wakeup from the kernel.
> > > 
> > Krishna,
> > 
> > can we please drop this patch and use device_wakeup_path() and verify the
> > following cases.
> > 
> > 1. one of the downstream USB device supports wakeup and xhci-plat wakeup is enabled
> > 2. one of the downstream USB device supports wakeup and xhci-plat wakeup is
> > disabled
> > 3. none of the downstream USB device supports wakeup (or disable) and
> > xhci-plat wakeup is enabled.
> > 4. none of the downstream USB device supports wakeup (or disable) and
> > xhci-plat wakeup is disabled.
> 
> I wonder if we couldn't keep this simpler: if the dwc3 is wakeup capable keep
> the PHYs/core powered, otherwise power them down. Similar to what commit
> 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during host
> bus-suspend/resume") intended, but with the additonal check for wakeup
> capability. We now know that the PHYs need to be powered down on some SoCs
> to allow the SoC to reach its low power mode during suspend:
> 
> 
>   commit c4a5153e87fdf6805f63ff57556260e2554155a5
>   Author: Manu Gautam <mgautam@codeaurora.org>
>   Date:   Thu Jan 18 16:54:30 2018 +0530
> 
>   usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode
> 
>   Commit 689bf72c6e0d ("usb: dwc3: Don't reinitialize core during
>   host bus-suspend/resume") updated suspend/resume routines to not
>   power_off and reinit PHYs/core for host mode.
>   It broke platforms that rely on DWC3 core to power_off PHYs to
>   enter low power state on system suspend.
> 
> 
> With wakeup capable controllers this is apparently not an issue, otherwise
> the SoC wouldn't be able to enter its low power state when wakeup is
> enabled.

Agree to your suggestion. Thanks for your inputs.

Thanks,
Pavan
