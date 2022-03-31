Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E989E4ED59F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiCaIbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiCaIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:31:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3235437028
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:29:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so32575104wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wVr/pwaQ//OyUW/xlrrZtzwk/VHF+xv/hJ0hbn99xUA=;
        b=bHBOFrGbyK6usdxVtb26YnVzA+j2UPUGlRCj9+EpHRwmAwewC8N7LzjM2J+BPcRBke
         u2mwI2K8Q+wAi8EG6onSjLV9ap272GU6SCA0LbcZ9hhaVeCWvr1aNc7BJzVQxgxI5j2/
         mILloB1kj6BQSVTPYLbXN131r75ruT9an6y2k1XQZ4Az4BHGKKPpEaUIJoZOZf6OAFa8
         NBRfg2OufDrqJC0SHFkJr2fpvYfa+IFyDmwFpnzJKI59HiX1dbrl0YhdjUHgXCyCJeHt
         XDlVjx1eDj72hN37AvJSnLEqDXd4DMyuO8+G0j8NIfJ/lBRCKGFhRILSo0mXIwWhaz70
         MZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wVr/pwaQ//OyUW/xlrrZtzwk/VHF+xv/hJ0hbn99xUA=;
        b=NC333coIxSfkr5utbKZ2LK6x8yz6B7ssYteXfZDSk2yt13X9fzqa1WpWbJExU67Hbf
         3H4KJoQttUxdMmBM5KpuaGenx9gJB4VMyY6TJ4/1m15OcfFcWLgoIJug4DYiLxL5HZow
         WsOFsrLeM/aC6pScdet8yFoTv08ndLfUjPAC/VqYkeo7rBHmJoMEcvKwmWIqRNf0vsTE
         xrTc4ST50iHZhcXpMgnCTL7FemTf8jCB5S+a3V28BWbfOhxv0Aixz8VwNdnEenO34X5H
         M0B2Gh2sxhL6iFBUIl0wPXI/p2NIjok6Hjg5V1xp0BqjKF4ippjsgPYjn5dknOkgrJq1
         UOeg==
X-Gm-Message-State: AOAM5336BVreX/OeVelC61mc2e70RvyXNmwiUXd0T2Mo6w/fgdQSn0Xt
        UtTMMst8482e+hNTDMkNZZ7gYeWtv4tIhM6eOMe+pg==
X-Google-Smtp-Source: ABdhPJzgXIZU2HUiAQFAb5W6LxBHCRo1D/DGebIXHrg++RnO0NOxbwpwd5dxp6c3hmZ0B7KvdvLQ3wPePh/yzFlxcxk=
X-Received: by 2002:adf:ebc7:0:b0:1ee:945a:ffb4 with SMTP id
 v7-20020adfebc7000000b001ee945affb4mr3181602wrn.641.1648715388617; Thu, 31
 Mar 2022 01:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-3c71e6fc-cd1c-4796-8b50-6768485b8f4a@palmer-ri-x1c9> <5787392.alqRGMn8q6@diego>
In-Reply-To: <5787392.alqRGMn8q6@diego>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Thu, 31 Mar 2022 10:29:37 +0200
Message-ID: <CAAeLtUCVs96DW8rFDi84WB2r8BFz9tFwyX_548HNZxZJjQqO3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: implement cache-management errata for T-Head SoCs
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com
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

Palmer,

Could you confirm that I correctly understood what you require: is it
that a patch is on the binutils list?

Philipp.


On Thu, 31 Mar 2022 at 10:22, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Palmer,
>
> Am Donnerstag, 31. M=C3=A4rz 2022, 04:30:36 CEST schrieb Palmer Dabbelt:
> > On Mon, 07 Mar 2022 14:46:20 PST (-0800), heiko@sntech.de wrote:
> > > The T-Head C906 and C910 implement a scheme for handling
> > > cache operations different from the generic Zicbom extension.
> > >
> > > Add an errata for it next to the generic dma coherency ops.
> > >
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  arch/riscv/Kconfig.erratas           | 10 +++++++
> > >  arch/riscv/errata/thead/errata.c     |  5 ++++
> > >  arch/riscv/include/asm/errata_list.h | 45 ++++++++++++++++++++++++++=
--
> > >  3 files changed, 57 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> > > index de4002baa1d0..89a6dcb8ac2a 100644
> > > --- a/arch/riscv/Kconfig.erratas
> > > +++ b/arch/riscv/Kconfig.erratas
> > > @@ -50,4 +50,14 @@ config ERRATA_THEAD_PBMT
> > >
> > >       If you don't know what to do here, say "Y".
> > >
> > > +config ERRATA_THEAD_CMO
> > > +   bool "Apply T-Head cache management errata"
> > > +   depends on ERRATA_THEAD && RISCV_DMA_NONCOHERENT
> > > +   default y
> > > +   help
> > > +     This will apply the cache management errata to handle the
> > > +     non-standard handling on non-coherent operations on T-Head SoCs=
.
> > > +
> > > +     If you don't know what to do here, say "Y".
> > > +
> > >  endmenu
> > > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/the=
ad/errata.c
> > > index fd8e0538a3f0..11c26c37425f 100644
> > > --- a/arch/riscv/errata/thead/errata.c
> > > +++ b/arch/riscv/errata/thead/errata.c
> > > @@ -33,6 +33,11 @@ static const struct errata_info errata_list[ERRATA=
_THEAD_NUMBER] =3D {
> > >             .stage =3D RISCV_ALTERNATIVES_EARLY_BOOT,
> > >             .check_func =3D errata_mt_check_func
> > >     },
> > > +   {
> > > +           .name =3D "cache-management",
> > > +           .stage =3D RISCV_ALTERNATIVES_BOOT,
> > > +           .check_func =3D errata_mt_check_func
> > > +   },
> > >  };
> > >
> > >  static u32 thead_errata_probe(unsigned int stage, unsigned long arch=
id, unsigned long impid)
> > > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/includ=
e/asm/errata_list.h
> > > index 7a2dd61af24d..f7c6805daeab 100644
> > > --- a/arch/riscv/include/asm/errata_list.h
> > > +++ b/arch/riscv/include/asm/errata_list.h
> > > @@ -16,7 +16,8 @@
> > >
> > >  #ifdef CONFIG_ERRATA_THEAD
> > >  #define    ERRATA_THEAD_PBMT 0
> > > -#define    ERRATA_THEAD_NUMBER 1
> > > +#define    ERRATA_THEAD_CMO 1
> > > +#define    ERRATA_THEAD_NUMBER 2
> > >  #endif
> > >
> > >  #define    CPUFEATURE_SVPBMT 0
> > > @@ -104,8 +105,37 @@ asm volatile(ALTERNATIVE(                       =
                                       \
> > >  #define CBO_CLEAN_A0       ".long 0x25200F"
> > >  #define CBO_FLUSH_A0       ".long 0x05200F"
> > >
> > > +/*
> > > + * dcache.ipa rs1 (invalidate, physical address)
> > > + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > > + *   0000001    01010      rs1       000      00000  0001011
> > > + * dache.iva rs1 (invalida, virtual address)
> > > + *   0000001    00110      rs1       000      00000  0001011
> > > + *
> > > + * dcache.cpa rs1 (clean, physical address)
> > > + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > > + *   0000001    01001      rs1       000      00000  0001011
> > > + * dcache.cva rs1 (clean, virtual address)
> > > + *   0000001    00100      rs1       000      00000  0001011
> > > + *
> > > + * dcache.cipa rs1 (clean then invalidate, physical address)
> > > + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > > + *   0000001    01011      rs1       000      00000  0001011
> > > + * dcache.civa rs1 (... virtual address)
> > > + *   0000001    00111      rs1       000      00000  0001011
> > > + *
> > > + * sync.s (make sure all cache operations finished)
> > > + * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> > > + *   0000000    11001     00000      000      00000  0001011
> > > + */
> > > +#define THEAD_INVAL_A0     ".long 0x0265000b"
> > > +#define THEAD_CLEAN_A0     ".long 0x0245000b"
> > > +#define THEAD_FLUSH_A0     ".long 0x0275000b"
> > > +#define THEAD_SYNC_S       ".long 0x0190000b"
> >
> > IIRC this came up before, but these really need to get into the
> > assembler as actual instructions.
>
> okay :-) .
>
> But just for my understanding which of the two ways going forward:
> - keep this in the waiting area _until_ a suitable binutils is released
> - use the coded instructions now and convert later once binutils is relea=
sed
>
> The reason I ask is, that any chip with a t-head core like the Allwinner-=
D1
> will need this for things like basic networking, so with the binutils
> release schedule, I guess we'd be looking at autumn 2022 at the earliest.
>
>
> Thanks
> Heiko
>
> > > +
> > >  #define ALT_CMO_OP(_op, _start, _size)                              =
                       \
> > > -asm volatile(ALTERNATIVE(                                           =
               \
> > > +asm volatile(ALTERNATIVE_2(                                         =
                       \
> > > +   "nop\n\t"                                                        =
               \
> > >     "nop\n\t"                                                        =
               \
> > >     "nop\n\t"                                                        =
               \
> > >     "nop\n\t"                                                        =
               \
> > > @@ -117,7 +147,16 @@ asm volatile(ALTERNATIVE(                       =
                                       \
> > >     CBO_##_op##_A0 "\n\t"                                            =
               \
> > >     "addi a0, a0, %0\n\t"                                            =
               \
> > >     "2:\n\t"                                                         =
               \
> > > -   "bltu a0, %2, 3b\n\t", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOH=
ERENT)         \
> > > +   "bltu a0, %2, 3b\n\t"                                            =
               \
> > > +   "nop", 0, CPUFEATURE_CMO, CONFIG_RISCV_DMA_NONCOHERENT,          =
               \
> > > +   "mv a0, %1\n\t"                                                  =
               \
> > > +   "j 2f\n\t"                                                       =
               \
> > > +   "3:\n\t"                                                         =
               \
> > > +   THEAD_##_op##_A0 "\n\t"                                          =
               \
> > > +   "addi a0, a0, %0\n\t"                                            =
               \
> > > +   "2:\n\t"                                                         =
               \
> > > +   "bltu a0, %2, 3b\n\t"                                            =
               \
> > > +   THEAD_SYNC_S, THEAD_VENDOR_ID, ERRATA_THEAD_CMO, CONFIG_ERRATA_TH=
EAD_CMO)       \
> > >     : : "I"(L1_CACHE_BYTES), "r"((_start) & ~(L1_CACHE_BYTES - 1)),  =
               \
> > >         "r"(ALIGN((_start) + (_size), L1_CACHE_BYTES)))
> >
>
>
>
>
