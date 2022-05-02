Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB5516BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383636AbiEBIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359198AbiEBIJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:09:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22633B3FF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F770B811CE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619F7C385B0;
        Mon,  2 May 2022 08:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651478756;
        bh=reI0GYhvyZGDahuSNQT0x3xx8RnuDPayoMRn+YbsRJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+YMI1oh1A5rkQvaiCoExW4gmnJVhc5Xqm9M36V+Fwvl/m1P5xY4qhsD/FTWvqEpn
         Oxxno0IWkFWoNFDk+39Ux2OzHUU06Ld9kqknY2WrdgnNVPnqYEvLZFfhQQfVNdhhJ/
         Mx8wK6eo4mNVylPtP4XQzs0hU1WLPVh8cIxcaZZPajJ/F3PyP9tqSQqlunMdVQVZQi
         evzQUmVehWJ0rwHQewJulM4XzAU0E5oqVktvjCgjLEykcqqzQhfRndPp6v4G8dlmof
         O9zkYsv6a5dPiL0qEyEEqos/rxbEmY8qcnPYEL8Abz7yWt1ebLEVlj738UPS6zDWpw
         P826i4I26F6HA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 2/6] habanalabs: add put by handle method to memory manager
Date:   Mon,  2 May 2022 11:05:45 +0300
Message-Id: <20220502080549.230411-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502080549.230411-1-ogabbay@kernel.org>
References: <20220502080549.230411-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

Putting object by its handle and not by object pointer is useful in
some finalization flows that do not have object pointer available.
It eliminates the need to first get the object and then perform
put twice.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  1 +
 drivers/misc/habanalabs/common/memory_mgr.c | 76 +++++++++++++++++++--
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ea5cfea21a2c..cfe349ebd0bb 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3293,6 +3293,7 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 		    void *args);
 struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg,
 						   u64 handle);
+int hl_mmap_mem_buf_put_handle(struct hl_mem_mgr *mmg, u64 handle);
 int hl_mmap_mem_buf_put(struct hl_mmap_mem_buf *buf);
 struct hl_mmap_mem_buf *
 hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 1cc2f2ebe3b6..9f3ab6cf25d3 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -14,8 +14,8 @@
  * @mmg: parent unifed memory manager
  * @handle: requested buffer handle
  *
- * @return Find the buffer in the store and return a pointer to its descriptor.
- *         Increase buffer refcount. If not found - return NULL.
+ * Find the buffer in the store and return a pointer to its descriptor.
+ * Increase buffer refcount. If not found - return NULL.
  */
 struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg, u64 handle)
 {
@@ -34,6 +34,23 @@ struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg, u64 handle)
 	return buf;
 }
 
+/**
+ * hl_mmap_mem_buf_destroy - destroy the unused buffer
+ *
+ * @buf: memory manager buffer descriptor
+ *
+ * Internal function, used as a final step of buffer release. Shall be invoked
+ * only when the buffer is no longer in use (removed from idr). Will call the
+ * release callback (if applicable), and free the memory.
+ */
+static void hl_mmap_mem_buf_destroy(struct hl_mmap_mem_buf *buf)
+{
+	if (buf->behavior->release)
+		buf->behavior->release(buf);
+
+	kfree(buf);
+}
+
 /**
  * hl_mmap_mem_buf_release - release buffer
  *
@@ -51,10 +68,23 @@ static void hl_mmap_mem_buf_release(struct kref *kref)
 	idr_remove(&buf->mmg->handles, lower_32_bits(buf->handle >> PAGE_SHIFT));
 	spin_unlock(&buf->mmg->lock);
 
-	if (buf->behavior->release)
-		buf->behavior->release(buf);
+	hl_mmap_mem_buf_destroy(buf);
+}
 
-	kfree(buf);
+/**
+ * hl_mmap_mem_buf_remove_idr_locked - remove handle from idr
+ *
+ * @kref: kref that reached 0.
+ *
+ * Internal function, used for kref put by handle. Assumes mmg lock is taken.
+ * Will remove the buffer from idr, without destroying it.
+ */
+static void hl_mmap_mem_buf_remove_idr_locked(struct kref *kref)
+{
+	struct hl_mmap_mem_buf *buf =
+		container_of(kref, struct hl_mmap_mem_buf, refcount);
+
+	idr_remove(&buf->mmg->handles, lower_32_bits(buf->handle >> PAGE_SHIFT));
 }
 
 /**
@@ -71,7 +101,41 @@ int hl_mmap_mem_buf_put(struct hl_mmap_mem_buf *buf)
 }
 
 /**
- * hl_mmap_mem_buf_alloc - allocate a new mappable buffer
+ * hl_mmap_mem_buf_put_handle - decrease the reference to the buffer with the
+ *                              given handle.
+ *
+ * @mmg: parent unifed memory manager
+ * @handle: requested buffer handle
+ *
+ * Decrease the reference to the buffer, and release it if it was the last one.
+ * Shall not be called from an interrupt context. Return -EINVAL if handle was
+ * not found, else return the put outcome (0 or 1).
+ */
+int hl_mmap_mem_buf_put_handle(struct hl_mem_mgr *mmg, u64 handle)
+{
+	struct hl_mmap_mem_buf *buf;
+
+	spin_lock(&mmg->lock);
+	buf = idr_find(&mmg->handles, lower_32_bits(handle >> PAGE_SHIFT));
+	if (!buf) {
+		spin_unlock(&mmg->lock);
+		dev_warn(mmg->dev,
+			 "Buff put failed, no match to handle %llu\n", handle);
+		return -EINVAL;
+	}
+
+	if (kref_put(&buf->refcount, hl_mmap_mem_buf_remove_idr_locked)) {
+		spin_unlock(&mmg->lock);
+		hl_mmap_mem_buf_destroy(buf);
+		return 1;
+	}
+
+	spin_unlock(&mmg->lock);
+	return 0;
+}
+
+/**
+ * @hl_mmap_mem_buf_alloc - allocate a new mappable buffer
  *
  * @mmg: parent unifed memory manager
  * @behavior: behavior object describing this buffer polymorphic behavior
-- 
2.25.1

