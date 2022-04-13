Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19C94FF4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiDMKbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiDMKbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:31:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB5F48E43;
        Wed, 13 Apr 2022 03:29:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c15so1597552ljr.9;
        Wed, 13 Apr 2022 03:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EM7/SkV+6s8Fu4/Dfl5qBS4N2VHhPA4O2DL1nEyVo2k=;
        b=mfZBR/gOmqrb4LoArxZ87H0Edrk2ihZ7Wt+hM2vGmacHp2oyqu5JvXKQ1i5wqNjucO
         3ou7Brx94NqT3kldGgDq2vqU0Rk48pZo6EjPCLegaYysbwO+XCZw6Pz0zIezLKBx8jH8
         OatEOn8td1HkPm94zJxCQfib+P6sxhWlEPDFE84HDuPpQrP8VnKo2WEviu6qJ704GmhJ
         b31TdXo/OK/DgljXRo8Qt57H8igBEw8vwhNuCgmHmweDK9zhtdR2deZhf4zltoPGgz94
         SADIjqAxfhsV4Y1vO5URpUbh25UyXZfvNvTo6ndLJJaNeo+OLry0pPkxUGc+NVkBvw84
         f1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EM7/SkV+6s8Fu4/Dfl5qBS4N2VHhPA4O2DL1nEyVo2k=;
        b=2ktwG514WE7meNSJ2gwfxoG5Zsfxp1G9BQ1cb6XzLYu2w2x6oyZKri6X/BZJCGOBdJ
         V/SbliITV1UtdwGpRhVXnrfnSKbBKnEWgixh6ioTDTPxdJQGov0fZ8Lzkqz/XRkE0p9B
         talXbg92v+DPviZbnSsd5IpsKqjsII/zjRBXIzQqHyzFIWteaq+ZN5NbCaT/M58cGg/B
         S1rUSAtLww7HiPut5itS+D19mnmeXlfneIWkfPHfZ/vlpthnVZpsPYcBosL53FUJmPpF
         9NmUoX53UapX/qzSSiaVdbqTj2196p2GwPUzFcI9vR6odlWh5u1j3aO0X+Z1MIL3wHky
         0mJw==
X-Gm-Message-State: AOAM531waMvfhrVi7PUA1p55HKGmpF7pGjVnBHW4CkaIincf1NTBKKsK
        tvokjY8cMBVxswD0KqKCzNWWVu5D+N75CD4ouSI=
X-Google-Smtp-Source: ABdhPJwqUtCWbhPewkf5rtBPPchoYH7LOsk6rspm6E15jH2QMeReIE9r1CchdIILTsp+lMrd1B4YDV5/FCDZUJvtUbg=
X-Received: by 2002:a2e:9103:0:b0:24b:6b46:3a32 with SMTP id
 m3-20020a2e9103000000b0024b6b463a32mr5919541ljg.349.1649845738913; Wed, 13
 Apr 2022 03:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220412045228.35306-1-patrick.wang.shcn@gmail.com>
 <CAL_JsqJ3Vi18RizzkKok5Rg8AM3U3Eytaunqk-5RF795ma=wcA@mail.gmail.com> <CAGcnep_Hp0UcoZ5beJ8AMX-4Axt-m47M8_Tdg-RPoNqqvjpgZg@mail.gmail.com>
In-Reply-To: <CAGcnep_Hp0UcoZ5beJ8AMX-4Axt-m47M8_Tdg-RPoNqqvjpgZg@mail.gmail.com>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Wed, 13 Apr 2022 18:28:47 +0800
Message-ID: <CAGcnep9BW9+wam0Lu2njqpX_3fZPrEvsbs5hg66X0hTNqG3JwQ@mail.gmail.com>
Subject: Re: [PATCH] of: fdt: do not reserve memory below MIN_MEMBLOCK_ADDR
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:06 AM patrick wang
<patrick.wang.shcn@gmail.com> wrote:
>
> I check the code again, it's not about  reserved memory, it's the calling=
 of
> kmemleak_alloc_phys, this api is for lowmem, added in commit 9099daed9c6.
>
> So I think the address should be checked before kmemleak_alloc_phys,
> only the range in lowmem should be passed to the  kmemleak api.
>
> if (size &&
>     early_init_dt_reserve_memory_arch(base, size, nomap) =3D=3D 0) {
> pr_debug("Reserved memory: reserved region for node '%s': base %pa,
> size %lu MiB\n",
> uname, &base, (unsigned long)(size / SZ_1M));
> if (!nomap)
> kmemleak_alloc_phys(base, size, 0, 0); // here to check
> }
>

Since the kmemleak_alloc_phys api is only for lowmem, this should be
handled by itself.

I will post a patch to kmemleak.

>
>
> Rob Herring <robh+dt@kernel.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C 20:31=E5=86=99=E9=81=93=EF=BC=9A
> >
> > +Mike Rapoport
> >
> > On Mon, Apr 11, 2022 at 11:52 PM Patrick Wang
> > <patrick.wang.shcn@gmail.com> wrote:
> > >
> > > Dt reserve memory without base checking, which will trigger an oops i=
n
> > > kmemleak when the base address is below MIN_MEMBLOCK_ADDR:
> >
> > Why does the caller need to know what this address is? Shouldn't
> > memblock handle all this internally?

early_init_dt_add_memory_arch() handled this.


> >
> > What about when EFI memory maps are used?

If reserved memory should be handled, this should also be handled too, I th=
ink.

Thanks

> >
> > >
> > > # echo scan > /sys/kernel/debug/kmemleak
> > > [   54.888353] Unable to handle kernel paging request at virtual addr=
ess ff5fffffffe00000
> > > [   54.888932] Oops [#1]
> > > [   54.889102] Modules linked in:
> > > [   54.889326] CPU: 2 PID: 134 Comm: bash Not tainted 5.18.0-rc1-next=
-20220407 #33
> > > [   54.889620] Hardware name: riscv-virtio,qemu (DT)
> > > [   54.889901] epc : scan_block+0x74/0x15c
> > > [   54.890215]  ra : scan_block+0x72/0x15c
> > > [   54.890390] epc : ffffffff801e5806 ra : ffffffff801e5804 sp : ff20=
0000104abc30
> > > [   54.890607]  gp : ffffffff815cd4e8 tp : ff60000004cfa340 t0 : 0000=
000000000200
> > > [   54.890835]  t1 : 00aaaaaac23954cc t2 : 00000000000003ff s0 : ff20=
0000104abc90
> > > [   54.891024]  s1 : ffffffff81b0ff28 a0 : 0000000000000000 a1 : ff5f=
ffffffe01000
> > > [   54.891201]  a2 : ffffffff81b0ff28 a3 : 0000000000000002 a4 : 0000=
000000000001
> > > [   54.891377]  a5 : 0000000000000000 a6 : ff200000104abd7c a7 : 0000=
000000000005
> > > [   54.891552]  s2 : ff5fffffffe00ff9 s3 : ffffffff815cd998 s4 : ffff=
ffff815d0e90
> > > [   54.891727]  s5 : ffffffff81b0ff28 s6 : 0000000000000020 s7 : ffff=
ffff815d0eb0
> > > [   54.891903]  s8 : ffffffffffffffff s9 : ff5fffffffe00000 s10: ff5f=
ffffffe01000
> > > [   54.892078]  s11: 0000000000000022 t3 : 00ffffffaa17db4c t4 : 0000=
00000000000f
> > > [   54.892271]  t5 : 0000000000000001 t6 : 0000000000000000
> > > [   54.892408] status: 0000000000000100 badaddr: ff5fffffffe00000 cau=
se: 000000000000000d
> > > [   54.892643] [<ffffffff801e5a1c>] scan_gray_list+0x12e/0x1a6
> > > [   54.892824] [<ffffffff801e5d3e>] kmemleak_scan+0x2aa/0x57e
> > > [   54.892961] [<ffffffff801e633c>] kmemleak_write+0x32a/0x40c
> > > [   54.893096] [<ffffffff803915ac>] full_proxy_write+0x56/0x82
> > > [   54.893235] [<ffffffff801ef456>] vfs_write+0xa6/0x2a6
> > > [   54.893362] [<ffffffff801ef880>] ksys_write+0x6c/0xe2
> > > [   54.893487] [<ffffffff801ef918>] sys_write+0x22/0x2a
> > > [   54.893609] [<ffffffff8000397c>] ret_from_syscall+0x0/0x2
> > > [   54.894183] ---[ end trace 0000000000000000 ]---
> > >
> > > Add base checking and ignore the range lower than MIN_MEMBLOCK_ADDR.
> > >
> > > Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> > > ---
> > >  drivers/of/fdt.c | 27 ++++++++++++++++++++-------
> > >  1 file changed, 20 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index ec315b060..296c4ab8e 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -33,6 +33,13 @@
> > >
> > >  #include "of_private.h"
> > >
> > > +#ifndef MIN_MEMBLOCK_ADDR
> > > +#define MIN_MEMBLOCK_ADDR      __pa(PAGE_OFFSET)
> > > +#endif
> > > +#ifndef MAX_MEMBLOCK_ADDR
> > > +#define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
> > > +#endif
> > > +
> > >  /*
> > >   * of_fdt_limit_memory - limit the number of regions in the /memory =
node
> > >   * @limit: maximum entries
> > > @@ -480,6 +487,19 @@ static u32 of_fdt_crc32;
> > >  static int __init early_init_dt_reserve_memory_arch(phys_addr_t base=
,
> > >                                         phys_addr_t size, bool nomap)
> > >  {
> > > +       const u64 phys_offset =3D MIN_MEMBLOCK_ADDR;
> > > +
> > > +       if (base < phys_offset) {
> > > +               pr_warn("Ignoring reserved memory range 0x%llx - 0x%l=
lx\n",
> > > +                       base, phys_offset);
> > > +               size =3D (phys_offset - base) < size ?
> > > +                       size - (phys_offset - base) : 0;
> > > +               base =3D phys_offset;
> > > +
> > > +               if (!size)
> > > +                       return -EFAULT;
> > > +       }
> > > +
> > >         if (nomap) {
> > >                 /*
> > >                  * If the memory is already reserved (by another regi=
on), we
> > > @@ -1198,13 +1218,6 @@ int __init early_init_dt_scan_chosen(char *cmd=
line)
> > >         return 0;
> > >  }
> > >
> > > -#ifndef MIN_MEMBLOCK_ADDR
> > > -#define MIN_MEMBLOCK_ADDR      __pa(PAGE_OFFSET)
> > > -#endif
> > > -#ifndef MAX_MEMBLOCK_ADDR
> > > -#define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
> > > -#endif
> > > -
> > >  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> > >  {
> > >         const u64 phys_offset =3D MIN_MEMBLOCK_ADDR;
> > > --
> > > 2.25.1
> > >
