Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64B65A9839
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiIANN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiIANMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98673A5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:11:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso2430441pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RRqSMFNoW/cIHVbpeeBppz0F/PdamR7IpDVsHgGJtSA=;
        b=Eqa+jABW4skIvnhjpw+8aHdrWhY92JYBFYH7jF7a1oQdEvCPKFMdnak1cncyW5nrSr
         RnPmHgclSdpD9SMNOF1nPgQiYg7fUwXljgK9/5dEaybd381jFHUw2XYuKRGYya+qJMUZ
         wlJhQcjPRFAtfLrWls64U8KNVDLx/6rjkXH9bxPuAROu60+HG9enxVGyO/hd5rS4JtvB
         dgXvHHlv1q/5ajs91C8KBiDcY2hnt4OImNuyiV6cdMg7AUSIiV5o3os3mB16Y8lY05RS
         /VItUDZy2uSpGhnP4VlCSr1tZYrSxD1VtPmysUsgFkRvo1mbqYxanC7/dohrm+RGL1tn
         MIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RRqSMFNoW/cIHVbpeeBppz0F/PdamR7IpDVsHgGJtSA=;
        b=EAdjEOmNyuYmW+NsSef2f9G+U+pU+O4srdafGSOxxpFTxQ6jAIK8YHueH9VUCT1a4g
         u5ctPDRiiLr4lECYJbxQ9TmxUhT//Yfq/DkqUHsRxfM7d56uRhAXR5n+BD6MJMR0zd+G
         LMS0jl57GzdB6zAkoteHo8ot+pUu8BsANs3/cv0dAhmktaTnfVfDCt06EHtQGb+yoQiw
         2Cucw+qdhPZK8RJaD19xPpvhoK9WKLZg4y2BnTjLIZX4ptIu4hVO9gpx9nrF10vGkcWJ
         uIwjaHNLzUFiTmnGA/MwA3Nz0scKn46t4Z8zhIO2dzgrS7EeEUu2pvv4WFvXdgygUGFR
         y91Q==
X-Gm-Message-State: ACgBeo0X6euj4I2kb2hTvgH1Fdx7o2jHDt9kGtgTa/qlftVtT66ck9Y+
        RCRY5zu6TPRS87mxWjiQ3Fb+1g==
X-Google-Smtp-Source: AA6agR7VpjLgG5FmnXKBGBoBS93IriE++mHWXH3TBZ6VtR1CRYZlmHuDsDUMwHvJ69UYjW0S3erNqw==
X-Received: by 2002:a17:902:d4c4:b0:170:9fdb:4a2a with SMTP id o4-20020a170902d4c400b001709fdb4a2amr29677345plg.137.1662037886268;
        Thu, 01 Sep 2022 06:11:26 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00175111a277dsm6221156plg.185.2022.09.01.06.11.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:11:25 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 1/5] sched/fair: remove redundant check in select_idle_smt
Date:   Thu,  1 Sep 2022 21:11:03 +0800
Message-Id: <20220901131107.71785-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
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

If two cpus share LLC cache, then the two cores they belong to
are also in the same LLC domain.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Josh Don <joshdon@google.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index efceb670e755..9657c7de5f57 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6350,14 +6350,11 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_smt(struct task_struct *p, int target)
 {
 	int cpu;
 
-	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
-		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
-			continue;
+	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
@@ -6381,7 +6378,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static inline int select_idle_smt(struct task_struct *p, int target)
 {
 	return -1;
 }
@@ -6615,7 +6612,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target, false);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, sd, prev);
+			i = select_idle_smt(p, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.31.1

