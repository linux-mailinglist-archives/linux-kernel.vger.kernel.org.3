Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5955944D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiFXHnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXHm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:42:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3128120AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656056577; x=1687592577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RfyrWIIDa4w9dz4gyd2U2zmHYdad2jtAHPjANf5neDw=;
  b=i7B5IltNEA/c4ba0NY/I4VsPf93t4cTa1w/JZ9kUKcL6XWCf+h5YU8gE
   n7vhQp+oZe+SKtKvde1m9h6ZPLPQnkQX7ZaN6rGvNHVq5wYHayt0/0npS
   0sfnIJ2qhjB7PT+wZYvPFbyZfQzavY2KmE269Ziva7oV67JWDhtTUG38l
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 00:42:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 00:42:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 00:42:56 -0700
Received: from hu-satyap-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 00:42:56 -0700
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>
CC:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: fix rq lock recursion issue
Date:   Fri, 24 Jun 2022 00:42:40 -0700
Message-ID: <20220624074240.13108-1-quic_satyap@quicinc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below recursion is observed in a rare scenario where __schedule()
takes rq lock, at around same time task's affinity is being changed,
bpf function for tracing sched_switch calls migrate_enabled(),
checks for affinity change (cpus_ptr != cpus_mask) lands into
__set_cpus_allowed_ptr which tries acquire rq lock and causing the
recursion bug.

Fix the issue by switching to preempt_enable/disable() for non-RT
Kernels.

-010 |spin_bug(lock = ???, msg = ???)
-011 |debug_spin_lock_before(inline)
-011 |do_raw_spin_lock(lock = 0xFFFFFF89323BB600)
-012 |_raw_spin_lock(inline)
-012 |raw_spin_rq_lock_nested(inline)
-012 |raw_spin_rq_lock(inline)
-012 |task_rq_lock(p = 0xFFFFFF88CFF1DA00, rf = 0xFFFFFFC03707BBE8)
-013 |__set_cpus_allowed_ptr(inline)
-013 |migrate_enable()
-014 |trace_call_bpf(call = ?, ctx = 0xFFFFFFFDEF954600)
-015 |perf_trace_run_bpf_submit(inline)
-015 |perf_trace_sched_switch(__data = 0xFFFFFFE82CF0BCB8, preempt = FALSE, prev = ?, next = ?)
-016 |__traceiter_sched_switch(inline)
-016 |trace_sched_switch(inline)
-016 |__schedule(sched_mode = ?)
-017 |schedule()
-018 |arch_local_save_flags(inline)
-018 |arch_irqs_disabled(inline)
-018 |__raw_spin_lock_irq(inline)
-018 |_raw_spin_lock_irq(inline)
-018 |worker_thread(__worker = 0xFFFFFF88CE251300)
-019 |kthread(_create = 0xFFFFFF88730A5A80)
-020 |ret_from_fork(asm)

Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
---
 kernel/sched/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfa7452ca92e..e254e9227341 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2223,6 +2223,7 @@ static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 
 void migrate_disable(void)
 {
+#ifdef CONFIG_PREEMPT_RT
 	struct task_struct *p = current;
 
 	if (p->migration_disabled) {
@@ -2234,11 +2235,15 @@ void migrate_disable(void)
 	this_rq()->nr_pinned++;
 	p->migration_disabled = 1;
 	preempt_enable();
+#else
+	preempt_disable();
+#endif
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
 
 void migrate_enable(void)
 {
+#ifdef CONFIG_PREEMPT_RT
 	struct task_struct *p = current;
 
 	if (p->migration_disabled > 1) {
@@ -2265,6 +2270,9 @@ void migrate_enable(void)
 	p->migration_disabled = 0;
 	this_rq()->nr_pinned--;
 	preempt_enable();
+#else
+	preempt_enable();
+#endif
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
-- 
2.36.1

