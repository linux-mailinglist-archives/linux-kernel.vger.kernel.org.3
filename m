Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56444FE587
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355879AbiDLQIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiDLQId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:08:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3D8527DE;
        Tue, 12 Apr 2022 09:06:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y32so33021916lfa.6;
        Tue, 12 Apr 2022 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6QvGr/lgESgCcAV1kLcr6T1wAqg4sC7hdPj97a5a3ao=;
        b=fSKdzRukLXyanfBM83cKM725fXdTewpZeRUgGuJ8z6xN3n/pu2U0NGjWREfTkESJAk
         VcB9ObEme58jUY5QSuLP0LdG1oNN8UbCfF23dp6WpnI3lPk5yslNx7+c+x0vStXPPIV+
         MDBsTdzb17u3BHnx5FnJpQrJxNFhNeSTSJX6Lmc9fRLUF7z14GPA8iYjI7WINhXLUGYl
         H2wcNHLKyxIl5PWyl1sMBOkdlaDx8qAFj/ES1orL+egzj08LhEflfI56/CKDSih5z3oN
         BDh1/24Gn9CcssFoWX9+/LjnmHVjx9iXO4+ffBLCdbM1JH00jyBj7Ul5+OsefHB2Z74p
         cMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6QvGr/lgESgCcAV1kLcr6T1wAqg4sC7hdPj97a5a3ao=;
        b=3wJd8zdK1Xs0c1wAlx+VUI+MsIT04nRjloVpCwrTzGyZOgklpA53Egk16cqPgl7IdD
         K7Itw0a2D7VhNULKJYMH5cw/lupOArtRodgOdGdmZTSPGVauUfof0NfNBA+bjT1v7LYj
         Q8Hk6lSWFuCISj37pa3yzq8035De0ERaIPlTOYiEEpl4j8+8YKksBfpWiX3a3ffapFnf
         r5QbSsNXmO5vt75504HpS9AoT7iFk5KGvwcj7R2B7TAYJ77Ukq2a/hPGx+S+TXIL02eX
         nrVxh5awlG/FSf0bJD+UaPHrmRto727q0KNIVmwt7yRNydtrHx9nTEGcimHh+Sj0uOWy
         n5vQ==
X-Gm-Message-State: AOAM5326CHsYHFHCugwjNNOvbcVc9K2yg/cou4gAj5JgHh0j721i3fZX
        smwloQLxmJZv3wGFYYb8vDkDTZoQtLWHUwbsIrM=
X-Google-Smtp-Source: ABdhPJwBsPYEcshcgKu8GVIRHeBsy6qY9rVuOkIEU+LMcc8tmswQqUDvOdqXnnDhgebLs9+aqmJkae8XN9OIhfgRvuY=
X-Received: by 2002:a05:6512:400e:b0:450:e09d:c9a6 with SMTP id
 br14-20020a056512400e00b00450e09dc9a6mr27299024lfb.243.1649779573292; Tue, 12
 Apr 2022 09:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220412045228.35306-1-patrick.wang.shcn@gmail.com> <CAL_JsqJ3Vi18RizzkKok5Rg8AM3U3Eytaunqk-5RF795ma=wcA@mail.gmail.com>
In-Reply-To: <CAL_JsqJ3Vi18RizzkKok5Rg8AM3U3Eytaunqk-5RF795ma=wcA@mail.gmail.com>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Wed, 13 Apr 2022 00:06:02 +0800
Message-ID: <CAGcnep_Hp0UcoZ5beJ8AMX-4Axt-m47M8_Tdg-RPoNqqvjpgZg@mail.gmail.com>
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

I check the code again, it's not about  reserved memory, it's the calling o=
f
kmemleak_alloc_phys, this api is for lowmem, added in commit 9099daed9c6.

So I think the address should be checked before kmemleak_alloc_phys,
only the range in lowmem should be passed to the  kmemleak api.

if (size &&
    early_init_dt_reserve_memory_arch(base, size, nomap) =3D=3D 0) {
pr_debug("Reserved memory: reserved region for node '%s': base %pa,
size %lu MiB\n",
uname, &base, (unsigned long)(size / SZ_1M));
if (!nomap)
kmemleak_alloc_phys(base, size, 0, 0); // here to check
}



Rob Herring <robh+dt@kernel.org> =E4=BA=8E2022=E5=B9=B44=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=8C 20:31=E5=86=99=E9=81=93=EF=BC=9A
>
> +Mike Rapoport
>
> On Mon, Apr 11, 2022 at 11:52 PM Patrick Wang
> <patrick.wang.shcn@gmail.com> wrote:
> >
> > Dt reserve memory without base checking, which will trigger an oops in
> > kmemleak when the base address is below MIN_MEMBLOCK_ADDR:
>
> Why does the caller need to know what this address is? Shouldn't
> memblock handle all this internally?
>
> What about when EFI memory maps are used?
>
> >
> > # echo scan > /sys/kernel/debug/kmemleak
> > [   54.888353] Unable to handle kernel paging request at virtual addres=
s ff5fffffffe00000
> > [   54.888932] Oops [#1]
> > [   54.889102] Modules linked in:
> > [   54.889326] CPU: 2 PID: 134 Comm: bash Not tainted 5.18.0-rc1-next-2=
0220407 #33
> > [   54.889620] Hardware name: riscv-virtio,qemu (DT)
> > [   54.889901] epc : scan_block+0x74/0x15c
> > [   54.890215]  ra : scan_block+0x72/0x15c
> > [   54.890390] epc : ffffffff801e5806 ra : ffffffff801e5804 sp : ff2000=
00104abc30
> > [   54.890607]  gp : ffffffff815cd4e8 tp : ff60000004cfa340 t0 : 000000=
0000000200
> > [   54.890835]  t1 : 00aaaaaac23954cc t2 : 00000000000003ff s0 : ff2000=
00104abc90
> > [   54.891024]  s1 : ffffffff81b0ff28 a0 : 0000000000000000 a1 : ff5fff=
ffffe01000
> > [   54.891201]  a2 : ffffffff81b0ff28 a3 : 0000000000000002 a4 : 000000=
0000000001
> > [   54.891377]  a5 : 0000000000000000 a6 : ff200000104abd7c a7 : 000000=
0000000005
> > [   54.891552]  s2 : ff5fffffffe00ff9 s3 : ffffffff815cd998 s4 : ffffff=
ff815d0e90
> > [   54.891727]  s5 : ffffffff81b0ff28 s6 : 0000000000000020 s7 : ffffff=
ff815d0eb0
> > [   54.891903]  s8 : ffffffffffffffff s9 : ff5fffffffe00000 s10: ff5fff=
ffffe01000
> > [   54.892078]  s11: 0000000000000022 t3 : 00ffffffaa17db4c t4 : 000000=
000000000f
> > [   54.892271]  t5 : 0000000000000001 t6 : 0000000000000000
> > [   54.892408] status: 0000000000000100 badaddr: ff5fffffffe00000 cause=
: 000000000000000d
> > [   54.892643] [<ffffffff801e5a1c>] scan_gray_list+0x12e/0x1a6
> > [   54.892824] [<ffffffff801e5d3e>] kmemleak_scan+0x2aa/0x57e
> > [   54.892961] [<ffffffff801e633c>] kmemleak_write+0x32a/0x40c
> > [   54.893096] [<ffffffff803915ac>] full_proxy_write+0x56/0x82
> > [   54.893235] [<ffffffff801ef456>] vfs_write+0xa6/0x2a6
> > [   54.893362] [<ffffffff801ef880>] ksys_write+0x6c/0xe2
> > [   54.893487] [<ffffffff801ef918>] sys_write+0x22/0x2a
> > [   54.893609] [<ffffffff8000397c>] ret_from_syscall+0x0/0x2
> > [   54.894183] ---[ end trace 0000000000000000 ]---
> >
> > Add base checking and ignore the range lower than MIN_MEMBLOCK_ADDR.
> >
> > Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> > ---
> >  drivers/of/fdt.c | 27 ++++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index ec315b060..296c4ab8e 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -33,6 +33,13 @@
> >
> >  #include "of_private.h"
> >
> > +#ifndef MIN_MEMBLOCK_ADDR
> > +#define MIN_MEMBLOCK_ADDR      __pa(PAGE_OFFSET)
> > +#endif
> > +#ifndef MAX_MEMBLOCK_ADDR
> > +#define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
> > +#endif
> > +
> >  /*
> >   * of_fdt_limit_memory - limit the number of regions in the /memory no=
de
> >   * @limit: maximum entries
> > @@ -480,6 +487,19 @@ static u32 of_fdt_crc32;
> >  static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
> >                                         phys_addr_t size, bool nomap)
> >  {
> > +       const u64 phys_offset =3D MIN_MEMBLOCK_ADDR;
> > +
> > +       if (base < phys_offset) {
> > +               pr_warn("Ignoring reserved memory range 0x%llx - 0x%llx=
\n",
> > +                       base, phys_offset);
> > +               size =3D (phys_offset - base) < size ?
> > +                       size - (phys_offset - base) : 0;
> > +               base =3D phys_offset;
> > +
> > +               if (!size)
> > +                       return -EFAULT;
> > +       }
> > +
> >         if (nomap) {
> >                 /*
> >                  * If the memory is already reserved (by another region=
), we
> > @@ -1198,13 +1218,6 @@ int __init early_init_dt_scan_chosen(char *cmdli=
ne)
> >         return 0;
> >  }
> >
> > -#ifndef MIN_MEMBLOCK_ADDR
> > -#define MIN_MEMBLOCK_ADDR      __pa(PAGE_OFFSET)
> > -#endif
> > -#ifndef MAX_MEMBLOCK_ADDR
> > -#define MAX_MEMBLOCK_ADDR      ((phys_addr_t)~0)
> > -#endif
> > -
> >  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> >  {
> >         const u64 phys_offset =3D MIN_MEMBLOCK_ADDR;
> > --
> > 2.25.1
> >
