Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039975A46BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiH2KDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiH2KDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:03:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8AA5F981
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vd9jVrMN2zfJQr2gkQEgY6lJ/h/t5ORUZobeIccBr08=; b=CmbVXb/32SiPLRq5G3OEhHKXuO
        281Sq0sDT0LBlG5L/zXcRwTINWRMPe3p0rWVerALqUzXO/RJBf05ytAcBsUHaGALZdvmfgOLmM6+T
        DzJOwzotRUOAi/SpKNdiG2nug2TaLd1GjJ1/mjodkEjGcsQvmz4tjsf6AO9mq5J06BLl/TjQtXyEP
        SjQDE0xVLdIq/2PWs9zyvmawoINJzYoYLt7lzPNYBj9e2yH2ZVQF1w9cPie9RIOyvjXnmA26yDs72
        y2U6c+G7BBahMWybQSPCwyjoBcVH4YMQbbKD27L3zH5g+ZoFkRIT0v1FDBUvfdSQc/IKaJJYaZC4e
        NO9lqQcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbbc-002zat-Ik; Mon, 29 Aug 2022 10:02:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B922300410;
        Mon, 29 Aug 2022 12:02:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65F31207FBF60; Mon, 29 Aug 2022 12:02:54 +0200 (CEST)
Date:   Mon, 29 Aug 2022 12:02:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Message-ID: <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com>
 <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 10:08:13AM +0200, Peter Zijlstra wrote:
> On Mon, Aug 29, 2022 at 07:54:50AM +0200, Dietmar Eggemann wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > 
> > The new sysctl sched_pelt_multiplier allows a user to set a clock
> > multiplier to x2 or x4 (x1 being the default). This clock multiplier
> > artificially speeds up PELT ramp up/down similarly to use a faster
> > half-life than the default 32ms.
> > 
> >   - x1: 32ms half-life
> >   - x2: 16ms half-life
> >   - x4: 8ms  half-life
> > 
> > Internally, a new clock is created: rq->clock_task_mult. It sits in the
> > clock hierarchy between rq->clock_task and rq->clock_pelt.
> > 
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> > +extern unsigned int sched_pelt_lshift;
> > +
> > +/*
> > + * absolute time   |1      |2      |3      |4      |5      |6      |
> > + * @ mult = 1      --------****************--------****************-
> > + * @ mult = 2      --------********----------------********---------
> > + * @ mult = 4      --------****--------------------****-------------
> > + * clock task mult
> > + * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
> > + * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
> > + *
> > + */
> > +static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
> > +{
> > +	delta <<= READ_ONCE(sched_pelt_lshift);
> > +
> > +	rq->clock_task_mult += delta;
> > +
> > +	update_rq_clock_pelt(rq, delta);
> > +}
> 
> Hurmph... I'd almost go write you something like
> static_call()/static_branch() but for immediates.
> 
> That said; given there's only like 3 options, perhaps a few
> static_branch() instances work just fine ?

Also, I'm not at all sure about exposing that as an official sysctl.

How about something like so?

---
Subject: sched/pelt: Introduce PELT multiplier
From: Vincent Donnefort <vincent.donnefort@arm.com>
Date: Mon, 29 Aug 2022 07:54:50 +0200

From: Vincent Donnefort <vincent.donnefort@arm.com>

The new sysctl sched_pelt_multiplier allows a user to set a clock
multiplier to x2 or x4 (x1 being the default). This clock multiplier
artificially speeds up PELT ramp up/down similarly to use a faster
half-life than the default 32ms.

  - x1: 32ms half-life
  - x2: 16ms half-life
  - x4: 8ms  half-life

Internally, a new clock is created: rq->clock_task_mult. It sits in the
clock hierarchy between rq->clock_task and rq->clock_pelt.

[peterz: Use sched_feat()]
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |    2 +-
 kernel/sched/features.h |    3 +++
 kernel/sched/pelt.h     |   45 +++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h    |    1 +
 4 files changed, 46 insertions(+), 5 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -727,7 +727,7 @@ static void update_rq_clock_task(struct
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
 #endif
-	update_rq_clock_pelt(rq, delta);
+	update_rq_clock_task_mult(rq, delta);
 }
 
 void update_rq_clock(struct rq *rq)
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -101,3 +101,6 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(PELT_M2, false)
+SCHED_FEAT(PELT_M4, false)
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -61,6 +61,14 @@ static inline void cfs_se_util_change(st
 	WRITE_ONCE(avg->util_est.enqueued, enqueued);
 }
 
+static inline u64 rq_clock_task_mult(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	assert_clock_updated(rq);
+
+	return rq->clock_task_mult;
+}
+
 static inline u64 rq_clock_pelt(struct rq *rq)
 {
 	lockdep_assert_rq_held(rq);
@@ -72,7 +80,7 @@ static inline u64 rq_clock_pelt(struct r
 /* The rq is idle, we can sync to clock_task */
 static inline void _update_idle_rq_clock_pelt(struct rq *rq)
 {
-	rq->clock_pelt  = rq_clock_task(rq);
+	rq->clock_pelt = rq_clock_task_mult(rq);
 
 	u64_u32_store(rq->clock_idle, rq_clock(rq));
 	/* Paired with smp_rmb in migrate_se_pelt_lag() */
@@ -121,6 +129,30 @@ static inline void update_rq_clock_pelt(
 	rq->clock_pelt += delta;
 }
 
+extern unsigned int sched_pelt_lshift;
+
+/*
+ * absolute time   |1      |2      |3      |4      |5      |6      |
+ * @ mult = 1      --------****************--------****************-
+ * @ mult = 2      --------********----------------********---------
+ * @ mult = 4      --------****--------------------****-------------
+ * clock task mult
+ * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
+ * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
+ *
+ */
+static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
+{
+	if (sched_feat(PELT_M2))
+		delta *= 2;
+	if (sched_feat(PELT_M4))
+		delta *= 4;
+
+	rq->clock_task_mult += delta;
+
+	update_rq_clock_pelt(rq, delta);
+}
+
 /*
  * When rq becomes idle, we have to check if it has lost idle time
  * because it was fully busy. A rq is fully used when the /Sum util_sum
@@ -147,7 +179,7 @@ static inline void update_idle_rq_clock_
 	 * rq's clock_task.
 	 */
 	if (util_sum >= divider)
-		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
+		rq->lost_idle_time += rq_clock_task_mult(rq) - rq->clock_pelt;
 
 	_update_idle_rq_clock_pelt(rq);
 }
@@ -218,13 +250,18 @@ update_irq_load_avg(struct rq *rq, u64 r
 	return 0;
 }
 
-static inline u64 rq_clock_pelt(struct rq *rq)
+static inline u64 rq_clock_task_mult(struct rq *rq)
 {
 	return rq_clock_task(rq);
 }
 
+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+	return rq_clock_task_mult(rq);
+}
+
 static inline void
-update_rq_clock_pelt(struct rq *rq, s64 delta) { }
+update_rq_clock_task_mult(struct rq *rq, s64 delta) { }
 
 static inline void
 update_idle_rq_clock_pelt(struct rq *rq) { }
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1009,6 +1009,7 @@ struct rq {
 	u64			clock;
 	/* Ensure that all clocks are in the same cache line */
 	u64			clock_task ____cacheline_aligned;
+	u64			clock_task_mult;
 	u64			clock_pelt;
 	unsigned long		lost_idle_time;
 	u64			clock_pelt_idle;
