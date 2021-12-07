Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3634246B40B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhLGHjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhLGHjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:39:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD4C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:35:42 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u11so8835108plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nN2/9Po7bX8XC5qpZjg09erIGhm1BJCFivo22bL3lhU=;
        b=ctnTLHdm0JvbIZmpjaU6jagVBaX6N7xzUtgb0THSWdD6qfsdrMnhpYtfQhlUL11Jfa
         E8gi2empJvK4IpRvD6Xf4BD+Zn1vjdAJtccRd+UzfK3sMyZxgBsRt43dQx0QLHVRNQ/7
         568VGhHwB5PStlpq5ioFYLGk9bToxhbO9MmBzCbvmO4QtKYH4KU6vIeSiQD2jli1+wSQ
         ld0HLPWbHMBWYVlBAK7htnsT8hQXtL9+x6/DW0lLkYtN8/vSE40i6JObjK3F+7Tcxmp3
         xz5g0l4Xzx1RZDHZTa9W+h8LeZHGLZ9QiqdOWC60pOOQZspK1vR3HLfVmJEPRk9LTM1k
         E6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nN2/9Po7bX8XC5qpZjg09erIGhm1BJCFivo22bL3lhU=;
        b=QzbgXwyKeOXhqI1e8wNOKSZdJSnsvz2Wb0mblNSE3lb7b3FI7rWJGxcp5/hvGtpnV9
         Mik9tFzQli39Myl2kP8mhBDdmEhjGM7iIfmr3ERlqOk9jaQviH0LjNkd2+fZEgHwgeWI
         VjTLy/4nfN9N74WXwuDDArhelt7Alz6amnKjGoeLlSLrTXW+h7N1kug0h2HlXzTwFX4i
         CMiNTz/kkhZUgQZPORxL4L/Hw3NPgJPNenmpQ0F08iFxXmCri5sofScT4QWCfE7U9q/A
         v1z7glZSimfJTjjp95UW4HxCpiOieccQCz5IM8ZnpqlanoNecaEWwRxWJkqb0gpUsgeV
         G2Tg==
X-Gm-Message-State: AOAM5301GqWEG8lSMsgKX+1Pm4W7Gf51Q2t3NE6jdpnfmNWoZMbWEjUb
        Qwgrn5QEVqBqV7IVpiF+VkuJkKQFA+8=
X-Google-Smtp-Source: ABdhPJyuWBFwq0PyYHOe1Io0CqnyzF/wpPEX36BPSSq2r4P0EBx0vxOozHnIrch2cyPL7i8QxjQKXg==
X-Received: by 2002:a17:90a:670e:: with SMTP id n14mr4683583pjj.144.1638862541683;
        Mon, 06 Dec 2021 23:35:41 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id n31sm7554771pfv.181.2021.12.06.23.35.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:35:41 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/7] workqueue: Remove the advanced kicking of the idle workers in rebind_workers()
Date:   Tue,  7 Dec 2021 15:35:38 +0800
Message-Id: <20211207073543.61092-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211207073543.61092-1-jiangshanlai@gmail.com>
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit 6d25be5782e4 ("sched/core, workqueues: Distangle worker
accounting from rq lock") changed the schedule callbacks for workqueue
and removed the local-wake-up functionality.

Now the wakingup of workers is done by normal fashion and workers not
yet migrated to the specific CPU in concurrency managed pool can also
be woken up by workers that already bound to the specific cpu now.

So this advanced kicking of the idle workers to migrate them to the
associated CPU is unneeded now.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 312b806b3956..ba8cf5f5e7fa 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5077,17 +5077,6 @@ static void rebind_workers(struct worker_pool *pool)
 	for_each_pool_worker(worker, pool) {
 		unsigned int worker_flags = worker->flags;
 
-		/*
-		 * A bound idle worker should actually be on the runqueue
-		 * of the associated CPU for local wake-ups targeting it to
-		 * work.  Kick all idle workers so that they migrate to the
-		 * associated CPU.  Doing this in the same loop as
-		 * replacing UNBOUND with REBOUND is safe as no worker will
-		 * be bound before @pool->lock is released.
-		 */
-		if (worker_flags & WORKER_IDLE)
-			wake_up_process(worker->task);
-
 		/*
 		 * We want to clear UNBOUND but can't directly call
 		 * worker_clr_flags() or adjust nr_running.  Atomically
-- 
2.19.1.6.gb485710b

