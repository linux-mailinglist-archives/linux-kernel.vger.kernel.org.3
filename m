Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEE0549BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbiFMSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343737AbiFMSlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:41:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5127427B35
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:22:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so5374441plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QriVKtPYPMjffyzAchOzVri+9s1RNxaid+oPI6/3qyk=;
        b=nMA5bwwYcv1OJRm4RabHPqtxsP5/fOnadu+DlNXVkKd9gG73CUJ9fvNT8WFa/oGGUh
         qnQfbVITDJdLBX+s8/ZA2pQ3RzFEUOjMYoWu9MiuwUKOynwD7vkqblTOthvbMgIAMx9t
         F9dQW8FKSt1ddO0ZsZCRgMuhjLmGgpXau5yGQHBFfALCRvTL/AozLIkhn+LUq/RNQ1tY
         IjjMMFYAlZ9rf0aFTldZTmrDmz9VAQUWVnB9+n+yZ9DsUyML1x/RkniSvO++AV2LOfks
         +IQ4kQvOG3KxhOlSbrXL2ESRMbLPli0ct9+ujZvAWYNsJc5KGFPrsqTwHgRnyB6kk2zM
         fQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QriVKtPYPMjffyzAchOzVri+9s1RNxaid+oPI6/3qyk=;
        b=DpELw4QKdVrveWMku4gewl4H2j+7j5uNzkJedhfYZOr43Rn/taYI78jhWRK48HCmch
         vbnv2e6cJf6SQEfgXKzhGYxpPZOOJ7tx42OAWyc2M9U96UGgeWUZk/ZkLv/Cu6sPR/z+
         N/MLbQHH3ScloJzDyRt5vXP/ayBQiOPdVj67vrCtleFOdOPhC6Vyybc2CMFvzKtPlmm/
         2eH7jL6pINjR1b6DeqtFNc39Ug/4h2Ho8KVhPm4kyflDrlzAOgsbyjAmRdiIPGvLVs6P
         nRuwq+iCaRebwawAZEeadqyi4fo8Id5pK9OvoyxZBt2ekhHhW5Jnw/DY2RR/MHhqFLh7
         Ye9g==
X-Gm-Message-State: AOAM532TD0KxXWf6ggQIOaca9PVsqcgh40gZihrTxDpj+ziAforqKrmz
        PsItnvmof8/sHr6eH6XYxmC5r/UEsvAamHqr
X-Google-Smtp-Source: ABdhPJzwdd6UO5KYk51wrui2bdwQpj0l/SkUNaEcIZLUM2ATiFKAKESw79G3RxPNEiuHkfgGuLrpKA==
X-Received: by 2002:a17:902:d2d1:b0:167:4c33:d5d3 with SMTP id n17-20020a170902d2d100b001674c33d5d3mr52125114plc.81.1655133740483;
        Mon, 13 Jun 2022 08:22:20 -0700 (PDT)
Received: from DESKTOP-IM4PCEA.localdomain ([49.207.204.161])
        by smtp.googlemail.com with ESMTPSA id d14-20020a17090ad3ce00b001e25e3ba05csm19752317pjw.2.2022.06.13.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 08:22:20 -0700 (PDT)
From:   Mintu Patel <mintupatel89@gmail.com>
To:     mintupatel89@gmail.com
Cc:     Chinmoy Ghosh <chinmoyghosh2001@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        Vimal Kumar <vimal.kumar32@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rt_spin_lock: To list the correct owner of rt_spin_lock
Date:   Mon, 13 Jun 2022 20:52:04 +0530
Message-Id: <20220613152205.262-1-mintupatel89@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Thread1                                 Thread2

__try_to_take_rt_mutex+0x95c+0x74   enqueue_task_dl+0x8cc/0x8dc
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
rt_spin_lock and point us the driver's critical section. Respective driver
need to be debugged for longer held period of lock.

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
 include/trace/events/lock.h | 60 +++++++++++++++++++++++++++++++++++++
 kernel/locking/rtmutex.c    | 10 +++++++
 2 files changed, 70 insertions(+)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index d7512129a324..8bb21b31c9a9 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -36,6 +36,66 @@ TRACE_EVENT(lock_acquire,
 		  __get_str(name))
 );
 
+TRACE_EVENT(rt_spinlock_acquire,
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
+	TP_printk("Process: %s is acquiring lock: %s",  __get_str(process_name),
+		  __get_str(name))
+);
+
+TRACE_EVENT(rt_spinlock_acquired,
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
+	TP_printk("Process: %s has acquired lock: %s", __get_str(process_name),
+		  __get_str(name))
+);
+
+TRACE_EVENT(rt_spinlock_released,
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
+	TP_printk("Process: %s has released lock: %s", __get_str(process_name),
+		  __get_str(name))
+);
+
 DECLARE_EVENT_CLASS(lock,
 
 	TP_PROTO(struct lockdep_map *lock, unsigned long ip),
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 08e233b7dc21..fb10c4e44f09 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -25,6 +25,7 @@
 #include <linux/timer.h>
 #include <linux/ww_mutex.h>
 #include <linux/blkdev.h>
+#include <trace/events/lock.h>
 
 #include "rtmutex_common.h"
 
@@ -1144,7 +1145,13 @@ void __lockfunc rt_spin_lock(spinlock_t *lock)
 	sleeping_lock_inc();
 	migrate_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+#ifdef CONFIG_RT_SPIN_LOCK_TRACING
+	trace_rt_spinlock_acquire(&lock->dep_map, current);
+#endif
 	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
+#ifdef CONFIG_RT_SPIN_LOCK_TRACING
+	trace_rt_spinlock_acquired(&lock->dep_map, current);
+#endif
 }
 EXPORT_SYMBOL(rt_spin_lock);
 
@@ -1168,6 +1175,9 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
 {
 	/* NOTE: we always pass in '1' for nested, for simplicity */
 	spin_release(&lock->dep_map, 1, _RET_IP_);
+#ifdef CONFIG_RT_SPIN_LOCK_TRACING
+	trace_rt_spinlock_released(&lock->dep_map, current);
+#endif
 	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
 	migrate_enable();
 	sleeping_lock_dec();
-- 
2.25.1

