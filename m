Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EE54CF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbiFORGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiFORGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:06:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408644F9D9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:06:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2698071pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X6U4Sh6IoO9AMkHFDosIKSFxwSjXcTB6jtV5NXDLAb0=;
        b=3ki+GZBjs6+mXREQJvHa1f5PQqgiDv7ehljSqU/MhC+F21bLvEiBlI8K8JqjbiZfkD
         wvVjwu8He46uOGtE6q5pnIhgrkvNfkgbtpGu4C5AZ1XQrWq5SVzqdqhLkz/3YuJ2mAlp
         4pJFs0LZI09mrDpi+Imh4OoF8RI/LtviN142qRiroWIkLJ0d8HbrDFKmnntsovtS8PCa
         ZgCjrmBlea3rit3a9Wt7VB19gZhLET0qljCsTtdA9ZNukdJw8I1ICCvLz5CMHxMfb/K/
         BGV+6UdT/5G7OjFD8BjOCTPUsNaP1jLKARED7SzUR8R070IR+447V+HSACaNdlVfZSDV
         z2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X6U4Sh6IoO9AMkHFDosIKSFxwSjXcTB6jtV5NXDLAb0=;
        b=pqyxp+mApAzp1EOfNqdwzs4dhd6KFhpgieej9H9XK80v4OtbQchO+Ykx+jJUGUiwTj
         /ylbVf0LTswx3ewnGdXGF9OH20poXH0r977B9tdc5xPzzyuzxIbgs82uNvHz8UaljLV+
         mQtc3dp3eafTjqna0oFsPuu9P1xqTnnltkB6gUYxm6nF34gSSuD1EWkw6VutDNaOjDc/
         lmzgKYNJrMpTagE/fTEmWIcLVgme+3yYqcm7gF1stIxoKjLm4mBsmPfAax8Jql5N5T1U
         Yp4xsvbxORUwpPQnOK1zjTLTifTPH2rQ/FyJ+70NxoPZSpboJO9qjlApJKX7aAkQJVYH
         jxJQ==
X-Gm-Message-State: AJIora/w1XD6IgzH6PBsjLsMUdvBeEyOST1fRIch6gquWjxdS0Scxx8u
        75E92QEyrRUkNHtQ9DXPMnehjjO4TL8LPeIqYyVM1Q==
X-Google-Smtp-Source: AGRyM1v7wjpHYcPjOYJUGLotI15cStcftvoCDRlXC5dPpAgbZRa+6TH4dnkj6tfWcZw7cAU0HxfRwb/M5Ylp/wHYjY0=
X-Received: by 2002:a17:902:b407:b0:168:e554:33be with SMTP id
 x7-20020a170902b40700b00168e55433bemr361060plr.130.1655312771712; Wed, 15 Jun
 2022 10:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220524211954.1936117-1-daolu@rivosinc.com> <3113192.5fSG56mABF@diego>
In-Reply-To: <3113192.5fSG56mABF@diego>
From:   Dao Lu <daolu@rivosinc.com>
Date:   Wed, 15 Jun 2022 10:06:01 -0700
Message-ID: <CAKh7v-TZ3+t+_MRYQSxjbm3qJ6huHO4NBiv2OEMbXB0=4LeRNA@mail.gmail.com>
Subject: Re: [PATCH v2] arch/riscv: add Zihintpause support
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>
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

Thanks Heiko and Palmer, will address the comments, rebase and send a v3.

On Tue, Jun 14, 2022 at 9:44 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Dienstag, 24. Mai 2022, 23:19:50 CEST schrieb Dao Lu:
> > Implement support for the ZiHintPause extension.
> >
> > The PAUSE instruction is a HINT that indicates the current hart=E2=80=
=99s rate of
> > instruction retirement should be temporarily reduced or paused.
> >
> > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Dao Lu <daolu@rivosinc.com>
> > ---
> >
> > v1 -> v2:
> >  Remove the usage of static branch, use PAUSE if toolchain supports it
> >
> >  arch/riscv/Makefile                     | 4 ++++
> >  arch/riscv/include/asm/hwcap.h          | 1 +
> >  arch/riscv/include/asm/vdso/processor.h | 8 +++++++-
> >  arch/riscv/kernel/cpu.c                 | 1 +
> >  arch/riscv/kernel/cpufeature.c          | 2 ++
> >  5 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 7d81102cffd4..900a8fda1a2d 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)  :=3D $(riscv-marc=
h-y)c
> >  toolchain-need-zicsr-zifencei :=3D $(call cc-option-yn, -march=3D$(ris=
cv-march-y)_zicsr_zifencei)
> >  riscv-march-$(toolchain-need-zicsr-zifencei) :=3D $(riscv-march-y)_zic=
sr_zifencei
> >
> > +# Check if the toolchain supports Zihintpause extension
> > +toolchain-supports-zihintpause :=3D $(call cc-option-yn, -march=3D$(ri=
scv-march-y)_zihintpause)
> > +riscv-march-$(toolchain-supports-zihintpause) :=3D $(riscv-march-y)_zi=
hintpause
> > +
> >  KBUILD_CFLAGS +=3D -march=3D$(subst fd,,$(riscv-march-y))
> >  KBUILD_AFLAGS +=3D -march=3D$(riscv-march-y)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index 0734e42f74f2..caa9ee5459b4 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
> >   */
> >  enum riscv_isa_ext_id {
> >       RISCV_ISA_EXT_SSCOFPMF =3D RISCV_ISA_EXT_BASE,
>
> svpbmt got merged meanwhile, so this patch needs a rebase
> onto 5.19-rc.
>
> One more nit below
>
> > +     RISCV_ISA_EXT_ZIHINTPAUSE,
> >       RISCV_ISA_EXT_ID_MAX =3D RISCV_ISA_EXT_MAX,
> >  };
> >
> > diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/inclu=
de/asm/vdso/processor.h
> > index 134388cbaaa1..4de911a25051 100644
> > --- a/arch/riscv/include/asm/vdso/processor.h
> > +++ b/arch/riscv/include/asm/vdso/processor.h
> > @@ -8,7 +8,13 @@
> >
> >  static inline void cpu_relax(void)
> >  {
> > -#ifdef __riscv_muldiv
> > +#ifdef __riscv_zihintpause
> > +     /*
> > +      * Reduce instruction retirement.
> > +      * This assumes the PC changes.
> > +      */
> > +     __asm__ __volatile__ ("pause");
> > +#elif __riscv_muldiv
> >       int dummy;
> >       /* In lieu of a halt instruction, induce a long-latency stall. */
> >       __asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy));
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index ccb617791e56..89e563e9c4cc 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -88,6 +88,7 @@ int riscv_of_parent_hartid(struct device_node *node)
> >   */
> >  static struct riscv_isa_ext_data isa_ext_arr[] =3D {
> >       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > +     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >       __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >  };
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 1b2d42d7f589..37ff06682ae6 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -25,6 +25,7 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) _=
_read_mostly;
> >  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
> >  #endif
> >
> > +
>
> this is an unrelated change and also is adding an unneeded extra empty li=
ne.
>
>
> Heiko
>
> >  /**
> >   * riscv_isa_extension_base() - Get base extension word
> >   *
> > @@ -192,6 +193,7 @@ void __init riscv_fill_hwcap(void)
> >                               set_bit(*ext - 'a', this_isa);
> >                       } else {
> >                               SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT=
_SSCOFPMF);
> > +                             SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_=
EXT_ZIHINTPAUSE);
> >                       }
> >  #undef SET_ISA_EXT_MAP
> >               }
> >
>
>
>
>
