Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0455A850A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiHaSIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiHaSIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D3FE3981;
        Wed, 31 Aug 2022 11:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49E7AB82272;
        Wed, 31 Aug 2022 18:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960CCC43143;
        Wed, 31 Aug 2022 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969287;
        bh=o9XgzRlPiWVyRgUYLtR8EAg++iHahsXyN3N9pj5GojQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSVrT/MWKdKtPeROyci6f6kHR0kAWFcDmm5cP62dDJshO+HkeLZA6HaQzBLIMXFnu
         aIYHb3pEzEsfpVCNRBDj66qJJJbuXS4o2ZXtrIK7t2sI9SCjQ8AvMYPzBIsTJtGUc5
         ufEDfC2fGiRQFRiB7Ux7U4y1mprWuWVy3nX+95r8kDJ8OGwWaW6V1x1WOglPzR2DEb
         6j+qx/YzPUiHHmPr46a9TNcegMGCP3EChFzOy8s5kgLu46OKVdwdv2V7n75BG+NKDP
         9Iqkh1v4REhatHOawxTqDp84fSlal0j+r5pTIElFklBQw4WGmoPCagt1VSHSrcH3Pm
         3pWG9g9xnGshA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 045DF5C0981; Wed, 31 Aug 2022 11:08:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH rcu 08/10] sched/debug: Show the registers of 'current' in dump_cpu_task()
Date:   Wed, 31 Aug 2022 11:08:03 -0700
Message-Id: <20220831180805.2693546-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

The dump_cpu_task() function does not print registers on architectures
that do not support NMIs.  However, registers can be useful for
debugging.  Fortunately, in the case where dump_cpu_task() is invoked
from an interrupt handler and is dumping the current CPU's stack, the
get_irq_regs() function can be used to get the registers.

Therefore, this commit makes dump_cpu_task() check to see if it is being
asked to dump the current CPU's stack from within an interrupt handler,
and, if so, it uses the get_irq_regs() function to obtain the registers.
On systems that do support NMIs, this commit has the further advantage
of avoiding a self-NMI in this case.

This is an example of rcu self-detected stall on arm64, which does not
support NMIs:
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

This is a marked improvement over the old output:
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e15b6a7f34f47..60fdc0faf1c9d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -73,6 +73,7 @@
 
 #include <uapi/linux/sched/types.h>
 
+#include <asm/irq_regs.h>
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
 
@@ -11183,6 +11184,16 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 
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
2.31.1.189.g2e36527f23

