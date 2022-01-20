Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D064F495077
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345928AbiATOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:43:06 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:32999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345740AbiATOnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:43:03 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N94FT-1mGkex1bh1-0164IJ; Thu, 20 Jan 2022 15:43:00 +0100
Received: by mail-oi1-f178.google.com with SMTP id e81so9165229oia.6;
        Thu, 20 Jan 2022 06:42:59 -0800 (PST)
X-Gm-Message-State: AOAM532fTQeZvdseBVNpP7JhI7X4GUoHSyhpLrOibn821AnyycWSbVfG
        7gdcN6oRoZQACfzl55Dx6kZhpqevXG0Q2Pv9cWo=
X-Google-Smtp-Source: ABdhPJx7CtRumP0QQYfXweJthBATxPSWS8llRiPfBtrUDHNd5XtCBWTkqgRw8si0X+m1xq787CRD7WnkdtRMWwwXsuo=
X-Received: by 2002:a05:6808:1490:: with SMTP id e16mr7781849oiw.84.1642689778452;
 Thu, 20 Jan 2022 06:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-9-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-9-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 15:42:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0LxB3we9wHOa4OPmNow6wz5NP49zeYhh7QXNv-MiR8UA@mail.gmail.com>
Message-ID: <CAK8P3a0LxB3we9wHOa4OPmNow6wz5NP49zeYhh7QXNv-MiR8UA@mail.gmail.com>
Subject: Re: [PATCH V3 08/17] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
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
X-Provags-ID: V03:K1:KOZKKo+WIJ1Y1zAPI6JeyCqeUpeTH9yVVag9YtkkrptSaffd3Hm
 p/3BvUygj4t2gs30sYZIJBjkyQAFHcPP6vZXD2vVfJqsszWM8hAv3PLyyYPUvURfxaGPzP+
 E8ck/3z6XRRBr7GqEd1raIUC6qFVnOkWbmRKKrwDEXBzP5rig2QA81gfrlG0smBz4mMjoyR
 44YTYZeBiLcgbab50Hn1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mcn8p1yf5TA=:KXPyAAJ49Kconojf7p5XMu
 2m0vIrZiPbqBK9AFU33jpY8G+65O57LOHHfnmLfG0s2Qlw7Ohj6zM9eGSw9B0qzxntRlTsw4B
 9Kxed0sow5Jf+zi8nWx7404wq+0RNh5itNVlRNPTxPUlMEM+37DfaBY2pyO9SJlVz49ziijgK
 zEK1zGkB13W2/JMwflFyhKNam0Al2k0G40SsPAH2qnOKHm/wXNr+7dTIJ2+8IoxRhqBL1qwFG
 ySTKH0T90DTf/5und6cZTCniDgcZxzLTddMPK4XtjVohaSZXPaRTagr3lqIEI1Y3aJuzeCVkJ
 kXqHlYKCrSIZNOP8TVUj7qoYTiO5wzrhzHmUS6b2XSWxFbVfqN5poQYWAn+ufpyWorCMmhNhq
 tUZBvUhqzd5xfrcTGNm4vAyh10ApKsmDEXGEYzdJBUodHOluUVAvx1pFj/4XdRD4qFGt/+NRQ
 9eLx+/dMZHfIXG6DRNzL6D8vm6KRY84=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
>
>  /* The array of function pointers for syscalls. */
>  extern void * const sys_call_table[];
> +#ifdef CONFIG_COMPAT
> +extern void * const compat_sys_call_table[];
> +#endif

No need for the #ifdef, the normal convention is to just define the
extern declaration unconditionally for symbols that may or may not be defined.

> +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, pathname,
> +                      arg_u32p(length))
> +{
> +       return ksys_truncate(pathname, arg_u64(length));
> +}

Are you sure these are the right calling conventions? According to [1],
I think the 64-bit argument should be in an aligned pair of registers,
which means you need an extra pad argument as in the arm64 version
of these functions. Same for ftruncate64, pread64, pwrite64, and
readahead.

> +COMPAT_SYSCALL_DEFINE3(ftruncate64, unsigned int, fd, arg_u32p(length))
> +{
> +       return ksys_ftruncate(fd, arg_u64(length));
> +}
> +
> +COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode,
> +                      arg_u32p(offset), arg_u32p(len))
> +{
> +       return ksys_fallocate(fd, mode, arg_u64(offset), arg_u64(len));
> +}
> +
> +COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, buf,
> +                      size_t, count, arg_u32p(pos))
> +{
> +       return ksys_pread64(fd, buf, count, arg_u64(pos));
> +}
> +
> +COMPAT_SYSCALL_DEFINE5(pwrite64, unsigned int, fd,
> +                      const char __user *, buf, size_t, count, arg_u32p(pos))
> +{
> +       return ksys_pwrite64(fd, buf, count, arg_u64(pos));
> +}
> +
> +COMPAT_SYSCALL_DEFINE6(sync_file_range, int, fd, arg_u32p(offset),
> +                      arg_u32p(nbytes), unsigned int, flags)
> +{
> +       return ksys_sync_file_range(fd, arg_u64(offset), arg_u64(nbytes),
> +                                   flags);
> +}
> +
> +COMPAT_SYSCALL_DEFINE4(readahead, int, fd, arg_u32p(offset),
> +                      size_t, count)
> +{
> +       return ksys_readahead(fd, arg_u64(offset), count);
> +}
> +
> +COMPAT_SYSCALL_DEFINE6(fadvise64_64, int, fd, int, advice, arg_u32p(offset),
> +                      arg_u32p(len))
> +{
> +       return ksys_fadvise64_64(fd, arg_u64(offset), arg_u64(len), advice);
> +}

I still feel like these should be the common implementations next to the
native handlers inside of an #ifdef CONFIG_COMPAT.

The names clash with the custom versions defined for powerpc and sparc,
but the duplicates look compatible if you can account for the padded
argument and the lo/hi order of the pairs, so could just be removed here
(all other architectures use custom function names instead).

        Arnd

[1] https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf
