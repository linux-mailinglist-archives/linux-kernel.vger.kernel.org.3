Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1077250E108
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbiDYNGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiDYNGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:06:19 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E913D76;
        Mon, 25 Apr 2022 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650891796; x=1682427796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TCbxBJKDjx/pXpEyqjCCZTPX37Sf1AfCI5Sa6rwvQV8=;
  b=frjy5xJ9toS//lrdEWlSAFXRKfwE35+roBJiBjyecfB4BpgkfOkJP6zX
   j9hMBjY0MFRKIyZwRef4Y49EW1SIMavemxx3YTWoxdDG68+93JZ3dfvQf
   6d4Nvdzou1x1tDrdTSJQFZmk/AJaB7O0/AOHj0aIP1PFTSsPaCrGe8Tdp
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Apr 2022 06:03:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 06:03:14 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 06:03:14 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 06:03:07 -0700
Date:   Mon, 25 Apr 2022 18:33:03 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Len Brown <len.brown@intel.com>, "Pavel Machek" <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>, <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v14 2/7] PM / wakeup: Add device_children_wakeup_capable()
Message-ID: <20220425130303.GA16319@hu-pkondeti-hyd.qualcomm.com>
References: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
 <1650395470-31333-3-git-send-email-quic_c_sanm@quicinc.com>
 <CAJZ5v0h2ZKPN6SERPnASPywZfeOWXWncJgNZ1WZa80+=M4DCiQ@mail.gmail.com>
 <YmL3lMaR79wPMEfY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YmL3lMaR79wPMEfY@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Fri, Apr 22, 2022 at 11:44:36AM -0700, Matthias Kaehlcke wrote:
> On Fri, Apr 22, 2022 at 01:57:17PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 19, 2022 at 9:11 PM Sandeep Maheswaram
> > <quic_c_sanm@quicinc.com> wrote:
> > >
> > > From: Matthias Kaehlcke <mka@chromium.org>
> > >
> > > Add device_children_wakeup_capable() which checks whether the device itself
> > > or one if its descendants is wakeup capable.
> > 
> > device_wakeup_path() exists for a very similar purpose.
> > 
> > Is it not usable for whatever you need the new function introduced here?
> 
> I wasn't aware of it's function, there are no doc comments and the
> name isn't really self explanatory.
> 
> In a quick test device_wakeup_path() returned inconsistent values for the
> root hub, sometimes true, others false when a wakeup capable USB device was
> connected.

We will also test the same to double confirm the behavior of
device_wakeup_path(). I am assuming that you checked device_wakeup_path()
only during system suspend path.

Here is what I understood by looking at __device_suspend(). Please share
your thoughts on this.

power.wakeup_path is set to true for the parent *after* a wakeup capable
device is suspended. This means when the root hub(s) is suspended, it is
propagated to xhci-plat and when xhci-plat is suspended, it is propagated
to dwc3. bottom up propgation during system suspend.

I believe we can directly check something like this in the dwc3 driver
instead of having another wrapper like device_children_wakeup_capable().

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1170b80..a783257 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1878,8 +1878,14 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 		if (!PMSG_IS_AUTO(msg)) {
+			/*
+			 * Don't kill the host when dwc3 is wakeup capable and
+			 * its children needs wakeup.
+			 */
+			if (device_may_wakeup(dwc->dev) && device_wakeup_path(dwc->dev))
+				handle_it();
+		} else {
 			dwc3_core_exit(dwc);
-			break;
 		}
 
 		/* Let controller to suspend HSPHY before PHY driver suspends */

Thanks,
Pavan
