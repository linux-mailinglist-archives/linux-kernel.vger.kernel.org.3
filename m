Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A854E3E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiCVMMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiCVMME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:12:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A1F85659
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:10:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e6so12473009pgn.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uePDHamTg8Aaje9cV7GXZKI4UAeGuCXRnl2ENUUEXxk=;
        b=FsRTO4RlcjR5SvPCtQOCwI3kpAD3W7w49KGuO99dqINQ6uOWZ5gOIMsgNsI6jxy9Uz
         QSCMtlPoMeim6YGW8OkevyocYuF/DBt28S6HI1X+CAidRFCDU9fJZc/XNpuAAXEslwpm
         MD1wTijilB06RSk200EmVDcbKzgWhOF3W3kILccXJCG46DTFvKTbFTHYC4tgb/ONeh/h
         G0l+INhk24k4SzX4HTlxzbuqMok45TzQGdon9rrL6losB9H0wWpTEArGsFSqIKO3OuWb
         UxSgpXULxwsvVnj0i/ff5ZkKHE9EpnJbUO+MjLpDReoR0eUp6kCZJjB9EBleJC/iiR6z
         zm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uePDHamTg8Aaje9cV7GXZKI4UAeGuCXRnl2ENUUEXxk=;
        b=xLSKS4vbcThOk6hNwNZimYIPKL/VYgCmznvKHHJ/+TM9zeMdC0A2UXOuf8Dm7BSkI1
         r5brJSbl5DKRaKM6heu9uNNW76OA4OiGrZjcuZlbd6h9m1DphkJV4HOLA/baHbUtVVW4
         XsTAupf3ZlNR38nHE8J2ka4bhCjQxRdk/PbVtfsox2pzW/fjGz1EaALrKAxKLbRleBp+
         WurkdrZ8hxJQi2pwqSr13RxEF682wQGLEJyeaQK10McFd2YwndgsTpgaSo2kd0zw/lTP
         OZfwrDYppzGjS39YQUThLyPLur14B8qxr6u/hz+I8Y6uB7XNO+UQP2Nv4kUTK1UTQSKb
         oCcQ==
X-Gm-Message-State: AOAM532TazW103CIooqDPovFISIoIQhM1cWSzcNHqV+txDZog01XRK6r
        8tXcC0fYQBDiVuUvhJC2Hb//et3FHpXRS63S
X-Google-Smtp-Source: ABdhPJzdsnGKnRy+ZLFU+RCMb/c6l9MPuXmGqraFSCQJyAYNskxfSG2QUnuOF5/VdE382cVcf+ByYQ==
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id p15-20020a056a0026cf00b004f6fc527b6amr28841152pfw.39.1647951026185;
        Tue, 22 Mar 2022 05:10:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e62:3990:75d0:8573:b73c:e6b4])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm24833850pfj.112.2022.03.22.05.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:10:25 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 5/6] perf/core: Always set cpuctx cgrp when enable cgroup event
Date:   Tue, 22 Mar 2022 20:08:33 +0800
Message-Id: <20220322120834.98637-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322120834.98637-1-zhouchengming@bytedance.com>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable a cgroup event, cpuctx->cgrp setting is conditional
on the current task cgrp matching the event's cgroup, so have to
do it for every new event. It brings complexity but no advantage.

To keep it simple, this patch would always set cpuctx->cgrp
when enable the first cgroup event, and reset to NULL when disable
the last cgroup event.

In this way, perf_cgroup_match() won't see cpuctx->cgrp == NULL if
it's a cgroup event, so add a WARN_ON_ONCE(!cpuctx->cgrp) there.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 849a81299906..4c8657b08301 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -703,7 +703,7 @@ perf_cgroup_match(struct perf_event *event)
 		return true;
 
 	/* wants specific cgroup scope but @cpuctx isn't associated with any */
-	if (!cpuctx->cgrp)
+	if (WARN_ON_ONCE(!cpuctx->cgrp))
 		return false;
 
 	/*
@@ -975,22 +975,10 @@ perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ct
 	 */
 	cpuctx = container_of(ctx, struct perf_cpu_context, ctx);
 
-	/*
-	 * Since setting cpuctx->cgrp is conditional on the current @cgrp
-	 * matching the event's cgroup, we must do this for every new event,
-	 * because if the first would mismatch, the second would not try again
-	 * and we would leave cpuctx->cgrp unset.
-	 */
-	if (ctx->is_active && !cpuctx->cgrp) {
-		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
-
-		if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
-			cpuctx->cgrp = cgrp;
-	}
-
 	if (ctx->nr_cgroups++)
 		return;
 
+	cpuctx->cgrp = perf_cgroup_from_task(current, ctx);
 	list_add(&cpuctx->cgrp_cpuctx_entry,
 			per_cpu_ptr(&cgrp_cpuctx_list, event->cpu));
 }
@@ -1012,9 +1000,7 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
 	if (--ctx->nr_cgroups)
 		return;
 
-	if (ctx->is_active && cpuctx->cgrp)
-		cpuctx->cgrp = NULL;
-
+	cpuctx->cgrp = NULL;
 	list_del(&cpuctx->cgrp_cpuctx_entry);
 
 	if (list_empty(per_cpu_ptr(&cgrp_cpuctx_list, event->cpu)))
-- 
2.20.1

