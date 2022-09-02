Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8215AA667
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiIBDbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiIBDbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:31:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E6ABF23
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:30:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso4297555pjd.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 20:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OgVgUilzFsIBU0tAMe4USLpgSwsnupiXGWp99EoaMlM=;
        b=lv6bbeT68Rj7eEAWwTMjtwB7upXVSZb9NBGza33CuLhHx8fsLrhk0DB/dc4C6RMYmo
         J+xTxWVLlNlc0m6sAS+TAu7DTZ0TknA9A+9YU5ufJqdzrGX30gBXiqx6Uq12feJNi0zb
         ZFeLKSNoLyobeAoGy3b3P1IK99pSDEBO+VufxUnigRg5tVa4tQM75vI631EmboImr8zw
         75OYdRkPil3aBSLnX10+xP/Q3V6lZsR98RGys92nueDYKsBMOJOIEHTr13xnVPVWzPqq
         MMCEEB3VTcl8YmtnaKpLVKFfFdjNtvILcxbrWOQq5lMgt7MVuJ/czWhHGDn+TkDRuiqh
         GxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OgVgUilzFsIBU0tAMe4USLpgSwsnupiXGWp99EoaMlM=;
        b=3ke1HJbfk5kERjYjwN08gcNmyAHJGnVqnisJ93r043DHbBq9cigKhXwxS4vamxwJ3n
         1G6hVJRw1lrqur6I29VYzHw0zJOzc9m/FKb4s8I3dA84vVt8/RA96QzkbKOxmCyecXcJ
         yD6ythKOT88F0pmU0HkmZ2e3rxdpTLlE0jyT4TbwDsTegrMIoamRgbs82fgKsQSRgHUp
         h9vyK3qBSO80bNWcl20WquyDT4f5Dhi2CqRCNKRMfY9U6H5Z6GGsdmPsOJGsA5oV/que
         3l1mDjwUyAo7OjzvVNEjU174outVVJVOKbeTrP7RoWgpHxO4eVFJRmpByW1lrQDk8/du
         nf4w==
X-Gm-Message-State: ACgBeo2viVVIhilNXFpK9hHXAHrSidmaURKwr/55h9OG2dAVvjUZSVwr
        W9GvoSi1dBoIJlejdbep/PEXNQ==
X-Google-Smtp-Source: AA6agR4ExNh5/GhgLE84Oetd30ckScdV3voduZ0majAdDbjgnlDIBCMV5JQSacunzLfIB1LCjNH99g==
X-Received: by 2002:a17:903:3093:b0:174:41c0:639f with SMTP id u19-20020a170903309300b0017441c0639fmr30973513plc.54.1662089453787;
        Thu, 01 Sep 2022 20:30:53 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id w21-20020a634915000000b0042a93b625d4sm325680pga.27.2022.09.01.20.30.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 20:30:53 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 4/5] sched/fair: default to false in test_idle_cores
Date:   Fri,  2 Sep 2022 11:30:31 +0800
Message-Id: <20220902033032.79846-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902033032.79846-1-wuyun.abel@bytedance.com>
References: <20220902033032.79846-1-wuyun.abel@bytedance.com>
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
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03ce65068333..23b020c3d3a0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1588,11 +1588,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
 
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
@@ -6271,7 +6271,7 @@ static inline void set_idle_cores(int cpu, int val)
 		WRITE_ONCE(sds->has_idle_cores, val);
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline bool test_idle_cores(int cpu)
 {
 	struct sched_domain_shared *sds;
 
@@ -6279,7 +6279,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 	if (sds)
 		return READ_ONCE(sds->has_idle_cores);
 
-	return def;
+	return false;
 }
 
 /*
@@ -6295,7 +6295,7 @@ void __update_idle_core(struct rq *rq)
 	int cpu;
 
 	rcu_read_lock();
-	if (test_idle_cores(core, true))
+	if (test_idle_cores(core))
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
@@ -6367,9 +6367,9 @@ static inline void set_idle_cores(int cpu, int val)
 {
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline bool test_idle_cores(int cpu)
 {
-	return def;
+	return false;
 }
 
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
@@ -6608,7 +6608,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return target;
 
 	if (sched_smt_active()) {
-		has_idle_core = test_idle_cores(target, false);
+		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
 			i = select_idle_smt(p, prev);
-- 
2.31.1

