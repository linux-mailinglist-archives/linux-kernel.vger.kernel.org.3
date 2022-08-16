Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B02596001
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiHPQTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbiHPQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:19:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE07D4DF22
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:18:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gk3so19851175ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=iJ/7niCppHSg4c2xRIFrYJlepL2BitnkJuwZF5uynfA=;
        b=buNPgX8gTxP2FDCSa+pcBQ4bIRAKTsb+yEdF0PLKD9u+iS4MWh4mwWTvidYITNV3Or
         pXFuowSxGbudOS82DanCQNxsJ/m6SAc69Gb3BthhwGH7/fBsOh9w140RrES0uxoMnWmI
         7HAV4tYOUgxpSyzqr3OIbljnRyGFfyzSjOCtlfhdrQDf82ghVFlSRQNpGcMLZcAkw/CI
         zfxmodYbP2M5E2GDoYfrukImE4nTHwFyC0Ge8qjUfegLSY2SezQ3Qlr+tjxYD1PVoxeu
         6F9iU6tt0q/x0aOnRmGUm86S9TOQuS3PqS40OM1MBhv327M9R0Lot97+uvVCpkYM8BaK
         hSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=iJ/7niCppHSg4c2xRIFrYJlepL2BitnkJuwZF5uynfA=;
        b=5bm2H/Y/YgZ2WrmCip7wibAO74jR1SSVPqC9Pn8bDTQxlDWeXUUzAGbq2zw7ZdPs2T
         +zPP9mmGrYe798YlbVFznDN/gNMcPWuoyz+JCu6Pa2Z+yP0wOWN963E+WjmHNkmjRZ5p
         YyLKdFJb2a9JoX44F6HZOQTzWdjGD4Ll6EvpUhpKs/IupU+Zotb4fqe1liQ5OukoaNcs
         q2KnDgGKx2ZzZBMw5yjcqXyWzMoUJwXyaiby4rzfy7z69dZWee1sxUY3awGoSz6BJVom
         4A6omsK7zaPIEFwjjt+Gey1dvFKEHVghhFmLB/TcVQyYg7eKMVZ2BgDe24egTwvM/IOr
         ldEw==
X-Gm-Message-State: ACgBeo0OU/FdBTStLkTwqc2cEWniNdkB5p3NV8E2CEpxBfTeIOIBnRXI
        0DMDI78PGgkHBJMQze/LbVodmA==
X-Google-Smtp-Source: AA6agR600R++4mbQeNarzZjjCHlFT8XZ2wMrDV5ScMxgSQSxd3fz/LZGbl21Lhb3PI1TasCFVejofQ==
X-Received: by 2002:a17:907:3f95:b0:733:1e1f:d75c with SMTP id hr21-20020a1709073f9500b007331e1fd75cmr14080427ejc.727.1660666738172;
        Tue, 16 Aug 2022 09:18:58 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7de8a000000b0043af8007e7fsm8717902edv.3.2022.08.16.09.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:18:57 -0700 (PDT)
Date:   Tue, 16 Aug 2022 18:18:56 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor.Dooley@microchip.com
Cc:     palmer@dabbelt.com, daolu@rivosinc.com,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        atishp@atishpatra.org, anup@brainfault.org, guoren@kernel.org,
        jszhang@kernel.org, rdunlap@infradead.org, niklas.cassel@wdc.com,
        panqinglin2020@iscas.ac.cn, alexandre.ghiti@canonical.com,
        robh@kernel.org, research_trasio@irq.a4lg.com,
        yury.norov@gmail.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4] arch/riscv: add Zihintpause support
Message-ID: <20220816161856.jbmobccceki7hfzi@kamzik>
References: <mhng-1b17506c-8dd7-4868-bd58-7df010313902@palmer-ri-x1c9>
 <73c7e97a-ebdc-5509-7e74-4b1dbb62b2bb@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73c7e97a-ebdc-5509-7e74-4b1dbb62b2bb@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:04:06PM +0000, Conor.Dooley@microchip.com wrote:
> On 16/08/2022 16:54, Palmer Dabbelt wrote:
> > On Fri, 12 Aug 2022 00:21:40 PDT (-0700), Conor.Dooley@microchip.com wrote:
> >> On 12/08/2022 07:57, Conor Dooley - M52691 wrote:
> >>> On 11/08/2022 16:17, Palmer Dabbelt wrote:
> >>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>
> >>>> On Mon, 20 Jun 2022 13:15:25 PDT (-0700), daolu@rivosinc.com wrote:
> >>>>> Implement support for the ZiHintPause extension.
> >>>>>
> >>>>> The PAUSE instruction is a HINT that indicates the current hart’s rate
> >>>>> of instruction retirement should be temporarily reduced or paused.
> >>>>>
> >>>>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> >>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
> >>>>> Signed-off-by: Dao Lu <daolu@rivosinc.com>
> >>>>> ---
> >>>>>
> >>>>> v1 -> v2:
> >>>>>  Remove the usage of static branch, use PAUSE if toolchain supports it
> >>>>> v2 -> v3:
> >>>>>  Added the static branch back, cpu_relax() behavior is kept the same for
> >>>>> systems that do not support ZiHintPause
> >>>>> v3 -> v4:
> >>>>>  Adopted the newly added unified static keys for extensions
> >>>>> ---
> >>>>>  arch/riscv/Makefile                     |  4 ++++
> >>>>>  arch/riscv/include/asm/hwcap.h          |  5 +++++
> >>>>>  arch/riscv/include/asm/vdso/processor.h | 21 ++++++++++++++++++---
> >>>>>  arch/riscv/kernel/cpu.c                 |  1 +
> >>>>>  arch/riscv/kernel/cpufeature.c          |  1 +
> >>>>>  5 files changed, 29 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> >>>>> index 34cf8a598617..6ddacc6f44b9 100644
> >>>>> --- a/arch/riscv/Makefile
> >>>>> +++ b/arch/riscv/Makefile
> >>>>> @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)  := $(riscv-march-y)c
> >>>>>  toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
> >>>>>  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
> >>>>>
> >>>>> +# Check if the toolchain supports Zihintpause extension
> >>>>> +toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
> >>>>> +riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
> >>>>> +
> >>>>>  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
> >>>>>  KBUILD_AFLAGS += -march=$(riscv-march-y)
> >>>>>
> >>>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> >>>>> index e48eebdd2631..dc47019a0b38 100644
> >>>>> --- a/arch/riscv/include/asm/hwcap.h
> >>>>> +++ b/arch/riscv/include/asm/hwcap.h
> >>>>> @@ -8,6 +8,7 @@
> >>>>>  #ifndef _ASM_RISCV_HWCAP_H
> >>>>>  #define _ASM_RISCV_HWCAP_H
> >>>>>
> >>>>> +#include <asm/errno.h>
> >>>>>  #include <linux/bits.h>
> >>>>>  #include <uapi/asm/hwcap.h>
> >>>>>
> >>>>> @@ -54,6 +55,7 @@ extern unsigned long elf_hwcap;
> >>>>>  enum riscv_isa_ext_id {
> >>>>>       RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> >>>>>       RISCV_ISA_EXT_SVPBMT,
> >>>>> +     RISCV_ISA_EXT_ZIHINTPAUSE,
> >>>>>       RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> >>>>>  };
> >>>>>
> >>>>> @@ -64,6 +66,7 @@ enum riscv_isa_ext_id {
> >>>>>   */
> >>>>>  enum riscv_isa_ext_key {
> >>>>>       RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
> >>>>> +     RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
> >>>>>       RISCV_ISA_EXT_KEY_MAX,
> >>>>>  };
> >>>>>
> >>>>> @@ -83,6 +86,8 @@ static __always_inline int riscv_isa_ext2key(int num)
> >>>>>               return RISCV_ISA_EXT_KEY_FPU;
> >>>>>       case RISCV_ISA_EXT_d:
> >>>>>               return RISCV_ISA_EXT_KEY_FPU;
> >>>>> +     case RISCV_ISA_EXT_ZIHINTPAUSE:
> >>>>> +             return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
> >>>>>       default:
> >>>>>               return -EINVAL;
> >>>>>       }
> >>>>> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> >>>>> index 134388cbaaa1..1e4f8b4aef79 100644
> >>>>> --- a/arch/riscv/include/asm/vdso/processor.h
> >>>>> +++ b/arch/riscv/include/asm/vdso/processor.h
> >>>>> @@ -4,15 +4,30 @@
> >>>>>
> >>>>>  #ifndef __ASSEMBLY__
> >>>>>
> >>>>> +#include <linux/jump_label.h>
> >>>>>  #include <asm/barrier.h>
> >>>>> +#include <asm/hwcap.h>
> >>>>>
> >>>>>  static inline void cpu_relax(void)
> >>>>>  {
> >>>>> +     if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
> >>>>>  #ifdef __riscv_muldiv
> >>>>> -     int dummy;
> >>>>> -     /* In lieu of a halt instruction, induce a long-latency stall. */
> >>>>> -     __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> >>>>> +             int dummy;
> >>>>> +             /* In lieu of a halt instruction, induce a long-latency stall. */
> >>>>> +             __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> >>>>>  #endif
> >>>>> +     } else {
> >>>>> +             /*
> >>>>> +              * Reduce instruction retirement.
> >>>>> +              * This assumes the PC changes.
> >>>>> +              */
> >>>>> +#ifdef __riscv_zihintpause
> >>>>> +             __asm__ __volatile__ ("pause");
> >>>>> +#else
> >>>>> +             /* Encoding of the pause instruction */
> >>>>> +             __asm__ __volatile__ (".4byte 0x100000F");
> >>>>> +#endif
> >>>>> +     }
> >>>>>       barrier();
> >>>>>  }
> >>>>>
> >>>>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> >>>>> index fba9e9f46a8c..a123e92b14dd 100644
> >>>>> --- a/arch/riscv/kernel/cpu.c
> >>>>> +++ b/arch/riscv/kernel/cpu.c
> >>>>> @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
> >>>>>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> >>>>>       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >>>>>       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> >>>>> +     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >>>>>       __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> >>>>>  };
> >>>>>
> >>>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> >>>>> index 1b3ec44e25f5..708df2c0bc34 100644
> >>>>> --- a/arch/riscv/kernel/cpufeature.c
> >>>>> +++ b/arch/riscv/kernel/cpufeature.c
> >>>>> @@ -198,6 +198,7 @@ void __init riscv_fill_hwcap(void)
> >>>>>                       } else {
> >>>>>                               SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> >>>>>                               SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> >>>>> +                             SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> >>>>>                       }
> >>>>>  #undef SET_ISA_EXT_MAP
> >>>>>               }
> >>>>
> >>>> Thanks, this is on for-next.  It needs a sparse patch, which I put in as a link.
> >>>
> >>> This breaks the C=1 build for all toolchains, not just new ones as your sparse
> >>> patch suggests. I amn't 100% what my CI is running, but I replicated this on
> >>> my own machine with:
> >>
> >> Argh, I went poking around and my toolchain's binutils etc is newer than I thought.
> >> Good for people searching on lore I suppose...
> >> Sorry!
> > 
> > So just to be clear: you're saying this only breaks with new binutils?
> 
> Yes, sorry - I *thought* the binutils in our CI predated Zihintpause but
> it doesn't. It (and so would the Zicbom stuff) breaks the builds in our CI
> as they run with C=1. I manually patched sparse to get that going again & I
> /suspect/ it may have impacted LKP too.
> 
> "New" is relative though - it breaks C=1 for anyone running a toolchain
> from riscv-collab/riscv-gnu-toolchain.
> 
> I guess it's just that Zicbom is newer so not many people will be on a
> toolchain that supports that. My GCC doesn't only my clang-15.
> 
> > I ask because Dao is also seeing some crashes, if it's breaking arbitrary
> > builds too then it's a stronger hint to revert it.
> 
> It is breaking module loading on RISC-V in general from what it seems.
> See:
> https://lore.kernel.org/linux-riscv/728ecbd5-975a-168e-efab-3c0030be21d5@w6rz.net/

Hi Conor,

I have a patch for this which I'll send in just a second.

Thanks,
drew

> 
> Thanks,
> Conor.
> 
> > 
> >> Conor.
> >>
> >>>
> >>> sparse --version
> >>> 0.6.4 (Ubuntu: 0.6.4-2)
> >>>
> >>> ---8<---
> >>>    YACC    scripts/dtc/dtc-parser.tab.[ch]
> >>>    HOSTCC  scripts/dtc/libfdt/fdt.o
> >>>    HOSTCC  scripts/dtc/libfdt/fdt_ro.o
> >>>    HOSTCC  scripts/dtc/libfdt/fdt_wip.o
> >>>    UPD     include/generated/uapi/linux/version.h
> >>>    HOSTCC  scripts/dtc/libfdt/fdt_sw.o
> >>>    UPD     include/config/kernel.release
> >>>    HOSTCC  scripts/dtc/libfdt/fdt_rw.o
> >>>    HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
> >>>    HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
> >>>    HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
> >>>    HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
> >>>    HOSTCC  scripts/dtc/fdtoverlay.o
> >>>    HOSTCC  scripts/dtc/dtc-lexer.lex.o
> >>>    HOSTCC  scripts/dtc/dtc-parser.tab.o
> >>>    UPD     include/generated/utsrelease.h
> >>>    HOSTLD  scripts/dtc/fdtoverlay
> >>>    HOSTLD  scripts/dtc/dtc
> >>>    HOSTCC  scripts/kallsyms
> >>>    HOSTCC  scripts/sorttable
> >>>    HOSTCC  scripts/asn1_compiler
> >>>    HOSTCC  scripts/selinux/genheaders/genheaders
> >>>    HOSTCC  scripts/selinux/mdp/mdp
> >>>    CC      scripts/mod/empty.o
> >>>    HOSTCC  scripts/mod/mk_elfconfig
> >>>    CC      scripts/mod/devicetable-offsets.s
> >>>    CHECK   ../scripts/mod/empty.c
> >>> invalid argument to '-march': '_zihintpause'
> >>>
> >>> make[2]: *** [../scripts/Makefile.build:250: scripts/mod/empty.o] Error 1
> >>> make[2]: *** Deleting file 'scripts/mod/empty.o'
> >>> make[2]: *** Waiting for unfinished jobs....
> >>> make[1]: *** [/mnt/automation/corp/workspace/ux-test_upstream-next-develop-cd@2/linux/Makefile:1287: prepare0] Error 2
> >>> make[1]: Leaving directory '/mnt/automation/corp/workspace/ux-test_upstream-next-develop-cd@2/linux/builddir'
> >>> make: *** [Makefile:231: __sub-make] Error 2
> >>
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
