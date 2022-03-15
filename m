Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F2F4D963F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345950AbiCOIcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345920AbiCOIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4869E4BFFD;
        Tue, 15 Mar 2022 01:30:56 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:30:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ag1W6+9J8xVYw7LflH0CBagDTzTojDHM624mxPFtLgw=;
        b=mrVWMOyfEtxOPaMjwgpSjw93ouDVdbXVfwQMMxLOEADwzh+u68xAaxqcrCmrhRaedGBXhI
        O3KcPUnvyFLRARQnYvqrjLotsTHom1/WDFnKVmeHXMTo9LcSaaqt76WdGjhPTJih1u9Be1
        qhUE6YqzFzgVnF4M+DtbidRJ/GBYUnPKGPTdF9C27HlZ/3FE1rz3MX3BK3PZM0/rwMjpJV
        a9geIwC0XvxzjXZFN7UardHWzRUCbVe3OqY/+BIM8omROdXFbnyNyP/i39eDBIJZ2obhy1
        xf1ekohrTM10H7ZAGCwwXBzUfZDbfDPlZrjZX3SQVd2/ZshYS7CkUlLpGfr2ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ag1W6+9J8xVYw7LflH0CBagDTzTojDHM624mxPFtLgw=;
        b=i6/WsknGHgzckL4XHlbEhlET0qa6FG8fbjXQ4U/SKLyWICK8311TpHbkPXnpLOxCngR5dz
        dPLTzj//eaUfvmBQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Reorganize, clean up and optimize
 kernel/sched/build_utility.c dependencies
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733305308.16921.6532434311471223117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e81daa7b6489e9810fa699c5104c6fd500e64fb8
Gitweb:        https://git.kernel.org/tip/e81daa7b6489e9810fa699c5104c6fd500e64fb8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 19 Jul 2021 12:43:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:34 +01:00

sched/headers: Reorganize, clean up and optimize kernel/sched/build_utility.c dependencies

Use all generic headers from kernel/sched/sched.h that are required
for it to build.

Sort the sections alphabetically.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/build_utility.c | 43 +++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 8b2b199..bc2f4d6 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -9,14 +9,53 @@
  *   coalescing source files to amortize header inclusion
  *   cost. )
  */
+#include <linux/sched/clock.h>
+#include <linux/sched/cputime.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/isolation.h>
+#include <linux/sched/loadavg.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/rseq_api.h>
+#include <linux/sched/task_stack.h>
+
+#include <linux/cpufreq.h>
+#include <linux/cpumask_api.h>
+#include <linux/cpuset.h>
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
+#include <linux/energy_model.h>
+#include <linux/hashtable_api.h>
+#include <linux/irq.h>
+#include <linux/kobject_api.h>
+#include <linux/membarrier.h>
+#include <linux/mempolicy.h>
+#include <linux/nmi.h>
+#include <linux/nospec.h>
+#include <linux/proc_fs.h>
+#include <linux/psi.h>
+#include <linux/psi.h>
+#include <linux/ptrace_api.h>
+#include <linux/sched_clock.h>
+#include <linux/security.h>
+#include <linux/spinlock_api.h>
+#include <linux/swait_api.h>
+#include <linux/timex.h>
+#include <linux/utsname.h>
+#include <linux/wait_api.h>
+#include <linux/workqueue_api.h>
+
+#ifdef CONFIG_PARAVIRT
+# include <asm/paravirt.h>
+#endif
+
+#include <uapi/linux/prctl.h>
+#include <uapi/linux/sched/types.h>
 
 #include "sched.h"
 #include "sched-pelt.h"
 #include "stats.h"
 #include "autogroup.h"
 
-#include <linux/sched_clock.h>
-
 #include "clock.c"
 
 #ifdef CONFIG_CGROUP_CPUACCT
