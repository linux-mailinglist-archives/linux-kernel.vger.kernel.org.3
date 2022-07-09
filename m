Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0172F56CA4D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiGIPQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGIPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:16:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C84B0D1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:16:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso3373373pjz.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yPtdrMhL5e8yh6wH/g86ZHF3r4Sj0ggBH1KhtHH5s8Q=;
        b=0Crk7rfhRGCx2d3NnQRlVIi4woe+EWOtrw7RgmOCkVqTHLyEpy7cyczQK29QH+a4UU
         JB0YqXANjbrzaOUaa96mO1tq8XFn0kSWcXt6vCLrcj5tsO9sb0lm3yjphZDBM0HOJkIy
         h6ZoXwe3y3ukuCT2yPj/7WGaE7s2qFUb4r70GftFIWar7VzvEdgkZkFtryFO7E0gLEli
         svG2s/FIniLUnUHvLUKREH7yPZWHwH+8g+pXSSkk3el2Nl5l8iMh03PjucUhdKlhGif0
         PJi+efrdw4HbhFtCkX1E807XazkQjFQEUJhxJkSwIhY5f0sf/e7CtYqSlEXv64/9MPgm
         5IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPtdrMhL5e8yh6wH/g86ZHF3r4Sj0ggBH1KhtHH5s8Q=;
        b=SlMI0euQKDZOCL0hdAHZAkISBkg2TlPCD4AXh0YQmtv5ncypNypkDQJxeDuL0WYnor
         G3jvGaZK8und+jbQzD86D/UVWefgGVPy8aUOGdigtsJdsJEsYQ3RgFC53iP8HSPYpc0N
         kT7HYsa3i/ZYBDF0xJzGfP+HmtrFYhgeaedoQaiHNQTUMElZvomwy/U36quNrEkz9WSO
         LFx75Sk32XyAYVOZJYQwxXMzvAUeZ5+eJ05Tfa3pGG0uSELwgcXHuTYBQg62h4hVv6Se
         z89CiRqybIr8PKdn8vGhFxp2Uift1pFC/93LFuhGnyp/XJeezyKIz9/j6IrFJ97x9DLt
         uhDg==
X-Gm-Message-State: AJIora/UGXl2FGy+sSiD3Ajk86QKltUKEm1H3xIoTosvVPNcOUuJshOr
        Fd892AQW4rVdLxAllNkuncg5VQ==
X-Google-Smtp-Source: AGRyM1s7U2bjc1ROQ8IyMcYSiCufXK2IdtF1kQWhrxSohH0mrD+A1ln1h0XWzrPPDY0+EFbWU4905Q==
X-Received: by 2002:a17:90b:30c4:b0:1ef:8d1b:f9bf with SMTP id hi4-20020a17090b30c400b001ef8d1bf9bfmr6570623pjb.158.1657379759931;
        Sat, 09 Jul 2022 08:15:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:e730:5493:aabd:e56d:65e6])
        by smtp.gmail.com with ESMTPSA id bo20-20020a17090b091400b001ef8d2f72fesm1295709pjb.45.2022.07.09.08.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:15:59 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 8/8] sched/fair: delete superfluous SKIP_AGE_LOAD
Date:   Sat,  9 Jul 2022 23:13:53 +0800
Message-Id: <20220709151353.32883-9-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709151353.32883-1-zhouchengming@bytedance.com>
References: <20220709151353.32883-1-zhouchengming@bytedance.com>
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

All three attach_entity_cfs_rq() types:

1. task migrate CPU
2. task migrate cgroup
3. task switched to fair

have its sched_avg last_update_time reset to 0 when
attach_entity_cfs_rq() -> update_load_avg(), so it makes
no difference whether SKIP_AGE_LOAD is set or not.

This patch delete the superfluous SKIP_AGE_LOAD, and the unused
feature ATTACH_AGE_LOAD together.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c     | 18 ++++++------------
 kernel/sched/features.h |  1 -
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b0bde895ba96..b91643a2143e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3956,9 +3956,8 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
  * Optional action to be done while updating the load average
  */
 #define UPDATE_TG	0x1
-#define SKIP_AGE_LOAD	0x2
-#define DO_ATTACH	0x4
-#define DO_DETACH	0x8
+#define DO_ATTACH	0x2
+#define DO_DETACH	0x4
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -3970,7 +3969,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	 * Track task load average for carrying it to new CPU after migrated, and
 	 * track group sched_entity load average for task_h_load calc in migration
 	 */
-	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
+	if (se->avg.last_update_time)
 		__update_load_avg_se(now, cfs_rq, se);
 
 	decayed  = update_cfs_rq_load_avg(now, cfs_rq);
@@ -4253,7 +4252,6 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 }
 
 #define UPDATE_TG	0x0
-#define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
 #define DO_DETACH	0x0
 
@@ -11484,9 +11482,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	/* Catch up with the cfs_rq and remove our load when we leave */
-	update_load_avg(cfs_rq, se, 0);
-	detach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq);
+	update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);
 	propagate_entity_cfs_rq(se);
 }
 
@@ -11494,10 +11490,8 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	/* Synchronize entity with its cfs_rq */
-	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
-	attach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq);
+	/* Synchronize entity with its cfs_rq and attach our load */
+	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	propagate_entity_cfs_rq(se);
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..fb92431d496f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -85,7 +85,6 @@ SCHED_FEAT(RT_PUSH_IPI, true)
 
 SCHED_FEAT(RT_RUNTIME_SHARE, false)
 SCHED_FEAT(LB_MIN, false)
-SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
 SCHED_FEAT(WA_IDLE, true)
 SCHED_FEAT(WA_WEIGHT, true)
-- 
2.36.1

