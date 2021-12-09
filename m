Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E303846E46E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhLIIoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:44:22 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:37766 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhLIIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:44:21 -0500
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 26E5D800204B;
        Thu,  9 Dec 2021 11:40:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 26E5D800204B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1639039241;
        bh=rOcoTfjRSCRchgIuYZjTj+60s0rm+FkZVRl2tknoAWw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=dUau/5goq4H5p5k0bZDgQxrh6FYYQV5uabZl+6ilNUQkBbZ2P8MyZ21b+bAGnthf3
         beyaM5iIZEQ/+Xud3M11MdOhcVMeglkbD53XFPq1vdzQWkqfd/NSs0rGmS7Ry03CMx
         X6n4KYAip1FadVZJiSBxITUDH8LnLqreC5yWP4eA=
Received: from mobilestation (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 9 Dec 2021 11:40:12 +0300
Date:   Thu, 9 Dec 2021 11:40:40 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
CC:     - Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: Re: [PATCH v3 3/5] spi: dw: Add support for master mode selection
 for DWC SSI controller
Message-ID: <20211209084040.623u3nqfxxdmsyme@mobilestation>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-4-nandhini.srikandan@intel.com>
 <YY0lpZkIsJih+g2o@sirena.org.uk>
 <20211111145246.dj4gogl4rlbem6qc@mobilestation>
 <YY0zUjjVobtg85o6@sirena.org.uk>
 <20211111160627.fcgrvj2k7x3lwtkp@mobilestation>
 <YY1D3tM4fg8h6mmj@sirena.org.uk>
 <20211116191542.vc42cxvflzn66ien@mobilestation>
 <BN0PR11MB5727E5AF778F8B504F009554859A9@BN0PR11MB5727.namprd11.prod.outlook.com>
 <SJ0PR11MB5816530165EEFCE780F1CDB0856F9@SJ0PR11MB5816.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5816530165EEFCE780F1CDB0856F9@SJ0PR11MB5816.namprd11.prod.outlook.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:03:03AM +0000, Srikandan, Nandhini wrote:
> 
> 
> > -----Original Message-----
> > From: Srikandan, Nandhini
> > Sent: Wednesday, November 17, 2021 5:29 PM
> > To: Serge Semin <fancer.lancer@gmail.com>; Mark Brown
> > <broonie@kernel.org>
> > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; robh+dt@kernel.org;
> > linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; mgross@linux.intel.com; Pan, Kris
> > <kris.pan@intel.com>; Demakkanavar, Kenchappa
> > <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> > <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> > <mahesh.r.vaidya@intel.com>; A, Rashmi <Rashmi.A@intel.com>
> > Subject: RE: [PATCH v3 3/5] spi: dw: Add support for master mode selection
> > for DWC SSI controller
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Serge Semin <fancer.lancer@gmail.com>
> > > Sent: Wednesday, November 17, 2021 12:46 AM
> > > To: Mark Brown <broonie@kernel.org>; Srikandan, Nandhini
> > > <nandhini.srikandan@intel.com>
> > > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>;
> > > robh+dt@kernel.org; linux-spi@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> > > Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> > > <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > > <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> > > <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> > > Subject: Re: [PATCH v3 3/5] spi: dw: Add support for master mode
> > > selection for DWC SSI controller
> > >
> > > On Thu, Nov 11, 2021 at 04:25:02PM +0000, Mark Brown wrote:
> > > > On Thu, Nov 11, 2021 at 07:06:27PM +0300, Serge Semin wrote:
> > > > > On Thu, Nov 11, 2021 at 03:14:26PM +0000, Mark Brown wrote:
> > > >
> > > > > > Given that people seem to frequently customise these IPs when
> > > > > > integrating them I wouldn't trust people not to have added some
> > > > > > other control into that reserved bit doing some magic stuff
> > > > > > that's useful in their system.
> > > >
> > > > > In that case the corresponding platform code would have needed to
> > > > > have that peculiarity properly handled and not to use a generic
> > > > > compatibles like "snps,dwc-ssi-1.01a" or "snps,dw-apb-ssi", which
> > > > > are supposed to be utilized for the default IP-core configs only.
> > > > > For the sake of the code simplification I'd stick to setting that
> > > > > flag for each generic DWC SSI-compatible device. That will be also
> > > > > helpful for DWC SSIs which for some reason have the slave-mode
> > > enabled by default.
> > > >
> > >
> > > > That's easier right up until the point where it explodes - I'd
> > > > prefer to be more conservative here.  Fixing things up after the
> > > > fact gets painful when people end up only finding the bug in
> > > > released kernels, especially if it's distro end users or similar rather than
> > developers.
> > >
> > > Since IP-core and components versions is now supported that will easy
> > > to implement. Thanks for merging the corresponding series in BTW.
> > >
> > > >
> > > > > Alternatively the driver could read the IP-core version from the
> > > > > DW_SPI_VERSION register, parse it (since it's in ASCII) and then
> > > > > use it in the conditional Master mode activation here. But that
> > > > > could have been a better solution in case if the older IP-cores
> > > > > would have used that bit for something special, while Nandhini
> > > > > claims it was
> > > reserved.
> > > > > So in this case I would stick with a simpler approach until we get
> > > > > to face any problem in this matter, especially seeing we already
> > > > > pocking the reserved bits of the CTRL0 register in this driver in
> > > > > the
> > > > > spi_hw_init() method when it comes to the DFS field width detection.
> > > >
> > > > If the device has a version register checking that seems ideal - the
> > > > infrastructure will most likely be useful in future anyway.  A bit
> > > > of a shame that it's an ASCII string though.
> > >
> > > That's what the patchset has been implemented for in the first place
> > > https://lore.kernel.org/linux-spi/20211115181917.7521-1-
> > > Sergey.Semin@baikalelectronics.ru/
> > >
> > > Nandhini, Mark has just merged in the series that adds the IP-core
> > > versions infrastructure support to the DW SSI driver.  So now you can
> > > easily convert this patch to be using that new interface like this:
> > > -               if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > > -                       cr0 |= DWC_SSI_CTRLR0_KEEMBAY_MST;
> > > +               /* CTRLR0[31] MST */
> > > +		if (dw_spi_ver_is_ge(dws, HSSI, 102A))
> > > +       	        cr0 |= DWC_HSSI_CTRLR0_MST;
> > >
> > > Please don't forget to convert the DWC_SSI_CTRLR0_KEEMBAY_MST name
> > to
> > > something like DWC_HSSI_CTRLR0_MST and place it at the top of the DWC
> > > HSSI CTRLR0 register macros list.
> > >
> > > -Sergey
> > Sure, I will test this patch set on our hardware and then use the IP-core
> > version infrastructure support and make the changes as mentioned for MST
> > bit.
> > 
> > - Nandhini

> I have tested the patches on our hardware and it is working fine. When would these patches be available in mainline? So that I can start applying the changes on top of these patches and share for review.
> - Nandhini 

These changes have been merged into the Mark' repo in the spi-next
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-next
The series together with the rest of the SPI-related changed will get
into the mainline during the merge window.
For the time being you can rebase your patches on top of the Mark' repo
and if it works well for you just post it out for review. If it looks
good you'll even be able to have your series merged into the kernel in
the next merge-window.

-Sergey

> 
