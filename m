Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3C520FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbiEJIp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiEJIpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:45:23 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AAC94A3C5;
        Tue, 10 May 2022 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:From:Subject; bh=Otu39
        E8gyU2HR3+h9CQAvZCu8WM7iS9AT0eNj6iRL/0=; b=RGKj0LIIGF2ai7ZOajCix
        EheFJnuQemsVlndMh3ODQ0MeO2QGx5W6hRohfDLPq7SV8WL3AGwnd8Ijtcwh4CYk
        OXkz3wvUBMsHCMF/dACA3jrgv5t/jcj2s1r23PyisoCLrANuN0TKZ9QmJgv19HXK
        9BnAXZz9SV+ygpR1ad8Nzw=
Received: from [192.168.3.102] (unknown [218.201.129.19])
        by smtp8 (Coremail) with SMTP id DMCowABnHhMQJXpibiEZBw--.39297S2;
        Tue, 10 May 2022 16:40:49 +0800 (CST)
Message-ID: <45d7cbbe-c667-e2d5-e1e4-8a81643e8011@163.com>
Date:   Tue, 10 May 2022 16:40:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev
From:   qianfan <qianfanguijin@163.com>
Subject: BUG REPORT: system dead when offline cpu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowABnHhMQJXpibiEZBw--.39297S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfWrWUJw4rAF48KrW7GF43trb_yoW5Xw4kAo
        W3Zr1UGrWkK34DGr1UA3W5Jr15XrWjvF1xJr1Ykw4UJw17JrWUGr13Ar45Jr13XF18KFnx
        Ar1jyw1UA3yxGa1kn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3miiDUUUU
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXBH87VXl2wi-YAAAsg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I had a SUN8I R40 board running with linux master 
code(9be9ed2612b5aedb52a2c240edb1630b6b743cb6).
The uart console doesn't response anything but the heartbeat led are 
work fine (I have tested many times
and sometimes the LED stops flashing).

Next is the kernel log printed on uart console:


root@ubuntu:/sys/devices/system/cpu/cpu3# echo 0 > online
root@ubuntu:/sys/devices/system/cpu/cpu3# [   65.735752] rcu: INFO: 
rcu_sched detected stalls on CPUs/tasks:
[   65.741722] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=966
[   65.749918]  (detected by 1, t=2103 jiffies, g=13, q=20)
[   65.755230] Sending NMI from CPU 1 to CPUs 0:
[  128.845759] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  128.851762] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=2029
[  128.860064]  (detected by 1, t=8414 jiffies, g=13, q=33)
[  128.865376] Sending NMI from CPU 1 to CPUs 0:
[  191.955748] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  191.961698] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=3092
[  191.969967]  (detected by 1, t=14725 jiffies, g=13, q=100)
[  191.975460] Sending NMI from CPU 1 to CPUs 0:
[  255.065746] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  255.071674] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=4155
[  255.079944]  (detected by 1, t=21036 jiffies, g=13, q=108)
[  255.085444] Sending NMI from CPU 1 to CPUs 0:
[  318.175748] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  318.181715] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=5218
[  318.190005]  (detected by 1, t=27347 jiffies, g=13, q=207)
[  318.195556] Sending NMI from CPU 1 to CPUs 0:
[  381.285752] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  381.291735] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=6280
[  381.300021]  (detected by 1, t=33658 jiffies, g=13, q=311)
[  381.305507] Sending NMI from CPU 1 to CPUs 0:
[  391.313614] rcu: rcu_sched kthread timer wakeup didn't happen for 
1004 jiffies! g13 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[  391.324572] rcu:     Possible timer handling issue on cpu=1 
timer-softirq=1269
[  391.331533] rcu: rcu_sched kthread starved for 1005 jiffies! g13 f0x0 
RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
[  391.341529] rcu:     Unless rcu_sched kthread gets sufficient CPU 
time, OOM is now expected behavior.
[  391.350483] rcu: RCU grace-period kthread stack dump:
[  391.355555] task:rcu_sched       state:I stack:    0 pid:   11 
ppid:     2 flags:0x00000000
[  391.363990]  __schedule from schedule+0x48/0xb4
[  391.368549]  schedule from schedule_timeout+0x1c4/0x2bc
[  391.373796]  schedule_timeout from rcu_gp_fqs_loop+0x260/0x2d0
[  391.379653]  rcu_gp_fqs_loop from rcu_gp_kthread+0x68/0x10c
[  391.385243]  rcu_gp_kthread from kthread+0xd8/0xf4
[  391.390053]  kthread from ret_from_fork+0x14/0x2c
[  391.394776] Exception stack(0xf0845fb0 to 0xf0845ff8)
[  391.399851] 5fa0:                                     00000000 
00000000 00000000 00000000
[  391.408042] 5fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[  391.416226] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  391.422855] rcu: Stack dump where RCU GP kthread last ran:
[  391.428340] NMI backtrace for cpu 1
[  391.431850] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
5.18.0-rc6-30031-g9be9ed2612b5-dirty #47
[  391.440537] Hardware name: Wisdom T3 based CCT Family
[  391.445589]  unwind_backtrace from show_stack+0x10/0x14
[  391.450828]  show_stack from dump_stack_lvl+0x40/0x4c
[  391.455895]  dump_stack_lvl from nmi_cpu_backtrace+0xe0/0x100
[  391.461667]  nmi_cpu_backtrace from 
nmi_trigger_cpumask_backtrace+0xd8/0x120
[  391.468732]  nmi_trigger_cpumask_backtrace from 
rcu_check_gp_kthread_starvation+0x144/0x160
[  391.477092]  rcu_check_gp_kthread_starvation from 
rcu_sched_clock_irq+0x59c/0xa0c
[  391.484598]  rcu_sched_clock_irq from update_process_times+0x94/0xb4
[  391.490962]  update_process_times from tick_sched_timer+0x4c/0xb0
[  391.497186]  tick_sched_timer from __hrtimer_run_queues+0x15c/0x20c
[  391.503637]  __hrtimer_run_queues from hrtimer_interrupt+0x104/0x2bc
[  391.510037]  hrtimer_interrupt from arch_timer_handler_phys+0x28/0x30
[  391.516508]  arch_timer_handler_phys from 
handle_percpu_devid_irq+0x78/0x124
[  391.523573]  handle_percpu_devid_irq from 
generic_handle_domain_irq+0x44/0x88
[  391.530725]  generic_handle_domain_irq from gic_handle_irq+0x74/0x88
[  391.537146]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
[  391.543356]  generic_handle_arch_irq from call_with_stack+0x18/0x20
[  391.549644]  call_with_stack from __irq_svc+0x98/0xb0
[  391.554705] Exception stack(0xf084df60 to 0xf084dfa8)
[  391.559764] df60: 0001ef9c 00000000 00000001 c0116c40 00000002 
c0c04f0c c0c04f54 00000001
[  391.567940] df80: c0cdf800 c0934ae4 00000000 00000000 c0d0afc8 
f084dfb0 c01076cc c01076d0
[  391.576110] dfa0: 600e0013 ffffffff
[  391.579613]  __irq_svc from arch_cpu_idle+0x38/0x3c
[  391.584606]  arch_cpu_idle from default_idle_call+0x1c/0x2c
[  391.590360]  default_idle_call from do_idle+0xc0/0x11c
[  391.595615]  do_idle from cpu_startup_entry+0x18/0x1c
[  391.600788]  cpu_startup_entry from secondary_start_kernel+0x148/0x150
[  391.607323]  secondary_start_kernel from 0x40101580
[  454.635777] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  454.641829] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=7542
[  454.650144]  (detected by 1, t=40993 jiffies, g=13, q=413)
[  454.655631] Sending NMI from CPU 1 to CPUs 0:
[  517.745746] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  517.751699] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=8605
[  517.759969]  (detected by 1, t=47304 jiffies, g=13, q=461)
[  517.765464] Sending NMI from CPU 1 to CPUs 0:
[  580.855747] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  580.861704] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=9668
[  580.869979]  (detected by 1, t=53615 jiffies, g=13, q=530)
[  580.875488] Sending NMI from CPU 1 to CPUs 0:
[  643.965747] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  643.971689] rcu:     0-...0: (1 GPs behind) idle=f29/1/0x40000000 
softirq=3155/3155 fqs=10731
[  643.980100]  (detected by 1, t=59926 jiffies, g=13, q=538)
[  643.985721] Sending NMI from CPU 1 to CPUs 0:
[  654.005112] 8<--- cut here ---
[  654.008362] Unable to handle kernel paging request at virtual address 
f0da6244
[  654.015621] [f0da6244] *pgd=42908811, *pte=00000000, *ppte=00000000
[  654.021937] Internal error: Oops: 7 [#1] SMP ARM
[  654.026566] Modules linked in:
[  654.029673] CPU: 1 PID: 294 Comm: bash Not tainted 
5.18.0-rc6-30031-g9be9ed2612b5-dirty #47
[  654.038099] Hardware name: Wisdom T3 based CCT Family
[  654.043163] PC is at __schedule+0x254/0x638
[  654.047367] LR is at __schedule+0x24c/0x638
[  654.051567] pc : [<c07ca874>]    lr : [<c07ca86c>]    psr: 80070113
[  654.057853] sp : f0da5d18  ip : f0da5d18  fp : f0da5d64
[  654.063085] r10: 00000000  r9 : c109455c  r8 : c1c038b8
[  654.068320] r7 : 00000000  r6 : c0c07c40  r5 : c1c03300  r4 : eefba0c0
[  654.074859] r3 : f0da5d34  r2 : 9b3d6701  r1 : c1c03300  r0 : eefc50c0
[  654.081389] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment none
[  654.088523] Control: 10c5387d  Table: 4299806a  DAC: 00000051
[  654.094262] Register r0 information: non-slab/vmalloc memory
[  654.099953] Register r1 information: slab task_struct start c1c03300 
pointer offset 0
[  654.108010] Register r2 information: non-paged memory
[  654.113064] Register r3 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  654.123778] Register r4 information: non-slab/vmalloc memory
[  654.129444] Register r5 information: slab task_struct start c1c03300 
pointer offset 0
[  654.137296] Register r6 information: non-slab/vmalloc memory
[  654.142953] Register r7 information: NULL pointer
[  654.147655] Register r8 information: slab task_struct start c1c03300 
pointer offset 1464
[  654.155755] Register r9 information: slab kmalloc-64 start c1094540 
pointer offset 28 size 64
[  654.164329] Register r10 information: NULL pointer
[  654.169119] Register r11 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  654.179902] Register r12 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  654.190686] Process bash (pid: 294, stack limit = 0x7f2f1c0a)
[  654.196439] Stack: (0xf0da5d18 to 0xf0da6000)
[  654.200800] 5d00: c1bfe400 c1bfe434
[  654.208976] 5d20: 00000000 f0da5d28 00000000 00000000 00000000 
f0da5d34 f0da5d34 9b3d6701
[  654.217151] 5d40: 00000000 00000000 00000000 f0da5d4c f0da5d4c 
9b3d6701 00000000 c2bf0800
[  654.225328] 5d60: c1c03300 c2bf0874 c2963640 00000000 00000000 
00000000 00000000 c015a2b0
[  654.233504] 5d80: 00000000 c2963640 00000000 c04482ec 00005500 
00000005 00001cb2 00000a3b
[  654.241681] 5da0: 7f1c0300 9b3d6701 f0da5dfc 00000004 f0da5dfc 
00000001 f0da5e04 bea10104
[  654.249857] 5dc0: c1c03300 00000000 f0da5dfc c0242190 0000000a 
00000000 00000000 c2bf0800
[  654.258034] 5de0: c2b42c2a f0da5dfc f0da5e00 f0da5e04 f0da5e08 
f0da5e0c f0da5e10 00000001
[  654.266211] 5e00: 1a131100 170f1200 00000000 0001c200 c1c03300 
bea10100 c12e0000 00000000
[  654.274389] 5e20: 00000fff c0d188c8 c183046c 0000002a c2b42c2a 
c0460ffc 00005400 a0080013
[  654.282564] 5e40: 00000000 c2bf0974 00000001 f0da5e70 00000000 
00000001 00000004 c1c03300
[  654.290741] 5e60: 60080013 c015a1a4 00000004 f0da5e70 00000000 
00000000 00000000 f0da5e7c
[  654.298917] 5e80: c10acf00 eefba100 68bf4301 0000000a 00000000 
c04dbed8 00000000 eefba0c0
[  654.307095] 5ea0: c10acf00 eefba100 c0b5b0c0 c1bc1100 00000000 
eefba0c0 c1c03300 c10acc80
[  654.315271] 5ec0: c10acc90 c1c03300 c10acc80 c10acc80 c1c038bc 
c0101258 c1c03300 00000000
[  654.323448] 5ee0: 00000002 00004004 00000000 c07caca0 2e45f000 
c1c03300 b6f4c000 9b3d6701
[  654.331625] 5f00: 000e1408 00000002 00010000 00000000 00000000 
f0da5f08 00000000 00000000
[  654.339802] 5f20: c2a55540 00000000 00000000 00000000 00000000 
00000000 00000000 00004004
[  654.347979] 5f40: 00000000 00000000 bea0feac 9b3d6701 0000002a 
9b3d6701 c202b180 00000001
[  654.356157] 5f60: bea10104 00000000 bea10084 00000051 c1c03300 
0000014f 00000001 c024269c
[  654.364334] 5f80: 00000000 bea10084 00000008 00000003 00000000 
bea10040 bea10084 0000014f
[  654.372512] 5fa0: c01002c4 c0100060 00000000 bea10040 00000001 
bea10104 00000000 00000000
[  654.380688] 5fc0: 00000000 bea10040 bea10084 0000014f bea10084 
00000001 bea10100 00000001
[  654.388865] 5fe0: 0000014f bea10030 b6e8801b b6e0e6f6 00080030 
00000001 00000000 00000000
[  654.397045]  __schedule from 0xc2bf0874
[  654.400933] Code: ebe4da6e ebe5db3b e51b3030 e51b2028 (e5933510)
[  654.407175] ---[ end trace 0000000000000000 ]---
[  655.188848] ------------[ cut here ]------------
[  655.193516] kernel BUG at kernel/sched/core.c:6407!
[  655.198414] Internal error: Oops - BUG: 0 [#2] SMP ARM
[  655.203584] Modules linked in:
[  655.206681] CPU: 1 PID: 294 Comm: bash Tainted: G D           
5.18.0-rc6-30031-g9be9ed2612b5-dirty #47
[  655.216419] Hardware name: Wisdom T3 based CCT Family
[  655.221469] PC is at do_task_dead+0x44/0x48
[  655.225684] LR is at __schedule+0x24c/0x638
[  655.229913] pc : [<c0146790>]    lr : [<c07ca86c>]    psr: 600d0013
[  655.236181] sp : f0da5ba0  ip : f0da5b50  fp : f0da5ba4
[  655.241463] r10: 00000000  r9 : c1c0381c  r8 : f0da5bac
[  655.246798] r7 : c1ab9700  r6 : c10a8000  r5 : c1c039a4  r4 : c1c03300
[  655.253455] r3 : 9b3d6701  r2 : 9b3d6701  r1 : c1c03300  r0 : eefc50c0
[  655.259995] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment none
[  655.267134] Control: 10c5387d  Table: 41aac06a  DAC: 00000051
[  655.272874] Register r0 information: non-slab/vmalloc memory
[  655.278535] Register r1 information: slab task_struct start c1c03300 
pointer offset 0
[  655.286379] Register r2 information: non-paged memory
[  655.291446] Register r3 information: non-paged memory
[  655.296522] Register r4 information: slab task_struct start c1c03300 
pointer offset 0
[  655.304430] Register r5 information: slab task_struct start c1c03300 
pointer offset 1700
[  655.312544] Register r6 information: slab task_struct start c10a8000 
pointer offset 0
[  655.320514] Register r7 information: slab mm_struct start c1ab96c0 
pointer offset 64 size 168
[  655.329068] Register r8 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  655.339871] Register r9 information: slab task_struct start c1c03300 
pointer offset 1308
[  655.348096] Register r10 information: NULL pointer
[  655.352891] Register r11 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  655.363683] Register r12 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  655.374477] Process bash (pid: 294, stack limit = 0x00000000)
[  655.380228] Stack: (0xf0da5ba0 to 0xf0da6000)
[  655.384607] 5ba0: 00000000 c01218c4 f0da5bbc f0da5bac f0da5bac 
9b3d6701 c0ce53dc f0da5cc8
[  655.392794] 5bc0: 00000000 c0121c50 c0ce53dc c010a69c f0da4000 
0000000b 00000000 60070113
[  655.400978] 5be0: 00000008 00000001 c092e66c c092e664 c0c04f60 
c016597c e5933510 650001a6
[  655.409166] 5c00: 64346562 20653661 35656265 62336264 31356520 
33303362 35652030 30326231
[  655.417351] 5c20: 28203832 33393565 30313533 c0002029 f0da5c54 
9b3d6701 c1c03300 f0da6244
[  655.425538] 5c40: 00000007 c1ab96c0 c0930094 00000214 00000007 
c1ab9700 00010000 c07c3604
[  655.433723] 5c60: f0da6244 c0111f78 f0da5cc8 2e45f000 f0da5cac 
c014466c 00000000 c0c09764
[  655.441910] 5c80: 00000007 c0111c78 f0da6244 f0da5cc8 c1c03300 
00000000 f0da5d64 c01120f4
[  655.450095] 5ca0: f0da5cf0 00000003 00000000 c015be58 c07ca874 
80070113 ffffffff f0da5cfc
[  655.458283] 5cc0: c1c038b8 c0100aec eefc50c0 c1c03300 9b3d6701 
f0da5d34 eefba0c0 c1c03300
[  655.466468] 5ce0: c0c07c40 00000000 c1c038b8 c109455c 00000000 
f0da5d64 f0da5d18 f0da5d18
[  655.474655] 5d00: c07ca86c c07ca874 80070113 ffffffff 00000051 
c07ca86c c1bfe400 c1bfe434
[  655.482840] 5d20: 00000000 f0da5d28 00000000 00000000 00000000 
f0da5d34 f0da5d34 9b3d6701
[  655.491027] 5d40: 00000000 00000000 00000000 f0da5d4c f0da5d4c 
9b3d6701 00000000 c2bf0800
[  655.499211] 5d60: c1c03300 c2bf0874 c2963640 00000000 00000000 
00000000 00000000 c015a2b0
[  655.507399] 5d80: 00000000 c2963640 00000000 c04482ec 00005500 
00000005 00001cb2 00000a3b
[  655.515584] 5da0: 7f1c0300 9b3d6701 f0da5dfc 00000004 f0da5dfc 
00000001 f0da5e04 bea10104
[  655.523772] 5dc0: c1c03300 00000000 f0da5dfc c0242190 0000000a 
00000000 00000000 c2bf0800
[  655.531958] 5de0: c2b42c2a f0da5dfc f0da5e00 f0da5e04 f0da5e08 
f0da5e0c f0da5e10 00000001
[  655.540146] 5e00: 1a131100 170f1200 00000000 0001c200 c1c03300 
bea10100 c12e0000 00000000
[  655.548333] 5e20: 00000fff c0d188c8 c183046c 0000002a c2b42c2a 
c0460ffc 00005400 a0080013
[  655.556521] 5e40: 00000000 c2bf0974 00000001 f0da5e70 00000000 
00000001 00000004 c1c03300
[  655.564706] 5e60: 60080013 c015a1a4 00000004 f0da5e70 00000000 
00000000 00000000 f0da5e7c
[  655.572894] 5e80: c10acf00 eefba100 68bf4301 0000000a 00000000 
c04dbed8 00000000 eefba0c0
[  655.581080] 5ea0: c10acf00 eefba100 c0b5b0c0 c1bc1100 00000000 
eefba0c0 c1c03300 c10acc80
[  655.589270] 5ec0: c10acc90 c1c03300 c10acc80 c10acc80 c1c038bc 
c0101258 c1c03300 00000000
[  655.597457] 5ee0: 00000002 00004004 00000000 c07caca0 2e45f000 
c1c03300 b6f4c000 9b3d6701
[  655.605646] 5f00: 000e1408 00000002 00010000 00000000 00000000 
f0da5f08 00000000 00000000
[  655.613830] 5f20: c2a55540 00000000 00000000 00000000 00000000 
00000000 00000000 00004004
[  655.622019] 5f40: 00000000 00000000 bea0feac 9b3d6701 0000002a 
9b3d6701 c202b180 00000001
[  655.630205] 5f60: bea10104 00000000 bea10084 00000051 c1c03300 
0000014f 00000001 c024269c
[  655.638395] 5f80: 00000000 bea10084 00000008 00000003 00000000 
bea10040 bea10084 0000014f
[  655.646580] 5fa0: c01002c4 c0100060 00000000 bea10040 00000001 
bea10104 00000000 00000000
[  655.654770] 5fc0: 00000000 bea10040 bea10084 0000014f bea10084 
00000001 bea10100 00000001
[  655.662956] 5fe0: 0000014f bea10030 b6e8801b b6e0e6f6 00080030 
00000001 00000000 00000000
[  655.671149]  do_task_dead from do_exit+0x6e4/0xa14
[  655.675955]  do_exit from make_task_dead+0x5c/0xfc
[  655.680760]  make_task_dead from die+0x418/0x474
[  655.685398]  die from die_kernel_fault+0x64/0x74
[  655.690047]  die_kernel_fault from do_bad_area+0x0/0x80
[  655.695350] Code: e3a00000 e3833902 e5843214 eb1a0fa3 (e7f001f2)
[  655.701468] ---[ end trace 0000000000000000 ]---
[  655.706099] Fixing recursive fault but reboot is needed!
[  655.711436] ------------[ cut here ]------------
[  655.716071] WARNING: CPU: 1 PID: 294 at lib/refcount.c:22 
make_task_dead+0xec/0xfc
[  655.723643] refcount_t: saturated; leaking memory.
[  655.728435] Modules linked in:
[  655.731505] CPU: 1 PID: 294 Comm: bash Tainted: G D           
5.18.0-rc6-30031-g9be9ed2612b5-dirty #47
[  655.741239] Hardware name: Wisdom T3 based CCT Family
[  655.746291]  unwind_backtrace from show_stack+0x10/0x14
[  655.751532]  show_stack from dump_stack_lvl+0x40/0x4c
[  655.756603]  dump_stack_lvl from __warn+0xec/0xf0
[  655.761332]  __warn from warn_slowpath_fmt+0x70/0xb4
[  655.766335]  warn_slowpath_fmt from make_task_dead+0xec/0xfc
[  655.772052]  make_task_dead from die+0x418/0x474
[  655.776729]  die from do_undefinstr+0x90/0x1b0
[  655.781271]  do_undefinstr from __und_svc_finish+0x0/0x24
[  655.786673] Exception stack(0xf0da5b50 to 0xf0da5b98)
[  655.791723] 5b40:                                     eefc50c0 
c1c03300 9b3d6701 9b3d6701
[  655.799904] 5b60: c1c03300 c1c039a4 c10a8000 c1ab9700 f0da5bac 
c1c0381c 00000000 f0da5ba4
[  655.808086] 5b80: f0da5b50 f0da5ba0 c07ca86c c0146790 600d0013 ffffffff
[  655.814802]  __und_svc_finish from do_task_dead+0x44/0x48
[  655.820403]  do_task_dead from do_exit+0x6e4/0xa14
[  655.825320]  do_exit from make_task_dead+0x5c/0xfc
[  655.830117]  make_task_dead from die+0x418/0x474
[  655.834740]  die from die_kernel_fault+0x64/0x74
[  655.839366]  die_kernel_fault from do_bad_area+0x0/0x80
[  655.844606] ---[ end trace 0000000000000000 ]---
[  655.849327] ------------[ cut here ]------------
[  655.853961] WARNING: CPU: 1 PID: 0 at lib/refcount.c:28 
finish_task_switch+0x208/0x268
[  655.861929] refcount_t: underflow; use-after-free.
[  655.866728] Modules linked in:
[  655.869802] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D W         
5.18.0-rc6-30031-g9be9ed2612b5-dirty #47
[  655.879854] Hardware name: Wisdom T3 based CCT Family
[  655.884901]  unwind_backtrace from show_stack+0x10/0x14
[  655.890131]  show_stack from dump_stack_lvl+0x40/0x4c
[  655.895188]  dump_stack_lvl from __warn+0xec/0xf0
[  655.899900]  __warn from warn_slowpath_fmt+0x70/0xb4
[  655.904875]  warn_slowpath_fmt from finish_task_switch+0x208/0x268
[  655.911069]  finish_task_switch from __schedule+0x24c/0x638
[  655.916653]  __schedule from schedule_idle+0x20/0x68
[  655.921631]  schedule_idle from do_idle+0xf0/0x11c
[  655.926439]  do_idle from cpu_startup_entry+0x18/0x1c
[  655.931507]  cpu_startup_entry from secondary_start_kernel+0x148/0x150
[  655.938053]  secondary_start_kernel from 0x40101580
[  655.942970] ---[ end trace 0000000000000000 ]---
[  661.438827] ------------[ cut here ]------------
[  661.443469] kernel BUG at kernel/sched/core.c:6407!
[  661.448349] Internal error: Oops - BUG: 0 [#3] SMP ARM
[  661.453490] Modules linked in:
[  661.456572] CPU: 1 PID: 294 Comm: bash Tainted: G      D W         
5.18.0-rc6-30031-g9be9ed2612b5-dirty #47
[  661.466387] Hardware name: Wisdom T3 based CCT Family
[  661.471433] PC is at do_task_dead+0x44/0x48
[  661.475628] LR is at __schedule+0x24c/0x638
[  661.479824] pc : [<c0146790>]    lr : [<c07ca86c>]    psr: 600e0013
[  661.486097] sp : f0da5a88  ip : f0da5a38  fp : f0da5a8c
[  661.491323] r10: c0146790  r9 : c1c03300  r8 : f0da5af6
[  661.496551] r7 : f0da5b50  r6 : 0000000b  r5 : c1c039a4  r4 : c1c03300
[  661.503082] r3 : 9b3d6701  r2 : 9b3d6701  r1 : c1c03300  r0 : eefc50c0
[  661.509607] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
Segment none
[  661.516756] Control: 10c5387d  Table: 418d406a  DAC: 00000051
[  661.522535] Register r0 information: non-slab/vmalloc memory
[  661.528233] Register r1 information: slab task_struct start c1c03300 
pointer offset 0
[  661.536127] Register r2 information: non-paged memory
[  661.541179] Register r3 information: non-paged memory
[  661.546233] Register r4 information: slab task_struct start c1c03300 
pointer offset 0
[  661.554080] Register r5 information: slab task_struct start c1c03300 
pointer offset 1700
[  661.562176] Register r6 information: non-paged memory
[  661.567235] Register r7 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  661.577953] Register r8 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  661.588672] Register r9 information: slab task_struct start c1c03300 
pointer offset 0
[  661.596543] Register r10 information: non-slab/vmalloc memory
[  661.602289] Register r11 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  661.613070] Register r12 information: 2-page vmalloc region starting 
at 0xf0da4000 allocated at kernel_clone+0xb4/0x398
[  661.623852] Process bash (pid: 294, stack limit = 0x00000000)
[  661.629597] Stack: (0xf0da5a88 to 0xf0da6000)
[  661.633959] 5a80:                   00000000 c0121cd8 c0ce53dc 
c010a69c 00000000 0000000b
[  661.642200] 5aa0: 00000006 600d0093 00000008 00000001 c092e66c 
c092e664 00000001 00000000
[  661.650438] 5ac0: e7f001f2 65000000 30306133 20303030 33383365 
32303933 38356520 31323334
[  661.658664] 5ae0: 62652034 66306131 28203361 30663765 32663130 
c0002029 5e103f02 9b3d6701
[  661.666891] 5b00: 5e103f02 07f001f0 f0da5b50 e7f001f2 c0146790 
00000000 c1c03300 00000000
[  661.675110] 5b20: f0da5ba4 c010a8c0 c0146790 00000000 00000006 
c10abb80 c0146794 600d0013
[  661.683329] 5b40: ffffffff f0da5b84 f0da5bac c0100c3c eefc50c0 
c1c03300 9b3d6701 9b3d6701
[  661.691542] 5b60: c1c03300 c1c039a4 c10a8000 c1ab9700 f0da5bac 
c1c0381c 00000000 f0da5ba4
[  661.699758] 5b80: f0da5b50 f0da5ba0 c07ca86c c0146790 600d0013 
ffffffff 00000051 c0146790
[  661.707967] 5ba0: 00000000 c01218c4 f0da5bbc f0da5bac f0da5bac 
9b3d6701 c0ce53dc f0da5cc8
[  661.716180] 5bc0: 00000000 c0121c50 c0ce53dc c010a69c f0da4000 
0000000b 00000000 60070113
[  661.724389] 5be0: 00000008 00000001 c092e66c c092e664 c0c04f60 
c016597c e5933510 650001a6
[  661.732599] 5c00: 64346562 20653661 35656265 62336264 31356520 
33303362 35652030 30326231
[  661.740806] 5c20: 28203832 33393565 30313533 c0002029 f0da5c54 
9b3d6701 c1c03300 f0da6244
[  661.749015] 5c40: 00000007 c1ab96c0 c0930094 00000214 00000007 
c1ab9700 00010000 c07c3604
[  661.757218] 5c60: f0da6244 c0111f78 f0da5cc8 2e45f000 f0da5cac 
c014466c 00000000 c0c09764
[  661.765424] 5c80: 00000007 c0111c78 f0da6244 f0da5cc8 c1c03300 
00000000 f0da5d64 c01120f4
[  661.773626] 5ca0: f0da5cf0 00000003 00000000 c015be58 c07ca874 
80070113 ffffffff f0da5cfc
[  661.781833] 5cc0: c1c038b8 c0100aec eefc50c0 c1c03300 9b3d6701 
f0da5d34 eefba0c0 c1c03300
[  661.790033] 5ce0: c0c07c40 00000000 c1c038b8 c109455c 00000000 
f0da5d64 f0da5d18 f0da5d18
[  661.798238] 5d00: c07ca86c c07ca874 80070113 ffffffff 00000051 
c07ca86c c1bfe400 c1bfe434
[  661.806437] 5d20: 00000000 f0da5d28 00000000 00000000 00000000 
f0da5d34 f0da5d34 9b3d6701
[  661.814641] 5d40: 00000000 00000000 00000000 f0da5d4c f0da5d4c 
9b3d6701 00000000 c2bf0800
[  661.822839] 5d60: c1c03300 c2bf0874 c2963640 00000000 00000000 
00000000 00000000 c015a2b0
[  661.831043] 5d80: 00000000 c2963640 00000000 c04482ec 00005500 
00000005 00001cb2 00000a3b
[  661.839243] 5da0: 7f1c0300 9b3d6701 f0da5dfc 00000004 f0da5dfc 
00000001 f0da5e04 bea10104
[  661.847444] 5dc0: c1c03300 00000000 f0da5dfc c0242190 0000000a 
00000000 00000000 c2bf0800
[  661.855643] 5de0: c2b42c2a f0da5dfc f0da5e00 f0da5e04 f0da5e08 
f0da5e0c f0da5e10 00000001
[  661.863844] 5e00: 1a131100 170f1200 00000000 0001c200 c1c03300 
bea10100 c12e0000 00000000
[  661.872043] 5e20: 00000fff c0d188c8 c183046c 0000002a c2b42c2a 
c0460ffc 00005400 a0080013
[  661.880243] 5e40: 00000000 c2bf0974 00000001 f0da5e70 00000000 
00000001 00000004 c1c03300
[  661.888439] 5e60: 60080013 c015a1a4 00000004 f0da5e70 00000000 
00000000 00000000 f0da5e7c
[  661.896639] 5e80: c10acf00 eefba100 68bf4301 0000000a 00000000 
c04dbed8 00000000 eefba0c0
[  661.904835] 5ea0: c10acf00 eefba100 c0b5b0c0 c1bc1100 00000000 
eefba0c0 c1c03300 c10acc80
[  661.913035] 5ec0: c10acc90 c1c03300 c10acc80 c10acc80 c1c038bc 
c0101258 c1c03300 00000000
[  661.921231] 5ee0: 00000002 00004004 00000000 c07caca0 2e45f000 
c1c03300 b6f4c000 9b3d6701
[  661.929430] 5f00: 000e1408 00000002 00010000 00000000 00000000 
f0da5f08 00000000 00000000
[  661.937624] 5f20: c2a55540 00000000 00000000 00000000 00000000 
00000000 00000000 00004004
[  661.945823] 5f40: 00000000 00000000 bea0feac 9b3d6701 0000002a 
9b3d6701 c202b180 00000001
[  661.954019] 5f60: bea10104 00000000 bea10084 00000051 c1c03300 
0000014f 00000001 c024269c
[  661.962218] 5f80: 00000000 bea10084 00000008 00000003 00000000 
bea10040 bea10084 0000014f
[  661.970412] 5fa0: c01002c4 c0100060 00000000 bea10040 00000001 
bea10104 00000000 00000000
[  661.978611] 5fc0: 00000000 bea10040 bea10084 0000014f bea10084 
00000001 bea10100 00000001
[  661.986805] 5fe0: 0000014f bea10030 b6e8801b b6e0e6f6 00080030 
00000001 00000000 00000000
[  661.995003]  do_task_dead from make_task_dead+0xe4/0xfc
[  662.000245]  make_task_dead from die+0x418/0x474
[  662.004876]  die from do_undefinstr+0x90/0x1b0
[  662.009336]  do_undefinstr from __und_svc_finish+0x0/0x24
[  662.014761] Exception stack(0xf0da5b50 to 0xf0da5b98)
[  662.019836] 5b40:                                     eefc50c0 
c1c03300 9b3d6701 9b3d6701
[  662.028028] 5b60: c1c03300 c1c039a4 c10a8000 c1ab9700 f0da5bac 
c1c0381c 00000000 f0da5ba4
[  662.036213] 5b80: f0da5b50 f0da5ba0 c07ca86c c0146790 600d0013 ffffffff
[  662.042841]  __und_svc_finish from do_task_dead+0x44/0x48
[  662.048259]  do_task_dead from do_exit+0x6e4/0xa14
[  662.053073]  do_exit from make_task_dead+0x5c/0xfc
[  662.057900]  make_task_dead from die+0x418/0x474
[  662.062606]  die from die_kernel_fault+0x64/0x74
[  662.067372]  die_kernel_fault from do_bad_area+0x0/0x80
[  662.072611] Code: e3a00000 e3833902 e5843214 eb1a0fa3 (e7f001f2)
[  662.078700] ---[ end trace 0000000000000000 ]---
[  662.083313] Fixing recursive fault but reboot is needed!


Thanks.

