Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28E05825F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiG0LyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiG0LyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6C5B4B0D3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658922846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2quE+oheJ5MgwAtS0wBQQxyLEnfIwU/DZPnyxSVPq8I=;
        b=PD2BnwTFNACqxQU7WzPcTcOINF4jzyeZxK8grRGWNZGHlZFtSeRwZiOF2zmojGN3t2S47w
        Baj+PZhIpBU4h7vodzgY3CvYoltHUIqAzS5WtaXg5Q9cJeqbysAIgCt9erDjTFdmaMtKA4
        oe/eb2Pz8K5GDq2a8ZMRd+sk4wzQUfA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-fnvORLzVP667K9c94XnaVQ-1; Wed, 27 Jul 2022 07:54:05 -0400
X-MC-Unique: fnvORLzVP667K9c94XnaVQ-1
Received: by mail-wm1-f71.google.com with SMTP id v24-20020a7bcb58000000b003a37681b861so458194wmj.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2quE+oheJ5MgwAtS0wBQQxyLEnfIwU/DZPnyxSVPq8I=;
        b=UlRfvaAy9joVvkn5J9gmjAUYxlJsJVx/gTRrFLg08hm8EIvAsWx4AyIplYIyTlhtbq
         lv+kk/vZoNEwwoDAjEXX+6NT9iiy2fMDSfxWZ0meDpx5SqqMoodyQgHyV4oFI5+W2O/U
         B4L0OdQyvpiRFLfQPMG7fN+jE2V88renpl5ytS3S2kqTUcxz6y8+tfnFEFsuFNGlThko
         WREqDAADFghcj5SbTn/cLO05U/+TJ5pffRGzEJBs+RYd2tSAUtj4R0r8lvivTfCxlvt+
         NAsxPPHh1yPOrsKwDWin0bAKD2tuZmj4iG0nQh47l/dBHrQ0A0+3XyyTHNxDmAhsX+Bx
         TDhg==
X-Gm-Message-State: AJIora/jdJ7ywlNkWoLCembTTu7bG89aPGuMwjfAQurZ6HFxlms6l7nQ
        W90Q42Jo95mjxGRAGxwuv7K01iwt7HD8XSy1zvApbjOMrlHiEfMGl9dS+Myrg/CmVFHsrFmaQ3v
        KcRBRB1A8Pz72U+sNfWMd74yJIG6Tz5pxvkp+je9K0zfWyqx+rM/cx6gz7DfZZePCKs8OpIwJkn
        KK
X-Received: by 2002:a05:600c:41c6:b0:3a3:4cab:74c1 with SMTP id t6-20020a05600c41c600b003a34cab74c1mr2697125wmh.175.1658922844123;
        Wed, 27 Jul 2022 04:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sezwyZTKDUk+AhXGdnwy34zp1ptH4CLYUrUrOIhrybOt9YyllohdQXYF9dFnOYsWdoshdZgA==
X-Received: by 2002:a05:600c:41c6:b0:3a3:4cab:74c1 with SMTP id t6-20020a05600c41c600b003a34cab74c1mr2697107wmh.175.1658922843763;
        Wed, 27 Jul 2022 04:54:03 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m64-20020a1c2643000000b003a30af0ec83sm2046838wmm.25.2022.07.27.04.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 04:54:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH v2 2/2] DEBUG: workqueue: kworker spawner
Date:   Wed, 27 Jul 2022 12:53:27 +0100
Message-Id: <20220727115327.2273547-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220727115327.2273547-1-vschneid@redhat.com>
References: <20220727115327.2273547-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 kernel/Makefile    |  2 +-
 kernel/workqueue.c |  9 +++++-
 kernel/wqstress.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 kernel/wqstress.c

diff --git a/kernel/Makefile b/kernel/Makefile
index a7e1f49ab2b3..860133f7bca5 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,7 +10,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    extable.o params.o platform-feature.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
-	    async.o range.o smpboot.o ucount.o regset.o
+	    async.o range.o smpboot.o ucount.o regset.o wqstress.o
 
 obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MODULES) += kmod.o
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 27642166dcc5..9559d0256683 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -91,7 +91,7 @@ enum {
 	BUSY_WORKER_HASH_ORDER	= 6,		/* 64 pointers */
 
 	MAX_IDLE_WORKERS_RATIO	= 4,		/* 1/4 of busy can be idle */
-	IDLE_WORKER_TIMEOUT	= 300 * HZ,	/* keep idle ones for 5 mins */
+	IDLE_WORKER_TIMEOUT	= 3 * HZ,	/* keep idle ones for 5 mins */
 
 	MAYDAY_INITIAL_TIMEOUT  = HZ / 100 >= 2 ? HZ / 100 : 2,
 						/* call for help after 10ms
@@ -1988,6 +1988,10 @@ static void rebind_worker(struct worker *worker, struct worker_pool *pool)
 
 static void reap_worker(struct worker *worker)
 {
+	pr_info("WORKER_REAP: task=%s cpu=%d this_task=%s this_cpu=%d\n",
+		worker->task->comm, task_cpu(worker->task),
+		current->comm, raw_smp_processor_id());
+
 	list_del_init(&worker->entry);
 	unbind_worker(worker);
 	wake_up_process(worker->task);
@@ -2443,6 +2447,9 @@ static int worker_thread(void *__worker)
 		WARN_ON_ONCE(!list_empty(&worker->entry));
 		set_pf_worker(false);
 
+		pr_info("WORKER_DIE: task=%s this_cpu=%d\n",
+			current->comm, raw_smp_processor_id());
+
 		set_task_comm(worker->task, "kworker/dying");
 		ida_free(&pool->worker_ida, worker->id);
 		worker_detach_from_pool(worker);
diff --git a/kernel/wqstress.c b/kernel/wqstress.c
new file mode 100644
index 000000000000..16a3771027cd
--- /dev/null
+++ b/kernel/wqstress.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+
+MODULE_AUTHOR("Valentin Schneider <vschneid@redhat.com>");
+MODULE_LICENSE("GPL");
+
+#define TARGET_CPU 3
+
+static void wqstress_workfn(struct work_struct *work)
+{
+	schedule_timeout_interruptible(10 * HZ);
+}
+
+#define DECL_WORK(n) static DECLARE_WORK(wqstress_work_##n, wqstress_workfn)
+#define KICK_WORK(n) do {						\
+		schedule_work_on(TARGET_CPU, &wqstress_work_##n);	\
+	} while (0);
+#define FLUSH_WORK(n) do {			\
+		flush_work(&wqstress_work_##n);	\
+	} while (0);
+
+DECL_WORK(0);
+DECL_WORK(1);
+DECL_WORK(2);
+DECL_WORK(3);
+DECL_WORK(4);
+DECL_WORK(5);
+DECL_WORK(6);
+DECL_WORK(7);
+DECL_WORK(8);
+DECL_WORK(9);
+
+/*
+ * This should create ≈(N-1) extra kworkers for N kicked work
+ */
+static int __init wqstress_init(void)
+{
+	pr_info("WQSTRESS START\n");
+
+	sched_set_fifo_low(current);
+
+	KICK_WORK(0);
+	KICK_WORK(1);
+	KICK_WORK(2);
+	KICK_WORK(3);
+	KICK_WORK(4);
+	KICK_WORK(5);
+	KICK_WORK(6);
+	KICK_WORK(7);
+	KICK_WORK(8);
+	KICK_WORK(9);
+
+	FLUSH_WORK(0);
+	FLUSH_WORK(1);
+	FLUSH_WORK(2);
+	FLUSH_WORK(3);
+	FLUSH_WORK(4);
+	FLUSH_WORK(5);
+	FLUSH_WORK(6);
+	FLUSH_WORK(7);
+	FLUSH_WORK(8);
+	FLUSH_WORK(9);
+
+	return 0;
+}
+
+late_initcall_sync(wqstress_init);
-- 
2.31.1

