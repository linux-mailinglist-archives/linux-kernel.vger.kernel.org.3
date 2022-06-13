Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3554824F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiFMIz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbiFMIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E97C45;
        Mon, 13 Jun 2022 01:43:26 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHjuPIMbgdG2lR+qQVtbOKhjK916xLaRY2n9UJBw2Cs=;
        b=3n1AJdDxkYWxTvX4BubnRkoE5gGX5CHyTSD3JnTUGC5/C2IO2BOzvvIWwQk9S3zsDOiZF5
        rD3S7SRmDKRBNueFnmMfszfZMYOtQ4XrSZvzpNqp7/DkmGAnq5tM13l5gnHuwxY2WZNchW
        RXsfsCjj/HWOqJjWQF+OcUON16++oT5E4wFfkV9rQMbgezp2L0fYGPJDWa2M0wyXD5pN3o
        eOD1IfZf1k2Fql2T41JV5xhuxvd3AXSpeAozllHSO4fxjRB5m7Af5mod11tIT61bfiiYGg
        hgdJxep1dlrYD9I+HjB/0w9VfcUaV2treEOKGxMBU4XmPTbaoLR3DZiSdQopOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHjuPIMbgdG2lR+qQVtbOKhjK916xLaRY2n9UJBw2Cs=;
        b=N6P2/Y+gsKq1Uj2HVSh/ousT7E8uMViHXs1BGeRQOR5mzfW32TXfx+SvyiK5/JtwGN5r6b
        HzPuQ1MLQM/gVWDg==
From:   "tip-bot2 for Tianchen Ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix the check of nr_running at queue wakelist
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220608233412.327341-2-dtcccc@linux.alibaba.com>
References: <20220608233412.327341-2-dtcccc@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <165510980360.4207.9149154297957353437.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     28156108fecb1f808b21d216e8ea8f0d205a530c
Gitweb:        https://git.kernel.org/tip/28156108fecb1f808b21d216e8ea8f0d205a530c
Author:        Tianchen Ding <dtcccc@linux.alibaba.com>
AuthorDate:    Thu, 09 Jun 2022 07:34:11 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:30:01 +02:00

sched: Fix the check of nr_running at queue wakelist

The commit 2ebb17717550 ("sched/core: Offload wakee task activation if it
the wakee is descheduling") checked rq->nr_running <= 1 to avoid task
stacking when WF_ON_CPU.

Per the ordering of writes to p->on_rq and p->on_cpu, observing p->on_cpu
(WF_ON_CPU) in ttwu_queue_cond() implies !p->on_rq, IOW p has gone through
the deactivate_task() in __schedule(), thus p has been accounted out of
rq->nr_running. As such, the task being the only runnable task on the rq
implies reading rq->nr_running == 0 at that point.

The benchmark result is in [1].

[1] https://lore.kernel.org/all/e34de686-4e85-bde1-9f3c-9bbc86b38627@linux.alibaba.com/

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20220608233412.327341-2-dtcccc@linux.alibaba.com
---
 kernel/sched/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfa7452..294b918 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3829,8 +3829,12 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	 * CPU then use the wakelist to offload the task activation to
 	 * the soon-to-be-idle CPU as the current CPU is likely busy.
 	 * nr_running is checked to avoid unnecessary task stacking.
+	 *
+	 * Note that we can only get here with (wakee) p->on_rq=0,
+	 * p->on_cpu can be whatever, we've done the dequeue, so
+	 * the wakee has been accounted out of ->nr_running.
 	 */
-	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
+	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
 		return true;
 
 	return false;
