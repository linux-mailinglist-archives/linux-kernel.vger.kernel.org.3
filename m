Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2CD47D0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbhLVLQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:16:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57228 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhLVLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:16:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFAB7B81BBF;
        Wed, 22 Dec 2021 11:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4C3C36AF3;
        Wed, 22 Dec 2021 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640171782;
        bh=9c47US/IBTSpcaTa6A9sohSlsGJgoac4lsSRerkjTaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rAwOapawARY4124h9997jUAYZGl8ZbZ6EIHFd5ga3NKlP1QtUijfWLS1Sb0BbnbD1
         skkzKp4Rs1OB7RkijJR2y8I+rPE2bSfmQZ0XYD936tCfGUqWr7jmkjBkeD/KTdtPGo
         yjNWFqu2wdYZmDF81jgndPbY9JZgH6OsOnDbuAtpXeoo+AU+s1TFjZ+M3q698sknmS
         KrNBv1vAAfGvWSENhuHjsk+4NRDR1DB9SAXYEqJWY+zxR6U9lW2QRlI0tAJ7QKRFka
         JabKFDuThabc7+jtrrDLtw/NdUbdPY1DWWL5BCCz6Ltzkg/ANsIl0ENM4TFeX5yKiP
         hoIMWD5uzs3UQ==
Received: by mail-vk1-f174.google.com with SMTP id s1so1082751vks.9;
        Wed, 22 Dec 2021 03:16:22 -0800 (PST)
X-Gm-Message-State: AOAM5323tCH7VbST4JAXE3MYknY0dezf5//TPjI7hV798NBSDog7qd+e
        oHb5WaNfCrdRXgQN6qbzO3SUtExeClhGcfMeO0g=
X-Google-Smtp-Source: ABdhPJxj1PzhyTI98cL1Srb70bXWLzUyQMiVzIdGh0LdKJMqyS7sLEVMCA+fdiZdr9wtUMSXc7/oy/tQPd/D8KKPRhU=
X-Received: by 2002:a1f:ae91:: with SMTP id x139mr867231vke.2.1640171781375;
 Wed, 22 Dec 2021 03:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-2-guoren@kernel.org>
 <CAK8P3a1fC8aro3kHLvGMVDdvVYjaQdxJeGur9ac=11+6=r0Xyg@mail.gmail.com>
In-Reply-To: <CAK8P3a1fC8aro3kHLvGMVDdvVYjaQdxJeGur9ac=11+6=r0Xyg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Dec 2021 19:16:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQciNaXk+_am=kS2uSwg6oGM4aJqiw_O5KN-DrHetf8nA@mail.gmail.com>
Message-ID: <CAJF2gTQciNaXk+_am=kS2uSwg6oGM4aJqiw_O5KN-DrHetf8nA@mail.gmail.com>
Subject: Re: [PATCH 01/13] syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
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

On Wed, Dec 22, 2021 at 1:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 4557a8b6086f..aafe5cfeb27c 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -383,7 +383,7 @@ __SYSCALL(__NR_syslog, sys_syslog)
> >
> >  /* kernel/ptrace.c */
> >  #define __NR_ptrace 117
> > -__SYSCALL(__NR_ptrace, sys_ptrace)
> > +__SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
> >
>
> Right. We could merge sys_ptrace and compat_sys_ptrace() by adding
> a in_compat_syscall() check, but either way works.
>
> >  /* kernel/sched/core.c */
> >  #define __NR_sched_setparam 118
> > @@ -779,7 +779,7 @@ __SYSCALL(__NR_rseq, sys_rseq)
> >  #define __NR_kexec_file_load 294
> >  __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
> >  /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
> > -#if __BITS_PER_LONG == 32
> > +#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
> >  #define __NR_clock_gettime64 403
> >  __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
>
> This part looks wrong, you expose clock_gettime64 to user space this way, both
> in asm/unistd.h and in the table.
>
>          Arnd

No, we only define __SYSCALL_COMPAT in compat_syscall_table.c. It
won't be expose to user space, because there is no __SYSCALL_COMPAT.

$ grep __SYSCALL_COMPAT * -r
arch/riscv/kernel/compat_syscall_table.c:#define __SYSCALL_COMPAT
                           ^^^^^^^^^^^^^^^^^^^^^^
include/uapi/asm-generic/unistd.h:#if __BITS_PER_LONG == 32 ||
defined(__SYSCALL_COMPAT)
include/uapi/asm-generic/unistd.h:#ifdef __SYSCALL_COMPAT
include/uapi/asm-generic/unistd.h:#if defined(__SYSCALL_COMPAT) ||
__BITS_PER_LONG == 32
include/uapi/asm-generic/unistd.h:#if __BITS_PER_LONG == 64 &&
!defined(__SYSCALL_COMPAT)
tools/include/uapi/asm-generic/unistd.h:#if __BITS_PER_LONG == 32 ||
defined(__SYSCALL_COMPAT)
tools/include/uapi/asm-generic/unistd.h:#ifdef __SYSCALL_COMPAT
tools/include/uapi/asm-generic/unistd.h:#if defined(__SYSCALL_COMPAT)
|| __BITS_PER_LONG == 32
tools/include/uapi/asm-generic/unistd.h:#if __BITS_PER_LONG == 64 &&
!defined(__SYSCALL_COMPAT)

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
