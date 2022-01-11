Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA50148A5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346625AbiAKCnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:43:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57012 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiAKCnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:43:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93257B8181E;
        Tue, 11 Jan 2022 02:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D3CC36AF2;
        Tue, 11 Jan 2022 02:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641868983;
        bh=L7cfkATlDL/kbJDiU7W4pEz2E1DRcTSkpRrIsXKoHAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SvBicDJ5I4L17UeymXOnn+zXfU1+dI5QyZoF1LCEXlf0yCWlKHAjuGj6so61+/QfU
         HJiiITRYEIScN5TUKfXXHUPUOhJCP1qnsdaJYqd9cqMpwk6NfY8hmSMP6UjJfoG4nl
         q/XhPuDumR/UafFefFg6SGZC5tLySoBC2B8E6QzBRv5shP7zZyzeTFtr/p8mWXkxpM
         3aT84vcWQHJh3V4V61GwpdI1p1gINCGDj31zN673RdKFMIXO7FjZgrYJBVIjbsF6eh
         HuAKmKKceppLTR7sWBvVavZJnrprlijapFGEhzEcCsl7NH3HmnmvScQcaLSyxoT9pV
         8k1oU8bT9yEIQ==
Received: by mail-ua1-f44.google.com with SMTP id m15so12852500uap.6;
        Mon, 10 Jan 2022 18:43:03 -0800 (PST)
X-Gm-Message-State: AOAM531necCM9pfRD73VSzgAmEnsqsdmuHUIxea/Koea8JAVzc1Y3WEt
        43v20q/PNHqToE6jj0vXCKJaG/5AonGZhZeQcOw=
X-Google-Smtp-Source: ABdhPJx2b4iOxBpQ9IOExNK2lhBMZAT9iocMb0nW0FEEl0sIdbHpU9vbDvP58kvQ6UoDTDuHXXLmA3s1gjGYrCCrjOU=
X-Received: by 2002:a05:6102:1009:: with SMTP id q9mr1248576vsp.22.1641868982282;
 Mon, 10 Jan 2022 18:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20211228143958.3409187-1-guoren@kernel.org> <20211228143958.3409187-12-guoren@kernel.org>
 <CAK8P3a0H2Nq=bFdzWGzzGuFWP85JA7=Td6_rb8GqOF3bYCRJBw@mail.gmail.com>
In-Reply-To: <CAK8P3a0H2Nq=bFdzWGzzGuFWP85JA7=Td6_rb8GqOF3bYCRJBw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 11 Jan 2022 10:42:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQCJ2W2wgdTVpdCoD0ycTkRd1jvfweknjq=t+PrW8QjKg@mail.gmail.com>
Message-ID: <CAJF2gTQCJ2W2wgdTVpdCoD0ycTkRd1jvfweknjq=t+PrW8QjKg@mail.gmail.com>
Subject: Re: [PATCH V2 11/17] riscv: compat: Add elf.h implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 10:29 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Dec 28, 2021 at 3:39 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Implement necessary type and macro for compat elf. See the code
> > comment for detail.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> This looks mostly correct,
>
> > +/*
> > + * FIXME: not sure SET_PERSONALITY for compat process is right!
> > + */
> > +#define SET_PERSONALITY(ex)                                               \
> > +do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)                         \
> > +               set_thread_flag(TIF_32BIT);                                \
> > +       else                                                               \
> > +               clear_thread_flag(TIF_32BIT);                              \
> > +       set_personality(PER_LINUX | (current->personality & (~PER_MASK))); \
> > +} while (0)
>
> This means the personality after exec is always set to PER_LINUX, not
> PER_LINUX32, which I think is wrong: you want the PER_LINUX32
> setting to stick, just like the upper bits do in the default implementation.
>
> What the other ones do is:
>
> | arch/parisc/include/asm/elf.h-
> set_personality((current->personality & ~PER_MASK) | PER_LINUX); \
>
> This looks like the same problem you introduce here: always forcing PER_LINUX
> instead of PER_LINUX32 makes it impossible to use PER_LINUX32.
>
> | arch/alpha/include/asm/elf.h:#define SET_PERSONALITY(EX)
>                            \
> | arch/alpha/include/asm/elf.h-   set_personality(((EX).e_flags &
> EF_ALPHA_32BIT)         \
> | arch/alpha/include/asm/elf.h-      ? PER_LINUX_32BIT : PER_LINUX)
> | arch/csky/include/asm/elf.h:#define SET_PERSONALITY(ex)
> set_personality(PER_LINUX)
> | arch/nds32/include/asm/elf.h:#define SET_PERSONALITY(ex)
> set_personality(PER_LINUX)
>
> These look even worse: instead of forcing the lower bits to
> PER_LINUX/PER_LINUX32 and
> leaving the upper bits untouched, these also clear the upper bits
> unconditionally.
>
> | arch/arm64/include/asm/elf.h:#define SET_PERSONALITY(ex)
>                                    \
> | arch/arm64/include/asm/elf.h-   current->personality &=
> ~READ_IMPLIES_EXEC;                     \
> | arch/x86/um/asm/elf.h:#define SET_PERSONALITY(ex) do {} while(0)
> | arch/x86/include/asm/elf.h:#define set_personality_64bit()      do {
> } while (0)
> | arch/x86/kernel/process_64.c:static void __set_personality_ia32(void)
> |         current->personality |= force_personality32;
>
> Inconsistent: does not enforce PER_LINUX/PER_LINUX32 as the default
> implementation
> does, but just leaves the value untouched (other than (re)setting
> READ_IMPLIES_EXEC).
> I think this is harmless otherwise, as we generally ignore the lower
> bits, except for the
> bit of code that checks for PER_LINUX32 in override_architecture() to mangle the
> output of sys_newuname() or in /proc/cpuinfo.
>
> | arch/s390/include/asm/elf.h-    if
> (personality(current->personality) != PER_LINUX32)   \
> | arch/s390/include/asm/elf.h-            set_personality(PER_LINUX |
>                    \
> | arch/s390/include/asm/elf.h-
> (current->personality & ~PER_MASK));    \
> | arch/powerpc/include/asm/elf.h- if
> (personality(current->personality) != PER_LINUX32)   \
> | arch/powerpc/include/asm/elf.h-         set_personality(PER_LINUX |
>                    \
> | arch/powerpc/include/asm/elf.h-
> (current->personality & (~PER_MASK)));  \
> | arch/sparc/include/asm/elf_64.h-        if
> (personality(current->personality) != PER_LINUX32)   \
> | arch/sparc/include/asm/elf_64.h-
> set_personality(PER_LINUX |             \
> | arch/sparc/include/asm/elf_64.h-
> (current->personality & (~PER_MASK)));  \
>
> This is probably the behavior you want to copy.
Thank you very much for your detailed explanation. Here is my modification.

+#define SET_PERSONALITY(ex)                                    \
+do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)              \
+               set_thread_flag(TIF_32BIT);                     \
+       else                                                    \
+               clear_thread_flag(TIF_32BIT);                   \
+       if (personality(current->personality) != PER_LINUX32)   \
+               set_personality(PER_LINUX |                     \
+                       (current->personality & (~PER_MASK)));  \
+} while (0)

>
>       Arnd




--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
