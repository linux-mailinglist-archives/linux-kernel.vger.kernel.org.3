Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC384ACDA1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbiBHBIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344002AbiBHAXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:23:22 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DC9C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:23:20 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x23so30282493lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+UHHZa2YhdmgPQstvWeRcu9szchcoh5hh/+NR8x4Lw=;
        b=ErUcSvv+gs26Pc/m2GTel4mHnX+MNfW1UMejFso5fP12YclQFyEmMAOIrhqOmJ7FbP
         SkiuDQCzfK2py0GD1EhVLFdEUr6R4yiu8/mK15dehRGieJ3ipPAAXs3sVc8nAvP6gawA
         kbqf8WlQVWcZFVL/ON/3eejFBlWwTssEJsfRwd4E3+raFqSLrOYsw9Os7hwLH7orJhIG
         +6sb+iAoscZ79eT4ca5MW3hMrkSlP2QZainAR4noyo6oYMGvXM4D4S1Vy70WrQ0mdaU6
         39VJPJ0x+H9UhuWwin2wNZks2ctYLGNTJbFf/jiA+zTV94eUwT2L+rzP/KzdlkKzfWO0
         Gszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+UHHZa2YhdmgPQstvWeRcu9szchcoh5hh/+NR8x4Lw=;
        b=XkCc23O6Pnzw5XJBowdZwEoAL8kbVtwhSHCfgXy7VkZ659F9TFYhMNJ3KSrb8euS/o
         FULgn6633AU9BBZuAnj/WEGMfp5bb1KrfxWWJpvRs9VONnjLCjxYEC4uBUhDx/It1kvX
         PJOskNgciGEqiTj98ovaOjEsriH1WZmO5oYKVJm6Mhrc+SFiCmZV9NMQQ8GwfFLZIQH1
         jeLsRkgeVwBGJA8bgWQdwreSdRnSA8LFv7ga9brDSTcAvMlbyVDpi0bIBd3LMyudFCPZ
         nmhVOh9n/wQO4/HkmZujnBLsBU6lzq0mL85Kvj5OMkZXXyFIMvXC7vOE6Pqy+1Ty1ibY
         shzg==
X-Gm-Message-State: AOAM5302aWOgkLrKMU2QM2rxgCOauA+mhwmGttUtEHEnMmkWjoC4CVPH
        uayScm1u0h4IowNCz4PAq2cuUswuDJFtOGb8OCqIGA==
X-Google-Smtp-Source: ABdhPJxyJiCaGJWkvMivtV2ifskFcihKaSNUittUcMO/bniTtZGs4M2zoCC3GXebDTpvgIC0pmawBO7SUGzrh+/RxWc=
X-Received: by 2002:a05:6512:3ba5:: with SMTP id g37mr1305901lfv.651.1644279798797;
 Mon, 07 Feb 2022 16:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20220204123740.GA4077@xsang-OptiPlex-9020>
In-Reply-To: <20220204123740.GA4077@xsang-OptiPlex-9020>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Feb 2022 16:23:06 -0800
Message-ID: <CAKwvOdm0+bB=UY91V=ai2TPg3XCbNUZQfBzxrSUA0AtW=zM=LA@mail.gmail.com>
Subject: Re: [x86] 1099ce55b0: BUG:kernel_NULL_pointer_dereference,address
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 4:37 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with clang-15):
>
> commit: 1099ce55b0530ff429312dc37362ad43aee8c5c0 ("x86: don't build CONFIG_X86_32 as -ffreestanding")
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git for-next/memcpy
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +---------------------------------------------+------------+------------+
> |                                             | 274d8f425a | 1099ce55b0 |
> +---------------------------------------------+------------+------------+
> | boot_successes                              | 9          | 0          |
> | boot_failures                               | 0          | 10         |
> | BUG:kernel_NULL_pointer_dereference,address | 0          | 10         |
> | Oops:#[##]                                  | 0          | 10         |
> | EIP:bcmp                                    | 0          | 10         |
> | Kernel_panic-not_syncing:Fatal_exception    | 0          | 10         |
> | Kernel_panic-not_syncing:Fatal_exception]   | 0          | 10         |
> +---------------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [    0.000000][    T0] BUG: kernel NULL pointer dereference, address: 0000004d
> [    0.000000][    T0] #PF: supervisor read access in kernel mode
> [    0.000000][    T0] #PF: error_code(0x0000) - not-present page
> [    0.000000][    T0] *pde = 00000000
> [    0.000000][    T0] Oops: 0000 [#1]
> [    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.17.0-rc2-00011-g1099ce55b053 #1
> [    0.000000][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [ 0.000000][ T0] EIP: bcmp (??:?)
> [ 0.000000][ T0] Code: 90 90 90 90 90 90 90 90 55 89 e5 53 57 56 50 83 f9 04 72 33 83 05 c8 e5 9c c2 01 8b 35 cc e5 9c c2 83 c6 01 90 90 90 90 8b 38 <3b> 3a 75 26 89 35 cc e5 9c c2 83 c0 04 83 c2 04 83 c1 fc 83 c6 01
> All code
> ========
>    0:   90                      nop
>    1:   90                      nop
>    2:   90                      nop
>    3:   90                      nop
>    4:   90                      nop
>    5:   90                      nop
>    6:   90                      nop
>    7:   90                      nop
>    8:   55                      push   %rbp
>    9:   89 e5                   mov    %esp,%ebp
>    b:   53                      push   %rbx
>    c:   57                      push   %rdi
>    d:   56                      push   %rsi
>    e:   50                      push   %rax
>    f:   83 f9 04                cmp    $0x4,%ecx
>   12:   72 33                   jb     0x47
>   14:   83 05 c8 e5 9c c2 01    addl   $0x1,-0x3d631a38(%rip)        # 0xffffffffc29ce5e3
>   1b:   8b 35 cc e5 9c c2       mov    -0x3d631a34(%rip),%esi        # 0xffffffffc29ce5ed
>   21:   83 c6 01                add    $0x1,%esi
>   24:   90                      nop
>   25:   90                      nop
>   26:   90                      nop
>   27:   90                      nop
>   28:   8b 38                   mov    (%rax),%edi
>   2a:*  3b 3a                   cmp    (%rdx),%edi              <-- trapping instruction

I've been having a hard time pinpointing via bisection when this
stopped working.  I suspect it's actually the change on llvm's side
that would replace memcmp with bcmp.  With this diff, we can boot
ARCH=i386 defconfig

```
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7ef211865239..5e4570495206 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -88,6 +88,8 @@ ifeq ($(CONFIG_X86_32),y)
         include $(srctree)/arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)

+        KBUILD_CFLAGS += -fno-builtin-bcmp
+
        ifeq ($(CONFIG_STACKPROTECTOR),y)
                ifeq ($(CONFIG_SMP),y)
                        KBUILD_CFLAGS +=
-mstack-protector-guard-reg=fs
-mstack-protector-guard-symbol=__stack_chk_guard
```

It looks like the call argument setup in the _callers_ of memcmp is messed up.

Before:
pushl %ecx
pushl %ebx
pushl -24(%ebp)
calll bcmp

After:
movl  %ebx, %eax
movl  %esi, %edx
movl  %ecx, %ebx
calll memcmp

it looks like they're not obeying `-mregparm=3`.

https://godbolt.org/z/z3fjveP4h

Diffing the IR between `-mregparm=3` vs not, it looks like there's an
LLVM IR function argument attribute inreg.
https://llvm.org/docs/LangRef.html#parameter-attributes
>> This indicates that this parameter or return value should be treated in a
>> special target-dependent fashion while emitting code for a function call
>> or return (usually, by putting it in a register as opposed to memory,
>> though some targets use it to distinguish between two different kinds of
>> registers). Use of this attribute is target-specific.

As is tradition, instcombine is not checking+carrying over the
function argument attributes when replacing calls to memcmp w/ bcmp.

Before:
  %4 = call i32 @memcmp(i8* inreg noundef %3, i8* inreg noundef %0,
i32 inreg noundef %1) #4, !dbg !22

After:
  %bcmp = call i32 @bcmp(i8* %3, i8* %0, i32 %1), !dbg !22

Filed:
https://github.com/llvm/llvm-project/issues/53645

So I think the best course of action is to disable memcmp to bcmp
BEFORE the removal of -ffreestanding, and only for clang until we have
a fix in hand.


>   2c:   75 26                   jne    0x54
>   2e:   89 35 cc e5 9c c2       mov    %esi,-0x3d631a34(%rip)        # 0xffffffffc29ce600
>   34:   83 c0 04                add    $0x4,%eax
>   37:   83 c2 04                add    $0x4,%edx
>   3a:   83 c1 fc                add    $0xfffffffc,%ecx
>   3d:   83 c6 01                add    $0x1,%esi
>
> Code starting with the faulting instruction
> ===========================================
>    0:   3b 3a                   cmp    (%rdx),%edi
>    2:   75 26                   jne    0x2a
>    4:   89 35 cc e5 9c c2       mov    %esi,-0x3d631a34(%rip)        # 0xffffffffc29ce5d6
>    a:   83 c0 04                add    $0x4,%eax
>    d:   83 c2 04                add    $0x4,%edx
>   10:   83 c1 fc                add    $0xfffffffc,%ecx
>   13:   83 c6 01                add    $0x1,%esi
> [    0.000000][    T0] EAX: c23b5f10 EBX: 4b4d564b ECX: 564b4d56 EDX: 0000004d
> [    0.000000][    T0] ESI: 00000001 EDI: 4b4d564b EBP: c23b5efc ESP: c23b5eec
> [    0.000000][    T0] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210002
> [    0.000000][    T0] CR0: 80050033 CR2: 0000004d CR3: 02b4d000 CR4: 00040600
> [    0.000000][    T0] Call Trace:
> [ 0.000000][ T0] vmware_platform (vmware.c:?)
> [ 0.000000][ T0] detect_hypervisor_vendor (hypervisor.c:?)
> [ 0.000000][ T0] init_hypervisor_platform (??:?)
> [ 0.000000][ T0] setup_arch (??:?)
> [ 0.000000][ T0] ? vprintk (??:?)
> [ 0.000000][ T0] ? _printk (??:?)
> [ 0.000000][ T0] start_kernel (??:?)
> [ 0.000000][ T0] i386_start_kernel (??:?)
> [ 0.000000][ T0] startup_32_smp (??:?)
> [    0.000000][    T0] Modules linked in:
> [    0.000000][    T0] CR2: 000000000000004d
> [    0.000000][    T0] ---[ end trace 0000000000000000 ]---
> [ 0.000000][ T0] EIP: bcmp (??:?)
> [ 0.000000][ T0] Code: 90 90 90 90 90 90 90 90 55 89 e5 53 57 56 50 83 f9 04 72 33 83 05 c8 e5 9c c2 01 8b 35 cc e5 9c c2 83 c6 01 90 90 90 90 8b 38 <3b> 3a 75 26 89 35 cc e5 9c c2 83 c0 04 83 c2 04 83 c1 fc 83 c6 01
> All code
> ========
>    0:   90                      nop
>    1:   90                      nop
>    2:   90                      nop
>    3:   90                      nop
>    4:   90                      nop
>    5:   90                      nop
>    6:   90                      nop
>    7:   90                      nop
>    8:   55                      push   %rbp
>    9:   89 e5                   mov    %esp,%ebp
>    b:   53                      push   %rbx
>    c:   57                      push   %rdi
>    d:   56                      push   %rsi
>    e:   50                      push   %rax
>    f:   83 f9 04                cmp    $0x4,%ecx
>   12:   72 33                   jb     0x47
>   14:   83 05 c8 e5 9c c2 01    addl   $0x1,-0x3d631a38(%rip)        # 0xffffffffc29ce5e3
>   1b:   8b 35 cc e5 9c c2       mov    -0x3d631a34(%rip),%esi        # 0xffffffffc29ce5ed
>   21:   83 c6 01                add    $0x1,%esi
>   24:   90                      nop
>   25:   90                      nop
>   26:   90                      nop
>   27:   90                      nop
>   28:   8b 38                   mov    (%rax),%edi
>   2a:*  3b 3a                   cmp    (%rdx),%edi              <-- trapping instruction
>   2c:   75 26                   jne    0x54
>   2e:   89 35 cc e5 9c c2       mov    %esi,-0x3d631a34(%rip)        # 0xffffffffc29ce600
>   34:   83 c0 04                add    $0x4,%eax
>   37:   83 c2 04                add    $0x4,%edx
>   3a:   83 c1 fc                add    $0xfffffffc,%ecx
>   3d:   83 c6 01                add    $0x1,%esi
>
> Code starting with the faulting instruction
> ===========================================
>    0:   3b 3a                   cmp    (%rdx),%edi
>    2:   75 26                   jne    0x2a
>    4:   89 35 cc e5 9c c2       mov    %esi,-0x3d631a34(%rip)        # 0xffffffffc29ce5d6
>    a:   83 c0 04                add    $0x4,%eax
>    d:   83 c2 04                add    $0x4,%edx
>   10:   83 c1 fc                add    $0xfffffffc,%ecx
>   13:   83 c6 01                add    $0x1,%esi
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.17.0-rc2-00011-g1099ce55b053 .config
>         make HOSTCC=clang-15 CC=clang-15 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
>         make HOSTCC=clang-15 CC=clang-15 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
>         cd <mod-install-dir>
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
>
> Thanks,
> Oliver Sang
>


-- 
Thanks,
~Nick Desaulniers
