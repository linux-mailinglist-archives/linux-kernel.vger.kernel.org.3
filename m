Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3F4E39C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiCVHq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiCVHqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:46:21 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2733206A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:40:21 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u25-20020a5d8199000000b006421bd641bbso11973073ion.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=qjyUq3UvrUF6WB1/L7bAEcw6CUa1YZwskiEvT860kDo=;
        b=w+my9Sa4iJ0CZi3U3wP5E9IEs3z8GiFpLqubpKPmnlQr6yYEtpraHq6N5p3zT4o1F/
         Em8enEpReNt6NGda3R6Na/cl1OK5UMEd4MsKNubZ26je4TH0sbVMT4WlbxsifszaIMpG
         DgPb7Jeukh69l+N3/I9gPAMrBGAb0yIh/qm/5qIRTaB5lmB8bId/qBtbHfgr66+ezQUC
         66zzoN3eXpGaEGRu0Xq74ZWbCIqxN2xOeP2Wbc7do2gTiARFovStA5E3Nky0tDTyEM9K
         xV9PqZNIQu1tYTtPonOz3znSbRHb2J+WVd00LuT8jdK80QU4lNXnn18VLtXlsWgaaV/+
         gbrw==
X-Gm-Message-State: AOAM531YdIZ5T5/V5y3Nd3bWmbyg0tMAgXO9ljWdb0LcpP69ovK3gfhD
        T8CYo5MNjXS0rctzkxNIZtHU8hmL9ARoLNI25JtIjtffBcxx
X-Google-Smtp-Source: ABdhPJx2Meqp7NP2Wl+MA4N+QFrIKllBtvtmMEMSXsQtiwO+2MkasV/83ruSL2d7Dn15GAogdHDI7N32KvI4qUiDuW2SIq7NUbx2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d03:b0:2c7:e33f:2557 with SMTP id
 i3-20020a056e021d0300b002c7e33f2557mr11826827ila.15.1647934821146; Tue, 22
 Mar 2022 00:40:21 -0700 (PDT)
Date:   Tue, 22 Mar 2022 00:40:21 -0700
In-Reply-To: <20220322074002.3294-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0a41d05dac9b99d@google.com>
Subject: Re: INFO: rcu detected stall in smp_call_function
From:   syzbot <syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 06 Sep 2020 11:40:17 -0700
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    dd9fb9bb Merge tags 'auxdisplay-for-linus-v5.9-rc4', 'clan..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=124893e1900000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd46548257448703
>> dashboard link: https://syzkaller.appspot.com/bug?extid=cb3b69ae80afd6535b0e
>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13727231900000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132c9fc9900000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
>> 
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> rcu: 	0-....: (1 GPs behind) idle=932/1/0x4000000000000002 softirq=9344/9345 fqs=5247 
>> 	(detected by 1, t=10502 jiffies, g=10529, q=124891)
>> Sending NMI from CPU 1 to CPUs 0:
>> NMI backtrace for cpu 0
>> CPU: 0 PID: 8110 Comm: syz-executor267 Not tainted 5.9.0-rc3-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:91 [inline]
>> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:108 [inline]
>> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:134 [inline]
>> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:165 [inline]
>> RIP: 0010:check_memory_region_inline mm/kasan/generic.c:183 [inline]
>> RIP: 0010:check_memory_region+0xdb/0x180 mm/kasan/generic.c:192
>> Code: 80 38 00 74 f2 48 89 c2 b8 01 00 00 00 48 85 d2 75 56 5b 5d 41 5c c3 48 85 d2 74 5e 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 50 <80> 38 00 74 f2 eb d4 41 bc 08 00 00 00 48 89 ea 45 29 dc 4d 8d 1c
>> RSP: 0018:ffffc90000007090 EFLAGS: 00000086
>> RAX: fffff52000000e30 RBX: fffff52000000e3c RCX: ffffffff81339c7a
>> RDX: fffff52000000e3c RSI: 0000000000000060 RDI: ffffc90000007180
>> RBP: fffff52000000e30 R08: 0000000000000001 R09: ffffc900000071df
>> R10: fffff52000000e3b R11: 0000000000000001 R12: 0000000000000060
>> R13: 0000000000000000 R14: 000000000000007f R15: ffffc90000007180
>> FS:  0000000000cf9880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000000008319c CR3: 000000009f579000 CR4: 00000000001506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <IRQ>
>>  memset+0x20/0x40 mm/kasan/common.c:84
>>  memset include/linux/string.h:391 [inline]
>>  __unwind_start+0x2a/0x800 arch/x86/kernel/unwind_orc.c:630
>>  unwind_start arch/x86/include/asm/unwind.h:60 [inline]
>>  perf_callchain_kernel+0x2f0/0x6a0 arch/x86/events/core.c:2447
>>  get_perf_callchain+0x16e/0x620 kernel/events/callchain.c:200
>>  perf_callchain+0x165/0x1c0 kernel/events/core.c:6985
>>  perf_prepare_sample+0x8fd/0x1d40 kernel/events/core.c:7012
>>  __perf_event_output kernel/events/core.c:7170 [inline]
>>  perf_event_output_forward+0xf3/0x270 kernel/events/core.c:7190
>>  __perf_event_overflow+0x13c/0x370 kernel/events/core.c:8845
>>  perf_swevent_overflow kernel/events/core.c:8921 [inline]
>>  perf_swevent_event+0x347/0x550 kernel/events/core.c:8949
>>  perf_tp_event+0x2e4/0xb50 kernel/events/core.c:9377
>>  perf_trace_run_bpf_submit+0x11c/0x200 kernel/events/core.c:9351
>>  perf_trace_preemptirq_template+0x289/0x440 include/trace/events/preemptirq.h:14
>>  trace_irq_enable_rcuidle include/trace/events/preemptirq.h:40 [inline]
>>  trace_irq_enable_rcuidle include/trace/events/preemptirq.h:40 [inline]
>>  trace_hardirqs_on+0x18a/0x220 kernel/trace/trace_preemptirq.c:44
>>  asm_sysvec_irq_work+0x12/0x20 arch/x86/include/asm/idtentry.h:611
>> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:770 [inline]
>> RIP: 0010:rcu_read_unlock_special kernel/rcu/tree_plugin.h:630 [inline]
>> RIP: 0010:__rcu_read_unlock+0x26e/0x530 kernel/rcu/tree_plugin.h:395
>> Code: ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 a3 02 00 00 48 83 3d d5 9c 54 08 00 0f 84 18 02 00 00 4c 89 e7 57 9d <0f> 1f 44 00 00 e9 07 fe ff ff 0f 0b e9 41 fe ff ff e8 5c b1 52 00
>> RSP: 0018:ffffc90000007b40 EFLAGS: 00000282
>> RAX: 1ffffffff136c789 RBX: ffffffff89bd9a80 RCX: 0000000000000002
>> RDX: dffffc0000000000 RSI: 0000000000000101 RDI: 0000000000000282
>> RBP: 0000000000000001 R08: 0000000000000001 R09: ffffffff8c5f4a97
>> R10: fffffbfff18be952 R11: 0000000000000001 R12: 0000000000000282
>> R13: 0000000000000200 R14: ffff8880ae636c00 R15: 0000000000000000
>>  rcu_read_unlock include/linux/rcupdate.h:687 [inline]
>>  mld_sendpack+0x742/0xdb0 net/ipv6/mcast.c:1690
>>  mld_send_initial_cr.part.0+0x106/0x150 net/ipv6/mcast.c:2096
>>  mld_send_initial_cr net/ipv6/mcast.c:1191 [inline]
>>  mld_dad_timer_expire+0x1c7/0x6a0 net/ipv6/mcast.c:2115
>>  call_timer_fn+0x1ac/0x760 kernel/time/timer.c:1413
>>  expire_timers kernel/time/timer.c:1458 [inline]
>>  __run_timers.part.0+0x67c/0xaa0 kernel/time/timer.c:1755
>>  __run_timers kernel/time/timer.c:1736 [inline]
>>  run_timer_softirq+0xae/0x1a0 kernel/time/timer.c:1768
>>  __do_softirq+0x1f7/0xa91 kernel/softirq.c:298
>>  asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
>>  </IRQ>
>>  __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
>>  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
>>  do_softirq_own_stack+0x9d/0xd0 arch/x86/kernel/irq_64.c:77
>>  invoke_softirq kernel/softirq.c:393 [inline]
>>  __irq_exit_rcu kernel/softirq.c:423 [inline]
>>  irq_exit_rcu+0x235/0x280 kernel/softirq.c:435
>>  sysvec_apic_timer_interrupt+0x51/0xf0 arch/x86/kernel/apic/apic.c:1091
>>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
>> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:770 [inline]
>> RIP: 0010:generic_exec_single+0x2b6/0x430 kernel/smp.c:172
>> Code: 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 2d 01 00 00 48 83 3d 82 fd 4c 08 00 0f 84 f3 00 00 00 e8 2f 0c 0b 00 48 89 df 57 9d <0f> 1f 44 00 00 45 31 e4 e9 34 fe ff ff e8 18 0c 0b 00 0f 0b e9 95
>> RSP: 0018:ffffc90009cbfb08 EFLAGS: 00000293
>> RAX: 0000000000000000 RBX: 0000000000000293 RCX: 0000000000000006
>> RDX: ffff88809054a380 RSI: ffffffff81693ed1 RDI: 0000000000000293
>> RBP: 0000000000000200 R08: 0000000000000001 R09: ffffffff8c5f4ab7
>> R10: fffffbfff18be956 R11: 0000000000000001 R12: ffffc90009cbfb80
>> R13: ffffffff818dc1d0 R14: ffffc90009cbfc48 R15: 1ffff92001397f9e
>>  smp_call_function_single+0x186/0x4f0 kernel/smp.c:379
>>  task_function_call+0xd7/0x160 kernel/events/core.c:116
>>  perf_install_in_context+0x2cb/0x550 kernel/events/core.c:2895
>>  __do_sys_perf_event_open+0x1c31/0x2cb0 kernel/events/core.c:11992
>>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> RIP: 0033:0x443f79
>> Code: e8 2c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007fffe1fb0778 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
>> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000443f79
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
>> RBP: 000000000008319c R08: 0000000000000000 R09: 0000000100000009
>> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000404da0 R14: 0000000000000000 R15: 0000000000000000
>> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 0.000 msecs
>
> See if it has any link to csd_lock_wait upstream with info printed about
> cpu1 that detected rcu stall on cpu0.
>
> Hillf
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

This bug is already marked as fixed. No point in testing.

