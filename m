Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792F846E583
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhLIJ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:29:41 -0500
Received: from elvis.franken.de ([193.175.24.41]:38009 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233327AbhLIJ3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:29:40 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mvFgg-0001er-00; Thu, 09 Dec 2021 10:26:02 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 05554C4E11; Thu,  9 Dec 2021 10:21:08 +0100 (CET)
Date:   Thu, 9 Dec 2021 10:21:08 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Do not define pci_remap_iospace() under
 MACH_LOONGSON64
Message-ID: <20211209092108.GA6981@alpha.franken.de>
References: <1637139795-3032-1-git-send-email-yangtiezhu@loongson.cn>
 <20211207170603.GA20028@alpha.franken.de>
 <CAMhs-H-3FRV2hDKbRR=A2M2fsaengTtTBF7HxCnrtGi=fziK-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H-3FRV2hDKbRR=A2M2fsaengTtTBF7HxCnrtGi=fziK-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 02:47:56PM +0100, Sergio Paracuellos wrote:
> > -#endif
> > -
> >  #ifdef CONFIG_PCI_DRIVERS_LEGACY
> >
> >  /*
> > diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
> > index 18eb8a453a86..d2d68bac3d25 100644
> > --- a/arch/mips/pci/pci-generic.c
> > +++ b/arch/mips/pci/pci-generic.c
> > @@ -47,6 +47,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
> >         pci_read_bridge_bases(bus);
> >  }
> >
> > +#ifdef pci_remap_iospace
> >  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> >  {
> >         unsigned long vaddr;
> > @@ -60,3 +61,4 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
> >         set_io_port_base(vaddr);
> >         return 0;
> >  }
> > +#endif
> 
> I agree this is cleaner than the CONFIG_MACH_LOONGSON64 ifdef stuff. I
> have tested this changes in mt7621 ralink platform and all seem to
> work, so in case you want to include this, feel free to add my:

thank you for testing.

> Tested-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> 
> Thomas, if you prefer me to send this as a more formal PATCH, please
> let me know.

Thiezhu already did, I'll add your tags the new patch.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
