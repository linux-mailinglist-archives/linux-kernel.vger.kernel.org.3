Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712A64B5E33
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiBNXWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:22:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBNXWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:22:41 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511C813C3B2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:22:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m17so4497198edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I6NFTkYI7ebjBhp1e1XZMTPr8QBe99RW2EaCjNoZteo=;
        b=NsqBzOE4RRr7fD/64cRooOi87Ol/TjJl31w8h3szs+IwvPeHvpgbSjSeNPn2BQheGQ
         qE6N266fHncxrlNu3FeyNWl/FGp9dQLZdEdcadh/QSc4vGDYtmsHASrCImwIzXXwAprQ
         w2z1W7yOqnUL4k7ljixm+lXXrUoNHJI3Hios3zK60Fi1p55hsITpndmOu4oES3WHURed
         ZIX2vFZQsSp48W9ubvOkOReK3UsZXnxYFlCCF3jR16ow/vVPVnRFTBS36UYk1xMtb5g/
         Q8tEkKmz4jYjsjz3wFCgqQu6fXq+nx83qFRkrg9DNqn3YFgmCqz3iJBFZG84TJYJPEQB
         BxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I6NFTkYI7ebjBhp1e1XZMTPr8QBe99RW2EaCjNoZteo=;
        b=1a8ULhvvFfpNdHc+Y9mmbSA4D+LDis/h2s+GhDn/PgA/qnXLv58O+3sex/bB2KJcgn
         UuqBu+HJYSaGm0+T4OrmLgioUlUSXTBdVluHX//je43mqyUkr5h9+AlGkp2ncdMuVQ1j
         M7swy+ScYRei46I8aFsyInu9Bp8+HzPBzY1oPlCLijVzbPM/bL2Tp+sKaRE6FGuXxnMS
         i1yJCvGKgPlg4AtYnKhs5BdZP2vbswy52LDn1Ez632hEfW/0whVErH9zTJ3/ycljTAfd
         QlmtUnUtqGiykhQh8060NEqp4Y2dYjVBfP8YOm+ID4fdCWvoJAOz0Dukp7s7FfzH+7Aa
         qFjA==
X-Gm-Message-State: AOAM531S1SizoNoGeQ+sFje4Hl+FNuDZ2s/MrRU/Accp7MISaBfcAoMH
        /yJPwxWV8OtdWKVkreMoc4jmlG9mYl0rTKkBDSwtsQ==
X-Google-Smtp-Source: ABdhPJxiPduwDthMX8xudSwJU0Ax5iRYwMNewuwx3OI/tLotIvBhazm+qPahaXe+6y5c3gRNM+1oBpx4HW8Iacx6o3E=
X-Received: by 2002:a05:6402:2050:: with SMTP id bc16mr1188306edb.431.1644880950812;
 Mon, 14 Feb 2022 15:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20220210214018.55739-1-atishp@rivosinc.com> <3479483.A1skbJeUdD@diego>
 <CAOnJCU+cWBDrN-3Z37m8xA1GPrJY+JaOweYMiZBxJ-cT7ii_5Q@mail.gmail.com> <2413800.L4PxSk42VP@diego>
In-Reply-To: <2413800.L4PxSk42VP@diego>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Mon, 14 Feb 2022 15:22:19 -0800
Message-ID: <CAHBxVyEETRsUu3mXqT2oD=fuxmNHxmvEd7z+ZhdXb60af2L=EQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] RISC-V: Implement multi-letter ISA extension
 probing framework
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Atish Patra <atishp@atishpatra.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 2:22 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Montag, 14. Februar 2022, 21:42:32 CET schrieb Atish Patra:
> > On Mon, Feb 14, 2022 at 12:24 PM Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> > >
> > > Am Montag, 14. Februar 2022, 21:14:13 CET schrieb Atish Patra:
> > > > On Mon, Feb 14, 2022 at 12:06 PM Heiko St=C3=BCbner <heiko@sntech.d=
e> wrote:
> > > > >
> > > > > Am Donnerstag, 10. Februar 2022, 22:40:16 CET schrieb Atish Patra=
:
> > > > > > Multi-letter extensions can be probed using exising
> > > > > > riscv_isa_extension_available API now. It doesn't support versi=
oning
> > > > > > right now as there is no use case for it.
> > > > > > Individual extension specific implementation will be added duri=
ng
> > > > > > each extension support.
> > > > > >
> > > > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > > >
> > > > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > > >
> > > > >
> > > > > By the way, does a similar parsing exist for opensbi as well?
> > > > > Things like svpbmt as well as zicbom have CSR bits controlling ho=
w
> > > > > these functions should behave (enabling them, etc), so I guess
> > > > > opensbi also needs to parse the extensions from the ISA string?
> > > > >
> > > > >
> > > >
> > > > No. Currently, OpenSBI relies on the CSR read/write & trap method t=
o
> > > > identify the extensions [1].
> > > >
> > > > https://github.com/riscv-software-src/opensbi/blob/master/lib/sbi/s=
bi_hart.c#L404
> > >
> > > I guess my question is more, who is supposed to set CBIE, CBCFE bits =
in the
> > > ENVCFG CSR. I.e. at it's default settings CMO instructions will cause
> > > illegal instructions until the level above does allow them.
> > >
> > > When the kernel wants to call a cache-invalidate, from my reading men=
vcfg
> > > needs to be modified accordingly - which would fall in SBI's court?
> > >
> >
> > I think so. I had the same question for the SSTC extension as well.
> > This is what I currently do:
> >
> > 1. Detect menvcfg first, detect stimecmp
> > 2. Enable SSTC feature only if both are available
> > 3. Set the STCE bit in menvcfg if SSTC is available
> >
> > Here is the patch
> > https://github.com/atishp04/opensbi/commit/e6b185821e8302bffdceb4633b41=
3252e0de4889
>
> Hmm, the CBO fields are defined as WARL (write any, read legal),
> so I guess some sort of trap won't work here.
>

Correct. Traps for extensions that introduce new CSRs.
I was suggesting setting the corresponding bits in MENVCFG and reading
it again to check if it sticks.

> The priv-spec only points to the cmo-spec for these bits and the cmo-spec
> does not specifiy what the value should be when cmo is not present.
>
>
> > > > In the future, zicbom can be detected in the same manner. However,
> > > > svpbmt is a bit tricky as it doesn't
> > > > define any new CSR. Do you think OpenSBI needs to detect svpbmt for=
 any reason ?
> > >
> > > There is the PBMTE bit in MENVCFG, which I found while looking throug=
h the
> > > zicbom-parts, which is supposed to "control wheter svpbmt is availabl=
e for
> > > use". So I guess the question is the same as above :-)
> > >
> >
> > PBMTE bit in MENVCFG says if PBMTE bit is available or not. OpenSBI
> > needs other way to
> > detect if PBMTE is available.
> >
> > That's why, I think MENVCFG should be set correctly by the hardware
> > upon reset. What do you think
> > about that ? I couldn't find anything related to the reset state for me=
nvcfg.
>
> me neither. Both the priv-spec as well as the cmobase spec do not
> specifiy any reset-values it seems.
>
I have raised an issue in the ISA spec.
https://github.com/riscv/riscv-isa-manual/issues/820

> So I guess in the Qemu case, Qemu needs to set that bit when
> its svpbmt extension is enabled?
>

We can do that if the priv spec is modified to allow that.

>
> Heiko
>
>
> > > > > > ---
> > > > > >  arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
> > > > > >  arch/riscv/kernel/cpufeature.c | 27 ++++++++++++++++++++++++--=
-
> > > > > >  2 files changed, 42 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/includ=
e/asm/hwcap.h
> > > > > > index 5ce50468aff1..170bd80da520 100644
> > > > > > --- a/arch/riscv/include/asm/hwcap.h
> > > > > > +++ b/arch/riscv/include/asm/hwcap.h
> > > > > > @@ -34,7 +34,25 @@ extern unsigned long elf_hwcap;
> > > > > >  #define RISCV_ISA_EXT_s              ('s' - 'a')
> > > > > >  #define RISCV_ISA_EXT_u              ('u' - 'a')
> > > > > >
> > > > > > +/*
> > > > > > + * Increse this to higher value as kernel support more ISA ext=
ensions.
> > > > > > + */
> > > > > >  #define RISCV_ISA_EXT_MAX    64
> > > > > > +#define RISCV_ISA_EXT_NAME_LEN_MAX 32
> > > > > > +
> > > > > > +/* The base ID for multi-letter ISA extensions */
> > > > > > +#define RISCV_ISA_EXT_BASE 26
> > > > > > +
> > > > > > +/*
> > > > > > + * This enum represent the logical ID for each multi-letter RI=
SC-V ISA extension.
> > > > > > + * The logical ID should start from RISCV_ISA_EXT_BASE and mus=
t not exceed
> > > > > > + * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> > > > > > + * extensions while all the multi-letter extensions should def=
ine the next
> > > > > > + * available logical extension id.
> > > > > > + */
> > > > > > +enum riscv_isa_ext_id {
> > > > > > +     RISCV_ISA_EXT_ID_MAX =3D RISCV_ISA_EXT_MAX,
> > > > > > +};
> > > > > >
> > > > > >  unsigned long riscv_isa_extension_base(const unsigned long *is=
a_bitmap);
> > > > > >
> > > > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel=
/cpufeature.c
> > > > > > index e9e3b0693d16..469b9739faf7 100644
> > > > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > > > @@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
> > > > > >
> > > > > >       for_each_of_cpu_node(node) {
> > > > > >               unsigned long this_hwcap =3D 0;
> > > > > > -             unsigned long this_isa =3D 0;
> > > > > > +             uint64_t this_isa =3D 0;
> > > > > >
> > > > > >               if (riscv_of_processor_hartid(node) < 0)
> > > > > >                       continue;
> > > > > > @@ -169,12 +169,22 @@ void __init riscv_fill_hwcap(void)
> > > > > >                       if (*isa !=3D '_')
> > > > > >                               --isa;
> > > > > >
> > > > > > +#define SET_ISA_EXT_MAP(name, bit)                            =
               \
> > > > > > +                     do {                                     =
               \
> > > > > > +                             if ((ext_end - ext =3D=3D sizeof(=
name) - 1) &&      \
> > > > > > +                                  !memcmp(ext, name, sizeof(na=
me) - 1)) {    \
> > > > > > +                                     this_isa |=3D (1UL << bit=
);               \
> > > > > > +                                     pr_info("Found ISA extens=
ion %s", name);\
> > > > > > +                             }                                =
               \
> > > > > > +                     } while (false)                          =
               \
> > > > > > +
> > > > > >                       if (unlikely(ext_err))
> > > > > >                               continue;
> > > > > >                       if (!ext_long) {
> > > > > >                               this_hwcap |=3D isa2hwcap[(unsign=
ed char)(*ext)];
> > > > > >                               this_isa |=3D (1UL << (*ext - 'a'=
));
> > > > > >                       }
> > > > > > +#undef SET_ISA_EXT_MAP
> > > > > >               }
> > > > > >
> > > > > >               /*
> > > > > > @@ -187,10 +197,21 @@ void __init riscv_fill_hwcap(void)
> > > > > >               else
> > > > > >                       elf_hwcap =3D this_hwcap;
> > > > > >
> > > > > > -             if (riscv_isa[0])
> > > > > > +             if (riscv_isa[0]) {
> > > > > > +#if IS_ENABLED(CONFIG_32BIT)
> > > > > > +                     riscv_isa[0] &=3D this_isa & 0xFFFFFFFF;
> > > > > > +                     riscv_isa[1] &=3D this_isa >> 32;
> > > > > > +#else
> > > > > >                       riscv_isa[0] &=3D this_isa;
> > > > > > -             else
> > > > > > +#endif
> > > > > > +             } else {
> > > > > > +#if IS_ENABLED(CONFIG_32BIT)
> > > > > > +                     riscv_isa[0] =3D this_isa & 0xFFFFFFFF;
> > > > > > +                     riscv_isa[1] =3D this_isa >> 32;
> > > > > > +#else
> > > > > >                       riscv_isa[0] =3D this_isa;
> > > > > > +#endif
> > > > > > +             }
> > > > > >       }
> > > > > >
> > > > > >       /* We don't support systems with F but without D, so mask=
 those out
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > >
> > > >
> > > >
> > >
> > >
> > >
> > >
> >
> >
> >
>
>
>
>
