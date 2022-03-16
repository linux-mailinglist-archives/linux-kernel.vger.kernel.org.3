Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC034DB817
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357762AbiCPSrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiCPSrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:47:01 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 183073C4B1;
        Wed, 16 Mar 2022 11:45:47 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id AFA5D92009C; Wed, 16 Mar 2022 19:45:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AC40D92009B;
        Wed, 16 Mar 2022 18:45:45 +0000 (GMT)
Date:   Wed, 16 Mar 2022 18:45:45 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
In-Reply-To: <CADVatmP4sPwyqi6vKPm3QOFD=47w1LwXtsUynhecY4wMYGhXmw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2203161837130.24248@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk> <CADVatmP4sPwyqi6vKPm3QOFD=47w1LwXtsUynhecY4wMYGhXmw@mail.gmail.com>
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

On Wed, 2 Mar 2022, Sudip Mukherjee wrote:

> > Make the PARPORT_PC option selectable also for PCI systems then, except
> > for the s390 arch, however limit the availability of PARPORT_PC_SUPERIO
> > to platforms that enable ARCH_MIGHT_HAVE_PC_PARPORT.  Update platforms
> > accordingly for the required <asm/parport.h> header.
> >
> > Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> 
> Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> 
> Usually parport patches goes via Greg's tree. Adding Greg.

 Thank you.  I have since been able to move my parport card to my RISC-V 
machine, and the result is as follows:

parport_pc 0000:07:00.0: enabling device (0000 -> 0001)
PCI parallel port detected: 1415:c118, I/O at 0x8(0x4), IRQ 38
parport0: PC-style at 0x8 (0x4), irq 38, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
lp0: using parport0 (interrupt-driven).

with the patch from:

<https://lore.kernel.org/lkml/alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk/>

also applied so as to prevent I/O port 0 from being assigned by PCI code 
that wouldn't actually work (so allocation for the two BARs is at 0x4 and 
0x8 instead).

  Maciej
