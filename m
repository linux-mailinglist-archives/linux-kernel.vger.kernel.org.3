Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DED4E3E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiCVMLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbiCVMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:11:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FDA85650
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:10:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q11so15250203pln.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwfN6VcDBeRjK7V61dOwWD2urkXJySgC4BmAO7ZvYbM=;
        b=Z6UWSD/PAs1653AL5+vTkN/dlBXFDOTgqXlQMSnGGGyYMAFx+d/4rMGckEn18A9qOl
         BhD/DlvKFWKZugK5n2yqWtz3cKE+FA2pm5AkQHe80adyXS4c8II+HiBMvRArqxrMC1JK
         7rJWBWyVdCjT447KnmJqMNeI4SO32C0W2ObBI91MHNi2M94CHAsVYDtvpWCmZaVVuESr
         uIQsOlsdWIjgwAzXB8+OtSJeApSqjYqmBmtj1cnCQZ+R5x5XwGbIBJTyehP1vKbP80za
         r1HJMWiiMSqE+kcKFsovPokqFn/WJNdKk1tLgiXrGZ30gEX5xKps2YZEjiVuJT1TfQLv
         EYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwfN6VcDBeRjK7V61dOwWD2urkXJySgC4BmAO7ZvYbM=;
        b=qU05Ib7tbLrV6ZTgByAzsmHc0aaVeGkoFY5sWBrr/Rea8q15sgkNpDfC+61b+T0QZV
         jW1oQgJvYXifivkQjv6iZZzzkH7Z3gM2a8X+Lj09JWLWGzjGki/TWUO1Ui7God2SMJ0V
         C2+wd/aFgU5VGlv1f3H4Bxgx6JlYYAWKZ5F5U9avsviHyc5PYsMYRXvaOkqDjzlyqPoQ
         optFNSRH4gl7LJHYgrlw2k22rww0faJOOFktBv1Co8IbDBgvwXLVnj3JCSpCispdYveO
         AqbH6yv6p6eXAqg2/tloivOD1wO9DIylVFXyidkI+pWSlEFaqnRDMLqlpw3whpkC5EDN
         3NRw==
X-Gm-Message-State: AOAM531KG4ssD9kiLEX6TX2lIVFm1dn+fy1sp4u0T44tDuQfuEmJLX6g
        Q/hN1yJE8VSog23CECWcgXzzeg==
X-Google-Smtp-Source: ABdhPJxHTeehJ7FigPtFgGA/wMvkEgVkxOff44GlHdN9UXiFH4IurvHVl5hUKeYxuPiAR4OmSOzQ6w==
X-Received: by 2002:a17:902:b941:b0:14d:af72:3f23 with SMTP id h1-20020a170902b94100b0014daf723f23mr18182992pls.6.1647951017987;
        Tue, 22 Mar 2022 05:10:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e62:3990:75d0:8573:b73c:e6b4])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm24833850pfj.112.2022.03.22.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:10:17 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 4/6] perf/core: Use stable cpuctx->cgrp when update perf cgroup time
Date:   Tue, 22 Mar 2022 20:08:32 +0800
Message-Id: <20220322120834.98637-5-zhouchengming@bytedance.com>
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

The current code use the changeable task->cgroups when update
the perf cgroup time, which maybe not the active perf_cgroup
that sched_in on the CPU.

This patch change to use the stable cpuctx->cgrp and only
update time when event is matched with cpuctx->cgrp.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e27c06628bad..849a81299906 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -780,7 +780,6 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 static inline void update_cgrp_time_from_event(struct perf_event *event)
 {
 	struct perf_cgroup_info *info;
-	struct perf_cgroup *cgrp;
 
 	/*
 	 * ensure we access cgroup data only when needed and
@@ -789,11 +788,10 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	if (!is_cgroup_event(event))
 		return;
 
-	cgrp = perf_cgroup_from_task(current, event->ctx);
 	/*
-	 * Do not update time when cgroup is not active
+	 * Only update time when event is matched with cpuctx cgrp
 	 */
-	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
+	if (perf_cgroup_match(event)) {
 		info = this_cpu_ptr(event->cgrp->info);
 		__update_cgrp_time(info, perf_clock(), true);
 	}
-- 
2.20.1

