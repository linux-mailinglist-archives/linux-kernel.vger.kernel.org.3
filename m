Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7061D587938
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiHBImh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiHBIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A49D1ADB1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659429746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8eF92se8Ck9gTMF8XB0hpV/HpagXM8oD2FIuevox34=;
        b=eFACHF/gzM0gdqegtcbzuwxtKECzM9ogTwSrZrZJ5RIMKvCePgSCcS+AhF9089SrVEMEi/
        5xXYsQR1zchJqt7C0FgOssK/EqLx7N9BZ9puXiFeozhrDwnfzDok05nfkjnaX7UpV4dI3y
        N3raYVH2bby9COdSDjl4IIhqeHpasJY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-UbyiuJ87MWewiWR5h0-WHQ-1; Tue, 02 Aug 2022 04:42:25 -0400
X-MC-Unique: UbyiuJ87MWewiWR5h0-WHQ-1
Received: by mail-wm1-f70.google.com with SMTP id n19-20020a05600c3b9300b003a314062cf4so461698wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=H8eF92se8Ck9gTMF8XB0hpV/HpagXM8oD2FIuevox34=;
        b=erYpPyPXEf+f1ZZ5HuhN7AvTfKsrWFMC3gghLvYd3W8bqc/jTYmp5L6NY8F7ifoOCk
         piDoWyIjQB2vyB1+/ErIVhRUZ2vpXAKNbgSH83d6fBUFAwI+RaEE2WP9LZNmTJvH9sot
         Zko5zKxJeKBJDJ97S/AaSWcJMWlqvcs03+Iz8yzh6nH1u/yJjZ3HqpuQZqhzEPy/DsiQ
         UpipWz+XxMCgHHHovhjnYV27Cbjz3vh7Z+0ZDsITJ9h0BN2+3wEYNJhM9oCK5jiZkPzO
         fCBeUdRPiWX+aGQSaat4ImV+DgCSgSJ3FLOFuOfAyC6Zm4ai9BEKuN2EeBHMDuYoEAzQ
         IClA==
X-Gm-Message-State: ACgBeo1cy5XeI78ocp+Oo8bWxKPQ+g7U6wGRr2yJvGdxVY8xemDMUTlE
        j/lNbkpxWm7Tig6/tYOF19y1tgFvb0m0i4X2+DA5uhbtd7hIabl1Rn03Gwsj7d/veTdbPLOC30u
        bV3r7ZHlkxSbt8Eq1F9I/AUThwNiGLm3NyUEN431uPjQe8Ef7kGxQpt35NTuFLuAwaH6Dn/Am9/
        J/
X-Received: by 2002:adf:e30c:0:b0:21e:51b9:113c with SMTP id b12-20020adfe30c000000b0021e51b9113cmr12594435wrj.247.1659429743822;
        Tue, 02 Aug 2022 01:42:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR68Br9lvaisAnOSvsrL/jy0yqyzJQxAgckkxeOgYyGYsx7EHgZcGonLMjxfQhNaIRqQ0BwU5g==
X-Received: by 2002:adf:e30c:0:b0:21e:51b9:113c with SMTP id b12-20020adfe30c000000b0021e51b9113cmr12594416wrj.247.1659429743552;
        Tue, 02 Aug 2022 01:42:23 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003a31169a7f4sm24825800wmg.12.2022.08.02.01.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 01:42:23 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH v3 3/3] DEBUG-DO-NOT-MERGE: workqueue: kworker spawner
Date:   Tue,  2 Aug 2022 09:41:46 +0100
Message-Id: <20220802084146.3922640-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220802084146.3922640-1-vschneid@redhat.com>
References: <20220802084146.3922640-1-vschneid@redhat.com>
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
index 28cd58c684ee..4ffd50a3db46 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -91,7 +91,7 @@ enum {
 	BUSY_WORKER_HASH_ORDER	= 6,		/* 64 pointers */
 
 	MAX_IDLE_WORKERS_RATIO	= 4,		/* 1/4 of busy can be idle */
-	IDLE_WORKER_TIMEOUT	= 300 * HZ,	/* keep idle ones for 5 mins */
+	IDLE_WORKER_TIMEOUT	= 3 * HZ,	/* keep idle ones for 5 mins */
 
 	MAYDAY_INITIAL_TIMEOUT  = HZ / 100 >= 2 ? HZ / 100 : 2,
 						/* call for help after 10ms
@@ -1996,6 +1996,10 @@ static void reap_workers(struct list_head *reaplist)
 	struct worker *worker, *tmp;
 
 	list_for_each_entry_safe(worker, tmp, reaplist, entry) {
+		pr_info("WORKER_REAP: task=%s cpu=%d this_task=%s this_cpu=%d\n",
+			worker->task->comm, task_cpu(worker->task),
+			current->comm, raw_smp_processor_id());
+
 		list_del_init(&worker->entry);
 		unbind_worker(worker);
 
@@ -2489,6 +2493,9 @@ static int worker_thread(void *__worker)
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

