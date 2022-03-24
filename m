Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951674E627B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbiCXLbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiCXLbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:31:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D7B1F60D;
        Thu, 24 Mar 2022 04:29:32 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="240509841"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="240509841"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 04:29:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="717783370"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 04:29:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nXLe9-005mjT-Ua;
        Thu, 24 Mar 2022 13:28:53 +0200
Date:   Thu, 24 Mar 2022 13:28:53 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] serial: 8250: Add proper clock handling for
 OxSemi PCIe devices
Message-ID: <YjxV9bsfdzdtgM6K@smile.fi.intel.com>
References: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk>
 <alpine.DEB.2.21.2106260604540.37803@angie.orcam.me.uk>
 <YOyi0cPdIVSCcpmw@surfacebook.localdomain>
 <alpine.DEB.2.21.2107130150420.9461@angie.orcam.me.uk>
 <CAHp75VfnCG-C6bUzhhC9jQGOSgMXVLZ=QtH0mdhAD85yeqBC7A@mail.gmail.com>
 <alpine.DEB.2.21.2107131504270.9461@angie.orcam.me.uk>
 <CAHp75VeS3UdK5o4cEKuT=nz+Yob9FBv6RNJ-i116pFZQTGuyuQ@mail.gmail.com>
 <alpine.DEB.2.21.2202052213110.34636@angie.orcam.me.uk>
 <YjSL34DkktVVahmy@smile.fi.intel.com>
 <alpine.DEB.2.21.2203232126220.52439@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2203232126220.52439@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:59:28PM +0000, Maciej W. Rozycki wrote:
> On Fri, 18 Mar 2022, Andy Shevchenko wrote:
> 
> > >  It does allow one to program the full clock divider range of the OxSemi 
> > > devices.  I find it appropriate according to my engineer's code of good 
> > > practices.  And it doesn't cause any burden for non-OxSemi code.
> > 
> > How BOTHER does prevent you doing the same?
> 
>  It does not allow you to set arbitrary serial port clock rates.  You can 
> only set integer baud rates,

Why do you need fractional baud rates? What is the practical use of that, please?

>	and then only those that do not exceed the [1;65535] clock divisor
>	range.

Can you be more specific as I can't see how it's possible in practice? In
several 8250 drivers we are able to set whatever we want to the limits of
the hardware.

> > >  So I have had a look at how it has been done for other drivers and I have 
> > > now convinced myself against such a split.  The primary reason for this 
> > > conclusion is that there is no basic infrastructure for such a split and 
> > > the ultimate result is code duplication with no clear benefit to justify 
> > > it.
> > 
> > Justification for split is to keep certain quirks out of the scope of the
> > generic driver. I'm not sure what duplication you are talking about if the
> > LOC statistics shows otherwise.
> 
>  All the init/remove code is almost the same across all the devices.

Each of the platform has its own constraints and what you see as a repetition
is just a similarity. If you have an idea of the common probe function, please
share.

Also, don't forget the memory footprint case at run time. In embedded world
we do not need 8250 code that is not supported by the platform in question.

The split allows to disable / remove the code that is not needed.

> And suspend/resume and PCI error handling code has been removed from the
> split off devices,

This is managed by PCI core. Any specifics, please?

>	and for the functional regression to be fixed:
> 
> 1. this code would have to be replicated, or
> 
> 2. handlers from the generic 8250_pci.c driver exported and referred to, 
>    or
> 
> 3. some kind of a helper library (or a core module) created providing this 
>    stuff to 8250_*.c drivers as required.

Which functional regression? You mean if it will be found then it needs to
be fixed in several places?

>  I guess the latter is the minimum that could convince me this driver
> framework is usable for implementing device-specific drivers (as I find 
> the other variants rather miserable hacks).
> 
>  Plus there would have to be clear information provided to the users as 
> otherwise people will be rather confused as to why 3 out of their 4 16x50 
> PCI/e serial cards work with 8250_pci.c while the remaining one does not 
> (probably broken, or is it?).

The default configuration after the split assumes that the driver is enabled
by the very same kernel configuration. Otherwise distributions will choose
what they consider better for their users and customers.

> > You may not want to get the idea, it's fine. The rationale is simple:
> > isolate quirks for certain platform(s) in one place. Each platform
> > in a separate module.
> 
>  What is a platform in your terminology?  A PCI/e option card you can 
> install in about any modern computer?  I usually think of platforms as 
> specific families of computers rather than option cards.  Variants of 
> otherwise the same device are usually handled with a single driver in 
> Linux.

It might be PCIe card, it might be soldered on the motherboard, it can
be part of the SoC.

By platform I assume the certain SoC + certain discrete components wired
in a certain way (PCB level). In your case it's a motherboard with PCIe
serial port card.

-- 
With Best Regards,
Andy Shevchenko


