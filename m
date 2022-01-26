Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261BA49C9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiAZMaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiAZMaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:30:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:30:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id j2so38360035ejk.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWKRFkvZ55inOHnSf7zADffeB6ypzfUfeoAKvj/oux0=;
        b=U0xg2tfrOgzFypjSxpYMxsfzCOYJ6LHF2SQsj1AlSNodgJvXlzuKkOeGerA//HGVu6
         sUHwj4lyomswHDgq8vTUo2TjPOPvkqJo4H6sjhMvAXc+cxW/xsR8J7AVMnWVTHBrtTH7
         j7TmbDgxvVwT9h80nRim5XqXjxwKP1sC0VIoXxRULq08R61/XKc/hBVyEa/IaLgz5p5c
         kekPBqLfmcLzviXARk+koz6k6ALUpMiQJL9tfeAA+gBl6oNG5w33y17OiYTcMbT4wS22
         gig7YBpavEGKMxCPDk8enccxF4y4zukDmL0I9mplYJm/EcPf2DCwiw16iV5xouZeJD5k
         dDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWKRFkvZ55inOHnSf7zADffeB6ypzfUfeoAKvj/oux0=;
        b=CDIwMOcfISCsTq4j9hWgIemLVtGtk/CKSq3fxNsEluRHMbhAsZ95etF/JxGPIioy3A
         8mX5MDGdw7gmxQzhTD+kbM3gqOnbFh/ITLLcOvZ1WcfgBRqjN8TB9EuBUUIxWIZ9Im8m
         pzCXXMPKuG6A8NAQpV8GBm0UiW1meLePgOmhVdSaYZijOtv0FF8bopEOwhpxJWYPdENT
         rH8YXiJjir7hkIz3E1Bi+3kthUqjhP4Csg3j7gIBgf1/kEQh8UZ/aDj9HRN1MeHDiFyP
         4wkFwroTI9Rb6kZuRoY6iU2G1oiYlpMAXmWx2XZc5ztOezwDvET9sAIzHojAJyAsbwtd
         aoiw==
X-Gm-Message-State: AOAM530iTT7lC5QqWZiFzrC9jyxvq7OUm0mpyb0xWU4BKBOf77vuu99l
        LiOWg+eEtCSsC6qswqGCCmDG2axYPtjh5WOIY5K9nQ==
X-Google-Smtp-Source: ABdhPJx2FiQBp/3TLUEdl4bheNgwa0FyfkRHJn5QGUAo873W5QWdCQ+kOT1RkR2JryxR0seGRnMl9Q/c5DQPLRrM4LY=
X-Received: by 2002:a17:906:3004:: with SMTP id 4mr19163688ejz.579.1643200217727;
 Wed, 26 Jan 2022 04:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20220126065751.GA23867@xsang-OptiPlex-9020>
In-Reply-To: <20220126065751.GA23867@xsang-OptiPlex-9020>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 26 Jan 2022 07:29:41 -0500
Message-ID: <CA+CK2bAG73VdzbUP4RS83TtsGmYDqBw=VXboMyaPta4NgrpciA@mail.gmail.com>
Subject: Re: [x86] 17cd1a8149: kernel_BUG_at_mm/page_table_check.c
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 1:58 AM kernel test robot <oliver.sang@intel.com> wrote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 17cd1a8149994ce2c0f49abbed2196626cb51011 ("x86: mm: add x86_64 support for page table check")
> url: https://github.com/0day-ci/linux/commits/Yang-Li/net-phy-micrel-use-min-macro-instead-of-doing-it-manually/20211224-171618
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +------------------------------------------+------------+------------+
> |                                          | a26c01367c | 17cd1a8149 |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 48         | 0          |
> | boot_failures                            | 0          | 48         |
> | kernel_BUG_at_mm/page_table_check.c      | 0          | 48         |
> | invalid_opcode:#[##]                     | 0          | 48         |
> | RIP:__page_table_check_zero              | 0          | 48         |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 48         |
> +------------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> [    9.414679][    T1] kernel BUG at mm/page_table_check.c:162!
> [    9.415511][    T1] invalid opcode: 0000 [#1] SMP
> [    9.416217][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc6-00149-g17cd1a814999 #1 145cbc68045d824db2e83a3e2291f7c16a59376c
> [    9.417858][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [ 9.419117][ T1] RIP: 0010:__page_table_check_zero (mm/page_table_check.c:162 (discriminator 1))
> [ 9.419966][ T1] Code: 03 2d e6 ab 97 01 41 83 c4 01 41 83 fd 1f 0f 87 f8 f9 9c 00 45 39 e6 7f 9b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 0b <0f> 0b 0f 0b cc cc cc cc cc cc 48 8b 07 48 89 06 31 c0 c3 0f 1f 80
> All code
> ========
>    0:   03 2d e6 ab 97 01       add    0x197abe6(%rip),%ebp        # 0x197abec
>    6:   41 83 c4 01             add    $0x1,%r12d
>    a:   41 83 fd 1f             cmp    $0x1f,%r13d
>    e:   0f 87 f8 f9 9c 00       ja     0x9cfa0c
>   14:   45 39 e6                cmp    %r12d,%r14d
>   17:   7f 9b                   jg     0xffffffffffffffb4
>   19:   48 83 c4 08             add    $0x8,%rsp
>   1d:   5b                      pop    %rbx
>   1e:   5d                      pop    %rbp
>   1f:   41 5c                   pop    %r12
>   21:   41 5d                   pop    %r13
>   23:   41 5e                   pop    %r14
>   25:   41 5f                   pop    %r15
>   27:   c3                      retq
>   28:   0f 0b                   ud2
>   2a:*  0f 0b                   ud2             <-- trapping instruction
>   2c:   0f 0b                   ud2
>   2e:   cc                      int3
>   2f:   cc                      int3
>   30:   cc                      int3
>   31:   cc                      int3
>   32:   cc                      int3
>   33:   cc                      int3
>   34:   48 8b 07                mov    (%rdi),%rax
>   37:   48 89 06                mov    %rax,(%rsi)
>   3a:   31 c0                   xor    %eax,%eax
>   3c:   c3                      retq
>   3d:   0f                      .byte 0xf
>   3e:   1f                      (bad)
>   3f:   80                      .byte 0x80
>
> Code starting with the faulting instruction
> ===========================================
>    0:   0f 0b                   ud2
>    2:   0f 0b                   ud2
>    4:   cc                      int3
>    5:   cc                      int3
>    6:   cc                      int3
>    7:   cc                      int3
>    8:   cc                      int3
>    9:   cc                      int3
>    a:   48 8b 07                mov    (%rdi),%rax
>    d:   48 89 06                mov    %rax,(%rsi)
>   10:   31 c0                   xor    %eax,%eax
>   12:   c3                      retq
>   13:   0f                      .byte 0xf
>   14:   1f                      (bad)
>   15:   80                      .byte 0x80
> [    9.422517][    T1] RSP: 0000:ffffc9000022bce0 EFLAGS: 00010202
> [    9.423342][    T1] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [    9.424457][    T1] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff82ebedc8
> [    9.425596][    T1] RBP: ffff888101819790 R08: 0000000000000000 R09: 000000000004007e
> [    9.426731][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [    9.427859][    T1] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> [    9.429002][    T1] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
> [    9.430271][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.431156][    T1] CR2: 00000000ffc6c3db CR3: 0000000002861000 CR4: 00000000000406f0
> [    9.432278][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    9.433406][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    9.434514][    T1] Call Trace:
> [    9.435019][    T1]  <TASK>
> [ 9.435489][ T1] free_pcp_prepare (include/linux/page_table_check.h:43 mm/page_alloc.c:1351 mm/page_alloc.c:1424)
> [ 9.436171][ T1] ? lock_is_held_type (kernel/locking/lockdep.c:5380 kernel/locking/lockdep.c:5680)
> [ 9.436873][ T1] free_unref_page (mm/page_alloc.c:3323 mm/page_alloc.c:3402)
> [ 9.437558][ T1] destroy_args (mm/debug_vm_pgtable.c:1046)
> [ 9.438202][ T1] debug_vm_pgtable (mm/debug_vm_pgtable.c:1332)
> [ 9.438902][ T1] ? init_args (mm/debug_vm_pgtable.c:1238)

This problem is fixed by this patch:
https://lore.kernel.org/all/20220126060514.1574935-2-pasha.tatashin@soleen.com
