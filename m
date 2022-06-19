Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29822550A84
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiFSMF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiFSMF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:05:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA0910551
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g186so7929287pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AFiOc0qT9nY4P1lJdZHcAAnjQucKyflb1VsEGjpojT0=;
        b=MNBsSX5uJu5EXM1N0sMkS3XqvxM1A+QezQco0Bp+/8VCPwnwHG0Bt/Ijz6fh2NXQV6
         EMHM/3ZvZqKzy0ZBfc7MedV4FNpQR+ue3JMdMrGefse4ELyAnI2mUfKtKww7NLHOJWVD
         dglly4WS3C8KaLecqahfNfd4ialdu4RdZyXrjN6uLsW/YdgGDldRko+1dN6Fv90D0AbY
         58lp/0vF8JvRByB1EprK0AoaAbPBauU1Jfr8fj95mPddwV1ez3cIOnYpa9i7f9kHkNjd
         95W+bFxbSRifvdeFrWwm0l+l+XQNS8YXIj3IOr2Kn1KTIR1MuiDEUqxTEBpy+m7j8RuG
         1sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AFiOc0qT9nY4P1lJdZHcAAnjQucKyflb1VsEGjpojT0=;
        b=qmoJ8uNxSL9bp5LsftyyN3vW6teaT65Gb9TtIamMAg2dayLRjqxsMdzCpQGQ0heCmh
         x7vdqJAfPiDgIF47aELp+eyjdyWQkNtY0sYIWlOx1ZNy135mYnh3K4MHt0+CGY6pCGlv
         jrXaVKBUQgwDjW7c3gXeLujnDUPhuKv9AUet72s3DlQvsOWIKBlvXVZxReic+khfom62
         BmOURfurZsVXqRa59AyetiGeObEe/puEMcHXm3qiorEtTaq+hGCO0L49XsTJ394z5N1K
         P2XDvn8Kijez2FF8lHiVQ76xYIerfdoOLmQN0uRGKL6rZqgCVdKoCbZ8JU91oPl8PELv
         fdHw==
X-Gm-Message-State: AJIora+I1B6SEVth6T1RBykOIdvQQ8VuZMK1Gun4guTLoH1ZVM7Wm6l8
        DyLxwFt28PvdbJ9Apqc1IG+hQQ==
X-Google-Smtp-Source: AGRyM1ukfLlAMHn6m0lHlyMr8YTjtx6f+zCFrPDBT5KV7AK3D+yzbA8Dl3uOhrIeSgrXVOLK8RgJpg==
X-Received: by 2002:a63:5906:0:b0:401:9ade:d138 with SMTP id n6-20020a635906000000b004019aded138mr17120462pgb.520.1655640322948;
        Sun, 19 Jun 2022 05:05:22 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb1d5sm1594038plb.31.2022.06.19.05.05.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:05:22 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 1/7] sched/fair: default to false in test_idle_cores
Date:   Sun, 19 Jun 2022 20:04:45 +0800
Message-Id: <20220619120451.95251-2-wuyun.abel@bytedance.com>
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

It's uncertain whether idle cores exist or not if shared sched-domains
are not ready, so returning "no idle cores" usually makes sense.

While __update_idle_core() is an exception, it checks status of this
core and set to shared sched-domain if necessary. So the whole logic
depends on the existence of shared domain, and can bail out early if
it isn't available. Modern compilers seems capable of handling such
cases, so remove the tricky self-defined default return value.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8bed75757e65..e5e8453e3ffb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1595,11 +1595,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
 
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
@@ -6206,7 +6206,7 @@ static inline void set_idle_cores(int cpu, int val)
 		WRITE_ONCE(sds->has_idle_cores, val);
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline bool test_idle_cores(int cpu)
 {
 	struct sched_domain_shared *sds;
 
@@ -6214,7 +6214,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 	if (sds)
 		return READ_ONCE(sds->has_idle_cores);
 
-	return def;
+	return false;
 }
 
 /*
@@ -6230,7 +6230,7 @@ void __update_idle_core(struct rq *rq)
 	int cpu;
 
 	rcu_read_lock();
-	if (test_idle_cores(core, true))
+	if (test_idle_cores(core))
 		goto unlock;
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
@@ -6306,9 +6306,9 @@ static inline void set_idle_cores(int cpu, int val)
 {
 }
 
-static inline bool test_idle_cores(int cpu, bool def)
+static inline bool test_idle_cores(int cpu)
 {
-	return def;
+	return false;
 }
 
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
@@ -6535,7 +6535,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return target;
 
 	if (sched_smt_active()) {
-		has_idle_core = test_idle_cores(target, false);
+		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
 			i = select_idle_smt(p, sd, prev);
-- 
2.31.1

