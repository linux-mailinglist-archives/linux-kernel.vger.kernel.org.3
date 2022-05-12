Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60AC5245C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350342AbiELG3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348909AbiELG3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:29:46 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF0C224A53
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:29:44 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i38so7906660ybj.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UsIye2bBDqtRb22afIRHd19srECco2EdRoKMOSfw2lU=;
        b=KUQ7PIrtndqPX6EtV4ihSBKIQpsEOAq54FyEXO18f4WedN7hQ5oHkRpaJOuZS2HXRv
         o5FmweKT15QdRH3aDDAwDiMpRJum5szKSBzPDCYwpn83sERgpG8qwNRiWfssNKpoQ8xs
         fTBzQZq++QlVHzv1lpjxbgzMD+QBM/zgEY1BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsIye2bBDqtRb22afIRHd19srECco2EdRoKMOSfw2lU=;
        b=cWGjGNbsJVrd34Bj9zBaibXvZolTqklJtLb5cI+F5Fb9dzUOlKrCPVs5aAouTU9ftG
         vzEM4U9kmI8gCp2dwGeYZFZxNnB0xaD2NCLPG/M+CrE97MCEdzv31lQrNCFJOzZ/7zDq
         6Qe9RCelNC71tWX2ASbDQ7WujKSzKuVz7lO9Ra47sJvW+FgDkL6Hq9hO4KHs+eCGavZC
         /xvKEf1LUTIefd8aLP1+CV4thM4UyXHtTtSU10SE7IgEqeUjqWtvY++VfOZtoODFd7wR
         rpceGI27FnIFtC/CvapAzrvgex8FM1ofyfGY5AFNLGQWU1sVZi9wajK0IHcuvFHfulqZ
         /rcw==
X-Gm-Message-State: AOAM531QfiRsgYmGJ4NAwy8oIw3EGCJumlMrAqDweN5nE7eb7xPrhyAp
        +KDnDCJ/0KtALUZc4Z24XBkZvEyV0NqEMsvmeWGA
X-Google-Smtp-Source: ABdhPJwcowWxIjzNrPiy/H4BjbcvWoEyivJWGMcbtkwzii68VVQLi1riHVtgSsIsblumZesSMxaYc5lAGM6shvA4DuI=
X-Received: by 2002:a25:b20e:0:b0:64b:4c0f:be27 with SMTP id
 i14-20020a25b20e000000b0064b4c0fbe27mr3490771ybj.53.1652336983775; Wed, 11
 May 2022 23:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220508160749.984-1-jszhang@kernel.org> <20220508160749.984-3-jszhang@kernel.org>
 <CAK9=C2Xinc6Y9ue+3ZOvKOOgru7wvJNcEPLvO4aZGuQqETXi2w@mail.gmail.com> <YnkoKxaPbrTnZPQv@xhacker>
In-Reply-To: <YnkoKxaPbrTnZPQv@xhacker>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 11 May 2022 23:29:32 -0700
Message-ID: <CAOnJCU+XR5mtqKBQLMj3JgsTPgvAQdO_jj2FWqcu7f9MezNCKA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] riscv: introduce unified static key mechanism for
 CPU features
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
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

On Mon, May 9, 2022 at 7:50 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Mon, May 09, 2022 at 09:17:10AM +0530, Anup Patel wrote:
> > On Sun, May 8, 2022 at 9:47 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > >
> > > Currently, riscv has several features why may not be supported on all
> > > riscv platforms, for example, FPU, SV48 and so on. To support unified
> > > kernel Image style, we need to check whether the feature is suportted
> > > or not. If the check sits at hot code path, then performance will be
> > > impacted a lot. static key can be used to solve the issue. In the past
> > > FPU support has been converted to use static key mechanism. I believe
> > > we will have similar cases in the future.
> >
> > It's not just FPU and Sv48. There are several others such as Svinval,
> > Vector, Svnapot, Svpbmt, and many many others.
> >
> > Overall, I agree with the approach of using static key array but I
> > disagree with the semantics and the duplicate stuff being added.
> >
> > Please see more comments below ..
> >
> > >
> > > Similar as arm64 does(in fact, some code is borrowed from arm64), this
> > > patch tries to add an unified mechanism to use static keys for all
> > > the cpu features by implementing an array of default-false static keys
> > > and enabling them when detected. The cpus_have_*_cap() check uses the
> > > static keys if riscv_const_caps_ready is finalized, otherwise the
> > > compiler generates the bitmap test.
> >
> > First of all, we should stop calling this a feature (like ARM does). Rather,
> > we should call these as isa extensions ("isaext") to align with the RISC-V
> > priv spec and RISC-V profiles spec. For all the ISA optionalities which do
> > not have distinct extension name, the RISC-V profiles spec is assigning
> > names to all such optionalities.
>
> Same as the reply a few minutes ago, the key problem here is do all
> CPU features belong to *ISA* extensions? For example, SV48, SV57 etc.
> I agree with Atish's comments here:
>
> "I think the cpu feature is a superset of the ISA extension.
> cpu feature != ISA extension"
>

It seems to be accurate at that point in time. However, the latest
profile spec seems to
define everything as an extension including sv48.

https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#623-rva22s64-supported-optional-extensions

It may be a redundant effort and confusing to create two sets i.e.
feature and extension in this case.
But this specification is not frozen yet and may change in the future.
We at least know that that is the current intention.

Array of static keys is definitely useful and should be used for all
well defined ISA extensions by the ratified priv spec.
This will simplify this patch as well. For any feature/extensions
(i.e. sv48/sv57) which was never defined as an extension
in the priv spec but profile seems to define it now, I would leave it
alone for the time being. Converting the existing code
to static key probably has value but please do not include it in the
static key array setup.

Once the profile spec is frozen, we can decide which direction the
Linux kernel should go.

> https://lore.kernel.org/linux-riscv/CAHBxVyF65jC_wvxcD6bueqpCY8-Kbahu1yxsSoBmO1s15dGkSQ@mail.gmail.com/
>
> >
> > Another issue with semantics is that this patch assumes all features are
> > enabled by default and we selectively disable it. This contrary to the
> > approach taken by existing arch/riscv/kernel/cpufeature.c which assumes
> > nothing is enabled by default and we selectively enable it.
>
> This is implementation related, can be modified in next version. From
> another side, assuming some feature enabled by default can result in
> trivial performance improvement for most platforms. For example, if
> most platforms are FPU capable, we'd better assume FPU enabled by default.
>
> >
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/Makefile                 |  3 +
> > >  arch/riscv/include/asm/cpufeature.h | 94 +++++++++++++++++++++++++++++
> > >  arch/riscv/kernel/cpufeature.c      | 23 +++++++
> > >  arch/riscv/tools/Makefile           | 22 +++++++
> > >  arch/riscv/tools/cpucaps            |  5 ++
> > >  arch/riscv/tools/gen-cpucaps.awk    | 40 ++++++++++++
> > >  6 files changed, 187 insertions(+)
> > >  create mode 100644 arch/riscv/include/asm/cpufeature.h
> > >  create mode 100644 arch/riscv/tools/Makefile
> > >  create mode 100644 arch/riscv/tools/cpucaps
> > >  create mode 100755 arch/riscv/tools/gen-cpucaps.awk
> > >
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index 7d81102cffd4..f4df67369d84 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -154,3 +154,6 @@ PHONY += rv64_randconfig
> > >  rv64_randconfig:
> > >         $(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/64-bit.config \
> > >                 -f $(srctree)/Makefile randconfig
> > > +
> > > +archprepare:
> > > +       $(Q)$(MAKE) $(build)=arch/riscv/tools kapi
> > > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > > new file mode 100644
> > > index 000000000000..d80ddd2f3b49
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/cpufeature.h
> >
> > We don't need a separate header for this.
> >
> > All this belongs to arch/riscv/include/asm/hwcap.h
> >
> > > @@ -0,0 +1,94 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
> > > + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> > > + */
> > > +
> > > +#ifndef __ASM_CPUFEATURE_H
> > > +#define __ASM_CPUFEATURE_H
> > > +
> > > +#include <asm/cpucaps.h>
> > > +
> > > +#include <linux/bug.h>
> > > +#include <linux/jump_label.h>
> > > +#include <linux/kernel.h>
> > > +
> > > +extern DECLARE_BITMAP(cpu_hwcaps, RISCV_NCAPS);
> >
> > This is a redundant bitmap. Please re-use "riscv_isa" bitmap for this
> > the ISA extensions.
> >
> > > +extern struct static_key_false cpu_hwcap_keys[RISCV_NCAPS];
> >
> > This should be called "riscv_isa_keys"
> >
> > > +extern struct static_key_false riscv_const_caps_ready;
> >
> > This should be called "riscv_isa_keys_ready".
> >
> > > +
> > > +static __always_inline bool system_capabilities_finalized(void)
> >
> > Another misaligned name. This should be called
> > "riscv_isa_keys_finalized()".
> >
> > > +{
> > > +       return static_branch_likely(&riscv_const_caps_ready);
> > > +}
> > > +
> > > +/*
> > > + * Test for a capability with a runtime check.
> > > + *
> > > + * Before the capability is detected, this returns false.
> > > + */
> > > +static inline bool cpus_have_cap(unsigned int num)
> > > +{
> > > +       if (num >= RISCV_NCAPS)
> > > +               return false;
> > > +       return test_bit(num, cpu_hwcaps);
> > > +}
> >
> > This should be called riscv_isa_have_extension() and it should
> > internally call "__riscv_isa_extension_available(NULL, num)".
> >
> > > +
> > > +/*
> > > + * Test for a capability without a runtime check.
> > > + *
> > > + * Before capabilities are finalized, this returns false.
> > > + * After capabilities are finalized, this is patched to avoid a runtime check.
> > > + *
> > > + * @num must be a compile-time constant.
> > > + */
> > > +static __always_inline bool __cpus_have_const_cap(int num)
> >
> > This should be named "__riscv_isa_have_const_extension()"
> >
> > > +{
> > > +       if (num >= RISCV_NCAPS)
> > > +               return false;
> > > +       return static_branch_unlikely(&cpu_hwcap_keys[num]);
> > > +}
> > > +
> > > +/*
> > > + * Test for a capability without a runtime check.
> > > + *
> > > + * Before capabilities are finalized, this will BUG().
> > > + * After capabilities are finalized, this is patched to avoid a runtime check.
> > > + *
> > > + * @num must be a compile-time constant.
> > > + */
> > > +static __always_inline bool cpus_have_final_cap(int num)
> >
> > This should be called "riscv_isa_have_final_extension()"
> >
> > > +{
> > > +       if (system_capabilities_finalized())
> > > +               return __cpus_have_const_cap(num);
> > > +       else
> > > +               BUG();
> > > +}
> > > +
> > > +/*
> > > + * Test for a capability, possibly with a runtime check.
> > > + *
> > > + * Before capabilities are finalized, this behaves as cpus_have_cap().
> > > + * After capabilities are finalized, this is patched to avoid a runtime check.
> > > + *
> > > + * @num must be a compile-time constant.
> > > + */
> > > +static __always_inline bool cpus_have_const_cap(int num)
> >
> > Same comment as above.
> >
> > > +{
> > > +       if (system_capabilities_finalized())
> > > +               return __cpus_have_const_cap(num);
> > > +       else
> > > +               return cpus_have_cap(num);
> > > +}
> > > +
> > > +static inline void cpus_set_cap(unsigned int num)
> >
> > Same comment as above.
> >
> > > +{
> > > +       if (num >= RISCV_NCAPS) {
> > > +               pr_warn("Attempt to set an illegal CPU capability (%d >= %d)\n",
> > > +                       num, RISCV_NCAPS);
> > > +       } else {
> > > +               __set_bit(num, cpu_hwcaps);
> > > +       }
> > > +}
> > > +
> > > +#endif
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > index 1b2d42d7f589..e6c72cad0c1c 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/bitmap.h>
> > >  #include <linux/ctype.h>
> > >  #include <linux/of.h>
> > > +#include <asm/cpufeature.h>
> > >  #include <asm/processor.h>
> > >  #include <asm/hwcap.h>
> > >  #include <asm/smp.h>
> > > @@ -25,6 +26,15 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> > >  __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
> > >  #endif
> > >
> > > +DECLARE_BITMAP(cpu_hwcaps, RISCV_NCAPS);
> > > +EXPORT_SYMBOL(cpu_hwcaps);
> >
> > Just like the previous comment. This is a redundant bitmap.
> > Please use "riscv_isa" bitmap for this purpose.
> >
> > > +
> > > +DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, RISCV_NCAPS);
> > > +EXPORT_SYMBOL(cpu_hwcap_keys);
> > > +
> > > +DEFINE_STATIC_KEY_FALSE(riscv_const_caps_ready);
> > > +EXPORT_SYMBOL(riscv_const_caps_ready);
> >
> > Please see comments above.
> >
> > > +
> > >  /**
> > >   * riscv_isa_extension_base() - Get base extension word
> > >   *
> > > @@ -62,6 +72,17 @@ bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, int bit)
> > >  }
> > >  EXPORT_SYMBOL_GPL(__riscv_isa_extension_available);
> > >
> > > +static void __init enable_cpu_capabilities(void)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i = 0; i < RISCV_NCAPS; i++) {
> > > +               if (!cpus_have_cap(i))
> > > +                       continue;
> > > +               static_branch_enable(&cpu_hwcap_keys[i]);
> > > +       }
> > > +}
> > > +
> > >  void __init riscv_fill_hwcap(void)
> > >  {
> > >         struct device_node *node;
> > > @@ -236,4 +257,6 @@ void __init riscv_fill_hwcap(void)
> > >         if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
> > >                 static_branch_enable(&cpu_hwcap_fpu);
> > >  #endif
> > > +       enable_cpu_capabilities();
> > > +       static_branch_enable(&riscv_const_caps_ready);
> > >  }
> > > diff --git a/arch/riscv/tools/Makefile b/arch/riscv/tools/Makefile
> > > new file mode 100644
> > > index 000000000000..932b4fe5c768
> > > --- /dev/null
> > > +++ b/arch/riscv/tools/Makefile
> > > @@ -0,0 +1,22 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +gen := arch/$(ARCH)/include/generated
> > > +kapi := $(gen)/asm
> > > +
> > > +kapi-hdrs-y := $(kapi)/cpucaps.h
> > > +
> > > +targets += $(addprefix ../../../,$(gen-y) $(kapi-hdrs-y))
> > > +
> > > +PHONY += kapi
> > > +
> > > +kapi:   $(kapi-hdrs-y) $(gen-y)
> > > +
> > > +# Create output directory if not already present
> > > +_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
> > > +
> > > +quiet_cmd_gen_cpucaps = GEN     $@
> > > +      cmd_gen_cpucaps = mkdir -p $(dir $@) && \
> > > +                     $(AWK) -f $(filter-out $(PHONY),$^) > $@
> > > +
> > > +$(kapi)/cpucaps.h: $(src)/gen-cpucaps.awk $(src)/cpucaps FORCE
> > > +       $(call if_changed,gen_cpucaps)
> > > diff --git a/arch/riscv/tools/cpucaps b/arch/riscv/tools/cpucaps
> > > new file mode 100644
> > > index 000000000000..cb1ff2747859
> > > --- /dev/null
> > > +++ b/arch/riscv/tools/cpucaps
> > > @@ -0,0 +1,5 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Internal CPU capabilities constants, keep this list sorted
> > > +
> > > +HAS_NO_FPU
> >
> > How can "No FPU" be a CPU capability ?
> >
> > We have ISA extensions 'F' and 'D' which tells us whether an FPU is available
> > or not.
> >
> > I think this file should be a table with two columns
> > "<lower_case_extension_name> <parsed_from_isa_string_yes_no>"
> > I this this file should look like this:
> >
> > i yes
> > m yes
> > a yes
> > c yes
> > f yes
> > d yes
> > h yes
> > sv48 no
> > sv57 no
> > sstc yes
> > svinval yes
> > svpbmt yes
> > svnapot yes
> > sscofpmf yes
> > ...
> >
> > > diff --git a/arch/riscv/tools/gen-cpucaps.awk b/arch/riscv/tools/gen-cpucaps.awk
> > > new file mode 100755
> > > index 000000000000..52a1e1b064ad
> > > --- /dev/null
> > > +++ b/arch/riscv/tools/gen-cpucaps.awk
> > > @@ -0,0 +1,40 @@
> > > +#!/bin/awk -f
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# gen-cpucaps.awk: riscv cpucaps header generator
> > > +#
> > > +# Usage: awk -f gen-cpucaps.awk cpucaps.txt
> > > +
> > > +# Log an error and terminate
> > > +function fatal(msg) {
> > > +       print "Error at line " NR ": " msg > "/dev/stderr"
> > > +       exit 1
> > > +}
> > > +
> > > +# skip blank lines and comment lines
> > > +/^$/ { next }
> > > +/^#/ { next }
> > > +
> > > +BEGIN {
> > > +       print "#ifndef __ASM_CPUCAPS_H"
> > > +       print "#define __ASM_CPUCAPS_H"
> > > +       print ""
> > > +       print "/* Generated file - do not edit */"
> > > +       cap_num = 0
> > > +       print ""
> > > +}
> > > +
> > > +/^[vA-Z0-9_]+$/ {
> > > +       printf("#define RISCV_%-30s\t%d\n", $0, cap_num++)
> > > +       next
> > > +}
> > > +
> > > +END {
> > > +       printf("#define RISCV_NCAPS\t\t\t\t%d\n", cap_num)
> > > +       print ""
> > > +       print "#endif /* __ASM_CPUCAPS_H */"
> > > +}
> >
> > This script need to change refer capabilities as extensions.
> >
> > For every extension, there should be two defines.
> > For e.g. "sstc" extension should have following defines
> > #define RISCV_ISA_EXT_sstc <#num>
> > #define RISCV_ISA_EXT_FROMSTR_sstc <1|0>
> >
> > > +
> > > +# Any lines not handled by previous rules are unexpected
> > > +{
> > > +       fatal("unhandled statement")
> > > +}
> > > --
> > > 2.34.1
> > >
> >
> > Regards,
> > Anup
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
