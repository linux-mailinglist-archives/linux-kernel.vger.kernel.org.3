Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FFB4CA63F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbiCBNqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiCBNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:46:07 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6D625C84A;
        Wed,  2 Mar 2022 05:45:23 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6DD9192009C; Wed,  2 Mar 2022 14:45:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6929692009B;
        Wed,  2 Mar 2022 13:45:22 +0000 (GMT)
Date:   Wed, 2 Mar 2022 13:45:22 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Icenowy Zheng <icenowy@aosc.io>
cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
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
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
In-Reply-To: <8e799cadb1104714f998fe74e40b3cb052c9c1ed.camel@aosc.io>
Message-ID: <alpine.DEB.2.21.2203021337430.58475@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk> <8e799cadb1104714f998fe74e40b3cb052c9c1ed.camel@aosc.io>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022, Icenowy Zheng wrote:

> > The only PCI platforms that actually can't make use of PC-style
> > parallel 
> > port hardware are those newer PCIe systems that have no support for
> > I/O 
> > cycles in the host bridge, required by such parallel ports.  Notably,
> > this includes the s390 arch, which has port I/O accessors that cause 
> > compilation warnings (promoted to errors with `-Werror'), and there
> > are 
> > other cases such as the POWER9 PHB4 device, though this one has
> > variable 
> > port I/O accessors that depend on the particular system.  Also it is
> > not 
> > clear whether the serial port side of devices enabled by
> > PARPORT_SERIAL 
> > uses port I/O or MMIO.  Finally Super I/O solutions are always either
> > ISA or platform devices.
> 
> Just spot this patch in linux-riscv mailing list, I think there's a
> pending patchset that tries to add a HAS_IOPORT Kconfig option, which
> can be used in this situation.

 Thanks for your input.

 That has been actually discussed already with a conclusion that more work 
is required to have HAS_IOPORT supported, see the thread starting from: 
<https://lore.kernel.org/lkml/CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com/>. 
(there's a reference to the HAS_IOPORT patchset there as well).  Once that 
has been sorted configuration conditions for the parport driver can be 
updated accordingly.  For the time being the !S390 qualification should 
do.

  Maciej
