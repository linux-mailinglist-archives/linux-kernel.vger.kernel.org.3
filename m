Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5F569E41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiGGJFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiGGJFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:05:15 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908131FCE4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:05:14 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id ck6so21787081qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eoPPFF1XlLJgXSAnYS4is7i8YNpEctc994ewIyf6DEw=;
        b=UZhnwwV0PUzZH32UFhw0oyMDAmO1//aaqk4SwL/HsTN9Ex/HkbBh3ujzP8CTLnDyzp
         PvzJA0ZAm3MkCjAm83kMObuoi6rF/b/EU3eVhnwo2hXpJjAcw4CaccmfAl/pkmGU1dVK
         nSR4gHPS/IZB67sh91Y/LkHxhD8hupSVs7DYLAJfb6gvi1Qp2rjSN6NEIj7eBQTC3/DW
         zwV7jv8x7dNyx03d6MHn7NOBh9p6Q5m1qDu9ADR+KfKKTGFgiFY16tnefwfBiyxsjvX3
         PYu5G3d2JV8zdKM0wms2Hc4KvCMiulgUTGzQKWoMzOvH1ml3M5pnPXBZC+MAfnDPYBV5
         3C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eoPPFF1XlLJgXSAnYS4is7i8YNpEctc994ewIyf6DEw=;
        b=4FBhkT+r7R7Kqy6YK66E+EHfiF4/Kazvy6QL+xn1dwBvyvVCePSYkGVmGh/c5KeT03
         2QsPEzG7CSPPB9PauR53BC5CPsPyTJ+8B9EESKoaGHFziQyeduJz96YXMJS1fFUt3w+z
         3iq8uBLfTqLcvD95YLMgfwJ4BI1TmEn+XzdnAZLDzH8O/JWPwY35BROyM4kID24R6vue
         +PFpI+1tgEtqF6Qpc056PZ0cIYNCf/1eSY2lm8O9+lfv5FhVjxMywWWOEucSodrt9cVJ
         5NnUczW6q7OWPzHl/bx358IV7AohzgwGIsRir+RbfeWhwG7PgkwE8StMS0e5/VkskZYD
         O1dg==
X-Gm-Message-State: AJIora/s5Zj05K908Xa9UJfnBZQ8IQokDQdzVkSmLUhBl4T3YukCTPPd
        kJK94KgsZftkeCVR1gInqsI=
X-Google-Smtp-Source: AGRyM1vE2yQhBI9FdEWt4MQ5qnsqeR62BI0M4S1+CqL9D5UuNqIALaxfPC4d7Qak+nqITFGmh2o7yQ==
X-Received: by 2002:ac8:4e56:0:b0:31d:38c0:b749 with SMTP id e22-20020ac84e56000000b0031d38c0b749mr25631033qtw.682.1657184713444;
        Thu, 07 Jul 2022 02:05:13 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05620a17a500b006af0d99c7fesm20166862qkb.132.2022.07.07.02.05.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2022 02:05:12 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH] workqueue: Use active mask for new worker when pool is DISASSOCIATED
Date:   Thu,  7 Jul 2022 17:05:01 +0800
Message-Id: <20220707090501.55483-1-schspa@gmail.com>
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
has bound the newly created task to pool->attrs->cpumask. The CPU has
been unplugged. And the following crash occurred.

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
---
 kernel/workqueue.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..713b07957cb6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1872,8 +1872,12 @@ static void worker_attach_to_pool(struct worker *worker,
 	else
 		kthread_set_per_cpu(worker->task, pool->cpu);
 
-	if (worker->rescue_wq)
-		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	if (worker->rescue_wq) {
+		if (pool->flags & POOL_DISASSOCIATED)
+			set_cpus_allowed_ptr(worker->task, cpu_active_mask);
+		else
+			set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	}
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
@@ -1952,7 +1956,18 @@ static struct worker *create_worker(struct worker_pool *pool)
 		goto fail;
 
 	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
+
+	mutex_lock(&wq_pool_attach_mutex);
+	if ((pool->flags & POOL_DISASSOCIATED)) {
+		/* We can't call get_online_cpus, there will be deadlock
+		 * cpu_active_mask will no change, because we have
+		 * wq_pool_attach_mutex hold.
+		 **/
+		kthread_bind_mask(worker->task, cpu_active_mask);
+	} else {
+		kthread_bind_mask(worker->task, pool->attrs->cpumask);
+	}
+	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
-- 
2.29.0

