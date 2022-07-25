Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7933857F9A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiGYGxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiGYGxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B6910FFB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:53:16 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220725065311epoutp04056bf09bb155ae7b3b2573d769e50253~E--VEgq_M0685006850epoutp04g
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220725065311epoutp04056bf09bb155ae7b3b2573d769e50253~E--VEgq_M0685006850epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658731991;
        bh=IGDWHVYiT7zLw/RUcYT4G2NS9SOc2hc90t7MvRAEEgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MALnqRx7LdCIogdNwuf/32LYA6HmjFiENsNF7Po/9T/U2E/AmtQmr5OUlTvAl+Ffy
         j/xjWl+eBKmVaO6gZNzAcLOYKvlZUsz9BB8J8U6bEOIWedJConwEVIsPOIOMK0VgaQ
         IcUfrnRZbZRw8xkC74jQe95+XI8tURIkU3O4bwZk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220725065311epcas1p35d5d817f662d9f535ea129a67ee3bf26~E--U0Jxo72805428054epcas1p3q;
        Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.237]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LrrN61k92z4x9Q2; Mon, 25 Jul
        2022 06:53:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.BE.09678.6DD3ED26; Mon, 25 Jul 2022 15:53:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epcas1p42ba84c5241d69192ea73904ed6af17d7~E--TLHamw0810408104epcas1p48;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220725065309epsmtrp12be707269d49ef709413f9d9fe10abf7~E--TKdB6f0382103821epsmtrp1s;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
X-AuditID: b6c32a39-e67ff700000025ce-c8-62de3dd6cc48
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.B6.08802.5DD3ED26; Mon, 25 Jul 2022 15:53:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epsmtip22a0640da8f71186d70180c31feb34801~E--S8v1qC2537425374epsmtip2V;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com,
        Jiho Chu <jiho.chu@samsung.com>
Subject: [PATCH 4/9] trinity: Add schduler module
Date:   Mon, 25 Jul 2022 15:53:03 +0900
Message-Id: <20220725065308.2457024-5-jiho.chu@samsung.com>
In-Reply-To: <20220725065308.2457024-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmvu4123tJBgdvcFr8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzpix9BFzwet2
        xorOd6+ZGxiv53cxcnJICJhIHN06j7mLkYtDSGAHo0T38vVMEM4nRomnf44yQjifGSUOzXjD
        BtNyf0YnO0RiF6PEzastLHBVx/4/BKtiE1CVmDljDTuILSLgLTG/tQtoLgcHs0CkxLUVVSBh
        YQFDialv1jGC2CxA5ef7msFaeQWsJTaf3c0KYnMK2Egs+LGbGSIuKHFy5hMWEJtZQF6ieets
        sLslBM6xS1x/8ZcdZL6EgIvEy0UhEIcKS7w6voUdwpaSeNnfBmVnS0zpWMQCYRdInHu+lRmi
        1Vji4ooUiCs1Jdbv0oeoUJTY+XsuI8RWPol3X3tYIap5JTrahCBKlCSW/DkMNVxCYuqMb0wQ
        todE1+tLYK1CAv2MEpu7Sicwys9C8sssJL/MQli8gJF5FaNYakFxbnpqsWGBKTxOk/NzNzGC
        k5+W5Q7G6W8/6B1iZOJgPMQowcGsJMLblXY7SYg3JbGyKrUoP76oNCe1+BCjKTB0JzJLiSbn
        A9NvXkm8oYmlgYmZkbGJhaGZoZI476pppxOFBNITS1KzU1MLUotg+pg4OKUamBbuT/jGM8/9
        +W2OmU7HNnlsWDtDh/n7ouojP9lZYrsXK5pdWNG996/a7wfiIYzrPd9V71rWv+2e1My7b1al
        nDqZOj2w5t+6V3c+dVQqa0713JHWpfd/x2a76S/fvpmvfnpr5q5X8b7c8jH1/48cuXjWqC+l
        9hv32kkZrxNn2txIXLju5OYDJRdWmF+InZ7H9Xr5+ruKLJkLMtr3XFjz6uPipSz8xbqz5j+f
        q2y9NnLu8zctTzh/uktwubGUmX9cs1lv3T1hsepmkSZ1ZrXHcyTznxRKPGJsygns8pK93PCd
        VXrB/F5L3WitL/r3cnv4ZnNm7N789NTcGw+ONdvtNss1cY0vPfjs7QTlY8Gu0UffK7EUZyQa
        ajEXFScCAHfZXG0HBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvO5V23tJBl/2Klj8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKmLH0EXPB63bGis53r5kbGK/ndzFyckgImEjcn9HJ3sXIxSEksINRYvb0H4wQCQmJ
        TfeWM3cxcgDZwhKHDxdD1HxklNj75BgrSA2bgKrEzBlr2EFsEQF/ib+fIOLMAtESq7fdZwGx
        hQUMJaa+WQc2kwWo/nxfMxuIzStgLbH57G6wek4BG4kFP3Yzg9hCQPH+rhOsEDWCEidnPmGB
        mCkv0bx1NvMERv5ZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIDlUt
        rR2Me1Z90DvEyMTBeIhRgoNZSYS3K+12khBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE
        0hNLUrNTUwtSi2CyTBycUg1MXbPsDGa0dOYsSA7hSy74dTbi5wPX1hdae59E7Vh8qeHv/GVf
        7C5dX1UkyvRtt1WnoU3Pn4dtc39tXmVhUWrkx+Ua+OKHb7Tz1CWiRT1BPoI1fYbvNBzn6+b8
        NnMzN2tfH3hu63GzY7Uax10/CYlJMGoZMFftOsqpxSnmsGb95bpFYssdey+br/+8LdF0/iJv
        7qNzXFh8q3U/3H0sWuf5rEl7SVBxyQpNFXYO2an2RjdexGzPMPj0eIFBl37n6SC52up0w+Vt
        2xcebs6XXHj/i09cZ+yT042VgjmzY07Hrnq2aNL5x5f3LFS2q9zz33Tpa96z97s1+3dnl32M
        2btnmfGt/jVNHu6zlWvFJPKUWIozEg21mIuKEwGS+xhOxAIAAA==
X-CMS-MailID: 20220725065309epcas1p42ba84c5241d69192ea73904ed6af17d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065309epcas1p42ba84c5241d69192ea73904ed6af17d7
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065309epcas1p42ba84c5241d69192ea73904ed6af17d7@epcas1p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes NPU scheduler interface.

Tasks can be pushed to the NPU in order by the scheduler. The default
schduling algorithm is provided using Priority policy.
The scheduler waits request from the user. When the requests are
invoked, it submits each request to the NPU by the priority, and waits
until complete interrupt arrives. The priority is calculated with
remained time to requested timeout.

Thus the scheduler algorithm may be added more in the later, it
provides an interface which can support various schedulers.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/Makefile         |   1 +
 drivers/misc/trinity/sched/core.c     | 170 +++++++++++++
 drivers/misc/trinity/sched/priority.c | 335 ++++++++++++++++++++++++++
 drivers/misc/trinity/sched/priority.h |  18 ++
 drivers/misc/trinity/sched/sched.h    |  52 ++++
 5 files changed, 576 insertions(+)
 create mode 100644 drivers/misc/trinity/sched/core.c
 create mode 100644 drivers/misc/trinity/sched/priority.c
 create mode 100644 drivers/misc/trinity/sched/priority.h
 create mode 100644 drivers/misc/trinity/sched/sched.h

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index cf313c3afb3d..dcf9d7ad1b4b 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
 
 trinity-y := trinity.o
 trinity-y += trinity_resv_mem.o trinity_hwmem.o
+trinity-y += sched/core.o sched/priority.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/sched/core.c b/drivers/misc/trinity/sched/core.c
new file mode 100644
index 000000000000..2d94f5d07e8b
--- /dev/null
+++ b/drivers/misc/trinity/sched/core.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NPU scheduler interface
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/spinlock.h>
+
+#include "../trinity_common.h"
+#include "sched.h"
+#include "priority.h"
+
+static struct trinity_sched_desc *sched_table[SCHED_END];
+static DEFINE_SPINLOCK(sched_lock);
+
+/**
+ * trinity_sched_register() - Register trinity task scheduler
+ *   It does nothing if it is already registered.
+ *
+ * @type: scheduler type
+ * @desc: scheduler description
+ */
+void trinity_sched_register(enum trinity_sched_type type,
+			    struct trinity_sched_desc *desc)
+{
+	if (type >= SCHED_END)
+		return;
+
+	spin_lock(&sched_lock);
+	if (!sched_table[type])
+		sched_table[type] = desc;
+	spin_unlock(&sched_lock);
+}
+
+/**
+ * trinity_sched_unregister() - Unregister trinity task scheduler
+ *
+ * @type: scheduler type
+ * @desc: scheduler description
+ */
+void trinity_sched_unregister(enum trinity_sched_type type,
+			      struct trinity_sched_desc *desc)
+{
+	if (type >= SCHED_END)
+		return;
+
+	spin_lock(&sched_lock);
+	if (sched_table[type] == desc)
+		sched_table[type] = NULL;
+	spin_unlock(&sched_lock);
+}
+
+/**
+ * trinity_sched_find() - Find trinity task scheduler
+ *
+ * @type: scheduler type
+ * Return: trinity scheduler description on Success, Otherwise return NULL.
+ */
+struct trinity_sched_desc *trinity_sched_find(enum trinity_sched_type type)
+{
+	struct trinity_sched_desc *desc;
+	unsigned long flags;
+
+	if (type >= SCHED_END)
+		return NULL;
+
+	spin_lock_irqsave(&sched_lock, flags);
+	desc = sched_table[type];
+	spin_unlock_irqrestore(&sched_lock, flags);
+
+	return desc;
+}
+
+/**
+ * trinity_sched_run_req() - Schedules a req to the target from the req queue
+ *
+ * @req_data: The data ptr to hold req information to be submitted.
+ *
+ * Return: 0 on success. Otherwise, returns negative error. Additional status of
+ * the submitted req could be passed by req->status.
+ */
+int32_t trinity_sched_run_req(void *req_data, void *sched_data)
+{
+	struct trinity_req *req = (struct trinity_req *)req_data;
+	struct trinity_driver *drv = req->drv;
+	int32_t err = 0;
+	int32_t ready;
+
+	/** setup is only allowed in ready state */
+	ready = drv->desc->get_state(drv);
+	if (ready != TRINITY_STATE_READY) {
+		dev_err(drv_to_dev_ptr(drv),
+			"Cannot setup NPU when it's in a non-ready state");
+		err = -EPERM;
+		goto out;
+	}
+
+	if (req->stat->status != TRINITY_REQ_STATUS_PENDING &&
+	    req->stat->status != TRINITY_REQ_STATUS_FINISHED) {
+		dev_err(drv_to_dev_ptr(drv), "Invalid req status: %d",
+			req->stat->status);
+		err = -EINVAL;
+		goto out;
+	}
+
+	req->stat->status = TRINITY_REQ_STATUS_RUNNING;
+	err = drv->desc->invoke_req(drv, req, sched_data);
+out:
+	if (err != 0)
+		req->stat->status = TRINITY_REQ_STATUS_ERROR;
+
+	return err;
+}
+
+/**
+ * trinity_sched_suspend() - Suspend whole task schedulers
+ */
+void trinity_sched_suspend(void)
+{
+	enum trinity_sched_type type;
+	struct trinity_sched_desc *desc;
+
+	for (type = SCHED_PRI; type < SCHED_END; type++) {
+		desc = sched_table[type];
+		if (desc)
+			desc->suspend();
+	}
+}
+
+/**
+ * trinity_sched_suspend() - Resume whole task schedulers
+ */
+void trinity_sched_resume(void)
+{
+	enum trinity_sched_type type;
+	struct trinity_sched_desc *desc;
+
+	for (type = SCHED_PRI; type < SCHED_END; type++) {
+		desc = sched_table[type];
+		if (desc)
+			desc->resume();
+	}
+}
+
+/**
+ * trinity_sched_init() - Initialize trinity task schedulers
+ *
+ * @dev: an instance of the device
+ * Return: always returns 0
+ */
+int32_t trinity_sched_init(struct device *dev)
+{
+	if (trinity_sched_init_pri(dev) < 0)
+		dev_warn(dev, "Unable to initialize SR task scheduler");
+
+	return 0;
+}
+
+/**
+ * trinity_sched_exit() - Exit trinity task schedulers
+ */
+void trinity_sched_exit(void)
+{
+	trinity_sched_exit_pri();
+}
diff --git a/drivers/misc/trinity/sched/priority.c b/drivers/misc/trinity/sched/priority.c
new file mode 100644
index 000000000000..3d27c84ff0ba
--- /dev/null
+++ b/drivers/misc/trinity/sched/priority.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NPU scheduler follows priority policy
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+
+#include "../trinity_common.h"
+#include "sched.h"
+
+#define get_dev_ptr() (g_sched_priv.dev)
+
+struct trinity_sched_priv {
+	struct device *dev;
+	struct llist_head req_queue;
+	wait_queue_head_t wait_queue;
+	struct task_struct *sched_thread;
+	struct mutex lock;
+	unsigned long suspended;
+};
+
+static struct trinity_sched_priv g_sched_priv;
+
+/**
+ * sched_calc_pri() - Calculate priority using timeout
+ */
+static unsigned long sched_calc_pri(struct trinity_req *req)
+{
+	ktime_t elapsed_time;
+	int64_t priority;
+
+	if (req->input.config.timeout_ms == 0)
+		return 0; /** @todo need preemption */
+
+	elapsed_time = ktime_to_ms(ktime_sub(ktime_get(), req->time_started));
+	WARN_ON(elapsed_time < 0);
+
+	/**
+	 * if the elapsed time exceeds the timeout of req,
+	 * its priority value is set to the minimum (highest).
+	 */
+	priority = req->input.config.timeout_ms - elapsed_time;
+	if (priority < 0)
+		priority = 0;
+
+	return priority;
+}
+
+/**
+ * sched_pick_req() - Pick the top-priority request from request queue
+ */
+static struct trinity_req *sched_pick_req(struct llist_head *queue)
+{
+	struct trinity_req *req, *req_prev;
+	struct trinity_req *top_req, *top_req_prev;
+	int64_t top_priority = S64_MAX;
+	unsigned long priority;
+
+	if (llist_empty(queue))
+		return NULL;
+
+	req = req_prev = NULL;
+	top_req = top_req_prev = NULL;
+
+	/**
+	 * llist is not a double linked list, and sorting is not easy
+	 * because llist provides only limited APIs.
+	 * it could be better than sorting if there are a few pending reqs.
+	 * Note that each user application can submit only one req at once.
+	 */
+	llist_for_each_entry(req, queue->first, llist) {
+		priority = sched_calc_pri(req);
+		if (top_priority > priority) {
+			top_priority = priority;
+			top_req = req;
+			top_req_prev = req_prev;
+		}
+
+		req_prev = req;
+	}
+
+	if (top_req_prev) {
+		WARN_ON(!top_req);
+		top_req_prev->llist.next = top_req->llist.next;
+	} else {
+		/** it's first entry */
+		top_req = llist_entry(llist_del_first(queue), typeof(*(req)),
+				      llist);
+	}
+
+	return top_req;
+}
+
+/**
+ * llist_last() - Get latest node from list
+ */
+static struct llist_node *llist_last(struct llist_node *first)
+{
+	struct llist_node *last = first;
+
+	while (first && first->next) {
+		last = first->next;
+		first = last;
+	}
+
+	return last;
+}
+
+/**
+ * sched_thread_func() - Scheduler thread function
+ */
+static int sched_thread_func(void *data)
+{
+	const unsigned long MAX_RETRY_COUNT = 100;
+
+	struct llist_head local_queue;
+	struct llist_node *new_first;
+
+	init_llist_head(&local_queue);
+repeat:
+	if (kthread_should_stop())
+		return 0;
+
+	/** extract requests from global queue without locking */
+	new_first = llist_del_all(&g_sched_priv.req_queue);
+	/** new and pending requests could be located together */
+	if (new_first) {
+		struct llist_node *new_last = llist_last(new_first);
+
+		llist_add_batch(new_first, new_last, &local_queue);
+	}
+
+	/** flush requests in the queue */
+	while (!llist_empty(&local_queue)) {
+		struct trinity_req *req;
+		int32_t ret;
+
+		/**
+		 * pick the top-priority request from the queue.
+		 * first and last node pointers are updated
+		 */
+		req = sched_pick_req(&local_queue);
+		if (!req)
+			goto repeat;
+
+		mutex_lock(&g_sched_priv.lock);
+		ret = trinity_sched_run_req(req, NULL);
+		mutex_unlock(&g_sched_priv.lock);
+
+		/** do not modify or access for 'req' except on an error case.
+		 *  it could be released by the interrupt.
+		 */
+
+		if (ret == -EBUSY) {
+			if (req->submit_retry >= MAX_RETRY_COUNT) {
+				/** give up to handling this req*/
+				complete_all(&req->complete);
+			} else {
+				req->submit_retry++;
+				/** push again and restart the loop */
+				llist_add(&req->llist, &local_queue);
+			}
+			goto repeat;
+		} else if (ret != 0) {
+			/** let's notify this unknown error */
+			complete_all(&req->complete);
+		}
+	}
+
+	/** ensure the local queue is empty */
+	WARN_ON(!llist_empty(&local_queue));
+
+	wait_event_interruptible(
+		g_sched_priv.wait_queue,
+		kthread_should_stop() ||
+			!llist_empty(&(g_sched_priv.req_queue)));
+	goto repeat;
+}
+
+/**
+ * sched_ready() - Check scheduler is ready
+ */
+static bool sched_ready(void)
+{
+	return (test_bit(1, &g_sched_priv.suspended) != 1);
+}
+
+/**
+ * sched_submit() - Submit request to scheduler
+ */
+static int32_t sched_submit(void *data)
+{
+	struct trinity_req *req = data;
+
+	if (!req)
+		return -EINVAL;
+
+	if (!sched_ready())
+		return -EAGAIN;
+
+	llist_add(&req->llist, &g_sched_priv.req_queue);
+	wake_up(&g_sched_priv.wait_queue);
+
+	return 0;
+}
+
+/**
+ * sched_notify() - finishes and notify the request handled
+ */
+static void sched_notify(void *data, bool error)
+{
+	struct trinity_req *req = data;
+
+	req->scheduled = false;
+}
+
+/**
+ * sched_suspend() - Suspend scheduler
+ */
+static void sched_suspend(void)
+{
+	if (!test_and_set_bit(1, &g_sched_priv.suspended))
+		mutex_lock(&g_sched_priv.lock);
+}
+
+/**
+ * sched_resume() - Resume scheduler
+ */
+static void sched_resume(void)
+{
+	if (test_and_clear_bit(1, &g_sched_priv.suspended))
+		mutex_unlock(&g_sched_priv.lock);
+}
+
+static struct trinity_sched_desc trinity_sched_pri = {
+	.ready = sched_ready,
+	.submit = sched_submit,
+	.notify = sched_notify,
+	.suspend = sched_suspend,
+	.resume = sched_resume,
+};
+
+/**
+ * sched_open() - Open scheduler
+ */
+static int sched_open(struct inode *inodep, struct file *filp)
+{
+	return 0;
+}
+
+/**
+ * sched_open() - Release scheduler
+ */
+static int sched_release(struct inode *inodep, struct file *filp)
+{
+	return 0;
+}
+
+static const struct file_operations sched_fops = {
+	.owner = THIS_MODULE,
+	.open = sched_open,
+	.release = sched_release,
+	.llseek = no_llseek,
+};
+
+static struct miscdevice sched_device = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "trinity_sched_pri",
+	.fops = &sched_fops,
+};
+
+/**
+ * sched_init_priv() - Initialize scheduler
+ */
+static int sched_init_priv(void)
+{
+	g_sched_priv.dev = sched_device.this_device;
+
+	init_llist_head(&g_sched_priv.req_queue);
+	init_waitqueue_head(&g_sched_priv.wait_queue);
+
+	g_sched_priv.sched_thread =
+		kthread_run(sched_thread_func, NULL, "trinity_sched_thread");
+	if (IS_ERR(g_sched_priv.sched_thread)) {
+		dev_err(get_dev_ptr(),
+			"Failed to create a thread for scheduling reqs");
+		misc_deregister(&sched_device);
+		return PTR_ERR(g_sched_priv.sched_thread);
+	}
+
+	mutex_init(&g_sched_priv.lock);
+	clear_bit(1, &g_sched_priv.suspended);
+
+	return 0;
+}
+
+/**
+ * trinity_sched_init_pri() - Initialize trinity priority task schedulers
+ *
+ * @dev: an instance of the device
+ */
+int trinity_sched_init_pri(struct device *dev)
+{
+	int err;
+
+	err = misc_register(&sched_device);
+	if (err) {
+		dev_err(dev,
+			"Failed to register a misc device for scheduler\n");
+		return err;
+	}
+
+	trinity_sched_register(SCHED_PRI, &trinity_sched_pri);
+	return sched_init_priv();
+}
+
+/**
+ * trinity_sched_exit_pri() - Exit trinity priority task schedulers
+ */
+void trinity_sched_exit_pri(void)
+{
+	trinity_sched_unregister(SCHED_PRI, &trinity_sched_pri);
+	misc_deregister(&sched_device);
+}
diff --git a/drivers/misc/trinity/sched/priority.h b/drivers/misc/trinity/sched/priority.h
new file mode 100644
index 000000000000..35ac07530496
--- /dev/null
+++ b/drivers/misc/trinity/sched/priority.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * NPU scheduler follows priority policy
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __TRINITY_SCHED_PRI_H__
+#define __TRINITY_SCHED_PRI_H__
+
+int trinity_sched_init_pri(struct device *dev);
+void trinity_sched_exit_pri(void);
+
+#endif /* __TRINITY_SCHED_PRI_H__ */
diff --git a/drivers/misc/trinity/sched/sched.h b/drivers/misc/trinity/sched/sched.h
new file mode 100644
index 000000000000..d13ef5857fc7
--- /dev/null
+++ b/drivers/misc/trinity/sched/sched.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Scheduler I/F header for trinity devices
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __TRINITY_SCHED_H__
+#define __TRINITY_SCHED_H__
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+/**
+ * struct trinity_sched_type - scheduler type
+ */
+enum trinity_sched_type { SCHED_PRI = 0, SCHED_END };
+
+typedef void (*remove_req_cb)(void *data, void *req);
+
+/**
+ * struct trinity_sched_desc - a structure for scheduler description
+ */
+struct trinity_sched_desc {
+	bool (*ready)(void);
+	int32_t (*submit)(void *data);
+	bool (*cancel)(void *data);
+	void (*suspend)(void);
+	void (*resume)(void);
+	void (*notify)(void *data, bool error);
+
+	struct trinity_req *(*find_req)(uint32_t dev_id, int req_id);
+	void (*remove_reqs)(void *data, remove_req_cb cb);
+	void (*test_run)(void *data, int req_id);
+};
+
+struct trinity_sched_desc *trinity_sched_find(enum trinity_sched_type type);
+void trinity_sched_register(enum trinity_sched_type type,
+			    struct trinity_sched_desc *desc);
+void trinity_sched_unregister(enum trinity_sched_type type,
+			      struct trinity_sched_desc *desc);
+int32_t trinity_sched_run_req(void *req_data, void *sched_data);
+void trinity_sched_suspend(void);
+void trinity_sched_resume(void);
+int32_t trinity_sched_init(struct device *dev);
+void trinity_sched_exit(void);
+
+#endif /* __TRINITY_SCHED_H__ */
-- 
2.25.1

