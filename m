Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7544E6CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbiCYDzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352153AbiCYDzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:55:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB7A387AE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:54:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g19so5481670pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggHOE2PxmNXtiInLf6967ShWoItkzb18mMZl8JKes8Y=;
        b=ufLqG0BJBtiwrAE9n5nzk9Ts4LaagK2DBj+a+J6R6A/f+VMKjJOYl/xxQPFjTljx/I
         pF6rbzi5ggn6MkAtE62zeasQBCYvkKGy7xxCE8HMryWK68xdn6sU08OpouD3E0EH2FOI
         4igt/FyZUyEvnrGK/6+6o1FHofyjTC4OhctHJ1f15Drde3pUkuIg0kn1frgcxq2Enbqu
         /Sd3msFHpw8I6YhCHMDovCw4lG55M5r/qHIzlUgl2Yy/+6ps7pQ48TmQHZ8tvQ/07RuD
         DMZvoQP1jAZOkMes7LlMohoJpF00WDNRvPFySwkvhQ/LyNbEjySOkcKjYnN5sWmlmmDu
         0rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggHOE2PxmNXtiInLf6967ShWoItkzb18mMZl8JKes8Y=;
        b=vw1SOEHImpkNfh6DiiCkCaSRjp6HtI7KXri/JKldN3FbOUKUVZLzMsHuZS19XtjwAt
         xoabyeIxSZhYAAatcOsm+W2stI281rODxdzOhlb5+03o78+5d2m0rrfuiF2g3Wqg7qq4
         mmiCF1QEeRwrA1jYncDpLeP3vQ7JWeudhvql8nJqaCqBdVPeupBHsWDoVFTNuftjuSlT
         ddOefxBowbNlVbe+qGthc5JIKCKrY9SZUCFQwoylCQCAUGrqsdyp6SzveGGlUQyEJ7YI
         oBw7JvlYvWv/KfKJm6U2xWCBEI9ZPz3T3EqxTk4BGQuYAMvebtuEWT357JFTnDUJC9i9
         Rm/g==
X-Gm-Message-State: AOAM531Y39w60K61jj3fUkR5g86tZG7c2fR64cDgjFi2rMKfmgtSMEP4
        LNXV2YdUW5iFzJLKB/Tdq3wCgQ==
X-Google-Smtp-Source: ABdhPJxAxMqoQGKyey8iorX7uMSU6WSv8TUeL7QH87mYJFfDXv2QYrkHOcVozid9s8crn4p9ltdpKA==
X-Received: by 2002:a05:6a00:16c7:b0:4f7:e497:69b8 with SMTP id l7-20020a056a0016c700b004f7e49769b8mr8304309pfc.6.1648180449569;
        Thu, 24 Mar 2022 20:54:09 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([2409:8a28:e6a:5860:acb7:c92:7e7f:45ef])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a2b8a00b001c6594e5ddcsm4286504pjd.15.2022.03.24.20.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:54:09 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 2/5] perf/core: Use perf_cgroup_info->active to check if cgroup is active
Date:   Fri, 25 Mar 2022 11:53:15 +0800
Message-Id: <20220325035318.42168-3-zhouchengming@bytedance.com>
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

Since we use perf_cgroup_set_timestamp() to start cgroup time and
set active to 1, then use update_cgrp_time_from_cpuctx() to stop
cgroup time and set active to 0.

We can use info->active directly to check if cgroup is active.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/events/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d50f45012c05..dd985c77bc37 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -780,7 +780,6 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 static inline void update_cgrp_time_from_event(struct perf_event *event)
 {
 	struct perf_cgroup_info *info;
-	struct perf_cgroup *cgrp;
 
 	/*
 	 * ensure we access cgroup data only when needed and
@@ -789,14 +788,12 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	if (!is_cgroup_event(event))
 		return;
 
-	cgrp = perf_cgroup_from_task(current, event->ctx);
+	info = this_cpu_ptr(event->cgrp->info);
 	/*
 	 * Do not update time when cgroup is not active
 	 */
-	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
-		info = this_cpu_ptr(event->cgrp->info);
+	if (info->active)
 		__update_cgrp_time(info, perf_clock(), true);
-	}
 }
 
 static inline void
-- 
2.20.1

