Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CFD4EB0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiC2PsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbiC2Pr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:47:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A03A727
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:46:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y16so5123750pju.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rhwh9jxyPwcfCpsQO0KCczugdPBmMe7ki4JPplrKdX0=;
        b=1ZOjuYVV7IS49mm+29IIWCx9Kgw806xN7HcEro53PMxH+61SjdUcSsXzGPUYBBEH88
         uwKJaOwzbkvmfD6JHHJo/DrDfG7P1GwtqU9KbajcVCiZBlnrjlcspNGkc30DBibvKO0a
         WzNULbGBUuWwjO8xuVOTcMfY1exC724DLjk4ZtC3nNeV7FSLgKLprzgTrGQrDoABGLeH
         Gwq9ad9A6tDfoGOobXdgBJyW4FaOySqhkOSHUWmiUdatAzSGW0fWmqF5RIy7zn52Gjkh
         GDMB70CeSy9CZzN37x+re8L/OOI4ghmWSNrFRkdk28aZLVcUjiOiGm/GYi7hEpYn9L2y
         GiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rhwh9jxyPwcfCpsQO0KCczugdPBmMe7ki4JPplrKdX0=;
        b=zAgBW2uwLroB+5YgSg0F1/WU+JAbcByNprOjyidWZ7X+u6zIRgb+IHmZsvQt5LSU8l
         SSzJ2fyFIL5ufJmtCNkzjxYM9w779c4iK2VyLcR18F2EOiJNYvsewlFiVsz/mOu1sEjI
         /wqZ3AcvohCDHZwVivWdo0YVnCiCcbI04a+JaEgRKWNIBruBG+8KkQlpn9Ra9ADX4NtU
         5bi5dwb9O4aBvU85rvEiA/074Cxc8FNqSB1HSAAqjvYG5n7UQg3geo/OXiif4hw721hI
         aEAr3NOXnaOVk9rCk2VlMHMLumWJ5LhCgL+24jJyUpFkDQMv6u8LvScG7QFUQT1K8NNa
         EOgg==
X-Gm-Message-State: AOAM532GhMnkG2CW8FNt8jfpA5nHw8klAlTNGrxLE4jeateYfiLsFWmt
        JHpB+pg6ktKjtM84E490DtdnQiVd3Lh4bw==
X-Google-Smtp-Source: ABdhPJxI2f60H+9yDfbq7bCXzPA5q5GFVR35gKrDEchQo7UVAUEKkvLhORP9cHiUPxiVJ/8hzds0VA==
X-Received: by 2002:a17:902:f70a:b0:153:88c7:774 with SMTP id h10-20020a170902f70a00b0015388c70774mr31141798plo.166.1648568772925;
        Tue, 29 Mar 2022 08:46:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e65:74c0:705b:241a:6dc0:a4ac])
        by smtp.gmail.com with ESMTPSA id u19-20020a056a00125300b004fafa43330csm17930733pfi.163.2022.03.29.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:46:12 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 4/4] perf/core: Always set cpuctx cgrp when enable cgroup event
Date:   Tue, 29 Mar 2022 23:45:23 +0800
Message-Id: <20220329154523.86438-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329154523.86438-1-zhouchengming@bytedance.com>
References: <20220329154523.86438-1-zhouchengming@bytedance.com>
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

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 782b9f5e3fc7..a1f6f0a54ef7 100644
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
2.35.1

