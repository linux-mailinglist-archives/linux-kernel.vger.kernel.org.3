Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095A357463D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiGNH5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGNH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:57:10 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B3E5E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:57:04 -0700 (PDT)
Received: from mail-yw1-f177.google.com ([209.85.128.177]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M4K6z-1oBcjf3yPR-000Hx0 for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022
 09:57:03 +0200
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31caffa4a45so9165137b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:57:02 -0700 (PDT)
X-Gm-Message-State: AJIora+4hQtLg5msm5LdbT8oxjMlzyqMZw46hQoFE9hYTcGAudm6nyLt
        K27oM+vVQ+vSTsrWHHz/Q1+xt8oEHI4fakNagj4=
X-Google-Smtp-Source: AGRyM1s6hq6erZ1yK1nIUP2svi0ANxmBF0XKQOXZ/sRFvr5z9HEm2aKaLzHV16xP3Q8+fv2MN1haOC3UBR+vKS0ayV0=
X-Received: by 2002:a81:9b02:0:b0:31c:9ae4:99ec with SMTP id
 s2-20020a819b02000000b0031c9ae499ecmr8278547ywg.495.1657785421695; Thu, 14
 Jul 2022 00:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220714042736.2133067-1-shorne@gmail.com> <20220714042736.2133067-2-shorne@gmail.com>
In-Reply-To: <20220714042736.2133067-2-shorne@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jul 2022 09:56:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com>
Message-ID: <CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] openrisc: Add pci bus support
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GDYCbmxyCS6dcrmwKsOs12ElGFbe0tLej9O3EYZiukCeTx5wjDM
 REA3SHjIJabTM0d4gjNRFAdDSXp0uUxuNIb9LxFtElt6TRLHfiIVH4qQBc5LGoR9KXHwl0l
 O6HBqUYoAvVNR9EuqTG9a0AkN/xaxxQnn4IblhahzQ46c+Bd5P+A4Wt4u7xAx6S5lldCrqQ
 yP+LDxWbid/x1YNWEfFmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:41ryh/wyzv0=:JClpietly9qXfK4aeDt/nK
 s/F626kB3YZRLBAy5o22eGC/pAKJcScnrlUMPYs0I7RNNVwlUvS/NOsfLQSOKvMDfLgcm6pGT
 TuYY3cubOij0Bdt4ighNs4oxIPLI2BMFxGVmq1WsSX7oNo1nfws7+mfOCkIuuIyXPfgZzwoVD
 3RRONR0OIXv4cLXK0wgT7Bds15qPzv/jlabFQqZMWX+Fv6uYUreo7EcKQ+sF189WGWoP1MWKT
 Ryekv5r721bKG0njUKPnfhNLlOFoLitXwuwFO4Z29pglru+lCw4eq3wsxjpkAMRlNgkybhe1e
 3jrfl0smN80TWcOJ4v7R8/wPYwuRVYHk9STUrKToXsA3Q6LDy6Mjhdc3afq0gl9bUiQFz8Zoq
 lHQ95wIkqkotukyp01XbUklEXiClBlnxnI5lysO3YpfL4isUV4wT3MTGF/+xnf8eLmBfLZSmZ
 ZnDw9n5WWXUjKIELzh9jJusunp3+aE6p5feOv+TDyM45j9aR9sM04X/+Uj4xb78rnAePYNaLF
 fKgnVE/yLePCO8kYtwlsIBL9m9PUhqy3P2NhOCwnETx2gMwGW2nxss0mj8RO0yh0jNB7YWdvY
 1RLoqcXkdQcfhImxsAss0XPtka4isJJV+3v8iagj9C7Dsbrli+ZfMJSJbWxhDzOcqWbv6iOvz
 QPUSPxug+Q7UvDU3nzj25NOd4NPaunOC9JUD/nCBEIuobVCLRWk0uyO3EzkFcrD3jVldudTtI
 X6/bl9WyVNL05V+UVvwUKy75hyLTqGNK1Qkn0TsnyuzDsCeF/bhHjK8QKZudFP4Sfr8rtqgS4
 tki10kSRWgZAa9GRd9TexB1SI+T9sk3olEJZq+WHfTMqUOor0CjI6LgXHWmvqgEHGisjVKPb0
 G58oqyS6/JfjCVxd4vEg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 6:27 AM Stafford Horne <shorne@gmail.com> wrote:
>
> This patch adds required definitions to allow for PCI buses on OpenRISC.
> This is being in the QEMU virt platform.
>
> OpenRISC does not have IO ports so this defines PCI IO to be allowed in
> any range.  Keeping PIO_RESERVED defined as 0 allows OpenRISC to use
> MMIO for all IO.

Ok, this looks better.

> Also, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
> systems") all platforms that support PCI also need to support parallel
> port.  We add a generic header to support parallel port drivers.

The parport_pc driver is actually one of the things that doesn't work without
I/O ports, so at least the description here is misleading. We should really
have Kconfig logic to enforce this, but that is a separate topic.

> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index e814df4c483c..327241988819 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -21,7 +21,9 @@ config OPENRISC
>         select GENERIC_IRQ_PROBE
>         select GENERIC_IRQ_SHOW
>         select GENERIC_IOMAP
> +       select GENERIC_PCI_IOMAP
>         select GENERIC_CPU_DEVICES

> @@ -46,9 +50,6 @@ config MMU
>  config GENERIC_HWEIGHT
>         def_bool y
>
> -config NO_IOPORT_MAP
> -       def_bool y
> -

GENERIC_IOMAP makes no sense without PIO, and I think you also
need to keep the NO_IOPORT_MAP. I think you still want
GENERIC_PCI_IOMAP, which in the absence of the other two
should turn just return an __iomem pointer for memory resource
and NULL for i/o resources.

> +static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> +{
> +       /* no legacy IRQs on or1k */
> +       return -ENODEV;
> +}

The comment seems misleading, as "legacy IRQs" normally refers to
non-MSI interrupts, which you do support. It's only the legacy IDE
interrupts that are not supported.

I see that the asm-generic/pci.h file is now completely useless,
as it only has a single function left in it, and this one is wrong
on most architectures -- it only works when you have PC-style
interrupt numbers. Out of the five architectures that include
asm-generic/pci.h  (m68k, s390, sparc, x86, xtensa), I would
expect only x86 to use this version, and maybe a few sparc
machines.

Can I ask you to move out the existing asm-generic/pci.h
code into those architectures, and add a new file in its place
that you can use as-is on openrisc? Ideally we should
be able to also remove most of the contents of asm/pci.h
on arm64 and riscv. If you have conflicting settings, the normal
way to handle them in asm-generic headers is like

#ifndef PCIBIOS_MIN_IO
#define PCIBIOS_MIN_IO 0
#endif

#ifndef pcibios_assign_all_busses
#define pcibios_assign_all_busses() 1
#endif

       Arnd
