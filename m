Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2141F5A58F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiH3BoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiH3BoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:44:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B257C1C2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c24so9301314pgg.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BKqwlh2LYsyA0xlbuRIO9SBcDmgUfBuyVHnS5ZwNoOg=;
        b=Fv+/cLbwo1iO+WAVeCuZ1vvS2QJyW7JL6cHtZ1jdcabtqKyvDPTpIefGiVZ5yw5V5t
         aRbk+afsASV4S+b7UfR4lWcFtOAz33T8lREB0hH9Eaoufs4fGHmigLHl4dZ6C46QdByz
         KeMJPPi1tnK+mL2cN8TfcY5ErIS+WgVBhifznkUvVqlsoZlg7aXTGsT3/PjRXSen3TKB
         eV+zNnZFqa+0WmDOxv4sPstNKAlKb4Ok79IoDL8OEdcTDdfapLrMYEHGT88f5SX+TCBE
         /vS58uGQwYD2eZfXDSkqc4eiV5+W4nkUo/jQC5Ru9Dat/Kscu/19lfxB9vr4s8ilbtUq
         93Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BKqwlh2LYsyA0xlbuRIO9SBcDmgUfBuyVHnS5ZwNoOg=;
        b=WBfnWetj/dKa1kiveXda+AEFX6C28r62WyOHLdjZFls640vOsMpLQ95PsZlhdDDYEG
         ukRhyymdLxjDCY+s4n97stqjUv+TiUBSf4WdIohNcZkIICE/d3Wdam2fdIzEe2+ve+U8
         pCAl1O1BzWMC/6P+oSkilaoK1iTsMVucJ7Mu3Gav11BAv3lYQMfaf7kPtowrXbr6PBPa
         t1oHVYzWcVEgQ/ilWy6/wG099zabPY4WlzVQQmWU33Wc+W9IR/gG2TVW5DXQ0nwW98HN
         4kM0mrQSqlnU412nDlNymLFzo5cZGCAeHLQjw8FwcZiHPNUUi0mS+incIafxl+un/RvK
         lzxQ==
X-Gm-Message-State: ACgBeo3wNh34tr3zqXSfie20KzUaBaN+6ns1j97A3yvbZOQP3Ptz6yZ0
        4Lc8xJMhQVutgUj4CVf3CDTe4sYf/HI=
X-Google-Smtp-Source: AA6agR7P4i0pBPdvGm0aHAx9/RlRD0/FDRYQzHti2KWDUbjF3jvIiPWmddCZYi+AkdvVVqj8eSeC0g==
X-Received: by 2002:a63:5418:0:b0:42a:d773:cbd6 with SMTP id i24-20020a635418000000b0042ad773cbd6mr16214306pgb.106.1661823848381;
        Mon, 29 Aug 2022 18:44:08 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id v14-20020aa799ce000000b00535faa9d6f2sm7976038pfi.53.2022.08.29.18.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 18:44:07 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/4] sched: add a few helpers to wake up tasks on the current cpu
Date:   Mon, 29 Aug 2022 18:43:55 -0700
Message-Id: <20220830014356.5364-4-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830014356.5364-1-avagin@gmail.com>
References: <20220830014356.5364-1-avagin@gmail.com>
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

Add complete_on_current_cpu, wake_up_poll_on_current_cpu helpers to wake
up processes on the current CPU.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 include/linux/completion.h |  1 +
 include/linux/swait.h      |  1 +
 include/linux/wait.h       |  3 +++
 kernel/sched/completion.c  | 12 ++++++++++++
 kernel/sched/core.c        |  2 +-
 kernel/sched/swait.c       | 11 +++++++++++
 kernel/sched/wait.c        |  5 +++++
 7 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 51d9ab079629..1699e697a225 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -115,6 +115,7 @@ extern bool try_wait_for_completion(struct completion *x);
 extern bool completion_done(struct completion *x);
 
 extern void complete(struct completion *);
+extern void complete_on_current_cpu(struct completion *x);
 extern void complete_all(struct completion *);
 
 #endif
diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b8c2a5..1f27b254adf5 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -147,6 +147,7 @@ static inline bool swq_has_sleeper(struct swait_queue_head *wq)
 extern void swake_up_one(struct swait_queue_head *q);
 extern void swake_up_all(struct swait_queue_head *q);
 extern void swake_up_locked(struct swait_queue_head *q);
+extern void swake_up_locked_on_current_cpu(struct swait_queue_head *q);
 
 extern void prepare_to_swait_exclusive(struct swait_queue_head *q, struct swait_queue *wait, int state);
 extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 58cfbf81447c..dcd01dd4de3e 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -210,6 +210,7 @@ __remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq
 }
 
 void __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
+void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
@@ -237,6 +238,8 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define key_to_poll(m) ((__force __poll_t)(uintptr_t)(void *)(m))
 #define wake_up_poll(x, m)							\
 	__wake_up(x, TASK_NORMAL, 1, poll_to_key(m))
+#define wake_up_poll_on_current_cpu(x, m)					\
+	__wake_up_on_current_cpu(x, TASK_NORMAL, poll_to_key(m))
 #define wake_up_locked_poll(x, m)						\
 	__wake_up_locked_key((x), TASK_NORMAL, poll_to_key(m))
 #define wake_up_interruptible_poll(x, m)					\
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 35f15c26ed54..1ae9b34822ef 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -38,6 +38,18 @@ void complete(struct completion *x)
 }
 EXPORT_SYMBOL(complete);
 
+void complete_on_current_cpu(struct completion *x)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&x->wait.lock, flags);
+
+	if (x->done != UINT_MAX)
+		x->done++;
+	swake_up_locked_on_current_cpu(&x->wait);
+	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
+}
+
 /**
  * complete_all: - signals all threads waiting on this completion
  * @x:  holds the state of this particular completion
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 008be12c31e6..1e164d8fde1a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6813,7 +6813,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~(WF_SYNC|WF_CURRENT_CPU));
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index 76b9b796e695..9ebe23868942 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -31,6 +31,17 @@ void swake_up_locked(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_locked);
 
+void swake_up_locked_on_current_cpu(struct swait_queue_head *q)
+{
+	struct swait_queue *curr;
+
+	if (list_empty(&q->task_list))
+		return;
+
+	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
+	try_to_wake_up(curr->task, TASK_NORMAL, WF_CURRENT_CPU);
+	list_del_init(&curr->task_list);
+}
 /*
  * Wake up all waiters. This is an interface which is solely exposed for
  * completions and not for general usage.
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 9860bb9a847c..9a78bca79419 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -157,6 +157,11 @@ void __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
 }
 EXPORT_SYMBOL(__wake_up);
 
+void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
+{
+	__wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
+}
+
 /*
  * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
  */
-- 
2.37.2

