Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9087D479B51
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhLROZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhLROZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:25:41 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E425C061574;
        Sat, 18 Dec 2021 06:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Type:Message-ID:Subject:Cc:To:From:Date
        :Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        In-Reply-To:References; bh=9mNqzOZiFdocsROzE9e3U9DF4opZfnCCgvgDR6tHkWk=; b=vU
        ZX2zFYsAPtNHdOHMZFqGPYNr+IJpafKAQM6lzcxoZOQzNX8SZmcuWjiQ5gI+CEh2Aq1DTdYodF9Hr
        THvYhhM1LApdadaDXGqe8z3eLqBaIwD3mmEbPAOZsqt2aEs+Y8C98HrCazHKqkdccR9QedYI+YxUk
        yyHlRFU56baXRglpmSJK2TYCTKn2vtPrwC09AiMqqgkdFHkrc+XOR21bpgwfV7oBAGm6s24ExLslU
        W5qqu3OB1dCgzqQ2IxGapmEj5t7pG1/Lc2MjN8ajpBsIBEBVe7W16xwCRUp4bdR3JJzsZnWwH7Uk5
        ayaul92ULSSKxMLXL3mLjchKqGfyyhWg==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1myaeW-0002I1-JK; Sat, 18 Dec 2021 14:25:36 +0000
Date:   Sat, 18 Dec 2021 14:25:35 +0000
From:   John Keeping <john@metanate.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RT] BUG in sched/cpupri.c
Message-ID: <Yb3vXx3DcqVOi+EA@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On v5.15.10-rt24 (and earlier v5.15 series RT kernels) I'm seeing an
occasional BUG at cpupri.c:151 (full trace below).

Having added extra logging, it seems that p->prio == 120 which isn't
handled by convert_prio() following commit 934fc3314b39 ("sched/cpupri:
Remap CPUPRI_NORMAL to MAX_RT_PRIO-1").

This happens maybe half the time as userspace is starting up, but if the
system boots to a login prompt I haven't seen any issues after that.
The process isn't always the same, I've seen systemd-udevd as well as
pr/ttyS2.

I can easily "fix" this by handling normal priority tasks in
convert_prio() but I guess there's some wider reason why that's not an
expected value there, so perhaps the real problem lies elsewhere.


Thanks,
John

------------[ cut here ]------------
kernel BUG at kernel/sched/cpupri.c:151!
Internal error: Oops - BUG: 0 [#1] PREEMPT_RT SMP ARM
Modules linked in:
CPU: 1 PID: 117 Comm: pr/ttyS2 Tainted: G    B             5.15.10-rt24 #1
Hardware name: Rockchip (Device Tree)
PC is at cpupri_find_fitness+0x78/0x1a4
LR is at cpupri_find_fitness+0x28/0x1a4
pc : [<c0183be8>]    lr : [<c0183b98>]    psr: 20030193
sp : c3ea38f8  ip : c38461bc  fp : 00000001
r10: e7db8b00  r9 : 00000001  r8 : c1ccd880
r7 : c3846180  r6 : c3846180  r5 : 00000000  r4 : e7db13dc
r3 : c0183b90  r2 : 00000000  r1 : 00000007  r0 : 00000078
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 0296406a  DAC: 00000051
Register r0 information: non-paged memory
Register r1 information: non-paged memory
Register r2 information: NULL pointer
Register r3 information: non-slab/vmalloc memory
Register r4 information: non-slab/vmalloc memory
Register r5 information: NULL pointer
Register r6 information: slab task_struct start c3846180 pointer offset 0
Register r7 information: slab task_struct start c3846180 pointer offset 0
Register r8 information: slab kmalloc-1k start c1ccd800 pointer offset 128 size 1024
Register r9 information: non-paged memory
Register r10 information: non-slab/vmalloc memory
Register r11 information: non-paged memory
Register r12 information: slab task_struct start c3846180 pointer offset 60
Process pr/ttyS2 (pid: 117, stack limit = 0x(ptrval))
Stack: (0xc3ea38f8 to 0xc3ea4000)
38e0:                                                       187d4724 00000078
3900: 41b58ab3 c11a824a c016ffcc 00000001 e7db13dc c1388b00 c3846180 c1408e04
3920: 00000001 e7db8b00 00000001 c017a378 c017bcd0 e7db9098 e7db8b00 c1d84b00
3940: 00000001 e7db9290 e7db9098 c1ccd858 c1ccd858 c017bcd8 e7db8b00 c1ccd858
3960: e7db9008 c1ccd800 c1408e04 00000008 c1ccd858 c017cfc8 c1ccd85c c1ccd858
3980: 0000002b 0000002a c1ccd85c c026718c 00000000 00000000 c1ccd858 00000000
39a0: c1ccd85c 00000020 c1ccd858 c01e7300 c17a5524 e7db8b40 00000000 0181b72f
39c0: c3846288 00000003 c17a4fe0 00000001 00000013 c0d0ab00 f0802000 26a30000
39e0: c15c4dc0 c01114e0 c1cc7000 c1c3db80 c1409064 00000013 c0111664 f0802000
3a00: 26a30000 c0111678 c1cc7000 c01a05d4 c1cc7000 c3ea0000 00000003 c1409064
3a20: 00000003 f0802000 26a30000 c0198080 00000000 00000000 00000003 c019894c
3a40: c1387850 00000003 c3ea3a80 c06417a0 c3ea3a80 40030193 00000000 c0cda8ec
3a60: 60030013 ffffffff c3ea3ab4 c40893f8 c3ea0000 c1408e04 c3ea3b8c c0100b00
3a80: e7db7020 00000003 00000000 00000000 80030013 b77d4760 00000000 00000001
3aa0: c40893f8 c3ea3b60 c1408e04 c3ea3b8c e7db7020 c3ea3ad0 c02340c4 c0cda8ec
3ac0: 60030013 ffffffff 00000051 c0cda8e8 c4088f00 c0167624 c122da30 187d4760
3ae0: c1388b00 80030013 e7db8b00 e7db8b00 c17a5dc0 c02353f0 00000000 00000000
3b00: 41b58ab3 c11a63b8 c01673fc c016580c 00000001 c3ea0004 26a30000 c3ea0000
3b20: c3ea3b84 c023523c c1d84b00 c0cda838 c17a5dc0 c02353f0 00000000 00000000
3b40: 00000000 c3ea0000 c1387020 c0cda8e8 00000001 c01640b4 00000001 c3ea0000
3b60: c3ea3c20 f6251f9e c3ea3b84 c181a338 b77d4774 c3ea3c20 c3ea0000 c3ea0000
3b80: c3ea3be0 c4073d18 c181a344 c0cd5ba8 80030013 c3ea000c 00000001 c3ea0000
3ba0: 41b58ab3 c11a889d c0cd59a8 00000003 c17a5dc0 c02353f0 ffffc000 c0235580
3bc0: c01641c8 c01640c4 00000000 00000001 c3ea0000 40030013 c38463c4 c14b7044
3be0: 00000001 c3ea3be0 c4088f00 c01641dc 40030013 c38463c4 40030013 c3846180
3c00: c14b7098 c0cda91c c14b7040 c01b5cc4 c01b5f2c 00000000 00000000 00000000
3c20: 00000001 00000000 00000000 00000001 c0d39640 f6251f9e 00000000 b77d4790
3c40: c181a338 c3ea3ce0 c3ea3ca0 c181a344 00000000 00000007 c181a4b8 c0cd5dac
3c60: 41b58ab3 c11e5383 c061d930 c023523c c17a5dc0 c02353f0 00000000 00000000
3c80: 41b58ab3 c11a8997 c0cd5cf0 c02353f0 00000000 00000000 00000000 c3ea0000
3ca0: c3846180 c06d95c4 00000001 c3ea0004 26a30000 00000007 c181a4b8 c02340c4
3cc0: c181a338 60030013 00000001 00000007 00000036 00000000 00000007 f6251f9e
3ce0: c181a338 b77d47a4 c181a4c4 c3f59000 00000036 c06ddb94 00000035 00000035
3d00: c3f59000 c3f59000 00000035 c0192a98 00000035 187d47a8 c3ea3e44 000003fe
3d20: 41b58ab3 c11eea53 c06dd92c c01b5eec b77d47ac c1448740 c3ea3dc0 c3ea3d80
3d40: 41b58ab3 c11a8f2c c0192900 c0cd5d9c c161de70 c0197ba4 26a20000 0000003e
3d60: 41b58ab3 c023523c c0cd5cf0 c0cda838 ffffffff c0cda838 00000000 c3ea0000
3d80: c17a5dc0 c02353f0 ffffc000 c0235580 c01641c8 c01640c4 00000000 00000001
3da0: c3ea0000 c3ea3f40 00000000 00000000 00000243 00000036 c3ea3dd4 f6251f9e
3dc0: c3ea3f40 c161de40 c3efed00 c3ea3f40 00000000 00000000 00000243 00000036
3de0: c161de70 c0194fd8 c3ea3e40 000016ca c14d1250 00000000 c3f59000 00000000
3e00: 187d47c4 c3f59000 00000017 c3ea0000 c1387020 c016580c 00000001 c3ea0004
3e20: 41b58ab3 c11a9104 c0194bb0 c02340c4 c1d80000 e7db8b00 00000000 c3ea0000
3e40: c3ea3ea0 c3f59000 00000400 c0165830 00000002 c01b5eec 00000000 00000002
3e60: 00000000 c3846180 c01828b4 c3ea3e6c c3ea3e6c c1d80000 c1512280 c3846188
3e80: c384640c 00000001 c3ea3f54 c0cd01b0 c1d64000 b77d47d8 c3ea3f54 c0167508
3ea0: 00000242 00000000 8bb3f10e 00000001 c2030035 00000001 00000000 00000000
3ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3ee0: 00000000 00000000 00000000 00000000 00000000 00000000 c17a5dc0 c02353f0
3f00: ffffc000 c0235580 c01641c8 c01640c4 00000000 00000001 c3ea0000 c3efec80
3f20: 60000013 c3ea000c 000004f8 c3846180 c3ea3f4c c01641dc c3efec80 60000013
3f40: 60000013 ffffc000 c3846180 f6251f9e c3ea0000 c3846180 c3efec80 00000000
3f60: c3846180 c0194bb0 c161de40 c1d67d20 c3846180 c0157eb0 00000000 c3846180
3f80: c3efeca0 c3efec0c 00000000 c3efec00 c0157c74 00000000 00000000 00000000
3fa0: 00000000 00000000 00000000 c01000fc 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<c0183be8>] (cpupri_find_fitness) from [<c017a378>] (find_lowest_rq+0x1bc/0x258)
[<c017a378>] (find_lowest_rq) from [<c017bcd8>] (push_rt_task.part.0+0xe8/0x23c)
[<c017bcd8>] (push_rt_task.part.0) from [<c017cfc8>] (rto_push_irq_work_func+0x7c/0xd8)
[<c017cfc8>] (rto_push_irq_work_func) from [<c026718c>] (irq_work_single+0x8c/0x140)
[<c026718c>] (irq_work_single) from [<c01e7300>] (flush_smp_call_function_queue+0x238/0x31c)
[<c01e7300>] (flush_smp_call_function_queue) from [<c01114e0>] (do_handle_IPI+0x29c/0x420)
[<c01114e0>] (do_handle_IPI) from [<c0111678>] (ipi_handler+0x14/0x20)
[<c0111678>] (ipi_handler) from [<c01a05d4>] (handle_percpu_devid_irq+0x8c/0x140)
[<c01a05d4>] (handle_percpu_devid_irq) from [<c0198080>] (handle_irq_desc+0x38/0x48)
[<c0198080>] (handle_irq_desc) from [<c019894c>] (handle_domain_irq+0x40/0x54)
[<c019894c>] (handle_domain_irq) from [<c06417a0>] (gic_handle_irq+0x88/0xa0)
[<c06417a0>] (gic_handle_irq) from [<c0100b00>] (__irq_svc+0x60/0xac)
Exception stack(0xc3ea3a80 to 0xc3ea3ac8)
3a80: e7db7020 00000003 00000000 00000000 80030013 b77d4760 00000000 00000001
3aa0: c40893f8 c3ea3b60 c1408e04 c3ea3b8c e7db7020 c3ea3ad0 c02340c4 c0cda8ec
3ac0: 60030013 ffffffff
[<c0100b00>] (__irq_svc) from [<c0cda8ec>] (_raw_spin_unlock_irqrestore+0x1c/0x70)
[<c0cda8ec>] (_raw_spin_unlock_irqrestore) from [<c0167624>] (try_to_wake_up+0x228/0x468)
[<c0167624>] (try_to_wake_up) from [<c0cd5ba8>] (rt_mutex_slowunlock+0x200/0x348)
[<c0cd5ba8>] (rt_mutex_slowunlock) from [<c0cd5dac>] (rt_spin_unlock+0xbc/0x104)
[<c0cd5dac>] (rt_spin_unlock) from [<c06ddb94>] (serial8250_console_write+0x268/0x39c)
[<c06ddb94>] (serial8250_console_write) from [<c0194fd8>] (printk_kthread_func+0x428/0x4c4)
[<c0194fd8>] (printk_kthread_func) from [<c0157eb0>] (kthread+0x23c/0x25c)
[<c0157eb0>] (kthread) from [<c01000fc>] (ret_from_fork+0x14/0x38)
Exception stack(0xc3ea3fb0 to 0xc3ea3ff8)
3fa0:                                     00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e1a00008 e28dd014 e8bd4ff0 ea00004a (e7f001f2) 
---[ end trace 0000000000000002 ]---
