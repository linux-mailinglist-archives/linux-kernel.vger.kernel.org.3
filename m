Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D639B47D301
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbhLVNVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:21:50 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:32949 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbhLVNVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:21:49 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQNF3-1mmdY239DV-00MIzo; Wed, 22 Dec 2021 14:21:47 +0100
Received: by mail-wr1-f48.google.com with SMTP id s1so4877290wra.6;
        Wed, 22 Dec 2021 05:21:47 -0800 (PST)
X-Gm-Message-State: AOAM530HSeVgBhXuqCrfEQJPRTMXQmQ8vJK2ixbp/+6zdJB9oGvR2r7z
        Jps8G5130AWGCLQ9OCVjSq1IkQ3l7sQcqIvObWw=
X-Google-Smtp-Source: ABdhPJyZJ7IM3FfszIOXVrgOVxvS2jRO3t8J5UTThAJUFt3pUIkSGUxFgQ01Mn2RRPgx8pl2cn6vKm8xDVBrWZjoma4=
X-Received: by 2002:a5d:484f:: with SMTP id n15mr2096485wrs.219.1640179307179;
 Wed, 22 Dec 2021 05:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-6-guoren@kernel.org>
 <CAK8P3a2XOVYB1Fm5TBdjtKx9DXoG93Zrw7TiquYL_Zy916dLwQ@mail.gmail.com> <CAJF2gTR2fAU=+0fvW_VCqaZfDkSTAxQ=cKE9iAYOoGORb3m+4g@mail.gmail.com>
In-Reply-To: <CAJF2gTR2fAU=+0fvW_VCqaZfDkSTAxQ=cKE9iAYOoGORb3m+4g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 14:21:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a17A3MU_atWNEretDcr5sLRc7540tM4vfc=H4M8qVCDEg@mail.gmail.com>
Message-ID: <CAK8P3a17A3MU_atWNEretDcr5sLRc7540tM4vfc=H4M8qVCDEg@mail.gmail.com>
Subject: Re: [PATCH 05/13] riscv: compat: syscall: Add compat_sys_call_table implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:KcHzApjnyl97SUX/IjHk9uJ+lCkoxRQHHtJigChsCQANQqFlxY3
 5/MMq6g2VTuF/I46pfNd6RnlNIFQ+denbw/0tR0ryLFOGp5Ea0aZF1+XJeRgN1AhKAXivcf
 pnSS/Mc433rsAd/P95Vg19ab/yop6szHgm5aCi3HAEXOmC6z9QT2FhVC7e/2irYf+a7KSZI
 UJctetkKtFpihzC/+0Ruw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lQE0d/nP5bg=:uC4/+XsTo0ujXShH6CntwY
 b5QttaZHPJ5/u7tpRrCEWXV6Cp+X+iy45lfaVg2E/9ImfO2D2JpzC90iimta9rU0tNpOFkW1s
 XXHIbb2try1m3FkZBA1rDlEWJjUAJN+RAMXGwTz3/bU5DJf0dsSz2YuuHoEw72t3i7HsKtGey
 1ynBOlhBJd+IJQID2fhhERr5gkUEWsNYbG+oV/Kz6o1BwwQkt2/uv1hTmUStVPjAlHtzQ33ew
 wJSQnYrBseZ14gUZUcEvy/p9pg3Y8QnzQx3Pk/0LJg3v1qAJERik50PpremZePUgrirlFoThm
 JzIIcjdXugSw+Om6BQgWvHG1rFE+4ahwQnY/nDCrwysHPFYAVI7SPDHFxScWEVGVU+0MxVLag
 plc3FYkty/G4AXe68Pj8/dDIMaS3MQmTln64STW9xx/zFGwT+GgAdVkNSXHYBOg2GlhmwVDXL
 2KOq8UKXU+mNEoLWB+CyEah4petwEyinjhcUfvcIGeMsGnXPrS+jboBBS2Co295V8xu/YMflL
 ecazrxtiplC/RRukl12dJqKpr9h25ypt/vF/Wg3mrflVSbMHRnC4FGIIVflaW2H+SwbIJ45uA
 CwEYPr0NAENYCPpE7TZv1R0WfH15oXOg8ZIDNeQ0UuvekMFDhJ42ek9ekZ+ue3k1Cc8y9ltP5
 TRKOqUs5qT682x5SNAeuQJ1g5fTumz0m9AiVqkhKIH27P6WYrYiwx6iH7w55Q+XOZnb6TMncZ
 To+Q7UY/CjkT2XVNqzJLxQoLBNbGO8iYNlO/Zf2th4FSrioltsaezapbUu+jD2qSRj6lSbnsx
 Jnq765M4NzgDmypQt/zvMFwBCtV74FdlM13rPzJeHlFHWBX2v8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 1:43 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Dec 22, 2021 at 2:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Implement compat_syscall_table.c with compat_sys_call_table & fixup
> > > system call such as truncate64,pread64,fallocate which need two
> > > regs to indicate 64bit-arg (copied from arm64).
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > ---
> > >  arch/riscv/include/asm/syscall.h         |  3 +
> > >  arch/riscv/kernel/compat_syscall_table.c | 84 ++++++++++++++++++++++++
> >
> > Same here, I think most of these should go next to the actual syscalls, with the
> > duplicates removed from other platforms,
> Agree, I will try that next version.
>
> >
> > > +#define __SYSCALL_COMPAT
> > > +#undef __LP64__
> >
> > What is the #undef for?
>
> See arch/riscv/include/uapi/asm/unistd.h:
>
> #ifdef __LP64__
> #define __ARCH_WANT_NEW_STAT
> #define __ARCH_WANT_SET_GET_RLIMIT
> #endif /* __LP64__ */

Ok, in this case I would recommend changing that #ifdef to
check for __SYSCALL_COMPAT instead, as removing the
__LP64__ define may cause other unintended changes.


> > > +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
> > > +       unsigned long, prot, unsigned long, flags,
> > > +       unsigned long, fd, unsigned long, offset)
> > > +{
> > > +       if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
> > > +               if (unlikely(!(prot & PROT_READ)))
> > > +                       return -EINVAL;
> > > +
> > > +       return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset);
> > > +}
> >
> > This is one that we may have to deal with separately, introducing
> > sys_mmap_pgoff() was a mistake in my opinion, and we should just have
>
> #if __BITS_PER_LONG == 32 || defined(__SYSCALL_COMPAT)
> #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
> #else
> #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _64)
> #endif
>
> #define __NR3264_mmap 222
> __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
>
> > added a sys_mmap2() for all architectures that don't explicitly override it.
> That should be another patch, right? Let's keep it here.

Right, I think the patch would be a nice cleanup, but it appears that
riscv is among the few architectures that have defined their own
nonstandard mmap2() syscall after all, despite using the standard
name for the entry point. Not sure how this slipped past my original
review, but it certainly can't be changed now.

It also means that you need to change your implementation of
compat_sys_mmap2() to match the version from
arch/riscv/kernel/sys_riscv.c, rather than the version that
everyone else has. Maybe leave it there and change the
#ifdef to build mmap2 for both native rv32 and compat
mode.

FWIW, this is what a conversion from mmap_pgoff() to mmap2()
would look like, I think this is an overall win, but it's entirely
unrelated to your series now: https://pastebin.com/QtF55dn4
(I'm sure I got some details wrong, at least it needs some
#ifdef checks).

       Arnd
