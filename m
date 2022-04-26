Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF79D50FB61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbiDZKuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349792AbiDZKtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:49:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7DD13DC8;
        Tue, 26 Apr 2022 03:45:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u7so14469620plg.13;
        Tue, 26 Apr 2022 03:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1is8Iezkr6s4Ex2hsS25ZUz1zJxOesQz7FGVxmLzzqI=;
        b=p0DuLhC8Wjy65J2kDplTzS8Gmbx06flEyAu02NmnEa6iLAouiE2jEx/xoupC8cq87d
         u6GcRCz0FyfcTy5F9x9jJErzZVniFujrqWUTIt+zbovvDIfLFcptXSQOEhTlutIaJfvb
         karYlh4Ccy9ZRuTY/FD+W4wndDYVaS0vtFnPbqgsS1ZOwh5JT1ZVww2TgOs5WMiHTY97
         +2vJrfQ9JE6zAlFBp6HddwWtnE0WUHvEuyfqRYnjOL7sw6HnqI0KjEGRzm7gboajj2Y9
         8DRcpcmW+jgOXuI7CBDZO4KLCqF6lRkGblXoEUlBGtkhXqmxBk4kuZuPGwAjiKEtFBGA
         fNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1is8Iezkr6s4Ex2hsS25ZUz1zJxOesQz7FGVxmLzzqI=;
        b=5ifkb1dnwQXc7mLfly+ZW8O4sqFUr547VMgdLY76KVQq5BpYPenF4MVRVISwn0pWIK
         cD3uZ0QR9UvUu7eBhOAVROQnLPvvpJRA5OCtk/Ke1XQzXonmKfXwTi1RHd9CP6Tb2QZD
         nIHp9PlyoPPg21G784oOondKqhpK1ys0OLnSG7sFdERf4nBAm/C7Vjr14K5rxYcVprRL
         7Hokn29LbjBcrw8U2FHs6DycbN2OJ6Li/O6knfOGnkZds1W3NLacTlrHj2Wwe6blqb2E
         MJ46vZeMhOPnPV/T4tilXPj0yc2ZsVMrqLMSyYde0TbOINvSU5R5NjmVYFtAxvvitpE6
         p6Og==
X-Gm-Message-State: AOAM531wIL0kKqsL5UbuJX1nHxtO1W8fuwZrCM3i1F9RTJGaAYOcwFI2
        raFh6aKiOXGFuh3nd2Yk5Go=
X-Google-Smtp-Source: ABdhPJywGsD8N8S5nB6bbKsBl/gY28f/6aIIUnZRIYbR5jtlC4ehB0GHOptwChCN5l4sOXbq39ztZw==
X-Received: by 2002:a17:902:ab96:b0:159:1ff:4ea0 with SMTP id f22-20020a170902ab9600b0015901ff4ea0mr23055359plr.60.1650969908094;
        Tue, 26 Apr 2022 03:45:08 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id c17-20020a056a00249100b00508389d6a7csm15519196pfv.39.2022.04.26.03.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 03:45:07 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     paulmck@kernel.org, rostedt@goodmis.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick.wang.shcn@gmail.com
Subject: [PATCH v3] rcu: ftrace: avoid tracing a few functions executed in stop machine
Date:   Tue, 26 Apr 2022 18:45:02 +0800
Message-Id: <20220426104502.52663-1-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the change of stop machine implementation, there are functions
being called while waiting currently:

----------------------------------------------------------------
Former stop machine wait loop:
do {
    cpu_relax(); => macro
    ...
} while (curstate != STOPMACHINE_EXIT);
-----------------------------------------------------------------
Current stop machine wait loop:
do {
    stop_machine_yield(cpumask); => function (notraced)
    ...
    touch_nmi_watchdog(); => function (notraced, inside calls also notraced)
    ...
    rcu_momentary_dyntick_idle(); => function (notraced, inside calls traced)
} while (curstate != MULTI_STOP_EXIT);
------------------------------------------------------------------

These functions (including the calls inside) should be marked notrace to avoid
their codes being updated when they are being called. The calls inside
rcu_momentary_dyntick_idle() still remain traced, and will cause crash:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu: 	1-...!: (0 ticks this GP) idle=14f/1/0x4000000000000000 softirq=3397/3397 fqs=0
  rcu: 	3-...!: (0 ticks this GP) idle=ee9/1/0x4000000000000000 softirq=5168/5168 fqs=0
  	(detected by 0, t=8137 jiffies, g=5889, q=2 ncpus=4)
  Task dump for CPU 1:
  task:migration/1     state:R  running task     stack:    0 pid:   19 ppid:     2 flags:0x00000000
  Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
  Call Trace:
  Task dump for CPU 3:
  task:migration/3     state:R  running task     stack:    0 pid:   29 ppid:     2 flags:0x00000000
  Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
  Call Trace:
  rcu: rcu_preempt kthread timer wakeup didn't happen for 8136 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
  rcu: 	Possible timer handling issue on cpu=2 timer-softirq=594
  rcu: rcu_preempt kthread starved for 8137 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
  rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
  rcu: RCU grace-period kthread stack dump:
  task:rcu_preempt     state:I stack:    0 pid:   14 ppid:     2 flags:0x00000000
  Call Trace:
    schedule+0x56/0xc2
    schedule_timeout+0x82/0x184
    rcu_gp_fqs_loop+0x19a/0x318
    rcu_gp_kthread+0x11a/0x140
    kthread+0xee/0x118
    ret_from_exception+0x0/0x14
  rcu: Stack dump where RCU GP kthread last ran:
  Task dump for CPU 2:
  task:migration/2     state:R  running task     stack:    0 pid:   24 ppid:     2 flags:0x00000000
  Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
  Call Trace:

Mark the calls inside rcu_momentary_dyntick_idle():
 rcu_preempt_deferred_qs()
 rcu_preempt_need_deferred_qs()
 rcu_preempt_deferred_qs_irqrestore()
as notrace to prevent this.

Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
v1->v2:
 - Modify log message.

v2->v3:
 - Move "notrace" to behind "static" to keep the consistency with the rest of the code.

 kernel/rcu/tree_plugin.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c8ba0fe17267..440d9e02a26e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -460,7 +460,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
  * be quite short, for example, in the case of the call from
  * rcu_read_unlock_special().
  */
-static void
+static notrace void
 rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 {
 	bool empty_exp;
@@ -581,7 +581,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  * is disabled.  This function cannot be expected to understand these
  * nuances, so the caller must handle them.
  */
-static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+static notrace bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
@@ -595,7 +595,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
  * evaluate safety in terms of interrupt, softirq, and preemption
  * disabling.
  */
-static void rcu_preempt_deferred_qs(struct task_struct *t)
+static notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
 
-- 
2.25.1

