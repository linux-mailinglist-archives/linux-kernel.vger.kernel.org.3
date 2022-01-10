Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0176489B43
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiAJOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:30:34 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:40055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiAJO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:28:59 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MyK9U-1m8X1J1Mpo-00yhft; Mon, 10 Jan 2022 15:28:57 +0100
Received: by mail-wr1-f54.google.com with SMTP id v6so27050965wra.8;
        Mon, 10 Jan 2022 06:28:57 -0800 (PST)
X-Gm-Message-State: AOAM532VBMarH7QeVUHGoz8+ZXjU/9qZZeVZVz90AB9wVWVF/f/m2yjD
        M7TXr0hBOeDI3wSDD6t42Wu4QNex4i4JfLRdij8=
X-Google-Smtp-Source: ABdhPJwP2dj7vwEXcQpaQSkksNl0ZEmP7KqS5c95/LhZe5KvkABgHfbU/HDC2zAjxcbRJXknKfqyiFGKdYDX7S/ttBs=
X-Received: by 2002:a05:6000:16c7:: with SMTP id h7mr17539097wrf.317.1641824936821;
 Mon, 10 Jan 2022 06:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20211228143958.3409187-1-guoren@kernel.org> <20211228143958.3409187-12-guoren@kernel.org>
In-Reply-To: <20211228143958.3409187-12-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Jan 2022 15:28:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0H2Nq=bFdzWGzzGuFWP85JA7=Td6_rb8GqOF3bYCRJBw@mail.gmail.com>
Message-ID: <CAK8P3a0H2Nq=bFdzWGzzGuFWP85JA7=Td6_rb8GqOF3bYCRJBw@mail.gmail.com>
Subject: Re: [PATCH V2 11/17] riscv: compat: Add elf.h implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UXLcJaB2lA59YOxwVTQMBTB9Dxji9s7QCHe0L7WJKm/zT8kjwvJ
 LBjfwCCXJ/N9g7kU69rg+/0EvE2V8nB7GMF9P5FdaYUvOWUrZjBOg+gBanVkEGe4nGS+gU1
 8Xf8k4fDqhQcn3LL+8hWphPJsrAxWcQ+EFPACTlxX+KeCmtT8e9jRJkmlC+eSDByMH3JQpC
 QwVuQNtUX5VMAzqJpf1qw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HoS1Cfn33y0=:PConMlud95CuR/s+ENDO8j
 Ww8aJhs5Ekbl///6FhHqJvuP/JCTeh7mxyXPpzUN3+nHP50EYZO3IccdpdYDzS0i6rta7poqd
 0+MHUB1dC5NHSXq7+K5fuC6JV6HEuW03p0s218WvrY1JS1WAeSg/U2oFd42Y0miGh+fbxeURe
 BEDN3EacpJJWsvZMIWaQB2c4E80LxGUcjLHVlTYy3cGvxXrWlewDSe9Q3YSHqX2OxHvFra9Y1
 iacjjPdOoSg28DTtAkE0lsgzWma34lAz8+2ZmqR5iqOsQ/UQMKc3lbKVjxyKb1h0dn7KDoKwQ
 86zMwLCY6HwT2/4tH8Q2vo6dIABEbit3qXl+3+t2rlt0jaqJ1lRXy0WoV4yovKRXKgr9EQrLI
 vAHP/+Z/jGTTDOdxAs4Lz8jXaSA7n09S2iPz9muukRCtaV2vz7vSylhJFRyb176Yh+g73Sjwr
 /EV+kFNwU/5GaK5FtE894LoZPbfyYXtR80ccbWc4mzXcgiGSV4+kmmv5+HDKJuF/0Tvhmxb6V
 RaNcmGAeRt1uOrGShSUArpz48oCGx9sdsNJjLaO7/tjBntpjdEKo/b/z9GAWDb4MYFPox33vy
 JVhLLYUWb/hHQ3mn3KY7jcvAu8xogbG67nZWJe81LWlHUVBxnEi/mAbfz8f31bXlx3VR42/79
 zze8iRoiPpPNjzfW/V6GffCmJDtaTwbEcAcNtuJ2+3H5TsSbrGZgkdG7yvWiaaDGt0EXLFOb/
 PUCrDfBdyUw8e/nxfEaVOyb7qcc+UYeNif3GiE6TRCeqChpq4ET4SNU7YLpjmek18j2lkqmlq
 k1BGXt0oneRdhdFqllETd4UBBhB9R7DxyQOyTge6+EJPPGzwSA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 3:39 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Implement necessary type and macro for compat elf. See the code
> comment for detail.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

This looks mostly correct,

> +/*
> + * FIXME: not sure SET_PERSONALITY for compat process is right!
> + */
> +#define SET_PERSONALITY(ex)                                               \
> +do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)                         \
> +               set_thread_flag(TIF_32BIT);                                \
> +       else                                                               \
> +               clear_thread_flag(TIF_32BIT);                              \
> +       set_personality(PER_LINUX | (current->personality & (~PER_MASK))); \
> +} while (0)

This means the personality after exec is always set to PER_LINUX, not
PER_LINUX32, which I think is wrong: you want the PER_LINUX32
setting to stick, just like the upper bits do in the default implementation.

What the other ones do is:

| arch/parisc/include/asm/elf.h-
set_personality((current->personality & ~PER_MASK) | PER_LINUX); \

This looks like the same problem you introduce here: always forcing PER_LINUX
instead of PER_LINUX32 makes it impossible to use PER_LINUX32.

| arch/alpha/include/asm/elf.h:#define SET_PERSONALITY(EX)
                           \
| arch/alpha/include/asm/elf.h-   set_personality(((EX).e_flags &
EF_ALPHA_32BIT)         \
| arch/alpha/include/asm/elf.h-      ? PER_LINUX_32BIT : PER_LINUX)
| arch/csky/include/asm/elf.h:#define SET_PERSONALITY(ex)
set_personality(PER_LINUX)
| arch/nds32/include/asm/elf.h:#define SET_PERSONALITY(ex)
set_personality(PER_LINUX)

These look even worse: instead of forcing the lower bits to
PER_LINUX/PER_LINUX32 and
leaving the upper bits untouched, these also clear the upper bits
unconditionally.

| arch/arm64/include/asm/elf.h:#define SET_PERSONALITY(ex)
                                   \
| arch/arm64/include/asm/elf.h-   current->personality &=
~READ_IMPLIES_EXEC;                     \
| arch/x86/um/asm/elf.h:#define SET_PERSONALITY(ex) do {} while(0)
| arch/x86/include/asm/elf.h:#define set_personality_64bit()      do {
} while (0)
| arch/x86/kernel/process_64.c:static void __set_personality_ia32(void)
|         current->personality |= force_personality32;

Inconsistent: does not enforce PER_LINUX/PER_LINUX32 as the default
implementation
does, but just leaves the value untouched (other than (re)setting
READ_IMPLIES_EXEC).
I think this is harmless otherwise, as we generally ignore the lower
bits, except for the
bit of code that checks for PER_LINUX32 in override_architecture() to mangle the
output of sys_newuname() or in /proc/cpuinfo.

| arch/s390/include/asm/elf.h-    if
(personality(current->personality) != PER_LINUX32)   \
| arch/s390/include/asm/elf.h-            set_personality(PER_LINUX |
                   \
| arch/s390/include/asm/elf.h-
(current->personality & ~PER_MASK));    \
| arch/powerpc/include/asm/elf.h- if
(personality(current->personality) != PER_LINUX32)   \
| arch/powerpc/include/asm/elf.h-         set_personality(PER_LINUX |
                   \
| arch/powerpc/include/asm/elf.h-
(current->personality & (~PER_MASK)));  \
| arch/sparc/include/asm/elf_64.h-        if
(personality(current->personality) != PER_LINUX32)   \
| arch/sparc/include/asm/elf_64.h-
set_personality(PER_LINUX |             \
| arch/sparc/include/asm/elf_64.h-
(current->personality & (~PER_MASK)));  \

This is probably the behavior you want to copy.

      Arnd
