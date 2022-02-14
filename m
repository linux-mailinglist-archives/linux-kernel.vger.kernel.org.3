Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8D4B5B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiBNUpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:45:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiBNUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:45:29 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2851524287C;
        Mon, 14 Feb 2022 12:42:47 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2C98292009E; Mon, 14 Feb 2022 21:42:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 221CC92009D;
        Mon, 14 Feb 2022 20:42:05 +0000 (GMT)
Date:   Mon, 14 Feb 2022 20:42:05 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport_pc: Also enable driver for PCI systems
In-Reply-To: <624931c5da90387324a97be57745b13af4738bda.camel@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2202142018060.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202122313460.34636@angie.orcam.me.uk>  <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com>  <alpine.DEB.2.21.2202140833290.34636@angie.orcam.me.uk>
 <624931c5da90387324a97be57745b13af4738bda.camel@linux.ibm.com>
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

On Mon, 14 Feb 2022, Niklas Schnelle wrote:

> > While older versions of the driver did have to be explicitly configured 
> > for MMIO rather than port I/O, a feature added with commit e89a2cfb7d7b 
> > ("[TC] defxx: TURBOchannel support"), the driver has been improved with 
> > commit 795e272e5474 ("FDDI: defxx: Implement dynamic CSR I/O address space 
> > selection") and the selection of the I/O space to use now fully automatic.
> 
> Very interesting and thanks for the input! On s390 we really only have
> very few different PCI devices and I can only test another hand full
> with my private x86 and ARM systems.

 Note that for TURBOchannel support, which is likewise MMIO only, the 
driver has this:

#if defined(CONFIG_EISA) || defined(CONFIG_PCI)
#define dfx_use_mmio bp->mmio
#else
#define dfx_use_mmio true
#endif

so if your proposal to add HAS_IOPORT goes forward it'll be enough if we 
update the condition to:

#if defined(CONFIG_HAS_IOPORT)

or maybe even rewrite the entire piece as:

#define dfx_use_mmio (!IS_ENABLED(CONFIG_HAS_IOPORT) || bp->mmio)

and all the port I/O stuff will be optimised away by the compiler.  The 
only part of the driver that actually cannot do without port I/O is EISA 
support, which uses the EISA slot port I/O space for BAR accesses even 
if the actual CSR block has been set up to be decoded in the MMIO space.

> >  Then what about the other FDDI driver there, SKFP?  It's not marked as
> > LEGACY_PCI, although it's not selectable anyway due to the dependency of 
> > FDDI on LEGACY_PCI.
> > 
> >  Niklas, what was the criterion for placing the LEGACY_PCI dependency?
> 
> Hmm, honestly I haven't really worked on this recently. There were some
> open questions from Bjorn towards Arnd and I was waiting for his reply
> but I guess he missed those. I think what you noticed was the main
> problem, there wasn't really a clear set of criteria for LEGACY_PCI and
> even for HAS_IOPORT we missed some uses if they were not compiled on
> s390's allyesconfig due to other dependencies.

 A dynamic boolean variable might be good having for platforms which may 
or may not have PCI port I/O available depending on the specific system 
model in addition to a compile-time constant of HAS_IOPORT.  I looked 
into it briefly in the context of the POWER9 system when I got it back 
in 2020, but figured out it wasn't straightforward enough and decided I 
could not afford the time for a proper investigation.

> >  Also do you plan to post an updated series anytime soon?  I'm asking 
> > because like with the m68k port also the MIPS one needs a more finegrained 
> > approach and I suspect there may be other corner cases and I'd rather look 
> > at the most recent version of your series.  Otherwise I'll have a look 
> > through your original submission, but it may have to wait until the next 
> > weekend due to my other commitments.
> 
> That sounds like you do see a need for something like HAS_IOPORT too,
> correct? Maybe with some input what you need and possibly stripping the
> LEGACY_PCI option it might make sense to do a new version. Rather than
> possibly getting in your way could directly work in your input.

 Yes, it does seem to me like a good direction, but will surely require 
some coordination from platform and driver maintainers, as it's not 
always easy for someone not familiar with a specific piece what the 
context is (such as with the defxx driver as I noted above).

  Maciej
