Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23399588556
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiHCBTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHCBTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:19:18 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98D2550A7
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:19:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VLERZfb_1659489525;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VLERZfb_1659489525)
          by smtp.aliyun-inc.com;
          Wed, 03 Aug 2022 09:19:11 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/debug: avoid executing show_state and causing rcu stall warning
Date:   Wed,  3 Aug 2022 09:18:45 +0800
Message-Id: <1659489525-82994-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

If the number of CPUs is large, "sysrq_sched_debug_show" will execute for
a long time. Every time I execute "echo t > /proc/sysrq-trigger" on my
128-core machine, the rcu stall warning will be triggered. Moreover,
sysrq_sched_debug_show does not need to be protected by rcu_read_lock,
and no rcu stall warning will appear after adjustment.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5555e49..82c117e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8879,11 +8879,11 @@ void show_state_filter(unsigned int state_filter)
 			sched_show_task(p);
 	}
 
+	rcu_read_unlock();
 #ifdef CONFIG_SCHED_DEBUG
 	if (!state_filter)
 		sysrq_sched_debug_show();
 #endif
-	rcu_read_unlock();
 	/*
 	 * Only show locks if all tasks are dumped:
 	 */
-- 
1.8.3.1

