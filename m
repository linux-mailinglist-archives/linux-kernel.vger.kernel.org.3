Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1E35B02C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIGLUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiIGLUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:20:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C629C509
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:20:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b144so9505131pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zgNdNFVnyT3RvVPbn2/w87CgJ8L2KSpB08/IQc4YsQE=;
        b=XR+dyQcfBvYRAdbviqvY3HgN8jfgFlTfznz1Ftjck+AzAjWQ3ELl+8Uvsj/UTjDF2C
         kaBRXGs4LpF55ccn/o4UsgVZ+1u11vPysBLmd3ptaoYjUUNVfR44kv4+elRvVzjN6jb0
         AFRdUmGmAneNeaTyWubR6kmIFjcfYmaNE7t/x7EeeFdQQl1IaFjlPUvYNUrv2w1Ssuzj
         etcuIqNwGsHT0u8EG4pMuO/JBgVkA8EbYUPRxhOecDbZGWDN/P2ioMamaNZ5NwF85Ee8
         BqQEUsPgx/m80fuIm/0X4Qtrgsz1RRTxTM23LbhHLWX+hMVEyRbrp2UHTu5XSfidICh8
         YKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zgNdNFVnyT3RvVPbn2/w87CgJ8L2KSpB08/IQc4YsQE=;
        b=wbJ4ypxz4IddPsiZvhFyMlkGkBdW+poaVRtFN/EeAP3gytKfk7pTNHExropyC9lwxw
         ickjZ/9P59oNi1/BVExAK+T//9uQ7+SX1QkKx/bCTLRFfl47/yxnVVMQeHZevVB6CUvw
         wpZ2EiZun5a0V7dwwjvpIp+ZjGAZLWWZk3fn3jJEHqhdonGGT9OkI7sJ24qhAPGjOrSQ
         tGQm3ndIec+BW6xhSUe6jzH1V+3ItX1e+lw2RCXy4G3nK8M4EfmkLf8eF/N3dzm2gV3t
         CRc3IgeoNGItRqqUMFRB+JDwqv/uZZau6VqXCToaCn4x7JgTBC+hw8oMEA3WzRM1BGVU
         xl/A==
X-Gm-Message-State: ACgBeo2laOp5Ze9UncMRHbyVC1A9Edshm88a4Ud1RW7QImUKnuGlmSpK
        f7K6Aoe1AsEFTsZrJNRbFXF8oQ==
X-Google-Smtp-Source: AA6agR6GyoYZk7c6Nnffk9vHlWOkHTJSB5mjnEosrMB01rPpaslj2Wtnu1jM1A2ZeoFMdR7jk+yTiQ==
X-Received: by 2002:a63:5658:0:b0:42a:1663:b965 with SMTP id g24-20020a635658000000b0042a1663b965mr2958745pgm.486.1662549633605;
        Wed, 07 Sep 2022 04:20:33 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d12-20020a63f24c000000b0042ba0a822cbsm10334731pgk.8.2022.09.07.04.20.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:20:33 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v4 4/5] sched/fair: Default to false in test_idle_cores()
Date:   Wed,  7 Sep 2022 19:19:59 +0800
Message-Id: <20220907112000.1854-5-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907112000.1854-1-wuyun.abel@bytedance.com>
References: <20220907112000.1854-1-wuyun.abel@bytedance.com>
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
of this core and set hint to shared sched-domain if necessary.
So the whole logic of this function depends on the existence
of shared sched-domain, and can certainly bail out early if
it is not available.

It's somehow a little tricky, and as Josh suggested that it
should be transient while the domain isn't ready. So remove
the self-defined default value to make things more clearer.

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
2.37.3

