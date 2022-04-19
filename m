Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEEA50606C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiDSADH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiDSAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C80211C34;
        Mon, 18 Apr 2022 17:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF3BE6128A;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AA4C385A8;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326416;
        bh=B3FKOAVi0h12Jmquk99abkkXI6DRfWVVNn7fsz2s47Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIyVIelsePL2hXcgK1LeA+D2oq1psbS3en+cIiWfV7CXR5CSKfcL1p4YR/RyUp8ia
         S8NKPlNqDslxqSV7Ze5lTntCIkums0iS3VJCgwe+BKyEEs9wD2xtXD7NusbV5suYKl
         LBRPZga+AsvMFW+fabpwlOd+621ojGTW/xp9GgJiNRbKb6hdsZv6i/YySjaJ3pg2LQ
         NDX6paN4TEYkdD8Q/VtTaTDYFcZYGHMJ3vhtzVDgqrmnrclZ15bSwyYHzCsD8lRXvo
         PXgW1s9rH/OZomfLNHgOg9o4UNnJ0PPM4NPY5u2H3MjsbqJiPdbvJvaCfwL5ysvr5e
         v4KpUy+s8l4lQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D5D605C04BD; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/9] rcu-tasks: Fix race in schedule and flush work
Date:   Mon, 18 Apr 2022 17:00:06 -0700
Message-Id: <20220419000014.3948512-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>

While booting secondary CPUs, cpus_read_[lock/unlock] is not keeping
online cpumask stable. The transient online mask results in below
calltrace.

[    0.324121] CPU1: Booted secondary processor 0x0000000001 [0x410fd083]
[    0.346652] Detected PIPT I-cache on CPU2
[    0.347212] CPU2: Booted secondary processor 0x0000000002 [0x410fd083]
[    0.377255] Detected PIPT I-cache on CPU3
[    0.377823] CPU3: Booted secondary processor 0x0000000003 [0x410fd083]
[    0.379040] ------------[ cut here ]------------
[    0.383662] WARNING: CPU: 0 PID: 10 at kernel/workqueue.c:3084 __flush_work+0x12c/0x138
[    0.384850] Modules linked in:
[    0.385403] CPU: 0 PID: 10 Comm: rcu_tasks_rude_ Not tainted 5.17.0-rc3-v8+ #13
[    0.386473] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
[    0.387289] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.388308] pc : __flush_work+0x12c/0x138
[    0.388970] lr : __flush_work+0x80/0x138
[    0.389620] sp : ffffffc00aaf3c60
[    0.390139] x29: ffffffc00aaf3d20 x28: ffffffc009c16af0 x27: ffffff80f761df48
[    0.391316] x26: 0000000000000004 x25: 0000000000000003 x24: 0000000000000100
[    0.392493] x23: ffffffffffffffff x22: ffffffc009c16b10 x21: ffffffc009c16b28
[    0.393668] x20: ffffffc009e53861 x19: ffffff80f77fbf40 x18: 00000000d744fcc9
[    0.394842] x17: 000000000000000b x16: 00000000000001c2 x15: ffffffc009e57550
[    0.396016] x14: 0000000000000000 x13: ffffffffffffffff x12: 0000000100000000
[    0.397190] x11: 0000000000000462 x10: ffffff8040258008 x9 : 0000000100000000
[    0.398364] x8 : 0000000000000000 x7 : ffffffc0093c8bf4 x6 : 0000000000000000
[    0.399538] x5 : 0000000000000000 x4 : ffffffc00a976e40 x3 : ffffffc00810444c
[    0.400711] x2 : 0000000000000004 x1 : 0000000000000000 x0 : 0000000000000000
[    0.401886] Call trace:
[    0.402309]  __flush_work+0x12c/0x138
[    0.402941]  schedule_on_each_cpu+0x228/0x278
[    0.403693]  rcu_tasks_rude_wait_gp+0x130/0x144
[    0.404502]  rcu_tasks_kthread+0x220/0x254
[    0.405264]  kthread+0x174/0x1ac
[    0.405837]  ret_from_fork+0x10/0x20
[    0.406456] irq event stamp: 102
[    0.406966] hardirqs last  enabled at (101): [<ffffffc0093c8468>] _raw_spin_unlock_irq+0x78/0xb4
[    0.408304] hardirqs last disabled at (102): [<ffffffc0093b8270>] el1_dbg+0x24/0x5c
[    0.409410] softirqs last  enabled at (54): [<ffffffc0081b80c8>] local_bh_enable+0xc/0x2c
[    0.410645] softirqs last disabled at (50): [<ffffffc0081b809c>] local_bh_disable+0xc/0x2c
[    0.411890] ---[ end trace 0000000000000000 ]---
[    0.413000] smp: Brought up 1 node, 4 CPUs
[    0.413762] SMP: Total of 4 processors activated.
[    0.414566] CPU features: detected: 32-bit EL0 Support
[    0.415414] CPU features: detected: 32-bit EL1 Support
[    0.416278] CPU features: detected: CRC32 instructions
[    0.447021] Callback from call_rcu_tasks_rude() invoked.
[    0.506693] Callback from call_rcu_tasks() invoked.

This commit therefore fixes this issue by applying a single-CPU
optimization to the RCU Tasks Rude grace-period process.  The key point
here is that the purpose of this RCU flavor is to force a schedule on
each online CPU since some past event.  But the rcu_tasks_rude_wait_gp()
function runs in the context of the RCU Tasks Rude's grace-period kthread,
so there must already have been a context switch on the current CPU since
the call to either synchronize_rcu_tasks_rude() or call_rcu_tasks_rude().
So if there is only a single CPU online, RCU Tasks Rude's grace-period
kthread does not need to anything at all.

It turns out that the rcu_tasks_rude_wait_gp() function's call to
schedule_on_each_cpu() causes problems during early boot.  During that
time, there is only one online CPU, namely the boot CPU.  Therefore,
applying this single-CPU optimization fixes early-boot instances of
this problem.

Link: https://lore.kernel.org/lkml/20220210184319.25009-1-treasure4paddy@gmail.com/T/
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 99cf3a13954c..b43320b149d2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -950,6 +950,9 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
+	if (num_online_cpus() <= 1)
+		return;	// Fastpath for only one CPU.
+
 	rtp->n_ipis += cpumask_weight(cpu_online_mask);
 	schedule_on_each_cpu(rcu_tasks_be_rude);
 }
-- 
2.31.1.189.g2e36527f23

