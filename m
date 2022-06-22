Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9655512F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376458AbiFVQUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357785AbiFVQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:20:40 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1236E37A9D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:20:40 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so184396pjr.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wcDPvndHpZwzaPAKNa743EbgoViASHqnapNbBWYR/9k=;
        b=csPMrLwI6U+ESXaBv4BSD2rScCHaL4zOOIyux+wt9fL7gM98rwa8H2JoqNDq7hAz1O
         Mab2KzOjW+1BMT9uwWMJjQG6vvfaY3HMCFGEoOpIULgMa8H72fKDPmY2WkvQD84T0N7v
         16EY+LdjZLIO3nFCFDUxp04bKU+Alh+IYQ/UacZBkv/jamIlIhiZDUPVBFrRxGYMtgjM
         2OcS5aqYpNZq2/tt20xw26b8XEKkysMFM3P0PPzjgkHzy/IN5w/QUxgOxGXrk4CcnZEf
         HFIZOrAX+szhg7n+fpertrirO4OGU629e+nAQhF7ltAxixOpRTsdprzsmpcccZ2wEMTA
         5KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wcDPvndHpZwzaPAKNa743EbgoViASHqnapNbBWYR/9k=;
        b=29wUncvfMihT15jAHB/tvWAzQ5qVInYUaWqb5zQreTexz4S1+JWypRVdJQcxyr4SHW
         9pNGexKrdFKoaaBWvKNIw89uR0xUZul85oqhmiTr5xo6QMozxTjl2S/Ci6YeWg7vFH8F
         iyeTs3gtxj5vNERFIeheDCdtPxanJrplxbJmrF/AyIqO/n0gZ7OmxLj2BEH3M2i6F7m3
         E4VG7XMm/8K593ebsMKD0Vf+/Ltlc6P+2hloDV1kH3qh0toMWSfY96Ck+Ycy0r0S4g3D
         lVH2lbt4/kfUlLMMrnRZoqOiZFTBS6kcDVGCo+6ckaxq8Vzi9urOLi7qdwjD3POt1wzK
         jQTQ==
X-Gm-Message-State: AJIora+gGqMwDpOXwo7Af8okPryjQ28PXFQb98+hZjZlwAR7YT5wPeZw
        djMQ9q/w27tKdVRxSen0NAU=
X-Google-Smtp-Source: AGRyM1u2OsiXYxx5H24pRVBYhOMFTG7PMvpVaXqFTxs/q71oMTMkZWFjch0Ct03MW/IecVzOtVo3eQ==
X-Received: by 2002:a17:902:ce87:b0:16a:3db5:593d with SMTP id f7-20020a170902ce8700b0016a3db5593dmr7715632plg.153.1655914839636;
        Wed, 22 Jun 2022 09:20:39 -0700 (PDT)
Received: from pc ([103.142.140.127])
        by smtp.gmail.com with ESMTPSA id u1-20020a170903124100b00163f8ddf160sm12918318plh.161.2022.06.22.09.20.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jun 2022 09:20:39 -0700 (PDT)
Date:   Thu, 23 Jun 2022 00:20:30 +0800
From:   Zhaoyu Liu <zackary.liu.pro@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/pelt: rename init_entity_runnable_average()
Message-ID: <20220622162025.GA12196@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 0dacee1bfa70 ("sched/pelt: Remove unused runnable load average"),
sa->runnable_load_avg was deleted from init_entity_runnable_average(),
and now it only init sa->load_avg inside of the function,
so rename the function to init_entity_load_average() is more appropriate.

Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
---
 kernel/sched/core.c  | 3 +--
 kernel/sched/fair.c  | 6 +++---
 kernel/sched/sched.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 263d76489a48..224ca514e9d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4580,8 +4580,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	else
 		p->sched_class = &fair_sched_class;
 
-	init_entity_runnable_average(&p->se);
-
+	init_entity_load_average(&p->se);
 
 #ifdef CONFIG_SCHED_INFO
 	if (likely(sched_info_on()))
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ed32f66bbd3d..6bc7eaf88c59 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -784,7 +784,7 @@ static unsigned long task_h_load(struct task_struct *p);
 static unsigned long capacity_of(int cpu);
 
 /* Give new sched_entity start runnable values to heavy its load in infant time */
-void init_entity_runnable_average(struct sched_entity *se)
+void init_entity_load_average(struct sched_entity *se)
 {
 	struct sched_avg *sa = &se->avg;
 
@@ -871,7 +871,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 }
 
 #else /* !CONFIG_SMP */
-void init_entity_runnable_average(struct sched_entity *se)
+void init_entity_load_average(struct sched_entity *se)
 {
 }
 void post_init_entity_util_avg(struct task_struct *p)
@@ -11510,7 +11510,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
-		init_entity_runnable_average(se);
+		init_entity_load_average(se);
 	}
 
 	return 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5b14b6b4495d..349b423ea8a6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2330,7 +2330,7 @@ extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
 #define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
 unsigned long to_ratio(u64 period, u64 runtime);
 
-extern void init_entity_runnable_average(struct sched_entity *se);
+extern void init_entity_load_average(struct sched_entity *se);
 extern void post_init_entity_util_avg(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_FULL
-- 
2.17.1

