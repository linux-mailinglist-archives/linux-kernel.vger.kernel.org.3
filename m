Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CCB5AA660
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiIBDaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiIBDam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:30:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1754E6CF46
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:30:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j5so656988plj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 20:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RRqSMFNoW/cIHVbpeeBppz0F/PdamR7IpDVsHgGJtSA=;
        b=ieXOM6So1q38BgNcA3HUrGTpasyOfAoBrzIPTlFwOfjByRiv5g5gEk2lv3rO9IpTe4
         Rrb4Rw3zDNwW/3zv3sjVXGhi9gBIraN61bkH3jAE49Sbr2sGwAJdbK1FqPDu25hvzTr1
         ECWkzDagKaqhtuhu/42GN9uYBjfoWZGENxzEX5BDbNiMApeE752yp6PBUB9TWf3QC7hQ
         5dciYb4GTGY1ka+eC8tJ8nS6ruSj/TepTT3IXDP+0rTtgqRK5O+rmxXyGTXE96yQqpl9
         ZZ098QJA+A96U08JQuhIJLwVfJuhRG02IS1dcpjLa2RDy86KHOQFOQviVnim1gBejQ9L
         kmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RRqSMFNoW/cIHVbpeeBppz0F/PdamR7IpDVsHgGJtSA=;
        b=tX/RtfSPIVN2CAdm0lsiBEr+lym9I8fc7vlWL456AkDhDQta/Z6yEEMxrEaQP0DCmd
         Zl9nS8Bo2t5adt4R3cyzMPhxKomKl2XkZcjC332bBXoRrYOGjxRvdP1SHQTAB+2BlqqQ
         j5k6eytJ2eyQCah+mF41/u0sfjkfpnmj/qdrY1CxJbLVSG2k9NuzOB+Or78nC87mEFBc
         KW34FiLvVKy4wHAx+auK0NA4Y0sEiKKE0gubJgK5zPCLpGTeMBz0KrJSyDbmUSJCZjFn
         tAg8vN62OvUlEHKTWzwCQecIF2Ny2GRSjcissuqxsHzoRRtlAeqLNE0KWt2czg+7rvH+
         wuJQ==
X-Gm-Message-State: ACgBeo1ywRM7yMYrvm5aPxTr15ZDg8iHxOtmYtBB63YsWZwnd5aY3uul
        ZI7PsD3GQb59I0yADSvxoswugZL34g2PgQiL
X-Google-Smtp-Source: AA6agR4RQxSmcZI7FlplqOgABqhekS1rIHU1sCY9AmJ0KHt83R9zIE3vBcqQdtIB8Dfl1zNaJM5w/g==
X-Received: by 2002:a17:902:d4c4:b0:173:1206:cee7 with SMTP id o4-20020a170902d4c400b001731206cee7mr33052643plg.142.1662089441570;
        Thu, 01 Sep 2022 20:30:41 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id w21-20020a634915000000b0042a93b625d4sm325680pga.27.2022.09.01.20.30.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 20:30:41 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v3 1/5] sched/fair: remove redundant check in select_idle_smt
Date:   Fri,  2 Sep 2022 11:30:28 +0800
Message-Id: <20220902033032.79846-1-wuyun.abel@bytedance.com>
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

