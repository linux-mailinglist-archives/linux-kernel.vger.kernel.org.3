Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2134B5B47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiBNUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:46:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiBNUpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:45:46 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D0160FC4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:43:13 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v63so22685902ybv.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U1oWoNofV8AZjJJFAuidFOcNI5CsuFZS/DRQS7vQedc=;
        b=TYcePQM8YCsYfbX0pi4eFmqkwdPyBtUUKJyRgseTrYyPNBIe3gpHXnXlcz/+ja7pe1
         Fwr1nEOFOBkOrhk8GF7cN8LU5Fd0LCy1dW3rZsog/J58Uf8VpT3olpcyVM8XX/jCa8EC
         24HAlNxLsxrXYa6TXCe69c9t/5T46h0cDO+ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U1oWoNofV8AZjJJFAuidFOcNI5CsuFZS/DRQS7vQedc=;
        b=3jJX/cvCvGX/u0ZVIlTe34oG7HCaS0tdk6+Iwj30Aocb95IT4/CxDEwGFomftDql/j
         l4aJG04LTFtgPIDraYjDw1aM6k7V7EbKrEtLdcWvCOafxSIJ7WDjA5SlwYMmSYGC1vVF
         u/jPU+cWcB0RnJSinVdI/Ar3+1WGeirE6IX49eB+ifAgYrePhWn1ZtNH0i/P1Z3BH25N
         7gumf1o4Yyy1pJY7lnVYLLeINUZ/yIUpGvAhb/871Nkd9EJKkMQqXdPSJsv+KWCNqoao
         5fvCTrp6gbOy0pKAR9//3+23+UR0IO7VJzpgDDvsOubEhccu6j9B3JZF6UGib870/tPN
         4zWA==
X-Gm-Message-State: AOAM532q6+DOZWrYzDJzydVuV5TJ/fx0HV0QwmhTJb988ydSoM9lwAIR
        URV0t3O340ASfT06wrGPHiekcOkVS7TS2f1eoi0X
X-Google-Smtp-Source: ABdhPJxcnmlwefG+6nBmJEbpi/vn+HO/ryxdwH+cXu8XlnxWV5H28qkELg/iB8P/k0Dm/0ombt2LQKojfS9CD5/rAO4=
X-Received: by 2002:a25:c794:: with SMTP id w142mr865109ybe.632.1644871363371;
 Mon, 14 Feb 2022 12:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20220210214018.55739-1-atishp@rivosinc.com> <3881365.IPMWXPQfj1@diego>
 <CAOnJCUK1CwJ=J+y9EqszY0aACQsDdpLqCDbEZ1ZNDRdHE9C4gA@mail.gmail.com> <3479483.A1skbJeUdD@diego>
In-Reply-To: <3479483.A1skbJeUdD@diego>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 14 Feb 2022 12:42:32 -0800
Message-ID: <CAOnJCU+cWBDrN-3Z37m8xA1GPrJY+JaOweYMiZBxJ-cT7ii_5Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] RISC-V: Implement multi-letter ISA extension
 probing framework
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atishp@rivosinc.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:24 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
>
> Am Montag, 14. Februar 2022, 21:14:13 CET schrieb Atish Patra:
> > On Mon, Feb 14, 2022 at 12:06 PM Heiko St=C3=BCbner <heiko@sntech.de> w=
rote:
> > >
> > > Am Donnerstag, 10. Februar 2022, 22:40:16 CET schrieb Atish Patra:
> > > > Multi-letter extensions can be probed using exising
> > > > riscv_isa_extension_available API now. It doesn't support versionin=
g
> > > > right now as there is no use case for it.
> > > > Individual extension specific implementation will be added during
> > > > each extension support.
> > > >
> > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > >
> > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > >
> > >
> > > By the way, does a similar parsing exist for opensbi as well?
> > > Things like svpbmt as well as zicbom have CSR bits controlling how
> > > these functions should behave (enabling them, etc), so I guess
> > > opensbi also needs to parse the extensions from the ISA string?
> > >
> > >
> >
> > No. Currently, OpenSBI relies on the CSR read/write & trap method to
> > identify the extensions [1].
> >
> > https://github.com/riscv-software-src/opensbi/blob/master/lib/sbi/sbi_h=
art.c#L404
>
> I guess my question is more, who is supposed to set CBIE, CBCFE bits in t=
he
> ENVCFG CSR. I.e. at it's default settings CMO instructions will cause
> illegal instructions until the level above does allow them.
>
> When the kernel wants to call a cache-invalidate, from my reading menvcfg
> needs to be modified accordingly - which would fall in SBI's court?
>

I think so. I had the same question for the SSTC extension as well.
This is what I currently do:

1. Detect menvcfg first, detect stimecmp
2. Enable SSTC feature only if both are available
3. Set the STCE bit in menvcfg if SSTC is available

Here is the patch
https://github.com/atishp04/opensbi/commit/e6b185821e8302bffdceb4633b413252=
e0de4889

>
> > In the future, zicbom can be detected in the same manner. However,
> > svpbmt is a bit tricky as it doesn't
> > define any new CSR. Do you think OpenSBI needs to detect svpbmt for any=
 reason ?
>
> There is the PBMTE bit in MENVCFG, which I found while looking through th=
e
> zicbom-parts, which is supposed to "control wheter svpbmt is available fo=
r
> use". So I guess the question is the same as above :-)
>

PBMTE bit in MENVCFG says if PBMTE bit is available or not. OpenSBI
needs other way to
detect if PBMTE is available.

That's why, I think MENVCFG should be set correctly by the hardware
upon reset. What do you think
about that ? I couldn't find anything related to the reset state for menvcf=
g.

>
> Heiko
>
>
> > > Heiko
> > >
> > > > ---
> > > >  arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
> > > >  arch/riscv/kernel/cpufeature.c | 27 ++++++++++++++++++++++++---
> > > >  2 files changed, 42 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/as=
m/hwcap.h
> > > > index 5ce50468aff1..170bd80da520 100644
> > > > --- a/arch/riscv/include/asm/hwcap.h
> > > > +++ b/arch/riscv/include/asm/hwcap.h
> > > > @@ -34,7 +34,25 @@ extern unsigned long elf_hwcap;
> > > >  #define RISCV_ISA_EXT_s              ('s' - 'a')
> > > >  #define RISCV_ISA_EXT_u              ('u' - 'a')
> > > >
> > > > +/*
> > > > + * Increse this to higher value as kernel support more ISA extensi=
ons.
> > > > + */
> > > >  #define RISCV_ISA_EXT_MAX    64
> > > > +#define RISCV_ISA_EXT_NAME_LEN_MAX 32
> > > > +
> > > > +/* The base ID for multi-letter ISA extensions */
> > > > +#define RISCV_ISA_EXT_BASE 26
> > > > +
> > > > +/*
> > > > + * This enum represent the logical ID for each multi-letter RISC-V=
 ISA extension.
> > > > + * The logical ID should start from RISCV_ISA_EXT_BASE and must no=
t exceed
> > > > + * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> > > > + * extensions while all the multi-letter extensions should define =
the next
> > > > + * available logical extension id.
> > > > + */
> > > > +enum riscv_isa_ext_id {
> > > > +     RISCV_ISA_EXT_ID_MAX =3D RISCV_ISA_EXT_MAX,
> > > > +};
> > > >
> > > >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bi=
tmap);
> > > >
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpu=
feature.c
> > > > index e9e3b0693d16..469b9739faf7 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
> > > >
> > > >       for_each_of_cpu_node(node) {
> > > >               unsigned long this_hwcap =3D 0;
> > > > -             unsigned long this_isa =3D 0;
> > > > +             uint64_t this_isa =3D 0;
> > > >
> > > >               if (riscv_of_processor_hartid(node) < 0)
> > > >                       continue;
> > > > @@ -169,12 +169,22 @@ void __init riscv_fill_hwcap(void)
> > > >                       if (*isa !=3D '_')
> > > >                               --isa;
> > > >
> > > > +#define SET_ISA_EXT_MAP(name, bit)                                =
           \
> > > > +                     do {                                         =
           \
> > > > +                             if ((ext_end - ext =3D=3D sizeof(name=
) - 1) &&      \
> > > > +                                  !memcmp(ext, name, sizeof(name) =
- 1)) {    \
> > > > +                                     this_isa |=3D (1UL << bit);  =
             \
> > > > +                                     pr_info("Found ISA extension =
%s", name);\
> > > > +                             }                                    =
           \
> > > > +                     } while (false)                              =
           \
> > > > +
> > > >                       if (unlikely(ext_err))
> > > >                               continue;
> > > >                       if (!ext_long) {
> > > >                               this_hwcap |=3D isa2hwcap[(unsigned c=
har)(*ext)];
> > > >                               this_isa |=3D (1UL << (*ext - 'a'));
> > > >                       }
> > > > +#undef SET_ISA_EXT_MAP
> > > >               }
> > > >
> > > >               /*
> > > > @@ -187,10 +197,21 @@ void __init riscv_fill_hwcap(void)
> > > >               else
> > > >                       elf_hwcap =3D this_hwcap;
> > > >
> > > > -             if (riscv_isa[0])
> > > > +             if (riscv_isa[0]) {
> > > > +#if IS_ENABLED(CONFIG_32BIT)
> > > > +                     riscv_isa[0] &=3D this_isa & 0xFFFFFFFF;
> > > > +                     riscv_isa[1] &=3D this_isa >> 32;
> > > > +#else
> > > >                       riscv_isa[0] &=3D this_isa;
> > > > -             else
> > > > +#endif
> > > > +             } else {
> > > > +#if IS_ENABLED(CONFIG_32BIT)
> > > > +                     riscv_isa[0] =3D this_isa & 0xFFFFFFFF;
> > > > +                     riscv_isa[1] =3D this_isa >> 32;
> > > > +#else
> > > >                       riscv_isa[0] =3D this_isa;
> > > > +#endif
> > > > +             }
> > > >       }
> > > >
> > > >       /* We don't support systems with F but without D, so mask tho=
se out
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


--=20
Regards,
Atish
