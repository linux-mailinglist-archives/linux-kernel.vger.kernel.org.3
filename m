Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3061F57F9A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiGYGxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiGYGxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:22 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E9910FE5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:53:15 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220725065311epoutp013ba83be2db8793a300a2f146babd1646~E--VFTFoo1626416264epoutp01X
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220725065311epoutp013ba83be2db8793a300a2f146babd1646~E--VFTFoo1626416264epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658731991;
        bh=BvfbnUYB88edyRHCB6/a3SK/d5TWgOI7L2jRkLbdaz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLbToU5L5cHc/Z+qkf3nk2jFLLbhZ15emP8VPll3TqUNo7W0e3rPWrPmGLlsJeRDJ
         k8c5wAHNU4MvQfZD4KI0wHgub8McLVNRiH5GWE/UsAPIfcBGImzr9repS+WKXAHDSY
         54ynZuCSOvpzxfOIovHu4VeWvM+ZeuPjSv/Bx4DE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220725065311epcas1p448f6667b5d68eff0df7a4eafda06f04c~E--UwSY591418414184epcas1p4X;
        Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.235]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LrrN62B7Jz4x9Pw; Mon, 25 Jul
        2022 06:53:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.F3.10203.6DD3ED26; Mon, 25 Jul 2022 15:53:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epcas1p413498a418cbf58570f8009ae7fd91015~E--TYkd-M1418414184epcas1p4K;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220725065309epsmtrp20c8bc16509b3d51e852930e075ff6e78~E--TX28pS0777907779epsmtrp2Q;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
X-AuditID: b6c32a38-597ff700000027db-db-62de3dd6988f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.C2.08905.5DD3ED26; Mon, 25 Jul 2022 15:53:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epsmtip2fb85dbd576127d8dfa2b3f233592ad95~E--TEDS1d2536525365epsmtip2V;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com,
        Jiho Chu <jiho.chu@samsung.com>
Subject: [PATCH 5/9] trinity: Add sysfs debugfs module
Date:   Mon, 25 Jul 2022 15:53:04 +0900
Message-Id: <20220725065308.2457024-6-jiho.chu@samsung.com>
In-Reply-To: <20220725065308.2457024-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmvu4123tJBr/+clv8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzjh6fzpzwcEJ
        LBUbdt1mb2DcsZG5i5GTQ0LARGLqwdmsXYxcHEICOxgl5u86wgbhfGKUWLfjBROE841R4v/R
        aewwLe8ebmKGSOxllNj/5xhUy2dGiTMXNjKCVLEJqErMnLEGrENEwFtifmsX0CgODmaBSIlr
        K6pAwsICZhIvDnYygdgsQOWv1+8Bu4lXwFpi9+6jYDangI3Egh+7oeKCEidnPmEBsZkF5CWa
        t84GO0JC4By7xIs7t9hA5ksIuEi8/10JcaiwxKvjW6COlpL4/G4vG4SdLTGlYxELhF0gce75
        VmaIVmOJiytSIK7UlFi/Sx+iQlFi5++5jBBb+STefe1hhajmlehoE4IoUZJY8ucw1CIJiakz
        vjFB2B4Sq/d8hAZOP6PEz2nXWCcwys9C8swsJM/MQti8gJF5FaNYakFxbnpqsWGBCTxWk/Nz
        NzGCE6CWxQ7GuW8/6B1iZOJgPMQowcGsJMLblXY7SYg3JbGyKrUoP76oNCe1+BCjKTB4JzJL
        iSbnA1NwXkm8oYmlgYmZkbGJhaGZoZI4b+/U04lCAumJJanZqakFqUUwfUwcnFINTAovDB7M
        0GhxVpwarNG89fqdx+wNDrqnTy2YuUHXb44Yp/P8sK0q5q/mHC9R2bGeU611Z5nWZPs9rY3r
        v74QvsXNKr3uYiy37V9Tk4zwJe4fX6xi8furbfagI+mM6TNbxeVuvI1rEhyTd02W/nJW63c7
        c/KF+uLF0jMqchc1Mjnm/1vX9vDg/90qf6qMi3OMil0fu10xN8yJ368ipHLxte7LFQ9Llpxc
        /6+ZzWLSp4IL8xPbyxaffR/d0x1WYz9PVLsrr7xr8/vgb5vqVoYrsXLU/UtnPJy0iX1f1cVd
        F5OtVC/n3otZ9STv0c+Svz9ti3JO2LoF5ifK/43dnvUok2FNhY9G7MElb31ON6WYKrEUZyQa
        ajEXFScCABULMs4JBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO5V23tJBrufaVv8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKOHp/OnPBwQksFRt23WZvYNyxkbmLkZNDQsBE4t3DTUA2F4eQwG5GiS3d7UwQCQmJ
        TfeWAyU4gGxhicOHiyFqPjJKHPoygxWkhk1AVWLmjDXsILaIgL/E30/HwOLMAtESq7fdZwGx
        hQXMJF4c7ASbyQJU/3r9HrDFvALWErt3HwWzOQVsJBb82A1mCwHF+7tOsELUCEqcnPmEBWKm
        vETz1tnMExj5ZyFJzUKSWsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhYtTR3
        MG5f9UHvECMTB+MhRgkOZiUR3q6020lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhP
        LEnNTk0tSC2CyTJxcEo1MC3f5bpn9u21Up3JGVUt12xzHj8oabjVzKrBpSh2oXjNBaWbTMXf
        e+xv1y3j0rRR7T0zf9vsG5c6RVjDTNy5a0q9Z/802qLgy1MasnJp2rmu2PI7bUw/uFbyHjjq
        HeW5k+G7rOXDNYJVQdtdLzroPar6sLbk/5pu1m9BRUv2z7xt9XGp8jmJtnXK+lsE92/1DTE3
        frD01vHbby8KbmM9VMy26ejn01J68+Y6mb7LuRJrs+4Z+78zHdbiD/4vPantxr63VoSV+VvY
        u8fy6wpnuPxdrb3jxoa4fB3vlGl8e1mNf2qEtQo+9pi7tOrLlOnPttit4WBUlotprDweYKky
        3XJ5cdDdhHL56isTZyyUa1diKc5INNRiLipOBACQreMHxQIAAA==
X-CMS-MailID: 20220725065309epcas1p413498a418cbf58570f8009ae7fd91015
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065309epcas1p413498a418cbf58570f8009ae7fd91015
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065309epcas1p413498a418cbf58570f8009ae7fd91015@epcas1p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes debugfs and sysfs interfaces.

It provides NPU's internal statistics and status. The moudles
show each request's status, scheduled time and duration. Also, it can
show total requests and memory usage. The statistics module
helps these calculations.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/Makefile         |   2 +
 drivers/misc/trinity/trinity.c        |  48 ++
 drivers/misc/trinity/trinity_common.h |  22 +
 drivers/misc/trinity/trinity_debug.c  | 358 +++++++++++
 drivers/misc/trinity/trinity_stat.c   | 893 ++++++++++++++++++++++++++
 drivers/misc/trinity/trinity_stat.h   |  56 ++
 drivers/misc/trinity/trinity_sysfs.c  | 864 +++++++++++++++++++++++++
 7 files changed, 2243 insertions(+)
 create mode 100644 drivers/misc/trinity/trinity_debug.c
 create mode 100644 drivers/misc/trinity/trinity_stat.c
 create mode 100644 drivers/misc/trinity/trinity_stat.h
 create mode 100644 drivers/misc/trinity/trinity_sysfs.c

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index dcf9d7ad1b4b..ce3539affbf2 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -5,5 +5,7 @@ obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
 trinity-y := trinity.o
 trinity-y += trinity_resv_mem.o trinity_hwmem.o
 trinity-y += sched/core.o sched/priority.o
+trinity-y += trinity_debug.o
+trinity-y += trinity_sysfs.o trinity_stat.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 4c1b8a7108d6..8f8ade0aff89 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -39,6 +39,11 @@
 
 #define TRINITY_PADDR_BASE (0x0)
 
+#define TRINITY_MODEL_HASH_BITS 10
+#define TRINITY_MODEL_HASH_SIZE (1 << TRINITY_MODEL_HASH_BITS)
+
+static struct hlist_bl_head trinity_model_node_hlist[TRINITY_MODEL_HASH_SIZE];
+
 /* A global lock for shared static variables such as dev_bitmap */
 static DEFINE_SPINLOCK(trinity_lock);
 
@@ -53,6 +58,49 @@ phys_addr_t trinity_get_paddr(struct iommu_domain *domain, dma_addr_t daddr)
 	return TRINITY_PADDR_BASE + daddr;
 }
 
+static uint64_t trinity_gen_model_id(int32_t dbuf_fd)
+{
+	static uint32_t id;
+	uint64_t mid = 0;
+
+	spin_lock(&trinity_lock);
+	if (++id >= (1 << TRINITY_SHIFT_MODEL_ID))
+		id = 0;
+	mid = id;
+	spin_unlock(&trinity_lock);
+
+	mid |= (dbuf_fd << TRINITY_SHIFT_MODEL_ID);
+
+	return mid;
+}
+
+static int32_t trinity_model_id_to_dbuf_fd(uint64_t id)
+{
+	return (id >> TRINITY_SHIFT_MODEL_ID) & UINT_MAX;
+}
+
+static void trinity_model_htable_init(void)
+{
+	int i;
+
+	for (i = 0; i < TRINITY_MODEL_HASH_SIZE; ++i)
+		INIT_HLIST_BL_HEAD(&trinity_model_node_hlist[i]);
+}
+
+/**
+ * trinity_init_model_htable() - Initialize model hash table
+ *
+ * @drv: An instance of the trinity driver
+ * @ht: hash table to be initialized
+ */
+void trinity_init_model_htable(const struct trinity_driver *drv,
+			       struct trinity_model_htable *ht)
+{
+	ht->ht_heads = trinity_model_node_hlist;
+	ht->hash_size = TRINITY_MODEL_HASH_SIZE;
+	ht->hash_bits = TRINITY_MODEL_HASH_BITS;
+}
+
 /**
  * trinity_release() - A common callback for close() in file_operations for a
  *		Trinity	device node. If there are device-specific data to be
diff --git a/drivers/misc/trinity/trinity_common.h b/drivers/misc/trinity/trinity_common.h
index 6940318362f6..c70f66722391 100644
--- a/drivers/misc/trinity/trinity_common.h
+++ b/drivers/misc/trinity/trinity_common.h
@@ -378,6 +378,8 @@ static inline int32_t trinity_get_app_id(void)
 int trinity_create_node(struct trinity_driver *drv);
 void trinity_destroy_node(struct trinity_driver *drv);
 int trinity_wait_ready(struct trinity_driver *drv);
+void trinity_init_model_htable(const struct trinity_driver *drv,
+			       struct trinity_model_htable *ht);
 phys_addr_t trinity_get_paddr(struct iommu_domain *domain, dma_addr_t daddr);
 
 /* File operations */
@@ -390,4 +392,24 @@ int trinity_probe(struct platform_device *pdev,
 int trinity_remove(struct platform_device *pdev,
 		   const struct trinity_desc *desc);
 
+/* sysfs operations */
+int trinity_sysfs_init(struct trinity_driver *drv);
+int trinity_sysfs_cleanup(struct trinity_driver *drv);
+
+/* debugfs operations */
+int trinity_debug_init(void);
+void trinity_debug_exit(void);
+
+int trinity_debug_add(struct trinity_driver *drv);
+void trinity_debug_remove(struct trinity_driver *drv);
+void trinity_debug_clear(struct trinity_driver *drv, unsigned long msg_max);
+unsigned long trinity_debug_get_max(struct trinity_driver *drv);
+void trinity_debug_dump_msg(struct trinity_driver *drv, const char *fmt, ...);
+void trinity_debug_dump_model(struct trinity_driver *drv,
+			      const struct trinity_model *model,
+			      const char *fmt, ...);
+void trinity_debug_dump_input(struct trinity_driver *drv,
+			      const struct trinity_input *input,
+			      const char *fmt, ...);
+
 #endif /* __TRINITY_COMMON_H__ */
diff --git a/drivers/misc/trinity/trinity_debug.c b/drivers/misc/trinity/trinity_debug.c
new file mode 100644
index 000000000000..5b10446eced3
--- /dev/null
+++ b/drivers/misc/trinity/trinity_debug.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Implementation of debug functions for trinity drivers
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "trinity_common.h"
+#include "trinity_resv_mem.h"
+
+#define TRINITY_DEVVER(drv) (drv->desc->ver >> TRINITY_SHIFT_DEV)
+#define TRINITY_DEBUGFS_DIR ("trinity")
+#define TRINITY_DEBUGFS_MAX (1024UL)
+#define TRINITY_DEBUGFS_LENGTH (255)
+
+struct trinity_debugfs_msg {
+	char msg[TRINITY_DEBUGFS_LENGTH + 1]; /* including NULL */
+};
+
+struct trinity_debugfs_entry {
+	struct dentry *dentry;
+	spinlock_t lock;
+
+	unsigned long msg_max;
+	unsigned long msg_num;
+	unsigned long msg_off;
+
+	struct trinity_resv_mem msg_buf;
+};
+
+static struct dentry *trinity_debugfs;
+
+static size_t trinity_debug_append_app_id(struct trinity_driver *drv, char *msg)
+{
+	return snprintf(msg, TRINITY_DEBUGFS_LENGTH, "[%d] ",
+			trinity_get_app_id());
+}
+
+static char *trinity_debug_get_msg_buf(struct trinity_driver *drv)
+{
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+	struct trinity_debugfs_msg *buf;
+
+	if (!entry || entry->msg_max == 0)
+		return NULL;
+
+	spin_lock(&entry->lock);
+	if (entry->msg_num == entry->msg_max) {
+		buf = &((struct trinity_debugfs_msg *)
+				entry->msg_buf.vaddr)[entry->msg_off];
+		entry->msg_off = (entry->msg_off + 1) % entry->msg_max;
+	} else {
+		buf = &((struct trinity_debugfs_msg *)
+				entry->msg_buf.vaddr)[entry->msg_num++];
+	}
+	spin_unlock(&entry->lock);
+
+	memset(buf, '\x00', sizeof(*buf));
+	return buf->msg;
+}
+
+/**
+ * trinity_debug_dump_msg() - Dump trinity debug message
+ *
+ * @drv: an instance of the trinity driver
+ * @fmt: tag message format
+ */
+void trinity_debug_dump_msg(struct trinity_driver *drv, const char *fmt, ...)
+{
+	char *msg;
+	size_t len;
+	va_list args;
+
+	msg = trinity_debug_get_msg_buf(drv);
+	if (msg == NULL)
+		return;
+
+	len = trinity_debug_append_app_id(drv, msg);
+
+	va_start(args, fmt);
+	len += vsnprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len, fmt, args);
+	va_end(args);
+
+	if (drv->verbose > 0)
+		dev_info(drv_to_dev_ptr(drv), msg);
+}
+
+/**
+ * trinity_debug_dump_input() - Dump trinity input data
+ *
+ * @drv: an instance of the trinity driver
+ * @input: an instance of the trinity model
+ * @fmt: tag message format
+ */
+void trinity_debug_dump_model(struct trinity_driver *drv,
+			      const struct trinity_model *model,
+			      const char *fmt, ...)
+{
+	char *msg;
+	size_t len;
+	va_list args;
+
+	msg = trinity_debug_get_msg_buf(drv);
+	if (msg == NULL)
+		return;
+
+	len = trinity_debug_append_app_id(drv, msg);
+
+	va_start(args, fmt);
+	len += vsnprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len, fmt, args);
+	va_end(args);
+
+	len += snprintf(
+		msg + len, TRINITY_DEBUGFS_LENGTH - len,
+		"\n\tid(0x%llx) dbuf_fd(%d) program_offset_addr(0x%llx) program_size(0x%llx)\n",
+		model->config.id, model->config.dbuf_fd,
+		model->config.program_offset_addr, model->config.program_size);
+	if (TRINITY_DEVVER(drv) == 1) {
+		len += snprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len,
+				"\tweight_offset_addr(0x%llx)",
+				model->config.weight_offset_addr);
+	} else if (TRINITY_DEVVER(drv) == 2) {
+		len += snprintf(
+			msg + len, TRINITY_DEBUGFS_LENGTH - len,
+			"\tmetadata_dbuf_fd(%d) metadata_ext_dbuf_fd(%d) metadata_ext_size(0x%llx)",
+			model->config.metadata_dbuf_fd,
+			model->config.metadata_ext_dbuf_fd,
+			model->config.metadata_ext_size);
+	}
+
+	if (drv->verbose > 0)
+		dev_info(drv_to_dev_ptr(drv), msg);
+}
+
+/**
+ * trinity_debug_dump_input() - Dump trinity input data
+ *
+ * @drv: an instance of the trinity driver
+ * @input: an instance of the trinity input
+ * @fmt: tag message format
+ */
+void trinity_debug_dump_input(struct trinity_driver *drv,
+			      const struct trinity_input *input,
+			      const char *fmt, ...)
+{
+	char *msg;
+	size_t len;
+	va_list args;
+
+	msg = trinity_debug_get_msg_buf(drv);
+	if (msg == NULL)
+		return;
+
+	len = trinity_debug_append_app_id(drv, msg);
+
+	va_start(args, fmt);
+	len += vsnprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len, fmt, args);
+	va_end(args);
+
+	len += snprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len,
+			"\n\tdbuf_fd(%d) model_id(0x%llx)\n",
+			input->config.dbuf_fd, input->config.model_id);
+	if (TRINITY_DEVVER(drv) == 1) {
+		len += snprintf(
+			msg + len, TRINITY_DEBUGFS_LENGTH - len,
+			"\tactivation_offset_addr0(0x%llx) activation_offset_addr1(0x%llx)",
+			input->config.activation_offset_addr0,
+			input->config.activation_offset_addr1);
+	} else if (TRINITY_DEVVER(drv) == 2) {
+		len += snprintf(
+			msg + len, TRINITY_DEBUGFS_LENGTH - len,
+			"\ttimeout_ms(%lld) priority(%u) num_segments(%u) input_mode(%d) output_mode(%d)",
+			input->config.timeout_ms, input->config.priority,
+			input->config.num_segments, input->config.input_mode,
+			input->config.output_mode);
+	}
+
+	if (drv->verbose > 0)
+		dev_info(drv_to_dev_ptr(drv), msg);
+}
+
+static int trinity_debugfs_show(struct seq_file *s, void *unsed)
+{
+	struct trinity_driver *drv = s->private;
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+	struct trinity_debugfs_msg *msg;
+	unsigned long i, offset;
+
+	spin_lock(&entry->lock);
+	for (i = 0; i < entry->msg_num; i++) {
+		offset = (entry->msg_off + i) % entry->msg_max;
+		msg = &((struct trinity_debugfs_msg *)
+				entry->msg_buf.vaddr)[offset];
+
+		seq_puts(s, msg->msg);
+		seq_puts(s, "\n");
+	}
+	spin_unlock(&entry->lock);
+
+	return 0;
+}
+
+static int trinity_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, trinity_debugfs_show, inode->i_private);
+}
+
+static const struct file_operations trinity_debugfs_fops = {
+	.open = trinity_debugfs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/**
+ * trinity_debug_add() - Add trinity debug file system entry
+ *
+ * @drv: an instance of the trinity driver
+ */
+int trinity_debug_add(struct trinity_driver *drv)
+{
+	struct trinity_debugfs_entry *entry;
+	struct dentry *dentry;
+	const char *name = drv->name;
+
+	if (name == NULL)
+		return -EINVAL;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	dentry = debugfs_create_file_unsafe(name, 0400, trinity_debugfs, drv,
+					    &trinity_debugfs_fops);
+	if (IS_ERR(dentry)) {
+		kfree(entry);
+		return PTR_ERR(dentry);
+	}
+
+	entry->dentry = dentry;
+	spin_lock_init(&entry->lock);
+
+	drv->debugfs_pdata = entry;
+
+	return 0;
+}
+
+/**
+ * trinity_debug_remove() - Remove trinity debug file system entry
+ *
+ * @drv: an instance of the trinity driver
+ */
+void trinity_debug_remove(struct trinity_driver *drv)
+{
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+
+	trinity_debug_clear(drv, 0);
+
+	debugfs_remove(entry->dentry);
+	kfree(entry);
+
+	drv->debugfs_pdata = NULL;
+}
+
+/**
+ * trinity_debug_clear() - Clear debug message entity
+ *
+ * @drv: an instance of the trinity driver
+ * @msg_max: reset max size of debug message entity
+ */
+void trinity_debug_clear(struct trinity_driver *drv, unsigned long msg_max)
+{
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+	struct device *dev = drv_to_dev_ptr(drv);
+	size_t size;
+
+	/* maximum size limit: 256KiB */
+	if (msg_max > TRINITY_DEBUGFS_MAX) {
+		dev_err(dev, "Too much debugfs entries (limit: %lu)",
+			TRINITY_DEBUGFS_MAX);
+		return;
+	}
+
+	spin_lock(&entry->lock);
+
+	/* disable debugfs temporally */
+	trinity_free_from_resv_mem(&entry->msg_buf, false);
+	entry->msg_max = 0;
+	entry->msg_num = 0;
+	entry->msg_off = 0;
+
+	if (msg_max == 0)
+		goto out;
+
+	/* reallocate debugfs buffer */
+	size = PAGE_ALIGN(msg_max * sizeof(struct trinity_debugfs_msg));
+	if (trinity_alloc_from_resv_mem(size, &entry->msg_buf, false) < 0) {
+		dev_warn(dev, "No available reserved memory for debugfs");
+		goto out;
+	}
+	/* more available entries due to page size alignment */
+	entry->msg_max = size / sizeof(struct trinity_debugfs_msg);
+
+out:
+	spin_unlock(&entry->lock);
+}
+
+/**
+ * trinity_debug_exit() - Get max size of debug message entity
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Return: max size of debug message entity
+ */
+unsigned long trinity_debug_get_max(struct trinity_driver *drv)
+{
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+	unsigned long msg_max;
+
+	spin_lock(&entry->lock);
+	msg_max = entry->msg_max;
+	spin_unlock(&entry->lock);
+
+	return msg_max;
+}
+
+/**
+ * trinity_debug_exit() - Initialize debug file system
+ */
+int trinity_debug_init(void)
+{
+	struct dentry *entry;
+
+	entry = debugfs_create_dir(TRINITY_DEBUGFS_DIR, NULL);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	trinity_debugfs = entry;
+
+	return 0;
+}
+
+/**
+ * trinity_debug_exit() - Exit debug file system
+ */
+void trinity_debug_exit(void)
+{
+	debugfs_remove_recursive(trinity_debugfs);
+}
diff --git a/drivers/misc/trinity/trinity_stat.c b/drivers/misc/trinity/trinity_stat.c
new file mode 100644
index 000000000000..388d38f81acd
--- /dev/null
+++ b/drivers/misc/trinity/trinity_stat.c
@@ -0,0 +1,893 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Providing statistics for Samsung Trinity device family support
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include "trinity_stat.h"
+#include "trinity_common.h"
+#include "trinity_resv_mem.h"
+
+#include <linux/bitmap.h>
+#include <linux/list_bl.h>
+
+/* maximum number of stats configurable from sysfs */
+#define TRINITY_STAT_MAX_APPS (128UL)
+#define TRINITY_STAT_MAX_REQS (4096UL)
+#define TRINITY_STAT_MAX_REQS_PER_APP (128UL)
+
+/* default number of stats */
+#define TRINITY_STAT_DEF_APPS (32UL)
+#define TRINITY_STAT_DEF_REQS (128UL)
+#define TRINITY_STAT_DEF_REQS_PER_APP (32UL)
+
+/**
+ * struct trinity_stat_pool - Statistics pool which maintain statistics for device
+ *
+ * @bitmap_app: bitmap for app
+ * @bitmap_req: bitmap for request
+ * @mem_app: reserved memory for applications
+ * @mem_req: reserved memory for request
+ * @max_stat_apps: max statistics size of applications
+ * @max_stat_reqs: max statistics size of requests.
+ * @max_stat_reqs_per_app: max statistics size of request per application
+ * @cur_stat_apps: current statistics for applications
+ * @cur_stat_reqs: current statistics for requests
+ * @drv: an instance of the trinity driver
+ */
+struct trinity_stat_pool {
+	DECLARE_BITMAP(bitmap_app, TRINITY_STAT_MAX_APPS);
+	DECLARE_BITMAP(bitmap_req, TRINITY_STAT_MAX_REQS);
+
+	struct trinity_resv_mem mem_app;
+	struct trinity_resv_mem mem_req;
+
+	unsigned long max_stat_apps;
+	unsigned long max_stat_reqs;
+	unsigned long max_stat_reqs_per_app;
+
+	unsigned long cur_stat_apps;
+	unsigned long cur_stat_reqs;
+
+	struct trinity_driver *drv;
+};
+
+/**
+ * trinity_stat_pool_init(): Initialize trinity statistics pool
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Returns: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_stat_pool_init(struct trinity_driver *drv)
+{
+	struct trinity_stat_pool *pool;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return -ENOMEM;
+
+	pool->drv = drv;
+
+	drv->stat.pdata = pool;
+
+	return 0;
+}
+
+/**
+ * trinity_stat_pool_init(): finish trinity statistics pool
+ *
+ * @drv: an instance of the trinity driver
+ */
+void trinity_stat_pool_fini(struct trinity_driver *drv)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+
+	if (!pool)
+		return;
+
+	trinity_free_from_resv_mem(&pool->mem_app, false);
+	trinity_free_from_resv_mem(&pool->mem_req, false);
+	kfree(pool);
+
+	drv->stat.pdata = NULL;
+}
+
+static void trinity_stat_pool_resize_apps(struct trinity_stat_pool *pool,
+					  unsigned long num_apps)
+{
+	struct device *dev = drv_to_dev_ptr(pool->drv);
+	struct trinity_resv_mem mem;
+	unsigned long size;
+
+	if (num_apps > TRINITY_STAT_MAX_APPS) {
+		dev_err(dev, "The maximum number of stat apps: %lu",
+			TRINITY_STAT_MAX_APPS);
+		return;
+	}
+
+	size = PAGE_ALIGN(sizeof(struct trinity_stat_app) * num_apps);
+	if (trinity_alloc_from_resv_mem(size, &mem, false) == 0) {
+		trinity_free_from_resv_mem(&pool->mem_app, false);
+
+		bitmap_fill(pool->bitmap_app, TRINITY_STAT_MAX_APPS);
+		bitmap_zero(pool->bitmap_app, num_apps);
+
+		pool->max_stat_apps = num_apps;
+		pool->mem_app = mem;
+	} else {
+		dev_warn(dev, "Unable to allocate stats for apps");
+	}
+}
+
+static void trinity_stat_pool_resize_reqs(struct trinity_stat_pool *pool,
+					  unsigned long num_reqs)
+{
+	struct device *dev = drv_to_dev_ptr(pool->drv);
+	struct trinity_resv_mem mem;
+	unsigned long size;
+
+	if (num_reqs > TRINITY_STAT_MAX_REQS) {
+		dev_err(dev, "The maximum number of stat reqs: %lu",
+			TRINITY_STAT_MAX_REQS);
+		return;
+	}
+
+	size = PAGE_ALIGN(sizeof(struct trinity_stat_req) * num_reqs);
+	if (trinity_alloc_from_resv_mem(size, &mem, false) == 0) {
+		trinity_free_from_resv_mem(&pool->mem_req, false);
+
+		bitmap_fill(pool->bitmap_req, TRINITY_STAT_MAX_REQS);
+		bitmap_zero(pool->bitmap_req, num_reqs);
+
+		pool->max_stat_reqs = num_reqs;
+		pool->mem_req = mem;
+	} else {
+		dev_warn(dev, "Unable to allocate stats for reqs");
+	}
+}
+
+static struct trinity_stat_app *
+trinity_stat_pool_get_app(struct trinity_driver *drv)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_app *app = NULL;
+	unsigned long slot;
+	bool retried = false;
+
+	/* ensured that the lock is acquired */
+retry:
+	slot = find_first_zero_bit(pool->bitmap_app, TRINITY_STAT_MAX_APPS);
+	if (slot < TRINITY_STAT_MAX_APPS) {
+		app = &((struct trinity_stat_app *)pool->mem_app.vaddr)[slot];
+		memset(app, '\x00', sizeof(*app));
+		set_bit(slot, pool->bitmap_app);
+		app->slot = slot;
+	} else if (!retried) {
+		/* retry after destroy old stats */
+		retried = true;
+		trinity_destroy_stats(stat, true);
+		goto retry;
+	} else {
+		dev_warn(drv_to_dev_ptr(pool->drv),
+			 "Please increase stat pool limit for apps");
+	}
+
+	return app;
+}
+
+static void trinity_stat_pool_put_app(struct trinity_driver *drv,
+				      struct trinity_stat_app *app)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+
+	/* ensured that the lock is acquired */
+	clear_bit(app->slot, pool->bitmap_app);
+}
+
+static struct trinity_stat_req *
+trinity_stat_pool_get_req(struct trinity_driver *drv)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_req *req = NULL;
+	unsigned long slot;
+	bool retried = false;
+
+	/* ensured that the lock is acquired */
+retry:
+	slot = find_first_zero_bit(pool->bitmap_req, TRINITY_STAT_MAX_REQS);
+	if (slot < TRINITY_STAT_MAX_REQS) {
+		req = &((struct trinity_stat_req *)pool->mem_req.vaddr)[slot];
+		memset(req, '\x00', sizeof(*req));
+		set_bit(slot, pool->bitmap_req);
+		req->slot = slot;
+	} else if (!retried) {
+		/* retry after destroy old stats */
+		retried = true;
+		trinity_destroy_stats(stat, true);
+		goto retry;
+	} else {
+		dev_warn(drv_to_dev_ptr(pool->drv),
+			 "Please increase stat pool limit for reqs");
+	}
+
+	return req;
+}
+
+static void trinity_stat_pool_put_req(struct trinity_driver *drv,
+				      struct trinity_stat_req *req)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+
+	/* ensured that the lock is acquired */
+	clear_bit(req->slot, pool->bitmap_req);
+}
+
+/**
+ * trinity_stat_init(): Initialize trinity statistics
+ *
+ * @drv: an instance of the trinity driver
+ */
+void trinity_stat_init(struct trinity_driver *drv)
+{
+	unsigned long i;
+
+	spin_lock_init(&drv->stat.lock);
+
+	INIT_LIST_HEAD(&drv->stat.list);
+	for (i = 0; i < TRINITY_STAT_HASH_SIZE; ++i)
+		INIT_HLIST_BL_HEAD(&drv->stat.hlist[i]);
+
+	trinity_stat_pool_init(drv);
+	/* initialize to default values */
+	trinity_stat_resize(drv, TRINITY_STAT_DEF_APPS, TRINITY_STAT_DEF_REQS,
+			    TRINITY_STAT_DEF_REQS_PER_APP);
+}
+
+/**
+ * trinity_stat_fini(): Finish trinity statistics
+ *
+ * @drv: an instance of the trinity driver
+ */
+void trinity_stat_fini(struct trinity_driver *drv)
+{
+	trinity_stat_resize(drv, 0, 0, 0);
+	trinity_stat_pool_fini(drv);
+}
+
+/**
+ * trinity_stat_fini(): Finish trinity statistics
+ *
+ * @drv: an instance of the trinity driver
+ * @num_apps: a number of applications
+ * @num_reqs: a number of requests
+ * @num_reqs_per_app: a number of requests per application
+ */
+void trinity_stat_resize(struct trinity_driver *drv, unsigned long num_apps,
+			 unsigned long num_reqs, unsigned long num_reqs_per_app)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	unsigned long i;
+
+	if (!pool)
+		return;
+
+	trinity_stat_lock(&drv->stat);
+
+	for (i = 0; i < TRINITY_STAT_HASH_SIZE; i++) {
+		struct trinity_stat_app *stat_app;
+		struct hlist_bl_node *hn;
+
+		hlist_bl_lock(&(stat->hlist[i]));
+		hlist_bl_for_each_entry(stat_app, hn, &(stat->hlist[i]),
+					 hnode) {
+			if (stat_app->status != TRINITY_APP_STATUS_TERMINATED) {
+				dev_warn(drv_to_dev_ptr(drv),
+					 "Still busy apps detected.. waiting");
+				hlist_bl_unlock(&(stat->hlist[i]));
+				goto unlock;
+			}
+		}
+		hlist_bl_unlock(&(stat->hlist[i]));
+	}
+
+	trinity_destroy_stats(stat, true);
+
+	/* re-allocate each stat buffer */
+	if (num_apps > 0)
+		trinity_stat_pool_resize_apps(pool, num_apps);
+
+	if (num_reqs > 0)
+		trinity_stat_pool_resize_reqs(pool, num_reqs);
+
+	if (num_reqs_per_app > 0)
+		pool->max_stat_reqs_per_app = num_reqs_per_app;
+
+unlock:
+	trinity_stat_unlock(&drv->stat);
+}
+
+/**
+ * trinity_stat_get_max_apps(): Get max statistics size for application
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Returns max number of statistics for applications. 0 on error.
+ */
+unsigned long trinity_stat_get_max_apps(struct trinity_driver *drv)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+	unsigned long num;
+
+	if (!pool)
+		return 0;
+
+	trinity_stat_lock(&drv->stat);
+	num = pool->max_stat_apps;
+	trinity_stat_unlock(&drv->stat);
+
+	return num;
+}
+
+/**
+ * trinity_stat_get_max_reqs(): Get max statistics size for requests
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Returns max number of statistics for requests. 0 on error.
+ */
+unsigned long trinity_stat_get_max_reqs(struct trinity_driver *drv)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+	unsigned long num;
+
+	if (!pool)
+		return 0;
+
+	trinity_stat_lock(&drv->stat);
+	num = pool->max_stat_reqs;
+	trinity_stat_unlock(&drv->stat);
+
+	return num;
+}
+
+/**
+ * trinity_stat_get_max_reqs(): Get max statistics size for requests per application
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Returns max number of statistics for requests per application. 0 on error.
+ */
+unsigned long trinity_stat_get_max_reqs_per_app(struct trinity_driver *drv)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+	unsigned long num;
+
+	if (!pool)
+		return 0;
+
+	trinity_stat_lock(&drv->stat);
+	num = pool->max_stat_reqs_per_app;
+	trinity_stat_unlock(&drv->stat);
+
+	return num;
+}
+
+/**
+ * trinity_stat_lock(): Lock for trinity statistics
+ *
+ * @stat: an instance of trinity statistics
+ */
+void trinity_stat_lock(struct trinity_stat *stat)
+{
+	if (stat)
+		spin_lock(&stat->lock);
+}
+
+/**
+ * trinity_stat_unlock(): Unlock for trinity statistics
+ *
+ * @stat: an instance of trinity statistics
+ */
+void trinity_stat_unlock(struct trinity_stat *stat)
+{
+	if (stat)
+		spin_unlock(&stat->lock);
+}
+
+/**
+ * trinity_create_stat_app() - Create a stat structure for the opened app
+ *
+ * @drv: An instance of the trinity driver.
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+static int trinity_create_stat_app(struct trinity_driver *drv)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_app *stat_app;
+	unsigned long key;
+
+	trinity_stat_lock(stat);
+	stat_app = trinity_stat_pool_get_app(drv);
+	if (IS_ERR_OR_NULL(stat_app)) {
+		trinity_stat_unlock(stat);
+		dev_err(drv_to_dev_ptr(drv),
+			"Unable to allocate stat of request");
+		return -ENOMEM;
+	}
+
+	stat_app->parent = stat;
+	stat_app->app_id = trinity_get_app_id();
+	stat_app->total_alloc_mem = 0;
+	stat_app->total_freed_mem = 0;
+	stat_app->num_total_reqs = 0;
+	stat_app->num_kept_reqs = 0;
+	stat_app->num_active_reqs = 0;
+	stat_app->status = TRINITY_APP_STATUS_STARTED;
+
+	strncpy(stat_app->name, current->comm, TASK_COMM_LEN);
+	stat_app->name[TASK_COMM_LEN - 1] = '\x00';
+
+	INIT_HLIST_BL_NODE(&stat_app->hnode);
+	INIT_LIST_HEAD(&stat_app->reqs);
+
+	key = hash_long(stat_app->app_id, TRINITY_STAT_HASH_BITS);
+
+	hlist_bl_lock(&(stat->hlist[key]));
+	hlist_bl_add_head(&stat_app->hnode, &(stat->hlist[key]));
+	hlist_bl_unlock(&(stat->hlist[key]));
+
+	list_add_tail(&stat_app->lnode, &stat->list);
+	pool->cur_stat_apps++;
+
+	/* Remove terminated stats if the number reaches the maximum */
+	trinity_destroy_stats(stat, false);
+
+	trinity_stat_unlock(stat);
+
+	return 0;
+}
+
+static void trinity_destroy_stat_req(struct trinity_stat_req *stat_req)
+{
+	struct trinity_stat_app *stat_app = stat_req->parent;
+	struct trinity_stat *stat = stat_app->parent;
+	struct trinity_driver *drv =
+		container_of(stat, struct trinity_driver, stat);
+
+	if (stat_req->profile)
+		drv->desc->destroy_profile(drv, stat_req->profile);
+	list_del(&stat_req->list);
+	trinity_stat_pool_put_req(drv, stat_req);
+}
+
+static void trinity_destroy_stat_reqs(struct trinity_stat_app *stat_app)
+{
+	struct trinity_stat_req *stat_req, *tmp;
+
+	list_for_each_entry_safe(stat_req, tmp, &stat_app->reqs, list)
+		trinity_destroy_stat_req(stat_req);
+}
+
+/**
+ * trinity_destroy_stats - Destroy terminated stat structures
+ *
+ * @drv: An instance of the trinity driver
+ * @force: force destroy
+ */
+void trinity_destroy_stats(struct trinity_stat *stat, bool force)
+{
+	struct trinity_driver *drv =
+		container_of(stat, struct trinity_driver, stat);
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_app *stat_app;
+	struct hlist_bl_node *hn, *tmp;
+	int i;
+
+	/* lock should be acquired before */
+	if (!force && pool->cur_stat_apps <= pool->max_stat_apps)
+		return;
+
+	for (i = 0; i < TRINITY_STAT_HASH_SIZE; i++) {
+		hlist_bl_lock(&stat->hlist[i]);
+		hlist_bl_for_each_entry_safe(stat_app, hn, tmp,
+					      &(stat->hlist[i]), hnode) {
+			enum trinity_app_status status = stat_app->status;
+
+			if (status == TRINITY_APP_STATUS_TERMINATED) {
+				hlist_bl_del(&stat_app->hnode);
+				list_del(&stat_app->lnode);
+
+				pool->cur_stat_apps--;
+
+				trinity_destroy_stat_reqs(stat_app);
+				trinity_stat_pool_put_app(drv, stat_app);
+			}
+		}
+		hlist_bl_unlock(&stat->hlist[i]);
+	}
+}
+
+static struct trinity_stat_app *
+trinity_get_stat_by_id(struct trinity_driver *drv, int32_t app_id)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+	struct hlist_bl_node *hn;
+	unsigned long key;
+
+	key = hash_long(app_id, TRINITY_STAT_HASH_BITS);
+
+	hlist_bl_lock(&stat->hlist[key]);
+	hlist_bl_for_each_entry(stat_app, hn, &stat->hlist[key], hnode) {
+		if (stat_app->app_id == app_id)
+			goto out;
+	}
+	stat_app = NULL;
+out:
+	hlist_bl_unlock(&stat->hlist[key]);
+
+	return stat_app;
+}
+
+/**
+ * trinity_get_stat_app() - Get a status structure for the target app
+ *
+ * @drv: an instance of the trinity driver.
+ *
+ * Returns statistics for application on success. Otherwise, returns NULL.
+ *
+ * @note: If the stat is not allocated yet, try to create and return it.
+ */
+struct trinity_stat_app *trinity_get_stat_app(struct trinity_driver *drv)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+	int app_id = trinity_get_app_id();
+
+retry:
+	trinity_stat_lock(stat);
+	stat_app = trinity_get_stat_by_id(drv, app_id);
+	trinity_stat_unlock(stat);
+
+	if (!IS_ERR_OR_NULL(stat_app))
+		return stat_app;
+
+	if (trinity_create_stat_app(drv) != 0)
+		return NULL;
+
+	goto retry;
+}
+
+/**
+ * trinity_stat_app_set_status() - Set a status structure for the target app
+ *
+ * @drv: an instance of the trinity driver.
+ * @status: application status
+ */
+void trinity_stat_app_set_status(struct trinity_driver *drv,
+				 enum trinity_app_status status)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+	int app_id = trinity_get_app_id();
+
+	trinity_stat_lock(stat);
+	stat_app = trinity_get_stat_by_id(drv, app_id);
+	trinity_stat_unlock(stat);
+
+	if (IS_ERR_OR_NULL(stat_app))
+		return;
+
+	stat_app->status = status;
+}
+
+/**
+ * trinity_stat_append_req() - Append request information for statistics
+ *
+ * @drv: an instance of the trinity driver.
+ * @req: an instance of request
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_stat_append_req(struct trinity_driver *drv, struct trinity_req *req)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_app *stat_app;
+	struct trinity_stat_req *stat_req;
+
+	stat_app = trinity_get_stat_app(drv);
+	if (IS_ERR_OR_NULL(stat_app))
+		return -ENOMEM;
+
+	trinity_stat_lock(stat);
+	stat_req = trinity_stat_pool_get_req(drv);
+	if (!stat_req) {
+		trinity_stat_unlock(stat);
+		dev_err(drv_to_dev_ptr(drv),
+			"Unable to allocate stat of request");
+		return -ENOMEM;
+	}
+
+	stat_req->parent = stat_app;
+	stat_req->app_id = stat_app->app_id;
+	stat_req->req_id = req->input.config.req_id;
+	stat_req->model_id = req->input.config.model_id;
+	stat_req->submitted = ktime_get();
+	stat_req->status = TRINITY_REQ_STATUS_PENDING;
+	stat_req->priority =
+		(enum trinity_req_priority)req->input.config.priority;
+	stat_req->is_kernel = req->is_kernel;
+
+	req->stat = stat_req;
+
+	list_add_tail(&stat_req->list, &stat_app->reqs);
+
+	/* don't count kernel requests */
+	if (!req->is_kernel) {
+		if (stat_app->num_kept_reqs == pool->max_stat_reqs_per_app) {
+			struct trinity_stat_req *old_stat;
+
+			old_stat = list_first_entry(
+				&stat_app->reqs, struct trinity_stat_req, list);
+			/* skip any kernel or unfinished request */
+			while (old_stat->is_kernel ||
+			       (old_stat->status !=
+					TRINITY_REQ_STATUS_FINISHED &&
+				old_stat->status != TRINITY_REQ_STATUS_ERROR))
+				old_stat = list_next_entry(old_stat, list);
+
+			WARN_ON(old_stat == NULL);
+
+			trinity_destroy_stat_req(old_stat);
+			stat_app->num_total_reqs--;
+		} else {
+			/* total number of user requests kepted */
+			stat_app->num_kept_reqs++;
+		}
+	}
+
+	stat_app->num_total_reqs++;
+	stat_app->num_active_reqs++;
+
+	trinity_stat_unlock(stat);
+	return 0;
+}
+
+/**
+ * trinity_stat_remove_req() - Remove request information for statistics
+ *
+ * @drv: an instance of the trinity driver.
+ * @req: an instance of the request to be used for statistics
+ * @rollback: rollback statistics
+ */
+void trinity_stat_remove_req(struct trinity_driver *drv,
+			     struct trinity_req *req, bool rollback)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_req *stat_req = req->stat;
+	struct trinity_stat_app *stat_app = stat_req->parent;
+
+	trinity_stat_lock(stat);
+
+	trinity_destroy_stat_req(stat_req);
+
+	if (!req->is_kernel) {
+		WARN_ON(stat_app->num_kept_reqs == 0);
+		stat_app->num_kept_reqs--;
+	}
+
+	if (rollback) {
+		WARN_ON(stat_app->num_total_reqs == 0);
+		stat_app->num_total_reqs--;
+		WARN_ON(stat_app->num_active_reqs == 0);
+		stat_app->num_active_reqs--;
+	}
+
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_finish_req() - Finish request for statistics
+ *
+ * @drv: an instance of the trinity driver.
+ * @req: an instance of the request to be used for statistics
+ */
+void trinity_stat_finish_req(struct trinity_driver *drv,
+			     struct trinity_req *req)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_req *stat_req = req->stat;
+	struct trinity_stat_app *stat_app = stat_req->parent;
+
+	trinity_stat_lock(stat);
+	if (stat_app->num_active_reqs != 0)
+		stat_app->num_active_reqs--;
+	else
+		dev_err(drv_to_dev_ptr(drv),
+			"Fail to keep track of the active reqs");
+	trinity_stat_unlock(stat);
+}
+
+static void copy_stat_app_ioctl(struct trinity_stat_app *stat_app,
+				struct trinity_ioctl_stat_app *ioctl_stat_app)
+{
+	ioctl_stat_app->app_id = stat_app->app_id;
+	ioctl_stat_app->status = stat_app->status;
+	ioctl_stat_app->num_total_reqs = stat_app->num_total_reqs;
+	ioctl_stat_app->num_active_reqs = stat_app->num_active_reqs;
+	ioctl_stat_app->total_alloc_mem = stat_app->total_alloc_mem;
+	ioctl_stat_app->total_freed_mem = stat_app->total_freed_mem;
+
+	strncpy(ioctl_stat_app->name, stat_app->name, TASK_COMM_LEN);
+	ioctl_stat_app->name[TASK_COMM_LEN - 1] = '\x00';
+}
+
+static void copy_stat_req_ioctl(struct trinity_stat_req *stat_req,
+				struct trinity_ioctl_stat_req *ioctl_stat_req)
+{
+	ktime_t cur_time = ktime_get();
+	ktime_t submitted, scheduled, completed;
+
+	submitted = stat_req->submitted;
+	scheduled = stat_req->scheduled ? stat_req->scheduled : cur_time;
+	completed = stat_req->completed ? stat_req->completed : cur_time;
+
+	ioctl_stat_req->req_id = stat_req->req_id;
+	ioctl_stat_req->model_id = stat_req->model_id;
+	ioctl_stat_req->priority = stat_req->priority;
+	ioctl_stat_req->status = stat_req->status;
+
+	if (stat_req->priority == TRINITY_REQ_PRIORITY_HIGH)
+		ioctl_stat_req->sched_time = 0;
+	else
+		ioctl_stat_req->sched_time = TIME_DIFF(scheduled, submitted);
+	ioctl_stat_req->infer_time = TIME_DIFF(completed, scheduled);
+}
+
+/**
+ * trinity_stat_app_copy_ioctl() - Copy an application's statistics information to ioctl info
+ *
+ * @drv: an instance of the trinity driver.
+ * @ioctl_stat_app: ioctl statistics information for an application
+ */
+void trinity_stat_app_copy_ioctl(struct trinity_driver *drv,
+				 struct trinity_ioctl_stat_app *ioctl_stat_app)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+	int app_id = trinity_get_app_id();
+
+	trinity_stat_lock(stat);
+
+	stat_app = trinity_get_stat_by_id(drv, app_id);
+	if (IS_ERR_OR_NULL(stat_app)) {
+		ioctl_stat_app->app_id = app_id;
+		ioctl_stat_app->status = TRINITY_APP_STATUS_PENDING;
+		ioctl_stat_app->num_total_reqs = 0;
+		ioctl_stat_app->num_active_reqs = 0;
+		ioctl_stat_app->total_alloc_mem = 0;
+		ioctl_stat_app->total_freed_mem = 0;
+
+		strncpy(ioctl_stat_app->name, current->comm, TASK_COMM_LEN);
+		ioctl_stat_app->name[TASK_COMM_LEN - 1] = '\x00';
+	} else {
+		copy_stat_app_ioctl(stat_app, ioctl_stat_app);
+	}
+
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_apps_copy_ioctl() - Copy applications' statistics information to ioctl info
+ *
+ * @drv: an instance of the trinity driver.
+ * @ioctl_stat_apps: ioctl statistics information for applications
+ */
+void trinity_stat_apps_copy_ioctl(
+	struct trinity_driver *drv,
+	struct trinity_ioctl_stat_apps *ioctl_stat_apps)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_ioctl_stat_app *ioctl_stat_app;
+	struct trinity_stat_app *stat_app;
+	uint32_t idx = 0;
+
+	trinity_stat_lock(stat);
+
+	list_for_each_entry(stat_app, &stat->list, lnode) {
+		if (idx >= TRINITY_APP_STAT_MAX)
+			break;
+		ioctl_stat_app = &ioctl_stat_apps->stat[idx++];
+		copy_stat_app_ioctl(stat_app, ioctl_stat_app);
+	}
+	ioctl_stat_apps->num_apps = idx;
+
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_app_copy_ioctl() - Copy requests' statistics information to ioctl info
+ *
+ * @drv: an instance of the trinity driver.
+ * @ioctl_stat_reqs: ioctl statistics information for requests
+ */
+void trinity_stat_reqs_copy_ioctl(
+	struct trinity_driver *drv,
+	struct trinity_ioctl_stat_reqs *ioctl_stat_reqs)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_ioctl_stat_req *ioctl_stat_req;
+	struct trinity_stat_app *stat_app;
+	struct trinity_stat_req *stat_req;
+	uint32_t idx = 0;
+
+	trinity_stat_lock(stat);
+	stat_app = trinity_get_stat_by_id(drv, ioctl_stat_reqs->app_id);
+	if (IS_ERR_OR_NULL(stat_app)) {
+		ioctl_stat_reqs->num_reqs = 0;
+		trinity_stat_unlock(stat);
+		return;
+	}
+
+	list_for_each_entry(stat_req, &stat_app->reqs, list) {
+		if (idx >= TRINITY_REQ_STAT_MAX)
+			break;
+		ioctl_stat_req = &ioctl_stat_reqs->stat[idx++];
+		copy_stat_req_ioctl(stat_req, ioctl_stat_req);
+	}
+	ioctl_stat_reqs->num_reqs = idx;
+
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_app_total_alloc() - Append allocated size to application's total memory size
+ *
+ * @drv: an instance of the trinity driver.
+ * @size: allocated memory size
+ */
+void trinity_stat_app_total_alloc(struct trinity_driver *drv, size_t size)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+
+	stat_app = trinity_get_stat_app(drv);
+	if (IS_ERR_OR_NULL(stat_app))
+		return;
+
+	trinity_stat_lock(stat);
+	stat_app->total_alloc_mem += size;
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_app_total_alloc() - Append freed size to application's total memory size
+ *
+ * @drv: an instance of the trinity driver.
+ * @size: freed memory size
+ */
+void trinity_stat_app_total_freed(struct trinity_driver *drv, size_t size)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+
+	stat_app = trinity_get_stat_app(drv);
+	if (IS_ERR_OR_NULL(stat_app))
+		return;
+
+	trinity_stat_lock(stat);
+	stat_app->total_freed_mem += size;
+	trinity_stat_unlock(stat);
+}
diff --git a/drivers/misc/trinity/trinity_stat.h b/drivers/misc/trinity/trinity_stat.h
new file mode 100644
index 000000000000..6be666e4e102
--- /dev/null
+++ b/drivers/misc/trinity/trinity_stat.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Statistics header for trinity devices
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __TRINITY_STAT_H__
+#define __TRINITY_STAT_H__
+
+#include "trinity_common.h"
+
+void trinity_stat_init(struct trinity_driver *drv);
+void trinity_stat_fini(struct trinity_driver *drv);
+void trinity_stat_resize(struct trinity_driver *drv, unsigned long num_apps,
+			 unsigned long num_reqs,
+			 unsigned long num_reqs_per_app);
+
+void trinity_stat_lock(struct trinity_stat *stat);
+void trinity_stat_unlock(struct trinity_stat *stat);
+void trinity_destroy_stats(struct trinity_stat *stat, bool force);
+
+unsigned long trinity_stat_get_max_apps(struct trinity_driver *drv);
+unsigned long trinity_stat_get_max_reqs(struct trinity_driver *drv);
+unsigned long trinity_stat_get_max_reqs_per_app(struct trinity_driver *drv);
+
+struct trinity_stat_app *trinity_get_stat_app(struct trinity_driver *drv);
+
+void trinity_stat_app_total_alloc(struct trinity_driver *drv, size_t size);
+void trinity_stat_app_total_freed(struct trinity_driver *drv, size_t size);
+void trinity_stat_app_set_status(struct trinity_driver *drv,
+				 enum trinity_app_status status);
+
+int trinity_stat_append_req(struct trinity_driver *drv,
+			    struct trinity_req *req);
+void trinity_stat_remove_req(struct trinity_driver *drv,
+			     struct trinity_req *req, bool rollback);
+void trinity_stat_finish_req(struct trinity_driver *drv,
+			     struct trinity_req *req);
+
+void trinity_stat_app_copy_ioctl(struct trinity_driver *drv,
+				 struct trinity_ioctl_stat_app *ioctl_stat_app);
+
+void trinity_stat_apps_copy_ioctl(
+	struct trinity_driver *drv,
+	struct trinity_ioctl_stat_apps *ioctl_stat_apps);
+
+void trinity_stat_reqs_copy_ioctl(
+	struct trinity_driver *drv,
+	struct trinity_ioctl_stat_reqs *ioctl_stat_reqs);
+
+#endif /* __TRINITY_STAT_H__ */
diff --git a/drivers/misc/trinity/trinity_sysfs.c b/drivers/misc/trinity/trinity_sysfs.c
new file mode 100644
index 000000000000..bdf630b04222
--- /dev/null
+++ b/drivers/misc/trinity/trinity_sysfs.c
@@ -0,0 +1,864 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sysfs interface for Samsung Research Trinity device family
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/device.h>
+#include <linux/sysfs.h>
+
+#include "sched/sched.h"
+#include "trinity_common.h"
+#include "trinity_stat.h"
+
+enum trinity_sysfs_msg {
+	SYSFS_MSG_NORMAL = 0,
+	SYSFS_MSG_PROLOGUE,
+	SYSFS_MSG_EPILOGUE,
+	SYSFS_MSG_EMIT,
+};
+
+static ssize_t verbose_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	int32_t ret = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	ret = kstrtoul(buf, 10, &drv->verbose);
+	if (ret != 0)
+		return -EINVAL;
+
+	return (ssize_t)count;
+}
+
+static ssize_t verbose_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", drv->verbose);
+}
+static DEVICE_ATTR_RW(verbose);
+
+static ssize_t debugfs_max_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	unsigned long msg_max;
+	int32_t ret = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	ret = kstrtoul(buf, 10, &msg_max);
+	if (ret != 0)
+		return -EINVAL;
+
+	trinity_debug_clear(drv, msg_max);
+
+	return (ssize_t)count;
+}
+
+static ssize_t debugfs_max_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n", trinity_debug_get_max(drv));
+}
+static DEVICE_ATTR_RW(debugfs_max);
+
+static ssize_t show_profile_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	unsigned long req_id;
+	int32_t ret = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	ret = kstrtoul(buf, 10, &req_id);
+	if (ret != 0)
+		return -EINVAL;
+
+	if (drv->desc->show_profile)
+		drv->desc->show_profile(drv, (int)req_id);
+
+	return (ssize_t)count;
+}
+static DEVICE_ATTR_WO(show_profile);
+
+static ssize_t idu_version_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	if (drv->desc->idu_version) {
+		uint32_t major, minor, extra;
+
+		if (drv->desc->idu_version(drv, &major, &minor, &extra) == 0)
+			return snprintf(buf, PAGE_SIZE, "v%u.%u.%u\n", major,
+					minor, extra);
+	}
+
+	return snprintf(buf, PAGE_SIZE,
+			"Unknown... v0.30.7 or higher version required.\n");
+}
+static DEVICE_ATTR_RO(idu_version);
+
+static struct attribute *trinity_attrs_debug[] = {
+	&dev_attr_verbose.attr, &dev_attr_debugfs_max.attr,
+	&dev_attr_show_profile.attr, &dev_attr_idu_version.attr, NULL
+};
+
+/* e.g, /sys/devices/platform/304f0000.triv2/debug/ */
+static struct attribute_group trinity_attrs_debug_group = {
+	.name = "debug",
+	.attrs = trinity_attrs_debug
+};
+
+static ssize_t max_stat_apps_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	unsigned long val;
+	int32_t ret = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret != 0)
+		return -EINVAL;
+
+	trinity_stat_resize(drv, val, 0, 0);
+
+	return (ssize_t)count;
+}
+
+static ssize_t max_stat_apps_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n",
+			trinity_stat_get_max_apps(drv));
+}
+static DEVICE_ATTR_RW(max_stat_apps);
+
+static ssize_t max_stat_reqs_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	unsigned long val;
+	int32_t ret = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret != 0)
+		return -EINVAL;
+
+	trinity_stat_resize(drv, 0, val, 0);
+
+	return (ssize_t)count;
+}
+
+static ssize_t max_stat_reqs_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n",
+			trinity_stat_get_max_reqs(drv));
+}
+static DEVICE_ATTR_RW(max_stat_reqs);
+
+static ssize_t max_stat_reqs_per_app_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	unsigned long val;
+	int32_t ret = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret != 0)
+		return -EINVAL;
+
+	trinity_stat_resize(drv, 0, 0, val);
+
+	return (ssize_t)count;
+}
+
+static ssize_t max_stat_reqs_per_app_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	return snprintf(buf, PAGE_SIZE, "%lu\n",
+			trinity_stat_get_max_reqs_per_app(drv));
+}
+static DEVICE_ATTR_RW(max_stat_reqs_per_app);
+
+static ssize_t mem_usage_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	struct trinity_stat_app *stat_app;
+	ssize_t pos = 0;
+	bool first = true;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	trinity_stat_lock(&drv->stat);
+
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		if (first) {
+			pos += snprintf(
+				buf + pos, PAGE_SIZE,
+				"Memory usage statistics for all opened devices\n");
+			first = false;
+		}
+
+		pos += snprintf(
+			buf + pos, PAGE_SIZE,
+			" [%d] total_alloc: %llu bytes, total_freed: %llu bytes\n",
+			stat_app->app_id, stat_app->total_alloc_mem,
+			stat_app->total_freed_mem);
+	}
+
+	if (first)
+		pos += snprintf(buf + pos, PAGE_SIZE, "No active devices\n");
+
+	trinity_stat_unlock(&drv->stat);
+
+	return pos;
+}
+static DEVICE_ATTR_RO(mem_usage);
+
+#define MODEL_REGISTERED_PROLOGUE                                    \
+	"\n   Model statistics registered in all opened devices\n"   \
+	"+--------------+--------------+-----------+------------+\n" \
+	"|   Model ID   |  Model Size  | Dmabuf FD |   Offset   |\n" \
+	"+--------------+--------------+-----------+------------+\n"
+#define MODEL_REGISTERED_NORMAL "| %#12llx | %#12llx | %9d | %#10llx |\n"
+#define MODEL_REGISTERED_EPILOGUE \
+	"+--------------+--------------+-----------+------------+\n"
+
+static ssize_t print_registered_models(const struct trinity_model *model,
+				       char *buf, enum trinity_sysfs_msg msg)
+{
+	ssize_t pos = 0;
+
+	switch (msg) {
+	case SYSFS_MSG_PROLOGUE:
+		pos = snprintf(buf, PAGE_SIZE, MODEL_REGISTERED_PROLOGUE);
+		break;
+	case SYSFS_MSG_NORMAL:
+		pos = snprintf(buf, PAGE_SIZE, MODEL_REGISTERED_NORMAL,
+			       model->config.id, model->config.program_size,
+			       model->config.dbuf_fd,
+			       model->config.program_offset_addr);
+		break;
+	case SYSFS_MSG_EPILOGUE:
+		pos = snprintf(buf, PAGE_SIZE, MODEL_REGISTERED_EPILOGUE);
+		break;
+	default:
+		break;
+	}
+
+	return pos;
+}
+
+static ssize_t registered_models_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	struct trinity_model_htable ht;
+	struct trinity_model *model;
+	struct hlist_bl_node *hn;
+	ssize_t pos;
+	int i, num_printed = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	trinity_init_model_htable(drv, &ht);
+
+	pos = print_registered_models(NULL, buf, SYSFS_MSG_PROLOGUE);
+
+	for (i = 0; i < ht.hash_size; i++) {
+		hlist_bl_lock(&(ht.ht_heads[i]));
+		hlist_bl_for_each_entry(model, hn, &(ht.ht_heads[i]), hnode) {
+			pos += print_registered_models(model, buf + pos,
+						       SYSFS_MSG_NORMAL);
+			num_printed++;
+		}
+		hlist_bl_unlock(&(ht.ht_heads[i]));
+	}
+
+	if (num_printed > 0)
+		pos += print_registered_models(NULL, buf + pos,
+					       SYSFS_MSG_EPILOGUE);
+
+	return pos;
+}
+static DEVICE_ATTR_RO(registered_models);
+
+static const char *priority_to_string(enum trinity_req_priority priority)
+{
+	static const char *const priority_strings[] = {
+		[TRINITY_REQ_PRIORITY_LOW] = "Low",
+		[TRINITY_REQ_PRIORITY_MID] = "Mid",
+		[TRINITY_REQ_PRIORITY_HIGH] = "High",
+	};
+	return priority_strings[priority];
+}
+
+static const char *status_to_string(enum trinity_req_status status)
+{
+	static const char *const status_strings[] = {
+		[TRINITY_REQ_STATUS_UNKNOWN] = "Unknown",
+		[TRINITY_REQ_STATUS_ERROR] = "Error",
+		[TRINITY_REQ_STATUS_PENDING] = "Pending",
+		[TRINITY_REQ_STATUS_RUNNING] = "Running",
+		[TRINITY_REQ_STATUS_FINISHED] = "Finished",
+	};
+	return status_strings[status];
+}
+
+#define APP_STATUS_LENGTH (77)
+#define USER_APP_STATUS_PROLOGUE                                                         \
+	"\n\tUser-level request statistics running in %s\n"                              \
+	"+-------+--------+----------+------+----------+--------------+-------------+\n" \
+	"|  PID  | Req ID | Model ID | Prio |  Status  |  Sched (us)  |  Infer (us) |\n" \
+	"+-------+--------+----------+------+----------+--------------+-------------+\n"
+#define USER_APP_STATUS_NORMAL \
+	"| %5d | %6d | %#8llx | %4s | %8s | %12lld | %11lld |\n"
+#define USER_APP_STATUS_EMIT \
+	"|                             ... (emitted) ...                            |\n"
+#define USER_APP_STATUS_EPILOGUE \
+	"+-------+--------+----------+------+----------+--------------+-------------+\n"
+
+static ssize_t print_user_app_status(struct device *dev,
+				     const struct trinity_stat_req *req,
+				     char *buf, enum trinity_sysfs_msg msg)
+{
+	ssize_t pos = 0;
+
+	switch (msg) {
+	case SYSFS_MSG_PROLOGUE:
+		pos = snprintf(buf, APP_STATUS_LENGTH * 4 + 1,
+			       USER_APP_STATUS_PROLOGUE, dev_name(dev));
+		break;
+	case SYSFS_MSG_NORMAL: {
+		ktime_t cur_time = ktime_get();
+		ktime_t submitted = req->submitted;
+		ktime_t scheduled = req->scheduled ? req->scheduled : cur_time;
+		ktime_t completed = req->completed ? req->completed : cur_time;
+
+		int64_t sched_diff = TIME_DIFF_US(scheduled, submitted);
+		int64_t infer_diff = TIME_DIFF_US(completed, scheduled);
+
+		if (req->status == TRINITY_REQ_STATUS_ERROR) {
+			sched_diff = 0;
+			infer_diff = 0;
+		}
+
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       USER_APP_STATUS_NORMAL, req->app_id, req->req_id,
+			       req->model_id, priority_to_string(req->priority),
+			       status_to_string(req->status), sched_diff,
+			       infer_diff);
+	} break;
+	case SYSFS_MSG_EMIT:
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       USER_APP_STATUS_EMIT);
+		break;
+	case SYSFS_MSG_EPILOGUE:
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       USER_APP_STATUS_EPILOGUE);
+		break;
+	default:
+		break;
+	}
+
+	return pos;
+}
+
+#define KERNEL_APP_STATUS_PROLOGUE                                                       \
+	"\n\tKernel-level request statistics running in %s\n"                            \
+	"+-------+--------+----------+------+----------+------------+---------------+\n" \
+	"|  PID  | Req ID | Model ID | Prio |  Status  |   # Runs   | Avg. Lat (us) |\n" \
+	"+-------+--------+----------+------+----------+------------+---------------+\n"
+#define KERNEL_APP_STATUS_NORMAL \
+	"| %5d | %6d | %#8llx | %4s | %8s | %10u | %13u |\n"
+#define KERNEL_APP_STATUS_EMIT \
+	"|                             ... (emitted) ...                            |\n"
+#define KERNEL_APP_STATUS_EPILOGUE \
+	"+-------+--------+----------+------+----------+------------+---------------+\n"
+
+static ssize_t print_kernel_app_status(struct device *dev,
+				       const struct trinity_stat_req *req,
+				       char *buf, enum trinity_sysfs_msg msg)
+{
+	ssize_t pos = 0;
+
+	switch (msg) {
+	case SYSFS_MSG_PROLOGUE:
+		pos = snprintf(buf, APP_STATUS_LENGTH * 4 + 1,
+			       KERNEL_APP_STATUS_PROLOGUE, dev_name(dev));
+		break;
+	case SYSFS_MSG_NORMAL: {
+		uint32_t avg_latency = 0;
+
+		if (req->num_runs > 0)
+			avg_latency = req->total_time / req->num_runs;
+
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       KERNEL_APP_STATUS_NORMAL, req->app_id,
+			       req->req_id, req->model_id,
+			       priority_to_string(req->priority),
+			       status_to_string(req->status), req->num_runs,
+			       avg_latency);
+	} break;
+	case SYSFS_MSG_EMIT:
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       KERNEL_APP_STATUS_EMIT);
+		break;
+	case SYSFS_MSG_EPILOGUE:
+		pos = snprintf(buf, APP_STATUS_LENGTH + 1,
+			       KERNEL_APP_STATUS_EPILOGUE);
+		break;
+	default:
+		break;
+	}
+
+	return pos;
+}
+
+static ssize_t app_status_user_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	struct trinity_stat_app *stat_app;
+	struct trinity_stat_req *stat_req;
+	int num_printed = 0;
+	ssize_t pos;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	pos = print_user_app_status(dev, NULL, buf, SYSFS_MSG_PROLOGUE);
+
+	trinity_stat_lock(&drv->stat);
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		list_for_each_entry(stat_req, &stat_app->reqs, list) {
+			if (stat_req->is_kernel)
+				continue;
+
+			pos += print_user_app_status(dev, stat_req, buf + pos,
+						     SYSFS_MSG_NORMAL);
+			num_printed++;
+
+			/* buffer size limit: PAGE_SIZE (also need reserved bytes) */
+			if (pos + APP_STATUS_LENGTH >
+			    PAGE_SIZE - 2 * APP_STATUS_LENGTH) {
+				pos += print_user_app_status(
+					dev, NULL, buf + pos, SYSFS_MSG_EMIT);
+				/* clear old stats */
+				trinity_destroy_stats(&drv->stat, true);
+				goto out;
+			}
+		}
+	}
+out:
+	trinity_stat_unlock(&drv->stat);
+
+	if (num_printed > 0)
+		pos += print_user_app_status(dev, NULL, buf + pos,
+					     SYSFS_MSG_EPILOGUE);
+
+	return pos;
+}
+static DEVICE_ATTR_RO(app_status_user);
+
+static ssize_t app_status_kernel_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	struct trinity_stat_app *stat_app;
+	struct trinity_stat_req *stat_req;
+	int num_printed = 0;
+	ssize_t pos;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	pos = print_kernel_app_status(dev, NULL, buf, SYSFS_MSG_PROLOGUE);
+
+	trinity_stat_lock(&drv->stat);
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		list_for_each_entry(stat_req, &stat_app->reqs, list) {
+			if (!stat_req->is_kernel)
+				continue;
+
+			pos += print_kernel_app_status(dev, stat_req, buf + pos,
+						       SYSFS_MSG_NORMAL);
+			num_printed++;
+
+			/* buffer size limit: PAGE_SIZE (also need reserved bytes) */
+			if (pos + APP_STATUS_LENGTH >
+			    PAGE_SIZE - 2 * APP_STATUS_LENGTH) {
+				pos += print_kernel_app_status(
+					dev, NULL, buf + pos, SYSFS_MSG_EMIT);
+				/* clear old stats */
+				trinity_destroy_stats(&drv->stat, true);
+				goto out;
+			}
+		}
+	}
+out:
+	trinity_stat_unlock(&drv->stat);
+
+	if (num_printed > 0)
+		pos += print_kernel_app_status(dev, NULL, buf + pos,
+					       SYSFS_MSG_EPILOGUE);
+
+	return pos;
+}
+static DEVICE_ATTR_RO(app_status_kernel);
+
+static ssize_t num_total_reqs_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	struct trinity_stat_app *stat_app;
+	uint32_t num_total_reqs = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	trinity_stat_lock(&drv->stat);
+
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		num_total_reqs += stat_app->num_total_reqs;
+	}
+
+	trinity_stat_unlock(&drv->stat);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", num_total_reqs);
+}
+static DEVICE_ATTR_RO(num_total_reqs);
+
+static ssize_t num_active_reqs_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	struct trinity_stat_app *stat_app;
+	uint32_t num_active_reqs = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	trinity_stat_lock(&drv->stat);
+
+	list_for_each_entry(stat_app, &drv->stat.list, lnode) {
+		num_active_reqs += stat_app->num_active_reqs;
+	}
+
+	trinity_stat_unlock(&drv->stat);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", num_active_reqs);
+}
+static DEVICE_ATTR_RO(num_active_reqs);
+
+static struct attribute *trinity_attrs_stat[] = {
+	&dev_attr_max_stat_apps.attr,	      &dev_attr_max_stat_reqs.attr,
+	&dev_attr_max_stat_reqs_per_app.attr, &dev_attr_mem_usage.attr,
+	&dev_attr_registered_models.attr,     &dev_attr_app_status_user.attr,
+	&dev_attr_app_status_kernel.attr,     &dev_attr_num_total_reqs.attr,
+	&dev_attr_num_active_reqs.attr,	      NULL
+};
+
+/* e.g, /sys/devices/platform/304f0000.triv2/stat/ */
+static struct attribute_group trinity_attrs_stat_group = {
+	.name = "stat",
+	.attrs = trinity_attrs_stat
+};
+
+static ssize_t stop_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	unsigned long stop;
+	int32_t ret = 0;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	ret = kstrtoul(buf, 10, &stop);
+	if (ret != 0)
+		return 0;
+
+	if (stop == 1 && drv->desc->stop_reqs)
+		schedule_work(&drv->work_stop);
+
+	return (ssize_t)count;
+}
+
+static DEVICE_ATTR_WO(stop);
+
+static ssize_t idu_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	char dirpath[NAME_MAX];
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	strncpy(dirpath, buf, NAME_MAX);
+	/* remove newline if exists */
+	dirpath[strcspn(dirpath, "\n")] = '\x00';
+
+	mutex_lock(&drv->lock);
+	drv->desc->idu_load(drv, dirpath, true);
+	mutex_unlock(&drv->lock);
+
+	return (ssize_t)count;
+}
+
+static DEVICE_ATTR_WO(idu);
+
+static ssize_t suspend_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	unsigned long suspend;
+
+	if (kstrtoul(buf, 10, &suspend) != 0)
+		return 0;
+
+	/** Note that this interface is used only for testing purpose */
+	if (suspend == 1) {
+		const struct dev_pm_ops *ops = dev->driver->pm;
+
+		ops->runtime_suspend(dev);
+	}
+
+	return (ssize_t)count;
+}
+
+static DEVICE_ATTR_WO(suspend);
+
+static ssize_t resume_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long resume;
+
+	if (kstrtoul(buf, 10, &resume) != 0)
+		return 0;
+
+	/** Note that this interface is used only for testing purpose */
+	if (resume == 1) {
+		const struct dev_pm_ops *ops = dev->driver->pm;
+
+		ops->runtime_resume(dev);
+	}
+
+	return (ssize_t)count;
+}
+
+static DEVICE_ATTR_WO(resume);
+
+static ssize_t profile_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	unsigned long profile;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	if (kstrtoul(buf, 10, &profile) != 0)
+		return 0;
+
+	/** Note that this interface is used only for testing purpose */
+	if (drv->desc->init_profile)
+		drv->desc->init_profile(drv, profile);
+
+	return (ssize_t)count;
+}
+
+static DEVICE_ATTR_WO(profile);
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct platform_device *pdev;
+	struct trinity_driver *drv;
+	unsigned long reset;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	drv = platform_get_drvdata(pdev);
+
+	if (drv == NULL)
+		return 0;
+
+	if (kstrtoul(buf, 10, &reset) != 0)
+		return 0;
+
+	if (reset == 1 && drv->desc->reset)
+		drv->desc->reset(drv);
+
+	return (ssize_t)count;
+}
+
+static DEVICE_ATTR_WO(reset);
+
+static struct attribute *trinity_attrs_control[] = { &dev_attr_stop.attr,
+						     &dev_attr_idu.attr,
+						     &dev_attr_suspend.attr,
+						     &dev_attr_resume.attr,
+						     &dev_attr_profile.attr,
+						     &dev_attr_reset.attr,
+						     NULL };
+
+/* e.g, /sys/devices/platform/304f0000.triv2/control/ */
+static struct attribute_group trinity_attrs_control_group = {
+	.name = "control",
+	.attrs = trinity_attrs_control
+};
+
+static const struct attribute_group *trinity_attrs_groups[] = {
+	&trinity_attrs_debug_group, &trinity_attrs_stat_group,
+	&trinity_attrs_control_group, NULL
+};
+
+int trinity_sysfs_init(struct trinity_driver *drv)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	int err;
+
+	err = sysfs_create_groups(&dev->kobj, trinity_attrs_groups);
+	if (err < 0) {
+		dev_err(dev, "failed to create sysfs groups\n");
+		return err;
+	}
+
+	return 0;
+}
+
+int trinity_sysfs_cleanup(struct trinity_driver *drv)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+
+	sysfs_remove_groups(&dev->kobj, trinity_attrs_groups);
+
+	return 0;
+}
-- 
2.25.1

