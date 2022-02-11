Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE734B241A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349398AbiBKLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:17:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349349AbiBKLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:17:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA8E5E;
        Fri, 11 Feb 2022 03:17:03 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644578222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRgfufVdSUKCP2kKHyjfDkGXkNj1dZAV5GKsRie9cWw=;
        b=M/WEd5p0pMBVpw3CVRdS4qmdCzqg2LmPnKawKMOmGo7zJ1avbJ8LmCNNpcixKxrIw5ssKR
        NI90vN2Txb+O9e1HyNUo2wqKNz8GsW4NXdKi5IqVBRkTnRVRRoCnoytNbYG+W4PzaUXPyQ
        46ukgT5/hVRUpzM08gG+ffrnz+rM0m75PNEbj5jSNE2/McuQcBixdgIXa2G6b2f2azEjOX
        qN5r/oVmO+crUvt1ePlpNscm3PfMDAoISYwDs1GCleKiY/XcIRNyZBGuNIpFcyfqBVXGqK
        eu//QssycG4FfOVNI5hcrMWHudAQBUKcBfjgRnk8CbTR6EhOLZuZUU3eOOkEWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644578222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRgfufVdSUKCP2kKHyjfDkGXkNj1dZAV5GKsRie9cWw=;
        b=TUkKY39eIN4hFuaG1yFNvCSa0cw6a3oGrVgHZaW3ZJnG73ckqm9i3XvZ8cX/A4TDu8HFc2
        YbxMQv/jOzT1icDQ==
From:   "tip-bot2 for Minchan Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Add missing __sched attributes
Cc:     Minchan Kim <minchan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220115231657.84828-1-minchan@kernel.org>
References: <20220115231657.84828-1-minchan@kernel.org>
MIME-Version: 1.0
Message-ID: <164457822108.16921.12490199519648748991.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c441e934b604a3b5f350a9104124cf6a3ba07a34
Gitweb:        https://git.kernel.org/tip/c441e934b604a3b5f350a9104124cf6a3ba07a34
Author:        Minchan Kim <minchan@kernel.org>
AuthorDate:    Sat, 15 Jan 2022 15:16:57 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Feb 2022 12:13:55 +01:00

locking: Add missing __sched attributes

This patch adds __sched attributes to a few missing places
to show blocked function rather than locking function
in get_wchan.

Signed-off-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220115231657.84828-1-minchan@kernel.org
---
 kernel/locking/percpu-rwsem.c | 5 +++--
 kernel/locking/rwsem.c        | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 70a32a5..c9fdae9 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -7,6 +7,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/sched/debug.h>
 #include <linux/errno.h>
 
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
@@ -162,7 +163,7 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
 	__set_current_state(TASK_RUNNING);
 }
 
-bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+bool __sched __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
 	if (__percpu_down_read_trylock(sem))
 		return true;
@@ -211,7 +212,7 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
 	return true;
 }
 
-void percpu_down_write(struct percpu_rw_semaphore *sem)
+void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 69aba4a..acde5d6 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1048,7 +1048,7 @@ out_nolock:
 /*
  * Wait until we successfully acquire the write lock
  */
-static struct rw_semaphore *
+static struct rw_semaphore __sched *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count;
