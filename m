Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698E511322
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359251AbiD0IEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359253AbiD0IDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:03:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52281AF2B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:00:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so4320147pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SY1krE1XlZHmCzWuFUzccc7xOTTIQag7kMHSwWGpH34=;
        b=IZ3sD0mDwQ1NFBRa4FJJlFvzQXUHgL7GwX/o1UKD8fuTVy3E+i9QMSfIQJb43U40mC
         c/C7DDr/WJRRu5nymtH6DT1jDDUssM2U96p7iux/MIibxfEPD41OHPsWB1oXl8s/tLJE
         By2Jq/NWrqHeGrOv9a1EJVnvOEsBqVRtjq5SHW/g4e2tSKUtTDE6uwSOW8tIfnyV6H3t
         eQOTyAZ26dpumf5rdJb0hLHBxk4uvW8KevjfvieMih9gRlJqvsotscV3QARnBCjWQHsI
         AYDaqMw826d7bAhk5NBZZl+L1NxTXP0QirKNa6fsHbZUUoZBB1fsZEUxMjvjZkvBQuvf
         cSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SY1krE1XlZHmCzWuFUzccc7xOTTIQag7kMHSwWGpH34=;
        b=TX8csoWF5GcJYR265bwExePwO3iKsvaEy0zzF5GQ9plEAXyXdj4TF7aOGzuU7353VO
         YbuJ5SvdxsY+B8TTixbBozPjLPby1GTzFdrrukINiQcDgfW3JXdCag0qoKTuW8YUzO/8
         qD/8YRxxg5PMV0wMGbmpgVrXi93wgfhCZ//kFk6Qm3Hgp3A0jeJpG0lgH6JgcJlufC3O
         lzIWC5I7QtENygkQJ2Za3huYJ82t2+qQa9TEn50EUnRO6yMLUWhlv63mldbRP6sds0Rv
         XBb9lmF0g+b4aUYiVDEHfWNNS63gyDlVEUkbocoWRaxthIvEOPZS1tL0aR3Z7HdUZmwW
         5qww==
X-Gm-Message-State: AOAM533RzfhPjAU0ZdIBFKgq7I8uwi18zXPq7xKiAxKn1GNMgyJIBYZA
        V+sjTi8pnu0TxKFbIoLJM0LsuA==
X-Google-Smtp-Source: ABdhPJwBuokuK0ZWgd6XP3nNl0yyemdmYB5BWsNpJw/IbXYwL1VZPJ2LHEH5vWWPYaVFH3AHtssG9w==
X-Received: by 2002:a17:90a:8d82:b0:1d8:a5a9:5489 with SMTP id d2-20020a17090a8d8200b001d8a5a95489mr27752692pjo.102.1651046436098;
        Wed, 27 Apr 2022 01:00:36 -0700 (PDT)
Received: from localhost.localdomain ([240e:390:e6b:6b80:9d6d:7735:8291:b65d])
        by smtp.gmail.com with ESMTPSA id u2-20020a62d442000000b0050d404f837fsm9543380pfl.156.2022.04.27.01.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:00:35 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 2/2] sched/deadline: Remove superfluous rq clock update in push_dl_task()
Date:   Wed, 27 Apr 2022 16:00:14 +0800
Message-Id: <20220427080014.18483-3-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220427080014.18483-1-jiahao.os@bytedance.com>
References: <20220427080014.18483-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change to call update_rq_clock() before activate_task()
commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq
when pushing a task") is no longer needed since commit f4904815f97a
("sched/deadline: Fix double accounting of rq/running bw in push & pull")
removed the add_running_bw() before the activate_task().

So we remove some comments that are no longer needed and update
rq clock in activate_task().

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/deadline.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a562bb271031..83636a7fcd32 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2320,13 +2320,7 @@ static int push_dl_task(struct rq *rq)
 
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, later_rq->cpu);
-
-	/*
-	 * Update the later_rq clock here, because the clock is used
-	 * by the cpufreq_update_util() inside __add_running_bw().
-	 */
-	update_rq_clock(later_rq);
-	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
+	activate_task(later_rq, next_task, 0);
 	ret = 1;
 
 	resched_curr(later_rq);
-- 
2.32.0

