Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431EA47C4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbhLURP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:15:56 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhLURPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:15:55 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MYNW8-1mutBL3wZe-00VReI; Tue, 21 Dec 2021 18:15:53 +0100
Received: by mail-wm1-f52.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso2193512wmc.4;
        Tue, 21 Dec 2021 09:15:53 -0800 (PST)
X-Gm-Message-State: AOAM531AhZ21DRpQBrx6icWuwRQVLJx311u33QTCipm+WR4NE0Sp3bvR
        ELh9RrpUDdyDDFM70I/i0Ngurj50+aHAEYHgMMY=
X-Google-Smtp-Source: ABdhPJzffr6WnaoEGTyhmBnXPy5ZleWzwlOCZ8nvVWpeF4NBAn+XXQBe16uur6o+emymJ0RcuqEtqPLnaIQ+7GdGM4I=
X-Received: by 2002:a7b:c007:: with SMTP id c7mr3663200wmb.82.1640106953460;
 Tue, 21 Dec 2021 09:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-6-guoren@kernel.org>
In-Reply-To: <20211221163532.2636028-6-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 18:15:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2XOVYB1Fm5TBdjtKx9DXoG93Zrw7TiquYL_Zy916dLwQ@mail.gmail.com>
Message-ID: <CAK8P3a2XOVYB1Fm5TBdjtKx9DXoG93Zrw7TiquYL_Zy916dLwQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] riscv: compat: syscall: Add compat_sys_call_table implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        Drew Fustini <drew@beagleboard.org>, wangjunqiang@iscas.ac.cn,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3IiEAytFo4q9rLeQEn1nPw/RZCpu7nmJdoClGuoMlKGgmnhyQFJ
 4WFooQQEPKZoBMpAaM//nVZ0iPhps7Zt9EYptofn2y0ll9d6bJ86jN3XMgEaDD1eXIvro+n
 F/yCOl0djN2l5GcwLKKx6VQG6s1+pIeQtIY0FdGbVnW16tPHK0uB0iQHt54tRG3w5nVNIfV
 iGDeuG5erI2w36gpucV4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ujcJA7FV+9w=:s/8zzZ61oUoEKXwNiH+7Nv
 eq9Zf6rw7EXiO6BZ0NFXbgDZoln3Tlhnh5cOU2vO7t8Z2BJqBHo/VYMVrRVrh1MIKoSP9wsoN
 xV7hvHb4HBATUG7UoMMTBqki7hWVIDYpA00fHk8Ai0T2wp2xEz5b4Jc3zhSJv9QSpizknsgti
 oBlWHhKbcj4fsSsQSOg6zsJyQd6UB7u62jCicrXhHYF1iWggihoyYNnHeLWbOqPop3isPrrAv
 R8O1w6nHCnL5Qr2UU31MpV9B+LHRgbcWhy/U0b3AG6vtpguGAPI5z7N0N3+BjO7HAiblJyugP
 VqSvRf1fb97/qO4ctDdwjn7+HrBRIU6RUs0lFangW8xoOVCdonDgYfMVO1G93ULdtVPpErZHw
 //67HDZGQmvLO4TIbWJTmH6ix0qF6B0M5yfrpfQNBG/o+1WINGXUR12OR/qBB9NjpF6dza3G/
 xkr78AOfQKIQpa5tWxSfumVSAPswsztbR9+pRhEDeUp700xY+JGDQUnzWGdBNDfIf/5uS8r0P
 PmJtubdo7Av3+yD39vHtpISh7u0EuuPc679pDluS+e1N6mGtR1MzPKMIdJjXt47k9tv33fnl3
 eeNivbVgUdlgVoLi+SXWenFhvg3nQpCmS1Vto737wR8NJXIydH6+sroGFQJCrH8xqmzQZISjw
 b8AabD72xQhBSbAATuM3h7jb08PFW7AUEynDOqjfM9UEmMH6xE9MjdZ+0Cu7/A9FMw4RbSAlB
 qwZ5Yse0IFEBw7LNqwkqCoC/HQXcv3UoDWwzr0Uj9xEbsa9Gimuw3Xqp9OQlBvDQvXoOG9Ptw
 reXDePfwAAAWZp7HWIkh3gTRao7hM9ZHB9J5JoqwXETO7AIGZM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Implement compat_syscall_table.c with compat_sys_call_table & fixup
> system call such as truncate64,pread64,fallocate which need two
> regs to indicate 64bit-arg (copied from arm64).
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/include/asm/syscall.h         |  3 +
>  arch/riscv/kernel/compat_syscall_table.c | 84 ++++++++++++++++++++++++

Same here, I think most of these should go next to the actual syscalls, with the
duplicates removed from other platforms,

> +#define __SYSCALL_COMPAT
> +#undef __LP64__

What is the #undef for?

> +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
> +       unsigned long, prot, unsigned long, flags,
> +       unsigned long, fd, unsigned long, offset)
> +{
> +       if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
> +               if (unlikely(!(prot & PROT_READ)))
> +                       return -EINVAL;
> +
> +       return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset);
> +}

This is one that we may have to deal with separately, introducing
sys_mmap_pgoff() was a mistake in my opinion, and we should just have
added a sys_mmap2() for all architectures that don't explicitly override it.

       Arnd
