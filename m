Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14715099AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386161AbiDUHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386210AbiDUHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:50:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBF1CFDB;
        Thu, 21 Apr 2022 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650527216; x=1682063216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P+XpSd9beND6/x2u+ntTWsApIZgguL/N6Ro0gQ3mGcc=;
  b=Q2DB0MWauILg0KXLk+238OWym4kw6BFacTu0GDMW2TId5VafjjF2OhrC
   inrUkZRykLeP+bEoFTtB2GoqanIN1sv5Cz5Y81JFLV8BT99okaYkE8sQX
   OkOVtzJyiGemtSMKnCXKCJ283GJK/6KsTPBPBJX9sSyiV5CMyFGKT7N4d
   FZK/u8oTmJnwJUj2wa3PA/LDb4HDjnJrBC5aM3mElEaqX2uSQhUIwAEa9
   q5+AJJcZyk3z1NEGIwqLYVDXaYrJ/9/CqcazjCwMG5K0tu/Iwc6uimXAO
   ZSbPSBRu2VJ//wVDj2jHKn6VzeSE9YiKEh02w5eUb6kdGZM5TxwByeSZC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="244203805"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="244203805"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="702979847"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 21 Apr 2022 00:46:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Apr 2022 10:46:37 +0300
Date:   Thu, 21 Apr 2022 10:46:37 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     "Sandeep Maheswaram (Temp) (QUIC)" <quic_c_sanm@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pavan Kumar Kondeti (QUIC)" <quic_pkondeti@quicinc.com>,
        "Pratham Pratap (QUIC)" <quic_ppratap@quicinc.com>,
        "Krishna Kurapati PSSNV (QUIC)" <quic_kriskura@quicinc.com>,
        "Vidya Sagar Pulyala (Temp) (QUIC)" <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers
Message-ID: <YmEL3WnyM7sa8VP9@kuha.fi.intel.com>
References: <1649323888-12420-1-git-send-email-quic_c_sanm@quicinc.com>
 <DM6PR02MB4857A0ADCDA1558DE58E103ADFF29@DM6PR02MB4857.namprd02.prod.outlook.com>
 <4b34735f-8e1f-bf37-398f-9b4a8aa2e939@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b34735f-8e1f-bf37-398f-9b4a8aa2e939@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 04:20:52PM +0300, Mathias Nyman wrote:
> On 19.4.2022 13.17, Sandeep Maheswaram (Temp) (QUIC) wrote:
> > Hi Mathias, Felipe,
> > 
> >> -----Original Message-----
> >> From: Sandeep Maheswaram (Temp) (QUIC) <quic_c_sanm@quicinc.com>
> >> Sent: Thursday, April 7, 2022 3:01 PM
> >> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Felipe Balbi
> >> <balbi@kernel.org>; Stephen Boyd <swboyd@chromium.org>; Doug
> >> Anderson <dianders@chromium.org>; Matthias Kaehlcke
> >> <mka@chromium.org>; Mathias Nyman <mathias.nyman@intel.com>
> >> Cc: linux-arm-msm@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; Pavan Kumar Kondeti (QUIC)
> >> <quic_pkondeti@quicinc.com>; Pratham Pratap (QUIC)
> >> <quic_ppratap@quicinc.com>; Krishna Kurapati PSSNV (QUIC)
> >> <quic_kriskura@quicinc.com>; Vidya Sagar Pulyala (Temp) (QUIC)
> >> <quic_vpulyala@quicinc.com>; Sandeep Maheswaram (Temp) (QUIC)
> >> <quic_c_sanm@quicinc.com>
> >> Subject: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers
> >>
> >> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
> >> usage value is 2 because the phy is initialized from
> >> DWC3 core and HCD core.
> >> Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
> >> This property can be set to avoid phy initialization in HCD core.
> >>
> >> v3:
> >> Coming back to this series based on discussion at below thread
> >> https://patchwork.kernel.org/project/linux-arm-msm/patch/1648103831-
> >> 12347-4-git-send-email-quic_c_sanm@quicinc.com/
> >> Dropped the dt bindings PATCH 1/3 in v2
> >> https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-
> >> 25582-1-git-send-email-quic_c_sanm@quicinc.com/
> >>
> >> v2:
> >> Updated the commit descriptions.
> >> Changed subject prefix from dwc to dwc3.
> >> Increased props array size.
> >>
> >> Sandeep Maheswaram (2):
> >>   usb: host: xhci-plat: Add device property to set XHCI_SKIP_PHY_INIT
> >>     quirk
> >>   usb: dwc3: host: Set the property usb-skip-phy-init
> >>
> >>  drivers/usb/dwc3/host.c      | 4 +++-
> >>  drivers/usb/host/xhci-plat.c | 3 +++
> >>  2 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> --
> >> 2.7.4
> > 
> > Please let me know your opinion about this series.
> 
> Otherwise looks good but wondering if we should document that new device
> property somewhere. 
> 
> Couldn't find a standard way how those device properties excluded from
> Documentation/devicetree/binding are documented

Couldn't it be just documented in drivers/usb/host/xhci-plat.c for now?

thanks,

-- 
heikki
