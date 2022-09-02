Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF835AA670
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiIBDbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiIBDbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:31:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D7ABD5F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:30:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso4334798pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 20:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lJvjTHFjR/MlQGHXJlibkl9nDfd1g4HM3Pj2eRvPck4=;
        b=GOAHnH0S6cyv7TwpTZWjnad+J68z4/Dm3KLs0JL3fqxygcn1YWr1p0qz3N5bHPVvvP
         WIcDY9uhRLqdsGHVmbYx3b665v2XBFSKyM/HGxtrpWu7t5hE1SnHxr9hBorYXepUwSxu
         aj0w+EHcrIoX6Ynlc444CEt1hxoL+k9aIwZQI7zC6W1XYWXkwQA5BRsuCWJ1tStmNwhB
         r/RDCYAVJqzd26qbGxiFBJi82NGTPwFCihpoTyYARmjdVmMvZzzsGe/p1PsxPFVal0UV
         Ip49vmKmQOCKnm3AUE26YTPqVo1pVuTY8+J6yxBBDHGjowo2hIOAixhZp4IxkDL1rcQh
         eqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lJvjTHFjR/MlQGHXJlibkl9nDfd1g4HM3Pj2eRvPck4=;
        b=7wVcbwqMqxHGhSCjGrs3toUhF/7GQvQCXQ/Hr1PA1OI2WKlRIGXu0O7geP//0ol87R
         tAkdoyQu2xKFfRP5gFazS/nTLRtDuKLAWmkrhteK4vZjagP2KuiyE4yJowaKe1UH546K
         RGVFcbLe1cTBXkEhiKjJ36dz/V0VssnFeCxcXmoFd4FqaQcIP5ktwrTpPef/ZJS+jbpR
         vVzHN0UymsvEWH/WRz/IxL3SKqrKgV77+MUdszvVeC6p0rC8TAwnoVy8pLwGg/vz4Hg6
         /f5AF8FiK/wcyMTra3s69eZzLOHz3L165cFKVwlBDgyWIlyvrR8pyt3yhqB3vMJZyHOu
         m2Bg==
X-Gm-Message-State: ACgBeo0XeWAUuYmhOI4ti7tmRrliPlfEac1Hh0XgHUiwid+ET5sKXLGm
        ALBcnMIQGZrG8cpUVoVF2tfWiw==
X-Google-Smtp-Source: AA6agR67Uh2uDj3ZLIxkm51hADdq6UU+fuLxUlpjXKICu2lrwsPtvKIIJZxcakBDzaD7OEZQNsxdqw==
X-Received: by 2002:a17:902:904b:b0:172:cd04:a3d3 with SMTP id w11-20020a170902904b00b00172cd04a3d3mr34365046plz.173.1662089457707;
        Thu, 01 Sep 2022 20:30:57 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id w21-20020a634915000000b0042a93b625d4sm325680pga.27.2022.09.01.20.30.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 20:30:57 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v3 5/5] sched/fair: cleanup for SIS_PROP
Date:   Fri,  2 Sep 2022 11:30:32 +0800
Message-Id: <20220902033032.79846-5-wuyun.abel@bytedance.com>
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

The sched-domain of this cpu is only used when SIS_PROP is enabled,
and it should be irrelevant whether the local sd_llc is valid or
not, since all we care about is target sd_llc if !SIS_PROP.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23b020c3d3a0..7bad641faef9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6396,19 +6396,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	struct sched_domain_shared *sd_share;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
-	struct sched_domain *this_sd;
+	struct sched_domain *this_sd = NULL;
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
@@ -6462,7 +6462,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (has_idle_core)
 		set_idle_cores(target, false);
 
-	if (sched_feat(SIS_PROP) && !has_idle_core) {
+	if (sched_feat(SIS_PROP) && this_sd && !has_idle_core) {
 		time = cpu_clock(this) - time;
 
 		/*
-- 
2.31.1

