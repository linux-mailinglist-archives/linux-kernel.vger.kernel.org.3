Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C277A51EED2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiEHQM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiEHQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:12:22 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0B7A264D
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9xhe1
        TpWpUHgTAUGhKM8bXnmGiRbvfK7a5SuRwyL/l0=; b=kE+CE//EPbRPkrujhHKJl
        ObOczwB2hAkBbOnxTyzvFlORQYbPjwvHqH/LPNynuU09OGSqWnjcUteoPmlDotMv
        ezdNABB2g1pOEHjbXM0Rm9avF6Tk5TipJjAsa+MatbEzGb9Rc46mz75QAFF7piaS
        JtePeVGHrHILARgNNX8AbA=
Received: from localhost (unknown [113.89.246.196])
        by smtp7 (Coremail) with SMTP id C8CowAA3GrCI6ndiKd0cBg--.17208S2;
        Mon, 09 May 2022 00:06:33 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     rostedt@goodmis.org, mingo@redhat.com, tglx@linutronix.de,
        frederic@kernel.org, tannerlove@google.com, wudaemon@163.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] softirq: Add tracepoint for tasklet_entry/exit
Date:   Sun,  8 May 2022 16:06:24 +0000
Message-Id: <20220508160624.48643-1-wudaemon@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAA3GrCI6ndiKd0cBg--.17208S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw4kJr1xXFyxJw43Gw17Wrg_yoW8AFy3pa
        4qkFya9rWrJr429r4fA3WUAF15Zwn3CF9rGrs7G3W3Ar4xXr1ktwsFqF1qyayktr409r9F
        9FnIqrW3Cw1kua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zM5l19UUUUU=
X-Originating-IP: [113.89.246.196]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBxwn6bWB0HLyHFwAAs9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
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
 include/trace/events/irq.h | 32 ++++++++++++++++++++++++++++++++
 kernel/softirq.c           |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafaaea4c..d3e922dcd475 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -160,6 +160,38 @@ DEFINE_EVENT(softirq, softirq_raise,
 	TP_ARGS(vec_nr)
 );
 
+TRACE_EVENT(tasklet_entry,
+
+	TP_PROTO(void *func),
+
+	TP_ARGS(func),
+
+	TP_STRUCT__entry(
+		__field(        void *,    func          )
+	),
+
+	TP_fast_assign(
+	__entry->func = func;
+	),
+
+	TP_printk("function=%ps", __entry->func)
+);
+TRACE_EVENT(tasklet_exit,
+
+	TP_PROTO(void *func),
+
+	TP_ARGS(func),
+
+	TP_STRUCT__entry(
+		__field(        void *,    func          )
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+	),
+
+	TP_printk("function=%ps", __entry->func)
+);
 #endif /*  _TRACE_IRQ_H */
 
 /* This part must be outside protection */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f470929e99..b3bce2b3b655 100644
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

