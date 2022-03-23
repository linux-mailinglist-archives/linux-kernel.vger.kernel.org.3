Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905444E5AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345067AbiCWWBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiCWWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:01:00 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5577045040;
        Wed, 23 Mar 2022 14:59:29 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 963D292009D; Wed, 23 Mar 2022 22:59:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9423792009C;
        Wed, 23 Mar 2022 21:59:28 +0000 (GMT)
Date:   Wed, 23 Mar 2022 21:59:28 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
In-Reply-To: <YjSL34DkktVVahmy@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.21.2203232126220.52439@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106260539240.37803@angie.orcam.me.uk> <alpine.DEB.2.21.2106260604540.37803@angie.orcam.me.uk> <YOyi0cPdIVSCcpmw@surfacebook.localdomain> <alpine.DEB.2.21.2107130150420.9461@angie.orcam.me.uk> <CAHp75VfnCG-C6bUzhhC9jQGOSgMXVLZ=QtH0mdhAD85yeqBC7A@mail.gmail.com>
 <alpine.DEB.2.21.2107131504270.9461@angie.orcam.me.uk> <CAHp75VeS3UdK5o4cEKuT=nz+Yob9FBv6RNJ-i116pFZQTGuyuQ@mail.gmail.com> <alpine.DEB.2.21.2202052213110.34636@angie.orcam.me.uk> <YjSL34DkktVVahmy@smile.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022, Andy Shevchenko wrote:

> >  It does allow one to program the full clock divider range of the OxSemi 
> > devices.  I find it appropriate according to my engineer's code of good 
> > practices.  And it doesn't cause any burden for non-OxSemi code.
> 
> How BOTHER does prevent you doing the same?

 It does not allow you to set arbitrary serial port clock rates.  You can 
only set integer baud rates, and then only those that do not exceed the 
[1;65535] clock divisor range.

> >  So I have had a look at how it has been done for other drivers and I have 
> > now convinced myself against such a split.  The primary reason for this 
> > conclusion is that there is no basic infrastructure for such a split and 
> > the ultimate result is code duplication with no clear benefit to justify 
> > it.
> 
> Justification for split is to keep certain quirks out of the scope of the
> generic driver. I'm not sure what duplication you are talking about if the
> LOC statistics shows otherwise.

 All the init/remove code is almost the same across all the devices.  And 
suspend/resume and PCI error handling code has been removed from the split 
off devices, and for the functional regression to be fixed:

1. this code would have to be replicated, or

2. handlers from the generic 8250_pci.c driver exported and referred to, 
   or

3. some kind of a helper library (or a core module) created providing this 
   stuff to 8250_*.c drivers as required.

 I guess the latter is the minimum that could convince me this driver
framework is usable for implementing device-specific drivers (as I find 
the other variants rather miserable hacks).

 Plus there would have to be clear information provided to the users as 
otherwise people will be rather confused as to why 3 out of their 4 16x50 
PCI/e serial cards work with 8250_pci.c while the remaining one does not 
(probably broken, or is it?).

> You may not want to get the idea, it's fine. The rationale is simple:
> isolate quirks for certain platform(s) in one place. Each platform
> in a separate module.

 What is a platform in your terminology?  A PCI/e option card you can 
install in about any modern computer?  I usually think of platforms as 
specific families of computers rather than option cards.  Variants of 
otherwise the same device are usually handled with a single driver in 
Linux.

  Maciej
