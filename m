Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A1536D53
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 16:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbiE1Onh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 10:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiE1Ong (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 10:43:36 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A14D140C1
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cm0sC
        7DsxYFcYZwdu+XcBc/NM+JngXDXLDnGMoBREK4=; b=IgatDGFseGjnVsgukh6eE
        XaBKRLezndgSJ80VxVrGFopHbu5FmaqMn5In7sA2fXBxbgPJOBAYwsOw1oP2UG3j
        CAqQMztQ0FS7KA2f+yq69TjR5oeYp1XnOBFW2sYZd/1hSDx1hnBRD9xlk/Cp9+i7
        HLgCkgtQK7cQ+HfesOnfQE=
Received: from localhost (unknown [113.89.245.6])
        by smtp13 (Coremail) with SMTP id EcCowABHtlLaNJJiy3DFEw--.201S2;
        Sat, 28 May 2022 22:42:36 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     rostedt@goodmis.org, mingo@redhat.com, dave@stgolabs.net,
        will@kernel.org, peterz@infradead.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Junwen Wu <wudaemon@163.com>
Subject: [PATCH v2] softirq: Add tracepoint for tasklet_entry/exit
Date:   Sat, 28 May 2022 14:42:28 +0000
Message-Id: <20220528144228.46867-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABHtlLaNJJiy3DFEw--.201S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw4kJr1xWr15Gw43Ww4DJwb_yoW8tFW3pa
        sF9ayYkrWrJr42vr13A3WUZr15Zws3GFy7Jrs7GF13Zw1Uur1kta9rtF1jyFW0yr409Fy2
        9a12qry3Cw1kua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMmhF-UUUUU=
X-Originating-IP: [113.89.245.6]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBxxgPbWB0Hw3xQQAAsL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually softirq handler is pre-defined,only tasklet can be register by
driver.We expand tracepoint for tasklet_entry/exit to trace
tasklet handler.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
Changes since v1: https://lore.kernel.org/all/20220508160624.48643-1-wudaemon@163.com/
 - Used DECLARE_EVENT_CLASS (Steven Rostedt)

 include/trace/events/irq.h | 41 ++++++++++++++++++++++++++++++++++++++
 kernel/softirq.c           |  4 ++++
 2 files changed, 45 insertions(+)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafaaea4c..62b7e53121da 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -160,6 +160,47 @@ DEFINE_EVENT(softirq, softirq_raise,
 	TP_ARGS(vec_nr)
 );
 
+DECLARE_EVENT_CLASS(tasklet,
+
+	TP_PROTO(void *func),
+
+	TP_ARGS(func),
+
+	TP_STRUCT__entry(
+		__field(        void*,     func )
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+	),
+
+	TP_printk("function=%ps", __entry->func)
+);
+
+/**
+ * tasklet_entry - called immediately when a tasklet exec
+ * @func: the callback function when a tasklet exec
+ *
+ * When used in combination with the tasklet_entry tracepoint
+ * we can determine the callback function when a tasklet exec.
+ */
+DEFINE_EVENT(tasklet, tasklet_entry,
+
+	TP_PROTO(void *func),
+
+	TP_ARGS(func)
+);
+
+/**
+ * tasklet_exit - called immediately after the tasklet handler returns
+ * @func: the callback function when a tasklet exec
+ */
+DEFINE_EVENT(tasklet, tasklet_exit,
+
+	TP_PROTO(void *func),
+
+	TP_ARGS(func)
+);
 #endif /*  _TRACE_IRQ_H */
 
 /* This part must be outside protection */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f470929e99..79b3814ad166 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -780,10 +780,14 @@ static void tasklet_action_common(struct softirq_action *a,
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
 				if (tasklet_clear_sched(t)) {
+					trace_tasklet_entry(t->use_callback ? (void *)t->callback
+							: (void *)t->func);
 					if (t->use_callback)
 						t->callback(t);
 					else
 						t->func(t->data);
+					trace_tasklet_exit(t->use_callback ? (void *)t->callback
+							: (void *)t->func);
 				}
 				tasklet_unlock(t);
 				continue;
-- 
2.25.1

