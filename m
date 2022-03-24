Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD54E6122
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349251AbiCXJff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349238AbiCXJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:35:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6E21C6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:33:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B4B7B8232D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE187C340F0;
        Thu, 24 Mar 2022 09:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648114437;
        bh=AA9g94G/LYSHBW4Zjqedz91lglwQEkZc4D8zQGNSWBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEhfyai+tTB+290mbc9Vq0u0xgavGYcQbj9kmYPaElgbZ+Q41Y4I25i12gYv3JMTd
         eyn3umJDI1OCG+2OZjKxvP4pcs7wSKVc/Sks6e/U3rjpOnblOhsRi8teD/1sDWRxw9
         z69ialAmHnppKuEFrvG1YtCnZminuOdm3tNdvsfw5vrn9XGC/YKmANIHaNepTFdCym
         vJcXwMJ42xdtG1bmFH99luGFglDpzePMFxA0XwisdpFKq1bHJB/QPKP5Td0fayOjLL
         /OFQbo18ZX176FnZuG8IMgrYxxvrTaFZXDZ3EYK44YNbkKv2whzRXy9Vu7fUVTK+a2
         rkf1JarVSbgyg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 2/7] habanalabs: unified memory manager infrastructure
Date:   Thu, 24 Mar 2022 11:33:44 +0200
Message-Id: <20220324093349.3245973-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324093349.3245973-1-ogabbay@kernel.org>
References: <20220324093349.3245973-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

This is a part of overall refactoring attempt to separate nic and the
core drivers.
Currently, there are 4 different flows, that contain very similar code.
These are the ts, nic, hwblocks and cb alloc/map flows. The similar
aspect of all these flows is that they all contain a central store, with
memory buffers inside, supporting the following set of operations:

- Allocate buffer and return handle
- Get buffer from the store with handle
- Put the buffer (last put releases the buffer)
- Map the buffer to the user

This patch contains a generic data structure used to implement the above
memory buffer store interface. Conversion of the existing code to use
the new data structure will follow.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/Makefile     |   2 +-
 drivers/misc/habanalabs/common/habanalabs.h |  51 ++++
 drivers/misc/habanalabs/common/memory_mgr.c | 281 ++++++++++++++++++++
 3 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/habanalabs/common/memory_mgr.c

diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index 6ebe3c7001ff..934a3a4aedc9 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -11,4 +11,4 @@ HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
 		common/sysfs.o common/hwmon.o common/memory.o \
 		common/command_submission.o common/firmware_if.o \
-		common/state_dump.o
+		common/state_dump.o common/memory_mgr.o
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9c70d95883a2..1859ace28783 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -741,6 +741,57 @@ struct hl_ts_buff {
 	u32			user_buff_size;
 };
 
+struct hl_mmap_mem_buf;
+
+/**
+ * struct hl_mem_mgr - describes unified memory manager for mappable memory chunks.
+ * @dev: back pointer to the owning device
+ * @lock: protects handles
+ * @handles: an idr holding all active handles to the memory buffers in the system.
+ */
+struct hl_mem_mgr {
+	struct device *dev;
+	spinlock_t lock;
+	struct idr handles;
+};
+
+/**
+ * struct hl_mmap_mem_buf_ops - describes unified memory manager buffer behavior
+ * @alloc: callback executed on buffer allocation, shall allocate the memory,
+ *         set it under buffer private, and set mappable size.
+ * @mmap: callback executed on mmap, must map the buffer to vma
+ * @release: callback executed on release, must free the resources used by the buffer
+ */
+struct hl_mmap_mem_buf_ops {
+	int (*alloc)(struct hl_mmap_mem_buf *buf, gfp_t gfp, void *args);
+	int (*mmap)(struct hl_mmap_mem_buf *buf, struct vm_area_struct *vma, void *args);
+	void (*release)(struct hl_mmap_mem_buf *buf);
+};
+
+/**
+ * struct hl_mmap_mem_buf_ops - describes a single unified memory buffer
+ * @ops: buffer behavior
+ * @mmg: back pointer to the unified memory manager
+ * @refcount: reference counter for buffer users
+ * @private: pointer to buffer behavior private data
+ * @mmap: atomic boolean indicating whether or not the buffer is mapped right now
+ * @real_mapped_size: the actual size of buffer mapped, after part of it may be released,
+ *                   may change at runtime.
+ * @mappable_size: the original mappable size of the buffer, does not change after
+ *                 the allocation.
+ * @handle: the buffer id in mmg handles store
+ */
+struct hl_mmap_mem_buf {
+	struct hl_mmap_mem_buf_ops *ops;
+	struct hl_mem_mgr *mmg;
+	struct kref refcount;
+	void *private;
+	atomic_t mmap;
+	u64 real_mapped_size;
+	u64 mappable_size;
+	u32 handle;
+};
+
 /**
  * struct hl_cb - describes a Command Buffer.
  * @refcount: reference counter for usage of the CB.
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
new file mode 100644
index 000000000000..3828ba44c660
--- /dev/null
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+/**
+ * hl_mmap_mem_buf_get - increase the buffer refcount and return a pointer to
+ *                        the buffer descriptor.
+ *
+ * @mmg: parent unifed memory manager
+ * @handle: requested buffer handle
+ *
+ * @return Find the buffer in the store and return a pointer to its descriptor.
+ *         Increase buffer refcount. If not found - return NULL.
+ */
+struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg, u32 handle)
+{
+	struct hl_mmap_mem_buf *buf;
+
+	spin_lock(&mmg->lock);
+	buf = idr_find(&mmg->handles, handle);
+	if (!buf) {
+		spin_unlock(&mmg->lock);
+		dev_warn(mmg->dev,
+			 "Buff get failed, no match to handle %u\n", handle);
+		return NULL;
+	}
+	kref_get(&buf->refcount);
+	spin_unlock(&mmg->lock);
+	return buf;
+}
+
+/**
+ * @hl_mmap_mem_buf_release - release buffer
+ *
+ * @kref: kref that reached 0.
+ *
+ * Internal function, used as a kref release callback, when the last user of
+ * the buffer is released. Shall be called from an interrupt context.
+ */
+static void hl_mmap_mem_buf_release(struct kref *kref)
+{
+	struct hl_mmap_mem_buf *buf =
+		container_of(kref, struct hl_mmap_mem_buf, refcount);
+
+	spin_lock(&buf->mmg->lock);
+	idr_remove(&buf->mmg->handles, buf->handle);
+	spin_unlock(&buf->mmg->lock);
+
+	if (buf->ops->release)
+		buf->ops->release(buf);
+
+	kfree(buf);
+}
+
+/**
+ * @hl_mmap_mem_buf_put - decrease the reference to the buffer
+ *
+ * @buf: memory manager buffer descriptor
+ *
+ * Decrease the reference to the buffer, and release it if it was the last one.
+ * Shall be called from an interrupt context.
+ */
+int hl_mmap_mem_buf_put(struct hl_mmap_mem_buf *buf)
+{
+	return kref_put(&buf->refcount, hl_mmap_mem_buf_release);
+}
+
+/**
+ * @hl_mmap_mem_buf_alloc - allocate a new mappable buffer
+ *
+ * @mmg: parent unifed memory manager
+ * @behavior: behavior object describing this buffer polymorphic behavior
+ * @gfp: gfp flags to use for the memory allocations
+ * @args: additional args passed to behavior->alloc
+ *
+ * Allocate and register a new memory buffer inside the give memory manager.
+ * Return the pointer to the new buffer on success or NULL on failure.
+ */
+struct hl_mmap_mem_buf *
+hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
+		      struct hl_mmap_mem_buf_ops *behavior, gfp_t gfp,
+		      void *args)
+{
+	struct hl_mmap_mem_buf *buf;
+	int rc;
+
+	buf = kzalloc(sizeof(*buf), gfp);
+	if (!buf)
+		return NULL;
+
+	spin_lock(&mmg->lock);
+	rc = idr_alloc(&mmg->handles, buf, 1, 0, GFP_ATOMIC);
+	spin_unlock(&mmg->lock);
+	if (rc < 0) {
+		dev_err(mmg->dev,
+			"Failed to allocate IDR for a new buffer, rc=%d\n", rc);
+		goto free_buf;
+	}
+
+	buf->handle = rc;
+	buf->mmg = mmg;
+	buf->ops = behavior;
+	kref_init(&buf->refcount);
+
+	rc = buf->ops->alloc(buf, gfp, args);
+	if (rc) {
+		dev_err(mmg->dev, "Failure in buffer alloc callback %d\n",
+			rc);
+		goto remove_idr;
+	}
+
+	dev_dbg(mmg->dev, "Created buff object handle %u\n", buf->handle);
+	return buf;
+
+remove_idr:
+	spin_lock(&mmg->lock);
+	idr_remove(&mmg->handles, buf->handle);
+	spin_unlock(&mmg->lock);
+free_buf:
+	kfree(buf);
+	return NULL;
+}
+
+/**
+ * @hl_mmap_mem_buf_vm_close - handle mmap close
+ *
+ * @vma: the vma object for which mmap was closed.
+ *
+ * Put the memory buffer if it is no longer mapped.
+ */
+static void hl_mmap_mem_buf_vm_close(struct vm_area_struct *vma)
+{
+	struct hl_mmap_mem_buf *buf =
+		(struct hl_mmap_mem_buf *)vma->vm_private_data;
+	long new_mmap_size;
+
+	new_mmap_size = buf->real_mapped_size - (vma->vm_end - vma->vm_start);
+
+	if (new_mmap_size > 0) {
+		buf->real_mapped_size = new_mmap_size;
+		return;
+	}
+
+	atomic_set(&buf->mmap, 0);
+	hl_mmap_mem_buf_put(buf);
+	vma->vm_private_data = NULL;
+}
+
+static const struct vm_operations_struct hl_mmap_mem_buf_vm_ops = {
+	.close = hl_mmap_mem_buf_vm_close
+};
+
+/**
+ * @hl_mem_mgr_mmap - map the given buffer to the user
+ *
+ * @mmg: unifed memory manager
+ * @vma: the vma object for which mmap was closed.
+ * @args: additional args passed to behavior->mmap
+ *
+ * Map the buffer specified by the vma->vm_pgoff to the given vma.
+ */
+int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
+		    void *args)
+{
+	struct hl_mmap_mem_buf *buf;
+	u64 user_mem_size;
+	u32 handle;
+	int rc;
+
+	/* We use the page offset to hold the idr and thus we need to clear
+	 * it before doing the mmap itself
+	 */
+	handle = vma->vm_pgoff;
+	vma->vm_pgoff = 0;
+
+	/* Reference was taken here */
+	buf = hl_mmap_mem_buf_get(mmg, handle);
+	if (!buf) {
+		dev_err(mmg->dev,
+			"Memory mmap failed, no match to handle %u\n", handle);
+		return -EINVAL;
+	}
+
+	/* Validation check */
+	user_mem_size = vma->vm_end - vma->vm_start;
+	if (user_mem_size != ALIGN(buf->mappable_size, PAGE_SIZE)) {
+		dev_err(mmg->dev,
+			"Memory mmap failed, mmap VM size 0x%llx != 0x%llx allocated physical mem size\n",
+			user_mem_size, buf->mappable_size);
+		rc = -EINVAL;
+		goto put_mem;
+	}
+
+#ifdef _HAS_TYPE_ARG_IN_ACCESS_OK
+	if (!access_ok(VERIFY_WRITE, (void __user *)(uintptr_t)vma->vm_start,
+		       user_mem_size)) {
+#else
+	if (!access_ok((void __user *)(uintptr_t)vma->vm_start,
+		       user_mem_size)) {
+#endif
+		dev_err(mmg->dev, "user pointer is invalid - 0x%lx\n",
+			vma->vm_start);
+
+		rc = -EINVAL;
+		goto put_mem;
+	}
+
+	if (atomic_cmpxchg(&buf->mmap, 0, 1)) {
+		dev_err(mmg->dev,
+			"Memory mmap failed, already mmaped to user\n");
+		rc = -EINVAL;
+		goto put_mem;
+	}
+
+	vma->vm_ops = &hl_mmap_mem_buf_vm_ops;
+
+	/* Note: We're transferring the memory reference to vma->vm_private_data here. */
+
+	vma->vm_private_data = buf;
+
+	rc = buf->ops->mmap(buf, vma, args);
+	if (rc) {
+		atomic_set(&buf->mmap, 0);
+		goto put_mem;
+	}
+
+	buf->real_mapped_size = buf->mappable_size;
+	vma->vm_pgoff = handle;
+
+	return 0;
+
+put_mem:
+	hl_mmap_mem_buf_put(buf);
+	return rc;
+}
+
+/**
+ * @hl_mem_mgr_init - initialize unified memory manager
+ *
+ * @dev: owner device pointer
+ * @mmg: structure to initialize
+ *
+ * Initialize an instance of unified memory manager
+ */
+void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg)
+{
+	mmg->dev = dev;
+	spin_lock_init(&mmg->lock);
+	idr_init(&mmg->handles);
+}
+
+/**
+ * @hl_mem_mgr_fini - release unified memory manager
+ *
+ * @mmg: parent unifed memory manager
+ *
+ * Release the unified memory manager. Shall be called from an interrupt context.
+ */
+void hl_mem_mgr_fini(struct hl_mem_mgr *mmg)
+{
+	struct hl_mmap_mem_buf *buf;
+	struct idr *idp;
+	u32 id;
+
+	idp = &mmg->handles;
+
+	idr_for_each_entry(idp, buf, id) {
+		if (hl_mmap_mem_buf_put(buf) != 1)
+			dev_err(mmg->dev,
+				"Buff handle %u for CTX is still alive\n", id);
+	}
+
+	/* TODO: can it happen that some buffer is still in use at this point? */
+
+	idr_destroy(&mmg->handles);
+}
-- 
2.25.1

