Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26356C21E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbiGHVS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGHVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:18:56 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE7F2B1A1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:18:55 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id e7so3671431qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VVj5JPreiWbsfHLMFnjHfdmTF3ogXhI9pPuNuPFyass=;
        b=p9J4Cekqy7kPYZhET0bZimFo5q4CcHkieoOcQnbXR8wNeeOiMLAvs/MoVuL7RMu+ed
         EjJEQpDACCrb8/gDT2gnZj+6RLNzu+RZU2BWvxnEX4zr8E20CRUmdqw0ndbR56NRXayE
         OZhJCq+F8kqJ84qJ6NvQlMzo8tGYPrJrn2+Xc6IR8ziGQhQDnZOLTfzYQeR3zS/qJNEh
         VHYCRw8/haVlh/7Q5FtLSTeQC4rAiQH9kRL168SeiBe2xbo0Y6H0lMc8d+j2FK8kuzkH
         PCa92dnetR/P2MzBN6D6UEBwUL2RvzNu4U5MIHKOL88ZHx6UxU6kw/DNz8cRjMTPhrhf
         LnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VVj5JPreiWbsfHLMFnjHfdmTF3ogXhI9pPuNuPFyass=;
        b=j8gbvOGPPHDFzk08nlmM+QWDzAN9gUcT1Y9EJF0FOEupXzH0aGYq0yCLIVxzJZfhIh
         AlZKccJR8FERBEl3ibqCuUySBm2x8Q8KIjNnoWxjCQpgpcs4l2Js/zNF4106fb6p7L7y
         rmZboSgOC6F4DkeU4dq0gPJWHXKnhtWm/P36fH7t9fVwLBIYGDtivoBXxcsNJy8+dX3n
         gZW8nPpCa2QdSTg/c4OtVk80j5zsdiel9U8UhCMo69pj/PMvtfl60f1X5XRd92xseYZX
         gE+YLHgqL42q4irWG317FeIyNTRR61CitiSjazsoj24fqDhEjNzoX5hZZ4Hpbab9zSwx
         n+6w==
X-Gm-Message-State: AJIora+VnkajGMSRCgUyGHYR5rxglPgr0jJbRGqB+qQMPUJl7hJDeKUh
        BqgnqrWvpTiX/rZK/SvAfZg=
X-Google-Smtp-Source: AGRyM1ugG6Y9KtP5Wo4ypXnM/cqRN2gOhAJbLIL/P5oX+ArBv4L0tJxBTSBDDdrJVBoaOcjnF+aXQQ==
X-Received: by 2002:ac8:5a03:0:b0:319:14d1:8baf with SMTP id n3-20020ac85a03000000b0031914d18bafmr4742790qta.374.1657315134992;
        Fri, 08 Jul 2022 14:18:54 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id ew7-20020a05622a514700b0031e9d9635d4sm3659728qtb.23.2022.07.08.14.18.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jul 2022 14:18:54 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v4 2/2] sched/rt: Trying to push current task when target disable migrating
Date:   Sat,  9 Jul 2022 05:17:55 +0800
Message-Id: <20220708211755.73637-2-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220708211755.73637-1-schspa@gmail.com>
References: <20220708211755.73637-1-schspa@gmail.com>
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
 kernel/sched/core.c | 6 +++++-
 kernel/sched/rt.c   | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecdc..0b1fefd97d874 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2509,8 +2509,12 @@ int push_cpu_stop(void *arg)
 	if (p->sched_class->find_lock_rq)
 		lowest_rq = p->sched_class->find_lock_rq(p, rq);
 
-	if (!lowest_rq)
+	if (!lowest_rq) {
+		if (unlikely(is_migration_disabled(p)))
+			p->migration_flags |= MDF_PUSH;
+
 		goto out_unlock;
+	}
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0e0bc9aeaa394..9a91adf486e34 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2135,6 +2135,12 @@ static int push_rt_task(struct rq *rq, bool pull)
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

