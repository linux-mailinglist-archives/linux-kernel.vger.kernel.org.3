Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBB507A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355857AbiDSTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiDSThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:37:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A023BF6;
        Tue, 19 Apr 2022 12:35:02 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:35:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650396901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlvWHJF8b1esV8seniJmC7hs+4b+46cXWx9FKu3RKeE=;
        b=AjrSK1Jf+eA3xEsL0w2WRsT/5P5iPQqG3F1uzhLKY8QcOH1W4RHJm/Rs6adS43K1lUDa6N
        ZmBjXaK3+GegEH1udrzu9uFtXEjcPKUatANvrTkmjQJOEqqjeAtn8oujgE6VRNhFCTsu/g
        V84/jDo9Eg6MgMZMreqzO6S/lzYiZe+LoeolKhyLdOhVPtH6x4InqFt8kbtAsphDFDrVVA
        cBGNA/Eb5xQSGB36pka3v9/WtaGflmNpm9GulZYPh+JaMV77XgHWshRUQ+0f9ZBAwZj/jx
        9tBxhWwHvfiCOqUa0NtRiELzXT8zFdm17wbqsIsAPKu3QxuHHCf8I1FnvcBRWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650396901;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlvWHJF8b1esV8seniJmC7hs+4b+46cXWx9FKu3RKeE=;
        b=bbgxh0jBmBkSb1Y13c0FT3K8pnDSaqINV9HcWN2lhT0cz2IlRFLW7KtnfP1N/SRO9rU5BP
        syd5RsFGFaXDnfAA==
From:   "tip-bot2 for kuyo chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/pelt: Fix attach_entity_load_avg() corner case
Cc:     kuyo chang <kuyo.chang@mediatek.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220414090229.342-1-kuyo.chang@mediatek.com>
References: <20220414090229.342-1-kuyo.chang@mediatek.com>
MIME-Version: 1.0
Message-ID: <165039690015.4207.4030717443778774474.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     40f5aa4c5eaebfeaca4566217cb9c468e28ed682
Gitweb:        https://git.kernel.org/tip/40f5aa4c5eaebfeaca4566217cb9c468e28ed682
Author:        kuyo chang <kuyo.chang@mediatek.com>
AuthorDate:    Thu, 14 Apr 2022 17:02:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:15:41 +02:00

sched/pelt: Fix attach_entity_load_avg() corner case

The warning in cfs_rq_is_decayed() triggered:

    SCHED_WARN_ON(cfs_rq->avg.load_avg ||
		  cfs_rq->avg.util_avg ||
		  cfs_rq->avg.runnable_avg)

There exists a corner case in attach_entity_load_avg() which will
cause load_sum to be zero while load_avg will not be.

Consider se_weight is 88761 as per the sched_prio_to_weight[] table.
Further assume the get_pelt_divider() is 47742, this gives:
se->avg.load_avg is 1.

However, calculating load_sum:

  se->avg.load_sum = div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
  se->avg.load_sum = 1*47742/88761 = 0.

Then enqueue_load_avg() adds this to the cfs_rq totals:

  cfs_rq->avg.load_avg += se->avg.load_avg;
  cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;

Resulting in load_avg being 1 with load_sum is 0, which will trigger
the WARN.

Fixes: f207934fb79d ("sched/fair: Align PELT windows between cfs_rq and its se")
Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
[peterz: massage changelog]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/20220414090229.342-1-kuyo.chang@mediatek.com
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299..a68482d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3829,11 +3829,11 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	se->avg.runnable_sum = se->avg.runnable_avg * divider;
 
-	se->avg.load_sum = divider;
-	if (se_weight(se)) {
-		se->avg.load_sum =
-			div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
-	}
+	se->avg.load_sum = se->avg.load_avg * divider;
+	if (se_weight(se) < se->avg.load_sum)
+		se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
+	else
+		se->avg.load_sum = 1;
 
 	enqueue_load_avg(cfs_rq, se);
 	cfs_rq->avg.util_avg += se->avg.util_avg;
