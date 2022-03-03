Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D57A4CBEC6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiCCNUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiCCNUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:20:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A004B188870
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:19:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f8so6563377edf.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 05:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VexrjkXSjl/LTDm+xnGgTi8XTrYcdQ/0U3vjR+rYTQw=;
        b=p1j7mA4YzD3XdeLqxs2B1b8zKL6YZUoDqmFhWdCRW7JWnkJx8j0Em3ciA/IQx2xIJY
         9qNHbVbhQY9JntYcwKWlljR4V0icJQXqcdT+k/QStB+rCraJhMwVOVN6WSBtiLIIhw/B
         ixzTTLJYLnG9+DLq5U1JM5VzzZDsr+LezlGZNnqPce8IRZKgDj7gC2jhRQRusDHXx72X
         0lgBEt7RvCd1mCZkR96nja6+whvhw0UZhT3XlWT4spuFdF6xj9ByDgX8oyD2FDkdNQUV
         cryPmyfLEDZmH/37imjP9KER89/sQMqMN5djWJBV048VXma/IRCovAGirCQSEjk9Gzec
         CZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VexrjkXSjl/LTDm+xnGgTi8XTrYcdQ/0U3vjR+rYTQw=;
        b=IIzHgebHdX2HnmBoKIB/9Eh35As6SAfPk81dv4cDPbUwcr5TBq4TejfpVhuvAsvrlt
         IcnjjReT40T7iaUSmOhalfy9IwOdE2IiWQSauHH81UX+Hl8PRRSKSfsrLKZFZ80LbdfH
         Zc/BvSuN187WE/sFIY/2YAwnxUL2j5HrEs0bF4WyO//GMJydAmiNdaHKIuEqrBJtlV4M
         YZ9Rs9XxAjHSrH0a7kutRYfzyyfLAiwMFO9QuA4Fhep8io4fHUbb/HDpf7Tz2oZm33a4
         pVHWHe4uZ+xBPw/744MAOg+Yj6QeC53G9cUexPtNxsOp+lv+j35ZwOxkeJwrPnr4QbDn
         NjGA==
X-Gm-Message-State: AOAM532EwNebquUVN504jwTI7ilJIK3lEJqNgpLddruS1XIezJRtLo8P
        y2uQnmtaedcUoWXvyeIexAo=
X-Google-Smtp-Source: ABdhPJzhH7vWeEc4jjV/03JS2MkMl9gdUKGbS+srAF1Wvec5Pz5Fdy5CpNjvMtU/YGx1IpeyZxWPkw==
X-Received: by 2002:a05:6402:34cb:b0:415:b974:ec5c with SMTP id w11-20020a05640234cb00b00415b974ec5cmr8031561edc.329.1646313592647;
        Thu, 03 Mar 2022 05:19:52 -0800 (PST)
Received: from tsf-452-wpa-4-117.epfl.ch (tsf-452-wpa-4-117.epfl.ch. [128.179.156.117])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906261800b006da94c9ccc9sm481323ejc.129.2022.03.03.05.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 05:19:52 -0800 (PST)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, christian@brauner.io,
        linux-kernel@vger.kernel.org
Cc:     Chun-Hung Tseng <henrybear327@gmail.com>
Subject: [PATCH v3] sched: Simplify __sched_init runtime checks
Date:   Thu,  3 Mar 2022 14:19:42 +0100
Message-Id: <20220303131942.12030-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve runtime checks in __sched_init(void) by replacing if conditional
checks with preprocessor directives.

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 kernel/sched/core.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9745613d531c..003e8677f6ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9317,28 +9317,29 @@ void __init sched_init(void)
 #ifdef CONFIG_RT_GROUP_SCHED
 	ptr += 2 * nr_cpu_ids * sizeof(void **);
 #endif
-	if (ptr) {
-		ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
+
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
+	ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-		root_task_group.se = (struct sched_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.se = (struct sched_entity **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-		root_task_group.cfs_rq = (struct cfs_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.cfs_rq = (struct cfs_rq **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
-		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
-		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
+	root_task_group.shares = ROOT_TASK_GROUP_LOAD;
+	init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
-		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
-
-		root_task_group.rt_rq = (struct rt_rq **)ptr;
-		ptr += nr_cpu_ids * sizeof(void **);
+	root_task_group.rt_se = (struct sched_rt_entity **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 
+	root_task_group.rt_rq = (struct rt_rq **)ptr;
+	ptr += nr_cpu_ids * sizeof(void **);
 #endif /* CONFIG_RT_GROUP_SCHED */
-	}
+#endif /* CONFIG_FAIR_GROUP_SCHED || CONFIG_RT_GROUP_SCHED */
+
 #ifdef CONFIG_CPUMASK_OFFSTACK
 	for_each_possible_cpu(i) {
 		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
-- 
2.35.1

