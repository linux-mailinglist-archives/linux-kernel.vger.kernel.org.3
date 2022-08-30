Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0F25A58F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiH3Bog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiH3BoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:44:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F7F7C305
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 145so9549500pfw.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=G+5+t9wS3j8loUJEHuF9oZ643Kgj2nRnoYQ+cdIzE4Q=;
        b=p8rDSiod8Q6m2f7lk+vGYHRbMdp8G+R142a05Y91cEYOFDAIz4HqPR/p3gogUm0Ylz
         5l58AwitYF7ClY7/r1uh90AHZqPulavtZLGuBk1pX+s1yUacjmsdsKZW9neSzre0hvZu
         Uqsfq7HgJLDLvNwr/UmZiExWBFqy8ePwhgbx3JfoKZJD7K6x9c+27IKwVKo7mLHeE7wG
         GQFB0gz0ZkrPU2pWnPg3Hut15UYaAuEwNO8/Xg08tn3wqAdJOGwrmqc0DyJLQZfr2pah
         +8nFLLbrjKfx/EsQNSPRF64j6afoBibu8dS6S/XrL3fnl1dAICEfbtwxZwqkWGxhZJJO
         QOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G+5+t9wS3j8loUJEHuF9oZ643Kgj2nRnoYQ+cdIzE4Q=;
        b=J0EvrtehfgzIJNEBxlPl8fMoiou5m06tvza4cSp8RVLoVI17di5TgBRbno9iaI2CtU
         4/VHcX3eNZX4OAghZbcctmpCa7k/g1VeAW+haE9zw6P3gWCaylqEIZtB6G1zesz/Fm2o
         uF5GFxn8cmc9eav3B2THxkdjgUlyos9r+0jvc7dzAcKm79tHPao/3gS+4RyiyMi1L0eM
         QwuZmPkkS7uPw8EFVO3qfoBwHo1CjEgmY1t5R8erLuJsx6EqB4NG7BImkAmWBKW/eGh7
         J/2/xA8trnLj1q14oEXFFE0ZLfbo+1lF1nVzDoZMr2jPwx9oYogK4NvsPb318rGqo/qd
         xBOA==
X-Gm-Message-State: ACgBeo15P2t2EAkEp6DZbbzPk3VOb3oYCJCuLf1s3Y8sI6DyZhKM1fTZ
        N3bcwPNO3fU9adWVvKvZAgDCOlKFHcQ=
X-Google-Smtp-Source: AA6agR5h5y0JHFyZVNXdoeR4s3tDd2r5LXjhoA3xugPlUhw3wrPSh1KuENIbd4Gu1ZSwl/Dg+K4pyA==
X-Received: by 2002:a65:494b:0:b0:428:d68c:35bf with SMTP id q11-20020a65494b000000b00428d68c35bfmr15539520pgs.509.1661823846843;
        Mon, 29 Aug 2022 18:44:06 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id v14-20020aa799ce000000b00535faa9d6f2sm7976038pfi.53.2022.08.29.18.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 18:44:06 -0700 (PDT)
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
Subject: [PATCH 2/4] sched: add WF_CURRENT_CPU and externise ttwu
Date:   Mon, 29 Aug 2022 18:43:54 -0700
Message-Id: <20220830014356.5364-3-avagin@gmail.com>
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

From: Peter Oskolkov <posk@google.com>

Add WF_CURRENT_CPU wake flag that advices the scheduler to
move the wakee to the current CPU. This is useful for fast on-CPU
context switching use cases such as UMCG.

In addition, make ttwu external rather than static so that
the flag could be passed to it from outside of sched/core.c.

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 kernel/sched/core.c  |  3 +--
 kernel/sched/fair.c  |  4 ++++
 kernel/sched/sched.h | 13 ++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..008be12c31e6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4045,8 +4045,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
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
index 914096c5b1ae..7b043870b634 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7028,6 +7028,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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
index e26688d387ae..6e93e8808bfd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2080,12 +2080,13 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
+#define WF_SYNC         0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED     0x20 /* Internal use, task got migrated */
+#define WF_CURRENT_CPU  0x40 /* Prefer to move the wakee to the current CPU. */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
@@ -3151,6 +3152,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
-- 
2.37.2

