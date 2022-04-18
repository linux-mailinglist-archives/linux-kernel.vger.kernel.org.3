Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08E504BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 06:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiDREkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 00:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiDREkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 00:40:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8363BE;
        Sun, 17 Apr 2022 21:37:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id bg9so16748100pgb.9;
        Sun, 17 Apr 2022 21:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2x14r91CBQD4kQRAmO7qT3fqu0Rss/iUo6NrPr0sqPQ=;
        b=gm9pLszO+K7B658j6Fx2WYqjVu6vHorUWNGvEz20nbqtS+wVkezBjVfJO6ftLCLKGu
         /I7LedZH/HVSfgKyU9cK9WyVETN/V4Y1swvvjLDRTeNnmHmxSdkj7hGFT2h0W+yaNNp/
         ePAHbv9as9Er5tUMuuRiaMYSn9xCa+vUkN20Ppp5qsF9+qCqE7214/e6JMmJguLZNZIT
         82ENHtlL/skI/Cxij5H7HLTqRBEtuk7tNp+D1IQKc1MJ5N6j3YL03KSof7sxF8C7I2lh
         uLb8kQVg08ZsgRezUIcSyla1u/HHDzHU2NLPtIfzioyQ7fS4rcUpt0sKQ+h0l6HiTEsd
         T4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2x14r91CBQD4kQRAmO7qT3fqu0Rss/iUo6NrPr0sqPQ=;
        b=RBtj88Zp9PnMkY/RPpcUggumb1YPlotJT5jZjuVMUjRRLyLFyx5cGNrPB+qMoeX2PW
         0uztkjUjmkflXSWdBn2DldVam2DoERUsNETuMO9SP8DejXrRBjdogznqr7cI63f5a+/Z
         9nv97ypmIxF7y8VESHcyKmiYskf0k4I4D1oI/dRb4UpSSFpuESw3o0nAZEG5o774pbxl
         M4IKL8DkL2mHPUFgFlJ2OrCJ8bYuqOYtQ0Acz6bdzLkIlNT9OM0AEcsVKzYOCATaiGSG
         gccHGPNvkyvQtaV3y453+eQ3LZ0NyXuLmuP8uDXkgKWi0paY5VW2Dyi/v/J8iQx8qfgw
         U1jg==
X-Gm-Message-State: AOAM533ILUUyRCtQmqhJbETNAj3T14twR9ZCDNIOVLf9rc7Q6T7tzdAZ
        I2YTGW3VqI2XFMYGG4I7K9bmfTr/A+xz2RdX
X-Google-Smtp-Source: ABdhPJwZ+qF61Md8chEgJf7BMSaSXVN+LN6fY4LgLXr1A7AfLDL31yGFyQpngRugRiP+yYhILZFyOQ==
X-Received: by 2002:a63:fd05:0:b0:3aa:127d:538a with SMTP id d5-20020a63fd05000000b003aa127d538amr605689pgh.95.1650256660396;
        Sun, 17 Apr 2022 21:37:40 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id w14-20020a17090a4f4e00b001cb510021ecsm15176253pjl.49.2022.04.17.21.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 21:37:39 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     paulmck@kernel.org, rostedt@goodmis.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick.wang.shcn@gmail.com
Subject: [PATCH] rcu: ftrace: avoid tracing a few functions executed in multi_cpu_stop()
Date:   Mon, 18 Apr 2022 12:37:35 +0800
Message-Id: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
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

A few functions are in the call chain of rcu_momentary_dyntick_idle()
which is executed in multi_cpu_stop() and marked notrace. They are running
in traced when ftrace modify code. This may cause non-ftrace_modify_code
CPUs stall:

[   72.686113] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   72.687344] rcu: 	1-...!: (0 ticks this GP) idle=14f/1/0x4000000000000000 softirq=3397/3397 fqs=0
[   72.687800] rcu: 	3-...!: (0 ticks this GP) idle=ee9/1/0x4000000000000000 softirq=5168/5168 fqs=0
[   72.688280] 	(detected by 0, t=8137 jiffies, g=5889, q=2 ncpus=4)
[   72.688739] Task dump for CPU 1:
[   72.688991] task:migration/1     state:R  running task     stack:    0 pid:   19 ppid:     2 flags:0x00000000
[   72.689594] Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
[   72.690242] Call Trace:
[   72.690603] Task dump for CPU 3:
[   72.690761] task:migration/3     state:R  running task     stack:    0 pid:   29 ppid:     2 flags:0x00000000
[   72.691135] Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
[   72.691474] Call Trace:
[   72.691733] rcu: rcu_preempt kthread timer wakeup didn't happen for 8136 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[   72.692180] rcu: 	Possible timer handling issue on cpu=2 timer-softirq=594
[   72.692485] rcu: rcu_preempt kthread starved for 8137 jiffies! g5889 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
[   72.692876] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   72.693232] rcu: RCU grace-period kthread stack dump:
[   72.693433] task:rcu_preempt     state:I stack:    0 pid:   14 ppid:     2 flags:0x00000000
[   72.693788] Call Trace:
[   72.694018] [<ffffffff807f3740>] schedule+0x56/0xc2
[   72.694306] [<ffffffff807f9cd8>] schedule_timeout+0x82/0x184
[   72.694539] [<ffffffff8007c456>] rcu_gp_fqs_loop+0x19a/0x318
[   72.694809] [<ffffffff8007e408>] rcu_gp_kthread+0x11a/0x140
[   72.695325] [<ffffffff800324d6>] kthread+0xee/0x118
[   72.695657] [<ffffffff8000398a>] ret_from_exception+0x0/0x14
[   72.696089] rcu: Stack dump where RCU GP kthread last ran:
[   72.696383] Task dump for CPU 2:
[   72.696562] task:migration/2     state:R  running task     stack:    0 pid:   24 ppid:     2 flags:0x00000000
[   72.697059] Stopper: multi_cpu_stop+0x0/0x18c <- stop_machine_cpuslocked+0x128/0x174
[   72.697471] Call Trace:

Mark rcu_preempt_deferred_qs(), rcu_preempt_need_deferred_qs() and
rcu_preempt_deferred_qs_irqrestore() notrace to avoid this.

Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 kernel/rcu/tree_plugin.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c3d212bc5338..07b3e656aedd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -460,7 +460,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
  * be quite short, for example, in the case of the call from
  * rcu_read_unlock_special().
  */
-static void
+notrace static void
 rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 {
 	bool empty_exp;
@@ -581,7 +581,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  * is disabled.  This function cannot be expected to understand these
  * nuances, so the caller must handle them.
  */
-static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
+notrace static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
@@ -595,7 +595,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
  * evaluate safety in terms of interrupt, softirq, and preemption
  * disabling.
  */
-static void rcu_preempt_deferred_qs(struct task_struct *t)
+notrace static void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
 
-- 
2.25.1

