Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE647CEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbhLVJPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbhLVJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:15:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:15:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so1954080pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6cS7hpcNOdn0wVvDSD4IF086CmVdAPt/Ay3Gzd4lAE=;
        b=kUktdl2o2DAqIacVbAy2mDEEfHAx8UYl299LS/SZWjscSCYOq0f22Jw3wZq2PDNMLh
         3ZJ9CaPF83nhk+GHRp83WaK39X83d3Pm9zk31WqDK+VUUm1J5A5w401nON/OGvZFNeyz
         XP6Rji4C+04auKwtr8C2TBXSSjw5SHlc31fENE0vix4sGegaSQjGsWcUPGVZDm6RuRYz
         vbe9sFQl2f+0ONBm1btLf/fIOyDLX+NRZNg9b493jsEcYwjcYUU9TRw7ZNtMjFWL8gRh
         LW0sMGb9pUnfCFwYAfwRXAHwToIMp4eB+iFCkiyEGS5rZ9jsQkFUIy/rISxksHW0f/ks
         CMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6cS7hpcNOdn0wVvDSD4IF086CmVdAPt/Ay3Gzd4lAE=;
        b=MnvAuy8fU1RwVAYXX09NJXSAGubLfNauNgM/W/6xOVr1OJhpSgGZ9tITNAcmWqW0rG
         7TzHhbe3E5eTCc7Malv70NKDD6hJMfl6gyve5TNpikJHhRs39UGy0wAv7EzYNXwGK/Qu
         FeYyUNX1VZzCwubyEVVwp2wM0KXp7mDKBg8ZEF+qn6TLJWs7hBvLiqQc1JlwgXu9Yfuq
         zQrTK6XMiSS/eGlt1Gt/gUZ5QJDd9PRo1L/1+UmsRMQTBebYI1jKgg/deXcCNk9nPMUR
         GVnaxoJpHOxtaJSwtc4h4N34ufjfgmijaO3RAjDCmqOHKMSho3ayzQAjeoFpuTBfhfLc
         aB3w==
X-Gm-Message-State: AOAM531cmaTWHhL0nB6ID1GyCGK3MmE7wO0fNqj18OBbSk8b+M4LiO4n
        T0s7pQYV5ZYtZcL9+yI33I4=
X-Google-Smtp-Source: ABdhPJwGvLpAloBJSkBoKJMXO8guMphGMlKpDC7m/2LnMOTRc0H/WOHCoXehEjbH8h8rWLggAapL/g==
X-Received: by 2002:a17:902:9303:b0:143:d6c7:babc with SMTP id bc3-20020a170902930300b00143d6c7babcmr2168575plb.58.1640164536692;
        Wed, 22 Dec 2021 01:15:36 -0800 (PST)
Received: from walker-VirtualBox.. ([43.230.206.234])
        by smtp.gmail.com with ESMTPSA id cu18sm4982000pjb.53.2021.12.22.01.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:15:36 -0800 (PST)
From:   "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] schedule: SCHED_RR: Give a fresh time-slice to the task after after it suspends or relinquishes
Date:   Wed, 22 Dec 2021 17:15:26 +0800
Message-Id: <20211222091526.8511-1-zhaoxiu.zeng@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming the sched_rr_timeslice is 100ms, there are several tasks with the
same priority t1, t2, t3, ..., and t1 sleeps every 80ms, the scheduling
timing may be:
    t1  t2   t3        t1  t2   t3        t1  t2   t3        t1  t2   t3
    80, 100, 100, ..., 20, 100, 100, ..., 60, 100, 100, ..., 40, 100, 100

After applying this patch, the scheduling timing may be:
    t1  t2   t3        t1  t2   t3        t1  t2   t3        t1  t2   t3
    80, 100, 100, ..., 80, 100, 100, ..., 80, 100, 100, ..., 80, 100, 100


Signed-off-by: zhaoxiu.zeng <zhaoxiu.zeng@gmail.com>
---
 kernel/sched/rt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b48baaba2fc2..51798fefcb36 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1491,9 +1491,13 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
-	if (flags & ENQUEUE_WAKEUP)
+	if (flags & ENQUEUE_WAKEUP) {
 		rt_se->timeout = 0;
 
+		if (p->policy == SCHED_RR)
+			p->rt.time_slice = sched_rr_timeslice;
+	}
+
 	check_schedstat_required();
 	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);
 
@@ -1544,7 +1548,12 @@ static void requeue_task_rt(struct rq *rq, struct task_struct *p, int head)
 
 static void yield_task_rt(struct rq *rq)
 {
-	requeue_task_rt(rq, rq->curr, 0);
+	struct task_struct *p = rq->curr;
+
+	if (p->policy == SCHED_RR)
+		p->rt.time_slice = sched_rr_timeslice;
+
+	requeue_task_rt(rq, p, 0);
 }
 
 #ifdef CONFIG_SMP
-- 
2.32.0

