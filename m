Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6151457369D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiGMMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiGMMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:51:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5170031926
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:51:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id j27so1185942qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeVsRv8F2tSBJckt36xHpfvvwVi5AqXK04hh4c63th4=;
        b=ReuVylsEBkkFjRwRW4d7tjBE2kSJe+cRTDXIdS+5/Jo8Y9V7lfH5wgm3FqGPHZe0sG
         McKsc27g/mXkoTDHAG+NJGtdyKrIxXz9AfzNEu94aflT6qbmeSfS9FDP7ELnjhtV7wVI
         eShWOkFRTYJzdGhakKNea0/x5Xt93TcLAbDBiKwRFllvcqHri0BJjFjsV133GqKQnKQx
         w3lUJPpkdWtBxWWahW/ndWlGlQZ3sGKhiXX5MO12NYkjrvI4G8WYEOTt+0nMje550qm5
         CuRPn3H+DwfzIdCQ+GuFmB9LP0VrZ9/gzpxfwwjD35VAZrDrCkty3dIZV4MPUY62OVP7
         A8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeVsRv8F2tSBJckt36xHpfvvwVi5AqXK04hh4c63th4=;
        b=mMmvjrwb28WPPzljZDZZR4OIeQTPrPoovvKmUqp7fDfhPCPrXe8CSZYPjCYQ+df41c
         MmLXc/t8RQT1UmobTg/WkJNmoAk86xaUzKHVb1RmPTyrLeVCVx/a79Z7FX4rLuTFDUNC
         5d6LZOeGNDc+PVFSzpZ36YENDXWsBSQBW9FE7xfLypOIEJzACylH9xOpMcmUBu+U5IMp
         Xge+junLF+I87HVjoZDQMzH7VoApMbgPUyLme3KlRZeTu9TlCTNwYo2MxqVzjXnWrqf9
         e8AkMNqlEKnuzILdK1POjt7hJE3aQ8kVEcnf4WDT1W2EBgaHarM1YOBumQExB+WcJfkJ
         ZoMA==
X-Gm-Message-State: AJIora99bflT/kKl2aJsLGLgsOpdeDNU7dkmjAAu4DZDecxrrGvaYcyI
        QE2ZiCOTIQ5Beo3ykSIGoLCpdLHMEb0TCA==
X-Google-Smtp-Source: AGRyM1sykaC0cYvh/xFqQVVKqrcwZFR6ktNhqxnB2seYX+V7cMFga1TfnyoT4PM73sUUEfbMqaReUw==
X-Received: by 2002:a05:622a:110e:b0:31e:b568:b5a5 with SMTP id e14-20020a05622a110e00b0031eb568b5a5mr2636989qty.54.1657716700373;
        Wed, 13 Jul 2022 05:51:40 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id ay2-20020a05622a228200b0031ea95094dcsm3484464qtb.72.2022.07.13.05.51.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 05:51:39 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     jiangshanlai@gmail.com, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v2] workqueue: Use active mask for new worker when pool is DISASSOCIATED
Date:   Wed, 13 Jul 2022 20:51:23 +0800
Message-Id: <20220713125123.8701-1-schspa@gmail.com>
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
---
 kernel/workqueue.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..3f6e6d884793 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1867,13 +1867,13 @@ static void worker_attach_to_pool(struct worker *worker,
 	 * stable across this function.  See the comments above the flag
 	 * definition for details.
 	 */
-	if (pool->flags & POOL_DISASSOCIATED)
+	if (pool->flags & POOL_DISASSOCIATED) {
 		worker->flags |= WORKER_UNBOUND;
-	else
+		set_cpus_allowed_ptr(worker->task, cpu_active_mask);
+	} else {
 		kthread_set_per_cpu(worker->task, pool->cpu);
-
-	if (worker->rescue_wq)
 		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	}
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
@@ -1952,7 +1952,6 @@ static struct worker *create_worker(struct worker_pool *pool)
 		goto fail;
 
 	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
 
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
-- 
2.29.0

