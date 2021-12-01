Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02385464F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhLAN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhLAN7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:59:19 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A28CC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:55:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w1so102300343edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSt3Unx0/Qaq0FKjSY7ns1ciES5Q464PSLz6H6FDGfQ=;
        b=gJ/UlzgyMQ2McJ7WN/9L0KBubFxWZVI4CASZkdqyA3frk7WdXC1wKI+g6w9Jnw7C+0
         f46wilN0nuOdKGOl0XPMug2Uan5MCuBvnFpU+kdVo7yikHIwcEGNegiFPhbYFUkOW7F0
         DdPyI2zHgvTfyFguFpf95neo67oC16a1NwxkC2mGWIur+j/zY3SMFO3ZwemyaOpuUnoo
         /PYnQ3ZXbdK6ma4R+TMx/UIPB+x1txZSSjR5Romg9zn5aTsSJrMX/1m3W2RWjexd4/an
         VCUkNWY1pTyWzH6UFic8uxachWdyRecVsWTJM/DLfH7sGKC0ePbW8JDWBLGWbyvAV/E+
         2jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSt3Unx0/Qaq0FKjSY7ns1ciES5Q464PSLz6H6FDGfQ=;
        b=XMv1W+6Nx/DiIxpmUZcK4Jk20huMXJcYvH0Z6F5fXAfRdvrSSL8dWrgRwYI9xI7slr
         SlqNWl02t0d9hsGMhuVI0WDfsb0DaD3b3lgUTclZbBg1i/sPoHLszxv9DN10Q394S2M7
         leqjAD51GRFFinE6/y4LYP1jlDRpGrrVRv7d8TT7D/KHNDpSqT1l8haqdl1oVA9UkM2I
         lh+4Lx7ZBnbofmhkxMpyKyz81jGv45Qko6jWVXstWJI4poZjJe89Ml882oRXM3/IsnEA
         /FcdTBsMV0JC4ML0kYeUBhaC1vp8l+79kUNHVE0pqnDCgUwvNQ8MSOzY6P1SA+rs46J+
         ZVxA==
X-Gm-Message-State: AOAM531aOw2Y+k+mlquf4zQrcBsNfbhlS5S3sh/4HVp8Q7ccqF3LxY4Z
        Q/GqGV1rmcacXj+M3dIwBskrrp8H4KggA2A8cT1IVg==
X-Google-Smtp-Source: ABdhPJwclv1vk+2ywUTPu0BpiV0wKbr52GqiTSYyY7qZKtTqCd2OmYjoujCv6mvjVoTJUS6dVMzInXlDQmxk7Gis7YA=
X-Received: by 2002:a17:906:2b12:: with SMTP id a18mr7290462ejg.254.1638366956867;
 Wed, 01 Dec 2021 05:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-4-pasha.tatashin@soleen.com> <f81a6434-9f38-947e-02a8-9a9191285e52@kernel.org>
 <cadf2582-3004-92b9-ab5a-cb39259fa36c@kernel.org>
In-Reply-To: <cadf2582-3004-92b9-ab5a-cb39259fa36c@kernel.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 1 Dec 2021 08:55:21 -0500
Message-ID: <CA+CK2bBfcrxDyxnV+xc680AP+sJGHSpong6a+b_vvWcRsB2CcA@mail.gmail.com>
Subject: Re: [PATCH 3/3] x86: mm: add x86_64 support for page table check
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 3:44 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 01. 12. 21, 9:00, Jiri Slaby wrote:
> > On 23. 11. 21, 22:48, Pasha Tatashin wrote:
> >> Add page table check hooks into routines that modify user page tables.
> >
> > Hi,
> >
> > I bisected to this as this causes crashes during modules load:
>
> And it's not enough to unset CONFIG_PAGE_TABLE_CHECK_ENFORCED. I had to
> unset CONFIG_PAGE_TABLE_CHECK completely to get rid of this.

Hi,

Thanks for reporting this. Seems like module load for some reasons
does not like the static branches. However, I was not able to repro
this. Could you please share your config and the module that you were
loading?

Thank you,
Pasha

>
> > #PF: supervisor write access in kernel mode
> > #PF: error_code(0x0003) - permissions violation
> > PGD 6d615067 P4D 6d615067 PUD 6d616063 PMD 800000006d2001e1
> > Oops: 0003 [#1] PREEMPT SMP PTI
> > CPU: 0 PID: 6189 Comm: modprobe Kdump: loaded Tainted: G          I E
> > 5.16.0-rc2-next-20211129-vanilla #3
> > 83846a405f0e3937f5c8dfbc7d449622b8f46369
> > Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be
> > filled by O.E.M., BIOS SDBLI944.86P 05/08/2007
> > RIP: 0010:jump_label_module_notify (kernel/jump_label.c:370
> > kernel/jump_label.c:670 kernel/jump_label.c:748)
> > Code: 00 48 8b 43 08 a8 02 0f 85 e9 00 00 00 48 83 e0 fc 48 c7 02 00 00
> > 00 00 48 89 42 08 48 8b 43 08 83 e0 03 48 09 c2 48 83 ca 02 <48> 89 53
> > 08 4d 89 66 10 49 89 6e 08 48 8b 43 08 a8 02 0f 84 98 00
> > All code
> > ========
> >     0:    00 48 8b                 add    %cl,-0x75(%rax)
> >     3:    43 08 a8 02 0f 85 e9     rex.XB or %bpl,-0x167af0fe(%r8)
> >     a:    00 00                    add    %al,(%rax)
> >     c:    00 48 83                 add    %cl,-0x7d(%rax)
> >     f:    e0 fc                    loopne 0xd
> >    11:    48 c7 02 00 00 00 00     movq   $0x0,(%rdx)
> >    18:    48 89 42 08              mov    %rax,0x8(%rdx)
> >    1c:    48 8b 43 08              mov    0x8(%rbx),%rax
> >    20:    83 e0 03                 and    $0x3,%eax
> >    23:    48 09 c2                 or     %rax,%rdx
> >    26:    48 83 ca 02              or     $0x2,%rdx
> >    2a:*    48 89 53 08              mov    %rdx,0x8(%rbx)        <--
> > trapping instruction
> >    2e:    4d 89 66 10              mov    %r12,0x10(%r14)
> >    32:    49 89 6e 08              mov    %rbp,0x8(%r14)
> >    36:    48 8b 43 08              mov    0x8(%rbx),%rax
> >    3a:    a8 02                    test   $0x2,%al
> >    3c:    0f                       .byte 0xf
> >    3d:    84                       .byte 0x84
> >    3e:    98                       cwtl
> >      ...
> >
> > Code starting with the faulting instruction
> > ===========================================
> >     0:    48 89 53 08              mov    %rdx,0x8(%rbx)
> >     4:    4d 89 66 10              mov    %r12,0x10(%r14)
> >     8:    49 89 6e 08              mov    %rbp,0x8(%r14)
> >     c:    48 8b 43 08              mov    0x8(%rbx),%rax
> >    10:    a8 02                    test   $0x2,%al
> >    12:    0f                       .byte 0xf
> >    13:    84                       .byte 0x84
> >    14:    98                       cwtl
> >      ...
> > RSP: 0018:ffffaf4dc051fbe8 EFLAGS: 00010282
> > RAX: 0000000000000001 RBX: ffffffff931ee760 RCX: 0000000000000001
> > RDX: ffff9d1aa7d43883 RSI: ffffffff91c50aa0 RDI: ffffffff931ee760
> > RBP: ffffffffc0782000 R08: 0000000000000020 R09: 0000000000000000
> > R10: ffff9d1aa7d43880 R11: 0000000000000000 R12: ffffffffc079a980
> > R13: ffffffffc0784080 R14: ffff9d1aa7d43ca0 R15: ffffffffc0782008
> > FS:  00007f87104b8740(0000) GS:ffff9d1b45c00000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffffff931ee768 CR3: 000000010fdce000 CR4: 00000000000006f0
> > Call Trace:
> >   <TASK>
> > blocking_notifier_call_chain_robust (kernel/notifier.c:83
> > kernel/notifier.c:118 kernel/notifier.c:283 kernel/notifier.c:271)
> > load_module (./include/linux/notifier.h:198 kernel/module.c:3923
> > kernel/module.c:4100)
> > __do_sys_finit_module (kernel/module.c:4224)
> > do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> > entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113)
> >
> >> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >> ---
> >>   arch/x86/Kconfig               |  1 +
> >>   arch/x86/include/asm/pgtable.h | 29 +++++++++++++++++++++++++++--
> >>   2 files changed, 28 insertions(+), 2 deletions(-)
> >>
> >
> > regards,
>
>
> --
> js
> suse labs
