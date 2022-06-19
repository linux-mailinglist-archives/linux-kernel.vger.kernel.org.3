Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC147550A80
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiFSMF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbiFSMFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:05:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A62B10551
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d5so7467465plo.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tYnIeZJWwfBV2OdXoru1uz9kc7tGLTiZrbrM31DT9w=;
        b=zz0YNR0kHLVcdHcsz7c+G/zgiaXIK9NENFPDKvqJVrHMxUNaKZob3UQvE6G63Xr4jk
         TQXkhLe+zkVKJwzUMP1iuRcjymmOtNHW65H9ub1/uqHR74jFVAvlrrwv+0V9RR2qFGJP
         WMO+rpqP5ZQMkKSTBM3+4AfvpW2sWtlswvlX674poDNGEGGL2B3nPQfYHXHmkYyWyxml
         aJ/Tv0btRYAWSLRH4ZaVasze1TNNAmmHvbuDP/OUQ964zxXLO0ufRC95a8WO52kAH1Mt
         GhfkOiS2SpfgA15bzNVWCXa6RA2t6SHluNw9D2iUtbv7SYbJp4b0qlJy4vQE4dch/P44
         7nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tYnIeZJWwfBV2OdXoru1uz9kc7tGLTiZrbrM31DT9w=;
        b=3KY9YGX1Nb6xS51pUYTz9XU0iO6moh6cMoXP7g6jow5AxLwEMF9u5Vuna/ML13+OaY
         iPx88NGxN2t2t5gfYWCuDngdt/LIhmQRfeV4BiTAgKQWQYXBeqlI9P56TuofwGgotQVA
         tLVO8hNxwC7Lk9ubhLGXanNsjJVLOCunjK85rGPcDSXAxy+N31jj8WR756pxYf8uE9HN
         88+d1sU0DbmiK5fqvzT1YBdNO4ep8YKQXOEVETLac6hjxHup71IbWDEbOSiS5ErNQO6H
         +lHKchfVtAobNjYlt5otEtoSNKsq82KgBzJgXfe11AMRjv0+dhqskN3/kaIOCB1Q5OL1
         XQdg==
X-Gm-Message-State: AJIora895vTgI8RCAgfIwNpRYOGjbbqSGR1lupXL0Tv1yPdE7sWX/0jP
        lXmjaEcbU4kPR8eIuN2fCzEYmQ==
X-Google-Smtp-Source: AGRyM1tL9hQNdrxHQ5K+PYHfIingbVHE/xnUbn2a4/fVgszrya38ZRqC074wXYdur6PtIJwbDwcESQ==
X-Received: by 2002:a17:902:e804:b0:164:466:e488 with SMTP id u4-20020a170902e80400b001640466e488mr18749522plg.161.1655640347466;
        Sun, 19 Jun 2022 05:05:47 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb1d5sm1594038plb.31.2022.06.19.05.05.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:05:47 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 7/7] sched/fair: de-entropy for SIS filter
Date:   Sun, 19 Jun 2022 20:04:51 +0800
Message-Id: <20220619120451.95251-8-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619120451.95251-1-wuyun.abel@bytedance.com>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now when updating core state, there are two main problems that could
pollute the SIS filter:

  - The updating is before task migration, so if dst_cpu is
    selected to be propagated which might be fed with tasks
    soon, the efforts we paid is no more than setting a busy
    cpu into the SIS filter. While on the other hand it is
    important that we update as early as possible to keep the
    filter fresh, so it's not wise to delay the update to the
    end of load balancing.

  - False negative propagation hurts performance since some
    idle cpus could be out of reach. So in general we will
    aggressively propagate idle cpus but allow false positive
    continue to exist for a while, which may lead to filter
    being fully polluted.

Pains can be relieved by a force correction when false positive
continuously detected.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h |  7 +++++
 kernel/sched/fair.c            | 51 ++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index b93edf587d84..e3552ce192a9 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -91,6 +91,12 @@ struct sched_group;
  *	search, and is also used as a fallback state of the other
  *	states.
  *
+ * - sd_may_idle
+ *	This state implies the unstableness of the SIS filter, and
+ *	some bits of it may out of date. This state is only used in
+ *	SMT domains as an intermediate state between sd_has_icpus
+ *	and sd_is_busy.
+ *
  * - sd_is_busy
  *	This state indicates there are no unoccupied cpus in this
  *	domain. So for LLC domains, it gives the hint on whether
@@ -111,6 +117,7 @@ struct sched_group;
 enum sd_state {
 	sd_has_icores,
 	sd_has_icpus,
+	sd_may_idle,
 	sd_is_busy
 };
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d55fdcedf2c0..9713d183d35e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8768,6 +8768,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
+		bool update = update_core && (env->dst_cpu != i);
 
 		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util_cfs(i);
@@ -8777,7 +8778,11 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
 
-		if (update_core)
+		/*
+		 * The dst_cpu is not preferred since it might
+		 * be fed with tasks soon.
+		 */
+		if (update)
 			sd_classify(sds, rq, i);
 
 		if (nr_running > 1)
@@ -8801,7 +8806,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			 * and fed with tasks, so we'd better choose
 			 * a candidate in an opposite way.
 			 */
-			sds->idle_cpu = i;
+			if (update)
+				sds->idle_cpu = i;
 			sgs->idle_cpus++;
 
 			/* Idle cpu can't have misfit task */
@@ -9321,7 +9327,7 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
 {
 	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
 	enum sd_state new = sds->sd_state;
-	int this = env->dst_cpu;
+	int icpu = sds->idle_cpu, this = env->dst_cpu;
 
 	/*
 	 * Parallel updating can hardly contribute accuracy to
@@ -9331,6 +9337,22 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
 	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
 		return;
 
+	/*
+	 * The dst_cpu is likely to be fed with tasks soon.
+	 * If it is the only unoccupied cpu in this domain,
+	 * we still handle it the same way as as_has_icpus
+	 * but turn the SMT into the unstable state, rather
+	 * than waiting to the end of load balancing since
+	 * it's also important that update the filter as
+	 * early as possible to keep it fresh.
+	 */
+	if (new == sd_is_busy) {
+		if (idle_cpu(this) || sched_idle_cpu(this)) {
+			new = sd_may_idle;
+			icpu = this;
+		}
+	}
+
 	/*
 	 * There is at least one unoccupied cpu available, so
 	 * propagate it to the filter to avoid false negative
@@ -9338,6 +9360,12 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
 	 * idle cpus thus throughupt downgraded.
 	 */
 	if (new != sd_is_busy) {
+		/*
+		 * The sd_may_idle state is taken into
+		 * consideration as well because from
+		 * here we couldn't actually know task
+		 * migrations would happen or not.
+		 */
 		if (!test_idle_cpus(this))
 			set_idle_cpus(this, true);
 	} else {
@@ -9347,9 +9375,26 @@ static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
 		 */
 		if (sd_smt_shared->state == sd_is_busy)
 			goto out;
+
+		/*
+		 * Allow false positive to exist for some time
+		 * to make a tradeoff of accuracy of the filter
+		 * for relieving cache traffic.
+		 */
+		if (sd_smt_shared->state == sd_has_icpus) {
+			new = sd_may_idle;
+			goto update;
+		}
+
+		/*
+		 * If the false positive issue has already been
+		 * there for a while, a correction of the filter
+		 * is needed.
+		 */
 	}
 
 	sd_update_icpus(this, sds->idle_cpu);
+update:
 	sd_smt_shared->state = new;
 out:
 	xchg(&sd_smt_shared->updating, 0);
-- 
2.31.1

