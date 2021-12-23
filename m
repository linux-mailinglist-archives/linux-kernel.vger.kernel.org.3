Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0C47E35E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348344AbhLWMbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348322AbhLWMbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:31:41 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:41 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id s15so5168737pfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oha+jKr0eb2j0AvjkCYEuMRcGgslsZrifhinvWmZB+Y=;
        b=makLo1S4ZYuGlJv1JVJyr5nrb8X5+LFc+Y3G2Gl62qAWPFIQKkOQ9RZVnrlXITOWZT
         R+l3cvvRdnGoBIoIWslbO8C872r2ymKGguSDzsYCXoIcGLpr3WyAvcaReA4CiBMbyHPi
         HByphap47sQtBbBISXO8shojkGUfYzHgRFcnLTcbrHGCmDpO5qcLTRu38l9bs4foF+Zm
         NH+ZDA+WSWJTvbNIfexq2a7Y4dwGOuT9WR74nb8tIeQ5x47sBoKE73LI9eapqDLQP4bV
         Sgwarfd31PhJf6jsOpNfYiI0kGSbOlE5bujN63yM5srFY6U49e/ydCDnzVWtv/2K1NE+
         /TIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oha+jKr0eb2j0AvjkCYEuMRcGgslsZrifhinvWmZB+Y=;
        b=cQ7q1IRhl5gJcFypxpTM1Ss4/G0u7kFSst2zBBdTPk2TvyCRTEJRF/AvxiuUjXdfu8
         bH3jVNuESklPmwDiWmN93UBcfKzO6Oi1YDrFS82aqiYIFkDc3SyEWIxhgpDVXcD4BPFg
         3/ngfMJxviBJmtYNEdXK/oZMGexn5z9fFEC341MkAEQwOpA3GNft+nKjMpTBAFwSMtTN
         sr2IsER8IlI63JPZcWgNviG5qMj6u6xK6wNj3J4sv0hDUJeTkCO8sorrK3YX2QVmla+F
         kYJJxAF3V+VhqBBYQTgOJQDue583c0BJTQT/Amroj207LFljFOCZ2gu636snBWlykiPQ
         OKAw==
X-Gm-Message-State: AOAM530obB/iSiYLtIABIvOJemZcbQ0lj62KDbMHasZhteowhIfZTEKg
        wSYn9SfdD/jAZN6x4+tMi+Ml4U7Tm90=
X-Google-Smtp-Source: ABdhPJxHS6FCX2bp9CcgO29wRdpTcP+SfAxJ9hEDxabguMEgEzxPnChzzpyh4T1dBflKKjfRW9KWdA==
X-Received: by 2002:a63:90c1:: with SMTP id a184mr1957271pge.44.1640262700684;
        Thu, 23 Dec 2021 04:31:40 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id h19sm6026922pfh.30.2021.12.23.04.31.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 04:31:40 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/4] workqueue: Use wake_up_worker() in wq_worker_sleeping() instead of open code
Date:   Thu, 23 Dec 2021 20:31:39 +0800
Message-Id: <20211223123140.3789-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211223123140.3789-1-jiangshanlai@gmail.com>
References: <20211223123140.3789-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The wakeup code in wq_worker_sleeping() is the same as wake_up_worker().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b3207722671c..69cbe9e62bf1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -887,7 +887,7 @@ void wq_worker_running(struct task_struct *task)
  */
 void wq_worker_sleeping(struct task_struct *task)
 {
-	struct worker *next, *worker = kthread_data(task);
+	struct worker *worker = kthread_data(task);
 	struct worker_pool *pool;
 
 	/*
@@ -918,11 +918,8 @@ void wq_worker_sleeping(struct task_struct *task)
 	}
 
 	if (atomic_dec_and_test(&pool->nr_running) &&
-	    !list_empty(&pool->worklist)) {
-		next = first_idle_worker(pool);
-		if (next)
-			wake_up_process(next->task);
-	}
+	    !list_empty(&pool->worklist))
+		wake_up_worker(pool);
 	raw_spin_unlock_irq(&pool->lock);
 }
 
-- 
2.19.1.6.gb485710b

