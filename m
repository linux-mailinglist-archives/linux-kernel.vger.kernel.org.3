Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987484B4588
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiBNJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:21:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiBNJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:21:34 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA17F5F8EB;
        Mon, 14 Feb 2022 01:21:26 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9FDA792009C; Mon, 14 Feb 2022 10:21:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 973DC92009B;
        Mon, 14 Feb 2022 09:21:25 +0000 (GMT)
Date:   Mon, 14 Feb 2022 09:21:25 +0000 (GMT)
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
In-Reply-To: <e5ec2e3be2e70e690bd9112bd23297d05a2993e6.camel@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2202140917540.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202122313460.34636@angie.orcam.me.uk> <CAMuHMdW-utcFzCZTgqONjxs=U662nF0=aBQu7Zi7FBQouwiA3g@mail.gmail.com> <e5ec2e3be2e70e690bd9112bd23297d05a2993e6.camel@linux.ibm.com>
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

> > > --- linux-macro.orig/drivers/parport/Kconfig
> > > +++ linux-macro/drivers/parport/Kconfig
> > > @@ -42,7 +42,7 @@ if PARPORT
> > > 
> > >  config PARPORT_PC
> > >         tristate "PC-style hardware"
> > > -       depends on ARCH_MIGHT_HAVE_PC_PARPORT
> > > +       depends on ARCH_MIGHT_HAVE_PC_PARPORT || PCI
> 
> This would allow selecting PARPORT_PC on s390 e.g. for allyesconfig and
> randconfig and like POWER9 we definitely do not support I/O port
> access.

 I guess we'll have to stop it with !S390 then short-term.  I don't think 
an issue with s390 should be blocking all the other platforms that can use 
these drivers just fine.  I'll post v2 with that installed if you agree.

  Maciej
