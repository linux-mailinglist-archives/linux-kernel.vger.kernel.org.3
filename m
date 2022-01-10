Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6116D489F90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbiAJSuQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 13:50:16 -0500
Received: from mxchg01.rrz.uni-hamburg.de ([134.100.38.111]:38967 "EHLO
        mxchg01.rrz.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242083AbiAJSuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:50:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxchg01.rrz.uni-hamburg.de (Postfix) with ESMTP id 6034EA1636;
        Mon, 10 Jan 2022 19:44:18 +0100 (CET)
X-Virus-Scanned: by University of Hamburg ( RRZ / mgw04.rrz.uni-hamburg.de )
Received: from mxchg04.rrz.uni-hamburg.de (mxchg04.rrz.uni-hamburg.de [134.100.38.114])
        by mxchg01.rrz.uni-hamburg.de (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 19:44:18 +0100 (CET)
X-Virus-Scanned: by University of Hamburg ( RRZ / mgw04.rrz.uni-hamburg.de )
Received: from exchange.uni-hamburg.de (UN-EX-MR08.uni-hamburg.de [134.100.84.75])
        by mxchg04.rrz.uni-hamburg.de (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 19:44:18 +0100 (CET)
Received: from plasteblaster (89.244.206.250) by UN-EX-MR08.uni-hamburg.de
 (134.100.84.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 19:44:18 +0100
Date:   Mon, 10 Jan 2022 19:44:17 +0100
From:   "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
To:     Balbir Singh <bsingharora@gmail.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] taskstats: version 11 with tgid
Message-ID: <20220110194417.147d4eff@plasteblaster>
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Hamburg
X-Mailer: Claws Mail (x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [89.244.206.250]
X-ClientProxiedBy: UN-EX-MR05.uni-hamburg.de (134.100.84.72) To
 UN-EX-MR08.uni-hamburg.de (134.100.84.75)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 9d3d915c4e0c1e4ff3a54d73851cedb613c7df44 Mon Sep 17 00:00:00 2001
From: "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Date: Mon, 10 Jan 2022 17:10:41 +0100
Subject: [PATCH 1/2] taskstats: version 11 with tgid

This adds the ac_tgid field to the taskstats struct, to be able to tell
apart (additional) threads and processes when a client application monitors
task exit events.

I need this for giving HPC users an overview over how many instances of
which programs they ran and how much resources each one used, including
the distinction between multithreaded programs (parallelized scientific
applications) and many process instances (script calling lots of
short-running programs). It is nice to get this information accurately via
taskstats with a data set once for each task that exits, as opposed to
expensive/inaccurate sampling of any sort.

There are process ID and parent process ID already in the struct. The
thread group ID seems like something that should accompany those, anyway.

base-commit: df0cc57e057f18e44dac8e6c18aba47ab53202f9

Signed-off-by: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
---
 include/uapi/linux/taskstats.h | 4 +++-
 kernel/tsacct.c                | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index ccbd08709321..9248dc6bcb4a 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */
 
 
-#define TASKSTATS_VERSION	10
+#define TASKSTATS_VERSION	11
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */
 
@@ -172,6 +172,8 @@ struct taskstats {
 
 	/* v10: 64-bit btime to avoid overflow */
 	__u64	ac_btime64;		/* 64-bit begin time */
+	/* v11: thread group ID to identify process vs. (non-leader) thread */
+	__u32   ac_tgid;
 };
 
 
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index f00de83d0246..959ae3a26f1b 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -52,6 +52,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_nice	 = task_nice(tsk);
 	stats->ac_sched	 = tsk->policy;
 	stats->ac_pid	 = task_pid_nr_ns(tsk, pid_ns);
+	stats->ac_tgid   = task_tgid_nr_ns(tsk, pid_ns);
 	rcu_read_lock();
 	tcred = __task_cred(tsk);
 	stats->ac_uid	 = from_kuid_munged(user_ns, tcred->uid);

base-commit: df0cc57e057f18e44dac8e6c18aba47ab53202f9
-- 
2.29.2



-- 
Dr. Thomas Orgis
HPC @ Universität Hamburg
