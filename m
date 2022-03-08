Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1664D1081
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiCHGwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245179AbiCHGwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:52:42 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDEB3CFD0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:51:46 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m2so10241887pll.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 22:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjRoLsseXs9PMpYjNJPxbbZENtKg37mqLrEPXGlUnVg=;
        b=hbDKR83zm77FpxqQ3JLULQiu5dHII84DQaKxu+Gsm1lfLpFJ9DzUu4UwqB71kqdZi8
         sJQbLjRrJRzOG6GbO2TkM6Jaqry68k376xfyEgHFiQD249Slr+XV3auACFpJ7ABpfnhp
         mDVCsfMxKsVmGf79C/1SBe8f5qCryGgfglbCcKJs6oYHQAuX73WGQPA6ymUFf/OF1+XM
         tGYqQGHiCuB4zulW3INmPc+31ksjcRUBK6IKBvA/r/ifwGrIlWOTJ/nE+V4gDIKy4szq
         z9vutIY+ZhS9wIwpI/SYWDA88Jh1B7SC81QcRQXIYdsqWvgG7+lVL3YStZ3v0IlO5uR0
         bIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjRoLsseXs9PMpYjNJPxbbZENtKg37mqLrEPXGlUnVg=;
        b=MAjgHGRcD2eY9Vkpj0kDmlKHDMi35KvR+PiWrgxl1pgvSSiycpsorj0Qu+erXbwnpp
         5O1EsuC3HPipzhh/ZDmjePRekg1MpBtd+JmwTIs2GjZPXlPH7s/E7/E/9GYvQbN51Rsp
         wsbdta6XpSSeC4ZLRWZyQJHB74h5mDjBmSdsyOiLlbq1DHIHsguxxYkT7nCBHX7svBub
         yWO0AWzPeckbe2mGAxlaW2GDv+DrqP3L/wQk6Fbq0yhtyWCh/60IMkCs4dsCG3TuRODT
         PLbhtdOOiFcYNRhfHD9CBwZ2RVc2edSlLn5j3kmJkVpn0sCFYsXTmkxBnTYl202bwDK4
         ocQw==
X-Gm-Message-State: AOAM532pJtrA80vJapDSM0ZgbkNsQGPc+2FIi6knTQwvxmG0vIO8GFPd
        7REx2oerPLCCWJAmEqDq9wI=
X-Google-Smtp-Source: ABdhPJy8KGlFukSVyT8cL0sNsOIDPJ9+ZVFzRgwj4WUOkoMJU47MwGUxHl5GSdVzISjwk8H1hU6tNA==
X-Received: by 2002:a17:902:ce91:b0:150:3f7:5096 with SMTP id f17-20020a170902ce9100b0015003f75096mr15731456plg.128.1646722306245;
        Mon, 07 Mar 2022 22:51:46 -0800 (PST)
Received: from mi.xiaomi.com ([43.224.245.250])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm17166446pfl.24.2022.03.07.22.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:51:45 -0800 (PST)
From:   Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Jian Wen <wenjian1@xiaomi.com>
Subject: [PATCH 2/2] sched: fix schedstats for idle kthreads
Date:   Tue,  8 Mar 2022 14:51:10 +0800
Message-Id: <20220308065110.636947-3-wenjian1@xiaomi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308065110.636947-1-wenjian1@xiaomi.com>
References: <20220308065110.636947-1-wenjian1@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Idle kthreads are sleeping instead of being blocked, since they are
not blocked at all.
This patch make idle kthreads triggers the sched:sched_stat_sleep
event instead of sched:sched_stat_blocked.

Testing:
A kernel module[1] is used to trigger sched:sched_stat_blocked/sleep event.

$ sudo sysctl -w kernel.sched_schedstats=1
kernel.sched_schedstats = 1

IDLE task now triggers the sched_stat_sleep event instead of
sched_stat_blocked:
$ sudo perf record -e sched:sched_stat_blocked -e sched:sched_stat_sleep insmod ./delay.ko
$ sudo perf script
...
swapper     0 [000]   546.194819:   sched:sched_stat_sleep: comm=insmod pid=1073 delay=4039079114 [ns]
...

UNINTERRUPTIBLE task still triggers sched:sched_stat_blocked:
$ sudo perf record -e sched:sched_stat_blocked -e sched:sched_stat_sleep insmod ./delay.ko block=1
$ sudo perf script
...
swapper     0 [000]   473.874658: sched:sched_stat_blocked: comm=insmod pid=1062 delay=4044046956 [ns]
...

[1]
static int block=0;
module_param(block, int, 0660);

static int __init init_delay(void)
{

	if (block)
		set_current_state(TASK_UNINTERRUPTIBLE);
	else
		set_current_state(TASK_IDLE);

	schedule_timeout(4*HZ);

	return 0;
}

Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
---
 kernel/sched/deadline.c | 2 +-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/rt.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e6fe3b46432a..f7e60c5983e8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1540,7 +1540,7 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
 		unsigned int state;
 
 		state = READ_ONCE(p->__state);
-		if (state & TASK_INTERRUPTIBLE)
+		if (state & TASK_INTERRUPTIBLE || state == TASK_IDLE)
 			__schedstat_set(p->stats.sleep_start,
 					rq_clock(rq_of_dl_rq(dl_rq)));
 		else if (state & TASK_UNINTERRUPTIBLE)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcfb22c835e4..f1eb0cf8dea3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -986,7 +986,7 @@ update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
 
 		/* XXX racy against TTWU */
 		state = READ_ONCE(tsk->__state);
-		if (state & TASK_INTERRUPTIBLE)
+		if (state & TASK_INTERRUPTIBLE || state == TASK_IDLE)
 			__schedstat_set(tsk->stats.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
 		else if (state & TASK_UNINTERRUPTIBLE)
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 5c4160f8cb23..f3cc5618ec57 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1384,7 +1384,7 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 		unsigned int state;
 
 		state = READ_ONCE(p->__state);
-		if (state & TASK_INTERRUPTIBLE)
+		if (state & TASK_INTERRUPTIBLE || state == TASK_IDLE)
 			__schedstat_set(p->stats.sleep_start,
 					rq_clock(rq_of_rt_rq(rt_rq)));
 		else if (state & TASK_UNINTERRUPTIBLE)
-- 
2.25.1

