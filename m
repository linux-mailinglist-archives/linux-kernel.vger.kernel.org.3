Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A44774E2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhLPOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:42:43 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33859 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbhLPOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:42:38 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JFFFQ43ZYzcbDK;
        Thu, 16 Dec 2021 22:42:18 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 22:42:37 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 22:42:36 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Nadav Amit <namit@vmware.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Subject: [PATCH v4 2/2] smp: Fix kernel-doc related mistakes
Date:   Thu, 16 Dec 2021 22:40:53 +0800
Message-ID: <20211216144053.229-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211216144053.229-1-thunder.leizhen@huawei.com>
References: <20211216144053.229-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Change "function-name:" to "function-name -".
2. The kernel-doc comments should start with "/**".
3. Add descriptions for the missing parameters.
4. Fix a mismatched function name in the comment.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/smp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 1e5221fe200296a..d00cc8e0e5d8b16 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -698,8 +698,9 @@ void flush_smp_call_function_from_idle(void)
 	local_irq_restore(flags);
 }
 
-/*
+/**
  * smp_call_function_single - Run a function on a specific CPU
+ * @cpu:  The CPU to run on.
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
  * @wait: If true, wait until function has completed on other CPUs.
@@ -809,7 +810,7 @@ int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 }
 EXPORT_SYMBOL_GPL(smp_call_function_single_async);
 
-/*
+/**
  * smp_call_function_any - Run a function on any of the given cpus
  * @mask: The mask of cpus it can run on.
  * @func: The function to run. This must be fast and non-blocking.
@@ -1005,7 +1006,7 @@ void smp_call_function_many(const struct cpumask *mask,
 EXPORT_SYMBOL(smp_call_function_many);
 
 /**
- * smp_call_function(): Run a function on all other CPUs.
+ * smp_call_function() - Run a function on all other CPUs.
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
  * @wait: If true, wait (atomically) until function has completed
@@ -1111,8 +1112,8 @@ void __init smp_init(void)
 	smp_cpus_done(setup_max_cpus);
 }
 
-/*
- * on_each_cpu_cond(): Call a function on each processor for which
+/**
+ * on_each_cpu_cond_mask() - Call a function on each processor for which
  * the supplied function cond_func returns true, optionally waiting
  * for all the required CPUs to finish. This may include the local
  * processor.
@@ -1126,6 +1127,7 @@ void __init smp_init(void)
  * @info:	An arbitrary pointer to pass to both functions.
  * @wait:	If true, wait (atomically) until function has
  *		completed on other CPUs.
+ * @mask:	The set of cpus to run on (only runs on online subset).
  *
  * Preemption is disabled to protect against CPUs going offline but not online.
  * CPUs going online during the call will not be seen or sent an IPI.
-- 
2.25.1

