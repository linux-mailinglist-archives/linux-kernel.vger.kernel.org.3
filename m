Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45223509C53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387690AbiDUJe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387677AbiDUJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:34:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4E1572F;
        Thu, 21 Apr 2022 02:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6916AB823A7;
        Thu, 21 Apr 2022 09:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B45BC385A1;
        Thu, 21 Apr 2022 09:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650533522;
        bh=5tCYODYe4IUZwtg/8f/XY3fbdkY0KtrDaNGpzi8qFUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yfswzQHoys+STXSwb/IAa5il79nk+s0bn4xbXaq3LJUY4T+natHRxo3gFMZnnHrbr
         qWtKCmV/Tu/jUBHnKejgruocGkKwQ0AY/s+DLkOHXVgjQPhCrkzNF0uLywNsqc1x/4
         z88Hhlly+u+82ml4UqP+bBAjzPnflGgUiB3akSNY=
Date:   Thu, 21 Apr 2022 11:31:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
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
Message-ID: <YmEkj3/6+9gvgqAx@kroah.com>
References: <1649323888-12420-1-git-send-email-quic_c_sanm@quicinc.com>
 <DM6PR02MB4857A0ADCDA1558DE58E103ADFF29@DM6PR02MB4857.namprd02.prod.outlook.com>
 <4b34735f-8e1f-bf37-398f-9b4a8aa2e939@linux.intel.com>
 <YmEL3WnyM7sa8VP9@kuha.fi.intel.com>
 <YmEXqe5IEAzZezU5@kroah.com>
 <YmEYvYA0uXatStZg@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmEYvYA0uXatStZg@kuha.fi.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:41:33AM +0300, Heikki Krogerus wrote:
> On Thu, Apr 21, 2022 at 10:36:57AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 21, 2022 at 10:46:37AM +0300, Heikki Krogerus wrote:
> > > On Wed, Apr 20, 2022 at 04:20:52PM +0300, Mathias Nyman wrote:
> > > > On 19.4.2022 13.17, Sandeep Maheswaram (Temp) (QUIC) wrote:
> > > > > Hi Mathias, Felipe,
> > > > > 
> > > > >> -----Original Message-----
> > > > >> From: Sandeep Maheswaram (Temp) (QUIC) <quic_c_sanm@quicinc.com>
> > > > >> Sent: Thursday, April 7, 2022 3:01 PM
> > > > >> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Felipe Balbi
> > > > >> <balbi@kernel.org>; Stephen Boyd <swboyd@chromium.org>; Doug
> > > > >> Anderson <dianders@chromium.org>; Matthias Kaehlcke
> > > > >> <mka@chromium.org>; Mathias Nyman <mathias.nyman@intel.com>
> > > > >> Cc: linux-arm-msm@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> > > > >> kernel@vger.kernel.org; Pavan Kumar Kondeti (QUIC)
> > > > >> <quic_pkondeti@quicinc.com>; Pratham Pratap (QUIC)
> > > > >> <quic_ppratap@quicinc.com>; Krishna Kurapati PSSNV (QUIC)
> > > > >> <quic_kriskura@quicinc.com>; Vidya Sagar Pulyala (Temp) (QUIC)
> > > > >> <quic_vpulyala@quicinc.com>; Sandeep Maheswaram (Temp) (QUIC)
> > > > >> <quic_c_sanm@quicinc.com>
> > > > >> Subject: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers
> > > > >>
> > > > >> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
> > > > >> usage value is 2 because the phy is initialized from
> > > > >> DWC3 core and HCD core.
> > > > >> Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
> > > > >> This property can be set to avoid phy initialization in HCD core.
> > > > >>
> > > > >> v3:
> > > > >> Coming back to this series based on discussion at below thread
> > > > >> https://patchwork.kernel.org/project/linux-arm-msm/patch/1648103831-
> > > > >> 12347-4-git-send-email-quic_c_sanm@quicinc.com/
> > > > >> Dropped the dt bindings PATCH 1/3 in v2
> > > > >> https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-
> > > > >> 25582-1-git-send-email-quic_c_sanm@quicinc.com/
> > > > >>
> > > > >> v2:
> > > > >> Updated the commit descriptions.
> > > > >> Changed subject prefix from dwc to dwc3.
> > > > >> Increased props array size.
> > > > >>
> > > > >> Sandeep Maheswaram (2):
> > > > >>   usb: host: xhci-plat: Add device property to set XHCI_SKIP_PHY_INIT
> > > > >>     quirk
> > > > >>   usb: dwc3: host: Set the property usb-skip-phy-init
> > > > >>
> > > > >>  drivers/usb/dwc3/host.c      | 4 +++-
> > > > >>  drivers/usb/host/xhci-plat.c | 3 +++
> > > > >>  2 files changed, 6 insertions(+), 1 deletion(-)
> > > > >>
> > > > >> --
> > > > >> 2.7.4
> > > > > 
> > > > > Please let me know your opinion about this series.
> > > > 
> > > > Otherwise looks good but wondering if we should document that new device
> > > > property somewhere. 
> > > > 
> > > > Couldn't find a standard way how those device properties excluded from
> > > > Documentation/devicetree/binding are documented
> > > 
> > > Couldn't it be just documented in drivers/usb/host/xhci-plat.c for now?
> > 
> > That's not where DT properties are documented.
> 
> It's not a DT property.

Then what is it and why are the other properties documented?

Anyway, a new series has been submitted that does document this so I
don't think it's an argument anymore :)
