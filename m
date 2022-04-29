Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D075155BB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380835AbiD2UjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiD2UjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:39:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A0382329;
        Fri, 29 Apr 2022 13:36:02 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:35:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651264561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Cbku9NUF1Vu1YvGy4wUhcGVy/PMIvcsWErJu7LXr14=;
        b=spNC7TmAuuXL/HbG2R33fk5Wzu8JqvzQWuFUQS1uJ5aR2HL7e/nu9oDpvRI9gdVGR4HJJW
        vFhUCfq95KxsQTQEEOJXXbrqEgbddooHFBrkacJUZHLyKbzsEqaFtI9uknF1s1G0hdECeI
        UfdzqXsPHJFPHAEBFBxngVYCsCKBgMXFbzRi5oStf8Jg10xTT8ZGWkmxulB1xzwn+Rm1+1
        iSHQ5JzGr5CRPG36OzkiyOaMMWNIMvBs7agpLujyyWkP41j/OEcIrOxEjkIF9x0bRJ1JpY
        uZ9wKI7jySgh2FYlTOKZGwcl1qpvSBU3Fp4cY/aAAapZa3Bmr+bzWQ9iw81vCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651264561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Cbku9NUF1Vu1YvGy4wUhcGVy/PMIvcsWErJu7LXr14=;
        b=1n+x4EigEIn2btzbwhlcINiw9HZCGDnT/4XNwYKqb6Zaj7ySSTWXf/VO4lxxtOuB3z3fma
        8zYPb1bhHAIxN3Dg==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove sched_trace_*() helper functions
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220428144338.479094-2-qais.yousef@arm.com>
References: <20220428144338.479094-2-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <165126455989.4207.2688453900664238005.tip-bot2@tip-bot2>
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

Commit-ID:     50e7b416d2ab10b9771bd00a4d85df90ad2e4b37
Gitweb:        https://git.kernel.org/tip/50e7b416d2ab10b9771bd00a4d85df90ad2e4b37
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 28 Apr 2022 15:43:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Apr 2022 11:06:29 +02:00

sched/fair: Remove sched_trace_*() helper functions

We no longer need them as we can use DWARF debug info or BTF + pahole to
re-generate the required structs to compile against them for a given
kernel.

This moves the burden of maintaining these helper functions to the
module.

	https://github.com/qais-yousef/sched_tp

Note that pahole v1.15 is required at least for using DWARF. And for BTF
v1.23 which is not yet released will be required. There's alignment
problem that will lead to crashes in earlier versions when used with
BTF.

We should have enough infrastructure to make these helper functions now
obsolete, so remove them.

[Rewrote commit message to reflect the new alternative]
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220428144338.479094-2-qais.yousef@arm.com
---
 include/linux/sched.h | 14 +------
 kernel/sched/fair.c   | 98 +------------------------------------------
 2 files changed, 112 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 67f06f7..fc74ea2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2378,20 +2378,6 @@ static inline void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
-const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq);
-char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len);
-int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq);
-
-const struct sched_avg *sched_trace_rq_avg_rt(struct rq *rq);
-const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq);
-const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq);
-
-int sched_trace_rq_cpu(struct rq *rq);
-int sched_trace_rq_cpu_capacity(struct rq *rq);
-int sched_trace_rq_nr_running(struct rq *rq);
-
-const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
-
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7d38728..19803e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11839,101 +11839,3 @@ __init void init_sched_fair_class(void)
 #endif /* SMP */
 
 }
-
-/*
- * Helper functions to facilitate extracting info from tracepoints.
- */
-
-const struct sched_avg *sched_trace_cfs_rq_avg(struct cfs_rq *cfs_rq)
-{
-#ifdef CONFIG_SMP
-	return cfs_rq ? &cfs_rq->avg : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_avg);
-
-char *sched_trace_cfs_rq_path(struct cfs_rq *cfs_rq, char *str, int len)
-{
-	if (!cfs_rq) {
-		if (str)
-			strlcpy(str, "(null)", len);
-		else
-			return NULL;
-	}
-
-	cfs_rq_tg_path(cfs_rq, str, len);
-	return str;
-}
-EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_path);
-
-int sched_trace_cfs_rq_cpu(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq ? cpu_of(rq_of(cfs_rq)) : -1;
-}
-EXPORT_SYMBOL_GPL(sched_trace_cfs_rq_cpu);
-
-const struct sched_avg *sched_trace_rq_avg_rt(struct rq *rq)
-{
-#ifdef CONFIG_SMP
-	return rq ? &rq->avg_rt : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_avg_rt);
-
-const struct sched_avg *sched_trace_rq_avg_dl(struct rq *rq)
-{
-#ifdef CONFIG_SMP
-	return rq ? &rq->avg_dl : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_avg_dl);
-
-const struct sched_avg *sched_trace_rq_avg_irq(struct rq *rq)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_HAVE_SCHED_AVG_IRQ)
-	return rq ? &rq->avg_irq : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_avg_irq);
-
-int sched_trace_rq_cpu(struct rq *rq)
-{
-	return rq ? cpu_of(rq) : -1;
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_cpu);
-
-int sched_trace_rq_cpu_capacity(struct rq *rq)
-{
-	return rq ?
-#ifdef CONFIG_SMP
-		rq->cpu_capacity
-#else
-		SCHED_CAPACITY_SCALE
-#endif
-		: -1;
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_cpu_capacity);
-
-const struct cpumask *sched_trace_rd_span(struct root_domain *rd)
-{
-#ifdef CONFIG_SMP
-	return rd ? rd->span : NULL;
-#else
-	return NULL;
-#endif
-}
-EXPORT_SYMBOL_GPL(sched_trace_rd_span);
-
-int sched_trace_rq_nr_running(struct rq *rq)
-{
-        return rq ? rq->nr_running : -1;
-}
-EXPORT_SYMBOL_GPL(sched_trace_rq_nr_running);
