Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431D34758DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbhLOM3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:29:54 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16817 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbhLOM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:29:53 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JDZLC5Cpmz91Dh;
        Wed, 15 Dec 2021 20:29:07 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 20:29:52 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 20:29:51 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Nadav Amit <namit@vmware.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Subject: [PATCH v3] smp: Fix the comments of smp_call_function_many()
Date:   Wed, 15 Dec 2021 20:29:31 +0800
Message-ID: <20211215122931.179-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit a32a4d8a815c ("smp: Run functions concurrently in
smp_call_function_many_cond()") itself says:
                  "Keep other smp_call_function_many() semantic as it is
today for backward compatibility: the called function is not executed in
this case locally."

It's clear that, the function header comments of smp_call_function_many()
does not need to be changed.

So move the comment about 'scf_flags' to smp_call_function_many_cond(),
and restore the original comments of smp_call_function_many(). The
comments have been simplified slightly to avoid duplication. And the
description of other parameters of smp_call_function_many_cond() is added.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/smp.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

v2 --> v3:
Add the descrition of other parameters of smp_call_function_many_cond().

v1 --> v2:
Delete some duplicate comments.

diff --git a/kernel/smp.c b/kernel/smp.c
index 01a7c1706a58b1d..46ef41d6b6f197e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -853,14 +853,26 @@ int smp_call_function_any(const struct cpumask *mask,
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
 /*
- * Flags to be used as scf_flags argument of smp_call_function_many_cond().
- *
  * %SCF_WAIT:		Wait until function execution is completed
  * %SCF_RUN_LOCAL:	Run also locally if local cpu is set in cpumask
  */
 #define SCF_WAIT	(1U << 0)
 #define SCF_RUN_LOCAL	(1U << 1)
 
+/**
+ * smp_call_function_many_cond(): Run a function on a set of CPUs.
+ * @mask:	The set of cpus to run on (only runs on online subset).
+ *		Whether to allow execution on the local CPU is also controlled
+ *		by @scf_flags.
+ * @func:	The function to run on all applicable CPUs.
+ * @info:	An arbitrary pointer to pass to @func.
+ * @scf_flags:	Bitmask that controls the operation. Such as SCF_WAIT,
+ *		SCF_RUN_LOCAL.
+ * @cond_func:	A callback function that is passed a cpu id and the info
+ *		parameter. The function should return a blooean value
+ *		indicating whether @func will be executed on the specified CPU.
+ *		If @cond_func is NULL, that means unconditional, always true.
+ */
 static void smp_call_function_many_cond(const struct cpumask *mask,
 					smp_call_func_t func, void *info,
 					unsigned int scf_flags,
@@ -972,14 +984,12 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 }
 
 /**
- * smp_call_function_many(): Run a function on a set of CPUs.
+ * smp_call_function_many(): Run a function on a set of other CPUs.
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
- *        (atomically) until function has completed on other CPUs. If
- *        %SCF_RUN_LOCAL is set, the function will also be run locally
- *        if the local CPU is set in the @cpumask.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
  *
  * If @wait is true, then returns once @func has returned.
  *
-- 
2.25.1

