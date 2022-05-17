Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E46952A9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiEQSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351728AbiEQSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13CF93F88C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652810615;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nC5sIeoZg0xNpUluSDaQNFJypbgrYlOswiBZevjeqz8=;
        b=M0Y5Mgi7mnTmfQFu94oy/XxUQtmTdrX/7D5iI2cXtWB+Aq1Bd3EyBMRPdnfHIe63j6y8vY
        bw3EVFTWmPe1Jm5mnpSolrqajXVCxLeVkmBbsGPyEWNLz5YDzO2P7DRmZ6ZPXJe4G6leNw
        qA95MzNVX/YSjdjSbRRM326QRY4oGdU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-LnqSJRQrOYCWdZI8rg2zfQ-1; Tue, 17 May 2022 14:03:32 -0400
X-MC-Unique: LnqSJRQrOYCWdZI8rg2zfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67ABA811E76;
        Tue, 17 May 2022 18:03:31 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 105D640CF8F0;
        Tue, 17 May 2022 18:03:31 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: [PATCH v3 01/11] smp: consolidate the structure definitions to smp.h
Date:   Tue, 17 May 2022 14:03:16 -0400
Message-Id: <20220517180326.997129-2-dqiao@redhat.com>
In-Reply-To: <20220517180326.997129-1-dqiao@redhat.com>
References: <20220517180326.997129-1-dqiao@redhat.com>
Reply-To: dqiao@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the structure definitions from kernel/smp.c to
include/linux/smp.h

Move the structure definitions from include/linux/smp_types.h
to include/linux/smp.h and delete smp_types.h

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
v2 -> v3: Moved the array seq_type[] back to smp.c as Thomas
	   pointed out.
 include/linux/irq_work.h  |   2 +-
 include/linux/smp.h       | 118 ++++++++++++++++++++++++++++++++++++--
 include/linux/smp_types.h |  69 ----------------------
 kernel/smp.c              |  50 ----------------
 4 files changed, 115 insertions(+), 124 deletions(-)
 delete mode 100644 include/linux/smp_types.h

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 8cd11a223260..145af67b1cd3 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_IRQ_WORK_H
 #define _LINUX_IRQ_WORK_H
 
-#include <linux/smp_types.h>
+#include <linux/smp.h>
 #include <linux/rcuwait.h>
 
 /*
diff --git a/include/linux/smp.h b/include/linux/smp.h
index a80ab58ae3f1..94bd901b4e4c 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -10,13 +10,74 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/llist.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
-#include <linux/smp_types.h>
 
 typedef void (*smp_call_func_t)(void *info);
 typedef bool (*smp_cond_func_t)(int cpu, void *info);
 
+enum {
+	CSD_FLAG_LOCK		= 0x01,
+
+	IRQ_WORK_PENDING	= 0x01,
+	IRQ_WORK_BUSY		= 0x02,
+	IRQ_WORK_LAZY		= 0x04, /* No IPI, wait for tick */
+	IRQ_WORK_HARD_IRQ	= 0x08, /* IRQ context on PREEMPT_RT */
+
+	IRQ_WORK_CLAIMED	= (IRQ_WORK_PENDING | IRQ_WORK_BUSY),
+
+	CSD_TYPE_ASYNC		= 0x00,
+	CSD_TYPE_SYNC		= 0x10,
+	CSD_TYPE_IRQ_WORK	= 0x20,
+	CSD_TYPE_TTWU		= 0x30,
+
+	CSD_FLAG_TYPE_MASK	= 0xF0,
+};
+
+/*
+ * struct __call_single_node is the primary type on
+ * smp.c:call_single_queue.
+ *
+ * flush_smp_call_function_queue() only reads the type from
+ * __call_single_node::u_flags as a regular load, the above
+ * (anonymous) enum defines all the bits of this word.
+ *
+ * Other bits are not modified until the type is known.
+ *
+ * CSD_TYPE_SYNC/ASYNC:
+ *	struct {
+ *		struct llist_node node;
+ *		unsigned int flags;
+ *		smp_call_func_t func;
+ *		void *info;
+ *	};
+ *
+ * CSD_TYPE_IRQ_WORK:
+ *	struct {
+ *		struct llist_node node;
+ *		atomic_t flags;
+ *		void (*func)(struct irq_work *);
+ *	};
+ *
+ * CSD_TYPE_TTWU:
+ *	struct {
+ *		struct llist_node node;
+ *		unsigned int flags;
+ *	};
+ *
+ */
+struct __call_single_node {
+	struct llist_node	llist;
+	union {
+		unsigned int	u_flags;
+		atomic_t	a_flags;
+	};
+#ifdef CONFIG_64BIT
+	u16 src, dst;
+#endif
+};
+
 /*
  * structure shares (partial) layout with struct irq_work
  */
@@ -26,13 +87,62 @@ struct __call_single_data {
 	void *info;
 };
 
-#define CSD_INIT(_func, _info) \
-	(struct __call_single_data){ .func = (_func), .info = (_info), }
-
 /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
 typedef struct __call_single_data call_single_data_t
 	__aligned(sizeof(struct __call_single_data));
 
+struct cfd_percpu {
+	call_single_data_t	csd;
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+	u64	seq_queue;
+	u64	seq_ipi;
+	u64	seq_noipi;
+#endif
+};
+
+struct call_function_data {
+	struct cfd_percpu	__percpu *pcpu;
+	cpumask_var_t		cpumask;
+	cpumask_var_t		cpumask_ipi;
+};
+
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+union cfd_seq_cnt {
+	u64		val;
+	struct {
+		u64	src:16;
+		u64	dst:16;
+#define CFD_SEQ_NOCPU	0xffff
+		u64	type:4;
+#define CFD_SEQ_QUEUE	0
+#define CFD_SEQ_IPI	1
+#define CFD_SEQ_NOIPI	2
+#define CFD_SEQ_PING	3
+#define CFD_SEQ_PINGED	4
+#define CFD_SEQ_HANDLE	5
+#define CFD_SEQ_DEQUEUE	6
+#define CFD_SEQ_IDLE	7
+#define CFD_SEQ_GOTIPI	8
+#define CFD_SEQ_HDLEND	9
+		u64	cnt:28;
+	}		u;
+};
+
+struct cfd_seq_local {
+	u64	ping;
+	u64	pinged;
+	u64	handle;
+	u64	dequeue;
+	u64	idle;
+	u64	gotipi;
+	u64	hdlend;
+};
+#endif
+
+#define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
+#define CSD_INIT(_func, _info) \
+	((struct __call_single_data){ .func = (_func), .info = (_info), })
+
 #define INIT_CSD(_csd, _func, _info)		\
 do {						\
 	*(_csd) = CSD_INIT((_func), (_info));	\
diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
deleted file mode 100644
index 2e8461af8df6..000000000000
--- a/include/linux/smp_types.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_SMP_TYPES_H
-#define __LINUX_SMP_TYPES_H
-
-#include <linux/llist.h>
-
-enum {
-	CSD_FLAG_LOCK		= 0x01,
-
-	IRQ_WORK_PENDING	= 0x01,
-	IRQ_WORK_BUSY		= 0x02,
-	IRQ_WORK_LAZY		= 0x04, /* No IPI, wait for tick */
-	IRQ_WORK_HARD_IRQ	= 0x08, /* IRQ context on PREEMPT_RT */
-
-	IRQ_WORK_CLAIMED	= (IRQ_WORK_PENDING | IRQ_WORK_BUSY),
-
-	CSD_TYPE_ASYNC		= 0x00,
-	CSD_TYPE_SYNC		= 0x10,
-	CSD_TYPE_IRQ_WORK	= 0x20,
-	CSD_TYPE_TTWU		= 0x30,
-
-	CSD_FLAG_TYPE_MASK	= 0xF0,
-};
-
-/*
- * struct __call_single_node is the primary type on
- * smp.c:call_single_queue.
- *
- * flush_smp_call_function_queue() only reads the type from
- * __call_single_node::u_flags as a regular load, the above
- * (anonymous) enum defines all the bits of this word.
- *
- * Other bits are not modified until the type is known.
- *
- * CSD_TYPE_SYNC/ASYNC:
- *	struct {
- *		struct llist_node node;
- *		unsigned int flags;
- *		smp_call_func_t func;
- *		void *info;
- *	};
- *
- * CSD_TYPE_IRQ_WORK:
- *	struct {
- *		struct llist_node node;
- *		atomic_t flags;
- *		void (*func)(struct irq_work *);
- *	};
- *
- * CSD_TYPE_TTWU:
- *	struct {
- *		struct llist_node node;
- *		unsigned int flags;
- *	};
- *
- */
-
-struct __call_single_node {
-	struct llist_node	llist;
-	union {
-		unsigned int	u_flags;
-		atomic_t	a_flags;
-	};
-#ifdef CONFIG_64BIT
-	u16 src, dst;
-#endif
-};
-
-#endif /* __LINUX_SMP_TYPES_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index 65a630f62363..4d192ac85a91 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -29,30 +29,7 @@
 #include "smpboot.h"
 #include "sched/smp.h"
 
-#define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
-
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-union cfd_seq_cnt {
-	u64		val;
-	struct {
-		u64	src:16;
-		u64	dst:16;
-#define CFD_SEQ_NOCPU	0xffff
-		u64	type:4;
-#define CFD_SEQ_QUEUE	0
-#define CFD_SEQ_IPI	1
-#define CFD_SEQ_NOIPI	2
-#define CFD_SEQ_PING	3
-#define CFD_SEQ_PINGED	4
-#define CFD_SEQ_HANDLE	5
-#define CFD_SEQ_DEQUEUE	6
-#define CFD_SEQ_IDLE	7
-#define CFD_SEQ_GOTIPI	8
-#define CFD_SEQ_HDLEND	9
-		u64	cnt:28;
-	}		u;
-};
-
 static char *seq_type[] = {
 	[CFD_SEQ_QUEUE]		= "queue",
 	[CFD_SEQ_IPI]		= "ipi",
@@ -65,37 +42,10 @@ static char *seq_type[] = {
 	[CFD_SEQ_GOTIPI]	= "gotipi",
 	[CFD_SEQ_HDLEND]	= "hdlend (src CPU 0 == early)",
 };
-
-struct cfd_seq_local {
-	u64	ping;
-	u64	pinged;
-	u64	handle;
-	u64	dequeue;
-	u64	idle;
-	u64	gotipi;
-	u64	hdlend;
-};
 #endif
 
-struct cfd_percpu {
-	call_single_data_t	csd;
-#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-	u64	seq_queue;
-	u64	seq_ipi;
-	u64	seq_noipi;
-#endif
-};
-
-struct call_function_data {
-	struct cfd_percpu	__percpu *pcpu;
-	cpumask_var_t		cpumask;
-	cpumask_var_t		cpumask_ipi;
-};
-
 static DEFINE_PER_CPU_ALIGNED(struct call_function_data, cfd_data);
-
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
-
 static void flush_smp_call_function_queue(bool warn_cpu_offline);
 
 int smpcfd_prepare_cpu(unsigned int cpu)
-- 
2.27.0

