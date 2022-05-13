Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17D526365
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiEMOCc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiEMOC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:02:29 -0400
X-Greylist: delayed 1004 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 May 2022 07:02:27 PDT
Received: from mta8.hihonor.com (mta8.hihonor.com [39.102.176.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B5FD20
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:02:27 -0700 (PDT)
Received: from w011.hihonor.com (unknown [10.68.20.122])
        by mta8.hihonor.com (SkyGuard) with ESMTPS id 4L08tW1P8RzWfnP
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 21:41:07 +0800 (CST)
Received: from a002.hihonor.com (10.68.31.193) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.15; Fri, 13 May
 2022 21:45:35 +0800
Received: from a007.hihonor.com (10.68.22.31) by a002.hihonor.com
 (10.68.31.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.15; Fri, 13 May
 2022 21:45:34 +0800
Received: from a007.hihonor.com ([fe80::dd1a:1e50:5c41:e645]) by
 a007.hihonor.com ([fe80::dd1a:1e50:5c41:e645%10]) with mapi id
 15.02.0858.015; Fri, 13 May 2022 21:45:34 +0800
From:   liangdongxu 00014050 <liangdongxu@hihonor.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "maco@android.com" <maco@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "hridya@google.com" <hridya@google.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sangmoon.kim@samsung.com" <sangmoon.kim@samsung.com>,
        "saravanak@google.com" <saravanak@google.com>
Subject: [PATCH] ANDROID: mutex: Add vendor hook and oem data to the mutex
Thread-Topic: [PATCH] ANDROID: mutex: Add vendor hook and oem data to the
 mutex
Thread-Index: Adhmx228HsZdoNCBQ7CkgL48RSZzgw==
Date:   Fri, 13 May 2022 13:45:34 +0000
Message-ID: <c5b5bd5f3bea4a17a66b115a16a628d5@hihonor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.163.18.227]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add hooks and oem data to apply oem's optimization of mutex.

Signed-off-by: Dezhi Huang <huangdezhi@hihonor.com>
---

diff --git a/drivers/android/vendor_hooks.c b/drivers/android/vendor_hooks.c
index 8ffa2fb..db972d1 100644
--- a/drivers/android/vendor_hooks.c
+++ b/drivers/android/vendor_hooks.c
@@ -91,6 +91,10 @@
 EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_alter_futex_plist_add);
 EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_mutex_wait_start);
 EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_mutex_wait_finish);
+EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_mutex_waiter_list_add);
+EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_mutex_unlock_slowpath);
+EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_mutex_waiting);
+EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_mutex_init);
 EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_rtmutex_wait_start);
 EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_rtmutex_wait_finish);
 EXPORT_TRACEPOINT_SYMBOL_GPL(android_vh_rwsem_read_wait_start);
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8f226d4..93a5bf0 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -19,6 +19,7 @@
 #include <asm/processor.h>
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
+#include <linux/android_vendor.h>
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
@@ -73,6 +74,7 @@
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
+	ANDROID_OEM_DATA(1);
 };
 
 #ifdef CONFIG_DEBUG_MUTEXES
diff --git a/include/trace/hooks/dtask.h b/include/trace/hooks/dtask.h
index 6f005d4..3c4277f 100644
--- a/include/trace/hooks/dtask.h
+++ b/include/trace/hooks/dtask.h
@@ -11,12 +11,28 @@
  * mechanism for vendor modules to hook and extend functionality
  */
 struct mutex;
+struct mutex_waiter;
 DECLARE_HOOK(android_vh_mutex_wait_start,
 	TP_PROTO(struct mutex *lock),
 	TP_ARGS(lock));
 DECLARE_HOOK(android_vh_mutex_wait_finish,
 	TP_PROTO(struct mutex *lock),
 	TP_ARGS(lock));
+DECLARE_HOOK(android_vh_mutex_waiter_list_add,
+		TP_PROTO(struct mutex *lock,
+			struct mutex_waiter *waiter,
+			struct list_head *list,
+			bool *add_finish),
+		TP_ARGS(lock, waiter, list, add_finish));
+DECLARE_HOOK(android_vh_mutex_unlock_slowpath,
+		TP_PROTO(struct mutex *lock),
+		TP_ARGS(lock));
+DECLARE_HOOK(android_vh_mutex_waiting,
+	TP_PROTO(struct mutex *lock),
+	TP_ARGS(lock));
+DECLARE_HOOK(android_vh_mutex_init,
+	TP_PROTO(struct mutex *lock),
+	TP_ARGS(lock));
 
 struct rt_mutex_base;
 DECLARE_HOOK(android_vh_rtmutex_wait_start,
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 77fa3dc..37f6316 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -51,6 +51,7 @@
 	osq_lock_init(&lock->osq);
 #endif
 
+	trace_android_vh_mutex_init(lock);
 	debug_mutex_init(lock, name, key);
 }
 EXPORT_SYMBOL(__mutex_init);
@@ -201,9 +202,12 @@
 __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
+	bool add_finish = false;
 	debug_mutex_add_waiter(lock, waiter, current);
 
-	list_add_tail(&waiter->list, list);
+	trace_android_vh_mutex_waiter_list_add(lock, waiter, list, &add_finish);
+	if (!add_finish)
+		list_add_tail(&waiter->list, list);
 	if (__mutex_waiter_is_first(lock, waiter))
 		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
 }
@@ -668,6 +672,7 @@
 				goto err;
 		}
 
+		trace_android_vh_mutex_waiting(lock);
 		raw_spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
@@ -895,6 +900,7 @@
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	trace_android_vh_mutex_unlock_slowpath(lock);
 	raw_spin_unlock(&lock->wait_lock);
 
 	wake_up_q(&wake_q);
