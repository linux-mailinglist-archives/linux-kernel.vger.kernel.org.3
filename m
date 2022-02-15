Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2628E4B7B11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbiBOXMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:12:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbiBOXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:12:14 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B4B13F74
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:12:03 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c6so774001ybk.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=loAfDoGLfr/iqSIkMgZ8bYEjmt72BeZCLhtdpL5OIaQ=;
        b=gNwn4w1BBG0QO8d7il/hS7XnsvBv8CEpuRu43msQBQZCnhs9Fnj5h72+hczDMizL64
         9MeW8FDditxJs7M787wypzS7HhaJKVRx4aLxywV+pZoSHdANKzvX0JPQx2u6to6zWfDy
         ZXcynRo469aF4QZX+xgx+6suPf+EIZz6Cfvl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=loAfDoGLfr/iqSIkMgZ8bYEjmt72BeZCLhtdpL5OIaQ=;
        b=uWB6E3V/iwYNdUoCxwtNa/NsvRnR7iSXUE3naD/7DnNfpSRr3QU5/6PurfVqw4fDcK
         lA+9PKaiEsTL/rVxV1Diu+ywuTFUg/uHBIoDr0GInpsAZ/aSU8bD1PJXGCdKdHgv8adO
         R0JnSlyVi2UrmVlQigKrs3CDRLrbsTBHiDHJi1C9C4EYiWgt6q46+jhd2EWoaipAm68X
         uEHLMgsJ4eC3fhwJt+/kdAzC7d6GSxbhAP6rbqBmf6P7BJfYJ1aCwnvk7l0+gJF3/Q4s
         XJzY/He/abpfhFiaGScBwT38s238Ce3xJ+ZUgur0EVuFM3ulcy6xCjSO57oRmv7ksdgl
         ox8g==
X-Gm-Message-State: AOAM5317Y+2xbciVUHynSIuEkIwpPVhZWmAyEKtIcd6HQSEm0UvcMdkS
        uP7q9Hn+cuSpvI0s3I78u9QJgy6t5K51lp0hR/8n
X-Google-Smtp-Source: ABdhPJyU6ADhFsSkKFw6pjjAvZ21yhhrWabJjiIocdygUARwxsgbNK6NODHq3oiHUoD9dlFnAQQTVwPWoB0Pj4jiqlw=
X-Received: by 2002:a25:c794:: with SMTP id w142mr1196085ybe.632.1644966722684;
 Tue, 15 Feb 2022 15:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20220215090211.911366-1-atishp@rivosinc.com> <20220215090211.911366-5-atishp@rivosinc.com>
 <CAAhSdy29nzXFesfeMjY_FkTmTZ4yrHjGxTweBCVn-wFFHnMV=A@mail.gmail.com>
In-Reply-To: <CAAhSdy29nzXFesfeMjY_FkTmTZ4yrHjGxTweBCVn-wFFHnMV=A@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 15 Feb 2022 15:11:51 -0800
Message-ID: <CAOnJCUJR1V2xBxr61xYH6PAYEooqGuMtuyvA-wWXFVAwYsG3Gw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] RISC-V: Implement multi-letter ISA extension
 probing framework
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 2:24 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Feb 15, 2022 at 2:32 PM Atish Patra <atishp@rivosinc.com> wrote:
> >
> > Multi-letter extensions can be probed using exising
> > riscv_isa_extension_available API now. It doesn't support versioning
> > right now as there is no use case for it.
> > Individual extension specific implementation will be added during
> > each extension support.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 18 ++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c | 27 ++++++++++++++++++++++++---
> >  2 files changed, 42 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 5ce50468aff1..170bd80da520 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -34,7 +34,25 @@ extern unsigned long elf_hwcap;
> >  #define RISCV_ISA_EXT_s                ('s' - 'a')
> >  #define RISCV_ISA_EXT_u                ('u' - 'a')
> >
> > +/*
> > + * Increse this to higher value as kernel support more ISA extensions.
> > + */
> >  #define RISCV_ISA_EXT_MAX      64
> > +#define RISCV_ISA_EXT_NAME_LEN_MAX 32
> > +
> > +/* The base ID for multi-letter ISA extensions */
> > +#define RISCV_ISA_EXT_BASE 26
> > +
> > +/*
> > + * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
> > + * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
> > + * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
> > + * extensions while all the multi-letter extensions should define the next
> > + * available logical extension id.
> > + */
> > +enum riscv_isa_ext_id {
> > +       RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> > +};
> >
> >  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index cd9eb34f8d11..af9a57ad3d4e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -83,7 +83,7 @@ void __init riscv_fill_hwcap(void)
> >
> >         for_each_of_cpu_node(node) {
> >                 unsigned long this_hwcap = 0;
> > -               unsigned long this_isa = 0;
> > +               uint64_t this_isa = 0;
>
> Why not use a bitmap here ?
>

Yeah. That will simplify things for both RV32 & RV64. Thanks.

> >
> >                 if (riscv_of_processor_hartid(node) < 0)
> >                         continue;
> > @@ -167,12 +167,22 @@ void __init riscv_fill_hwcap(void)
> >                         if (*isa != '_')
> >                                 --isa;
> >
> > +#define SET_ISA_EXT_MAP(name, bit)                                             \
>
> Where is this macro used ?

It will be used in the future where individual extension support will use it.
Here is an example from my debug patch

https://github.com/atishp04/linux/commit/e9e240c9a854dceb434ceb53bdbe82a657bee5f2

>
> > +                       do {                                                    \
> > +                               if ((ext_end - ext == sizeof(name) - 1) &&      \
> > +                                    !memcmp(ext, name, sizeof(name) - 1)) {    \
> > +                                       this_isa |= (1UL << bit);               \
>
> You can use set_bit() here when using bitmap.
>
> > +                                       pr_info("Found ISA extension %s", name);\
> > +                               }                                               \
> > +                       } while (false)                                         \
> > +
> >                         if (unlikely(ext_err))
> >                                 continue;
> >                         if (!ext_long) {
> >                                 this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> >                                 this_isa |= (1UL << (*ext - 'a'));
> >                         }
> > +#undef SET_ISA_EXT_MAP
> >                 }
> >
> >                 /*
> > @@ -185,10 +195,21 @@ void __init riscv_fill_hwcap(void)
> >                 else
> >                         elf_hwcap = this_hwcap;
> >
> > -               if (riscv_isa[0])
> > +               if (riscv_isa[0]) {
>
> You can use bitmap_weight() here
>
> > +#if IS_ENABLED(CONFIG_32BIT)
> > +                       riscv_isa[0] &= this_isa & 0xFFFFFFFF;
> > +                       riscv_isa[1] &= this_isa >> 32;
> > +#else
> >                         riscv_isa[0] &= this_isa;
> > -               else
> > +#endif
> > +               } else {
> > +#if IS_ENABLED(CONFIG_32BIT)
> > +                       riscv_isa[0] = this_isa & 0xFFFFFFFF;
> > +                       riscv_isa[1] = this_isa >> 32;
> > +#else
> >                         riscv_isa[0] = this_isa;
> > +#endif
> > +               }
> >         }
> >
> >         /* We don't support systems with F but without D, so mask those out
> > --
> > 2.30.2
> >
>
> Regards,
> Anup



-- 
Regards,
Atish
