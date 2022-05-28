Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31105536D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 15:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiE1Nzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 09:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiE1Nzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 09:55:31 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B63E7283
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GsSYc
        +fe6QdvZyYkZ6XY8VfsUlV3aCJmso5J7Wnq8n8=; b=cnm9VPEpBN2pmgJOlRk9G
        zZ1YxCxw+M2ee5r7QXIO2ygxIjVcWMa+6JFW8ZxRdS67xx2BqzFw/FWEp0MWUuTQ
        mSXFTj2daDiFxEbT9vWvQPOmtdLz3xreg5IRdIAWUVO0iKTUKraAkvD4i8RDrV/u
        m+iI9LJLqTIbd+BnJKDI4o=
Received: from localhost (unknown [113.89.247.110])
        by smtp12 (Coremail) with SMTP id EMCowABn+1yTKZJirHDyAA--.14079S2;
        Sat, 28 May 2022 21:54:28 +0800 (CST)
From:   Junwen Wu <wudaemon@163.com>
To:     rostedt@goodmis.org, Junwen Wu <wudaemon@163.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tannerlove@google.com, tglx@linutronix.de
Subject: Re: [PATCH v1] softirq: Add tracepoint for tasklet_entry/exit
Date:   Sat, 28 May 2022 13:54:11 +0000
Message-Id: <20220524210709.3f0ddc3a@gandalf.local.home> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508160624.48643-1-wudaemon@163.com>
References: <20220524210709.3f0ddc3a@gandalf.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowABn+1yTKZJirHDyAA--.14079S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW7Wryxuw4fZF47Wr15urg_yoW5Xw47pa
        sF9ayYkrZ5Jr42vr13A3WUAr15Zws3GFy7Jrs7W3W3Zw1Uur1kt39rt3WjyFW0yr4F9Fy2
        9a1aqry3u34kua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRLvtXUUUUU=
X-Originating-IP: [113.89.247.110]
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBxxUPbWB0Hw0dbAAAsH
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

From: Steven Rostedt <rostedt@goodmis.org>

>> +
>> +	TP_printk("function=%ps", __entry->func)

>This needs an acked-by from Thomas, but regardless, the above two trace
>events are identical. You need to have a DECLARE_EVENT_CLASS() followed by
>two DEFINE_EVENT()s, otherwise you are wasting memory.

I have use DECLARE_EVENT_CLASS() define use tracepoint,Steve.
Thomas, can you give me acked-by,here is patch v2.


From 68d2298372018ec90c8587d5421a0e1a3c9f879f Mon Sep 17 00:00:00 2001
From: Junwen Wu <wudaemon@163.com>
Date: Sun, 8 May 2022 15:29:56 +0000
Subject: [PATCH v2] softirq: Add tracepoint for tasklet_entry/exit

Usually softirq handler is pre-defined,only tasklet can be register by
driver.We expand tracepoint for tasklet_entry/exit to trace
tasklet handler.

Signed-off-by: Junwen Wu <wudaemon@163.com>
---
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
+       TP_PROTO(void *func),
+
+       TP_ARGS(func),
+
+       TP_STRUCT__entry(
+               __field(        void*,     func )
+       ),
+
+       TP_fast_assign(
+               __entry->func = func;
+       ),
+
+       TP_printk("function=%ps", __entry->func)
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
+       TP_PROTO(void *func),
+
+       TP_ARGS(func)
+);
+
+/**
+ * tasklet_exit - called immediately after the tasklet handler returns
+ * @func: the callback function when a tasklet exec
+ */
+DEFINE_EVENT(tasklet, tasklet_exit,
+
+       TP_PROTO(void *func),
+
+       TP_ARGS(func)
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
+                                       trace_tasklet_entry(t->use_callback ? (void *)t->callback
+                                                       : (void *)t->func);
                                        if (t->use_callback)
                                                t->callback(t);
                                        else
                                                t->func(t->data);
+                                       trace_tasklet_exit(t->use_callback ? (void *)t->callback
+                                                       : (void *)t->func);
                                }
                                tasklet_unlock(t);
                                continue;
--
2.25.1

