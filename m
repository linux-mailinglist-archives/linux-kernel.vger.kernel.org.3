Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1064B31F7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354425AbiBLA2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:28:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354405AbiBLA2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:28:01 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E06CF9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:27:58 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p19so29591675ybc.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h0XjfV5S+NZoNqf5ccb+0dn5q5hDN4Ozr6b7SwitfP0=;
        b=A4hnXb7sELAaFz1JChb22KKUrzglu2B3xSFj9t5wDoFY51BkyGegR/QcoEZbtN012T
         9qWb9UfuL5zqiAk8ukM77+Wtix/GUK59iDpKhb0a1yygeDI1FiOk3EbRLZDUuKeTLk2T
         1/UC5eE7wAnYkXvf0o6kVTgiThIzYdIAtFbhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h0XjfV5S+NZoNqf5ccb+0dn5q5hDN4Ozr6b7SwitfP0=;
        b=34cs/EC6CBxzLAppbSG/NUHz8yEIWYyeNQMtUHKKciUOecVqybnbcWP6S9gxNclinz
         vM++p3ggkyN6TSYdzePx/yASelwXnOTg6zGeMSmSDpYvy2kVrx2e1ydjAQChmVHAUThn
         b0wuyaNKwnB1A5GdcNl4OccqM542RFQY4CGZEh/t0rPx58ZFsUVNxMqcorZhvWnQXG9Y
         D/jgin/AM1LLMlNhWTLIr93jIAnrB34ai/68DNpDQYWJC/5rGSuNF1o90T2DJNZ4Xs0u
         S10zdlPzImMEFaNhfjGKVeCzfIikapBsl9TwoN3QxwzxH/YmwOsfy1SwOHeYA5RCmxFT
         TBWw==
X-Gm-Message-State: AOAM5325JMnPn8bY2eUK5gxnz2yMVNqEY0t8R8TLyllDOCZ+PQTRxvVq
        sh07CCHNVnYg6+5YWAKiALKJyJ+f2FP+lu0vAh/k
X-Google-Smtp-Source: ABdhPJwiG1dvT40Hpnip7vDBtgicQG7ZFT9r0xVQnaRyQy8GLIc9oO84EQrJE4Ao2vcbZKTKEaPgudHQ4u4BhsOgOFA=
X-Received: by 2002:a25:e406:: with SMTP id b6mr3800421ybh.703.1644625677748;
 Fri, 11 Feb 2022 16:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20220209123800.269774-1-heiko@sntech.de> <20220209123800.269774-15-heiko@sntech.de>
 <CAOnJCU+zoSfvyFg0swotCt1NH9bHOr4OX0g4H97ZkV4-UpSyNw@mail.gmail.com> <2456541.MUnXTO88Fi@diego>
In-Reply-To: <2456541.MUnXTO88Fi@diego>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 11 Feb 2022 16:27:46 -0800
Message-ID: <CAOnJCULt6kgjj5tZBS9OwRRqayEt8xtJwMQFuaQGrW9a8t8oMg@mail.gmail.com>
Subject: Re: [PATCH v6 14/14] riscv: add memory-type errata for T-Head
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
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

On Fri, Feb 11, 2022 at 1:25 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Atish,
>
> Am Freitag, 11. Februar 2022, 01:12:55 CET schrieb Atish Patra:
> > On Wed, Feb 9, 2022 at 4:41 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > Some current cpus based on T-Head cores implement memory-types
> > > way different than described in the svpbmt spec even going
> > > so far as using PTE bits marked as reserved.
> > >
> > > Add the T-Head vendor-id and necessary errata code to
> > > replace the affected instructions.
> > >
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  arch/riscv/Kconfig.erratas             | 19 ++++++
> > >  arch/riscv/errata/Makefile             |  1 +
> > >  arch/riscv/errata/sifive/errata.c      |  7 ++-
> > >  arch/riscv/errata/thead/Makefile       |  1 +
> > >  arch/riscv/errata/thead/errata.c       | 85 ++++++++++++++++++++++++=
++
> > >  arch/riscv/include/asm/alternative.h   |  5 ++
> > >  arch/riscv/include/asm/errata_list.h   | 47 ++++++++++++--
> > >  arch/riscv/include/asm/pgtable-64.h    | 18 +++++-
> > >  arch/riscv/include/asm/pgtable.h       | 18 +++++-
> > >  arch/riscv/include/asm/vendorid_list.h |  1 +
> > >  arch/riscv/kernel/alternative.c        | 14 +++++
> > >  arch/riscv/kernel/cpufeature.c         |  2 +
> > >  arch/riscv/mm/init.c                   |  1 +
> > >  13 files changed, 210 insertions(+), 9 deletions(-)
> > >  create mode 100644 arch/riscv/errata/thead/Makefile
> > >  create mode 100644 arch/riscv/errata/thead/errata.c
> > >
> > > diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
> > > index d18be8ff0245..380ec039c3dc 100644
> > > --- a/arch/riscv/Kconfig.erratas
> > > +++ b/arch/riscv/Kconfig.erratas
> > > @@ -31,4 +31,23 @@ config ERRATA_SIFIVE_CIP_1200
> > >
> > >           If you don't know what to do here, say "Y".
> > >
> > > +config ERRATA_THEAD
> > > +       bool "T-HEAD errata"
> > > +       help
> > > +         All T-HEAD errata Kconfig depend on this Kconfig. Disabling
> > > +         this Kconfig will disable all T-HEAD errata. Please say "Y"
> > > +         here if your platform uses T-HEAD CPU cores.
> > > +
> > > +         If you don't know what to do here, say "Y".
> > > +
> > > +config ERRATA_THEAD_PBMT
> > > +       bool "Apply T-Head memory type errata"
> > > +       depends on ERRATA_THEAD && 64BIT
> > > +       default y
> > > +       help
> > > +         This will apply the memory type errata to handle the non-st=
andard
> > > +         memory type bits in page-table-entries on T-Head SoCs.
> > > +
> > > +         If you don't know what to do here, say "Y".
> > > +
> > >  endmenu
> > > diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> > > index 0ca1c5281a2d..a1055965fbee 100644
> > > --- a/arch/riscv/errata/Makefile
> > > +++ b/arch/riscv/errata/Makefile
> > > @@ -1 +1,2 @@
> > >  obj-$(CONFIG_ERRATA_SIFIVE) +=3D sifive/
> > > +obj-$(CONFIG_ERRATA_THEAD) +=3D thead/
> > > diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/si=
five/errata.c
> > > index 4fe03ac41fd7..f933d6cdf304 100644
> > > --- a/arch/riscv/errata/sifive/errata.c
> > > +++ b/arch/riscv/errata/sifive/errata.c
> > > @@ -84,10 +84,15 @@ void __init sifive_errata_patch_func(struct alt_e=
ntry *begin, struct alt_entry *
> > >                                      unsigned int stage)
> > >  {
> > >         struct alt_entry *alt;
> > > -       u32 cpu_req_errata =3D sifive_errata_probe(archid, impid);
> > > +       u32 cpu_req_errata;
> > >         u32 cpu_apply_errata =3D 0;
> > >         u32 tmp;
> > >
> > > +       if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> > > +               return;
> > > +
> > > +       cpu_req_errata =3D sifive_errata_probe(archid, impid);
> > > +
> > >         for (alt =3D begin; alt < end; alt++) {
> > >                 if (alt->vendor_id !=3D SIFIVE_VENDOR_ID)
> > >                         continue;
> > > diff --git a/arch/riscv/errata/thead/Makefile b/arch/riscv/errata/the=
ad/Makefile
> > > new file mode 100644
> > > index 000000000000..2d644e19caef
> > > --- /dev/null
> > > +++ b/arch/riscv/errata/thead/Makefile
> > > @@ -0,0 +1 @@
> > > +obj-y +=3D errata.o
> > > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/the=
ad/errata.c
> > > new file mode 100644
> > > index 000000000000..fd8e0538a3f0
> > > --- /dev/null
> > > +++ b/arch/riscv/errata/thead/errata.c
> > > @@ -0,0 +1,85 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2021 Heiko Stuebner <heiko@sntech.de>
> > > + */
> > > +
> > > +#include <linux/bug.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/string.h>
> > > +#include <linux/uaccess.h>
> > > +#include <asm/alternative.h>
> > > +#include <asm/cacheflush.h>
> > > +#include <asm/errata_list.h>
> > > +#include <asm/patch.h>
> > > +#include <asm/vendorid_list.h>
> > > +
> > > +struct errata_info {
> > > +       char name[ERRATA_STRING_LENGTH_MAX];
> > > +       bool (*check_func)(unsigned long arch_id, unsigned long impid=
);
> > > +       unsigned int stage;
> > > +};
> > > +
> > > +static bool errata_mt_check_func(unsigned long  arch_id, unsigned lo=
ng impid)
> > > +{
> > > +       if (arch_id !=3D 0 || impid !=3D 0)
> > > +               return false;
> > > +       return true;
> > > +}
> > > +
> > > +static const struct errata_info errata_list[ERRATA_THEAD_NUMBER] =3D=
 {
> > > +       {
> > > +               .name =3D "memory-types",
> > > +               .stage =3D RISCV_ALTERNATIVES_EARLY_BOOT,
> > > +               .check_func =3D errata_mt_check_func
> > > +       },
> > > +};
> > > +
> > > +static u32 thead_errata_probe(unsigned int stage, unsigned long arch=
id, unsigned long impid)
> > > +{
> > > +       const struct errata_info *info;
> > > +       u32 cpu_req_errata =3D 0;
> > > +       int idx;
> > > +
> > > +       for (idx =3D 0; idx < ERRATA_THEAD_NUMBER; idx++) {
> > > +               info =3D &errata_list[idx];
> > > +
> > > +               if ((stage =3D=3D RISCV_ALTERNATIVES_MODULE ||
> > > +                    info->stage =3D=3D stage) && info->check_func(ar=
chid, impid))
> > > +                       cpu_req_errata |=3D (1U << idx);
> > > +       }
> > > +
> > > +       return cpu_req_errata;
> > > +}
> > > +
> > > +void __init_or_module thead_errata_patch_func(struct alt_entry *begi=
n, struct alt_entry *end,
> > > +                                             unsigned long archid, u=
nsigned long impid,
> > > +                                             unsigned int stage)
> > > +{
> > > +       struct alt_entry *alt;
> > > +       u32 cpu_req_errata =3D thead_errata_probe(stage, archid, impi=
d);
> > > +       u32 cpu_apply_errata =3D 0;
> > > +       u32 tmp;
> > > +
> > > +       for (alt =3D begin; alt < end; alt++) {
> > > +               if (alt->vendor_id !=3D THEAD_VENDOR_ID)
> > > +                       continue;
> > > +               if (alt->errata_id >=3D ERRATA_THEAD_NUMBER)
> > > +                       continue;
> > > +
> > > +               tmp =3D (1U << alt->errata_id);
> > > +               if (cpu_req_errata & tmp) {
> > > +                       /* On vm-alternatives, the mmu isn't running =
yet */
> > > +                       if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOO=
T)
> > > +                               memcpy((void *)__pa_symbol(alt->old_p=
tr),
> > > +                                      (void *)__pa_symbol(alt->alt_p=
tr), alt->alt_len);
> > > +                       else
> > > +                               patch_text_nosync(alt->old_ptr, alt->=
alt_ptr, alt->alt_len);
> > > +
> > > +                       cpu_apply_errata |=3D tmp;
> > > +               }
> > > +       }
> > > +
> > > +       if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> > > +               local_flush_icache_all();
> > > +}
> > > diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/includ=
e/asm/alternative.h
> > > index cf3b22173834..d1154c91ab03 100644
> > > --- a/arch/riscv/include/asm/alternative.h
> > > +++ b/arch/riscv/include/asm/alternative.h
> > > @@ -19,8 +19,10 @@
> > >
> > >  #define RISCV_ALTERNATIVES_BOOT                0 /* alternatives app=
lied during regular boot */
> > >  #define RISCV_ALTERNATIVES_MODULE      1 /* alternatives applied dur=
ing module-init */
> > > +#define RISCV_ALTERNATIVES_EARLY_BOOT  2 /* alternatives applied bef=
ore mmu start */
> > >
> >
> > But this stage invoked is used after RISCV_ALTERNATIVES_BOOT
>
> No it isn't.
>
> the "boot" alternative is applied right now directly before soc_early_ini=
t,
> while the "early-boot" alternative is already applied during setup_vm()

Yeah you are right. I got confused with the name and numbering.

> even before page-tables are set up.
>
> Right now the numbering doesn't reflect the order and just
> makes it distinct, but I guess we can adjust it to make that clear
> (move early_boot to the top)
>
>
> > >  void __init apply_boot_alternatives(void);
> > > +void __init apply_early_boot_alternatives(void);
> > >  void apply_module_alternatives(void *start, size_t length);
> > >
> > >  struct alt_entry {
> > > @@ -39,6 +41,9 @@ struct errata_checkfunc_id {
> > >  void sifive_errata_patch_func(struct alt_entry *begin, struct alt_en=
try *end,
> > >                               unsigned long archid, unsigned long imp=
id,
> > >                               unsigned int stage);
> > > +void thead_errata_patch_func(struct alt_entry *begin, struct alt_ent=
ry *end,
> > > +                            unsigned long archid, unsigned long impi=
d,
> > > +                            unsigned int stage);
> > >
> > >  void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt=
_entry *end,
> > >                                  unsigned int stage);
> > > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/includ=
e/asm/errata_list.h
> > > index a4a9b0842922..4fac46b82c16 100644
> > > --- a/arch/riscv/include/asm/errata_list.h
> > > +++ b/arch/riscv/include/asm/errata_list.h
> > > @@ -14,6 +14,11 @@
> > >  #define        ERRATA_SIFIVE_NUMBER 2
> > >  #endif
> > >
> > > +#ifdef CONFIG_ERRATA_THEAD
> > > +#define        ERRATA_THEAD_PBMT 0
> > > +#define        ERRATA_THEAD_NUMBER 1
> > > +#endif
> > > +
> > >  #define        CPUFEATURE_SVPBMT 0
> > >  #define        CPUFEATURE_NUMBER 1
> > >
> > > @@ -42,10 +47,44 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SI=
FIVE_VENDOR_ID,    \
> > >   * in the default case.
> > >   */
> > >  #define ALT_SVPBMT_SHIFT 61
> > > -#define ALT_SVPBMT(_val, prot)                                      =
   \
> > > -asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0, =
   \
> > > -               CPUFEATURE_SVPBMT, CONFIG_64BIT)                     =
   \
> > > -               : "=3Dr"(_val) : "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIF=
T), "I"(ALT_SVPBMT_SHIFT))
> > > +#define ALT_THEAD_PBMT_SHIFT 59
> > > +#define ALT_SVPBMT(_val, prot)                                      =
                   \
> > > +asm(ALTERNATIVE_2("li %0, 0\t\nnop",                                =
                   \
> > > +                 "li %0, %1\t\nslli %0,%0,%3", 0, CPUFEATURE_SVPBMT,=
 CONFIG_64BIT,     \
> > > +                 "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID, ERRA=
TA_THEAD_PBMT,     \
> > > +                                               CONFIG_ERRATA_THEAD_P=
BMT)               \
> > > +               : "=3Dr"(_val) : "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIF=
T),                  \
> > > +                              "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHI=
FT),               \
> > > +                              "I"(ALT_SVPBMT_SHIFT), "I"(ALT_THEAD_P=
BMT_SHIFT))
> > > +
> > > +#ifdef CONFIG_ERRATA_THEAD_PBMT
> > > +/*
> > > + * IO/NOCACHE memory types are handled together with svpbmt,
> > > + * so on T-Head chips, check if no other memory type is set,
> > > + * and set the non-0 PMA type if applicable.
> > > + */
> > > +#define ALT_THEAD_PMA(_val)                                         =
                   \
> > > +asm volatile(ALTERNATIVE(                                           =
                   \
> > > +       "nop\n\t"                                                    =
                   \
> > > +       "nop\n\t"                                                    =
                   \
> > > +       "nop\n\t"                                                    =
                   \
> > > +       "nop\n\t"                                                    =
                   \
> > > +       "nop\n\t"                                                    =
                   \
> > > +       "nop\n\t"                                                    =
                   \
> > > +       "nop",                                                       =
                   \
> > > +       "li      t3, %2\n\t"                                         =
                   \
> > > +       "slli    t3, t3, %4\n\t"                                     =
                   \
> > > +       "and     t3, %0, t3\n\t"                                     =
                   \
> > > +       "bne     t3, zero, 2f\n\t"                                   =
                   \
> > > +       "li      t3, %3\n\t"                                         =
                   \
> > > +       "slli    t3, t3, %4\n\t"                                     =
                   \
> > > +       "or      %0, %0, t3\n\t"                                     =
                   \
> > > +       "2:",  THEAD_VENDOR_ID, ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEA=
D_PBMT)            \
> > > +       : "+r"(_val) : "0"(_val), "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD=
_PBMT_SHIFT),      \
> > > +                      "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT), =
 "I"(ALT_THEAD_PBMT_SHIFT))
> > > +#else
> > > +#define ALT_THEAD_PMA(_val)
> > > +#endif
> > >
> > >  #endif /* __ASSEMBLY__ */
> > >
> > > diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include=
/asm/pgtable-64.h
> > > index 07ba3416cb19..6d59e4695200 100644
> > > --- a/arch/riscv/include/asm/pgtable-64.h
> > > +++ b/arch/riscv/include/asm/pgtable-64.h
> > > @@ -69,6 +69,18 @@ typedef struct {
> > >  #define _PAGE_IO_SVPBMT                (1UL << 62)
> > >  #define _PAGE_MTMASK_SVPBMT    (_PAGE_NOCACHE_SVPBMT | _PAGE_IO_SVPB=
MT)
> > >
> > > +/*
> > > + * [63:59] T-Head Memory Type definitions:
> > > + *
> > > + * 00000 - NC   Weakly-ordered, Non-cacheable, Non-bufferable, Non-s=
hareable, Non-trustable
> > > + * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, No=
n-trustable
> > > + * 10000 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Non=
-shareable, Non-trustable
> > > + */
> > > +#define _PAGE_PMA_THEAD                ((1UL << 62) | (1UL << 61) | =
(1UL << 60))
> > > +#define _PAGE_NOCACHE_THEAD    0UL
> > > +#define _PAGE_IO_THEAD         (1UL << 63)
> > > +#define _PAGE_MTMASK_THEAD     (_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (=
1UL << 59))
> > > +
> > >  static inline u64 riscv_page_mtmask(void)
> > >  {
> > >         u64 val;
> > > @@ -167,7 +179,11 @@ static inline bool mm_pud_folded(struct mm_struc=
t *mm)
> > >
> > >  static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
> > >  {
> > > -       return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
> > > +       unsigned long prot_val =3D pgprot_val(prot);
> > > +
> > > +       ALT_THEAD_PMA(prot_val);
> > > +
> > > +       return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
> > >  }
> > >
> > >  static inline unsigned long _pmd_pfn(pmd_t pmd)
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/as=
m/pgtable.h
> > > index b8abc75dfe01..3d0c4c144093 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -245,7 +245,11 @@ static inline void pmd_clear(pmd_t *pmdp)
> > >
> > >  static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
> > >  {
> > > -       return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
> > > +       unsigned long prot_val =3D pgprot_val(prot);
> > > +
> > > +       ALT_THEAD_PMA(prot_val);
> > > +
> > > +       return __pgd((pfn << _PAGE_PFN_SHIFT) | prot_val);
> > >  }
> > >
> > >  static inline unsigned long _pgd_pfn(pgd_t pgd)
> > > @@ -284,7 +288,11 @@ static inline unsigned long pte_pfn(pte_t pte)
> > >  /* Constructs a page table entry */
> > >  static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
> > >  {
> > > -       return __pte((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
> > > +       unsigned long prot_val =3D pgprot_val(prot);
> > > +
> > > +       ALT_THEAD_PMA(prot_val);
> > > +
> > > +       return __pte((pfn << _PAGE_PFN_SHIFT) | prot_val);
> > >  }
> > >
> > >  #define mk_pte(page, prot)       pfn_pte(page_to_pfn(page), prot)
> > > @@ -393,7 +401,11 @@ static inline int pmd_protnone(pmd_t pmd)
> > >  /* Modify page protection bits */
> > >  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> > >  {
> > > -       return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(new=
prot));
> > > +       unsigned long newprot_val =3D pgprot_val(newprot);
> > > +
> > > +       ALT_THEAD_PMA(newprot_val);
> > > +
> > > +       return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
> > >  }
> > >
> > >  #define pgd_ERROR(e) \
> > > diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/incl=
ude/asm/vendorid_list.h
> > > index 9d934215b3c8..cb89af3f0704 100644
> > > --- a/arch/riscv/include/asm/vendorid_list.h
> > > +++ b/arch/riscv/include/asm/vendorid_list.h
> > > @@ -6,5 +6,6 @@
> > >  #define ASM_VENDOR_LIST_H
> > >
> > >  #define SIFIVE_VENDOR_ID       0x489
> > > +#define THEAD_VENDOR_ID                0x5b7
> > >
> > >  #endif
> > > diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alte=
rnative.c
> > > index e6c9de9f9ba6..3f6ad91f524c 100644
> > > --- a/arch/riscv/kernel/alternative.c
> > > +++ b/arch/riscv/kernel/alternative.c
> > > @@ -48,6 +48,11 @@ static void __init init_alternative(void)
> > >         case SIFIVE_VENDOR_ID:
> > >                 vendor_patch_func =3D sifive_errata_patch_func;
> > >                 break;
> > > +#endif
> > > +#ifdef CONFIG_ERRATA_THEAD
> > > +       case THEAD_VENDOR_ID:
> > > +               vendor_patch_func =3D thead_errata_patch_func;
> > > +               break;
> > >  #endif
> > >         default:
> > >                 vendor_patch_func =3D NULL;
> > > @@ -85,6 +90,15 @@ void __init apply_boot_alternatives(void)
> > >                             RISCV_ALTERNATIVES_BOOT);
> > >  }
> > >
> > > +void __init apply_early_boot_alternatives(void)
> > > +{
> > > +       init_alternative();
> > > +
> > > +       _apply_alternatives((struct alt_entry *)__alt_start,
> > > +                           (struct alt_entry *)__alt_end,
> > > +                           RISCV_ALTERNATIVES_EARLY_BOOT);
> > > +}
> > > +
> >
> > The name is a bit confusing as there is another "apply_boot_alternative=
s"
> > which was called earlier than "apply_early_boot_alternatives".
>
> I'm not that much attached to early-boot, so if you have other naming-
> suggestions we can of course change that.
>

Just a suggestion:
how about BEFORE_MMU and AFTER_MMU to indicate the purpose more clearly.
But I am okay with the current naming scheme as well.

> As explained above, the early-boot stage runs before page-table setup,
> so that things like the D1 can hook into it with their setting for the ba=
se
> page-type.
>
>
> Heiko
>
>
>
> > >  #ifdef CONFIG_MODULES
> > >  void apply_module_alternatives(void *start, size_t length)
> > >  {
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufe=
ature.c
> > > index 7bce66ee7ce7..ecc248e5dab7 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -224,6 +224,8 @@ static bool cpufeature_svpbmt_check_func(unsigned=
 int stage)
> > >
> > >  #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> > >         switch (stage) {
> > > +       case RISCV_ALTERNATIVES_EARLY_BOOT:
> > > +               return false;
> > >         case RISCV_ALTERNATIVES_BOOT:
> > >                 return cpufeature_svpbmt_check_fdt();
> > >         default:
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index cf4d018b7d66..7216db5d6a2c 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -819,6 +819,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> > >         BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPA=
CE_END - SZ_4K);
> > >  #endif
> > >
> > > +       apply_early_boot_alternatives();
> > >         pt_ops_set_early();
> > >
> > >         /* Setup early PGD for fixmap */
> > > --
> > > 2.30.2
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
> >
>
>
>
>


--
Regards,
Atish
