Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD457507A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiGNOMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbiGNOM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:12:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDCF5F980;
        Thu, 14 Jul 2022 07:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D09F0CE27C4;
        Thu, 14 Jul 2022 14:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B9FC34114;
        Thu, 14 Jul 2022 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657807935;
        bh=8fBfjFECA4prmKNVhYJ0IJWUT9G/Hd/flA0UAeza7Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Sn+Vb2lm4WCBLgAy9MkxbYMFMMXKKx1sWr4qY5ZJcTqUP5Gy13Q/LbCAeV4PyY6C
         zvADvB4YQxk4A4UCQoAg2Wjd9jVsJ+MFdW1YI2R/7/88hTShda6SqfqsM0YUcIXPbg
         HgEsIh67KCNLVXxO87wPDP3n5pZdpg/WRTHTmO8s=
Date:   Thu, 14 Jul 2022 15:49:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Kao, Ben" <ben.kao@intel.com>
Cc:     "Nyman, Mathias" <mathias.nyman@intel.com>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xhci-pci: Enable runtime PM on Alder Lake-N PCH xHCI
 controller
Message-ID: <YtAe7eNMju8EdFTE@kroah.com>
References: <20220712122442.22504-1-ben.kao@intel.com>
 <Ys1sxRT0i/NXSui7@kroah.com>
 <SN6PR11MB32930FD21F5C00DB8A8429A0ED889@SN6PR11MB3293.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB32930FD21F5C00DB8A8429A0ED889@SN6PR11MB3293.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:06:44AM +0000, Kao, Ben wrote:
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, July 12, 2022 8:45 PM
> > To: Kao, Ben <ben.kao@intel.com>
> > Cc: Nyman, Mathias <mathias.nyman@intel.com>;
> > mathias.nyman@linux.intel.com; linux-usb@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] xhci-pci: Enable runtime PM on Alder Lake-N PCH xHCI
> > controller
> > 
> > On Tue, Jul 12, 2022 at 08:24:42PM +0800, Ben Kao wrote:
> > > There are two Alder Lake-N xHCI host controllers with PCI IDs 0x464e
> > > and 0x54ed, now we add the quirk to default enable runtime PM for
> > > 0x54ed.
> > >
> > > Signed-off-by: Ben Kao <ben.kao@intel.com>
> > > ---
> > >  drivers/usb/host/xhci-pci.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > > index dce6c0ec8d34..44486156bd5d 100644
> > > --- a/drivers/usb/host/xhci-pci.c
> > > +++ b/drivers/usb/host/xhci-pci.c
> > > @@ -61,6 +61,7 @@
> > >  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI		0x461e
> > >  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI
> > 	0x464e
> > >  #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI	0x51ed
> > > +#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
> > 
> > I think we ask this every time, but why don't we enable this for all devices
> > and then only disable it for the tiny number that don't need it?
> Got it, I will provide another patch to enable runtime PM by default for all
> Intel devices if no one has concerns.

Please test to verify that it works on the systems you enable it for and
verify that future devices will also work properly.

thanks,

greg k-h
