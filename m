Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD1E49E986
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiA0R5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:57:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:65467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244796AbiA0Rzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306141; x=1674842141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5PNbZiFfcGOHVsut66vPdPMpwN8Bxyu2O4inZ1cSArk=;
  b=dlt905LV9MBr0qoh5Naryw0LXMXrkdIJi0j2yheM77mQ+Q7o5z+CUvgW
   FHOE4PadWcFt4/a2Olf5tzHazsG5wdpT8sHNlks4SwuCeA3agBZEEcski
   ZhEZt96OCDvsUVX7EbwpvLPIv4T530mIiZCn7TWnbFvAMv0hW+naUnQGJ
   YbtBQ8y6IzpNEfjVXRm8bJYjgYiBAjrkmrIiJ7eGVjqp4oAtT7clXv8JV
   byiQkO0mlav7KSQEeDl+miBiQ8sMe5Bi35vUlCDRRDHlzhYV0MevxuCu/
   ClXKbUu9otQ6SZVPwEO8A8pArIOsGANPv4/IU0C8mFoQyR2PEA9+klaTF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899147"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899147"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796208"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 42/44] dax: Stray access protection for dax_direct_access()
Date:   Thu, 27 Jan 2022 09:55:03 -0800
Message-Id: <20220127175505.851391-43-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

dax_direct_access() provides a way to obtain the direct map address of
PMEM memory.  Coordinate PKS protection with dax_direct_access() of
protected devmap pages.

Introduce 3 new dax_operation calls .map_protected .mk_readwrite and
.mk_noaccess. These 3 calls do not have to be implemented by the dax
provider if no protection is implemented.

Threads of execution can use dax_mk_{readwrite,noaccess}() to relax the
protection of the dax device and allow direct use of the kaddr returned
from dax_direct_access().  The dax_mk_{readwrite,noaccess}() calls only
need to be used to guard actual access to the memory.  Other uses of
dax_direct_access() do not need to use these guards.

For users who require a permanent address to the dax device such as the
DM write cache.  dax_map_protected() indicates that the dax device has
additional protections and that user should create it's own permanent
mapping of the memory.  Update the DM write cache code to create this
permanent mapping.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Rebase changes on 5.17-rc1
	Clean up the cover letter
		dax_read_lock() is not required
		s/dax_protected()/dax_map_protected()/
	Testing revealed a dax_flush() which was not properly protected.

Changes for V7
	Rework cover letter.
	Do not include a FS_DAX_LIMITED restriction for dcss.  It  will
		simply not implement the protection and there is no need
		to special case this.
		Clean up commit message because I did not originally
		understand the nuance of the s390 device.
	Introduce dax_{protected,mk_readwrite,mk_noaccess}()
	From Dan Williams
		Remove old clean up cruft from previous versions
		Remove map_protected
	Remove 'global' parameters all calls
---
 drivers/dax/super.c        | 54 ++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-writecache.c |  8 +++++-
 fs/dax.c                   |  8 ++++++
 fs/fuse/virtio_fs.c        |  2 ++
 include/linux/dax.h        |  8 ++++++
 5 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e3029389d809..705b2e736200 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -117,6 +117,8 @@ enum dax_device_flags {
  * @pgoff: offset in pages from the start of the device to translate
  * @nr_pages: number of consecutive pages caller can handle relative to @pfn
  * @kaddr: output parameter that returns a virtual address mapping of pfn
+ *         Direct access through this pointer must be guarded by calls to
+ *         dax_mk_{readwrite,noaccess}()
  * @pfn: output parameter that returns an absolute pfn translation of @pgoff
  *
  * Return: negative errno if an error occurs, otherwise the number of
@@ -209,6 +211,58 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
 #endif
 EXPORT_SYMBOL_GPL(dax_flush);
 
+bool dax_map_protected(struct dax_device *dax_dev)
+{
+	if (!dax_alive(dax_dev))
+		return false;
+
+	if (dax_dev->ops->map_protected)
+		return dax_dev->ops->map_protected(dax_dev);
+	return false;
+}
+EXPORT_SYMBOL_GPL(dax_map_protected);
+
+/**
+ * dax_mk_readwrite() - make protected dax devices read/write
+ * @dax_dev: the dax device representing the memory to access
+ *
+ * Any access of the kaddr memory returned from dax_direct_access() must be
+ * guarded by dax_mk_readwrite() and dax_mk_noaccess().  This ensures that any
+ * dax devices which have additional protections are allowed to relax those
+ * protections for the thread using this memory.
+ *
+ * NOTE these calls must be contained within a single thread of execution and
+ * both must be guarded by dax_read_lock()  Which is also a requirement for
+ * dax_direct_access() anyway.
+ */
+void dax_mk_readwrite(struct dax_device *dax_dev)
+{
+	if (!dax_alive(dax_dev))
+		return;
+
+	if (dax_dev->ops->mk_readwrite)
+		dax_dev->ops->mk_readwrite(dax_dev);
+}
+EXPORT_SYMBOL_GPL(dax_mk_readwrite);
+
+/**
+ * dax_mk_noaccess() - restore protection to dax devices if needed
+ * @dax_dev: the dax device representing the memory to access
+ *
+ * See dax_direct_access() and dax_mk_readwrite()
+ *
+ * NOTE Must be called prior to dax_read_unlock()
+ */
+void dax_mk_noaccess(struct dax_device *dax_dev)
+{
+	if (!dax_alive(dax_dev))
+		return;
+
+	if (dax_dev->ops->mk_noaccess)
+		dax_dev->ops->mk_noaccess(dax_dev);
+}
+EXPORT_SYMBOL_GPL(dax_mk_noaccess);
+
 void dax_write_cache(struct dax_device *dax_dev, bool wc)
 {
 	if (wc)
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 4f31591d2d25..5d6d7b6bad30 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -297,7 +297,13 @@ static int persistent_memory_claim(struct dm_writecache *wc)
 		r = -EOPNOTSUPP;
 		goto err2;
 	}
-	if (da != p) {
+
+	/*
+	 * Force the write cache to map the pages directly if the dax device
+	 * mapping is protected or if the number of pages returned was not what
+	 * was requested.
+	 */
+	if (dax_map_protected(wc->ssd_dev->dax_dev) || da != p) {
 		long i;
 		wc->memory_map = NULL;
 		pages = kvmalloc_array(p, sizeof(struct page *), GFP_KERNEL);
diff --git a/fs/dax.c b/fs/dax.c
index cd03485867a7..0b22a1091fe2 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -728,7 +728,9 @@ static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter
 		return rc;
 	}
 	vto = kmap_atomic(vmf->cow_page);
+	dax_mk_readwrite(iter->iomap.dax_dev);
 	copy_user_page(vto, kaddr, vmf->address, vmf->cow_page);
+	dax_mk_noaccess(iter->iomap.dax_dev);
 	kunmap_atomic(vto);
 	dax_read_unlock(id);
 	return 0;
@@ -937,8 +939,10 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	count = 1UL << dax_entry_order(entry);
 	index = xas->xa_index & ~(count - 1);
 
+	dax_mk_readwrite(dax_dev);
 	dax_entry_mkclean(mapping, index, pfn);
 	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
+	dax_mk_noaccess(dax_dev);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
 	 * cannot be new dirty data in the pfn after the flush has completed as
@@ -1125,8 +1129,10 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
 
 	ret = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
 	if (ret > 0) {
+		dax_mk_readwrite(dax_dev);
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
+		dax_mk_noaccess(dax_dev);
 	}
 	return ret;
 }
@@ -1260,12 +1266,14 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (map_len > end - pos)
 			map_len = end - pos;
 
+		dax_mk_readwrite(dax_dev);
 		if (iov_iter_rw(iter) == WRITE)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
 			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
+		dax_mk_noaccess(dax_dev);
 
 		pos += xfer;
 		length -= xfer;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 9d737904d07c..c748218fe70c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -774,8 +774,10 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
 	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
 	if (rc < 0)
 		return rc;
+	dax_mk_readwrite(dax_dev);
 	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
 	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
+	dax_mk_noaccess(dax_dev);
 	return 0;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9fc5f99a0ae2..261af298f89f 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -30,6 +30,10 @@ struct dax_operations {
 			sector_t, sector_t);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
+
+	bool (*map_protected)(struct dax_device *dax_dev);
+	void (*mk_readwrite)(struct dax_device *dax_dev);
+	void (*mk_noaccess)(struct dax_device *dax_dev);
 };
 
 #if IS_ENABLED(CONFIG_DAX)
@@ -187,6 +191,10 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
+bool dax_map_protected(struct dax_device *dax_dev);
+void dax_mk_readwrite(struct dax_device *dax_dev);
+void dax_mk_noaccess(struct dax_device *dax_dev);
+
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
-- 
2.31.1

