Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDF0571466
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiGLIW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiGLIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:21:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4AA4382
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p11so160005pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/AmHtaoJN9cStmlDDuzEHtA59f9y41ieyctN/HPoTQ=;
        b=jgEQ5uhNQz9tCVVSvOkNk4YrqUylHK3wp1uDHToutGBzvvT1IgkWKk8ANT5KbTleHV
         30/MDid4zVk1iYSQ4UaBd/TpCNyguZZOoiJz7Ga4b0eM1HXpbZ9mQ/Vs9Lp+heVIEUWp
         e7j+ZvxUlkuFHs/mo9ma2fR7a/ADbFBq3ad2qYZKuxPNX5U0jttFQ1sv5U4/3FC2FJTu
         roH3S7f6quxz2h0ZyT7pvWR/Ye9505qfPGAwqG9a4jVgoJbJONU9o3u1jWufS8GHoQJA
         q7L0qx1iLw/sGJYWkICuonzPcdBaIaMqE3pK1hqYWUFs7BptOzMiMBWwBK2Wweb0xc+f
         hwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/AmHtaoJN9cStmlDDuzEHtA59f9y41ieyctN/HPoTQ=;
        b=hGOivaVFJntC3NoQ3cMG/wHKYGx/PUD5u7Se6MxFkC76R0IaJ3gtSnzcRVauzPdXnO
         nsV3lQnZtSIZ5nKYuG7EAFatp2nT1+eQCcrF+FOeXplLjq+24TJndTPN9DdHwDM/nRtD
         kOwayf4/Td3jBLOgeQOFc4fQdVhId7SfNiI2gojsP7UAhvY9DZkir+Nc0IXzGZRa0mTT
         Rd0A66FDBWOGZjhuNb05+lKidxo5lZtK0EppGha7yWo8+ttcHHFq1bfQp+/PPIFW+GRT
         sKsmQXf1OuT3CHOoKlrC6KCuLOx9rTs+vHuZdEujBn3eXghCsPyRtCEKKhNJmtzn0gIg
         IV6w==
X-Gm-Message-State: AJIora8AvisTEnPtwV/J5emFMl1oy64r+Lc49/oz+Mygnqo3sysYViKg
        4iYAztKZqYgdVAdyEzOVLCb50g==
X-Google-Smtp-Source: AGRyM1sRj7yQTDFa/JHdPgFYNqBD/fpW54n/sLLItrO12A92nmwPxi2LPUQz3frLSHs25wqPV7GRbg==
X-Received: by 2002:a63:540d:0:b0:412:9fb2:4d4 with SMTP id i13-20020a63540d000000b004129fb204d4mr19528428pgb.475.1657614083050;
        Tue, 12 Jul 2022 01:21:23 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s13-20020aa78bcd000000b0050dc762816dsm6114428pfd.71.2022.07.12.01.21.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:21:22 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 3/5] sched/fair: remove redundant check in select_idle_smt
Date:   Tue, 12 Jul 2022 16:20:34 +0800
Message-Id: <20220712082036.5130-4-wuyun.abel@bytedance.com>
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

If two cpus share LLC cache, then the two cores they belong to
are also in the same LLC domain.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c72093f282ec..0d7e8555bcf9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6339,14 +6339,11 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
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
@@ -6370,7 +6367,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static inline int select_idle_smt(struct task_struct *p, int target)
 {
 	return -1;
 }
@@ -6607,7 +6604,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, sd, prev);
+			i = select_idle_smt(p, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.31.1

