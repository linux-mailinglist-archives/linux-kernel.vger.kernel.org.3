Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3445B4E3ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiCVImo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiCVImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:42:37 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99CE6BDD1;
        Tue, 22 Mar 2022 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647938468; x=1679474468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nijQD/zlc5+xUJ+OIlvFTQfbS4iCg/CX/NvW4jL1NHY=;
  b=IzRqD4+BN1Gtp9FKWKiOZhFBtwvOfvmSEVP1nJgYpo3uTFgy7ffMGfO9
   hBD6hpnVODEwMrBUByswgbZXhtl72OPz7S9Z/9IVxD+SFVB/qc9AbtbKo
   bfQ0fBiXmepuX9wDVK7e8rBeHeKYd1UuLxiFx5kMneEFqRy0wJSr1+ygg
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Mar 2022 01:41:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 01:41:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:41:07 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 01:41:03 -0700
Date:   Tue, 22 Mar 2022 14:10:59 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_kriskura@quicinc.com>
Subject: Re: [PATCH v11 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <20220322084059.GN23316@hu-pkondeti-hyd.qualcomm.com>
References: <1647932876-23249-1-git-send-email-quic_c_sanm@quicinc.com>
 <1647932876-23249-3-git-send-email-quic_c_sanm@quicinc.com>
 <20220322083221.GJ23316@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220322083221.GJ23316@hu-pkondeti-hyd.qualcomm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

On Tue, Mar 22, 2022 at 02:02:21PM +0530, Pavan Kondeti wrote:
> Hi Sandeep,
> 
> On Tue, Mar 22, 2022 at 12:37:53PM +0530, Sandeep Maheswaram wrote:
> > During suspend read the status of all port and make sure the PHYs
> > are in the correct mode based on current speed.
> > Phy interrupt masks are set based on this mode. Keep track of the mode
> > of the HS PHY to be able to configure wakeup properly.
> > 
> > Also check during suspend if any wakeup capable devices are
> > connected to the controller (directly or through hubs), if there
> > are none set a flag to indicate that the PHY is powered
> > down during suspend.
> > 
> > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > ---
> >  drivers/usb/dwc3/core.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 45 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 1170b80..232a734 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -32,12 +32,14 @@
> >  #include <linux/usb/gadget.h>
> >  #include <linux/usb/of.h>
> >  #include <linux/usb/otg.h>
> > +#include <linux/usb/hcd.h>
> >  
> >  #include "core.h"
> >  #include "gadget.h"
> >  #include "io.h"
> >  
> >  #include "debug.h"
> > +#include "../host/xhci.h"
> >  
> >  #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
> >  
> > @@ -1861,10 +1863,36 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
> >  	return ret;
> >  }
> >  
> > +static void dwc3_set_phy_speed_mode(struct dwc3 *dwc)
> > +{
> > +
> > +	int i, num_ports;
> > +	u32 reg;
> > +	struct usb_hcd	*hcd = platform_get_drvdata(dwc->xhci);
> > +	struct xhci_hcd	*xhci_hcd = hcd_to_xhci(hcd);
> > +
> > +	dwc->hs_phy_mode = 0;
> > +
Sorry, My bad. I did not notice that the flags are cleared here.

Thanks,
Pavan
