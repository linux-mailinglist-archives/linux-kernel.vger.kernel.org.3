Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E452A47E35C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348338AbhLWMbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348322AbhLWMb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:31:28 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE332C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:28 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f125so4979517pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kU2IGw5V69WHsr+msgVWAepNWfKRz5fn/GJtcUxliE=;
        b=qxKYKnPpKERymmgIn8blY5jJHvjziOUMErAHiS9r6ZMw4SbttWfTeXEKkGqJ4e7X3w
         PvAy8/C0siV7tirI6xZdOGYyWTyK6boNs/4BK1XKRNYW4r15P0iiLcUhWofqLviXeHq5
         QmXICuMaHeuMNQ8m8Do7uncXF9U36VmanlT997rjhJXZtzC/n3srlqd0aEFRluxvg/1G
         0jiXyMEe5h6ttO+QMHDeJzaAm4hGbYGKAGRhLZ8uJmSovC46EZm5bxTaphBMmTZ5SIZY
         IFNfSkX1f7CWhGH9qHaA/v95t07yB5WOrW49xCc/Nfqs82UAm889hozrSaaBSAXZmZYp
         clyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kU2IGw5V69WHsr+msgVWAepNWfKRz5fn/GJtcUxliE=;
        b=Us03SZyEhY22rZ4yLSHq5zRvUkFM4939nF+bGiqXIpRAKo4a6KW6/YBq1sagQrD0e3
         y0R8TuyMIZTx7yKLy596yb4tif5uBo3WbhCsk+nqGZvtR+Rkdw0rzOhyq6Zln/ubBPLs
         aVGC+Qy1WqpewUwtUh0eKdTITnfmHXD5EwUE+7ikFsY/KcGPXUVKDw/ZztYvMofDvbEf
         DNm8nPlsadh8jUHrIH0i8G0jQsWtU7v2I98jhBy9Ns5uQxmHB27B9NymKwF/+dkLO2bB
         U+ULNcT/t0AVSvG/95c/bFj7qhHzYKtV0RXVZhm3LPv5WQl3PdmxJEQE1UKBRC01gQ/L
         8Tiw==
X-Gm-Message-State: AOAM532PNd/HR5PV6gSHO7aIfTDY1MPDs1FcYD+mxWp2kFIBBYFEJmMX
        GBU3OXkK4BkaQvRNcKLmT1e+U+V5OG8=
X-Google-Smtp-Source: ABdhPJwWug5PZ8WyHwFq56cJodez2jvjjywJ9LRYlSCnynw2ZbdUaHs4TqO1UPLWR9v5IcYs9xhJPQ==
X-Received: by 2002:a65:4c81:: with SMTP id m1mr1988509pgt.427.1640262688053;
        Thu, 23 Dec 2021 04:31:28 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id u5sm6550905pfk.67.2021.12.23.04.31.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 04:31:27 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/4] workqueue: Remove the mb() pair between wq_worker_sleeping() and insert_work()
Date:   Thu, 23 Dec 2021 20:31:37 +0800
Message-Id: <20211223123140.3789-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211223123140.3789-1-jiangshanlai@gmail.com>
References: <20211223123140.3789-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In wq_worker_sleeping(), the access to worklist is protected by the
pool->lock, so the memory barrier is unneeded.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..29b070106f34 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -918,10 +918,6 @@ void wq_worker_sleeping(struct task_struct *task)
 	}
 
 	/*
-	 * The counterpart of the following dec_and_test, implied mb,
-	 * worklist not empty test sequence is in insert_work().
-	 * Please read comment there.
-	 *
 	 * NOT_RUNNING is clear.  This means that we're bound to and
 	 * running on the local cpu w/ rq lock held and preemption
 	 * disabled, which in turn means that none else could be
@@ -1372,13 +1368,6 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 	list_add_tail(&work->entry, head);
 	get_pwq(pwq);
 
-	/*
-	 * Ensure either wq_worker_sleeping() sees the above
-	 * list_add_tail() or we see zero nr_running to avoid workers lying
-	 * around lazily while there are works to be processed.
-	 */
-	smp_mb();
-
 	if (__need_more_worker(pool))
 		wake_up_worker(pool);
 }
-- 
2.19.1.6.gb485710b

