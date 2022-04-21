Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1FD509AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiDUIoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiDUIo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:44:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63B013CDB;
        Thu, 21 Apr 2022 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650530500; x=1682066500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XSzPShs8SkPM61bfZv/toM/2LSoHv+Vk1csdks4Cs50=;
  b=lZy0BiLcYwi2jBZbscusQ2sKvyYXdRON3InEnkakUWgSBNSD5me7XD/6
   2QxObg5xN9rPhTiHXa/NdoGHm69oCYMWoqt1UpoExvkccuNV/glcRJCGt
   q+oCLFevkSIPW5w6W4FTKw+ISIjZjLCYrN/colNDyR4y1t6piA+rBf0I5
   fjl4Ntwp/yavFrXfed/T+tNg0bS8Xkds0ApTV2CThs8x3r+fvKRaht3Tj
   cHawW2R8m41hLTPjFnwx0/ym0cqDPBDLNuq/yq+hFcqY92JmCGsHrr2+W
   oxd5v9mIlPgrzBauYAnfhf5tJz0NCSUXBfdUmtIKSJBeR3hjWhV+vrL5t
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289396325"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="289396325"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 01:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="702999580"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 21 Apr 2022 01:41:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Apr 2022 11:41:34 +0300
Date:   Thu, 21 Apr 2022 11:41:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "Sandeep Maheswaram (Temp) (QUIC)" <quic_c_sanm@quicinc.com>,
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
Message-ID: <YmEYvYA0uXatStZg@kuha.fi.intel.com>
References: <1649323888-12420-1-git-send-email-quic_c_sanm@quicinc.com>
 <DM6PR02MB4857A0ADCDA1558DE58E103ADFF29@DM6PR02MB4857.namprd02.prod.outlook.com>
 <4b34735f-8e1f-bf37-398f-9b4a8aa2e939@linux.intel.com>
 <YmEL3WnyM7sa8VP9@kuha.fi.intel.com>
 <YmEXqe5IEAzZezU5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmEXqe5IEAzZezU5@kroah.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:36:57AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 21, 2022 at 10:46:37AM +0300, Heikki Krogerus wrote:
> > On Wed, Apr 20, 2022 at 04:20:52PM +0300, Mathias Nyman wrote:
> > > On 19.4.2022 13.17, Sandeep Maheswaram (Temp) (QUIC) wrote:
> > > > Hi Mathias, Felipe,
> > > > 
> > > >> -----Original Message-----
> > > >> From: Sandeep Maheswaram (Temp) (QUIC) <quic_c_sanm@quicinc.com>
> > > >> Sent: Thursday, April 7, 2022 3:01 PM
> > > >> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Felipe Balbi
> > > >> <balbi@kernel.org>; Stephen Boyd <swboyd@chromium.org>; Doug
> > > >> Anderson <dianders@chromium.org>; Matthias Kaehlcke
> > > >> <mka@chromium.org>; Mathias Nyman <mathias.nyman@intel.com>
> > > >> Cc: linux-arm-msm@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> > > >> kernel@vger.kernel.org; Pavan Kumar Kondeti (QUIC)
> > > >> <quic_pkondeti@quicinc.com>; Pratham Pratap (QUIC)
> > > >> <quic_ppratap@quicinc.com>; Krishna Kurapati PSSNV (QUIC)
> > > >> <quic_kriskura@quicinc.com>; Vidya Sagar Pulyala (Temp) (QUIC)
> > > >> <quic_vpulyala@quicinc.com>; Sandeep Maheswaram (Temp) (QUIC)
> > > >> <quic_c_sanm@quicinc.com>
> > > >> Subject: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers
> > > >>
> > > >> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
> > > >> usage value is 2 because the phy is initialized from
> > > >> DWC3 core and HCD core.
> > > >> Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
> > > >> This property can be set to avoid phy initialization in HCD core.
> > > >>
> > > >> v3:
> > > >> Coming back to this series based on discussion at below thread
> > > >> https://patchwork.kernel.org/project/linux-arm-msm/patch/1648103831-
> > > >> 12347-4-git-send-email-quic_c_sanm@quicinc.com/
> > > >> Dropped the dt bindings PATCH 1/3 in v2
> > > >> https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-
> > > >> 25582-1-git-send-email-quic_c_sanm@quicinc.com/
> > > >>
> > > >> v2:
> > > >> Updated the commit descriptions.
> > > >> Changed subject prefix from dwc to dwc3.
> > > >> Increased props array size.
> > > >>
> > > >> Sandeep Maheswaram (2):
> > > >>   usb: host: xhci-plat: Add device property to set XHCI_SKIP_PHY_INIT
> > > >>     quirk
> > > >>   usb: dwc3: host: Set the property usb-skip-phy-init
> > > >>
> > > >>  drivers/usb/dwc3/host.c      | 4 +++-
> > > >>  drivers/usb/host/xhci-plat.c | 3 +++
> > > >>  2 files changed, 6 insertions(+), 1 deletion(-)
> > > >>
> > > >> --
> > > >> 2.7.4
> > > > 
> > > > Please let me know your opinion about this series.
> > > 
> > > Otherwise looks good but wondering if we should document that new device
> > > property somewhere. 
> > > 
> > > Couldn't find a standard way how those device properties excluded from
> > > Documentation/devicetree/binding are documented
> > 
> > Couldn't it be just documented in drivers/usb/host/xhci-plat.c for now?
> 
> That's not where DT properties are documented.

It's not a DT property.

-- 
heikki
