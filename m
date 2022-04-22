Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117A650B515
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446554AbiDVKam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446540AbiDVKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2910D54BF5;
        Fri, 22 Apr 2022 03:27:42 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teOH439CL13s2Fik94mdeuFW3qMai2ULGSkcDlXTTO0=;
        b=jhxORQd73g5jY3hX9HNBFt8Ve3WdXFS5uc2PYmxPKkqYTupJIQBvX1KGorx2B/Tw+s4F/F
        7+dGVzfI/gV0McAcm0B3JIerzNYQ8lCqpq9Bh5caQBW5fdoH1ukTsWwRNMv94uQTiICzLt
        03XD+JotRRwH2c6dbABqycdrCJF4RC9sbGamFUBPFLSR7VUvw5c0/du7vu4SPWZ1gdHkeA
        7XMgFiiX2V7XWMAEYrCXbCAAOxekCV0+ELo7Gh1INSt4qhlQrvRZ/jhlJ9Y0zXqXSKZllU
        X+7TYu/HTdOU0SBeAH40WbQq8R6x8zzI2YqGSSsWpesRCRzc3P1xsHgkMWo++A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teOH439CL13s2Fik94mdeuFW3qMai2ULGSkcDlXTTO0=;
        b=c8NqAdYfu7i97oIFkpVvThhfBnqncQpy2L4yW049ji8kqWmjNF/YhIoVa2Plp5cgXZpWt5
        y3o5pRczKMI2QFBw==
From:   "tip-bot2 for Tao Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Revise comment about lb decision matrix
Cc:     Tao Zhou <tao.zhou@linux.dev>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220415095505.7765-1-tao.zhou@linux.dev>
References: <20220415095505.7765-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Message-ID: <165062326028.4207.17060214721845047142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a658353167bf2ea6052cee071dbcc13e0f229dc9
Gitweb:        https://git.kernel.org/tip/a658353167bf2ea6052cee071dbcc13e0f229dc9
Author:        Tao Zhou <tao.zhou@linux.dev>
AuthorDate:    Fri, 15 Apr 2022 17:55:04 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:14:08 +02:00

sched/fair: Revise comment about lb decision matrix

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
Signed-off-by: Tao Zhou <tao.zhou@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20220415095505.7765-1-tao.zhou@linux.dev
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3eba0dc..4c42012 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9496,7 +9496,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  * busiest \ local has_spare fully_busy misfit asym imbalanced overloaded
  * has_spare        nr_idle   balanced   N/A    N/A  balanced   balanced
  * fully_busy       nr_idle   nr_idle    N/A    N/A  balanced   balanced
- * misfit_task      force     N/A        N/A    N/A  force      force
+ * misfit_task      force     N/A        N/A    N/A  N/A        N/A
  * asym_packing     force     force      N/A    N/A  force      force
  * imbalanced       force     force      N/A    N/A  force      force
  * overloaded       force     force      N/A    N/A  force      avg_load
