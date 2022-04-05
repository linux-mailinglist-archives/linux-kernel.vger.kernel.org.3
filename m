Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA824F2F50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357167AbiDEKZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241178AbiDEIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76098101D7;
        Tue,  5 Apr 2022 01:29:06 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBgVq2GrLXfsCm/GOGUJunmBfHbDq+68IoRgUjYZEIQ=;
        b=4cL92wJYafsNAZeJBJhZPkaTIYqag5a4O8ElNW/UzhDgfRTsXfJm1S1zcgWeB9VVUrNw2D
        7HZPJvxGO58jDWgdSTHrGOFGGj3CTXVgfOqF+g3FMj8KxhkZE1RmeUcOof48j5xdzfOwuq
        +dRbPZNQqFroVL0OHK4ycRDhfOa8yUYILZa+UnadL06S+7SuW59Qbl/Z7nQ++Cjo0zp36c
        +rhs0aPDdTNloyevezEHYqdqkvKB9tz3PH8hijF0M6DegOdKPZjQhGFpyuSxkQj3ZurHTq
        ctypjcoNIhohZ0rFViPQixouLr8ggm3BK5rEYAhEaN9pubSA0Ic5V6h3wMQMvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147345;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBgVq2GrLXfsCm/GOGUJunmBfHbDq+68IoRgUjYZEIQ=;
        b=vcsUS0s1BSXMdueYf65emNb4FRgNeXYr40AEWc/RjCRyqxZ/uNXSj0eL+UHQHtsHggqDDU
        5Xa8hZ675Pkm1oCA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Use perf_cgroup_info->active to check
 if cgroup is active
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220329154523.86438-3-zhouchengming@bytedance.com>
References: <20220329154523.86438-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <164914734415.389.1917067665654461073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6875186aea5ce09a644758d9193265da1cc187c7
Gitweb:        https://git.kernel.org/tip/6875186aea5ce09a644758d9193265da1cc187c7
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Tue, 29 Mar 2022 23:45:21 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:45 +02:00

perf/core: Use perf_cgroup_info->active to check if cgroup is active

Since we use perf_cgroup_set_timestamp() to start cgroup time and
set active to 1, then use update_cgrp_time_from_cpuctx() to stop
cgroup time and set active to 0.

We can use info->active directly to check if cgroup is active.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220329154523.86438-3-zhouchengming@bytedance.com
---
 kernel/events/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6545020..a08fb92 100644
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
