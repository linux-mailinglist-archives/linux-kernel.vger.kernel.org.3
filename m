Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6B4E64E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347684AbiCXOSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236272AbiCXOS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:18:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F12985B1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:16:54 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w127so4994172oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IwhRmQLD4pp4REKGSz+HZGQaSrUkXBhHYyruYo/qME=;
        b=ENyBI7OHrQ9U1iGH+RFRx4UF+zqisNu3doWA8azwBOYOu3TtAGgBzzB4sXSOK2rTcV
         UewH9o32bIcY3EYoxmDeKl0ESim0eDlKgk35w9KUsPPYIiLqkvTx0C73zmO52gvWYIVg
         9Dg67nyKuYVldVU5tHrxReAXwJ//p0tEg2SGend/NoFPNO2YxKVrzJ35ojxZYYQRvUsa
         LEdn2mSbuBcjbV090AT+oynrbfNjp9w/J1KnAmDztakJT6QWYysSZdw4VHxpvDjyP1iW
         Ky2RXmnVcKuh9NGZlqjS28cuGvFZG5kfsWJGIWmCdc1kS+UoIgrU1gb4hpRnzE5lWQP+
         MXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IwhRmQLD4pp4REKGSz+HZGQaSrUkXBhHYyruYo/qME=;
        b=UkUaNLMnx7ST6Mx7hWnzSgW3Z9xoPJDxSJVM/zAz5HeX7tmgjuq+bMqoCg3PJHxtGk
         /kaQevGVD/Ie9wDJbTZag84xThFWUaKUZWs3ytpT5gn2FvsAjMCemKiMZKy4cBRG4WH/
         RWBEiE0NLHbFN/V3Csq69HIEr8l8ybLepXab9pxgwGDaGZRW44IBOqyUHu55L60dVI3M
         ft2RP7zS3X43120EdEdJDU801enAUmF08j5DgmSPRdoGZ5gBAl9dK62eVVs/Hk798T+0
         WucyWzTgUh+hoUtONB/VIUPO+Iqd3QFuj+TGehVpzCkeXZTXQ0HzaxhJPyI7WDD9UmmG
         xJyg==
X-Gm-Message-State: AOAM531LqZY/d2Qo5X7x8TDXUL/LsZokBVKvvw2c4AIM/Yw+lNTOQ12/
        AzYDVFI3eA5o05E01OMGAYyYrwsmFS8/DEJUYNwegw==
X-Google-Smtp-Source: ABdhPJw4KMNpkELCzWuWWIZqap4aNQL9WmccQBs/OANy5gYAA71/5r+3JUclC7+zoNhjg/9kJrvMPTk5XJL0sbCLsQI=
X-Received: by 2002:a05:6808:16a4:b0:2f7:1fd1:f48 with SMTP id
 bb36-20020a05680816a400b002f71fd10f48mr1156736oib.163.1648131413996; Thu, 24
 Mar 2022 07:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000644f1a05daf71983@google.com>
In-Reply-To: <000000000000644f1a05daf71983@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Mar 2022 15:16:42 +0100
Message-ID: <CACT4Y+bSazxGmb=F4ouAEK+N=fTrwTpZHasPo2i_E6eqRPfAzg@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in do_user_addr_fault (3)
To:     syzbot <syzbot+6684a9d1b4d61d0b8f3e@syzkaller.appspotmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     akpm@linux-foundation.org, elver@google.com, glider@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 at 14:48, syzbot
<syzbot+6684a9d1b4d61d0b8f3e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    724946410067 x86: kmsan: enable KMSAN builds for x86
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=1734f916700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=76f99026248b24e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=6684a9d1b4d61d0b8f3e
> compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b1cbf2700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131d38a6700000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6684a9d1b4d61d0b8f3e@syzkaller.appspotmail.com

+linux-riscv as there are some riscv bugs bucketed here as well:

BUG: KASAN: slab-out-of-bounds in walk_stackframe+0x11c/0x260
arch/riscv/kernel/stacktrace.c:57
Read of size 8 at addr ffffaf800bd53d60 by task syz-executor.0/2044

CPU: 0 PID: 2044 Comm: syz-executor.0 Not tainted
5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
[<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
[<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
[<ffffffff8047479e>] print_address_description.constprop.0+0x2a/0x330
mm/kasan/report.c:255
[<ffffffff80474d4c>] __kasan_report mm/kasan/report.c:442 [inline]
[<ffffffff80474d4c>] kasan_report+0x184/0x1e0 mm/kasan/report.c:459
[<ffffffff80475b20>] check_region_inline mm/kasan/generic.c:183 [inline]
[<ffffffff80475b20>] __asan_load8+0x6e/0x96 mm/kasan/generic.c:256
[<ffffffff8000a052>] walk_stackframe+0x11c/0x260
arch/riscv/kernel/stacktrace.c:57
[<ffffffff8000a4a4>] arch_stack_walk+0x2c/0x3c
arch/riscv/kernel/stacktrace.c:146
[<ffffffff80162ac8>] stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
[<ffffffff80473abe>] kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38

If risc-v stack walking is intentionally imprecise, then it needs
kasan annotations as other arches do for async stack walking. Or
otherwise it looks like a stack walking precision bug.





> =====================================================
> BUG: KMSAN: uninit-value in arch_stack_walk+0x1ad/0x3c0 arch/x86/kernel/stacktrace.c:21
>  arch_stack_walk+0x1ad/0x3c0 arch/x86/kernel/stacktrace.c:21
>  stack_trace_save+0x43/0x60 kernel/stacktrace.c:122
>  kmsan_save_stack_with_flags mm/kmsan/core.c:80 [inline]
>  kmsan_internal_chain_origin+0xa9/0x110 mm/kmsan/core.c:217
>  kmsan_internal_memmove_metadata+0x1f2/0x2e0 mm/kmsan/core.c:165
>  __msan_memcpy+0x65/0x90 mm/kmsan/instrumentation.c:127
>  sock_write_iter+0x605/0x690 net/socket.c:1062
>  do_iter_readv_writev+0xa7f/0xc70
>  do_iter_write+0x52c/0x1500 fs/read_write.c:851
>  vfs_writev fs/read_write.c:924 [inline]
>  do_writev+0x645/0xe00 fs/read_write.c:967
>  __do_sys_writev fs/read_write.c:1040 [inline]
>  __se_sys_writev fs/read_write.c:1037 [inline]
>  __x64_sys_writev+0xe5/0x120 fs/read_write.c:1037
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Local variable regs created at:
>  __bpf_prog_run32+0x84/0x180 kernel/bpf/core.c:1796
>  bpf_dispatcher_nop_func include/linux/bpf.h:785 [inline]
>  __bpf_prog_run include/linux/filter.h:626 [inline]
>  bpf_prog_run include/linux/filter.h:633 [inline]
>  __bpf_prog_run_save_cb+0x168/0x580 include/linux/filter.h:756
>
> CPU: 1 PID: 3474 Comm: syz-executor178 Not tainted 5.17.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> =====================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
