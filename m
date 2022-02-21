Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158CB4BE102
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355684AbiBULJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:09:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355672AbiBULJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:09:42 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987C3FD94
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:38:27 -0800 (PST)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21LAcAgn000134;
        Mon, 21 Feb 2022 19:38:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 21 Feb 2022 19:38:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21LAcAlI000131
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Feb 2022 19:38:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3a20c799-c18e-dd3a-3161-fee6bca1491e@I-love.SAKURA.ne.jp>
Date:   Mon, 21 Feb 2022 19:38:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [PATCH] workqueue: Use private WQ for schedule_on_each_cpu() API
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>
References: <20220221083358.GC835@xsang-OptiPlex-9020>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220221083358.GC835@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since schedule_on_each_cpu() calls schedule_work_on() and flush_work(),
we should avoid using system_wq in order to avoid unexpected locking
dependency.

  [T1] Running RCU-tasks wait API self tests
  [T9] Please do not flush events WQ.
  [T9] CPU: 0 PID: 9 Comm: rcu_tasks_rude_ Not tainted 5.16.0-06523-g29bd199e4e73 #1
  [T9] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
  [T9] Call Trace:
  [T9]  <TASK>
  [T9]  dump_stack_lvl+0x45/0x59
  [T9]  check_flush_dependency.cold+0x18/0x49
  [T9]  __flush_work+0x202/0xa00
  [T9]  schedule_on_each_cpu+0x1d8/0x300
  [T9]  rcu_tasks_kthread+0x21f/0x580
  [T9]  kthread+0x3a4/0x480
  [T9]  ret_from_fork+0x22/0x30
  [T9]  </TASK>
  [T1] Performance Events: unsupported p6 CPU model 42 no PMU driver, software events only.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Tejun, are you OK with https://lkml.kernel.org/r/2f887679-c783-bf18-a2aa-aa9a709bfb38@I-love.SAKURA.ne.jp ?

 kernel/workqueue.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8e6e64372441..6ebc6cb15c1c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3345,10 +3345,16 @@ int schedule_on_each_cpu(work_func_t func)
 {
 	int cpu;
 	struct work_struct __percpu *works;
+	struct workqueue_struct *wq;
 
 	works = alloc_percpu(struct work_struct);
 	if (!works)
 		return -ENOMEM;
+	wq = alloc_workqueue("events_sync", 0, 0);
+	if (!wq) {
+		free_percpu(works);
+		return -ENOMEM;
+	}
 
 	cpus_read_lock();
 
@@ -3363,6 +3369,7 @@ int schedule_on_each_cpu(work_func_t func)
 		flush_work(per_cpu_ptr(works, cpu));
 
 	cpus_read_unlock();
+	destroy_workqueue(wq);
 	free_percpu(works);
 	return 0;
 }
-- 
2.32.0


