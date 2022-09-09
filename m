Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ECB5B2E56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiIIFxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiIIFxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:53:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6CB6D1A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:53:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so4394662pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 22:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0uEhMXPDUDFRk9g65SyN66WJYbSzpbA8SwnRw2EhGFU=;
        b=7B5ASd0p5RbvenZXMcOQY9nlGWeFOctkqQw3j7ozSxFDgjAXLf5JDHPCdIwavHE9DO
         LKIrLjzQt/XZPFgGVHsJw9zmiWb8t0O5sWCp64VV+t6tUmMGJE9YaUq4Mdc7T75KRNx9
         DooLFOXx0H5+rka8y1exh7cf/9iXfTZs9GUblLRQ1upkzI329offz7hnklOXaa6fKjV2
         TXVjCA9DLntKFF0FTyrx0YELiOtZglvoJ8Sj756TsLsBuPU4K9vkVJYC4sALcpx001Gv
         USBEyHaj4Ff/YJtF/YT4Ddz83Gy/BzM+Jy5+jrfoM0kpUGQDGjJpp5t9dj9nDjAx7VeP
         jP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0uEhMXPDUDFRk9g65SyN66WJYbSzpbA8SwnRw2EhGFU=;
        b=gISl5I5tiNzOsuG1zvVIorye8TAZRcxA1kqI2kO3uwOOwh7HjmEhrMZA203XkXx0G0
         hMdlBByksX3vs4r+A/xi1tTktzFntGYoeag/+PXuF+MZJv+H19Ol2N3vfx8ROXmZEWwF
         jD4XP86e95ZGnwSxheQVf+7BPUPEySblmqwX7sK8Tag2wAmo0Fy28/2jFveLc7RkGuQT
         47ixDTC/eqSyQNuRFBkg4prwVgFtyKGuPUd91t6ixLKg+2DltI3iUFLOfW7vaf2CvJ2L
         Y/iyBctwGPYPUXkAKABtUhqDaSdREexuVuoIfSAqZM0Jk7+diS6wwsFH6X8SusJUjOQe
         FWCA==
X-Gm-Message-State: ACgBeo20pXt1BTGR1YMFeP79hIy4Cm2d1uDbHRnT5bZqIBJzuiJSIqZI
        FpxSxT24NEto0UGVSkjIC2XWCw==
X-Google-Smtp-Source: AA6agR4/NzRF6WmODs+HNEfDatv0qjiM2g7hhwml4B0ymJVkqHpDIQZqQI6ZVy3ZdzuZXCxOYnUfKw==
X-Received: by 2002:a17:903:247:b0:16c:5017:9ad4 with SMTP id j7-20020a170903024700b0016c50179ad4mr12809435plh.115.1662702814994;
        Thu, 08 Sep 2022 22:53:34 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id y66-20020a636445000000b00421841943dfsm464380pgb.12.2022.09.08.22.53.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 22:53:34 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v5 4/5] sched/fair: Skip SIS domain scan if fully busy
Date:   Fri,  9 Sep 2022 13:53:03 +0800
Message-Id: <20220909055304.25171-5-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909055304.25171-1-wuyun.abel@bytedance.com>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
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

If a full domain scan failed, then no unoccupied cpus available
and the LLC is fully busy.  In this case we'd better use cpus
more wisely, rather than wasting it trying to find an idle cpu
that probably not exist. The fully busy status will be cleared
when any cpu of that LLC goes idle and everything goes back to
normal again.

Make the has_idle_cores boolean hint more rich by turning it
into a state machine.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h | 35 +++++++++++++++++-
 kernel/sched/fair.c            | 67 ++++++++++++++++++++++++++++------
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc444e..cc6089765b64 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -77,10 +77,43 @@ extern int sched_domain_level_max;
 
 struct sched_group;
 
+/*
+ * States of the sched-domain
+ *
+ * - sd_has_icores
+ *	This state is only used in LLC domains to indicate worthy
+ *	of a full scan in SIS due to idle cores available.
+ *
+ * - sd_has_icpus
+ *	This state indicates that unoccupied (sched-idle/idle) cpus
+ *	might exist in this domain. For the LLC domains it is the
+ *	default state since these cpus are the main targets of SIS
+ *	search, and is also used as a fallback state of the other
+ *	states.
+ *
+ * - sd_is_busy
+ *	This state indicates there are no unoccupied cpus in this
+ *	domain. So for LLC domains, it gives the hint on whether
+ *	we should put efforts on the SIS search or not.
+ *
+ * For LLC domains, sd_has_icores is set when the last non-idle cpu of
+ * a core becomes idle. After a full SIS scan and if no idle cores found,
+ * sd_has_icores must be cleared and the state will be set to sd_has_icpus
+ * or sd_is_busy depending on whether there is any idle cpu. And during
+ * load balancing on each SMT domain inside the LLC, the state will be
+ * re-evaluated and switch from sd_is_busy to sd_has_icpus if idle cpus
+ * exist.
+ */
+enum sd_state {
+	sd_has_icores,
+	sd_has_icpus,
+	sd_is_busy
+};
+
 struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
-	int		has_idle_cores;
+	enum sd_state	state;
 	int		nr_idle_scan;
 };
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fad289530e07..25df73c7e73c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6262,26 +6262,47 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
-static inline void set_idle_cores(int cpu, int val)
+static inline void set_llc_state(int cpu, enum sd_state state)
 {
 	struct sched_domain_shared *sds;
 
 	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
 	if (sds)
-		WRITE_ONCE(sds->has_idle_cores, val);
+		WRITE_ONCE(sds->state, state);
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline enum sd_state get_llc_state(int cpu, enum sd_state def)
 {
 	struct sched_domain_shared *sds;
 
 	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
 	if (sds)
-		return READ_ONCE(sds->has_idle_cores);
+		return READ_ONCE(sds->state);
 
 	return def;
 }
 
+static inline void clear_idle_cpus(int cpu)
+{
+	set_llc_state(cpu, sd_is_busy);
+}
+
+static inline bool test_idle_cpus(int cpu)
+{
+	return get_llc_state(cpu, sd_has_icpus) != sd_is_busy;
+}
+
+static inline void set_idle_cores(int cpu, int core_idle)
+{
+	set_llc_state(cpu, core_idle ? sd_has_icores : sd_has_icpus);
+}
+
+static inline bool test_idle_cores(int cpu, bool def)
+{
+	return sd_has_icores ==
+	       get_llc_state(cpu, def ? sd_has_icores : sd_has_icpus);
+}
+
 /*
  * Scans the local SMT mask to see if the entire core is idle, and records this
  * information in sd_llc_shared->has_idle_cores.
@@ -6291,25 +6312,29 @@ static inline bool test_idle_cores(int cpu, bool def)
  */
 void __update_idle_core(struct rq *rq)
 {
-	int core = cpu_of(rq);
-	int cpu;
+	enum sd_state old, new = sd_has_icores;
+	int core = cpu_of(rq), cpu;
 
 	if (rq->ttwu_pending)
 		return;
 
 	rcu_read_lock();
-	if (test_idle_cores(core, true))
+	old = get_llc_state(core, sd_has_icores);
+	if (old == sd_has_icores)
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		if (cpu == core)
 			continue;
 
-		if (!available_idle_cpu(cpu))
-			goto unlock;
+		if (!available_idle_cpu(cpu)) {
+			new = sd_has_icpus;
+			break;
+		}
 	}
 
-	set_idle_cores(core, 1);
+	if (old != new)
+		set_llc_state(core, new);
 unlock:
 	rcu_read_unlock();
 }
@@ -6370,6 +6395,15 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 
 #else /* CONFIG_SCHED_SMT */
 
+static inline void clear_idle_cpus(int cpu)
+{
+}
+
+static inline bool test_idle_cpus(int cpu)
+{
+	return true;
+}
+
 static inline void set_idle_cores(int cpu, int val)
 {
 }
@@ -6406,6 +6440,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	struct sched_domain *this_sd;
 	u64 time = 0;
 
+	if (!test_idle_cpus(target))
+		return -1;
+
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
 		return -1;
@@ -6482,8 +6519,14 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
-	if (has_idle_core)
-		set_idle_cores(target, false);
+	/*
+	 * If no idle cpu can be found, set LLC state to busy to prevent
+	 * us from SIS domain scan to save a few cycles.
+	 */
+	if (idle_cpu == -1)
+		clear_idle_cpus(target);
+	else if (has_idle_core)
+		set_idle_cores(target, 0);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		time = cpu_clock(this) - time;
-- 
2.37.3

