Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C274B5B78
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiBNUvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:51:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiBNUvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:51:53 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A8116BFA5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:51:36 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id v6-20020a05683024a600b005ac1754342fso8765407ots.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kGBEFAYbaLpqMalFqEbdF8CMyFM//dqVIIoAUyybZhY=;
        b=nHWM1dUXTwzVoJmGZtBmCKnqa0kMnBrJbKSVwJC/ZkJjyIRJVPSh9e5cLhYAbHGOvv
         BA3ihuEZd89wB77VDUUnDycnqKXD8qF4dR27XkYyuqRB0Rku2ypXXX/sewJV/xRKpuZB
         n+FoP3+RiJXvS0QjhXOHHEF9o/4RVuNOQHs/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kGBEFAYbaLpqMalFqEbdF8CMyFM//dqVIIoAUyybZhY=;
        b=bzxCZdjqLykK0VoucsfjI6Mw/gknumnKKVJf8JQXQuF77sSNqJRJHgTxPdYu5/Zamv
         tCHpzsi6Ad20QC2cMNSuYF9+YXUA5TDnuzRb0qUqQ/JSi3Xs2rHjKVAEiMrjJPfjL433
         nSAu7UbZTGtMDBTEnZidJmiOQTSPCK7tSJe52o3gp/bHQjjbCl5nH9QkXFUOl4JE6YL+
         lwRgbT8GuuCmrBz7BgaSATi3AtB4GhdCjteMYxDGXevsDnqp9kaIMEIDgt+0U2RSD5jL
         t6skRRMzvY5OksIOH64xqvmTCIiKudbNeDyTYcBXDCEuBcXF85Fg7pwJlsU2XwhlcQHV
         RtAw==
X-Gm-Message-State: AOAM532yJS81DFH/HJhKBspedzqsCDo0BadxnUekahwsBi88agQfVYNK
        wQQSX21q2S2gFjH2ZbskohNC6urqwzdOMwfPWrkKgw/EO6OV
X-Google-Smtp-Source: ABdhPJy9iWrjlJ1/7f5PyrkeukMSg4A7DFeq3zidpdYp4uG08BhZuPqtKTLfDxzE8Och0iVX9MsRI+gwY1fppNR4gqk=
X-Received: by 2002:a25:8b0a:: with SMTP id i10mr765883ybl.651.1644869664014;
 Mon, 14 Feb 2022 12:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20220210214018.55739-1-atishp@rivosinc.com> <20220210214018.55739-5-atishp@rivosinc.com>
 <3881365.IPMWXPQfj1@diego>
In-Reply-To: <3881365.IPMWXPQfj1@diego>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 14 Feb 2022 12:14:13 -0800
Message-ID: <CAOnJCUK1CwJ=J+y9EqszY0aACQsDdpLqCDbEZ1ZNDRdHE9C4gA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:06 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
>
> Am Donnerstag, 10. Februar 2022, 22:40:16 CET schrieb Atish Patra:
> > Multi-letter extensions can be probed using exising
> > riscv_isa_extension_available API now. It doesn't support versioning
> > right now as there is no use case for it.
> > Individual extension specific implementation will be added during
> > each extension support.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
>
>
> By the way, does a similar parsing exist for opensbi as well?
> Things like svpbmt as well as zicbom have CSR bits controlling how
> these functions should behave (enabling them, etc), so I guess
> opensbi also needs to parse the extensions from the ISA string?
>
>

No. Currently, OpenSBI relies on the CSR read/write & trap method to
identify the extensions [1].

https://github.com/riscv-software-src/opensbi/blob/master/lib/sbi/sbi_hart.=
c#L404

In the future, zicbom can be detected in the same manner. However,
svpbmt is a bit tricky as it doesn't
define any new CSR. Do you think OpenSBI needs to detect svpbmt for any rea=
son ?

> Heiko
>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c | 27 ++++++++++++++++++++++++---
> >  2 files changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index 5ce50468aff1..170bd80da520 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -34,7 +34,25 @@ extern unsigned long elf_hwcap;
> >  #define RISCV_ISA_EXT_s              ('s' - 'a')
> >  #define RISCV_ISA_EXT_u              ('u' - 'a')
> >
> > +/*
> > + * Increse this to higher value as kernel support more ISA extensions.
> > + */
> >  #define RISCV_ISA_EXT_MAX    64
> > +#define RISCV_ISA_EXT_NAME_LEN_MAX 32
> > +
> > +/* The base ID for multi-letter ISA extensions */
> > +#define RISCV_ISA_EXT_BASE 26
> > +
> > +/*
> > + * This enum represent the logical ID for each multi-letter RISC-V ISA=
 extension.
> > + * The logical ID should start from RISCV_ISA_EXT_BASE and must not ex=
ceed
> > + * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> > + * extensions while all the multi-letter extensions should define the =
next
> > + * available logical extension id.
> > + */
> > +enum riscv_isa_ext_id {
> > +     RISCV_ISA_EXT_ID_MAX =3D RISCV_ISA_EXT_MAX,
> > +};
> >
> >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap=
);
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index e9e3b0693d16..469b9739faf7 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
> >
> >       for_each_of_cpu_node(node) {
> >               unsigned long this_hwcap =3D 0;
> > -             unsigned long this_isa =3D 0;
> > +             uint64_t this_isa =3D 0;
> >
> >               if (riscv_of_processor_hartid(node) < 0)
> >                       continue;
> > @@ -169,12 +169,22 @@ void __init riscv_fill_hwcap(void)
> >                       if (*isa !=3D '_')
> >                               --isa;
> >
> > +#define SET_ISA_EXT_MAP(name, bit)                                    =
       \
> > +                     do {                                             =
       \
> > +                             if ((ext_end - ext =3D=3D sizeof(name) - =
1) &&      \
> > +                                  !memcmp(ext, name, sizeof(name) - 1)=
) {    \
> > +                                     this_isa |=3D (1UL << bit);      =
         \
> > +                                     pr_info("Found ISA extension %s",=
 name);\
> > +                             }                                        =
       \
> > +                     } while (false)                                  =
       \
> > +
> >                       if (unlikely(ext_err))
> >                               continue;
> >                       if (!ext_long) {
> >                               this_hwcap |=3D isa2hwcap[(unsigned char)=
(*ext)];
> >                               this_isa |=3D (1UL << (*ext - 'a'));
> >                       }
> > +#undef SET_ISA_EXT_MAP
> >               }
> >
> >               /*
> > @@ -187,10 +197,21 @@ void __init riscv_fill_hwcap(void)
> >               else
> >                       elf_hwcap =3D this_hwcap;
> >
> > -             if (riscv_isa[0])
> > +             if (riscv_isa[0]) {
> > +#if IS_ENABLED(CONFIG_32BIT)
> > +                     riscv_isa[0] &=3D this_isa & 0xFFFFFFFF;
> > +                     riscv_isa[1] &=3D this_isa >> 32;
> > +#else
> >                       riscv_isa[0] &=3D this_isa;
> > -             else
> > +#endif
> > +             } else {
> > +#if IS_ENABLED(CONFIG_32BIT)
> > +                     riscv_isa[0] =3D this_isa & 0xFFFFFFFF;
> > +                     riscv_isa[1] =3D this_isa >> 32;
> > +#else
> >                       riscv_isa[0] =3D this_isa;
> > +#endif
> > +             }
> >       }
> >
> >       /* We don't support systems with F but without D, so mask those o=
ut
> >
>
>
>
>


--=20
Regards,
Atish
