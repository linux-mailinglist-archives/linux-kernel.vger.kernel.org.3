Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E55C47E35D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbhLWMbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348322AbhLWMbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:31:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA98C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:35 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v19so4259752plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIiF5ZTyZb7T0ax+B8TAfFCgsySuyQiALr29Do5upMg=;
        b=GN3W0HNdwuc8XOH/9p6dx27nh9gk+tkfEiV5yUs6kzQar6T5MejpJN+dhiSOb65WVh
         j3uiO1gePo8uGuVojpC2bYz8mOHViYYo27TdGPKZwnV4GwbAZh8JxpC9XLLMCp+s55Bd
         /aUR3L71GFzx/8ENsckTIIbrykRarhb00zZ1VXUeeph0EsLyPLyWmF4GoF6kV6UCqZoo
         I+VmwrEJHfhsxsYj89WGzQ5W34RTebNYtF66XsVJcjCbkma8zAzn1JLqiXzusvkNU7C8
         auZnKB/X3Dbpci6eJ+CSpwg+TEnHOWOIKJPhV+dI42hYCdcnhzFV/aBPavCmb8Qpey3n
         nyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIiF5ZTyZb7T0ax+B8TAfFCgsySuyQiALr29Do5upMg=;
        b=2mcsU7d2mvLU2dLtBAdjaKlh5/7wIlx72W/OCpCz59NrIXj6q2dDJpnVraQNbhuaLp
         9X/xHcYF3cZvBeXs//Wz2LzpvQ1/hVm0OSR4gG6nvCt5NKX/LTTO9WEvocaP0ls5+9u1
         jRl0V5kclwtEU1D9WPHxumSjhX9fZ99ELGb995+xCyfTod3gFOygveIUvG2qveXVARRz
         C6KaOCU8eqlKV0bbhQp91Yb0h772YFLeGr9OZJ7pdu2st7OwjulK4WnHbaKJ3DCCoVPm
         223orCjcn56UuyuUHqDhceL6bsc6qRA4crh7lYEBgSu/kqzwyJ1DHmz+aevV+CnveC5Q
         0r+A==
X-Gm-Message-State: AOAM532+Bi1Rx6MvsaqHpk5dLyrPSeD+SJuvm2lfyvy8gP+o61pDA0lU
        vVvHvIHfOirFqDAVJ90eJT+wgKpNHfM=
X-Google-Smtp-Source: ABdhPJwDsYkXvNVtX7ICS7gM5bKtVug8arSH2Gn7j/Ctsjj6We/jgcHUIpCJALo3GUfkSsCo5GcWMA==
X-Received: by 2002:a17:903:1246:b0:148:a658:8d32 with SMTP id u6-20020a170903124600b00148a6588d32mr2140727plh.117.1640262694495;
        Thu, 23 Dec 2021 04:31:34 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id o124sm5791904pfb.177.2021.12.23.04.31.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 04:31:34 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/4] workqueue: Change the comments of the synchronization about the idle_list
Date:   Thu, 23 Dec 2021 20:31:38 +0800
Message-Id: <20211223123140.3789-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211223123140.3789-1-jiangshanlai@gmail.com>
References: <20211223123140.3789-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The access to idle_list in wq_worker_sleeping() is changed to be
protected by pool->lock, so the comments above idle_list can be changed
to "L:" which is the meaning of "access with pool->lock held".

And the outdated comments in wq_worker_sleeping() is removed since
the function is not called with rq lock held any more, idle_list is
dereferenced with pool lock now.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 29b070106f34..b3207722671c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -162,7 +162,7 @@ struct worker_pool {
 	int			nr_workers;	/* L: total number of workers */
 	int			nr_idle;	/* L: currently idle workers */
 
-	struct list_head	idle_list;	/* X: list of idle workers */
+	struct list_head	idle_list;	/* L: list of idle workers */
 	struct timer_list	idle_timer;	/* L: worker idle timeout */
 	struct timer_list	mayday_timer;	/* L: SOS timer for workers */
 
@@ -826,7 +826,7 @@ static bool too_many_workers(struct worker_pool *pool)
  * Wake up functions.
  */
 
-/* Return the first idle worker.  Safe with preemption disabled */
+/* Return the first idle worker.  Called with pool->lock held. */
 static struct worker *first_idle_worker(struct worker_pool *pool)
 {
 	if (unlikely(list_empty(&pool->idle_list)))
@@ -917,13 +917,6 @@ void wq_worker_sleeping(struct task_struct *task)
 		return;
 	}
 
-	/*
-	 * NOT_RUNNING is clear.  This means that we're bound to and
-	 * running on the local cpu w/ rq lock held and preemption
-	 * disabled, which in turn means that none else could be
-	 * manipulating idle_list, so dereferencing idle_list without pool
-	 * lock is safe.
-	 */
 	if (atomic_dec_and_test(&pool->nr_running) &&
 	    !list_empty(&pool->worklist)) {
 		next = first_idle_worker(pool);
-- 
2.19.1.6.gb485710b

