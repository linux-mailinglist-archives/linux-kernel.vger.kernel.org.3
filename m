Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF40C46B40D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhLGHjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhLGHjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:39:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC87C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:35:53 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y7so8869274plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXKVF5cdBIVoYUcf1ImPNf+EFKz9kn61KrdDWcbSQc0=;
        b=Ylnf16MbYQzqFByZmG6cPkqCspGtw0oE0vaS4Q2/FKQGILz8X7J0uBvJMsEVCTzSpI
         MCHvvd9kXyIE0CcNj06T0ak+++NlKDxp2hBR/kJQRG6S47hNxvHOL8RlnkkVjsr3O0iE
         OlUnSa+HRQd1+HsswiNHb+zeCN9AnRWRTjKbJp3RAo4bsh7CXPJk4Fn8cTaQCBCZWfl1
         cFN3Kvr1NUKInoOWCri6R1cPqm1nLAEKlTcqHol0/lI+Rf7yHDO1UfbAR0kxtjnDl0Wo
         Ceuz0eEGjckTmglRw/HXsWQixwOv9eyskqLLTQbpvje1vxZEd6bJW0/q8gwVM8ljw9Vu
         A6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXKVF5cdBIVoYUcf1ImPNf+EFKz9kn61KrdDWcbSQc0=;
        b=bYdCJFQWADfhs16+uCw/Y2i93FfBco1Fy9NuWrW6XT77QF7ZShRTma/iVeE8q9nSUI
         s4hs1cmOZ6recrcp53REzUWNtrFnBGv6jerVQ9wr9+JD37TDhimo5pjPuIdB0pT1OfZ5
         rdlCY19fha4wadl5qhJVc420XBVuUeEMgbfn/7byciyFQ2wPLizeXdxDXC4yFuF45a0i
         +1OHnKAi4GgObzMDC19OzrLfggv76UCGwGxJ0fnB7cwdSl/q8mysFcaFFnVtnaxCrmW2
         zFtSWdO65kUM8iVBcnt+r7SF5Z6tNskQbcxTFauaZGWdtP9gGDpioaPZXXr2mIZUphLw
         rFOQ==
X-Gm-Message-State: AOAM533sMgDi9bB6f3z63mpIE0IQRx0trg6YxFcqUt0xZEYnkuP+x+xt
        SR8IEmdHYBbKdf5I6gmfsdTppMHLXDo=
X-Google-Smtp-Source: ABdhPJyyzz8qkhYsbgMTqdfUlVaKVK+rARtAop4/+pr7gBFNd64t17GLqypYZghf/KJQkbLMdEyx+Q==
X-Received: by 2002:a17:90b:2504:: with SMTP id ns4mr4438846pjb.175.1638862552813;
        Mon, 06 Dec 2021 23:35:52 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id t7sm1773859pjs.45.2021.12.06.23.35.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:35:52 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 4/7] workqueue: Remove schedule() in unbind_workers()
Date:   Tue,  7 Dec 2021 15:35:40 +0800
Message-Id: <20211207073543.61092-5-jiangshanlai@gmail.com>
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
and moved the schedule callback from the wakeup code to at end of
schedule() in the worker's process context.

It means that the callback wq_worker_running() must be guaranteed that
it sees the %WORKER_UNBOUND flag after scheduled since unbind_workers()
is running on the same CPU that all the pool's workers bound to.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ad663853bb78..595f9bd5ad29 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4999,6 +4999,9 @@ static void unbind_workers(int cpu)
 		 * We've blocked all attach/detach operations. Make all workers
 		 * unbound and set DISASSOCIATED.  Before this, all workers
 		 * must be on the cpu.  After this, they may become diasporas.
+		 * And the preemption disabled section in their sched callbacks
+		 * are guaranteed to see WORKER_UNBOUND since the code here
+		 * is on the same cpu.
 		 */
 		for_each_pool_worker(worker, pool)
 			worker->flags |= WORKER_UNBOUND;
@@ -5014,14 +5017,6 @@ static void unbind_workers(int cpu)
 
 		mutex_unlock(&wq_pool_attach_mutex);
 
-		/*
-		 * Call schedule() so that we cross rq->lock and thus can
-		 * guarantee sched callbacks see the %WORKER_UNBOUND flag.
-		 * This is necessary as scheduler callbacks may be invoked
-		 * from other cpus.
-		 */
-		schedule();
-
 		/*
 		 * Sched callbacks are disabled now.  Zap nr_running.
 		 * After this, nr_running stays zero and need_more_worker()
-- 
2.19.1.6.gb485710b

