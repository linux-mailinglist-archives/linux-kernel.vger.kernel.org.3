Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1447D247
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbhLVMnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbhLVMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:43:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3F8C061761;
        Wed, 22 Dec 2021 04:43:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A567CB81054;
        Wed, 22 Dec 2021 12:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795F7C36AEA;
        Wed, 22 Dec 2021 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640177015;
        bh=spRwUCGiSSG8n6qeVEE9aN2Iq6VFzAj957YT2tK8Kqs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XOAUZhCycs8P/F/IgB41mY0S24xJyBhBueU6B2STDwK6SWiYp9SFmsTMDZUwf0WlS
         XuGelJ1kDkiPKATKBgPNXcBwUcC0Qi2ZaErDTa1EcLQgSantLXY0oWuTcUXnERnHqG
         PHwPJE3Gc9PccipxJLHsMflbauYYRzS+hjqeLI3jxpvkAkIYc2d2igdTSXOJYTHrxL
         p5IIoIGZLKlbmMVRcBfrRy/YmlQTsYG666UvZpVq7zLs9GoEWvtnRVdSvgoERT9zus
         nnfJvRLhGTzkiPreYUb/purRFnEOQilR8tA4kyBTlksVtapPJgMg637B6GGV6+ZfuX
         nkamUJNP2aBKA==
Received: by mail-vk1-f177.google.com with SMTP id s144so1223614vkb.8;
        Wed, 22 Dec 2021 04:43:35 -0800 (PST)
X-Gm-Message-State: AOAM531TEvvdpNxHN4xwr3s9qo1h5YUOgtyZFLXNsh1eHexVQPc3TTSS
        4a3G0TvKDleyotkeqEgEqCu9oe09/R3HHuJGVUY=
X-Google-Smtp-Source: ABdhPJzC3viZd1a1jd6xOFjIMdxvyj8zxpI+z9Ie7iUhyHVWlvCpwXNy8RLLG5OJvKtf/gKMdK2si6m9Ls6Z9GIn+oY=
X-Received: by 2002:a1f:a4c5:: with SMTP id n188mr846875vke.35.1640177006825;
 Wed, 22 Dec 2021 04:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-6-guoren@kernel.org>
 <CAK8P3a2XOVYB1Fm5TBdjtKx9DXoG93Zrw7TiquYL_Zy916dLwQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2XOVYB1Fm5TBdjtKx9DXoG93Zrw7TiquYL_Zy916dLwQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Dec 2021 20:43:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR2fAU=+0fvW_VCqaZfDkSTAxQ=cKE9iAYOoGORb3m+4g@mail.gmail.com>
Message-ID: <CAJF2gTR2fAU=+0fvW_VCqaZfDkSTAxQ=cKE9iAYOoGORb3m+4g@mail.gmail.com>
Subject: Re: [PATCH 05/13] riscv: compat: syscall: Add compat_sys_call_table implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 2:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Implement compat_syscall_table.c with compat_sys_call_table & fixup
> > system call such as truncate64,pread64,fallocate which need two
> > regs to indicate 64bit-arg (copied from arm64).
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  arch/riscv/include/asm/syscall.h         |  3 +
> >  arch/riscv/kernel/compat_syscall_table.c | 84 ++++++++++++++++++++++++
>
> Same here, I think most of these should go next to the actual syscalls, with the
> duplicates removed from other platforms,
Agree, I will try that next version.

>
> > +#define __SYSCALL_COMPAT
> > +#undef __LP64__
>
> What is the #undef for?

See arch/riscv/include/uapi/asm/unistd.h:

#ifdef __LP64__
#define __ARCH_WANT_NEW_STAT
#define __ARCH_WANT_SET_GET_RLIMIT
#endif /* __LP64__ */


>
> > +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
> > +       unsigned long, prot, unsigned long, flags,
> > +       unsigned long, fd, unsigned long, offset)
> > +{
> > +       if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
> > +               if (unlikely(!(prot & PROT_READ)))
> > +                       return -EINVAL;
> > +
> > +       return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset);
> > +}
>
> This is one that we may have to deal with separately, introducing
> sys_mmap_pgoff() was a mistake in my opinion, and we should just have
#if __BITS_PER_LONG == 32 || defined(__SYSCALL_COMPAT)
#define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
#else
#define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _64)
#endif

#define __NR3264_mmap 222
__SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)

> added a sys_mmap2() for all architectures that don't explicitly override it.
That should be another patch, right? Let's keep it here.

>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
