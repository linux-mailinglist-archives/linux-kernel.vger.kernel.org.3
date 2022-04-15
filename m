Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645ED5027A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351920AbiDOJ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348693AbiDOJ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:57:11 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D46363
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:54:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650016479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Id7F0bBZwbU+kl7Y3j+XMtZvdbjgCDi5TDTPOpN4GdU=;
        b=Zk4aoDHIpJJgbvB00NtqUzwl4Qhff2grUyVx5+Yb6YblUYbAS9Y8jo98SPFAHfUYkiZnS1
        mivhOXdh2sQIViWYXw/UF0cmYKRSgXBWKRSJHFV5OdKDtLO10KSECKZqEc0M5SL7npyqtm
        l1sCbefWqNgc0GlM83W4uIOZTiykzg0=
From:   Tao Zhou <tao.zhou@linux.dev>
To:     LKML <linux-kernel@vger.kernel.org>, Tao Zhou <tao.zhou@linux.dev>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH V1 RESEND]: sched/fair: Revise comment about lb decision matrix
Date:   Fri, 15 Apr 2022 17:55:04 +0800
Message-Id: <20220415095505.7765-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If busiest group type is group_misfit_task, the local
group type must be group_has_spare according to below
code in update_sd_pick_busiest():

if (sgs->group_type == group_misfit_task &&
    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
     sds->local_stat.group_type != group_has_spare))
         return false;

group type imbalanced and overloaded and fully_busy are filtered in here.
misfit and asym are filtered before in update_sg_lb_stats().
So, change the decision matrix to:

busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
misfit_task      force     N/A        N/A    N/A  *N/A*      *N/A*
asym_packing     force     force      N/A    N/A  force      force
imbalanced       force     force      N/A    N/A  force      force
overloaded       force     force      N/A    N/A  force      avg_load

Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Tao Zhou <tao.zhou@linux.dev>
---

v1 changelog:
(1) Send to MAINTAINERS/REVIEWS get from `./scripts/get_maintainer.pl`
    suggested by Dietmar Eggemann.
(2) Based on v5.18-rc2

v1->v2 changelog:
(1) Add Reviewed-by from Vincent Guittot.
(2) This behavior has changed with
    cad68e552e77 ("sched/fair: Consider misfit tasks when load-balancing")
    and the matrix has not changed.
    Add the related people of commit cad68e552e77 to the cc list.

 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..b8c67e7c8cf3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9495,7 +9495,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
  * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
  * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
- * misfit_task      force     N/A        N/A    N/A  force      force
+ * misfit_task      force     N/A        N/A    N/A  N/A        N/A
  * asym_packing     force     force      N/A    N/A  force      force
  * imbalanced       force     force      N/A    N/A  force      force
  * overloaded       force     force      N/A    N/A  force      avg_load
-- 
2.35.2

