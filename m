Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3335140C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiD2DJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiD2DJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:09:13 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5DDBB913;
        Thu, 28 Apr 2022 20:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651201556; x=1682737556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n9GSRz3I8hm7PZYmgP8cDouLfs9ShB/oLPDbfepHXII=;
  b=DduetlMwvcRqsyDCyUfX/nMyXYAf04xHOYwwVTMlkrARy145HY5+DOSV
   hgbO741rfYrG12/CYxbDbcNAyrR6M5l9N7wjBbN84Bv2xtsEs+8mlHua1
   cnTZKvsDlj3jneySSjwUEB2LA+Pc0aEsruQBAxgECKzvXZUTyW2iSVQoW
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2022 20:05:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 20:05:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 20:05:54 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 20:05:48 -0700
Date:   Fri, 29 Apr 2022 08:35:44 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_kriskura@quicinc.com" <quic_kriskura@quicinc.com>,
        "quic_vpulyala@quicinc.com" <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v4 0/3] Skip phy initialization for DWC3 USB Controllers
Message-ID: <20220429030544.GC16319@hu-pkondeti-hyd.qualcomm.com>
References: <1650517255-4871-1-git-send-email-quic_c_sanm@quicinc.com>
 <20220425024858.GA7052@hu-pkondeti-hyd.qualcomm.com>
 <1287c649-de62-c7d8-1c1d-a30ede7505c9@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1287c649-de62-c7d8-1c1d-a30ede7505c9@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On Tue, Apr 26, 2022 at 01:12:17AM +0000, Thinh Nguyen wrote:
> Hi,
> 
> Pavan Kondeti wrote:
> > Hi Mathias,
> > 
> > On Thu, Apr 21, 2022 at 10:30:52AM +0530, Sandeep Maheswaram wrote:
> >> Runtime suspend of phy drivers was failing from DWC3 driver as
> >> runtime usage value is 2 because the phy is initialized from
> >> DWC3 core and HCD core.
> >> Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
> >> This property can be set to avoid phy initialization in HCD core.
> >>
> >> v4:
> >> Added the device tree binding patch in the series.
> >>
> >> v3:
> >> Coming back to this series based on discussion at below thread
> >> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-arm-msm/patch/1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com/__;!!A4F2R9G_pg!fykTNTBuKk9ci6zKdcuQNbuZQdVi_HekU3jetzud-PQVhbRaVhhZHKz0k_LfG0cgwaX4bQM5bLI0ep6tYyikgvYK7b5SdA$ 
> >> Dropped the dt bindings PATCH 1/3 in v2
> >> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-25582-1-git-send-email-quic_c_sanm@quicinc.com/__;!!A4F2R9G_pg!fykTNTBuKk9ci6zKdcuQNbuZQdVi_HekU3jetzud-PQVhbRaVhhZHKz0k_LfG0cgwaX4bQM5bLI0ep6tYyikgva2VXahOQ$  
> >>
> >> v2:
> >> Updated the commit descriptions.
> >> Changed subject prefix from dwc to dwc3.
> >> Increased props array size.
> >>
> >>
> >> Sandeep Maheswaram (3):
> >>   dt-bindings: usb: usb-xhci: Add bindings for usb-skip-phy-init
> >>     property
> >>   usb: host: xhci-plat: Add device property to set XHCI_SKIP_PHY_INIT
> >>     quirk
> >>   usb: dwc3: host: Set the property usb-skip-phy-init
> >>
> >>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
> >>  drivers/usb/dwc3/host.c                             | 4 +++-
> >>  drivers/usb/host/xhci-plat.c                        | 3 +++
> >>  3 files changed, 10 insertions(+), 1 deletion(-)
> >>
> > 
> > This is the latest series with bindings added as per Greg's comment. Can you
> > please pick up this series if you don't have any further comments.
> > 
> 
> We've had this conversation going on for a while. Seems there's no good
> one solution with everyone fully getting on-board.
> 
> I've tried to get some of the quirks out before also, but ran into the
> same problem. [1]
> 
> As Mathias noted [2] before, maybe we can create a new xhci-snps
> platform glue driver.
> 
> The problem with the current implementation is passing dwc3's related
> info to xhci-plat generic driver is very clunky. We can teach the new
> glue driver with all the info necessary to drive the controller.
> 
> We can just pass the controller's version (and subversion) as a property
> for platform device. This way, we can:
> 
> 1) Separate the quirks from xhci-plat glue. Most common quirks can be
> detected just base on the controller's version
> 
> 2) Avoid having to create duplicate "snps,*" properties
> 
> 3) Get access to the common xhci quirk flags while maintain abstraction
> 
> 4) Potentially add compatibility string as part of the controller's
> version and let the glue driver handle the rest
> 
> 5) Reduce introducing new "quirks" in the future
> 
> I can get started with this. Let me know if you have any comment.

Sorry, could not reply earlier. The proposal sounds good to me.

The xhci-plat is a thin wrapper, so having a separate wrapper for SNPS
controller is definitely not an overkill and gives lot of flexibility
in abstracting dwc3 specifics. Also dwc3/host.c becomes just a platform
device creation wrapper and xHC specifics are completely taken out.

Thanks,
Pavan


