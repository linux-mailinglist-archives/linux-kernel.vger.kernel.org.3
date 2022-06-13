Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F5549C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiFMSyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbiFMSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:53:08 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF53F3FB1;
        Mon, 13 Jun 2022 08:55:00 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id D85A3431EE;
        Mon, 13 Jun 2022 11:54:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135697;
        bh=1WTAP0DvTsx/f1U86SK5DcklsETF7q/oXSjix4YMTg8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SOFnSCj2/Uco+m8cqk1mnjn23PpGTwCRrx0c9ki6JFsuKnWLhivKogpDrVSaf2BRu
         P6gs8i/eGOQP2f4yv4GYeyLlo4FtDeiClqr28sRi8dcbJnPUOwa/YtWbEpRLvlVKa6
         oRWO73BJMTStkY6qfqgaItjMFoQb1S3BkcNbz1dOgNJoiu5vfG1yF2TsUgsStX4BpK
         UYDhRYtfYNNQ27owcSaNqQZ1dopnXR/UdUXVKVtMdPyj1w3ua95OJv2pqjcAPnkZck
         iT03cDl1ISvnZpCO/kLRqO/9Bd7qaluvtuQ25PHWM00QsLsD2PwPM0vdBEMC4iyHje
         /IftoWTV96F9g==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:41 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 13/20] block, blksnap: event queue from the difference storage
Date:   Mon, 13 Jun 2022 18:53:06 +0300
Message-ID: <1655135593-1900-14-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A536D7766
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides transmission of events from the difference storage to the user
process. Only two events are currently defined. The first is that there
are few free regions in the difference storage. The second is that the
request for a free region for storing differences failed with an error,
since there are no more free regions left in the difference storage
(the snapshot overflow state).

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/event_queue.c | 90 +++++++++++++++++++++++++++++
 drivers/block/blksnap/event_queue.h | 64 ++++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 drivers/block/blksnap/event_queue.c
 create mode 100644 drivers/block/blksnap/event_queue.h

diff --git a/drivers/block/blksnap/event_queue.c b/drivers/block/blksnap/event_queue.c
new file mode 100644
index 000000000000..abf0a584ae40
--- /dev/null
+++ b/drivers/block/blksnap/event_queue.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-event_queue: " fmt
+#include <linux/slab.h>
+#include <linux/sched.h>
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "event_queue.h"
+
+void event_queue_init(struct event_queue *event_queue)
+{
+	INIT_LIST_HEAD(&event_queue->list);
+	spin_lock_init(&event_queue->lock);
+	init_waitqueue_head(&event_queue->wq_head);
+}
+
+void event_queue_done(struct event_queue *event_queue)
+{
+	struct event *event;
+
+	spin_lock(&event_queue->lock);
+	while (!list_empty(&event_queue->list)) {
+		event = list_first_entry(&event_queue->list, struct event,
+					 link);
+		list_del(&event->link);
+		event_free(event);
+	}
+	spin_unlock(&event_queue->lock);
+}
+
+int event_gen(struct event_queue *event_queue, gfp_t flags, int code,
+	      const void *data, int data_size)
+{
+	struct event *event;
+
+	event = kzalloc(sizeof(struct event) + data_size, flags);
+	if (!event)
+		return -ENOMEM;
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	memory_object_inc(memory_object_event);
+#endif
+	event->time = ktime_get();
+	event->code = code;
+	event->data_size = data_size;
+	memcpy(event->data, data, data_size);
+
+	pr_debug("Generate event: time=%lld code=%d data_size=%d\n",
+		 event->time, event->code, event->data_size);
+
+	spin_lock(&event_queue->lock);
+	list_add_tail(&event->link, &event_queue->list);
+	spin_unlock(&event_queue->lock);
+
+	wake_up(&event_queue->wq_head);
+	return 0;
+}
+
+struct event *event_wait(struct event_queue *event_queue,
+			 unsigned long timeout_ms)
+{
+	int ret;
+
+	ret = wait_event_interruptible_timeout(event_queue->wq_head,
+					       !list_empty(&event_queue->list),
+					       timeout_ms);
+
+	if (ret > 0) {
+		struct event *event;
+
+		spin_lock(&event_queue->lock);
+		event = list_first_entry(&event_queue->list, struct event,
+					 link);
+		list_del(&event->link);
+		spin_unlock(&event_queue->lock);
+
+		pr_debug("Event received: time=%lld code=%d\n", event->time,
+			 event->code);
+		return event;
+	}
+	if (ret == 0)
+		return ERR_PTR(-ENOENT);
+
+	if (ret == -ERESTARTSYS) {
+		pr_debug("event waiting interrupted\n");
+		return ERR_PTR(-EINTR);
+	}
+
+	pr_err("Failed to wait event. errno=%d\n", abs(ret));
+	return ERR_PTR(ret);
+}
diff --git a/drivers/block/blksnap/event_queue.h b/drivers/block/blksnap/event_queue.h
new file mode 100644
index 000000000000..27d4b90a9f1d
--- /dev/null
+++ b/drivers/block/blksnap/event_queue.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#include <linux/types.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+
+/**
+ * struct event - An event to be passed to the user space.
+ * @link:
+ *	The list header allows to combine events from the queue.
+ * @time:
+ *	A timestamp indicates when an event occurred.
+ * @code:
+ *	Event code.
+ * @data_size:
+ *	The number of bytes in the event data array.
+ * @data:
+ *	An array of event data.
+ *
+ * Events can be different, so they contain different data. The size of the
+ * data array is not defined exactly, but it has limitations. The size of
+ * the event structure may exceed the PAGE_SIZE.
+ */
+struct event {
+	struct list_head link;
+	ktime_t time;
+	int code;
+	int data_size;
+	char data[1]; /* up to PAGE_SIZE - sizeof(struct blk_snap_snapshot_event) */
+};
+
+/**
+ * struct event_queue - A queue of &struct event.
+ * @list:
+ *	Linked list for storing events.
+ * @lock:
+ *	Spinlock allows to guarantee safety of the linked list.
+ * @wq_head:
+ *	A wait queue allows to put a user thread in a waiting state until
+ *	an event appears in the linked list.
+ */
+struct event_queue {
+	struct list_head list;
+	spinlock_t lock;
+	struct wait_queue_head wq_head;
+};
+
+void event_queue_init(struct event_queue *event_queue);
+void event_queue_done(struct event_queue *event_queue);
+
+int event_gen(struct event_queue *event_queue, gfp_t flags, int code,
+	      const void *data, int data_size);
+struct event *event_wait(struct event_queue *event_queue,
+			 unsigned long timeout_ms);
+static inline void event_free(struct event *event)
+{
+	kfree(event);
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+	if (event)
+		memory_object_dec(memory_object_event);
+#endif
+};
-- 
2.20.1

