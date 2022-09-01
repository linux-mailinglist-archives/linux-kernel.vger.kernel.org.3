Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4E5A983A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiIANN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiIANM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037723155
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:11:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c2so17047698plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jrbuE/+Ki3PbZbNcc+gY70rLAJkl8Sw712gHyc15u3Q=;
        b=czhXlRSGpf/3sG2PqjUxt6KUDdlUTHLKRhX+0yZVBn9EtBj1Wh01Jl4oIZCuJnRSfo
         jI03NbKS53hTGPMfdZtEgngQC2EK/cd2hmugISFhAYB+puJCiF410U37RlYr6INUs5Qj
         Se12+Y/dQ9Re8vwTbDu41YEVoejhZ/zQElHzTN0Kx104mL71A+3WGh2ZUnQbHTcxvhX5
         oHxKnwmYLs2AbrQN3CEaBbUokQaNrOs5evevb4J4xMCb72B/kqIhpbYAIU1/loUpJRqf
         6MgObQOLGk9/iiaNEMOuqESTd3+em2o24Hp/+m38z1gw1ZfAnDNk6qMWy3yraARv1+0z
         ogiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jrbuE/+Ki3PbZbNcc+gY70rLAJkl8Sw712gHyc15u3Q=;
        b=ONvUJA5+x2LSdrM7Lf6HNURq3BrVFbfXPGeFkNQVkJSRbc1dPFeubNVnBYL/aZJ2mM
         qjgknNf2kkP7BobTvUBUFO6PQ1Sj8qY+ocLvQChZB61dmr06IKjHwNEaYqCCwGv+N0TC
         lzwPKSi+Vo3T+r6gNFXOiuOTWRxkY+vntoC1fT+RApZLrkQls7DwlvxzvUK/1P4DHvD4
         oAC62ktSO6tAIJR935P4MUP+F8JBEy+yYKAUzxYo4wG1oew40t6TUb3mQiUH7O11lRxd
         zEf454KvnkHernsiuqKBKCuha1+Ns564X4ZLlynF9cX0DNhvD61YWsE7NWoHOzetvH4P
         +LGw==
X-Gm-Message-State: ACgBeo2ioCJ8/cpamIw/NcH67o49AGy3+vZE81w50LIeJ46gMiLLVH/K
        Gqa2JH6FkFnWHY1ufeQwJS1bJQ==
X-Google-Smtp-Source: AA6agR7jV26HzGGFgsPMNqY9/XaF5jVGK7niPYOthK/Z60GC610rUZL0LyfbShLwK6d3COucqIMerQ==
X-Received: by 2002:a17:903:22c4:b0:175:41bc:9596 with SMTP id y4-20020a17090322c400b0017541bc9596mr8376411plg.112.1662037909653;
        Thu, 01 Sep 2022 06:11:49 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00175111a277dsm6221156plg.185.2022.09.01.06.11.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:11:49 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2 5/5] sched/fair: cleanup for SIS_PROP
Date:   Thu,  1 Sep 2022 21:11:07 +0800
Message-Id: <20220901131107.71785-5-wuyun.abel@bytedance.com>
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

The sched-domain of this cpu is only used when SIS_PROP is enabled,
and it should be irrelevant whether the local sd_llc is valid or
not, since all we care about is target sd_llc if !SIS_PROP.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23b020c3d3a0..3561b18bfe9f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6399,16 +6399,16 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	struct sched_domain *this_sd;
 	u64 time = 0;
 
-	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-	if (!this_sd)
-		return -1;
-
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
 		unsigned long now = jiffies;
 
+		this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
+		if (!this_sd)
+			return -1;
+
 		/*
 		 * If we're busy, the assumption that the last idle period
 		 * predicts the future is flawed; age away the remaining
-- 
2.31.1

