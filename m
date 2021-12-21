Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3947C4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhLURJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:09:04 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:56623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhLURJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:09:03 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N9MlI-1mNU532i1M-015LUp; Tue, 21 Dec 2021 18:09:01 +0100
Received: by mail-wm1-f50.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2533605wmc.2;
        Tue, 21 Dec 2021 09:09:01 -0800 (PST)
X-Gm-Message-State: AOAM530Hwj5g8Jfo9VAzuFhMYheKgBK1Gla3m7Jww+rMb8JjoKGcMwXr
        AJ8Zjw5P479CLw/sCYhAffEQ+ZONKLXuxDe+v+s=
X-Google-Smtp-Source: ABdhPJwBjfG8n5UL3gUcPzQHQGqJD8jdtXydpXBiVw9zz8vMTxK4PxCyGzOYKywQHcSPDIX78gSsHjw/vuP33ZnB2VQ=
X-Received: by 2002:a1c:8013:: with SMTP id b19mr3463956wmd.35.1640106541291;
 Tue, 21 Dec 2021 09:09:01 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-2-guoren@kernel.org>
In-Reply-To: <20211221163532.2636028-2-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 18:08:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1fC8aro3kHLvGMVDdvVYjaQdxJeGur9ac=11+6=r0Xyg@mail.gmail.com>
Message-ID: <CAK8P3a1fC8aro3kHLvGMVDdvVYjaQdxJeGur9ac=11+6=r0Xyg@mail.gmail.com>
Subject: Re: [PATCH 01/13] syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
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
X-Provags-ID: V03:K1:lTFpZ6pDtY49FZfxsjv/cLPpAW+MEwn+/ySvxxlZ/8woKiBQs9L
 YHiLTryYHpjpdbqT0cN7PSsA/BILDtL0sIOaRmiNH9jDJTTKZUFhc/Q7paOsMt4zdyQKtmj
 pF3kkhg13dVPOI6lLMDYuDsxhZHg6MBWKrSs7hz+9s658rUR4kMAOdOgzHk9OMtc+7ETOR5
 anCf30yrsL6OzVd8KjMag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jkHcHPAbZI8=:mpAlvJgX+UoHr92Qp5XNYB
 M24/x2JwzmogjmbnnVL5/giWDUkbSRNddd7V86Y2JC8Wq4BT0fN9yfBfHkAKbakl5tXmjv6Gr
 IG2Ms3fWQ4bNvFTOp0sWumofFCMSxihU2WOM0n89shW381scOC43e1GimWGFpK/XEs6Mm2x/T
 5MWTOhI4/lIPissEzjnYus1PE4GLsUfSOeDDuxwgIzKAqf/h4p5sOz/L3kvMdQ/pBq3vM5kFA
 8rOAHro2bEr4DnMOaz+UHb3wNU0Fr5xUTz1yptEFQCN8DKIEKKv44Y4KV4PtV7A7bqyf5T48c
 Hk7d9dAFUJcUYTImCQma4rS1Ut9jjw2+RYTpDp1wbp3ilJncfkrORyaovfQXsBIaklWlV+UqM
 91Qeiuao5ZlTu6azAQSxDyoxcxJ5P5azRZ6cwMzzxP55XRg5GwViq4SOvCV5iATkN/AYEmiQd
 p0Q15sfrTEt353OJN0EMCMcydvEQcE8DUqMZzcJgQamwp3nOxtpxaif/VI+jRnj+859kuV5lA
 kxvh4Pvn+oDQ8CRVWWUtFaKZEM34c2IdJEOcwIEHkVX99h2yRyRfb7c7H8AyjrcUjRaonOHCF
 qe4+LfRSEDIAaVu0EnirBcoCgbEdD97Cetn/Xuw/nc8QCFlAPsO1tWh/qjAKALreOamSK32/b
 M2qxewK+FxRjjknah3S0IkywKdS1qoJZTddZMr+EVS41+D3wOghXuNDN0fgryXFw/Yo/2/5Bl
 WvDG6AyO3I++d1DE3MqdIHgaXtrtD9zw2gzqqNvMLy0LIgFl0zGyN5JYqHgbhnGrb5gF7aG9y
 DmSTVsLWXMarEvZ6Nn+jIPX1H56dsBCDnGI96NOZNJNh6aOrBo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 4557a8b6086f..aafe5cfeb27c 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -383,7 +383,7 @@ __SYSCALL(__NR_syslog, sys_syslog)
>
>  /* kernel/ptrace.c */
>  #define __NR_ptrace 117
> -__SYSCALL(__NR_ptrace, sys_ptrace)
> +__SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
>

Right. We could merge sys_ptrace and compat_sys_ptrace() by adding
a in_compat_syscall() check, but either way works.

>  /* kernel/sched/core.c */
>  #define __NR_sched_setparam 118
> @@ -779,7 +779,7 @@ __SYSCALL(__NR_rseq, sys_rseq)
>  #define __NR_kexec_file_load 294
>  __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
>  /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
> -#if __BITS_PER_LONG == 32
> +#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
>  #define __NR_clock_gettime64 403
>  __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)

This part looks wrong, you expose clock_gettime64 to user space this way, both
in asm/unistd.h and in the table.

         Arnd
