Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB15741C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiGNDRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiGNDQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:16:56 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7901A811
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:16:55 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f14so422453qkm.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 20:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XsnrRCN2FMJJPKytAuk4MZlN3t6CL5h+2g4NiG8wePc=;
        b=KAg1f1ooXkpoIbgNYHXHGrw5QXt4NtPwBx+vr9sf//U/IzQy8d6AviD6rfuOawa2xT
         6RweFiyoxKf6n9L/gF1Fk1Hec53aoInhticSmPXET8noZwVfxFYYDBIR8zCxbmLCzuf3
         TXAOO0l0dYacg0idt4A7JTOYG0VbXQEBoACr9bpX+G1nVjfw49IjHZij/a9p3lMJb+mt
         uvqkMxurWJ36oJcx8AHITw3Uoj5AGJzSC+89xXirzaIhMz41JhbWfEnVOnZD7WlnX2by
         XCB/FMgt9kjUePci8f2aTP3XA7yNC5Okb88cNuPDvZgix+iMUDNrHtUXmu/GZ5Z108M7
         P3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XsnrRCN2FMJJPKytAuk4MZlN3t6CL5h+2g4NiG8wePc=;
        b=NWivvNMiq3DUnE2fVNj9BXKnvHVQdkkW3fuSdacrz6b7c1e+AnpMuBq3ELftfaB4ap
         7pE4pJ6cs5+Gki5sMFIpEV8+NySIZNjtGvcV1KrGrEdyjOVk18W2/0xMOneZgQWJyDGH
         tzyJ/t3oTC1bzo/ZstmgmsKOgCWU6ninoNTu8q1ZpuoxOB+Z+cksEakLU5fXK7j7ttZm
         dRj0RKhPsxxFnfZ+Ov6gOeBKGZbo4imXVU7LNYzAFeHOV7xpT1PRnWSHsJ50k9d6maze
         H0kspvlqBEMrlZtViuiazygCQlsHnTylW1y11PZ+iFezer/s2LCr2pS1aJQTppGfqVnD
         vhaA==
X-Gm-Message-State: AJIora9FixhndbQYljKm1SAXO5916roAWA4dtxbZ7gBww98ATxK1IEZ5
        0sZ3XF5SEgFTGGc75fk0Uto=
X-Google-Smtp-Source: AGRyM1uuO10zd2nH0sGqZen7MW+9/Ib57PAGbWNeFJ8QDutnRDj0ibvsAdudUb2ZoztxrxZeSl5CfQ==
X-Received: by 2002:a05:620a:29ce:b0:6a7:1379:62d4 with SMTP id s14-20020a05620a29ce00b006a7137962d4mr4736947qkp.604.1657768614133;
        Wed, 13 Jul 2022 20:16:54 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id z125-20020a37b083000000b006a758ce2ae1sm362658qke.104.2022.07.13.20.16.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 20:16:53 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     jiangshanlai@gmail.com, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v3] workqueue: Use active mask for new worker when pool is DISASSOCIATED
Date:   Thu, 14 Jul 2022 11:16:45 +0800
Message-Id: <20220714031645.28004-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU-[un]hotplugs, all workers will be bound to active CPU via
unbind_workers().

But the unbound worker still has a chance to create a new worker, which
has bound the newly created task to pool->attrs->cpumask. But the CPU has
been unplugged.

Please refer to the following scenarios.

           CPU0                                  CPU1
------------------------------------------------------------------
sched_cpu_deactivate(cpu_active_mask clear)
workqueue_offline_cpu(work pool POOL_DISASSOCIATED)
  -- all worker will migrate to another cpu --
                                    worker_thread
                                    -- will create new worker if
                                       pool->worklist is not empty
                                       create_worker()
                                     -- new kworker will bound to CPU0
                               (pool->attrs->cpumask will be mask of CPU0).
      kworker/0:x will running on rq

sched_cpu_dying
  if (rq->nr_running != 1 || rq_has_pinned_tasks(rq))
    WARN(true, "Dying CPU not properly vacated!");
      ---------OOPS-------------

And the crash log as fellowing.

The crash log is as follows:
[ 1622.829074] ------------[ cut here ]------------
[ 1622.829081] Dying CPU not properly vacated!
[ 1622.829091] WARNING: CPU: 3 PID: 31 at kernel/sched/core.c:7756 sched_cpu_dying+0x74/0x204
[ 1622.829374] CPU: 3 PID: 31 Comm: migration/3 Tainted: P           O      5.10.59-rt52 #2
[ 1622.829386] Stopper: multi_cpu_stop+0x0/0x160 <- 0x0
[ 1622.829400] pstate: 60c00009 (nZCv daif +PAN +UAO -TCO BTYPE=--)
[ 1622.829408] pc : sched_cpu_dying+0x74/0x204
[ 1622.829415] lr : sched_cpu_dying+0x74/0x204
[ 1622.829421] sp : ffff800012933c70
[ 1622.829424] pmr_save: 00000060
[ 1622.829426] x29: ffff800012933c70 x28: 0000000000000000
[ 1622.829435] x27: 0000000000000000 x26: 0000000000000001
[ 1622.829444] x25: 0000000000000000 x24: ffff800018353c2c
[ 1622.829452] x23: 0000000000000003 x22: 0000000000000003
[ 1622.829460] x21: 0000000000000059 x20: 0000000000000000
[ 1622.829468] x19: ffff00027ee68a80 x18: 0000000000000000
[ 1622.829477] x17: 0000000000000000 x16: 0000000000000000
[ 1622.829485] x15: ffffffffffffffff x14: ffff80001169ae30
[ 1622.829493] x13: ffffffffffc38c07 x12: ffffffffffffffff
[ 1622.829501] x11: ffffffffffe00000 x10: ffff80001169ae58
[ 1622.829510] x9 : 000000000000001e x8 : ffff80001169ae30
[ 1622.829518] x7 : ffff800012933ab0 x6 : 00000000ffff0e20
[ 1622.829526] x5 : ffff00027ee62988 x4 : 00000000ffff0e20
[ 1622.829535] x3 : ffff800011e30180 x2 : 0000000100000002
[ 1622.829543] x1 : 0000000000000000 x0 : 0000000000000000
[ 1622.829552] Call trace:
[ 1622.829555]  sched_cpu_dying+0x74/0x204
[ 1622.829562]  cpuhp_invoke_callback+0xc0/0x1b0
[ 1622.829571]  take_cpu_down+0xbc/0xd4
[ 1622.829577]  multi_cpu_stop+0x138/0x160
[ 1622.829584]  cpu_stopper_thread+0x9c/0x118
[ 1622.829591]  smpboot_thread_fn+0x1e8/0x1ec
[ 1622.829598]  kthread+0x114/0x124
[ 1622.829606]  ret_from_fork+0x10/0x30
[ 1622.829615] ---[ end trace 0000000000000002 ]---
[ 1623.830273] CPU3 enqueued tasks (2 total):
[ 1623.830291] 	pid: 31, name: migration/3
[ 1623.830440] 	pid: 25654, name: kworker/3:0
[ 1623.830444] task:kworker/3:0     state:R  running task     stack:    0 pid:25654 ppid:     2 flags:0x00000028
[ 1623.830458] Call trace:
[ 1623.830460]  __switch_to+0x164/0x17c
[ 1623.830472]  __schedule+0x4cc/0x5c0
[ 1623.830483]  schedule+0x7c/0xcc
[ 1623.830491]  schedule_preempt_disabled+0x14/0x24
[ 1623.830500]  kthread+0xd8/0x124
[ 1623.830509]  ret_from_fork+0x10/0x30

In the crash log, the error enqueued kworker(pid: 25654, name: kworker/3:0)
is a newly created thread, and have bind to a unpluged CPU 3.

Can crash dump can also verify this.
crash> task -R nr_cpus_allowed,cpus_mask 25654
PID: 25654  TASK: ffff000181ff0000  CPU: 3   COMMAND: "kworker/3:0"
  nr_cpus_allowed = 1,
  cpus_mask = {
    bits = {8, 0}
  },

crash> struct worker_pool.cpu,nr_workers,attrs 0xffff00027ee68380
  cpu = 3,
  nr_workers = 3,
  attrs = 0xffff000180004480,
crash> struct workqueue_attrs 0xffff000180004480
struct workqueue_attrs {
  nice = 0,
  cpumask = {{
      bits = {8, 0}
    }},
  no_numa = false
}

The stack trace of the bad running task was dumped via the following patch:
Link: https://lore.kernel.org/all/20220519161125.41144-1-schspa@gmail.com/
And I think this debug patch needs to be added to the mainline,
it can help us to debug this kind of problem

To fix it, we can use cpu_active_mask when work pool is DISASSOCIATED.

Signed-off-by: Schspa Shi <schspa@gmail.com>

--

Changelog:
v1 -> v2:
        - Move worker task bind to worker_attach_to_pool, remove extra
        wq_pool_attach_mutex added.
        - Add a timing diagram to make this question clearer.
v2 -> v3:
        - Add missing PF_NO_SETAFFINITY, use cpumask_intersects to
        avoid setting bad mask for unbound work pool as Lai Jiangshan
        advised.
        - Call kthread_set_pre_cpu correctly for unbound worker.
---
 kernel/workqueue.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..b3e9289d9640 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1860,8 +1860,16 @@ static struct worker *alloc_worker(int node)
 static void worker_attach_to_pool(struct worker *worker,
 				   struct worker_pool *pool)
 {
+	const struct cpumask *cpu_mask;
+
 	mutex_lock(&wq_pool_attach_mutex);
 
+	if (cpumask_intersects(pool->attrs->cpumask, cpu_active_mask))
+		cpu_mask = pool->attrs->cpumask;
+	else
+		cpu_mask = wq_unbound_cpumask;
+
+	set_cpus_allowed_ptr(worker->task, cpu_mask);
 	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
 	 * stable across this function.  See the comments above the flag
@@ -1870,10 +1878,8 @@ static void worker_attach_to_pool(struct worker *worker,
 	if (pool->flags & POOL_DISASSOCIATED)
 		worker->flags |= WORKER_UNBOUND;
 	else
-		kthread_set_per_cpu(worker->task, pool->cpu);
-
-	if (worker->rescue_wq)
-		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+		kthread_set_per_cpu(worker->task,
+				cpu_mask == wq_unbound_cpumask ? -1 : pool->cpu);
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
@@ -1952,8 +1958,8 @@ static struct worker *create_worker(struct worker_pool *pool)
 		goto fail;
 
 	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
 
+	worker->task->flags |= PF_NO_SETAFFINITY;
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
 
-- 
2.29.0

