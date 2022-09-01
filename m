Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8965A9844
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiIANNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiIANM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B82B195
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:11:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w2so17085293pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OgVgUilzFsIBU0tAMe4USLpgSwsnupiXGWp99EoaMlM=;
        b=e1ZrGOhmw/U8yP58S9RoxKjVrPHDwzHapZU9RMAzdPhVyj5HL/RaPLd7i8NWAdUmUo
         daxg6C5Fyp4Rc3wU8vjNL1zID3LCLheHnS7jNqbXe2zWYuWTK4r6gLspwdOKQz3wrw32
         Ll9kujuWs1tVkPaRYYU6+NSCF/Whea2bGh1RjLvCrTOIkS7l+dUErpUthhXIWDnfJb+O
         UPJX4BQj2RkTvgkcbB+GvGK8lg126V2/c8ooK41FaeCn9VFuSMDoFUm+SS2mS4BXDH6n
         UXZ6L7/tzhHY89Wmvu12Ak6hEbvyU64d+Icn8+szR6EmjFKz0gE1NNsSypWsoQWhbyIg
         3lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OgVgUilzFsIBU0tAMe4USLpgSwsnupiXGWp99EoaMlM=;
        b=0Radw0QuWHunz/uXEkpbqLrKAv25kX6dXn3qcLZ/9yRD8PYwkMBjQqitD8M7b3xpY+
         j00oVQK1v7KDECACW3kkVLRMAeD4DVn66mBZ0c/IlDCpbj1REhsTNJSTFl9hpszXDRVH
         xNtWN4CVrfYyRfgmxEwOFx3hah0MMfRr+sC/kRXqBqiA1z68iNtrp0G35zY0iARe+IxF
         MrpSHp+viqqY0lq3ED8XSAH/ZirS24vFzl4W2CZ7eFXWePaiK1X/DD3aCaXdFVXBn4lC
         mjWr9mUnI5Ur5yy+41CGI8RSUISCQFdeJCq5clzn7lLG3UPFRJSZc4MyOXa6KH3He/r9
         4w+w==
X-Gm-Message-State: ACgBeo3vTgxpkVqNMqsfg8HI5Zt+b2cePLwMb5zEEdao2L7HwdkAd/FT
        FFJBlDD9sUMhtDleCbcSYBjjSA==
X-Google-Smtp-Source: AA6agR5qKm8e/wuk2zDoXk4eJZrUxUwtgnl8zSJoakLJhlghpeNt7PyhSD7e6Hd7StZetjYVo2xxAQ==
X-Received: by 2002:a17:902:d4c4:b0:172:f328:e474 with SMTP id o4-20020a170902d4c400b00172f328e474mr30896085plg.144.1662037904493;
        Thu, 01 Sep 2022 06:11:44 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00175111a277dsm6221156plg.185.2022.09.01.06.11.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:11:43 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 4/5] sched/fair: default to false in test_idle_cores
Date:   Thu,  1 Sep 2022 21:11:06 +0800
Message-Id: <20220901131107.71785-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220901131107.71785-1-wuyun.abel@bytedance.com>
References: <20220901131107.71785-1-wuyun.abel@bytedance.com>
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

