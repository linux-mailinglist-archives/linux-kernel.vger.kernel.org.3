Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1257A471
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbiGSQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbiGSQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6369E4F6A1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658249884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pGLT/O5C/K0AnzGXbvcTRwb/0H0s9Eed8T9hVEGD0gc=;
        b=QlJha7v3hoKeejbMhNvbzHnj20FDTV04Mj+WVBYfHQPdcDUlyDE2yHgwm2U1sx2zqFlMlS
        nhb321X//To6+uvTvWnOt1Bnb4cLRQRJQw0j2SpJrWjh9pdiPtLUYwsfC6un3sIBMWQhGo
        oZZPpDnUdnuF4hWLcG7vdl+tmx4L1qs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-2jnbNDBJPCaxmPKD4yZWOA-1; Tue, 19 Jul 2022 12:57:57 -0400
X-MC-Unique: 2jnbNDBJPCaxmPKD4yZWOA-1
Received: by mail-wm1-f71.google.com with SMTP id r127-20020a1c4485000000b003a2fdeea756so1202794wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGLT/O5C/K0AnzGXbvcTRwb/0H0s9Eed8T9hVEGD0gc=;
        b=3ivO3eFn2Dr0L4w/YqK+UecWwuJ4/Xu8SoiZD4x+ffQR9iHB3gnhh/Xo/C5JxEiEYI
         8B8PdPefc1SCBR/m794gVni/pHjJpsUNDLwcNltoftYJfHYbkC/KIFKV/BbmEIZ549cI
         9TIJ1vFYb6Yp03gYVwZa+Tjc6xhNfJxXbYEIyUKHDHcMXR4eQWZtnq43NrnmFP7IiCgw
         0GG6MBFDDf3928D9pshLV23UkOOX9VnwQDblAjW1PFYqs4Lmc5E/4hYGN5xNn3MMpuU1
         XpOeJTUfRJdqklEG3Aop8ScQvFjyquTlGG4Fc1mjlYOJJbpAgeDewXmuqDwYD2NGzCrk
         1sPQ==
X-Gm-Message-State: AJIora98mvBRlRUrmTMnd0d1CqZiJvoeb1l+PLcP5UQ3osNt3y/wXbkj
        q1MQ/9k0RlSdroqlVV1spiUjwGhxOo9ZDqmqcM5grpoF4kxN1fpb1hS6G2p3ncHQWOCHD2obRQ5
        5QSHXrnZZaEfeTJpJh1RSbAZAhAZiM1Kinkk7dFuU9jBFUD7skDGeFBITaV6f2JLnQifMU0v3Sr
        7q
X-Received: by 2002:a5d:452e:0:b0:21d:9234:8661 with SMTP id j14-20020a5d452e000000b0021d92348661mr27026466wra.481.1658249875560;
        Tue, 19 Jul 2022 09:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vyr8MeqADwsGxABGdtADyEHOP8+z+Xngogz4JQJhwVcBouDJx6dPv8YV8xCvAx0iZ2f5Zccg==
X-Received: by 2002:a5d:452e:0:b0:21d:9234:8661 with SMTP id j14-20020a5d452e000000b0021d92348661mr27026449wra.481.1658249875343;
        Tue, 19 Jul 2022 09:57:55 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f7-20020a7bcd07000000b003a02cbf862esm19309823wmj.13.2022.07.19.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 09:57:54 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [RFC PATCH] workqueue: Unbind workers before sending them to exit()
Date:   Tue, 19 Jul 2022 17:57:43 +0100
Message-Id: <20220719165743.3409313-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been reported that isolated CPUs can suffer from interference due to
per-CPU kworkers waking up just to die.

A surge of workqueue activity (sleeping workfn's exacerbate this) during
initial setup can cause extra per-CPU kworkers to be spawned. Then, a
latency-sensitive task can be running merrily on an isolated CPU only to be
interrupted sometime later by a kworker marked for death (cf.
IDLE_WORKER_TIMEOUT, 5 minutes after last kworker activity).

Affine kworkers to the wq_unbound_cpumask (which doesn't contain isolated
CPUs, cf. HK_TYPE_WQ) before waking them up after marking them with
WORKER_DIE.

This follows the logic of CPU hot-unplug, which has been packaged into
helpers for the occasion.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/workqueue.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..0f1a25ea4924 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1972,6 +1972,18 @@ static struct worker *create_worker(struct worker_pool *pool)
 	return NULL;
 }
 
+static void unbind_worker(struct worker *worker)
+{
+	kthread_set_per_cpu(worker->task, -1);
+	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
+}
+
+static void rebind_worker(struct worker *worker, struct worker_pool *pool)
+{
+	kthread_set_per_cpu(worker->task, pool->cpu);
+	WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask) < 0);
+}
+
 /**
  * destroy_worker - destroy a workqueue worker
  * @worker: worker to be destroyed
@@ -1999,6 +2011,16 @@ static void destroy_worker(struct worker *worker)
 
 	list_del_init(&worker->entry);
 	worker->flags |= WORKER_DIE;
+
+	/*
+	 * We're sending that thread off to die, so any CPU would do. This is
+	 * especially relevant for pcpu kworkers affined to an isolated CPU:
+	 * we'd rather not interrupt an isolated CPU just for a kworker to
+	 * do_exit().
+	 */
+	if (!(worker->flags & WORKER_UNBOUND))
+		unbind_worker(worker);
+
 	wake_up_process(worker->task);
 }
 
@@ -4999,10 +5021,8 @@ static void unbind_workers(int cpu)
 
 		raw_spin_unlock_irq(&pool->lock);
 
-		for_each_pool_worker(worker, pool) {
-			kthread_set_per_cpu(worker->task, -1);
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
-		}
+		for_each_pool_worker(worker, pool)
+			unbind_worker(worker);
 
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
@@ -5027,11 +5047,8 @@ static void rebind_workers(struct worker_pool *pool)
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
-	for_each_pool_worker(worker, pool) {
-		kthread_set_per_cpu(worker->task, pool->cpu);
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
-						  pool->attrs->cpumask) < 0);
-	}
+	for_each_pool_worker(worker, pool)
+		rebind_worker(worker, pool);
 
 	raw_spin_lock_irq(&pool->lock);
 
-- 
2.31.1

