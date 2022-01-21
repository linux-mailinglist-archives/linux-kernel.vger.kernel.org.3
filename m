Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8444959E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378700AbiAUGZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378696AbiAUGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:25:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E31C06173F;
        Thu, 20 Jan 2022 22:25:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6647B81F4A;
        Fri, 21 Jan 2022 06:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D23C36AE7;
        Fri, 21 Jan 2022 06:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642746341;
        bh=Isi0LP5N8Hd28Ba/kM6pY+YaZm5nWrdB7apzNizLGkI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QGovHoz1oiofsdeaaXvjyotkiuHEDH0/CO+SlieoWuLCgx5KtV+Ai2Csju6ecvcNn
         xTbsrzAaDUp9BLR9AyNzODSTM1WIjQcjd/vxArKlUGwNgK09W1bVBsghi+Zm7UWemM
         uEtNuhsOXX8Ugo1Y4qHLm4MRe1sX1QcTL2nYe/FfR+RV6+/ofNF6GmJUNEvEHvHK+e
         w1SoJRREbXxjcdQQSlT7aN2dH/O/U5TVCUyEr9r+jtwrROIzQilSGVx4QeQK9dZVSh
         d1xgfZJVGsxLsNdaiWOd+utFZwUfcRwN3wT3+g6qcQI0ranll2u6k7n00Y/woKgW8j
         jDKVRZ3MkFA6w==
Received: by mail-ua1-f45.google.com with SMTP id r15so15165463uao.3;
        Thu, 20 Jan 2022 22:25:41 -0800 (PST)
X-Gm-Message-State: AOAM531o1hGvHoRX5X6NRHKYSV3HPnON1mXcOnKe386cx1rrWYA36DfY
        M1NGgl+PD3UWDui+YcedmjcKpQniT2wYk59fM8o=
X-Google-Smtp-Source: ABdhPJwB7ga72MDOno+HFBeeiGH/FKsBJy+/4qpm4/UjbqnmBZuKa8XMIWL0JsmA8KTM5bJQlsAjrV4ffWb0zfo7B4M=
X-Received: by 2002:a67:e016:: with SMTP id c22mr1147085vsl.51.1642746340414;
 Thu, 20 Jan 2022 22:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-9-guoren@kernel.org> <CAK8P3a0LxB3we9wHOa4OPmNow6wz5NP49zeYhh7QXNv-MiR8UA@mail.gmail.com>
In-Reply-To: <CAK8P3a0LxB3we9wHOa4OPmNow6wz5NP49zeYhh7QXNv-MiR8UA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Jan 2022 14:25:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQVUF4LSO0a6_MV8x-UAiJw32pAFyS1oPNLXhcEaemzqg@mail.gmail.com>
Message-ID: <CAJF2gTQVUF4LSO0a6_MV8x-UAiJw32pAFyS1oPNLXhcEaemzqg@mail.gmail.com>
Subject: Re: [PATCH V3 08/17] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
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

On Thu, Jan 20, 2022 at 10:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
> >
> >  /* The array of function pointers for syscalls. */
> >  extern void * const sys_call_table[];
> > +#ifdef CONFIG_COMPAT
> > +extern void * const compat_sys_call_table[];
> > +#endif
>
> No need for the #ifdef, the normal convention is to just define the
> extern declaration unconditionally for symbols that may or may not be defined.
Okay

>
> > +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, pathname,
> > +                      arg_u32p(length))
> > +{
> > +       return ksys_truncate(pathname, arg_u64(length));
> > +}
>
> Are you sure these are the right calling conventions? According to [1],
> I think the 64-bit argument should be in an aligned pair of registers,
> which means you need an extra pad argument as in the arm64 version
> of these functions. Same for ftruncate64, pread64, pwrite64, and
> readahead.

[1] has abandoned.

See:
https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc

Ltp test results:

ftruncate01                                        PASS       0
ftruncate01_64                                     PASS       0
ftruncate03                                        PASS       0
ftruncate03_64                                     PASS       0
ftruncate04                                        CONF       32
ftruncate04_64                                     CONF       32

truncate02                                         PASS       0
truncate02_64                                      PASS       0
truncate03                                         PASS       0
truncate03_64                                      PASS       0

pread01                                            PASS       0
pread01_64                                         PASS       0
pread02                                            PASS       0
pread02_64                                         PASS       0
pread03                                            PASS       0
pread03_64                                         PASS       0

pwrite01_64                                        PASS       0
pwrite02_64                                        PASS       0
pwrite03_64                                        PASS       0
pwrite04_64                                        PASS       0

readahead01                                        PASS       0
readahead02                                        CONF       32


>
> > +COMPAT_SYSCALL_DEFINE3(ftruncate64, unsigned int, fd, arg_u32p(length))
> > +{
> > +       return ksys_ftruncate(fd, arg_u64(length));
> > +}
> > +
> > +COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode,
> > +                      arg_u32p(offset), arg_u32p(len))
> > +{
> > +       return ksys_fallocate(fd, mode, arg_u64(offset), arg_u64(len));
> > +}
> > +
> > +COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, buf,
> > +                      size_t, count, arg_u32p(pos))
> > +{
> > +       return ksys_pread64(fd, buf, count, arg_u64(pos));
> > +}
> > +
> > +COMPAT_SYSCALL_DEFINE5(pwrite64, unsigned int, fd,
> > +                      const char __user *, buf, size_t, count, arg_u32p(pos))
> > +{
> > +       return ksys_pwrite64(fd, buf, count, arg_u64(pos));
> > +}
> > +
> > +COMPAT_SYSCALL_DEFINE6(sync_file_range, int, fd, arg_u32p(offset),
> > +                      arg_u32p(nbytes), unsigned int, flags)
> > +{
> > +       return ksys_sync_file_range(fd, arg_u64(offset), arg_u64(nbytes),
> > +                                   flags);
> > +}
> > +
> > +COMPAT_SYSCALL_DEFINE4(readahead, int, fd, arg_u32p(offset),
> > +                      size_t, count)
> > +{
> > +       return ksys_readahead(fd, arg_u64(offset), count);
> > +}
> > +
> > +COMPAT_SYSCALL_DEFINE6(fadvise64_64, int, fd, int, advice, arg_u32p(offset),
> > +                      arg_u32p(len))
> > +{
> > +       return ksys_fadvise64_64(fd, arg_u64(offset), arg_u64(len), advice);
> > +}
>
> I still feel like these should be the common implementations next to the
> native handlers inside of an #ifdef CONFIG_COMPAT.
>
> The names clash with the custom versions defined for powerpc and sparc,
> but the duplicates look compatible if you can account for the padded
> argument and the lo/hi order of the pairs, so could just be removed here
> (all other architectures use custom function names instead).
I would try it later.

>
>         Arnd
>
> [1] https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
