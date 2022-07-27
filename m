Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19740581FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiG0GIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG0GIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:08:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90573FA06
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:08:35 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lt3Fb2BS1zmVDr;
        Wed, 27 Jul 2022 14:06:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 14:08:32 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 14:08:31 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] sched: Print each field value left-aligned in sched_show_task()
Date:   Wed, 27 Jul 2022 14:08:19 +0800
Message-ID: <20220727060819.1085-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the values of some fields are printed right-aligned, causing
the field value to be next to the next field name rather than next to its
own field name. So print each field value left-aligned, to make it more
readable.

Before:
	stack:    0 pid:  307 ppid:     2 flags:0x00000008
After
	stack:0     pid:308   ppid:2      flags:0x0000000a

This also makes them print in the same style as the other two fields:
	task:demo0           state:R  running task

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecdcf6..54e5fb2eeee898c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8792,7 +8792,7 @@ void sched_show_task(struct task_struct *p)
 	if (pid_alive(p))
 		ppid = task_pid_nr(rcu_dereference(p->real_parent));
 	rcu_read_unlock();
-	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
+	pr_cont(" stack:%-5lu pid:%-5d ppid:%-6d flags:0x%08lx\n",
 		free, task_pid_nr(p), ppid,
 		read_task_thread_flags(p));
 
-- 
2.25.1

