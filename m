Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543C85B02C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIGLU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiIGLUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:20:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB986B4B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:20:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id iw17so7544405plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aDniB8hJUxb/LoNqhQjiZRSUOVFgsRjJ2v0euL0XhpM=;
        b=B3KZs+fMUKHDSVYXzQBLMPYQfcMKpZy2VsEdFjggSkPKS6mg2CCks+Dt4+HJSB9jjo
         WnRiObuTk+sC3U4oZnwbSO6nEQKZlZFgOZaukkn4rS+GHjiyvJ2JFE9+MnavIMYZ58rf
         3OtB8mWnNWmTog7QWeuNMoh21hIPwRpW4FAgkghVj+1iq2MDXZ7d5N2Vo03v24W3ekbj
         5dac+ZvUxCkRVoZTDSpbJr8eBQaCESm5pBDP6ND695M68rVVsPnBT3Hdmt8JYE+vInS3
         8q7z1O02qGn3AhPPl/XAVntVSc+ECNLOUuyDGE6HzHKgNgP0KQkvidXbyA3K8vFZiMpS
         cc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aDniB8hJUxb/LoNqhQjiZRSUOVFgsRjJ2v0euL0XhpM=;
        b=AlZP20fZyrC85Obkeg+1DVrQZ/hkIScnGiBIWg2+XHT6rk2nDm7ipsFkRm42vZfBWG
         lbt7md+pA4AmFEhD8s+H/QuZZRC393B4y5iCkHpskax2g5oqOtn6HlqPmbIJ0p0I3JSy
         SUgn6DEdlmmlVymHVdMoUVLBgn6sfuHgnqMgsUcTS+W4BircBWFrNsh78YwYtmOANVA5
         SwgTFt+pIURsb8+/7T+urtnotw59a0swN0xA5+Z44lsnHmSk/x0Ej1mOxU0yQqzcqn4q
         k2Kz54F9bin+6oameU4Tz/1dCHoZD09TpzJExj6OL6IrxNtEVCPoBqdN4552/NUoA5mz
         Payg==
X-Gm-Message-State: ACgBeo3VYtpjZz617uzbG6pu6FFxQA4aphBvmUbCa2//MEz71pvlYNhr
        HDtLMPgnnofzVZwOoNHfsbyHRQ==
X-Google-Smtp-Source: AA6agR5C7KOVsKCuIqYGN5BWgkxBIsdBaOWkm0jQu98JwoSuyDpfaPmU/9X6BS3Lnd5CFo1KYYcStg==
X-Received: by 2002:a17:903:22cf:b0:174:a5cd:31e0 with SMTP id y15-20020a17090322cf00b00174a5cd31e0mr3285343plg.23.1662549637312;
        Wed, 07 Sep 2022 04:20:37 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d12-20020a63f24c000000b0042ba0a822cbsm10334731pgk.8.2022.09.07.04.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:20:37 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 5/5] sched/fair: Cleanup for SIS_PROP
Date:   Wed,  7 Sep 2022 19:20:00 +0800
Message-Id: <20220907112000.1854-6-wuyun.abel@bytedance.com>
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

The sched-domain of this cpu is only used for some heuristics when
SIS_PROP is enabled, and it should be irrelevant whether the local
sd_llc is valid or not, since all we care about is target sd_llc
if !SIS_PROP.

Access the local domain only when there is a need.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Acked-by: Mel Gorman <mgorman@suse.de>
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
2.37.3

