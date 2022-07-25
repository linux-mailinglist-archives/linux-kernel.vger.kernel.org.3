Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39EA57F9A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiGYGx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiGYGxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:20 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438FEEE01
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:53:15 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220725065311epoutp012f3fb5ed19a9dbeeae43db6d26c4e9fb~E--UppMBQ1626416264epoutp01W
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:53:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220725065311epoutp012f3fb5ed19a9dbeeae43db6d26c4e9fb~E--UppMBQ1626416264epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658731991;
        bh=5+dYD+e/XnrfSnq2UGFHCzRACK1SK6ufOi5AI/P3Tk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mc7A5eFEsSZ54K0VHjOsDE8KOLRnVSVjvriXXxMU/tIIW0k03fXIFuGp7zFYjRP36
         s2JntOVLsZJLU+lebB41CRS+sc9onewGfgkWyohFmS7BEvMk2lTfRe++wCKYbtDzuA
         q/nLVJU/xdqWEr9YPmNaBp8iInQsHcgbYxWU+81k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220725065310epcas1p102c109d86b02631204e30b07926f2bd5~E--UY3iFE1456714567epcas1p13;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.237]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LrrN55RhTz4x9QK; Mon, 25 Jul
        2022 06:53:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.29.09657.5DD3ED26; Mon, 25 Jul 2022 15:53:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epcas1p3c691bbc54c84775524b97c4b717c7ce7~E--S-xj8B2805428054epcas1p3j;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220725065309epsmtrp2a8139fbb87a21e2ac54c45ddbbe44b1d~E--S_dmSR0777907779epsmtrp2P;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
X-AuditID: b6c32a35-71dff700000025b9-c3-62de3dd56a75
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.B6.08802.5DD3ED26; Mon, 25 Jul 2022 15:53:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065309epsmtip21aa02071e745a7e4b83d576f9eb373a1~E--So78U22537425374epsmtip2U;
        Mon, 25 Jul 2022 06:53:09 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com,
        Jiho Chu <jiho.chu@samsung.com>
Subject: [PATCH 2/9] tirnity: Add dma memory module
Date:   Mon, 25 Jul 2022 15:53:01 +0900
Message-Id: <20220725065308.2457024-3-jiho.chu@samsung.com>
In-Reply-To: <20220725065308.2457024-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmge5V23tJBl9+aVr8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzpja61Pw6hFj
        xZ71U5gbGH/tZOxi5OSQEDCRuL9rCnMXIxeHkMAORolHf26yQTifGCVufeyCcj4zSvxaMJmp
        i5EDrOXUUg6I+C5GiSfnnzPDFa08t4IJZC6bgKrEzBlr2EFsEQFvifmtXWDNzAKREtdWVIGE
        hQWMJW7c3MIMYrMAlc9Z3cACYvMKWEu037zHBmJzCthILPixmxkiLihxcuYTsBpmAXmJ5q2z
        wfZKCJxjl5hy/CALxD8uEm0PprJC2MISr45vYYewpSQ+v9vLBmFnS0zpWARVXyBx7vlWZojH
        jCUurkiBOFNTYv0ufYgKRYmdv+cyQqzlk3j3tYcVoppXoqNNCKJESWLJn8NQiyQkps74xgRh
        e0h8+bOECRI6/YwSj092MU5glJ+F5JtZSL6ZhbB5ASPzKkax1ILi3PTUYsMCQ3ikJufnbmIE
        pz8t0x2ME99+0DvEyMTBeIhRgoNZSYS3K+12khBvSmJlVWpRfnxRaU5q8SFGU2D4TmSWEk3O
        BybgvJJ4QxNLAxMzI2MTC0MzQyVx3lXTTicKCaQnlqRmp6YWpBbB9DFxcEo1MK0xaWhhf3/z
        TKpraEbxv+izPw18Plvk+NvkBnVuqLruHHWnz+p9aGLd9iP/zuy57ssWvn7Znqr05/kPf5W+
        TvztwnhxC3NGuLbp4gPnnCT8PjH/+L47+8/WjkaeUDb/e1PX60XL2jwWT2n9yVdw+dCr7zIf
        tyxoCHzbMWnR625uS68T+3yvlhdHX+JO+bnHoKd80iV7EQNjt48Pwv4xywlKPutKiuCSOndx
        1+7bsRK3ut9wLVB9sm3tp8IMzduSDw7oXph47t+6e0tCtj49sFrhU7zh8T1tvLnaNh+nFc1c
        9KF5m/SsWfWdk6c+uhQn+lO1503kkd6tUgdLP+SrLdDmUe+piT96ynDHnTJXp24lluKMREMt
        5qLiRAAI8c29CAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO5V23tJBo8+8lv8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKmNrrU/DqEWPFnvVTmBsYf+1k7GLk4JAQMJE4tZSji5GLQ0hgB6PEuvNPmboYOYHi
        EhKb7i1nhqgRljh8uBii5iOjxNvmWSwgNWwCqhIzZ6xhB7FFBPwl/n46xgpiMwtES6zedh+s
        RljAWOLGzS3MIDYLUP2c1Q1gcV4Ba4n2m/fYQGxOARuJBT92g9UIAcX7u06wQtQISpyc+YQF
        Yqa8RPPW2cwTGPlnIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOFC1
        tHYw7ln1Qe8QIxMH4yFGCQ5mJRHerrTbSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcS
        SE8sSc1OTS1ILYLJMnFwSjUw7WYtL176uuzNecUMwc2ysv9ESt09jZrb7+ZMWtBp9elN+pFI
        l4QsBi5H0eW9x/VX7uKVsajbt/m6n/9yK+5VHjEOB8SmZdodD0pn80zvjbr3oPxqV+zjeWZr
        dA9ffrB7zeOPb/My555ZKMG58E1c++tvB2U/2ey9qGc278qM+/c+MX9d2S91KvqQ+bvTTM++
        VhmovNRUUF6ZWLDxSJj//OTZyX08LM8u8IQfM3qx5xjzvNrSlWlLp84rtZTUjD62NLtlWuo8
        SdVLLUJ7nOOXql9Xj7/JZnyxNFjvWMVLvtcPpUs2utzksTbZtdn6PlP/+tAK/Xtip8x2nT13
        /kl8+Sphu9etDtpn9NS37I+wVWIpzkg01GIuKk4EAIqtj9DDAgAA
X-CMS-MailID: 20220725065309epcas1p3c691bbc54c84775524b97c4b717c7ce7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065309epcas1p3c691bbc54c84775524b97c4b717c7ce7
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065309epcas1p3c691bbc54c84775524b97c4b717c7ce7@epcas1p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes memory management module.

It provides abstraction layer to handle DMA buffer.
The buffers are reserved when the driver starts, and are
used by the user request. The alloc/dealloc functions
are provided to access the DMA buffer, and the reference
of the buffers is counted.

DMA buffer address and allocation of it are depend on each
hardware, so config for supported hardware is introduced.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/Makefile              |   1 +
 drivers/misc/trinity/trinity.c             |  91 +++++
 drivers/misc/trinity/trinity_common.h      |   2 +-
 drivers/misc/trinity/trinity_hwmem.c       | 438 +++++++++++++++++++++
 drivers/misc/trinity/trinity_hwmem.h       |  45 +++
 drivers/misc/trinity/trinity_resv_mem.c    | 264 +++++++++++++
 drivers/misc/trinity/trinity_resv_mem.h    |  41 ++
 drivers/misc/trinity/trinity_vision2_drv.c |   1 +
 8 files changed, 882 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/trinity/trinity_hwmem.c
 create mode 100644 drivers/misc/trinity/trinity_hwmem.h
 create mode 100644 drivers/misc/trinity/trinity_resv_mem.c
 create mode 100644 drivers/misc/trinity/trinity_resv_mem.h

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index a8e5697d6d85..cf313c3afb3d 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -3,5 +3,6 @@
 obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
 
 trinity-y := trinity.o
+trinity-y += trinity_resv_mem.o trinity_hwmem.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index a85904c17f2e..1ee9403dbdca 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -33,6 +33,7 @@
 #include <linux/uaccess.h>
 
 #include "trinity_common.h"
+#include "trinity_resv_mem.h"
 
 #define BASE_DEV_NAME "trinity"
 
@@ -163,11 +164,88 @@ int trinity_open(struct inode *inode, struct file *f)
 	return 0;
 }
 
+/**
+ * trinity_get_dma_memory() - Get the DMA memory information
+ *
+ * @dev: device structure
+ * @paddr: acquired physical address
+ * @daddr: acquired DMA address
+ * @size: acquired size of the resource
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+static int trinity_get_dma_memory(struct device *dev, phys_addr_t *paddr,
+			   dma_addr_t *daddr, size_t *size)
+{
+	struct device_node *np;
+	struct resource res;
+	int err;
+
+	if (!dev || !paddr || !daddr || !size)
+		return -EINVAL;
+
+	np = dev->of_node;
+	if (!np)
+		return -ENOENT;
+
+#ifdef ARM64
+	err = of_property_read_u64_array(np, "samsung,dma", info, 3);
+	if (err < 0)
+		return err;
+
+	*paddr = info[0];
+	*daddr = info[1];
+	*size = info[2];
+#else
+	err = of_address_to_resource(np, 0, &res);
+	if (err < 0)
+		return err;
+
+	*paddr = res.start;
+	*daddr = *paddr;
+	*size = resource_size(&res);
+#endif
+
+	dev_info(dev, "Detected DMA memory region: %lx-%lx",
+		 (unsigned long)*paddr, (unsigned long)(*paddr + *size));
+	return 0;
+}
+
+static int trinity_declare_dma_memory(struct device *dev)
+{
+	phys_addr_t paddr;
+	dma_addr_t daddr;
+	size_t size;
+	int err;
+
+	err = trinity_get_dma_memory(dev, &paddr, &daddr, &size);
+	if (err < 0) {
+		dev_info(dev, "No available dma memory, skipping");
+		return 0;
+	}
+
+	err = trinity_declare_resv_mem(paddr, daddr, size);
+	if (err < 0) {
+		dev_err(dev, "Failed to declare reserved memory: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void trinity_release_dma_memory(void)
+{
+	return trinity_release_resv_mem();
+}
+
 static void trinity_common_init(struct device *dev)
 {
 	if (!trinity_is_empty())
 		return;
 
+	if (trinity_declare_dma_memory(dev) < 0)
+		dev_warn(dev, "Failed to declare DMA memory\n");
+
 	/* Common init codes */
 }
 
@@ -176,6 +254,7 @@ static void trinity_common_exit(void)
 	if (!trinity_is_empty())
 		return;
 
+	trinity_release_dma_memory();
 	/* Common deinit codes */
 }
 
@@ -203,6 +282,13 @@ static int trinity_set_device_id(struct trinity_driver *drv)
 	return err;
 }
 
+/**
+ * trinity_create_node() - Create trinity node
+ *
+ * @drv: an instance of trinity driver
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
 int trinity_create_node(struct trinity_driver *drv)
 {
 	struct device *dev = drv_to_dev_ptr(drv);
@@ -222,6 +308,11 @@ int trinity_create_node(struct trinity_driver *drv)
 	return err;
 }
 
+/**
+ * trinity_destroy_node() - Destroy trinity node
+ *
+ * @drv: an instance of trinity driver
+ */
 void trinity_destroy_node(struct trinity_driver *drv)
 {
 	misc_deregister(&drv->mdev);
diff --git a/drivers/misc/trinity/trinity_common.h b/drivers/misc/trinity/trinity_common.h
index 37aba34ef9bc..7f576d4a71a5 100644
--- a/drivers/misc/trinity/trinity_common.h
+++ b/drivers/misc/trinity/trinity_common.h
@@ -25,7 +25,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-
 #include <uapi/misc/trinity.h>
 
 /** Default timeout to wait for opening device in jiffies */
@@ -131,6 +130,7 @@ struct trinity_desc {
 			    struct trinity_req *req);
 	int32_t (*invoke_req)(struct trinity_driver *drv,
 			      struct trinity_req *req, void *sched_data);
+
 	irq_handler_t handle_irq;
 };
 
diff --git a/drivers/misc/trinity/trinity_hwmem.c b/drivers/misc/trinity/trinity_hwmem.c
new file mode 100644
index 000000000000..069c856589e3
--- /dev/null
+++ b/drivers/misc/trinity/trinity_hwmem.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * An abstraction layer to handle DMA memory buffers for Trinity device driver
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/version.h>
+
+#include "trinity_hwmem.h"
+#include "trinity_resv_mem.h"
+
+#define dbuf_to_trnt_hwmem(d) ((struct trinity_hwmem *)d->priv)
+#define vma_to_trnt_hwmem(v) ((struct trinity_hwmem *)v->vm_private_data)
+
+/**
+ * struct trinity_hwmem - A data structure for Trinity DMA buffer management
+ * @dev: A pointer to device which this hwmem belongs to.
+ * @dbuf: The dma_buf instance.
+ * @refcnt: Reference counts.
+ * @direction: A variable indicating the DMA data direction in allocating this
+ *		dma_buf.
+ * @attrs: Attributes used in allocating this dma_buf.
+ * @req_size: The size of the DMA buffer that the user request to allocate.
+ * @alc_size: The size of the DMA buffer which is actually allocated.
+ * @addr: The DMA (physical) address of this dma_buf.
+ * @cookie: The DMA cookies.
+ */
+struct trinity_hwmem {
+	struct device *dev;
+	struct dma_buf *dbuf;
+	struct kref refcnt;
+
+	enum dma_data_direction direction;
+	enum trinity_hwmem_type type;
+
+	unsigned long attrs;
+	size_t req_size;
+	size_t alc_size;
+
+	bool is_cont;
+	dma_addr_t addr;
+	void *cookie;
+};
+
+static void __trinity_hwmem_free(struct kref *refcnt)
+{
+	struct trinity_hwmem *mem =
+		container_of(refcnt, struct trinity_hwmem, refcnt);
+	/**
+	 * when the dmabuf reference counter becomes zero,
+	 * trinity_hwmem_dbuf_ops_release() is triggered.
+	 */
+	dma_buf_put(mem->dbuf);
+}
+
+static void __trinity_hwmem_put(struct trinity_hwmem *mem)
+{
+	kref_put(&mem->refcnt, __trinity_hwmem_free);
+}
+
+static void __trinity_hwmem_put_dmabuf(struct dma_buf *dbuf)
+{
+	__trinity_hwmem_put(dbuf_to_trnt_hwmem(dbuf));
+}
+
+static struct trinity_hwmem *__trinity_hwmem_get(struct trinity_hwmem *mem)
+{
+	kref_get(&mem->refcnt);
+
+	return mem;
+}
+
+static void trinity_hwmem_dbuf_ops_detach(struct dma_buf *dbuf,
+					  struct dma_buf_attachment *attachment)
+{
+	struct trinity_hwmem *mem = dbuf_to_trnt_hwmem(dbuf);
+
+	/* Decrease ref count of the backing storage */
+	__trinity_hwmem_put(mem);
+}
+
+static int trinity_hwmem_dbuf_ops_attach(struct dma_buf *dbuf,
+					 struct dma_buf_attachment *attachment)
+{
+	struct trinity_hwmem *mem = dbuf_to_trnt_hwmem(dbuf);
+
+	/* Increase ref count of the backing storage */
+	mem = __trinity_hwmem_get(mem);
+	attachment->priv = mem;
+
+	return 0;
+}
+
+static struct sg_table *
+trinity_hwmem_dbuf_ops_map_dma_buf(struct dma_buf_attachment *attachment,
+				   enum dma_data_direction dir)
+{
+	return NULL;
+}
+
+static void
+trinity_hwmem_dbuf_ops_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				     struct sg_table *sgt,
+				     enum dma_data_direction dir)
+{
+}
+
+static void trinity_hwmem_vm_ops_open(struct vm_area_struct *vma)
+{
+	struct trinity_hwmem *mem = vma_to_trnt_hwmem(vma);
+
+	__trinity_hwmem_get(mem);
+}
+
+static void trinity_hwmem_vm_ops_close(struct vm_area_struct *vma)
+{
+	struct trinity_hwmem *mem = vma_to_trnt_hwmem(vma);
+
+	__trinity_hwmem_put(mem);
+}
+
+static const struct vm_operations_struct trinity_hwmem_vm_ops = {
+	.open = trinity_hwmem_vm_ops_open,
+	.close = trinity_hwmem_vm_ops_close,
+};
+
+static int32_t trinity_hwmem_dbuf_ops_mmap(struct dma_buf *dbuf,
+					   struct vm_area_struct *vma)
+{
+	struct trinity_hwmem *mem;
+	int32_t ret;
+
+	if (!dbuf)
+		return -EINVAL;
+
+	mem = dbuf_to_trnt_hwmem(dbuf);
+	if (!mem)
+		return -EINVAL;
+
+	vma->vm_pgoff = 0;
+	if (mem->type == TRINITY_HWMEM_DMA_CONT)
+		ret = trinity_mmap_from_resv_mem(vma, mem->cookie,
+						 mem->alc_size, mem->is_cont);
+	else
+		ret = dma_mmap_attrs(mem->dev, vma, mem->cookie, mem->addr,
+				     mem->alc_size, mem->attrs);
+	if (ret)
+		return ret;
+
+	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
+	vma->vm_private_data = mem;
+	vma->vm_ops = &trinity_hwmem_vm_ops;
+
+	vma->vm_ops->open(vma);
+
+	return 0;
+}
+
+static void trinity_hwmem_dbuf_ops_release(struct dma_buf *dbuf)
+{
+	struct trinity_hwmem *mem = dbuf_to_trnt_hwmem(dbuf);
+
+	if (mem->type == TRINITY_HWMEM_DMA_CONT) {
+		struct trinity_resv_mem resv_mem;
+
+		resv_mem.vaddr = mem->cookie;
+		resv_mem.daddr = mem->addr;
+		resv_mem.size = mem->alc_size;
+
+		trinity_free_from_resv_mem(&resv_mem, mem->is_cont);
+	} else {
+		dma_free_attrs(mem->dev, mem->alc_size, mem->cookie, mem->addr,
+			       mem->attrs);
+	}
+	put_device(mem->dev);
+
+	mem->dbuf->priv = NULL;
+
+	kfree(mem);
+}
+
+static int trinity_hwmem_dbuf_ops_vmap(struct dma_buf *dbuf,
+				       struct iosys_map *map)
+{
+	struct trinity_hwmem *mem;
+
+	if (!dbuf)
+		return -EINVAL;
+
+	mem = dbuf_to_trnt_hwmem(dbuf);
+	if (!mem)
+		return -ENOENT;
+
+	map->vaddr = mem->cookie;
+
+	return 0;
+}
+
+static struct dma_buf_ops trinity_hwmem_dbuf_ops = {
+	.vmap = trinity_hwmem_dbuf_ops_vmap,
+	.attach = trinity_hwmem_dbuf_ops_attach,
+	.detach = trinity_hwmem_dbuf_ops_detach,
+	.map_dma_buf = trinity_hwmem_dbuf_ops_map_dma_buf,
+	.unmap_dma_buf = trinity_hwmem_dbuf_ops_unmap_dma_buf,
+	.release = trinity_hwmem_dbuf_ops_release,
+	.mmap = trinity_hwmem_dbuf_ops_mmap,
+};
+
+static void *__trinity_hwmem_alloc(struct device *dev, const size_t size,
+				   const enum dma_data_direction dir,
+				   const enum trinity_hwmem_type type)
+{
+	size_t aligned_size = ALIGN(size, PAGE_SIZE);
+	struct trinity_hwmem *mem;
+	struct trinity_resv_mem resv_mem;
+	int ret;
+
+	if (WARN_ON(!dev))
+		return ERR_PTR(-EINVAL);
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return ERR_PTR(-ENOMEM);
+
+	mem->dev = get_device(dev);
+	mem->req_size = size;
+	mem->alc_size = aligned_size;
+	mem->direction = dir;
+	mem->type = TRINITY_HWMEM_DMA_IOMMU;
+	mem->is_cont = (type == TRINITY_HWMEM_DMA_CONT);
+
+	mem->attrs |= DMA_ATTR_WRITE_COMBINE;
+	mem->attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+
+	/**
+	 * Trying to alloc memery from resv mem first regardless of hwmem type.
+	 * But, the resv allocator should preserve a minimum space for vISA programs
+	 * because they should be physically contiguous.
+	 */
+	ret = trinity_alloc_from_resv_mem(aligned_size, &resv_mem,
+					  mem->is_cont);
+	if (ret == 0) {
+		mem->addr = resv_mem.daddr;
+		mem->cookie = resv_mem.vaddr;
+		mem->type = TRINITY_HWMEM_DMA_CONT;
+	} else if (!mem->is_cont) {
+		mem->cookie = dma_alloc_attrs(dev, aligned_size, &mem->addr,
+					      GFP_KERNEL, mem->attrs);
+	} else {
+		dev_err(mem->dev,
+			"Unable alloc contiguous memory for program: %zu\n",
+			size);
+	}
+
+	if (!mem->cookie) {
+		ret = -ENOMEM;
+		goto free_mem;
+	}
+
+	kref_init(&mem->refcnt);
+
+	return mem;
+
+free_mem:
+	kfree(mem);
+
+	return ERR_PTR(ret);
+}
+
+static struct dma_buf *__trinity_hwmem_get_dmabuf(struct trinity_hwmem *mem,
+						  unsigned long flags)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(einfo);
+	struct dma_buf *dbuf;
+
+	einfo.ops = &trinity_hwmem_dbuf_ops;
+	einfo.size = mem->alc_size;
+	einfo.flags = flags;
+	einfo.priv = (void *)mem;
+
+	dbuf = dma_buf_export(&einfo);
+	if (IS_ERR(dbuf))
+		return dbuf;
+
+	/* Increase ref count of the backing storage */
+	dbuf->priv = (void *)__trinity_hwmem_get(mem);
+	mem->dbuf = dbuf;
+
+	return dbuf;
+}
+
+/**
+ * trinity_hwmem_alloc() - Allocate Hardware memory according to type
+ * @dev: A pointer to the instance of the device to be attached the DMA buffer
+ * @size: Requested memory size
+ * @type: Requested memory type. It will try to allocate from reserved memory first
+ *
+ * Return: a file descriptor for the dma buffer on success.
+ *         Otherwise, returns negative error.
+ */
+int32_t trinity_hwmem_alloc(struct device *dev, const size_t size,
+			    enum trinity_hwmem_type type)
+{
+	struct trinity_hwmem *mem;
+	struct dma_buf *dbuf;
+	int32_t ret;
+
+	mem = __trinity_hwmem_alloc(dev, size, DMA_BIDIRECTIONAL, type);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
+
+	dbuf = __trinity_hwmem_get_dmabuf(mem, O_CLOEXEC | O_RDWR);
+	if (IS_ERR(dbuf)) {
+		ret = PTR_ERR(dbuf);
+		goto err_put_mem;
+	}
+
+	ret = dma_buf_fd(dbuf, O_CLOEXEC);
+	if (ret < 0)
+		goto err_put_mem;
+
+	return ret;
+
+err_put_mem:
+	__trinity_hwmem_put(mem);
+
+	return ret;
+}
+
+/**
+ * trinity_hwmem_free() - Free Hardware memory
+ * @dev: A pointer to the instance of the device to be attached the DMA buffer
+ * @fd: A file descriptor for a allocated memory
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int32_t trinity_hwmem_free(struct device *dev, const int32_t fd)
+{
+	struct dma_buf *dbuf;
+
+	dbuf = dma_buf_get(fd);
+	if (!IS_ERR(dbuf)) {
+		struct trinity_hwmem *mem = dbuf_to_trnt_hwmem(dbuf);
+
+		/* Counter part of __trinity_hwmem_get() in __trinity_hwmem_get_dmabuf() */
+		__trinity_hwmem_put_dmabuf(dbuf);
+		/* Counter part of __trinity_hwmem_get() in __trinity_hwmem_alloc() */
+		__trinity_hwmem_put(mem);
+
+		dma_buf_put(dbuf);
+
+		return 0;
+	}
+
+	dev_err(dev,
+		"failed to free the dma_buf structure realted to fd with %ld\n",
+		PTR_ERR(dbuf));
+
+	return PTR_ERR(dbuf);
+}
+
+/**
+ * trinity_hwmem_import_dmabuf_begin() - Defines the beginning of a section to
+ *		import a given DMA buffer file descriptor.
+ * @dev: A pointer to the instance of the device to be attached the DMA buffer
+ * @dbuf_fd: The file descriptor of the DMA buffer to be imported.
+ * @import_info: If importing is successful, information such as the DMA
+ *		address, the virtual address which is mapped to the DMA address,
+ *		&struct dma_buf_attachment, a scatter-gather table, and &struct
+ *		dma_buf corresponding to the file descriptor will be passed
+ *		using this parameter.
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int32_t
+trinity_hwmem_import_dmabuf_begin(struct device *dev, const int32_t dbuf_fd,
+				  struct trinity_hwmem_import *import_info)
+{
+	struct dma_buf_attachment *attachment;
+	struct dma_buf *buf;
+	struct trinity_hwmem *mem;
+	struct iosys_map map;
+	int32_t ret;
+
+	if (!import_info)
+		return -EINVAL;
+
+	buf = dma_buf_get(dbuf_fd);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	attachment = dma_buf_attach(buf, dev);
+	if (IS_ERR(attachment)) {
+		ret = PTR_ERR(attachment);
+		goto err_dbuf_put;
+	}
+
+	mem = attachment->priv;
+	import_info->dma_addr = mem->addr;
+	ret = dma_buf_vmap(buf, &map);
+	if (ret)
+		goto err_dbuf_put;
+
+	import_info->addr = map.vaddr;
+	import_info->attachment = attachment;
+	import_info->buf = buf;
+
+	return 0;
+
+err_dbuf_put:
+	dma_buf_put(buf);
+
+	return ret;
+}
+
+/**
+ * trinity_hwmem_import_dmabuf_end() - Defines the ending of the section related
+ *		to the given pointer to &strut trinity_hwmem_import.
+ * @import_info: Importing information related to the section to be ended.
+ */
+void trinity_hwmem_import_dmabuf_end(struct trinity_hwmem_import *import_info)
+{
+	if (!import_info || !import_info->buf)
+		return;
+	dma_buf_vunmap(import_info->buf, import_info->addr);
+	dma_buf_detach(import_info->buf, import_info->attachment);
+	dma_buf_put(import_info->buf);
+}
diff --git a/drivers/misc/trinity/trinity_hwmem.h b/drivers/misc/trinity/trinity_hwmem.h
new file mode 100644
index 000000000000..a64b83a1eec9
--- /dev/null
+++ b/drivers/misc/trinity/trinity_hwmem.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * An abstraction layer to handle DMA memory buffers for Trinity device driver
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __DRIVERS_MISC_TRINITY_HWMEM_H__
+#define __DRIVERS_MISC_TRINITY_HWMEM_H__
+
+#include <linux/dma-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/kref.h>
+#include <uapi/misc/trinity.h>
+
+/**
+ * struct trinity_hwmem_import - A data structure to maintin imported hwmem
+ *   (that is Trinity DMA buffer).
+ * @dma_addr: The physical DMA address of this DMA buffer.
+ * @addr: A virtual address of this DMA buffer.
+ * @attachment: A pointer to &struct dma_buf_attachment.
+ * @buf: &struct dma_buf that this hwmem wrapped.
+ */
+struct trinity_hwmem_import {
+	dma_addr_t dma_addr;
+	void *addr;
+	struct dma_buf_attachment *attachment;
+	struct dma_buf *buf;
+};
+
+int32_t
+trinity_hwmem_import_dmabuf_begin(struct device *dev, const int32_t dbuf_fd,
+				  struct trinity_hwmem_import *import_info);
+void trinity_hwmem_import_dmabuf_end(struct trinity_hwmem_import *import_info);
+
+int32_t trinity_hwmem_alloc(struct device *dev, const size_t size,
+			    enum trinity_hwmem_type type);
+int32_t trinity_hwmem_free(struct device *dev, const int32_t fd);
+
+#endif /* __DRIVERS_MISC_TRINITY_HWMEM_H__ */
diff --git a/drivers/misc/trinity/trinity_resv_mem.c b/drivers/misc/trinity/trinity_resv_mem.c
new file mode 100644
index 000000000000..9279452b9b2d
--- /dev/null
+++ b/drivers/misc/trinity/trinity_resv_mem.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Reserved memory allocator for Trinity device drivers
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include "trinity_resv_mem.h"
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#define PROG_POOL_SIZE (6 * 1024 * 1024) /* FIXME: 6MB */
+#define IS_INITIALIZED(pool) (atomic_read(&((pool)->initialized)) == 1)
+#define SET_INITIALIZED(pool) atomic_set(&((pool)->initialized), 1)
+#define UNSET_INITIALIZED(pool) atomic_set(&((pool)->initialized), 0)
+
+struct trinity_resv_mem_pool {
+	phys_addr_t paddr_base;
+	dma_addr_t daddr_base;
+	void *vaddr_base;
+
+	size_t total_size;
+	size_t total_used;
+
+	unsigned int num_bits;
+	unsigned long *bitmap;
+
+	spinlock_t lock;
+	atomic_t initialized;
+};
+
+/* Trinity devices share this reserved memory pool */
+static struct trinity_resv_mem_pool resv_pool_cont;
+static struct trinity_resv_mem_pool resv_pool_norm;
+
+static int init_resv_mem(phys_addr_t paddr, dma_addr_t daddr, size_t size,
+			 struct trinity_resv_mem_pool *pool)
+{
+	unsigned int num_bits = size >> PAGE_SHIFT;
+	int bitmap_size = BITS_TO_LONGS(num_bits) * sizeof(long);
+	void *vaddr;
+
+	vaddr = ioremap_wc(paddr, size);
+	if (unlikely(!vaddr))
+		return -EINVAL;
+
+	pool->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
+	if (unlikely(!pool->bitmap)) {
+		iounmap(vaddr);
+		return -ENOMEM;
+	}
+
+	pool->paddr_base = paddr;
+	pool->daddr_base = daddr;
+	pool->vaddr_base = vaddr;
+	pool->total_size = size;
+	pool->total_used = 0;
+	pool->num_bits = num_bits;
+
+	spin_lock_init(&pool->lock);
+	SET_INITIALIZED(pool);
+
+	return 0;
+}
+
+static void fini_resv_mem(struct trinity_resv_mem_pool *pool)
+{
+	if (!pool || unlikely(!IS_INITIALIZED(pool)))
+		return;
+
+	UNSET_INITIALIZED(pool);
+
+	iounmap(pool->vaddr_base);
+	kfree(pool->bitmap);
+	memset(pool, '\x00', sizeof(*pool));
+}
+
+/**
+ * trinity_declare_resv_mem() - Declare reserved memory
+ *
+ * @dev: a pointer to the instance of the device to be attached the DMA buffer
+ * @daddr: DMA buffer address to be used for reserved memory
+ * @size: size of requested memory
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_declare_resv_mem(phys_addr_t paddr, dma_addr_t daddr, size_t size)
+{
+	int ret;
+
+	/* skip if initialized before */
+	if (unlikely(IS_INITIALIZED(&resv_pool_cont) ||
+		     IS_INITIALIZED(&resv_pool_norm)))
+		return 0;
+
+	ret = init_resv_mem(paddr, daddr, PROG_POOL_SIZE, &resv_pool_cont);
+	if (ret != 0)
+		return ret;
+
+	/* FIXME: reserve the first page (not used) */
+	set_bit(0, resv_pool_cont.bitmap);
+	resv_pool_cont.total_used = PAGE_SIZE;
+
+	ret = init_resv_mem(paddr + PROG_POOL_SIZE, daddr + PROG_POOL_SIZE,
+			    size - PROG_POOL_SIZE, &resv_pool_norm);
+	if (ret != 0) {
+		fini_resv_mem(&resv_pool_cont);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * trinity_release_resv_mem() - Release reserved memory
+ *
+ */
+void trinity_release_resv_mem(void)
+{
+	fini_resv_mem(&resv_pool_cont);
+	fini_resv_mem(&resv_pool_norm);
+}
+
+static int find_free_region(unsigned long *bitmap, unsigned long num_bits,
+			    unsigned long nr)
+{
+	unsigned long index, start, end, i;
+
+	start = 0;
+retry:
+	index = find_next_zero_bit(bitmap, num_bits, start);
+	end = index + nr;
+	if (end > num_bits)
+		return -ERANGE;
+
+	i = find_next_bit(bitmap, end, index);
+	if (i < end) {
+		start = i + 1;
+		goto retry;
+	}
+	return index;
+}
+
+/**
+ * trinity_alloc_from_resv_mem() - Allocate reserved memory
+ *
+ * @size: size of requested memory
+ * @mem: allocated reserved memory information
+ * @is_cont: continuity of the memory region
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_alloc_from_resv_mem(const size_t size, struct trinity_resv_mem *mem,
+				bool is_cont)
+{
+	struct trinity_resv_mem_pool *pool;
+	dma_addr_t offset;
+	int pageno, err = 0;
+
+	pool = is_cont ? &resv_pool_cont : &resv_pool_norm;
+
+	if (unlikely(!IS_INITIALIZED(pool)))
+		return -EPERM;
+
+	if (unlikely(!IS_ALIGNED(size, PAGE_SIZE)))
+		return -EINVAL;
+
+	spin_lock(&pool->lock);
+
+	if (unlikely(size > pool->total_size)) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	pageno = find_free_region(pool->bitmap, pool->num_bits,
+				  size >> PAGE_SHIFT);
+	if (unlikely(pageno < 0)) {
+		err = pageno;
+		goto out;
+	}
+	bitmap_set(pool->bitmap, pageno, size >> PAGE_SHIFT);
+	offset = (dma_addr_t)pageno << PAGE_SHIFT;
+
+	mem->daddr = pool->daddr_base + offset;
+	mem->vaddr = pool->vaddr_base + offset;
+	mem->size = size;
+
+	memset(mem->vaddr, '\x00', size);
+
+	pool->total_used += mem->size;
+out:
+	spin_unlock(&pool->lock);
+
+	return err;
+}
+
+/**
+ * trinity_free_from_resv_mem() - Free reserved memory
+ *
+ * @mem: allocated reserved memory information
+ * @is_cont: continuity of the memory region
+ */
+void trinity_free_from_resv_mem(struct trinity_resv_mem *mem, bool is_cont)
+{
+	struct trinity_resv_mem_pool *pool;
+
+	pool = is_cont ? &resv_pool_cont : &resv_pool_norm;
+
+	if (unlikely(!IS_INITIALIZED(pool)))
+		return;
+
+	if (likely(mem->vaddr != NULL)) {
+		int page = (mem->vaddr - pool->vaddr_base) >> PAGE_SHIFT;
+		int len = mem->size >> PAGE_SHIFT;
+
+		spin_lock(&pool->lock);
+
+		bitmap_clear(pool->bitmap, page, len);
+		pool->total_used -= mem->size;
+
+		spin_unlock(&pool->lock);
+	}
+}
+
+/**
+ * trinity_mmap_from_resv_mem() - mmap for reserved memory
+ *
+ * @vma: vma to map
+ * @vaddr: target virtual address
+ * @size: size of map area
+ * @is_cont: continuity of the memory region
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_mmap_from_resv_mem(struct vm_area_struct *vma, void *vaddr,
+			       size_t size, bool is_cont)
+{
+	struct trinity_resv_mem_pool *pool;
+
+	pool = is_cont ? &resv_pool_cont : &resv_pool_norm;
+
+	if (likely(IS_INITIALIZED(pool))) {
+		unsigned long off = vma->vm_pgoff;
+		unsigned long pfn_base = PFN_DOWN(pool->paddr_base);
+		int start = (vaddr - pool->vaddr_base) >> PAGE_SHIFT;
+		int user_count = vma_pages(vma);
+		int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+		if (off < count && user_count <= count - off) {
+			unsigned long pfn = pfn_base + start + off;
+
+			return remap_pfn_range(vma, vma->vm_start, pfn,
+					       user_count << PAGE_SHIFT,
+					       vma->vm_page_prot);
+		}
+	}
+
+	return -ENXIO;
+}
diff --git a/drivers/misc/trinity/trinity_resv_mem.h b/drivers/misc/trinity/trinity_resv_mem.h
new file mode 100644
index 000000000000..94b1c712aa1d
--- /dev/null
+++ b/drivers/misc/trinity/trinity_resv_mem.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Reserved memory allocator for Trinity device drivers
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __DRIVERS_MISC_TRINITY_RESV_MEM_H__
+#define __DRIVERS_MISC_TRINITY_RESV_MEM_H__
+
+#include <linux/mm_types.h>
+#include <linux/types.h>
+
+/**
+ * struct trinity_resv_mem - A data structure to maintin reserved memory
+ *
+ * @daddr: The physical DMA address of this DMA buffer.
+ * @vaddr: A virtual address of this DMA buffer.
+ * @size: allocated reserved memory size. page aligned.
+ * @orig_size: requested memory size
+ */
+struct trinity_resv_mem {
+	dma_addr_t daddr;
+	void *vaddr;
+	size_t size;
+	size_t orig_size;
+};
+
+int trinity_declare_resv_mem(phys_addr_t paddr, dma_addr_t daddr, size_t size);
+void trinity_release_resv_mem(void);
+int trinity_alloc_from_resv_mem(const size_t size, struct trinity_resv_mem *mem,
+				bool is_prog);
+void trinity_free_from_resv_mem(struct trinity_resv_mem *mem, bool is_prog);
+int trinity_mmap_from_resv_mem(struct vm_area_struct *vma, void *vaddr,
+			       size_t size, bool is_prog);
+
+#endif /* __DRIVERS_MISC_TRINITY_RESV_MEM_H__ */
diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index a24eb0f6ac6d..f1c1e06d188e 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -507,6 +507,7 @@ static struct platform_driver trinity_triv2 = {
 
 module_platform_driver(trinity_triv2);
 
+MODULE_IMPORT_NS(DMA_BUF);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Samsung Electronics");
 MODULE_DESCRIPTION("Samsung NPU device driver for trinity vision 2");
-- 
2.25.1

