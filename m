Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDECB595FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiHPP51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiHPP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:57:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E5D564DD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:54:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso10015301pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=q0t02tZn+lyShszZb2QblODphqaUGbYZAuB4Yb6ebzM=;
        b=g5hpu99D79h8RksybINLoJ9/fvz3PEsuamTptaZBrWWAJQEHZCDUe0rNjAR1Kix/js
         QicMYJ2AO6ObkxPnkCRPtNRMRvNUg0fdYsxt6CDBVlsNDTJogrL0bL332iVSGVaG1b7a
         ErKsDCB1twJCC/QQd6Lfjvq7lChcJBCbHysrrXg13bRqzD7JLalwiT8ZZTZv5lHZ/C3l
         bGymvZaOuqdiSKefEj9aR2KlZhNiYXxsIPQjlWUIFlMadyZYYA+prV35ujLbBIb6XNit
         2ouJxMqbK0sXh2AhjyGUmhZuhNigdVnbJVxm08LleKPqgFxTYUowcxpCn6r0TTd3pOc0
         Rn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=q0t02tZn+lyShszZb2QblODphqaUGbYZAuB4Yb6ebzM=;
        b=pen3joAYcMw6GpGJ4R/SXNjeV71DMjJuu3c+V/mHFQHf7CxssMfI+Kpf3T1ury2kZP
         IvRb0ZwrkAEcO8l+cEmpnRDES0yeIuO8TG1QPaGLgdzA3BRgg0+KJP0E5lpxdE+eGe4E
         Ez2reJdn0IdRi5qI1id6CFJxN6irVCRJX2JEx0/xsIqZIS6mIbdozDNVGeou+SCZIfb2
         VPeFOFp3FZofMZrgeXp0hrqb5nAaXRpVI3r83geTFaNhbJwnDVx/vuE/Xje2RG+s3ban
         o9Xju91wNsMAp30wdMKf5ftZBI3cwZ6RFmIVZR/nKmZFApmVnet67O+xqRzykjTxOXzD
         RDlQ==
X-Gm-Message-State: ACgBeo2C/W16HJJjpqdNzJ8isn1QET9SQUOn0aNB84cYufkfonvQozu7
        CDWVW+G8ef2LpRe7Zxbqcj5hRw==
X-Google-Smtp-Source: AA6agR5zZ+DvbjJWr2K/AxN3fo6u8OmrQAqQZpsE1xXn+4RHg2ABRw5X01oJ1d5OkDgHM6MU+EoSLw==
X-Received: by 2002:a17:90b:1941:b0:1f3:2636:895 with SMTP id nk1-20020a17090b194100b001f326360895mr24789832pjb.26.1660665258420;
        Tue, 16 Aug 2022 08:54:18 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id oa10-20020a17090b1bca00b001f21646d1a4sm3205073pjb.1.2022.08.16.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 08:54:17 -0700 (PDT)
Date:   Tue, 16 Aug 2022 08:54:17 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Aug 2022 08:54:16 PDT (-0700)
Subject:     Re: [PATCH v4] arch/riscv: add Zihintpause support
In-Reply-To: <310f0509-91c3-6ef2-8895-d1a87125f064@microchip.com>
CC:     daolu@rivosinc.com, linux-kernel@vger.kernel.org, heiko@sntech.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, anup@brainfault.org,
        guoren@kernel.org, jszhang@kernel.org, rdunlap@infradead.org,
        niklas.cassel@wdc.com, panqinglin2020@iscas.ac.cn,
        alexandre.ghiti@canonical.com, robh@kernel.org,
        research_trasio@irq.a4lg.com, yury.norov@gmail.com,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor.Dooley@microchip.com
Message-ID: <mhng-1b17506c-8dd7-4868-bd58-7df010313902@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 00:21:40 PDT (-0700), Conor.Dooley@microchip.com wrote:
> On 12/08/2022 07:57, Conor Dooley - M52691 wrote:
>> On 11/08/2022 16:17, Palmer Dabbelt wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On Mon, 20 Jun 2022 13:15:25 PDT (-0700), daolu@rivosinc.com wrote:
>>>> Implement support for the ZiHintPause extension.
>>>>
>>>> The PAUSE instruction is a HINT that indicates the current hart’s rate
>>>> of instruction retirement should be temporarily reduced or paused.
>>>>
>>>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>>> Signed-off-by: Dao Lu <daolu@rivosinc.com>
>>>> ---
>>>>
>>>> v1 -> v2:
>>>>  Remove the usage of static branch, use PAUSE if toolchain supports it
>>>> v2 -> v3:
>>>>  Added the static branch back, cpu_relax() behavior is kept the same for
>>>> systems that do not support ZiHintPause
>>>> v3 -> v4:
>>>>  Adopted the newly added unified static keys for extensions
>>>> ---
>>>>  arch/riscv/Makefile                     |  4 ++++
>>>>  arch/riscv/include/asm/hwcap.h          |  5 +++++
>>>>  arch/riscv/include/asm/vdso/processor.h | 21 ++++++++++++++++++---
>>>>  arch/riscv/kernel/cpu.c                 |  1 +
>>>>  arch/riscv/kernel/cpufeature.c          |  1 +
>>>>  5 files changed, 29 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>>>> index 34cf8a598617..6ddacc6f44b9 100644
>>>> --- a/arch/riscv/Makefile
>>>> +++ b/arch/riscv/Makefile
>>>> @@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)  := $(riscv-march-y)c
>>>>  toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
>>>>  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
>>>>
>>>> +# Check if the toolchain supports Zihintpause extension
>>>> +toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
>>>> +riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
>>>> +
>>>>  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
>>>>  KBUILD_AFLAGS += -march=$(riscv-march-y)
>>>>
>>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>>> index e48eebdd2631..dc47019a0b38 100644
>>>> --- a/arch/riscv/include/asm/hwcap.h
>>>> +++ b/arch/riscv/include/asm/hwcap.h
>>>> @@ -8,6 +8,7 @@
>>>>  #ifndef _ASM_RISCV_HWCAP_H
>>>>  #define _ASM_RISCV_HWCAP_H
>>>>
>>>> +#include <asm/errno.h>
>>>>  #include <linux/bits.h>
>>>>  #include <uapi/asm/hwcap.h>
>>>>
>>>> @@ -54,6 +55,7 @@ extern unsigned long elf_hwcap;
>>>>  enum riscv_isa_ext_id {
>>>>       RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
>>>>       RISCV_ISA_EXT_SVPBMT,
>>>> +     RISCV_ISA_EXT_ZIHINTPAUSE,
>>>>       RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>>>>  };
>>>>
>>>> @@ -64,6 +66,7 @@ enum riscv_isa_ext_id {
>>>>   */
>>>>  enum riscv_isa_ext_key {
>>>>       RISCV_ISA_EXT_KEY_FPU,          /* For 'F' and 'D' */
>>>> +     RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
>>>>       RISCV_ISA_EXT_KEY_MAX,
>>>>  };
>>>>
>>>> @@ -83,6 +86,8 @@ static __always_inline int riscv_isa_ext2key(int num)
>>>>               return RISCV_ISA_EXT_KEY_FPU;
>>>>       case RISCV_ISA_EXT_d:
>>>>               return RISCV_ISA_EXT_KEY_FPU;
>>>> +     case RISCV_ISA_EXT_ZIHINTPAUSE:
>>>> +             return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
>>>>       default:
>>>>               return -EINVAL;
>>>>       }
>>>> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
>>>> index 134388cbaaa1..1e4f8b4aef79 100644
>>>> --- a/arch/riscv/include/asm/vdso/processor.h
>>>> +++ b/arch/riscv/include/asm/vdso/processor.h
>>>> @@ -4,15 +4,30 @@
>>>>
>>>>  #ifndef __ASSEMBLY__
>>>>
>>>> +#include <linux/jump_label.h>
>>>>  #include <asm/barrier.h>
>>>> +#include <asm/hwcap.h>
>>>>
>>>>  static inline void cpu_relax(void)
>>>>  {
>>>> +     if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
>>>>  #ifdef __riscv_muldiv
>>>> -     int dummy;
>>>> -     /* In lieu of a halt instruction, induce a long-latency stall. */
>>>> -     __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>>>> +             int dummy;
>>>> +             /* In lieu of a halt instruction, induce a long-latency stall. */
>>>> +             __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>>>>  #endif
>>>> +     } else {
>>>> +             /*
>>>> +              * Reduce instruction retirement.
>>>> +              * This assumes the PC changes.
>>>> +              */
>>>> +#ifdef __riscv_zihintpause
>>>> +             __asm__ __volatile__ ("pause");
>>>> +#else
>>>> +             /* Encoding of the pause instruction */
>>>> +             __asm__ __volatile__ (".4byte 0x100000F");
>>>> +#endif
>>>> +     }
>>>>       barrier();
>>>>  }
>>>>
>>>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>>>> index fba9e9f46a8c..a123e92b14dd 100644
>>>> --- a/arch/riscv/kernel/cpu.c
>>>> +++ b/arch/riscv/kernel/cpu.c
>>>> @@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
>>>>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>>>>       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>>>>       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>>>> +     __RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>>>>       __RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>>>>  };
>>>>
>>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>>> index 1b3ec44e25f5..708df2c0bc34 100644
>>>> --- a/arch/riscv/kernel/cpufeature.c
>>>> +++ b/arch/riscv/kernel/cpufeature.c
>>>> @@ -198,6 +198,7 @@ void __init riscv_fill_hwcap(void)
>>>>                       } else {
>>>>                               SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
>>>>                               SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
>>>> +                             SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
>>>>                       }
>>>>  #undef SET_ISA_EXT_MAP
>>>>               }
>>>
>>> Thanks, this is on for-next.  It needs a sparse patch, which I put in as a link.
>> 
>> This breaks the C=1 build for all toolchains, not just new ones as your sparse
>> patch suggests. I amn't 100% what my CI is running, but I replicated this on
>> my own machine with:
> 
> Argh, I went poking around and my toolchain's binutils etc is newer than I thought.
> Good for people searching on lore I suppose...
> Sorry!

So just to be clear: you're saying this only breaks with new binutils?  
I ask because Dao is also seeing some crashes, if it's breaking 
arbitrary builds too then it's a stronger hint to revert it.

> Conor.
> 
>> 
>> sparse --version
>> 0.6.4 (Ubuntu: 0.6.4-2)
>> 
>> ---8<---
>>    YACC    scripts/dtc/dtc-parser.tab.[ch]
>>    HOSTCC  scripts/dtc/libfdt/fdt.o
>>    HOSTCC  scripts/dtc/libfdt/fdt_ro.o
>>    HOSTCC  scripts/dtc/libfdt/fdt_wip.o
>>    UPD     include/generated/uapi/linux/version.h
>>    HOSTCC  scripts/dtc/libfdt/fdt_sw.o
>>    UPD     include/config/kernel.release
>>    HOSTCC  scripts/dtc/libfdt/fdt_rw.o
>>    HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
>>    HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
>>    HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
>>    HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
>>    HOSTCC  scripts/dtc/fdtoverlay.o
>>    HOSTCC  scripts/dtc/dtc-lexer.lex.o
>>    HOSTCC  scripts/dtc/dtc-parser.tab.o
>>    UPD     include/generated/utsrelease.h
>>    HOSTLD  scripts/dtc/fdtoverlay
>>    HOSTLD  scripts/dtc/dtc
>>    HOSTCC  scripts/kallsyms
>>    HOSTCC  scripts/sorttable
>>    HOSTCC  scripts/asn1_compiler
>>    HOSTCC  scripts/selinux/genheaders/genheaders
>>    HOSTCC  scripts/selinux/mdp/mdp
>>    CC      scripts/mod/empty.o
>>    HOSTCC  scripts/mod/mk_elfconfig
>>    CC      scripts/mod/devicetable-offsets.s
>>    CHECK   ../scripts/mod/empty.c
>> invalid argument to '-march': '_zihintpause'
>> 
>> make[2]: *** [../scripts/Makefile.build:250: scripts/mod/empty.o] Error 1
>> make[2]: *** Deleting file 'scripts/mod/empty.o'
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [/mnt/automation/corp/workspace/ux-test_upstream-next-develop-cd@2/linux/Makefile:1287: prepare0] Error 2
>> make[1]: Leaving directory '/mnt/automation/corp/workspace/ux-test_upstream-next-develop-cd@2/linux/builddir'
>> make: *** [Makefile:231: __sub-make] Error 2
> 
