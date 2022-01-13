Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F0D48E108
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiAMXkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiAMXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:40:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7ECC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so14769029ybp.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMGfyZNGg16kQgWmzvaNooZwk13glosUs6aVPqZ/nrc=;
        b=dPjeDOi3O6ASy2ii197CAuCJWdyt8duA1D7+djoQotRqDWEhrzMmCDnirA/nQ9hobQ
         b0jwGR5DttHhc7TO0zCq9P83NNX8HIuOu7C3PuUi1naYFMUSXJLqh/bj7/0/HUMide1a
         CQ7+ws5aRRjDBPW3sVeq/GIKcXNaoWg9GlsmsDhG0RZFV53D9DAEMUYsppjTQW/+r9pl
         hPifaqFSqER+Dfj0ncmOx3oxCYdMKfxadHa0FxG4lAh+xyj5K3yQN35aVqZ7Hq8hNZDe
         mLUDfq3b+sMRtPRShVuPrMejCh12/LAjHxZAbOMHfdK+fhggZQjwS9ZxWf50K3mVt1lr
         7F/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMGfyZNGg16kQgWmzvaNooZwk13glosUs6aVPqZ/nrc=;
        b=qWTmvQoaF8jL+1zgKzt+Ae6xB+5RjgONjyLHRMwsQuX0LQbxQ4mjUlIN3/nk/0i1IV
         fPjefn847s+spYve2JIZz/kI3wCyG13YPhDswOT4fI/phzY6jdsjw7oXIFEtLnPe4foi
         qfoYTr6cbSku63cjocYFPLGfXfpakjjf/vhQK9sfqoEK5B3nSfSo8um2fSzF1mwkx9yo
         7+NbZfF56MMVllkVKTP/MUOoplKY0QDnQtDgg9AWmcj/KtbXbqPcQhQTeljENDsYw14e
         NaGlLh9aJo49ymWPJMJ/tZ7ZDlVd4ueROoYw3/NxvV9ls75cflYeepb+MajryWL0kwoA
         lJEA==
X-Gm-Message-State: AOAM530/Mkb9MrPJImyAEzfsyh3ydbbohdozAbzpUS2EdnFMUQkTyeQU
        a2zDbj0XpXGpSZA6MpGFVZTNqjUg
X-Google-Smtp-Source: ABdhPJz5otcxfEhE6MWpPlPMKjfGbxs3qBpBtoEpYWyLi1d9W5GUhm/RULyKZYaWhqebI5v0hyA4l39c
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:c548:e79f:8954:121f])
 (user=posk job=sendgmr) by 2002:a25:9a02:: with SMTP id x2mr9180866ybn.701.1642117204312;
 Thu, 13 Jan 2022 15:40:04 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:39:36 -0800
In-Reply-To: <20220113233940.3608440-1-posk@google.com>
Message-Id: <20220113233940.3608440-2-posk@google.com>
Mime-Version: 1.0
References: <20220113233940.3608440-1-posk@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [RFC PATCH v2 1/5] sched/umcg: add WF_CURRENT_CPU and externise ttwu
From:   Peter Oskolkov <posk@google.com>
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@posk.io>

Add WF_CURRENT_CPU wake flag that advices the scheduler to
move the wakee to the current CPU. This is useful for fast on-CPU
context switching use cases such as UMCG.

In addition, make ttwu external rather than static so that
the flag could be passed to it from outside of sched/core.c.

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211122211327.5931-2-posk@google.com
---
 kernel/sched/core.c  |  3 +--
 kernel/sched/fair.c  |  4 ++++
 kernel/sched/sched.h | 15 +++++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83872f95a1ea..04525933de94 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3980,8 +3980,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
-static int
-try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
+int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
 	unsigned long flags;
 	int cpu, success = 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..4b70cf8f1ec3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6838,6 +6838,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
+		if ((wake_flags & WF_CURRENT_CPU) &&
+		    cpumask_test_cpu(cpu, p->cpus_ptr))
+			return cpu;
+
 		if (sched_energy_enabled()) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be905739..77f67d09b946 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2052,13 +2052,14 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 }
 
 /* Wake flags. The first three directly map to some SD flag value */
-#define WF_EXEC     0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
-#define WF_FORK     0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
-#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+#define WF_EXEC         0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK         0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU         0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
 
-#define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
-#define WF_MIGRATED 0x20 /* Internal use, task got migrated */
-#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
+#define WF_SYNC         0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED     0x20 /* Internal use, task got migrated */
+#define WF_ON_CPU       0x40 /* Wakee is on_cpu */
+#define WF_CURRENT_CPU  0x80 /* Prefer to move the wakee to the current CPU. */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
@@ -3112,6 +3113,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
-- 
2.34.1.703.g22d0c6ccf7-goog

