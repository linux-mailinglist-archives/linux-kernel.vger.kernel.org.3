Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F35598375
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbiHRMtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244779AbiHRMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:48:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F361B03
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 73so1209625pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=x8m79S6XeJzWHPW0WBhOsEVwccQlVpjElOwJhSo8zB4=;
        b=fr8Ic8NDO7wYMDMtiNtNOwQod6dsA/mmJOips3BsLPIkrev8e8LuBfMHNK4gBd/UU5
         p6JniRKTbR0W6PKNZKcP7ZdjO2VL0WlRdM6HOz2qo0U52JB0jN46Rr27LsD61OTTPdcv
         A/7wz9y+HbgUbZLUBo+S4je0VEjKNMtA9VH92HkIybE3yUsrCXQOtDSPLEcBcZaMZLKT
         oBkbQZIl3pxoM7+Dd2b0TxCRsnaHybSYeyw6dCS2H57IkfBIxv5RBdo8VR+YuL3vcNYv
         ThJKuTXBXSp5UDWEm/lN1LWHfbYgdUc5QXl8/3Qo3oIRoy5oksIkuVHisvxgRZa+yH39
         bhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=x8m79S6XeJzWHPW0WBhOsEVwccQlVpjElOwJhSo8zB4=;
        b=Tnv6Vn2g5BC5+F9ZMncKYly0bvnA6n8JatCbaPek0csHk1ej9SzLAjl56xfyb5Yt24
         c25TieAR1N5f3Gb7itzyOGIU/rx6zTrQ1iiUBm8BCYdt/yOSsP/wd80AIKwlnEazoa0k
         Ul9KGWBinNmGilFAJ6pF4Tglxvlgdl4yyfCA184grQ8kAiUAH4hHl2ngJHZNdLYzlpp8
         Q20uScpCLSeUcE8hLM4Q8uMSzl488J8awbAwD/Ie7g5toRruyJIcmgm1PxkV227gdpkM
         O9xPuiqrby65yhAUJmbTC7/k3aFWPoXOazlMNYxEDGCBBpKcYnjc8KqgX26FwzJ7++5T
         8OXA==
X-Gm-Message-State: ACgBeo036cVeBzttdk/QAyN0n9GjsPTzY2gzOVn7a7CIfpxlE2kT/iUe
        lMl+me5yhEwifG3f8xicEb5HjQ==
X-Google-Smtp-Source: AA6agR7hTf8zbLhVeq3bm60Xuw1nM5ewTOoZMgs6/QACQptaUXmvQ42OV07WKVBW/5e0lyDKGvvhRg==
X-Received: by 2002:a63:6909:0:b0:41c:9f4f:a63c with SMTP id e9-20020a636909000000b0041c9f4fa63cmr2441531pgc.76.1660826937103;
        Thu, 18 Aug 2022 05:48:57 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c16-20020a621c10000000b0052f3a7bc29fsm1477449pfc.202.2022.08.18.05.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:48:56 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 9/9] sched/fair: don't init util/runnable_avg for !fair task
Date:   Thu, 18 Aug 2022 20:48:05 +0800
Message-Id: <20220818124805.601-10-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818124805.601-1-zhouchengming@bytedance.com>
References: <20220818124805.601-1-zhouchengming@bytedance.com>
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

post_init_entity_util_avg() init task util_avg according to the cpu util_avg
at the time of fork, which will decay when switched_to_fair() some time later,
we'd better to not set them at all in the case of !fair task.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 93d7c7b110dd..621bd19e10ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -833,20 +833,6 @@ void post_init_entity_util_avg(struct task_struct *p)
 	long cpu_scale = arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)));
 	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
 
-	if (cap > 0) {
-		if (cfs_rq->avg.util_avg != 0) {
-			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
-			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
-
-			if (sa->util_avg > cap)
-				sa->util_avg = cap;
-		} else {
-			sa->util_avg = cap;
-		}
-	}
-
-	sa->runnable_avg = sa->util_avg;
-
 	if (p->sched_class != &fair_sched_class) {
 		/*
 		 * For !fair tasks do:
@@ -861,6 +847,20 @@ void post_init_entity_util_avg(struct task_struct *p)
 		se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
 		return;
 	}
+
+	if (cap > 0) {
+		if (cfs_rq->avg.util_avg != 0) {
+			sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
+			sa->util_avg /= (cfs_rq->avg.load_avg + 1);
+
+			if (sa->util_avg > cap)
+				sa->util_avg = cap;
+		} else {
+			sa->util_avg = cap;
+		}
+	}
+
+	sa->runnable_avg = sa->util_avg;
 }
 
 #else /* !CONFIG_SMP */
-- 
2.37.2

