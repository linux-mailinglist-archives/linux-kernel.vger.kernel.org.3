Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0930B49F487
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347012AbiA1Hkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:40:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346929AbiA1HkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:40:21 -0500
Date:   Fri, 28 Jan 2022 07:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643355620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgQHOP7FAc8xoIouA+Kq7XUg7z2NU+RW5HZix9IfTDQ=;
        b=SJw+Cjuqfrh+BE5clkqUFqWeEsOsW0NIDCxeIcU3ykkXAFa5mdQv3wvMxmpgrSOStfRvLR
        dphCyWMVGgpHTEp3Cw2ruqZ3nHu8HHnNgSJmGfCVqCouQKakZFKzhN53NpfMj6oJVGhoYA
        8kfbg8yEpN+4daCYLftdE6SPV6VA23frv9ezod5MoLX+93bAuyX+2uOUrZ/Kam0HbdPp2A
        KFNE7mnu6Qn161ZEU7oGgr7hCOWXYOE08bycQ7NBfC4YmMdRFQvHIAMm2EE6wWAcLZM4tZ
        zbcwmMkr4ReldTdKLfJDfyBRGb8VeyKv1Mo9WmAtdplYSBiWuTfSQ7MRy/Wcbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643355620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vgQHOP7FAc8xoIouA+Kq7XUg7z2NU+RW5HZix9IfTDQ=;
        b=HEzm+4b9uu3BBC9/Omg7fICe7EVnrhnFiVSyarihN0CNh2vSutoJbt4Zn139fLd9kkcfXN
        l4fYj/0TJHVOmpCw==
From:   "tip-bot2 for Honglei Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: initialize numa statistics when forking
 new task
Cc:     Honglei Wang <wanghonglei@didichuxing.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220113133920.49900-1-wanghonglei@didichuxing.com>
References: <20220113133920.49900-1-wanghonglei@didichuxing.com>
MIME-Version: 1.0
Message-ID: <164335561912.16921.1991988864577957433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     12bf8a7eb84e4d3547ebfd89bb0a9255a0f2acc7
Gitweb:        https://git.kernel.org/tip/12bf8a7eb84e4d3547ebfd89bb0a9255a0f2acc7
Author:        Honglei Wang <wanghonglei@didichuxing.com>
AuthorDate:    Thu, 13 Jan 2022 21:39:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Jan 2022 12:57:18 +01:00

sched/numa: initialize numa statistics when forking new task

The child processes will inherit numa_pages_migrated and
total_numa_faults from the parent. It means even if there is no numa
fault happen on the child, the statistics in /proc/$pid of the child
process might show huge amount. This is a bit weird. Let's initialize
them when do fork.

Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20220113133920.49900-1-wanghonglei@didichuxing.com
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa..5dca13f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2825,6 +2825,8 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	/* Protect against double add, see task_tick_numa and task_numa_work */
 	p->numa_work.next		= &p->numa_work;
 	p->numa_faults			= NULL;
+	p->numa_pages_migrated		= 0;
+	p->total_numa_faults		= 0;
 	RCU_INIT_POINTER(p->numa_group, NULL);
 	p->last_task_numa_placement	= 0;
 	p->last_sum_exec_runtime	= 0;
