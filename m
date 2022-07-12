Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B270571465
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiGLIWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiGLIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:21:52 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0936FA2EFE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:19 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so6927630pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0oHBDiwaFsGTBwRGBiV75qzptiCX6BQhcdK4hyouxqo=;
        b=JmFoNoaxkrmQg1VmI1FYollmz7uAzIk5FB7LmTNJZ3rj6zFPoPEnpvwvtjuVK0toVk
         EmjlqkHM1YmiubjPJx6Z78aVjnM4HdmK/C3Sa4z3cxVd80tcOQuCwH9VgaEGDc7BtXge
         0oRTwhDY7heEYD2mNgtCUBn8Ynfmsba/x2jDLEDSNfNu27dfjRSt+FzMw8fU+mWtQGy/
         7E7198I3My97XR8j/a8whvC+b2oI3HgX7128TpCWF4Oc24R71HEkMXfhsQVjTEOFxoS6
         hXylAIRBUh+yFvdHwObcXxmySKCwvaaohPUJjd9E/AJY0UeHmNINzG2t/aSCrFY53VUs
         IiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0oHBDiwaFsGTBwRGBiV75qzptiCX6BQhcdK4hyouxqo=;
        b=Vt9u0ts6N89u8Xr5PD21i+0y7LECas/KylQKGsWGmynNTQr8Dmnjcn19u1mqilsib/
         7jjlqFMpO7SZLLqm26u4VYdoz9JmU8cAfiA++zQlWhm6Y/Kk4NRUM9K5E5C6yhof2j+c
         2+2JGxJzKzuIj0/9yc7IIhGy2A6hUwMFGzGtTXY9zf5gT/jugKzTLtJQbX+mjlAAhs8a
         UhK5+3XR/740THT5KVbSrrZ9bkNU3PBLCBRMiAFroUKdbwiVJ7cO1A/i6FrqWXLwrAC3
         J1cbFtKvctLJiZNTHQLHUqk9g5j992bJgiE5IrCv1vFBlsNgNpLhl/NJVdZ4tFcMIThJ
         OXJA==
X-Gm-Message-State: AJIora9WLuSeTT83QeT9mASsLKDGL2bhfMBCPHyC2aApQZ/XYHBuSwL6
        Q0XEcPFf1jbenbD8KMz5m/zWdg==
X-Google-Smtp-Source: AGRyM1tkSxpLxdnW1Lbm7AuPRSZ6cGD2bAmDVG9cX1GHsRnbV6hBE/jqbXV8HCxa1fmQiPlWbtgM3A==
X-Received: by 2002:a62:1cc8:0:b0:52a:ee9e:b735 with SMTP id c191-20020a621cc8000000b0052aee9eb735mr770805pfc.42.1657614078541;
        Tue, 12 Jul 2022 01:21:18 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s13-20020aa78bcd000000b0050dc762816dsm6114428pfd.71.2022.07.12.01.21.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:21:18 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 2/5] sched/fair: default to false in test_idle_cores
Date:   Tue, 12 Jul 2022 16:20:33 +0800
Message-Id: <20220712082036.5130-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220712082036.5130-1-wuyun.abel@bytedance.com>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
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

It's uncertain whether idle cores exist or not if shared sched-
domains are not ready, so returning "no idle cores" usually
makes sense.

While __update_idle_core() is an exception, it checks status
of this core and set to shared sched-domain if necessary. So
the whole logic depends on the existence of sds, and can bail
out early if !sds.

It's somehow a little tricky, and as Josh suggested that it
should be transient while the domain isn't ready. So remove
the self-defined default value to make things more clearer,
while introduce little overhead in idle path.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd758b3616bd..c72093f282ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1592,11 +1592,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
 
 #ifdef CONFIG_SCHED_SMT
 /* Forward declarations of select_idle_sibling helpers */
-static inline bool test_idle_cores(int cpu, bool def);
+static inline bool test_idle_cores(int cpu);
 static inline int numa_idle_core(int idle_core, int cpu)
 {
 	if (!static_branch_likely(&sched_smt_present) ||
-	    idle_core >= 0 || !test_idle_cores(cpu, false))
+	    idle_core >= 0 || !test_idle_cores(cpu))
 		return idle_core;
 
 	/*
@@ -6260,7 +6260,7 @@ static inline void set_idle_cores(int cpu, int val)
 		WRITE_ONCE(sds->has_idle_cores, val);
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline bool test_idle_cores(int cpu)
 {
 	struct sched_domain_shared *sds;
 
@@ -6268,7 +6268,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 	if (sds)
 		return READ_ONCE(sds->has_idle_cores);
 
-	return def;
+	return false;
 }
 
 /*
@@ -6284,7 +6284,7 @@ void __update_idle_core(struct rq *rq)
 	int cpu;
 
 	rcu_read_lock();
-	if (test_idle_cores(core, true))
+	if (test_idle_cores(core))
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
@@ -6360,9 +6360,9 @@ static inline void set_idle_cores(int cpu, int val)
 {
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline bool test_idle_cores(int cpu)
 {
-	return def;
+	return false;
 }
 
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
@@ -6604,7 +6604,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return target;
 
 	if (sched_smt_active()) {
-		has_idle_core = test_idle_cores(target, false);
+		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
 			i = select_idle_smt(p, sd, prev);
-- 
2.31.1

