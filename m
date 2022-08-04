Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C157458996B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiHDImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbiHDIlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:41:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0623A66125
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:41:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w14so5668983plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JYtx0gSEzUyP9tNNW1dyx5vOU7phI7IefN54Dq4Qn2I=;
        b=nPH69jq36PE5OSDqSsRcVNcq3kxLmc0zvtGfIflRk9S3woqyXqCymAOCoLVA80yOAv
         RRxjrJpwbytrD3aB12lEra/NWYQ/GSZGYdbm6tbMl3hS5cQS8mPJX5YK56zjt7hZhUTD
         3HmDvXLtBv9/QWCxGv4CNz9rwUlPE/t7wxXUY9a7muEOO1/ysTqB9PETUCQjn9QjaxDS
         7VIU8hYOz4sx6TceGzZxffzuOw7I1cw4CwrXG71pEo1EgrVMtldTuyFKfQpf86BCoxBn
         6zlXds1v8kBDQGQ5RB+VCF1VzdpbkK3N75b7hgnH+FeNZjDWm8FJrE4C5jDie80AA1Nc
         h5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JYtx0gSEzUyP9tNNW1dyx5vOU7phI7IefN54Dq4Qn2I=;
        b=l2+1HmGqSJSkrRocXX8yE3lue0x0s7QGt2Hk85sBIvZ0Oy5xDhvzqgpITFhoa0uQ/K
         0xJ6gV6WppCANKDxz005ewtikOGma4H/o7PFDKHmn95s+nqLLgZ35GUGFiT4+WpCgOp2
         Wm/9a9GC7C5HFgVZCyFXKz75tcRqxwlwShYwEW7++ywYhrE8d6rBeBPaISYC/8zp16xZ
         vupUVDhqXZMr9LSka6K2wyn1RiagMaMZyNiDEAsiS4+m747/RLKQMyGqkhLM0jz9TQxX
         e2U4BCsgYAw1dOlIoMJCCYtq7I/dSwSaGGY1SZO0TGSbqnD09kphWEUYbOESaA+idHjh
         Mk3Q==
X-Gm-Message-State: ACgBeo0Wl5J5OPyApcpvKdwhq9nTm34T1yRAeN0uopDffA6m2MqF4p6R
        PSeNrZc2gx3dKkY9aDUQ1qnMenIutYI=
X-Google-Smtp-Source: AA6agR5VwKqCPDcRPZSLIdxQMKZkjNmhgeyswq844jixfkWUVrC/JiSV5Mt6SMfvDmSeXyKUnLfCaA==
X-Received: by 2002:a17:902:ac97:b0:16e:eb08:fb15 with SMTP id h23-20020a170902ac9700b0016eeb08fb15mr941051plr.7.1659602462293;
        Thu, 04 Aug 2022 01:41:02 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id b27-20020aa78edb000000b0052b6277df9esm354103pfr.43.2022.08.04.01.41.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:41:01 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH 6/8] workqueue: Simplify the starting of the newly created worker
Date:   Thu,  4 Aug 2022 16:41:33 +0800
Message-Id: <20220804084135.92425-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220804084135.92425-1-jiangshanlai@gmail.com>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

There is no point for the newly created worker entering and leaving
idle in the same pool->lock held region and checking WORKER_DIE
because it has not added to idle_list before the lock.

Avoid the code in the starting of the newly created worker and move
those code to the end of the worker_thread().

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index afe62649fb3a..64dc1833d11a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2383,31 +2383,16 @@ static int worker_thread(void *__worker)
 
 	raw_spin_lock_irq(&pool->lock);
 	worker->pool->nr_workers++;
-	worker_enter_idle(worker);
 	complete(&pool->created);
-woke_up:
-
-	/* am I supposed to die? */
-	if (unlikely(worker->flags & WORKER_DIE)) {
-		raw_spin_unlock_irq(&pool->lock);
-		WARN_ON_ONCE(!list_empty(&worker->entry));
-
-		set_task_comm(worker->task, "kworker/dying");
-		ida_free(&pool->worker_ida, worker->id);
-		worker_detach_from_pool(worker);
-		kfree(worker);
-		return 0;
-	}
 
-	worker_leave_idle(worker);
-recheck:
+loop:
 	/* no more worker necessary? */
 	if (!need_more_worker(pool))
 		goto sleep;
 
 	/* do we need to manage? */
 	if (unlikely(!may_start_working(pool)) && manage_workers(worker))
-		goto recheck;
+		goto loop;
 
 	/*
 	 * ->scheduled list can only be filled while a worker is
@@ -2457,7 +2442,21 @@ static int worker_thread(void *__worker)
 	raw_spin_unlock_irq(&pool->lock);
 	schedule();
 	raw_spin_lock_irq(&pool->lock);
-	goto woke_up;
+
+	/* am I supposed to die? */
+	if (unlikely(worker->flags & WORKER_DIE)) {
+		raw_spin_unlock_irq(&pool->lock);
+		WARN_ON_ONCE(!list_empty(&worker->entry));
+
+		set_task_comm(worker->task, "kworker/dying");
+		ida_free(&pool->worker_ida, worker->id);
+		worker_detach_from_pool(worker);
+		kfree(worker);
+		return 0;
+	}
+
+	worker_leave_idle(worker);
+	goto loop;
 }
 
 /**
-- 
2.19.1.6.gb485710b

