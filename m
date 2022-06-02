Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6689F53B78E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiFBK5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiFBK5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:57:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB020B14C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:57:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id l30so7214778lfj.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+CytCKlX79rhtBNDGo+eN/Csfz4tGbSW706glfcV3s=;
        b=IrBYH2atiRJTij4OLkL2McNzaoMR3RqF5IQNxPWSS4MKmKEZwVfo766LNbSjF5dRWW
         cXFMBvyydlUCOY5FUNClP3TU0KNiwEN3SZzoW/65g1Pm+DmVX3C8nvtlRiP3KA7teXx6
         ThGTHny9ze7dy+BMT4LA6doHWH7JqDtK33XtP2NkYcyLx0NC/nEI5L89L4ZSs0/CXrct
         CcTH8POG8oZpMV8ORMcHbE/H7LriMVrPMKQ4M+UJjJABi9RQ8a3bHWLowlT+KQqHYC4z
         EyW1W7L5bVRmR5ijb7kU/SlZMCNH572BPtAKMyOEGJd6xN6Wz/gBnbVK5UrRQSwpE1mk
         KnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+CytCKlX79rhtBNDGo+eN/Csfz4tGbSW706glfcV3s=;
        b=VgdK/GxZdSo3YVNeKxurFa3fBOzyOwinFSPuo4DOGFMSCfNWxTFPEmQtm1dJFJ+Kmk
         F0hJghdJ4C4T/64OH6Ng84szt/wlClitLWgXGICCkP0cslc2wKCPvHK7ZuUQmo1XNqto
         Qt3995JkE8tInlUvzvo/FmjwD9OvyJuDj0I60jdYOriOploanjzR0LQyr7GPho9jZiso
         YHMQM2xQJ/xwRti6OUn1Gket61Uw4C8tP6IynjeIoHdjMS9tkFbNQVoVoeOqQUAv9TRk
         cis5PxCvfQw/C4y4FHXge5z4+NoTz7hF6EuAt2m0Z6/7prw+M9/+1y+hkrzTCX9lIztE
         adbQ==
X-Gm-Message-State: AOAM532feXVYBtT/0Fy4PkA1I4cAfE73w17ug5H+TlpJCynVsMggigKH
        DBYLQ1GvnAtDNP0Yz4JK1PmCnpLldsNdYO/JGvBDzw==
X-Google-Smtp-Source: ABdhPJyRW4SMizmg/2yd0bFF1lI+Tau+09O/qHPkI3ruuPazvFnilXmy/61Dibd6p0qtuaD+W+P4LBZ7Y/pFJQAK4jA=
X-Received: by 2002:a05:6512:1156:b0:478:79b1:583c with SMTP id
 m22-20020a056512115600b0047879b1583cmr3211435lfg.206.1654167458543; Thu, 02
 Jun 2022 03:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000044cc505e0741a4b@google.com>
In-Reply-To: <000000000000044cc505e0741a4b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 2 Jun 2022 12:57:27 +0200
Message-ID: <CACT4Y+ay0SQiiu2MwanpYEGmybHZc-nuqOxWOz1hC0PgLRRhuQ@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: BUG: soft lockup in corrupted
To:     syzbot <syzbot+1d1952c211a38ac43f10@syzkaller.appspotmail.com>
Cc:     aou@eecs.berkeley.edu, axboe@kernel.dk, justin@coraid.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2022 at 12:02, syzbot
<syzbot+1d1952c211a38ac43f10@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c932edeaf6d6 riscv: dts: microchip: fix gpio1 reg property..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=14de11edf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aa6b5702bdf14a17
> dashboard link: https://syzkaller.appspot.com/bug?extid=1d1952c211a38ac43f10
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1d1952c211a38ac43f10@syzkaller.appspotmail.com


This is the issue with riscv command line length we discussed in the
other thread:
https://lore.kernel.org/all/CACT4Y+bP+U2Co67SJG4qri=qHqCk38cq_JwGmo7m0s-8hCF8ww@mail.gmail.com/


> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [swapper/0:1]
> Modules linked in:
> irq event stamp: 410297
> hardirqs last  enabled at (410296): [<ffffffff8000ee74>] __trace_hardirqs_on+0x18/0x20 arch/riscv/kernel/trace_irq.c:19
> hardirqs last disabled at (410297): [<ffffffff8000ee94>] __trace_hardirqs_off+0x18/0x20 arch/riscv/kernel/trace_irq.c:25
> softirqs last  enabled at (405886): [<ffffffff83207a08>] softirq_handle_end kernel/softirq.c:401 [inline]
> softirqs last  enabled at (405886): [<ffffffff83207a08>] __do_softirq+0x618/0x8fc kernel/softirq.c:587
> softirqs last disabled at (405891): [<ffffffff8006164a>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (405891): [<ffffffff8006164a>] invoke_softirq kernel/softirq.c:439 [inline]
> softirqs last disabled at (405891): [<ffffffff8006164a>] __irq_exit_rcu+0x142/0x1f8 kernel/softirq.c:637
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc1-syzkaller #0
> Hardware name: riscv-virtio,qemu (DT)
> epc : arch_static_branch arch/riscv/include/asm/jump_label.h:20 [inline]
> epc : kfence_alloc include/linux/kfence.h:120 [inline]
> epc : slab_alloc_node mm/slub.c:3135 [inline]
> epc : kmem_cache_alloc_node+0xa0/0x3c6 mm/slub.c:3267
>  ra : slab_pre_alloc_hook mm/slab.h:724 [inline]
>  ra : slab_alloc_node mm/slub.c:3131 [inline]
>  ra : kmem_cache_alloc_node+0x66/0x3c6 mm/slub.c:3267
> epc : ffffffff8047df56 ra : ffffffff8047df1c sp : ff200000002273b0
>  gp : ffffffff85a76440 tp : ff60000007430000 t0 : 0000000000046000
>  t1 : ffebffff014d10b7 t2 : ffffffff80668f62 s0 : ff20000000227450
>  s1 : ff600000075a93c0 a0 : 0000000000000000 a1 : 0000000000000007
>  a2 : 1ffffffff09c876c a3 : ffffffff80bec434 a4 : 0000000000000000
>  a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ff6000000a6885bb
>  s2 : 0000000000000a20 s3 : 0000000000000000 s4 : 0000000000000a20
>  s5 : ffffffffffffffff s6 : ffffffff8271f756 s7 : ffffffff85a9c780
>  s8 : 00000000000000e8 s9 : ffffffff85a7c2c0 s10: 00000000000000ff
>  s11: ffffffffffffa288 t3 : fffffffff3f3f300 t4 : ffebffff014d10b7
>  t5 : ffebffff014d10b8 t6 : ff6000001239fc00
> status: 0000000000000120 badaddr: 0000000000000000 cause: 8000000000000005
> [<ffffffff8271f756>] __alloc_skb+0x234/0x2e4 net/core/skbuff.c:414
> [<ffffffff81a42954>] alloc_skb include/linux/skbuff.h:1300 [inline]
> [<ffffffff81a42954>] new_skb+0x2c/0xcc drivers/block/aoe/aoecmd.c:66
> [<ffffffff81a48ab2>] aoecmd_cfg_pkts drivers/block/aoe/aoecmd.c:425 [inline]
> [<ffffffff81a48ab2>] aoecmd_cfg+0x1f6/0x5c6 drivers/block/aoe/aoecmd.c:1362
> [<ffffffff81a4bdfc>] discover_timer+0x4a/0x54 drivers/block/aoe/aoemain.c:24
> [<ffffffff8016c084>] call_timer_fn+0x164/0x694 kernel/time/timer.c:1421
> [<ffffffff8016ca9a>] expire_timers kernel/time/timer.c:1466 [inline]
> [<ffffffff8016ca9a>] __run_timers.part.0+0x4e6/0x76e kernel/time/timer.c:1734
> [<ffffffff8016cda8>] __run_timers kernel/time/timer.c:1715 [inline]
> [<ffffffff8016cda8>] run_timer_softirq+0x86/0x100 kernel/time/timer.c:1747
> [<ffffffff83207664>] __do_softirq+0x274/0x8fc kernel/softirq.c:558
> [<ffffffff8006164a>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> [<ffffffff8006164a>] invoke_softirq kernel/softirq.c:439 [inline]
> [<ffffffff8006164a>] __irq_exit_rcu+0x142/0x1f8 kernel/softirq.c:637
> [<ffffffff80061958>] irq_exit+0x10/0x7a kernel/softirq.c:661
> [<ffffffff831f7c8e>] generic_handle_arch_irq+0x48/0x54 kernel/irq/handle.c:240
> [<ffffffff800057b2>] ret_from_exception+0x0/0x10
> [<ffffffff8047df1c>] slab_pre_alloc_hook mm/slab.h:724 [inline]
> [<ffffffff8047df1c>] slab_alloc_node mm/slub.c:3131 [inline]
> [<ffffffff8047df1c>] kmem_cache_alloc_node+0x66/0x3c6 mm/slub.c:3267
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000044cc505e0741a4b%40google.com.
