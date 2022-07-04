Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068EB565444
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiGDMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiGDMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:02:29 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344551182D;
        Mon,  4 Jul 2022 05:02:28 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lc4Cm06sXzYd0r;
        Mon,  4 Jul 2022 20:01:40 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 20:02:26 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 20:02:25 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v2] perf/core: Fix data race between perf_event_set_output and perf_mmap_close
Date:   Mon, 4 Jul 2022 20:00:06 +0800
Message-ID: <20220704120006.98141-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data race exists between perf_event_set_output and perf_mmap_close.
The scenario is as follows:

                  CPU1                                                       CPU2
                                                                    perf_mmap_close(event2)
                                                                      if (atomic_dec_and_test(&event2->rb->mmap_count)  // mmap_count 1 -> 0
                                                                        detach_rest = true;
ioctl(event1, PERF_EVENT_IOC_SET_OUTPUT, event2)
  perf_event_set_output(event1, event2)
                                                                      if (!detach_rest)
                                                                        goto out_put;
                                                                      list_for_each_entry_rcu(event, &event2->rb->event_list, rb_entry)
                                                                        ring_buffer_attach(event, NULL)
                                                                      // because event1 has not been added to event2->rb->event_list,
                                                                      // event1->rb is not set to NULL in these loops

    ring_buffer_attach(event1, event2->rb)
      list_add_rcu(&event1->rb_entry, &event2->rb->event_list)

The above data race causes a problem, that is, event1->rb is not NULL, but event1->rb->mmap_count is 0.
If the perf_mmap interface is invoked for the fd of event1, the kernel keeps in the perf_mmap infinite loop:

again:
        mutex_lock(&event->mmap_mutex);
        if (event->rb) {
<SNIP>
                if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
                        /*
                         * Raced against perf_mmap_close() through
                         * perf_event_set_output(). Try again, hope for better
                         * luck.
                         */
                        mutex_unlock(&event->mmap_mutex);
                        goto again;
                }
<SNIP>

This problem has occurred on the Syzkaller, causing the softlockup. The call stack is as follows:
[ 3666.984385][    C2] watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [syz-executor.2:32404]
[ 3666.986137][    C2] Modules linked in:
[ 3666.989581][    C2] CPU: 2 PID: 32404 Comm: syz-executor.2 Not tainted 5.10.0+ #4
[ 3666.990697][    C2] Hardware name: linux,dummy-virt (DT)
[ 3666.992270][    C2] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[ 3666.993787][    C2] pc : __kasan_check_write+0x0/0x40
[ 3666.994841][    C2] lr : perf_mmap+0x3c8/0xf80
[ 3666.995661][    C2] sp : ffff00001011f8f0
[ 3666.996598][    C2] x29: ffff00001011f8f0 x28: ffff0000cf644868
[ 3666.998488][    C2] x27: ffff000012cad2c0 x26: 0000000000000000
[ 3666.999888][    C2] x25: 0000000000000001 x24: ffff000012cad298
[ 3667.003511][    C2] x23: 0000000000000000 x22: ffff000012cad000
[ 3667.005504][    C2] x21: ffff0000cf644818 x20: ffff0000cf6d2400
[ 3667.006891][    C2] x19: ffff0000cf6d24c0 x18: 0000000000000000
[ 3667.008295][    C2] x17: 0000000000000000 x16: 0000000000000000
[ 3667.009528][    C2] x15: 0000000000000000 x14: 0000000000000000
[ 3667.010658][    C2] x13: 0000000000000000 x12: ffff800002023f17
[ 3667.012169][    C2] x11: 1fffe00002023f16 x10: ffff800002023f16
[ 3667.013780][    C2] x9 : dfffa00000000000 x8 : ffff00001011f8b7
[ 3667.015265][    C2] x7 : 0000000000000001 x6 : ffff800002023f16
[ 3667.016683][    C2] x5 : ffff0000c0f36400 x4 : 0000000000000000
[ 3667.018078][    C2] x3 : ffffa00010000000 x2 : ffffa000119a0000
[ 3667.019343][    C2] x1 : 0000000000000004 x0 : ffff0000cf6d24c0
[ 3667.021276][    C2] Call trace:
[ 3667.022598][    C2]  __kasan_check_write+0x0/0x40
[ 3667.023666][    C2]  __mmap_region+0x7a4/0xc90
[ 3667.024679][    C2]  __do_mmap_mm+0x600/0xa20
[ 3667.025700][    C2]  do_mmap+0x114/0x384
[ 3667.026583][    C2]  vm_mmap_pgoff+0x138/0x230
[ 3667.027532][    C2]  ksys_mmap_pgoff+0x1d8/0x570
[ 3667.028537][    C2]  __arm64_sys_mmap+0xa4/0xd0
[ 3667.029597][    C2]  el0_svc_common.constprop.0+0xf4/0x414
[ 3667.030682][    C2]  do_el0_svc+0x50/0x11c
[ 3667.031545][    C2]  el0_svc+0x20/0x30
[ 3667.032368][    C2]  el0_sync_handler+0xe4/0x1e0
[ 3667.033305][    C2]  el0_sync+0x148/0x180

perf_mmap_close and ring_buffer_attach involve complicated lock recursion.
The solution is to modify ring_buffer_attach function, that is,
after new event is added to rb->event_list, check whether rb->mmap_count is 0,
if the value is 0, another core performs perf_mmap_close operation
on ring buffer during this period. In this case, we set event->rb to NULL.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---

Changes since v1:
 - Modify commit message description.

 kernel/events/core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..c67c070f7b39 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5900,6 +5900,7 @@ static void ring_buffer_attach(struct perf_event *event,
 			       struct perf_buffer *rb)
 {
 	struct perf_buffer *old_rb = NULL;
+	struct perf_buffer *new_rb = rb;
 	unsigned long flags;
 
 	WARN_ON_ONCE(event->parent);
@@ -5928,6 +5929,20 @@ static void ring_buffer_attach(struct perf_event *event,
 
 		spin_lock_irqsave(&rb->event_lock, flags);
 		list_add_rcu(&event->rb_entry, &rb->event_list);
+
+		/*
+		 * When perf_mmap_close traverses rb->event_list during
+		 * detach all other events, new event may not be added to
+		 * rb->event_list, let's check again, if rb->mmap_count is 0,
+		 * it indicates that perf_mmap_close is executed.
+		 * Manually delete event from rb->event_list and
+		 * set event->rb to null.
+		 */
+		if (!atomic_read(&rb->mmap_count)) {
+			list_del_rcu(&event->rb_entry);
+			new_rb = NULL;
+		}
+
 		spin_unlock_irqrestore(&rb->event_lock, flags);
 	}
 
@@ -5944,7 +5959,7 @@ static void ring_buffer_attach(struct perf_event *event,
 	if (has_aux(event))
 		perf_event_stop(event, 0);
 
-	rcu_assign_pointer(event->rb, rb);
+	rcu_assign_pointer(event->rb, new_rb);
 
 	if (old_rb) {
 		ring_buffer_put(old_rb);
@@ -11883,6 +11898,13 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 			goto unlock;
 	}
 
+	/*
+	 * If rb->mmap_count is 0, perf_mmap_close is being executed,
+	 * the ring buffer is about to be unmapped and cannot be attached.
+	 */
+	if (rb && !atomic_read(&rb->mmap_count))
+		goto unlock;
+
 	ring_buffer_attach(event, rb);
 
 	ret = 0;
-- 
2.30.GIT

