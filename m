Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A374F5EC0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiDFNDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiDFNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:02:38 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727C5C0175
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:27:24 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 7 Apr 2022
 01:24:56 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 6 Apr
 2022 17:14:28 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/fair: Return true/false (not 1/0) from bool functions
Date:   Wed, 6 Apr 2022 17:14:27 +0800
Message-ID: <1649236467-29390-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return boolean values ("true" or "false") instead of 1 or 0 from bool
functions.  This fixes the following warnings from coccicheck:

kernel/sched/fair.c:9846:9-10: WARNING: return of 0/1 in function
'imbalanced_active_balance' with return type bool

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 265bf7a75a37..deb143916cdd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9843,9 +9843,9 @@ imbalanced_active_balance(struct lb_env *env)
 	 */
 	if ((env->migration_type == migrate_task) &&
 	    (sd->nr_balance_failed > sd->cache_nice_tries+2))
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 static int need_active_balance(struct lb_env *env)
-- 
2.7.4

