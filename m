Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB75A15B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiHYP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiHYP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:28:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F090DBA14D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:27:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E156D6E;
        Thu, 25 Aug 2022 08:26:25 -0700 (PDT)
Received: from cam-smtp0.cambridge.arm.com (pierre123.nice.arm.com [10.34.100.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3EA213F93E;
        Thu, 25 Aug 2022 08:26:20 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] firmware: arm_sdei: Make sdei_list_lock a raw spinlock
Date:   Thu, 25 Aug 2022 17:25:56 +0200
Message-Id: <20220825152556.1634513-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an Ampere Altra, running a preemp_rt kernel based on
v5.19-rc3-rt5, the following happens:

[   15.683141] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[   15.683154] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 24, name: cpuhp/0
[   15.683157] preempt_count: 0, expected: 0
[   15.683159] RCU nest depth: 0, expected: 0
[   15.683163] 3 locks held by cpuhp/0/24:
[   15.683167]  #0: ffffda30217c70d0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
[   15.683201]  #1: ffffda30217c7120 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x5c/0x248
[   15.683205]  #2: ffffda3021c711f0 (sdei_list_lock){....}-{3:3}, at: sdei_cpuhp_up+0x3c/0x130
[   15.683224] irq event stamp: 36
[   15.683226] hardirqs last  enabled at (35): [<ffffda301e85b7bc>] finish_task_switch+0xb4/0x2b0
[   15.683236] hardirqs last disabled at (36): [<ffffda301e812fec>] cpuhp_thread_fun+0x21c/0x248
[   15.683238] softirqs last  enabled at (0): [<ffffda301e80b184>] copy_process+0x63c/0x1ac0
[   15.683245] softirqs last disabled at (0): [<0000000000000000>] 0x0
[   15.683258] CPU: 0 PID: 24 Comm: cpuhp/0 Not tainted 5.19.0-rc3-rt5-[...]
[   15.683265] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
[   15.683268] Call trace:
[   15.683271]  dump_backtrace+0x114/0x120
[   15.683277]  show_stack+0x20/0x70
[   15.683279]  dump_stack_lvl+0x9c/0xd8
[   15.683288]  dump_stack+0x18/0x34
[   15.683289]  __might_resched+0x188/0x228
[   15.683292]  rt_spin_lock+0x70/0x120
[   15.683301]  sdei_cpuhp_up+0x3c/0x130
[   15.683303]  cpuhp_invoke_callback+0x250/0xf08
[   15.683305]  cpuhp_thread_fun+0x120/0x248
[   15.683308]  smpboot_thread_fn+0x280/0x320
[   15.683315]  kthread+0x130/0x140
[   15.683321]  ret_from_fork+0x10/0x20

sdei_cpuhp_up() is called in the STARTING hotplug section,
which runs whith interrupts disabled. Convert sdei_list_lock
to a raw spinlock to avoid sleeping with interrupt disabled.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/firmware/arm_sdei.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1e1a51510e83..d2d596166f03 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -67,7 +67,7 @@ struct sdei_event {
 static DEFINE_MUTEX(sdei_events_lock);
 
 /* and then hold this when modifying the list */
-static DEFINE_SPINLOCK(sdei_list_lock);
+static DEFINE_RAW_SPINLOCK(sdei_list_lock);
 static LIST_HEAD(sdei_list);
 
 /* Private events are registered/enabled via IPI passing one of these */
@@ -167,14 +167,14 @@ static struct sdei_event *sdei_event_find(u32 event_num)
 
 	lockdep_assert_held(&sdei_events_lock);
 
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	list_for_each_entry(e, &sdei_list, list) {
 		if (e->event_num == event_num) {
 			found = e;
 			break;
 		}
 	}
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 
 	return found;
 }
@@ -259,9 +259,9 @@ static struct sdei_event *sdei_event_create(u32 event_num,
 		event->private_registered = regs;
 	}
 
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	list_add(&event->list, &sdei_list);
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 
 	return event;
 
@@ -287,9 +287,9 @@ static void sdei_event_destroy_llocked(struct sdei_event *event)
 
 static void sdei_event_destroy(struct sdei_event *event)
 {
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	sdei_event_destroy_llocked(event);
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 }
 
 static int sdei_api_get_version(u64 *version)
@@ -416,9 +416,9 @@ int sdei_event_enable(u32 event_num)
 		err = sdei_do_cross_call(_local_event_enable, event);
 
 	if (!err) {
-		spin_lock(&sdei_list_lock);
+		raw_spin_lock(&sdei_list_lock);
 		event->reenable = true;
-		spin_unlock(&sdei_list_lock);
+		raw_spin_unlock(&sdei_list_lock);
 	}
 	cpus_read_unlock();
 	mutex_unlock(&sdei_events_lock);
@@ -454,9 +454,9 @@ int sdei_event_disable(u32 event_num)
 		return -ENOENT;
 	}
 
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	event->reenable = false;
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 
 	if (event->type == SDEI_EVENT_TYPE_SHARED)
 		err = sdei_api_event_disable(event->event_num);
@@ -501,10 +501,10 @@ int sdei_event_unregister(u32 event_num)
 		goto unlock;
 	}
 
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	event->reregister = false;
 	event->reenable = false;
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 
 	if (event->type == SDEI_EVENT_TYPE_SHARED)
 		err = sdei_api_event_unregister(event->event_num);
@@ -531,7 +531,7 @@ static int sdei_unregister_shared(void)
 	struct sdei_event *event;
 
 	mutex_lock(&sdei_events_lock);
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	list_for_each_entry(event, &sdei_list, list) {
 		if (event->type != SDEI_EVENT_TYPE_SHARED)
 			continue;
@@ -540,7 +540,7 @@ static int sdei_unregister_shared(void)
 		if (err)
 			break;
 	}
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 	mutex_unlock(&sdei_events_lock);
 
 	return err;
@@ -609,9 +609,9 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 		goto cpu_unlock;
 	}
 
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	event->reregister = true;
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 cpu_unlock:
 	cpus_read_unlock();
 unlock:
@@ -625,7 +625,7 @@ static int sdei_reregister_shared(void)
 	struct sdei_event *event;
 
 	mutex_lock(&sdei_events_lock);
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	list_for_each_entry(event, &sdei_list, list) {
 		if (event->type != SDEI_EVENT_TYPE_SHARED)
 			continue;
@@ -651,7 +651,7 @@ static int sdei_reregister_shared(void)
 			}
 		}
 	}
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 	mutex_unlock(&sdei_events_lock);
 
 	return err;
@@ -663,7 +663,7 @@ static int sdei_cpuhp_down(unsigned int cpu)
 	int err;
 
 	/* un-register private events */
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	list_for_each_entry(event, &sdei_list, list) {
 		if (event->type == SDEI_EVENT_TYPE_SHARED)
 			continue;
@@ -674,7 +674,7 @@ static int sdei_cpuhp_down(unsigned int cpu)
 			       event->event_num, err);
 		}
 	}
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 
 	return sdei_mask_local_cpu();
 }
@@ -685,7 +685,7 @@ static int sdei_cpuhp_up(unsigned int cpu)
 	int err;
 
 	/* re-register/enable private events */
-	spin_lock(&sdei_list_lock);
+	raw_spin_lock(&sdei_list_lock);
 	list_for_each_entry(event, &sdei_list, list) {
 		if (event->type == SDEI_EVENT_TYPE_SHARED)
 			continue;
@@ -706,7 +706,7 @@ static int sdei_cpuhp_up(unsigned int cpu)
 			}
 		}
 	}
-	spin_unlock(&sdei_list_lock);
+	raw_spin_unlock(&sdei_list_lock);
 
 	return sdei_unmask_local_cpu();
 }
-- 
2.25.1

