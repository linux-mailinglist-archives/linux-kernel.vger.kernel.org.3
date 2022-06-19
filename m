Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4207550A86
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbiFSMFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236277AbiFSMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:05:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B158112607
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso7026597pjd.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzpeKHhlQFzCLUX887NT0k9eXFdupYHEr7hAOzZ4lz8=;
        b=1If22w4K8EmyGn6L2VPze0NB1qY7LIkyE00FlMDYVsjSRQnRpd30SNOCvG72jbMKHy
         vO2XUF/rkcgCaEfWKB71brdTKVrOfJt3rIRkEjsBvIpY+ea25ca5cUMVHvq4aRBwKrAR
         Z+Fhz/TLuLyBiPuhy8h9HD5juQ56iPO2tO01Yokx1IoP0Jp+82sgTQyLMQx1r39ZiXyc
         cGvZjed0qzQhotcvVwABp8C1JvZME3FeA5HG14NMWJIBfDaBMD6BAJWmaa4OD+cTKctm
         xx+jLtOpcSu8V4HcF6EIfDYNH0Yk4bdgim8VTl4h0Jp8dOvfD96QXXKSeJrJ1eFx0R40
         9GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzpeKHhlQFzCLUX887NT0k9eXFdupYHEr7hAOzZ4lz8=;
        b=RL86g10QHNWqGsOwMahRywBMryvb1SFwi9eU5llnFLF3a7K1efvoOIa5Wu3Jwuepub
         Xq7u33R1Ruua0IyBlYgEJ93sa6h7ttVeQB3rJadOSw2TavVZSOdsID+yfxfnyBT5Ftpw
         DjHfVgmIzoK0AKUlEGEE5nCbCJWNae44+9O87ewElH0WsWKNdQgVZNQuj79SjsUAqeVR
         eWcAMcqBqzcuRdHYGxKURHvTXyTRv0QAlqQQGAJT7/pykECa79RfTE1+JYFsqKqMb+/h
         eimsm0C4FmSMvePRw57ng3xU6/UhgUyuHeLTjpYCzHREBQoj1hA7hXSNJ2siZorQiIIy
         QRwQ==
X-Gm-Message-State: AJIora9SgygD9bTMQSkzZ2pnkvtzqg6P/bMoBjFKbssCShgksaTOAlPR
        YXvLw1H4vLuHsKiVK4cYfujehA==
X-Google-Smtp-Source: AGRyM1t1jmwEjvZQhrkbyBTzBpi1cLh3o8nvCAJz6BHvgcrS93472WE0HHoH5w/Xb/2FdMc2YkupUA==
X-Received: by 2002:a17:90b:68c:b0:1ec:99f5:d911 with SMTP id m12-20020a17090b068c00b001ec99f5d911mr3421888pjz.52.1655640327061;
        Sun, 19 Jun 2022 05:05:27 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb1d5sm1594038plb.31.2022.06.19.05.05.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:05:26 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 2/7] sched/fair: remove redundant check in select_idle_smt
Date:   Sun, 19 Jun 2022 20:04:46 +0800
Message-Id: <20220619120451.95251-3-wuyun.abel@bytedance.com>
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

If two cpus share LLC cache, then the cores they belong to are also in
the same LLC domain.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5e8453e3ffb..e57d7cdf46ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6285,14 +6285,11 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
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
@@ -6316,7 +6313,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static inline int select_idle_smt(struct task_struct *p, int target)
 {
 	return -1;
 }
@@ -6538,7 +6535,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, sd, prev);
+			i = select_idle_smt(p, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.31.1

