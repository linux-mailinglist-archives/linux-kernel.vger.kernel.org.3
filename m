Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856EB4E6CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbiCYD4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356709AbiCYD4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:56:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB13ED0B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:54:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s11so5467164pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOjaONZKMKdSsuIYVocxhHlKftggb493wbtIiiPtVs0=;
        b=neNoe4SioYRiOAfumI2Qi6ZhxWfffkqMOShngq9XvSSMjo2sp4G17lYNkJXA1KtSYx
         Rb1KhAw8FXGu4Nno8BugqdMKDAxma23HIiMojIq8Ex3CSJ59l4JhpJeEmKAed3X5zcDO
         hJn+ZQ/qiOigxtZykRAKzOdTsjhhwP1G3lY+HdXIqHIcXxnpLv+ozSdXC1C8cj6r0QmH
         6zjn8mb1IoT1icbos6NbDdabmN7tSK0u4NMIzPQuLw3fpjkUr42p4QfVqVtGuKrvtr6P
         hBNh8LpM8f+WCk2nD3kHd+KhTIo482bAzzpw/n5Rmt6IpYMsE3sOflgu6wlBPQ0qj+zi
         y82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOjaONZKMKdSsuIYVocxhHlKftggb493wbtIiiPtVs0=;
        b=FPFu7AWHxaDIMPmxFxFE22R/Y9mlg/bfY7SsnLaCQ2hL/OfMgCgpRuPaCY31iPNiO4
         5yXX0OFBnG56e6kNLXBl4RCwQW9KX8xJh/Vl8sbXnAzx+gwKYQAVr926GWTALDKlvvUd
         0SQ1uJ6yISswqf6RQ/ikvo00mALU4CITu/znIEbxsG+c8hlq42vySuax2+Bp5uvpc353
         abJn4atI3TJzcLG/H5q93oF7dq1ckf3i+1pqhQmDi3UkzL04vyfIUu3N6XlfCcWk5kwu
         zcetBt+6555Lfx4uUw8to46vLJ/ahdRuBSdk2vniGenu1/JJbBoBZxA9unHiaU+G024e
         0fdw==
X-Gm-Message-State: AOAM531B5bPSVaV5A9XkK/TEG7DSjYhk12yEiEun91l9i2sUbutQkPzA
        yy7nuK1za9PYe8jRUXhZQmyNsw==
X-Google-Smtp-Source: ABdhPJzgnlXnTMAAP50rmjk1RpE7Pq+oO0/kB529+we11ivjrAxlbhS4IWrReGZpq+lU0mKL4MF3Jg==
X-Received: by 2002:aa7:8385:0:b0:4f6:ef47:e943 with SMTP id u5-20020aa78385000000b004f6ef47e943mr8184087pfm.38.1648180469209;
        Thu, 24 Mar 2022 20:54:29 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([2409:8a28:e6a:5860:acb7:c92:7e7f:45ef])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm4286504pjd.15.2022.03.24.20.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:54:28 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 5/5] perf/core: Always set cpuctx cgrp when enable cgroup event
Date:   Fri, 25 Mar 2022 11:53:18 +0800
Message-Id: <20220325035318.42168-6-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325035318.42168-1-zhouchengming@bytedance.com>
References: <20220325035318.42168-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d559fbbd3aaa..ccd4dfdf4810 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -967,22 +967,10 @@ perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ct
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
@@ -1004,9 +992,7 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
 	if (--ctx->nr_cgroups)
 		return;
 
-	if (ctx->is_active && cpuctx->cgrp)
-		cpuctx->cgrp = NULL;
-
+	cpuctx->cgrp = NULL;
 	list_del(&cpuctx->cgrp_cpuctx_entry);
 }
 
-- 
2.20.1

