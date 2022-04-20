Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598E3509309
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382901AbiDTWnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345088AbiDTWnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:43:14 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B31FCE5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:40:25 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2eba37104a2so34621747b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDPlXpgyHO1Tq+DlJ+vKmZK0ZbHm1vtqTlycnJ11XBg=;
        b=Dn+4m5dtOR/5x0ftZIEEPPVYLsvmQYOjxJ6Xlp3Q1t276cM/5suHQYH5tWuSZJt9O5
         o1arHx+QUZK4NKk8pfNvhluOVPFGwxeDa+BMQxAeuLkdKdhq2KErXBx2lVUTaMWSeUYR
         neCYw+sDGhSdylTr5u/99pcgJXsZKyzSbyYI0i0tM4K8zQ/o7KRr1VBY5PhFl0qDuaY6
         VSvUjS3IqHWz1DPh8pU2Uk4rlzCHKnky3r9hM/35yFts7L+mxyMxJ+MvqzIQdlhSWnNQ
         5ZUMLcSn8orGjbmuhan6BjXfDQ+ELPaiIPUZf+RBfSxMCfD5a4MBt1ZhD/X7F7WT4ZXl
         zSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDPlXpgyHO1Tq+DlJ+vKmZK0ZbHm1vtqTlycnJ11XBg=;
        b=GRGDDUX13fKE7lE5RTmQfYYn0tR9GdMPd9+LLQBt12d7ByraPVtovUur6zxgJ9rWjS
         a5YnD/zm3uS5xVbcfuHVmiBPbQD0i4G68RF8xprKymNedf4ZAxb+5lq0cTF2G51XQvW+
         8RQ5fbjTnaW7XLVpQkKupDZ0Jd9K18uDmrf54CUYiPBeBNqfUBH/0Ss4YSx/5r2zNtNt
         HRou9NwUPhcgmEJAdfY1LO5eYYfCkpwcDQ3CaYu1P2BM7l+XGv+vNN9xO6RCK2BBKyTK
         MarpgstvKfTkMKwEfBDYeZ/iCnTQtQ/nK0gStl5cF9jtICWfSRTdDGpr06NKut8ZWcco
         gi3w==
X-Gm-Message-State: AOAM530Z0G6SiOkCBZgn2SjdG7TDb6ZPcrI4OQtT58snNnna7pL+mPih
        9SeYy1pwegqe91BKEqwaKk4fgRnPIroyrDHYJJ+sQw==
X-Google-Smtp-Source: ABdhPJxKqQxuNMwOvKvwxEZwWGkVMHh3ibxCcHJ1MBT1TdSljeiKict+Cq2u1J1geuVROj3r9zFVBxAHWlaeHPH2CmQ=
X-Received: by 2002:a81:1cd5:0:b0:2f4:c3fc:2174 with SMTP id
 c204-20020a811cd5000000b002f4c3fc2174mr3985288ywc.512.1650494424156; Wed, 20
 Apr 2022 15:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009054b205dd1bbcd5@google.com>
In-Reply-To: <0000000000009054b205dd1bbcd5@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 Apr 2022 00:39:47 +0200
Message-ID: <CANpmjNNJQ6gorxVg4trf_CKut5ZVDwpePHQaSDVLYyEMCAKDKw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in __bfs (2)
To:     syzbot <syzbot+a7de825fb004b4dced19@syzkaller.appspotmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     arnd@arndb.de, dinguyen@kernel.org, dvyukov@google.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        shorne@gmail.com, syzkaller-bugs@googlegroups.com,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc riscv]

On Wed, 20 Apr 2022 at 22:21, syzbot
<syzbot+a7de825fb004b4dced19@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=10bc68e8f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
> dashboard link: https://syzkaller.appspot.com/bug?extid=a7de825fb004b4dced19
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a7de825fb004b4dced19@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in __bfs+0x154/0x394 kernel/locking/lockdep.c:1708
> Read of size 8 at addr ffffaf801145fed0 by task syz-executor.1/6775
>
> CPU: 1 PID: 6775 Comm: syz-executor.1 Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
> [<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
> [<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
> [<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
> [<ffffffff8047479e>] print_address_description.constprop.0+0x2a/0x330 mm/kasan/report.c:255
> [<ffffffff80474d4c>] __kasan_report mm/kasan/report.c:442 [inline]
> [<ffffffff80474d4c>] kasan_report+0x184/0x1e0 mm/kasan/report.c:459
> [<ffffffff80475b20>] check_region_inline mm/kasan/generic.c:183 [inline]
> [<ffffffff80475b20>] __asan_load8+0x6e/0x96 mm/kasan/generic.c:256
> [<ffffffff8010dd9a>] __bfs+0x154/0x394 kernel/locking/lockdep.c:1708
> [<ffffffff8010e52a>] __bfs_forwards kernel/locking/lockdep.c:1803 [inline]
> [<ffffffff8010e52a>] check_path.constprop.0+0x24/0x46 kernel/locking/lockdep.c:2104
> [<ffffffff8010f95c>] check_noncircular+0x11a/0x1fe kernel/locking/lockdep.c:2131
> [<ffffffff80113c26>] check_prev_add kernel/locking/lockdep.c:3063 [inline]
> [<ffffffff80113c26>] check_prevs_add kernel/locking/lockdep.c:3186 [inline]
> [<ffffffff80113c26>] validate_chain kernel/locking/lockdep.c:3801 [inline]
> [<ffffffff80113c26>] __lock_acquire+0x19a4/0x333e kernel/locking/lockdep.c:5027
>
> Allocated by task 1102416563:
> (stack is not available)
>
> Freed by task 6724:
>  stack_trace_save+0xa6/0xd8 kernel/stacktrace.c:122
>  kasan_save_stack+0x2c/0x58 mm/kasan/common.c:38
>  kasan_set_track+0x1a/0x26 mm/kasan/common.c:45
>  kasan_set_free_info+0x1e/0x3a mm/kasan/generic.c:370
>  ____kasan_slab_free mm/kasan/common.c:366 [inline]
>  ____kasan_slab_free+0x15e/0x180 mm/kasan/common.c:328
>  __kasan_slab_free+0x10/0x18 mm/kasan/common.c:374
>  kasan_slab_free include/linux/kasan.h:236 [inline]
>  slab_free_hook mm/slub.c:1728 [inline]
>  slab_free_freelist_hook+0x8e/0x1cc mm/slub.c:1754
>  slab_free mm/slub.c:3509 [inline]
>  kmem_cache_free+0xca/0x482 mm/slub.c:3526
>  free_task_struct kernel/fork.c:176 [inline]
>  free_task+0xac/0xd6 kernel/fork.c:472
>  __put_task_struct+0x160/0x242 kernel/fork.c:760
>  put_task_struct include/linux/sched/task.h:115 [inline]
>  delayed_put_task_struct+0x2f0/0x394 kernel/exit.c:174
>  rcu_do_batch kernel/rcu/tree.c:2527 [inline]
>  rcu_core+0x63c/0xf36 kernel/rcu/tree.c:2778
>  rcu_core_si+0xc/0x14 kernel/rcu/tree.c:2795
>  __do_softirq+0x274/0x8fc kernel/softirq.c:558
>
> Last potentially related work creation:
> ------------[ cut here ]------------
> slab index 1181800 out of bounds (419) for stack id 84520868
> WARNING: CPU: 1 PID: 6775 at lib/stackdepot.c:304 stack_depot_fetch lib/stackdepot.c:304 [inline]
> WARNING: CPU: 1 PID: 6775 at lib/stackdepot.c:304 stack_depot_print+0x66/0x70 lib/stackdepot.c:276
> Modules linked in:
> CPU: 1 PID: 6775 Comm: syz-executor.1 Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
> Hardware name: riscv-virtio,qemu (DT)
> epc : stack_depot_fetch lib/stackdepot.c:304 [inline]
> epc : stack_depot_print+0x66/0x70 lib/stackdepot.c:276
>  ra : stack_depot_fetch lib/stackdepot.c:304 [inline]
>  ra : stack_depot_print+0x66/0x70 lib/stackdepot.c:276
> epc : ffffffff80c00b8a ra : ffffffff80c00b8a sp : ffffaf801145fc60
>  gp : ffffffff85863ac0 tp : ffffaf800e583080 t0 : ffffffff86bcb657
>  t1 : fffff5ef0b53c90c t2 : 0000000000000000 s0 : ffffaf801145fc70
>  s1 : ffffaf807ab248c0 a0 : 000000000000003c a1 : 00000000000f0000
>  a2 : 0000000000000104 a3 : ffffffff8012252a a4 : 36206938ade05e00
>  a5 : 36206938ade05e00 a6 : 0000000000f00000 a7 : ffffaf805a9e4863
>  s2 : ffffaf801145fed0 s3 : ffffaf800723ea00 s4 : ffffaf801145e100
>  s5 : ffffaf801145f840 s6 : ffffffff8588bb20 s7 : ffffffff85e09180
>  s8 : ffffaf801145fde0 s9 : ffffaf800e583bd8 s10: ffffffff85899680
>  s11: ffffaf800e583080 t3 : ffffffff801163b2 t4 : fffff5ef0b53c90c
>  t5 : fffff5ef0b53c90d t6 : ffffaf801145f758
> status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
> [<ffffffff80474a70>] describe_object_stacks mm/kasan/report.c:216 [inline]
> [<ffffffff80474a70>] describe_object mm/kasan/report.c:231 [inline]
> [<ffffffff80474a70>] print_address_description.constprop.0+0x2fc/0x330 mm/kasan/report.c:263
> [<ffffffff80474d4c>] __kasan_report mm/kasan/report.c:442 [inline]
> [<ffffffff80474d4c>] kasan_report+0x184/0x1e0 mm/kasan/report.c:459
> [<ffffffff80475b20>] check_region_inline mm/kasan/generic.c:183 [inline]
> [<ffffffff80475b20>] __asan_load8+0x6e/0x96 mm/kasan/generic.c:256
> [<ffffffff8010dd9a>] __bfs+0x154/0x394 kernel/locking/lockdep.c:1708
> [<ffffffff8010e52a>] __bfs_forwards kernel/locking/lockdep.c:1803 [inline]
> [<ffffffff8010e52a>] check_path.constprop.0+0x24/0x46 kernel/locking/lockdep.c:2104
> [<ffffffff8010f95c>] check_noncircular+0x11a/0x1fe kernel/locking/lockdep.c:2131
> [<ffffffff80113c26>] check_prev_add kernel/locking/lockdep.c:3063 [inline]
> [<ffffffff80113c26>] check_prevs_add kernel/locking/lockdep.c:3186 [inline]
> [<ffffffff80113c26>] validate_chain kernel/locking/lockdep.c:3801 [inline]
> [<ffffffff80113c26>] __lock_acquire+0x19a4/0x333e kernel/locking/lockdep.c:5027
> irq event stamp: 435
> hardirqs last  enabled at (434): [<ffffffff8041714a>] rmqueue_pcplist mm/page_alloc.c:3671 [inline]
> hardirqs last  enabled at (434): [<ffffffff8041714a>] rmqueue mm/page_alloc.c:3698 [inline]
> hardirqs last  enabled at (434): [<ffffffff8041714a>] get_page_from_freelist+0xfc8/0x12d8 mm/page_alloc.c:4162
> hardirqs last disabled at (435): [<ffffffff80417140>] rmqueue_pcplist mm/page_alloc.c:3660 [inline]
> hardirqs last disabled at (435): [<ffffffff80417140>] rmqueue mm/page_alloc.c:3698 [inline]
> hardirqs last disabled at (435): [<ffffffff80417140>] get_page_from_freelist+0xfbe/0x12d8 mm/page_alloc.c:4162
> softirqs last  enabled at (376): [<ffffffff82af5e6e>] rcu_read_unlock_bh include/linux/rcupdate.h:760 [inline]
> softirqs last  enabled at (376): [<ffffffff82af5e6e>] ip_finish_output2+0x540/0x1720 net/ipv4/ip_output.c:222
> softirqs last disabled at (377): [<ffffffff80060ea0>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (377): [<ffffffff80060ea0>] do_softirq kernel/softirq.c:459 [inline]
> softirqs last disabled at (377): [<ffffffff80060ea0>] do_softirq+0x158/0x15a kernel/softirq.c:446
> ---[ end trace 0000000000000000 ]---
>
> Second to last potentially related work creation:
> ------------[ cut here ]------------
> slab index 2097151 out of bounds (419) for stack id ffffffff
> WARNING: CPU: 1 PID: 6775 at lib/stackdepot.c:304 stack_depot_fetch lib/stackdepot.c:304 [inline]
> WARNING: CPU: 1 PID: 6775 at lib/stackdepot.c:304 stack_depot_print+0x66/0x70 lib/stackdepot.c:276
> Modules linked in:
> CPU: 1 PID: 6775 Comm: syz-executor.1 Tainted: G        W         5.17.0-rc1-syzkaller-00002-g0966d385830d #0
> Hardware name: riscv-virtio,qemu (DT)
> epc : stack_depot_fetch lib/stackdepot.c:304 [inline]
> epc : stack_depot_print+0x66/0x70 lib/stackdepot.c:276
>  ra : stack_depot_fetch lib/stackdepot.c:304 [inline]
>  ra : stack_depot_print+0x66/0x70 lib/stackdepot.c:276
> epc : ffffffff80c00b8a ra : ffffffff80c00b8a sp : ffffaf801145fc60
>  gp : ffffffff85863ac0 tp : ffffaf800e583080 t0 : ffffffff86bcb657
>  t1 : fffff5ef0b53c90c t2 : 0000000000000000 s0 : ffffaf801145fc70
>  s1 : ffffaf807ab248c0 a0 : 000000000000003c a1 : 00000000000f0000
>  a2 : 0000000000000104 a3 : ffffffff8012252a a4 : 36206938ade05e00
>  a5 : 36206938ade05e00 a6 : 0000000000f00000 a7 : ffffaf805a9e4863
>  s2 : ffffaf801145fed0 s3 : ffffaf800723ea00 s4 : ffffaf801145e100
>  s5 : ffffaf801145f840 s6 : ffffffff8588bb20 s7 : ffffffff85e09180
>  s8 : ffffaf801145fde0 s9 : ffffaf800e583bd8 s10: ffffffff85899680
>  s11: ffffaf800e583080 t3 : ffffffff801163b2 t4 : fffff5ef0b53c90c
>  t5 : fffff5ef0b53c90d t6 : ffffaf801145f758
> status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
> [<ffffffff80474a22>] describe_object_stacks mm/kasan/report.c:221 [inline]
> [<ffffffff80474a22>] describe_object mm/kasan/report.c:231 [inline]
> [<ffffffff80474a22>] print_address_description.constprop.0+0x2ae/0x330 mm/kasan/report.c:263
> [<ffffffff80474d4c>] __kasan_report mm/kasan/report.c:442 [inline]
> [<ffffffff80474d4c>] kasan_report+0x184/0x1e0 mm/kasan/report.c:459
> [<ffffffff80475b20>] check_region_inline mm/kasan/generic.c:183 [inline]
> [<ffffffff80475b20>] __asan_load8+0x6e/0x96 mm/kasan/generic.c:256
> [<ffffffff8010dd9a>] __bfs+0x154/0x394 kernel/locking/lockdep.c:1708
> [<ffffffff8010e52a>] __bfs_forwards kernel/locking/lockdep.c:1803 [inline]
> [<ffffffff8010e52a>] check_path.constprop.0+0x24/0x46 kernel/locking/lockdep.c:2104
> [<ffffffff8010f95c>] check_noncircular+0x11a/0x1fe kernel/locking/lockdep.c:2131
> [<ffffffff80113c26>] check_prev_add kernel/locking/lockdep.c:3063 [inline]
> [<ffffffff80113c26>] check_prevs_add kernel/locking/lockdep.c:3186 [inline]
> [<ffffffff80113c26>] validate_chain kernel/locking/lockdep.c:3801 [inline]
> [<ffffffff80113c26>] __lock_acquire+0x19a4/0x333e kernel/locking/lockdep.c:5027
> irq event stamp: 435
> hardirqs last  enabled at (434): [<ffffffff8041714a>] rmqueue_pcplist mm/page_alloc.c:3671 [inline]
> hardirqs last  enabled at (434): [<ffffffff8041714a>] rmqueue mm/page_alloc.c:3698 [inline]
> hardirqs last  enabled at (434): [<ffffffff8041714a>] get_page_from_freelist+0xfc8/0x12d8 mm/page_alloc.c:4162
> hardirqs last disabled at (435): [<ffffffff80417140>] rmqueue_pcplist mm/page_alloc.c:3660 [inline]
> hardirqs last disabled at (435): [<ffffffff80417140>] rmqueue mm/page_alloc.c:3698 [inline]
> hardirqs last disabled at (435): [<ffffffff80417140>] get_page_from_freelist+0xfbe/0x12d8 mm/page_alloc.c:4162
> softirqs last  enabled at (376): [<ffffffff82af5e6e>] rcu_read_unlock_bh include/linux/rcupdate.h:760 [inline]
> softirqs last  enabled at (376): [<ffffffff82af5e6e>] ip_finish_output2+0x540/0x1720 net/ipv4/ip_output.c:222
> softirqs last disabled at (377): [<ffffffff80060ea0>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (377): [<ffffffff80060ea0>] do_softirq kernel/softirq.c:459 [inline]
> softirqs last disabled at (377): [<ffffffff80060ea0>] do_softirq+0x158/0x15a kernel/softirq.c:446
> ---[ end trace 0000000000000000 ]---
>
> The buggy address belongs to the object at ffffaf801145e100
>  which belongs to the cache task_struct of size 5952
> The buggy address is located 1680 bytes to the right of
>  5952-byte region [ffffaf801145e100, ffffaf801145f840)
> The buggy address belongs to the page:
> page:ffffaf807ab248c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x91658
> head:ffffaf807ab248c0 order:3 compound_mapcount:0 compound_pincount:0
> memcg:ffffaf8021359281
> flags: 0x9000010200(slab|head|section=18|node=0|zone=0)
> raw: 0000009000010200 ffffaf807aaad940 0000000000000003 ffffaf800723ea00
> raw: 0000000000000000 0000000000050005 00000001ffffffff ffffaf8021359281
> raw: 00000000000007ff
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 3072, ts 1369164483600, free_ts 1354406359600
>  __set_page_owner+0x48/0x136 mm/page_owner.c:183
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0xd0/0x10a mm/page_alloc.c:2427
>  prep_new_page mm/page_alloc.c:2434 [inline]
>  get_page_from_freelist+0x8da/0x12d8 mm/page_alloc.c:4165
>  __alloc_pages+0x150/0x3b6 mm/page_alloc.c:5389
>  alloc_pages+0x132/0x2a6 mm/mempolicy.c:2271
>  alloc_slab_page.constprop.0+0xc2/0xfa mm/slub.c:1799
>  allocate_slab mm/slub.c:1944 [inline]
>  new_slab+0x25a/0x2cc mm/slub.c:2004
>  ___slab_alloc+0x56e/0x918 mm/slub.c:3018
>  __slab_alloc.constprop.0+0x50/0x8c mm/slub.c:3105
>  slab_alloc_node mm/slub.c:3196 [inline]
>  kmem_cache_alloc_node+0x1f2/0x41c mm/slub.c:3266
>  alloc_task_struct_node kernel/fork.c:171 [inline]
>  dup_task_struct kernel/fork.c:883 [inline]
>  copy_process+0x203e/0x3c34 kernel/fork.c:1998
>  kernel_clone+0xee/0x920 kernel/fork.c:2555
>  __do_sys_clone+0xf2/0x12e kernel/fork.c:2672
>  sys_clone+0x32/0x44 kernel/fork.c:2640
>  ret_from_syscall+0x0/0x2
> page last free stack trace:
>  __reset_page_owner+0x4a/0xea mm/page_owner.c:142
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1352 [inline]
>  free_pcp_prepare+0x29c/0x45e mm/page_alloc.c:1404
>  free_unref_page_prepare mm/page_alloc.c:3325 [inline]
>  free_unref_page+0x6a/0x31e mm/page_alloc.c:3404
>  free_the_page mm/page_alloc.c:706 [inline]
>  __free_pages+0xe2/0x112 mm/page_alloc.c:5474
>  __free_slab+0x122/0x27c mm/slub.c:2028
>  free_slab mm/slub.c:2043 [inline]
>  discard_slab+0x4c/0x7a mm/slub.c:2049
>  __slab_free+0x20a/0x29c mm/slub.c:3414
>  do_slab_free mm/slub.c:3497 [inline]
>  ___cache_free+0x17c/0x354 mm/slub.c:3516
>  qlink_free mm/kasan/quarantine.c:157 [inline]
>  qlist_free_all+0x7c/0x132 mm/kasan/quarantine.c:176
>  kasan_quarantine_reduce+0x14c/0x1c8 mm/kasan/quarantine.c:283
>  __kasan_slab_alloc+0x5c/0x98 mm/kasan/common.c:446
>  kasan_slab_alloc include/linux/kasan.h:260 [inline]
>  slab_post_alloc_hook mm/slab.h:732 [inline]
>  slab_alloc_node mm/slub.c:3230 [inline]
>  kmem_cache_alloc_node+0x368/0x41c mm/slub.c:3266
>  __alloc_skb+0x234/0x2e4 net/core/skbuff.c:414
>  alloc_skb_fclone include/linux/skbuff.h:1208 [inline]
>  tcp_stream_alloc_skb+0x70/0x4c0 net/ipv4/tcp.c:861
>  tcp_sendmsg_locked+0x880/0x1d9e net/ipv4/tcp.c:1281
>  tcp_sendmsg+0x32/0x4e net/ipv4/tcp.c:1440
>
> Memory state around the buggy address:
>  ffffaf801145fd80: f1 f1 f1 f1 00 f3 f3 f3 fc fc fc fc fc fc fc fc
>  ffffaf801145fe00: fc fc fc fc fc fc fc fc fc fc fc fc 00 00 00 00
> >ffffaf801145fe80: f1 f1 f1 f1 00 f2 f2 f2 fc fc fc fc 00 00 00 f3
>                                                  ^
>  ffffaf801145ff00: f3 f3 f3 f3 fc fc fc fc fc fc fc fc fc fc fc fc
>  ffffaf801145ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
