Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A495955E35E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiF0QN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiF0QNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:13:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240F17E0E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d17so9441333pfq.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3T3dACI/J1KzbkodVYl5rHCT2kW21BLvkYUwrihnqgI=;
        b=W2aRsj/VPceuu3uWRO3mZTUavf+6cQEhdyDFpOr6f79tfu+vdwt+MjA/i6LqGbKpli
         XjZVK10ciDt6xJ8Fx9VcYqleeEzqJDVqZqV7Sx8j0Lrs8y3hBEBAriNCzspCMCDBZADe
         gZMgnnv6zZUNgyXTC1j33asq6umc1UsmE6jahM9xSiL73V4cTbeWjErk6tp655FjNyg3
         cDRcEhcwnHb3epYKB+dE0B4/mvNX4hz+ptZ7Imb8yhSU2h09VlCtTN7hKJOR1ErHnGKa
         KtMYqGmsQSbYA0T2tqG+N6WDPLbnyY8DEhaZxJTpCFH5cJYMNzvXfnjkvJ8IC7zJqNWk
         BASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3T3dACI/J1KzbkodVYl5rHCT2kW21BLvkYUwrihnqgI=;
        b=b91ra8bwb1DiUWgRrD7U/7H86b0HCxaVdmeq1+xYzfcfWSUmbt9jCTZMUnu83PbwMe
         WLuJcZ0JyFmNn3ILpD7/UUjOiFhPCkl2wZkMvV/57QtGVp0ZFffEbBby7koyUTArqeOF
         JFpmABuFuTr0Yc3U7p12h6phRFe5xU5DU0wOpQlqrXMX7BOHfYTdVR55I2XtfPQdB2Vh
         FKRZtdPKySKCLDkrMRz0mR4HT/RIQVXz6e7oh/p4fxYGNv7VdvuZhbEZ0mQ80oTLIA7c
         Z7Xs4ISipp6ll2kAX+yXnDzMHURMjacAPhveIOFz0zGcP8niGeeNmyxyy0gJwOlDcToH
         nD0g==
X-Gm-Message-State: AJIora8ancMp3tnbcx9Hj5qAtgtRX4tAtrVbDIA3PSt9YXi2bSqR2C4T
        kTwpCsS3MYMm4CjF71D0bME=
X-Google-Smtp-Source: AGRyM1trjL3b+PeZR613EcKOLoL1O0lkZD3G/ULUPLia8Egpheoa+b6k9BSOamj14ZDFbjIHYc/xHg==
X-Received: by 2002:a63:3ec6:0:b0:40d:27a:7847 with SMTP id l189-20020a633ec6000000b0040d027a7847mr13287106pga.606.1656346433083;
        Mon, 27 Jun 2022 09:13:53 -0700 (PDT)
Received: from DESKTOP-IM4PCEA.localdomain ([49.207.219.170])
        by smtp.googlemail.com with ESMTPSA id o15-20020a17090ab88f00b001ece373522dsm7401175pjr.10.2022.06.27.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:13:52 -0700 (PDT)
From:   Mintu Patel <mintupatel89@gmail.com>
To:     mintupatel89@gmail.com
Cc:     badolevishal1116@gmail.com, chinmoyghosh2001@gmail.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, vimal.kumar32@gmail.com,
        will@kernel.org
Subject: [PATCH v2] rt_spin_lock: To list the correct owner of rt_spin_lock
Date:   Mon, 27 Jun 2022 21:41:38 +0530
Message-Id: <20220627161136.3468-1-mintupatel89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220619142038.1274-1-mintupatel89@gmail.com>
References: <20220619142038.1274-1-mintupatel89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   rt_spin_lock is actually mutex on RT Kernel so it goes for contention
   for lock. Currently owners of rt_spin_lock are decided before actual
   acquiring of lock. This patch would depict the correct owner of
   rt_spin_lock. The patch would help in solving crashes and deadlock
   due to race condition of lock

acquiring rt_spin_lock        acquired the lock       released the lock
                    <-------->                <------->
                    contention period         Held period

Thread1                             Thread2
_try_to_take_rt_mutex+0x95c+0x74    enqueue_task_dl+0x8cc/0x8dc
rt_spin_lock_slowlock_locked+0xac+2 rt_mutex_setprio+0x28c/0x574
rt_spin_lock_slowlock+0x5c/0x90     task_blocks_rt_mutex+0x240/0x310
rt_spin_lock+0x58/0x5c              rt_spin_lock_slowlock_locked+0xac/0x2
driverA_acquire_lock+0x28/0x56      rt_spin_lock_slowlock+0x5c/0x90
				    rt_spin_lock+0x58/0x5c
                                    driverB_acquire_lock+0x48/0x6c

As per above call traces sample, Thread1 acquired the rt_spin_lock and
went to critical section on the other hand Thread2 kept trying to acquire
the same rt_spin_lock held by Thread1 ie contention period is too high.
Finally Thread2 entered to dl queue due to high held time of the lock by
Thread1. The below patch would help us to know the correct owner of
rt_spin_lock and point us the driver's critical section. Respective
driver need to be debugged for longer held period of lock.

   ex: cat /sys/kernel/debug/tracing/trace

   kworker/u13:0-150   [003] .....11   202.761025: rt_spinlock_acquire:
Process: kworker/u13:0 is acquiring lock: &kbdev->hwaccess_lock
   kworker/u13:0-150   [003] .....11   202.761039: rt_spinlock_acquired:
Process: kworker/u13:0 has acquired lock: &kbdev->hwaccess_lock
   kworker/u13:0-150   [003] .....11   202.761042: rt_spinlock_released:
Process: kworker/u13:0 has released lock: &kbdev->hwaccess_lock

Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
---
 include/trace/events/lock.h     | 38 +++++++++++++++++++++++++++++++++
 kernel/locking/rtmutex.c        |  4 ++++
 kernel/locking/rtmutex_common.h | 14 ++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index d7512129a324..0564474341c8 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -36,6 +36,44 @@ TRACE_EVENT(lock_acquire,
 		  __get_str(name))
 );
 
+DECLARE_EVENT_CLASS(rt_lock_class,
+
+	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
+
+	TP_ARGS(lock, pname),
+
+	TP_STRUCT__entry(
+		__string(name, lock->name)
+		__string(process_name, pname->comm)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, lock->name);
+		__assign_str(process_name, pname->comm);
+	),
+
+	TP_printk("Process: %s is acquiring lock: %s", __get_str(process_name),
+		__get_str(name))
+);
+
+DEFINE_EVENT(rt_lock_class, rt_spinlock_acquire,
+	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
+	TP_ARGS(lock, pname));
+
+DEFINE_EVENT_PRINT(rt_lock_class, rt_spinlock_acquired,
+	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
+	TP_ARGS(lock, pname),
+	TP_printk("Process: %s has acquired lock: %s", __get_str(process_name),
+		__get_str(name))
+	);
+
+DEFINE_EVENT_PRINT(rt_lock_class, rt_spinlock_released,
+	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
+	TP_ARGS(lock, pname),
+	TP_printk("Process: %s has released lock: %s", __get_str(process_name),
+		__get_str(name))
+	);
+
 DECLARE_EVENT_CLASS(lock,
 
 	TP_PROTO(struct lockdep_map *lock, unsigned long ip),
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 602eb7821a1b..80ba2c0d7923 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -26,6 +26,7 @@
 #include <linux/timer.h>
 #include <linux/ww_mutex.h>
 #include <linux/blkdev.h>
+#include <trace/events/lock.h>
 
 #include "rtmutex_common.h"
 
@@ -1144,7 +1145,9 @@ void __lockfunc rt_spin_lock(spinlock_t *lock)
 	rcu_read_lock();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	do_trace_rt_spinlock_acquire(lock, current);
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+	do_trace_rt_spinlock_acquired(lock, current);
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
@@ -1169,6 +1172,7 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 {
 	/* NOTE: we always pass in '1' for nested, for simplicity */
 	spin_release(&lock->dep_map, 1, _RET_IP_);
+	do_trace_rt_spinlock_released(lock, current);
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 	migrate_enable();
 	rcu_read_unlock();
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 546aaf058b9e..185ffc1e7015 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -25,6 +25,20 @@
  * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
  */
+
+#ifdef CONFIG_RT_SPIN_LOCK_TRACING
+#define do_trace_rt_spinlock_acquire(lock, task) \
+	trace_rt_spinlock_acquire(&lock->dep_map, task)
+#define do_trace_rt_spinlock_acquired(lock, task) \
+	trace_rt_spinlock_acquired(&lock->dep_map, task)
+#define do_trace_rt_spinlock_released(lock, task) \
+	trace_rt_spinlock_released(&lock->dep_map, task)
+#else
+#define do_trace_rt_spinlock_acquire(lock, task) do {} while(0)
+#define do_trace_rt_spinlock_acquired(lock, task) do {} while(0)
+#define do_trace_rt_spinlock_released(lock, task) do {} while(0)
+#endif
+
 struct rt_mutex_waiter {
 	struct rb_node          tree_entry;
 	struct rb_node          pi_tree_entry;
-- 
2.25.1

