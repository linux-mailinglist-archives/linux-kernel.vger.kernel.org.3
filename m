Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F04E4B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbiCWDJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiCWDJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:09:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DC3BE15;
        Tue, 22 Mar 2022 20:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648004880; x=1679540880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EF/JQuQvjXcqaoJAFGbUy4VuBPt0HhFRN25fJmoeJlk=;
  b=ME6+DSaAh/SFqD9UbBXJLD0Vl7gOfpOWeslWTTRVgsgC+nnQdj9Scr/3
   q1yaV7XKOTo07v+P6EqRa7uJo4XXqJ5AcBSNLyLYJf78xMlOJKBBlpYL8
   XWgsmTR+TIVhtlwIX42YYLbEyzGbLPQYAdlJx5DwTfCPOJl7DKW3/YRNS
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 Mar 2022 20:07:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 20:07:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 20:07:58 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 22 Mar 2022 20:07:52 -0700
Date:   Wed, 23 Mar 2022 08:37:49 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Pawel Laszczak" <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        "Roger Quadros" <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
Subject: Re: [PATCH v2 0/3] Refactor xhci quirks and plat private data
Message-ID: <20220323030749.GO23316@hu-pkondeti-hyd.qualcomm.com>
References: <1646130507-26796-1-git-send-email-quic_c_sanm@quicinc.com>
 <ddc86a4f-8d1c-c02c-5600-4fa851568557@quicinc.com>
 <YjR0Ne3BDxxMfrxt@kroah.com>
 <b38ddfcc-68c3-d99f-816b-8b9f788aa88a@quicinc.com>
 <29ba84fb-1db2-1d84-cf9e-191e9bcbf739@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29ba84fb-1db2-1d84-cf9e-191e9bcbf739@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Hi Mathias,

On Tue, Mar 22, 2022 at 05:53:42PM +0200, Mathias Nyman wrote:
> On 21.3.2022 8.21, Sandeep Maheswaram (Temp) wrote:
> > Hi Mathias,
> > 
> > On 3/18/2022 5:29 PM, Greg Kroah-Hartman wrote:
> >> On Thu, Mar 17, 2022 at 11:17:17AM +0530, Sandeep Maheswaram (Temp) wrote:
> >>> Hi Greg,
> >>>
> >>> On 3/1/2022 3:58 PM, Sandeep Maheswaram wrote:
> >>>> changes in v2:
> >>>> Added a PATCH 2/3 to remove unwanted header inclusion.
> >>>> Fixed minor nitpicks in PATCH 3/3.
> >>>>
> >>>> Pavankumar Kondeti (1):
> >>>>     usb: xhci: refactor quirks and plat private data
> >>>>
> >>>> Sandeep Maheswaram (2):
> >>>>     usb: xhci: Remove unwanted header inclusion
> >>>>     usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
> >>>>
> >>>>    drivers/usb/cdns3/host.c        |  2 +-
> >>>>    drivers/usb/dwc3/host.c         | 13 ++++++++
> >>>>    drivers/usb/host/xhci-plat.c    |  3 +-
> >>>>    drivers/usb/host/xhci-plat.h    | 24 ---------------
> >>>>    drivers/usb/host/xhci-rcar.c    |  3 +-
> >>>>    drivers/usb/host/xhci.h         | 60 ++++--------------------------------
> >>>>    include/linux/usb/xhci-plat.h   | 24 +++++++++++++++
> >>>>    include/linux/usb/xhci-quirks.h | 67 +++++++++++++++++++++++++++++++++++++++++
> >>>>    8 files changed, 115 insertions(+), 81 deletions(-)
> >>>>    delete mode 100644 drivers/usb/host/xhci-plat.h
> >>>>    create mode 100644 include/linux/usb/xhci-plat.h
> >>>>    create mode 100644 include/linux/usb/xhci-quirks.h
> >>> Please let me know your opinion about this patch series.
> >> I need the xhci maintainer to review it...
> >>
> >> thanks,
> >>
> >> greg k-h
> > 
> > 
> > Can you please review this patch series.
> > 
> 
> I don't have a better solution than this.
> 
> So neither devicetree or ACPI entries exists for the xHC part of this dwc3 controller?
> 
> A pure platform device is created, and it matches and binds to xhci-plat driver by "xhci-hcd" name.
> I guess we have no way to identify this dwc3 xhci controller in xhci-plat.c, and set quirks there,
> like all those devicetree xhci devices that we set quirks based on .compatibility. 
> 
Thanks for the review. Yes, xhci-plat platform device is created by the DWC3
driver for the controllers that needs to be operated in the host.

Thanks,
Pavan
