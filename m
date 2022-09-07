Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1B5B02C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIGLUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIGLUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:20:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C65783BC6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:20:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so14423656pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1+Agwc67cdmFUqKrKuUk9pQZaioY9SDdZ0DErnLUR7I=;
        b=jdsRL2VLr6BOeCk85a//yWe+laFiC5io9+vVfRcqwFsMNk/Dk2db54IZzXKtjk0xFy
         Ph8VkA2AT80oR5mLzBOUkxN9oVi6rmj9p/kbaKkzoG7nv4OHLwnTKT3u3GvT2kDgpugA
         bmu7yWys15S0ot8To5p/1FRZsHKtGN6krFaU2bXCDUbVg22UxnJKuHcnKfaBdEmU0jJn
         NopP0zanOgxBlCMRseZFFG3DPwq2PJIBKUa/KfhRim2Qsyy9t9fz0Ojh4sEk49YEz445
         vjlbUU9v3wRlFsvGum7WV+KdxmDlGKYRnnTzVzEGV/CSTL0Z34+WhR7n+zesu030EXb2
         MaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1+Agwc67cdmFUqKrKuUk9pQZaioY9SDdZ0DErnLUR7I=;
        b=iltLM+P8QMerLIlo2f760Js4o4JkOBxASD56a7K2aLFMfphcpUadCtyLpZTu6hM0TK
         p+RHes7Mwn58odGfSSZrqh31y+4lidB/0W5GXILns2YojITMusOH9U/RWW79yBGaibw+
         8WHyO9cmAWm/3JyUYsV9l9d1UX9EmLrYDQsi5jWRAEelMCKLnRhk4i79wasMjSgvUu1s
         DGeWPfe3rRU7GNqDnj+uckY/OZTKSSCZvS86YEROSmz7Yvj+3vyerusJ76VVhs/HEANQ
         tyr2J8g29EePYbLv1KYCUz2l9QBIz+z0v4jm9IZweu08llsNMea69SFUcOGtDIDHo5pv
         cTww==
X-Gm-Message-State: ACgBeo0+jPdjzkbyF8cz4wTuVtcNDd6WMT/Z86bcKyJtkUs4FJ3zbp8l
        pZnKSkNsirjR3Vr4uXTHbuVF9g==
X-Google-Smtp-Source: AA6agR6NzATHYK/Urr4ZT/bAY6RPDO7NsWA1EsZuDgIn/RzJ6HC+II5bVQ1gUsGfLPsegK3B08MTfg==
X-Received: by 2002:a17:90a:318f:b0:1fa:a374:f565 with SMTP id j15-20020a17090a318f00b001faa374f565mr30069387pjb.146.1662549621545;
        Wed, 07 Sep 2022 04:20:21 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d12-20020a63f24c000000b0042ba0a822cbsm10334731pgk.8.2022.09.07.04.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:20:21 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v4 1/5] sched/fair: Remove redundant check in select_idle_smt()
Date:   Wed,  7 Sep 2022 19:19:56 +0800
Message-Id: <20220907112000.1854-2-wuyun.abel@bytedance.com>
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
2.37.3

