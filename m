Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B527C589628
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiHDCfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbiHDCeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:34:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065865FAE7;
        Wed,  3 Aug 2022 19:34:49 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lyt5q61WnzjXfy;
        Thu,  4 Aug 2022 10:31:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 10:34:47 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 10:34:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 2/2] sched/debug: Show the registers of 'current' in dump_cpu_task()
Date:   Thu, 4 Aug 2022 10:34:20 +0800
Message-ID: <20220804023420.1663-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220804023420.1663-1-thunder.leizhen@huawei.com>
References: <20220804023420.1663-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For architectures that do not support NMI, registers is not printed.
However, this information is useful for analyzing the root cause of the
fault. Fortunately, when the stack traces of current is dumped in the
interrupt handler, we can take it through get_irq_regs() and display it
through show_regs(). Further, show_regs() unwind the call trace based on
'regs', the worthless call trace associated with interrupt handling will
be omitted, this helps us to focus more on the problem. By the way, for
architectures that support NMI, it also avoids generating an unnecessary
NMI in this case.

This is an example of rcu self-detected stall on arm64:
[   27.501721] rcu: INFO: rcu_preempt self-detected stall on CPU
[   27.502238] rcu:     0-....: (1250 ticks this GP) idle=4f7/1/0x4000000000000000 softirq=2594/2594 fqs=619
[   27.502632]  (t=1251 jiffies g=2989 q=29 ncpus=4)
[   27.503845] CPU: 0 PID: 306 Comm: test0 Not tainted 5.19.0-rc7-00009-g1c1a6c29ff99-dirty #46
[   27.504732] Hardware name: linux,dummy-virt (DT)
[   27.504947] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   27.504998] pc : arch_counter_read+0x18/0x24
[   27.505301] lr : arch_counter_read+0x18/0x24
[   27.505328] sp : ffff80000b29bdf0
[   27.505345] x29: ffff80000b29bdf0 x28: 0000000000000000 x27: 0000000000000000
[   27.505475] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   27.505553] x23: 0000000000001f40 x22: ffff800009849c48 x21: 000000065f871ae0
[   27.505627] x20: 00000000000025ec x19: ffff80000a6eb300 x18: ffffffffffffffff
[   27.505654] x17: 0000000000000001 x16: 0000000000000000 x15: ffff80000a6d0296
[   27.505681] x14: ffffffffffffffff x13: ffff80000a29bc18 x12: 0000000000000426
[   27.505709] x11: 0000000000000162 x10: ffff80000a2f3c18 x9 : ffff80000a29bc18
[   27.505736] x8 : 00000000ffffefff x7 : ffff80000a2f3c18 x6 : 00000000759bd013
[   27.505761] x5 : 01ffffffffffffff x4 : 0002dc6c00000000 x3 : 0000000000000017
[   27.505787] x2 : 00000000000025ec x1 : ffff80000b29bdf0 x0 : 0000000075a30653
[   27.505937] Call trace:
[   27.506002]  arch_counter_read+0x18/0x24
[   27.506171]  ktime_get+0x48/0xa0
[   27.506207]  test_task+0x70/0xf0
[   27.506227]  kthread+0x10c/0x110
[   27.506243]  ret_from_fork+0x10/0x20

The old output is as follows:
[   27.944550] rcu: INFO: rcu_preempt self-detected stall on CPU
[   27.944980] rcu:     0-....: (1249 ticks this GP) idle=cbb/1/0x4000000000000000 softirq=2610/2610 fqs=614
[   27.945407]  (t=1251 jiffies g=2681 q=28 ncpus=4)
[   27.945731] Task dump for CPU 0:
[   27.945844] task:test0           state:R  running task     stack:    0 pid:  306 ppid:     2 flags:0x0000000a
[   27.946073] Call trace:
[   27.946151]  dump_backtrace.part.0+0xc8/0xd4
[   27.946378]  show_stack+0x18/0x70
[   27.946405]  sched_show_task+0x150/0x180
[   27.946427]  dump_cpu_task+0x44/0x54
[   27.947193]  rcu_dump_cpu_stacks+0xec/0x130
[   27.947212]  rcu_sched_clock_irq+0xb18/0xef0
[   27.947231]  update_process_times+0x68/0xac
[   27.947248]  tick_sched_handle+0x34/0x60
[   27.947266]  tick_sched_timer+0x4c/0xa4
[   27.947281]  __hrtimer_run_queues+0x178/0x360
[   27.947295]  hrtimer_interrupt+0xe8/0x244
[   27.947309]  arch_timer_handler_virt+0x38/0x4c
[   27.947326]  handle_percpu_devid_irq+0x88/0x230
[   27.947342]  generic_handle_domain_irq+0x2c/0x44
[   27.947357]  gic_handle_irq+0x44/0xc4
[   27.947376]  call_on_irq_stack+0x2c/0x54
[   27.947415]  do_interrupt_handler+0x80/0x94
[   27.947431]  el1_interrupt+0x34/0x70
[   27.947447]  el1h_64_irq_handler+0x18/0x24
[   27.947462]  el1h_64_irq+0x64/0x68                       <--- the above backtrace is worthless
[   27.947474]  arch_counter_read+0x18/0x24
[   27.947487]  ktime_get+0x48/0xa0
[   27.947501]  test_task+0x70/0xf0
[   27.947520]  kthread+0x10c/0x110
[   27.947538]  ret_from_fork+0x10/0x20

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/sched/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0e82073020bf0d1..6a5af8af2e69954 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -73,6 +73,7 @@
 
 #include <uapi/linux/sched/types.h>
 
+#include <asm/irq_regs.h>
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
 
@@ -11145,6 +11146,16 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
 void dump_cpu_task(int cpu)
 {
+	if (cpu == smp_processor_id() && in_hardirq()) {
+		struct pt_regs *regs;
+
+		regs = get_irq_regs();
+		if (regs) {
+			show_regs(regs);
+			return;
+		}
+	}
+
 	if (trigger_single_cpu_backtrace(cpu))
 		return;
 
-- 
2.25.1

