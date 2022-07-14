Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED14574DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiGNMll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiGNMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:41:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D45E312
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:41:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so8612120pjn.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3h9c3FGTTpmVX++3flAulp3WHcv9mbKiAG+klxgd4Fg=;
        b=koV+yx9nkANm2Uhwc2mx1p5TDVvFO0Pq9026BPOplyIfNkRQxR172QmsM1iZZsRR0l
         hTZhVAPjokJ1WmwxCpkdz76SFFZ3He+2CS/3yu1+4Xyue49Ut0nmEAIIABtBjBscI2F/
         FKVi/u/gYbZdU8Sjtrc14gSnroHF3rwWZ3nAffq6mqA9dts50OcbA3G9RGCUKyhKGg26
         MIRADkVdUR9D6S+BcW95uBk9BFrtNobrOQbqU2cyC6Aq2UFQRrUfNaXMwOKRkAvbGoe5
         6ORcFKNWFQ7U6VUZ9m5tbj1Wh2kPtZMhEC8niQc1stGNKl83l04Qi80Df9lC1uTd+1dQ
         UQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3h9c3FGTTpmVX++3flAulp3WHcv9mbKiAG+klxgd4Fg=;
        b=j1+MidZC4u4qF83cJsxQLa2WIJv5AaowQS7jMpwrTyNxb2yTO3Jg7eU4A9tMsXPqWa
         pjYOvgWKkUwgmjtiVK0Uh4a/U0GrpSRr1r5wHUI314Qz1SqdziKVXGCjn+MBTtC00/n+
         0ggPKZn/9OiMpPk8/z2e9R+NMLUqrtj9qDGpX19fTvgKBFg9iIk87Wt7a6zvZtqZ+JoR
         qQOS9tGwtgPzEWlcFEviynSAcBzjrNlB+Q1lCXfnj1CqvYzA31Eg8Gn7CdoNU/sewenQ
         3coFETL2buDP8UA33H8XHmOVoVqx0V6ASk53r7j+vUXb9yPySi1nIu1oajjglB09CszV
         HN3Q==
X-Gm-Message-State: AJIora/QZckgoDMISmF460waNFUdyqOmYFRf02ZM697SDvSTYx9Erlcj
        C7upW4u4PkxXxbHqL4nKdwA=
X-Google-Smtp-Source: AGRyM1uZUUoWrMws0sOG5cPzaHob5mxbfrBC/vfZxXW6L7AasRxArG6rpLgplExROVPACGPcJXcKlg==
X-Received: by 2002:a17:90b:3811:b0:1ef:e647:ff34 with SMTP id mq17-20020a17090b381100b001efe647ff34mr9875511pjb.171.1657802496327;
        Thu, 14 Jul 2022 05:41:36 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016c1cdd2de3sm1375408plg.281.2022.07.14.05.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:41:36 -0700 (PDT)
Date:   Thu, 14 Jul 2022 21:41:34 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] openrisc: Add pci bus support
Message-ID: <YtAO/nxcsjjc8M/c@antec>
References: <20220714042736.2133067-1-shorne@gmail.com>
 <20220714042736.2133067-2-shorne@gmail.com>
 <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:56:44AM +0200, Arnd Bergmann wrote:
> On Thu, Jul 14, 2022 at 6:27 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > This patch adds required definitions to allow for PCI buses on OpenRISC.
> > This is being in the QEMU virt platform.
> >
> > OpenRISC does not have IO ports so this defines PCI IO to be allowed in
> > any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
> > MMIO for all IO.
> 
> Ok, this looks better.
> 
> > Also, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
> > systems") all platforms that support PCI also need to support parallel
> > port.  We add a generic header to support parallel port drivers.
> 
> The parport_pc driver is actually one of the things that doesn't work without
> I/O ports, so at least the description here is misleading. We should really
> have Kconfig logic to enforce this, but that is a separate topic.

OK, let me try to fix up this comment in v3.

> > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > index e814df4c483c..327241988819 100644
> > --- a/arch/openrisc/Kconfig
> > +++ b/arch/openrisc/Kconfig
> > @@ -21,7 +21,9 @@ config OPENRISC
> >         select GENERIC_IRQ_PROBE
> >         select GENERIC_IRQ_SHOW
> >         select GENERIC_IOMAP
> > +       select GENERIC_PCI_IOMAP
> >         select GENERIC_CPU_DEVICES
> 
> > @@ -46,9 +50,6 @@ config MMU
> >  config GENERIC_HWEIGHT
> >         def_bool y
> >
> > -config NO_IOPORT_MAP
> > -       def_bool y
> > -

I tried the below patch on top of this but I get failures, as the __pci_ioport_map
uses ioport_map.

    lib/pci_iomap.c: In function 'pci_iomap_range':
      CC      drivers/i2c/i2c-core-base.o
    ./include/asm-generic/pci_iomap.h:29:41: error: implicit declaration of function 'ioport_map'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
       29 | #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
	  |                                         ^~~~~~~~~~
    lib/pci_iomap.c:44:24: note: in expansion of macro '__pci_ioport_map'
       44 |                 return __pci_ioport_map(dev, start, len);
	  |                        ^~~~~~~~~~~~~~~~


diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 327241988819..c7f282f60f64 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -20,7 +20,6 @@ config OPENRISC
        select GENERIC_IRQ_CHIP
        select GENERIC_IRQ_PROBE
        select GENERIC_IRQ_SHOW
-       select GENERIC_IOMAP
        select GENERIC_PCI_IOMAP
        select GENERIC_CPU_DEVICES
        select HAVE_PCI
@@ -50,6 +49,9 @@ config MMU
 config GENERIC_HWEIGHT
        def_bool y
 
+config NO_IOPORT_MAP
+       def_bool y
+
 # For now, use generic checksum functions
 #These can be reimplemented in assembly later if so inclined
 config GENERIC_CSUM


> GENERIC_IOMAP makes no sense without PIO, and I think you also
> need to keep the NO_IOPORT_MAP. I think you still want
> GENERIC_PCI_IOMAP, which in the absence of the other two
> should turn just return an __iomem pointer for memory resource
> and NULL for i/o resources.

OK.

If we keep NO_IOPORT_MAP, it causes HAS_IOPORT_MAP to be false and it removes
the definition of ioport_map which still seems to be needed at link time.  Maybe
thats an issue though.

> > +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > +{
> > +       /* no legacy IRQs on or1k */
> > +       return -ENODEV;
> > +}
> 
> The comment seems misleading, as "legacy IRQs" normally refers to
> non-MSI interrupts, which you do support. It's only the legacy IDE
> interrupts that are not supported.

OK, I might have copied this from another architecture.  I will check if those
comments should be updated too.

> I see that the asm-generic/pci.h file is now completely useless,
> as it only has a single function left in it, and this one is wrong
> on most architectures -- it only works when you have PC-style
> interrupt numbers. Out of the five architectures that include
> asm-generic/pci.h  (m68k, s390, sparc, x86, xtensa), I would
> expect only x86 to use this version, and maybe a few sparc
> machines.
> 
> Can I ask you to move out the existing asm-generic/pci.h
> code into those architectures, and add a new file in its place
> that you can use as-is on openrisc? Ideally we should
> be able to also remove most of the contents of asm/pci.h
> on arm64 and riscv. If you have conflicting settings, the normal
> way to handle them in asm-generic headers is like

Yeah, that sounds like a good plan,

> #ifndef PCIBIOS_MIN_IO
> #define PCIBIOS_MIN_IO 0
> #endif
> 
> #ifndef pcibios_assign_all_busses
> #define pcibios_assign_all_busses() 1
> #endif

OK.

-Stafford
