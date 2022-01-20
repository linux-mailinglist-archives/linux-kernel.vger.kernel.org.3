Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC86E49484A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359006AbiATHbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:31:09 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44414
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358998AbiATHbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:31:07 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C0413FFD9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642663866;
        bh=dCQXkZtZ/VwDrAN2uVWBP6tsU2v5k0SPHuefqy0UyIg=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QY9c4CmA2B0fCLINQxScRrlFnye6e+xIpXsexgjVD1ajLPA41zjTMg84iOM1ksesU
         2FtSkhzogQhbTP/dUIPkYMtB/YEPk7XBM1U8HNEk9bw8r14QV+11+1MM94QXA3Y76Z
         cP44PF01Xk89MlSIO+9N4poolMrDkgqTv0mLx7Im9SUsAwY0veo9ZJEalKK0cFtDhS
         CPgFNnPlgbQRu+CsDk1CuyTe2li2NTF3xmuL9pzG5DBZxd/j1mmGF2D8M2WNfX2Aln
         Reknq4tIrkyd1wOby1CrABcq/asMwClmGrbv4sO7Ws232BHUZAh10OAELQh+6vjCSR
         iu1TN2uPUlF8w==
Received: by mail-wm1-f70.google.com with SMTP id bg23-20020a05600c3c9700b0034bb19dfdc0so2291181wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 23:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCQXkZtZ/VwDrAN2uVWBP6tsU2v5k0SPHuefqy0UyIg=;
        b=wZmXpytKW+RNCl/zqcOCftTeIsL1P/FYObDLyoBJJ/J716hnDzigN77Bx+ZOQ9NoOW
         Or2QipTFl9HeDCRmb4SXcerIrfHW4PogTEROfmj200MMtF5izeFnQB/HpPYXbaVbhNvA
         hGAgALeJiftrvZODvY9uW95Ua40pojf1Uk7C1g/kDBeswbdn7Whyc0izLlY95MUlDRZy
         FNAlEbbku4Mh0rkYkMwk+5idzYSXL/a1NwsVb8epFXma6+GHhqvyP633oiMMy/3DDZZN
         Z2WrJeHNJT0d8dZ6YeWexWrf7ZTvIgVCrcjTUCdkjlDmBbOL+oz0RAUCPbfCuHdpofWk
         FHlw==
X-Gm-Message-State: AOAM531yY8mD4YwlQ+4qnteGy6nPuzuJdroc6Ngz32++0Sk6A2xj/46t
        03urKnoCB3JMh22W0woFtd380lGQOCb35ub11hlQy5kQYRQNC4t9q7UG2AMXAII+ZHot6G+Oq8I
        4CDWHlW7owpnMC1tnnPYo66N8TsCUqZIdkDGNX+Ez/rwwgWxOAPtE+oXJvQ==
X-Received: by 2002:a05:6402:268a:: with SMTP id w10mr35311135edd.10.1642663855649;
        Wed, 19 Jan 2022 23:30:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx4lfTfUx4Ph9cNei39h0hiDJe+PmE9RqL0dDaj6MBDX4YqPidVFEEVr4D9rAfOlQrUSsuyrh6JKI5CmG9NuI=
X-Received: by 2002:a05:6402:268a:: with SMTP id w10mr35311082edd.10.1642663855317;
 Wed, 19 Jan 2022 23:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com> <mhng-cdec292e-aea2-4b76-8853-b8465521e94f@palmer-ri-x1c9>
In-Reply-To: <mhng-cdec292e-aea2-4b76-8853-b8465521e94f@palmer-ri-x1c9>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 20 Jan 2022 08:30:43 +0100
Message-ID: <CA+zEjCuTSjOCmNExSN1jO50tsuXNzL9x6K6jWjG4+vVky5eWsw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Introduce sv48 support without relocatable kernel
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, zong.li@sifive.com, anup@brainfault.org,
        Atish.Patra@rivosinc.com, Christoph Hellwig <hch@lst.de>,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, ardb@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        keescook@chromium.org, guoren@linux.alibaba.com,
        heinrich.schuchardt@canonical.com, mchitale@ventanamicro.com,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 5:18 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 06 Dec 2021 02:46:44 PST (-0800), alexandre.ghiti@canonical.com wrote:
> > * Please note notable changes in memory layouts and kasan population *
> >
> > This patchset allows to have a single kernel for sv39 and sv48 without
> > being relocatable.
> >
> > The idea comes from Arnd Bergmann who suggested to do the same as x86,
> > that is mapping the kernel to the end of the address space, which allows
> > the kernel to be linked at the same address for both sv39 and sv48 and
> > then does not require to be relocated at runtime.
> >
> > This implements sv48 support at runtime. The kernel will try to
> > boot with 4-level page table and will fallback to 3-level if the HW does not
> > support it. Folding the 4th level into a 3-level page table has almost no
> > cost at runtime.
> >
> > Note that kasan region had to be moved to the end of the address space
> > since its location must be known at compile-time and then be valid for
> > both sv39 and sv48 (and sv57 that is coming).
> >
> > Tested on:
> >   - qemu rv64 sv39: OK
> >   - qemu rv64 sv48: OK
> >   - qemu rv64 sv39 + kasan: OK
> >   - qemu rv64 sv48 + kasan: OK
> >   - qemu rv32: OK
> >
> > Changes in v3:
> >   - Fix SZ_1T, thanks to Atish
> >   - Fix warning create_pud_mapping, thanks to Atish
> >   - Fix k210 nommu build, thanks to Atish
> >   - Fix wrong rebase as noted by Samuel
> >   - * Downgrade to sv39 is only possible if !KASAN (see commit changelog) *
> >   - * Move KASAN next to the kernel: virtual layouts changed and kasan population *
> >
> > Changes in v2:
> >   - Rebase onto for-next
> >   - Fix KASAN
> >   - Fix stack canary
> >   - Get completely rid of MAXPHYSMEM configs
> >   - Add documentation
> >
> > Alexandre Ghiti (13):
> >   riscv: Move KASAN mapping next to the kernel mapping
> >   riscv: Split early kasan mapping to prepare sv48 introduction
> >   riscv: Introduce functions to switch pt_ops
> >   riscv: Allow to dynamically define VA_BITS
> >   riscv: Get rid of MAXPHYSMEM configs
> >   asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
> >   riscv: Implement sv48 support
> >   riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
> >   riscv: Explicit comment about user virtual address space size
> >   riscv: Improve virtual kernel memory layout dump
> >   Documentation: riscv: Add sv48 description to VM layout
> >   riscv: Initialize thread pointer before calling C functions
> >   riscv: Allow user to downgrade to sv39 when hw supports sv48 if !KASAN
> >
> >  Documentation/riscv/vm-layout.rst             |  48 ++-
> >  arch/riscv/Kconfig                            |  37 +-
> >  arch/riscv/configs/nommu_k210_defconfig       |   1 -
> >  .../riscv/configs/nommu_k210_sdcard_defconfig |   1 -
> >  arch/riscv/configs/nommu_virt_defconfig       |   1 -
> >  arch/riscv/include/asm/csr.h                  |   3 +-
> >  arch/riscv/include/asm/fixmap.h               |   1
> >  arch/riscv/include/asm/kasan.h                |  11 +-
> >  arch/riscv/include/asm/page.h                 |  20 +-
> >  arch/riscv/include/asm/pgalloc.h              |  40 ++
> >  arch/riscv/include/asm/pgtable-64.h           | 108 ++++-
> >  arch/riscv/include/asm/pgtable.h              |  47 +-
> >  arch/riscv/include/asm/sparsemem.h            |   6 +-
> >  arch/riscv/kernel/cpu.c                       |  23 +-
> >  arch/riscv/kernel/head.S                      |   4 +-
> >  arch/riscv/mm/context.c                       |   4 +-
> >  arch/riscv/mm/init.c                          | 408 ++++++++++++++----
> >  arch/riscv/mm/kasan_init.c                    | 250 ++++++++---
> >  drivers/firmware/efi/libstub/efi-stub.c       |   2
> >  drivers/pci/controller/pci-xgene.c            |   2 +-
> >  include/asm-generic/pgalloc.h                 |  24 +-
> >  include/linux/sizes.h                         |   1
> >  22 files changed, 833 insertions(+), 209 deletions(-)
>
> Sorry this took a while.  This is on for-next, with a bit of juggling: a
> handful of trivial fixes for configs that were failing to build/boot and
> some merge issues.  I also pulled out that MAXPHYSMEM fix to the top, so
> it'd be easier to backport.  This is bigger than something I'd normally like to
> take late in the cycle, but given there's a lot of cleanups, likely some fixes,
> and it looks like folks have been testing this I'm just going to go with it.
>

Yes yes yes! That's fantastic news :)

> Let me know if there's any issues with the merge, it was a bit hairy.
> Probably best to just send along a fixup patch at this point.

I'm going to take a look at that now, and I'll fix anything that comes
up quickly :)

Thanks!

Alex

>
> Thanks!
