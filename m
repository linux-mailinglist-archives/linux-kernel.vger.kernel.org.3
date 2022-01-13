Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B11F48D937
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiAMNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:39:34 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:25446 "HELO
        mailgate02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S229915AbiAMNjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:39:32 -0500
Received: from mail.didiglobal.com (unknown [172.20.36.211])
        by mailgate02.didichuxing.com (Maildata Gateway V2.8) with ESMTP id 3E3BD6005E800;
        Thu, 13 Jan 2022 21:39:28 +0800 (CST)
Received: from localhost.localdomain (172.20.16.101) by
 BJSGEXMBX11.didichuxing.com (172.20.15.141) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 13 Jan 2022 21:39:27 +0800
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.211
From:   Honglei Wang <wanghonglei@didichuxing.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Honglei Wang <jameshongleiwang@126.com>
Subject: [PATCH] sched/numa: initialize numa statistics when forking new task
Date:   Thu, 13 Jan 2022 21:39:20 +0800
Message-ID: <20220113133920.49900-1-wanghonglei@didichuxing.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.20.16.101]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX11.didichuxing.com (172.20.15.141)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The child processes will inherit numa_pages_migrated and
total_numa_faults from the parent. It means even if there is no numa
fault happen on the child, the statistics in /proc/$pid of the child
process might show huge amount. This is a bit weird. Let's initialize
them when do fork.

Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..1aa0ec123a4b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2826,6 +2826,8 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	/* Protect against double add, see task_tick_numa and task_numa_work */
 	p->numa_work.next		= &p->numa_work;
 	p->numa_faults			= NULL;
+	p->numa_pages_migrated		= 0;
+	p->total_numa_faults		= 0;
 	RCU_INIT_POINTER(p->numa_group, NULL);
 	p->last_task_numa_placement	= 0;
 	p->last_sum_exec_runtime	= 0;
-- 
2.14.1

