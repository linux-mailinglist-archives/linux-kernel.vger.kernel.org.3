Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40765571E94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiGLPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiGLPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:12:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BE8C258D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:05:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b8so6449223pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NmkTEvpJO+qmPFwRE0pLByg6hx1muEVeRREJA+lWhYQ=;
        b=lKzZvacW+cj7x10Ndn0bevDXF/pFit7UyeOHdEWKVUjPgqWWqcmGz7zb99jnuivCD9
         fFMAxdk+bSApkSrgzJcRVeDGQUYxTQWQOC6j0TeiIMOaiwYxpBHdji3ZuzE4zcvzCcVj
         RjCOZ9Lc5yEyDJYAEVCYbfiEq7gyrcI8C4Lpbzvu3icS1QBc+pcmLxlvhadZwX07RmA9
         As+N1gufNn3Zq72jAtC0CXEgWfd+4vn2+SuWJu83csGCXwuWSekwhl67qzb+QqlgXeB2
         IMOd/J40YvxwANFnxjG/+NKg9Y2QLpETTamfcqT6JagDlH3B7gnSVvoKzXp0+ir6dBah
         ofTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NmkTEvpJO+qmPFwRE0pLByg6hx1muEVeRREJA+lWhYQ=;
        b=y7UmmTkuRMMhaRPGOrFR+Pqdkx3b92CjROPmGfTSIb59LwDq8ebXTWL6PDMsFszq95
         CGlvlGem1kOupY/SAV+HOgNarisz8hyWpavQ/+HEfQahv4esdfFTY4SsXLvCwzqq9D0o
         Zbja9TTNdO0EV4pMnGWvU2gwmNbxoqb8QjeTcH9+7osDx44DWbBWWWGFILTmf4qO5Uqq
         PMfqmzdW5H/ku7YIDITU8CA2zEj1Yy9yqM0wNzzbA3BYo4K42I4W7kFwv+R3PmDs5Pu7
         /mg9mYXiyr7f5HPr9FDdbbD5yTl06iXz90dKMAi6BEktzPztQnzxRi7zDsSlXZKRZWA4
         mjhw==
X-Gm-Message-State: AJIora98pAqXBAUcKHacQjIeC47afAo5NaUDdShZ2LOjXoEMgcG/1HEJ
        h8fY8/kT1MIQD+PEgeFyIPY=
X-Google-Smtp-Source: AGRyM1t3f7GnN0EthRWtL3a804oXdyKlBRGpDS/6kTgY6rSbRLoD8tXqrSCvUhK7twSIr5w5u5LOLA==
X-Received: by 2002:a17:903:124e:b0:16b:e975:232f with SMTP id u14-20020a170903124e00b0016be975232fmr23418041plh.165.1657638347186;
        Tue, 12 Jul 2022 08:05:47 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f54700b0016be4d310b2sm7002737plf.80.2022.07.12.08.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:05:46 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v6 2/2] sched/rt: Trying to push current task when target disable migrating
Date:   Tue, 12 Jul 2022 23:05:06 +0800
Message-Id: <20220712150506.632304-2-schspa@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712150506.632304-1-schspa@gmail.com>
References: <20220712150506.632304-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the task to push disable migration, retry to push the current
running task on this CPU away, instead doing nothing for this migrate
disabled task.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 kernel/sched/core.c | 13 ++++++++++++-
 kernel/sched/rt.c   |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecdc..af90cc558b8ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2509,8 +2509,19 @@ int push_cpu_stop(void *arg)
 	if (p->sched_class->find_lock_rq)
 		lowest_rq = p->sched_class->find_lock_rq(p, rq);
 
-	if (!lowest_rq)
+	if (!lowest_rq) {
+		/*
+		 * The find_lock_rq function above could have released the rq
+		 * lock and allow p to schedule and be preempted again, and
+		 * that lowest_rq could be NULL because p now has the
+		 * migrate_disable flag set and not because it could not find
+		 * the lowest rq. So we must check task migration flag again.
+		 */
+		if (unlikely(is_migration_disabled(p)))
+			p->migration_flags |= MDF_PUSH;
+
 		goto out_unlock;
+	}
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7bd3e6ecbe45e..e2d7b085a93d9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2136,6 +2136,12 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 */
 		task = pick_next_pushable_task(rq);
 		if (task == next_task) {
+			/*
+			 * If next task has now disabled migrating, see if we
+			 * can push the current task.
+			 */
+			if (unlikely(is_migration_disabled(task)))
+				goto retry;
 			/*
 			 * The task hasn't migrated, and is still the next
 			 * eligible task, but we failed to find a run-queue
-- 
2.37.0

