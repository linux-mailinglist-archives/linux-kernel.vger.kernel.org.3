Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B9507639
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355955AbiDSRLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355654AbiDSRKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27721273B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388040; x=1681924040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HcEslqZopmXYsUw7zwbef5KUJ9D83y9DD7QVT5vPuts=;
  b=b0Ni6yB7tkm9od5rpV0o8oEdTqyydOt8CKNAoJifX6dn/iiAWSkZTIPb
   xkDSYFqlR/xnBYAYjGxG3hMV47bnuicd7pEhY7IggKRIqxx6v0SwD2fvp
   Iq/YsdF/W+eWqUNzUk2WXjxCdMCU5umFLomnQtG+QJgpCl2dGxFJZTaLp
   bWVjmxb328m5/H5djdQsfFo/hRhdfDY9YxJHksJpir0vB+P6RRsJ64hdf
   DpYNhIw5jJ/Ewo2RJXCl/sUt33FDKLz0+CyLiKX26Y08nKSKYQSaRHDKq
   kGgz8pWmAq4QUL9ajysaDQDxM3p/MGzlD0iLrlQU0JVQSiZaUxqQ1THA+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261420874"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="261420874"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="702255151"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:19 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 34/44] dax: Stray access protection for dax_direct_access()
Date:   Tue, 19 Apr 2022 10:06:39 -0700
Message-Id: <20220419170649.1022246-35-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

dax_direct_access() provides a way to obtain the direct map address of
PMEM memory.  With the new devmap protections the use of this address
needs to be bracketed by calls to enable and disable protection of
those pages.  These calls only need to be used to guard actual access to
the memory.  Other uses of dax_direct_access() do not need to use these
guards.

Introduce 2 new calls dax_set_readwrite() and dax_set_noaccess().
Bracket all uses of the address returned by dax_direct_access() with
those calls.

For consumers who require a permanent address to the dax device, such as
the DM write cache, dax_map_protected() is used to query for additional
protections.

Update the DM write cache code to create a permanent mapping if
dax_map_protected() is true.

Cc: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Do not add a new dax operation.  Instead teach struct dax_device
		about the dev_pagemap PGMAP_PROTECTION flag and call the
		ops directly if needed.
	s/dax_mk_*/dax_set_*/

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
 drivers/dax/super.c        | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-writecache.c |  8 ++++-
 fs/dax.c                   |  8 +++++
 fs/fuse/virtio_fs.c        |  2 ++
 include/linux/dax.h        |  5 ++++
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0211e6f7b47a..3105794f55f7 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -13,6 +13,7 @@
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
+#include <linux/memremap.h>
 #include "dax-private.h"
 
 /**
@@ -29,6 +30,7 @@ struct dax_device {
 	void *private;
 	unsigned long flags;
 	const struct dax_operations *ops;
+	struct dev_pagemap *pgmap;
 };
 
 static dev_t dax_devt;
@@ -118,6 +120,8 @@ enum dax_device_flags {
  * @pgoff: offset in pages from the start of the device to translate
  * @nr_pages: number of consecutive pages caller can handle relative to @pfn
  * @kaddr: output parameter that returns a virtual address mapping of pfn
+ *         Direct access through this pointer must be guarded by calls to
+ *         dax_set_{readwrite,noaccess}()
  * @pfn: output parameter that returns an absolute pfn translation of @pgoff
  *
  * Return: negative errno if an error occurs, otherwise the number of
@@ -210,6 +214,56 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
 #endif
 EXPORT_SYMBOL_GPL(dax_flush);
 
+bool dax_map_protected(struct dax_device *dax_dev)
+{
+	struct dev_pagemap *pgmap = dax_dev->pgmap;
+
+	if (!dax_alive(dax_dev))
+		return false;
+
+	return pgmap && (pgmap->flags & PGMAP_PROTECTION);
+}
+EXPORT_SYMBOL_GPL(dax_map_protected);
+
+/**
+ * dax_set_readwrite() - make protected dax devices read/write
+ * @dax_dev: the dax device representing the memory to access
+ *
+ * Any access of the kaddr memory returned from dax_direct_access() must be
+ * guarded by dax_set_readwrite() and dax_set_noaccess().  This ensures that any
+ * dax devices which have additional protections are allowed to relax those
+ * protections for the thread using this memory.
+ *
+ * NOTE these calls must be contained within a single thread of execution and
+ * both must be guarded by dax_read_lock()  Which is also a requirement for
+ * dax_direct_access() anyway.
+ */
+void dax_set_readwrite(struct dax_device *dax_dev)
+{
+	if (!dax_map_protected(dax_dev))
+		return;
+
+	__pgmap_set_readwrite(dax_dev->pgmap);
+}
+EXPORT_SYMBOL_GPL(dax_set_readwrite);
+
+/**
+ * dax_set_noaccess() - restore protection to dax devices if needed
+ * @dax_dev: the dax device representing the memory to access
+ *
+ * See dax_direct_access() and dax_set_readwrite()
+ *
+ * NOTE Must be called prior to dax_read_unlock()
+ */
+void dax_set_noaccess(struct dax_device *dax_dev)
+{
+	if (!dax_map_protected(dax_dev))
+		return;
+
+	__pgmap_set_noaccess(dax_dev->pgmap);
+}
+EXPORT_SYMBOL_GPL(dax_set_noaccess);
+
 void dax_write_cache(struct dax_device *dax_dev, bool wc)
 {
 	if (wc)
@@ -249,6 +303,12 @@ void set_dax_nomc(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(set_dax_nomc);
 
+void set_dax_pgmap(struct dax_device *dax_dev, struct dev_pagemap *pgmap)
+{
+	dax_dev->pgmap = pgmap;
+}
+EXPORT_SYMBOL_GPL(set_dax_pgmap);
+
 bool dax_alive(struct dax_device *dax_dev)
 {
 	lockdep_assert_held(&dax_srcu);
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 5630b470ba42..8fd26a237de3 100644
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
index 67a08a32fccb..7cc76c6752ae 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -727,7 +727,9 @@ static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter
 		return rc;
 	}
 	vto = kmap_atomic(vmf->cow_page);
+	dax_set_readwrite(iter->iomap.dax_dev);
 	copy_user_page(vto, kaddr, vmf->address, vmf->cow_page);
+	dax_set_noaccess(iter->iomap.dax_dev);
 	kunmap_atomic(vto);
 	dax_read_unlock(id);
 	return 0;
@@ -936,8 +938,10 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	count = 1UL << dax_entry_order(entry);
 	index = xas->xa_index & ~(count - 1);
 
+	dax_set_readwrite(dax_dev);
 	dax_entry_mkclean(mapping, index, pfn);
 	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
+	dax_set_noaccess(dax_dev);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
 	 * cannot be new dirty data in the pfn after the flush has completed as
@@ -1124,8 +1128,10 @@ static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
 
 	ret = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
 	if (ret > 0) {
+		dax_set_readwrite(dax_dev);
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
+		dax_set_noaccess(dax_dev);
 	}
 	return ret;
 }
@@ -1259,12 +1265,14 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (map_len > end - pos)
 			map_len = end - pos;
 
+		dax_set_readwrite(dax_dev);
 		if (iov_iter_rw(iter) == WRITE)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
 			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
+		dax_set_noaccess(dax_dev);
 
 		pos += xfer;
 		length -= xfer;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 86b7dbb6a0d4..58bb949dcdfc 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -775,8 +775,10 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
 	rc = dax_direct_access(dax_dev, pgoff, nr_pages, &kaddr, NULL);
 	if (rc < 0)
 		return rc;
+	dax_set_readwrite(dax_dev);
 	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
 	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
+	dax_set_noaccess(dax_dev);
 	return 0;
 }
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9fc5f99a0ae2..30fe49f9ec9d 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -91,6 +91,7 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 
 void set_dax_nocache(struct dax_device *dax_dev);
 void set_dax_nomc(struct dax_device *dax_dev);
+void set_dax_pgmap(struct dax_device *dax_dev, struct dev_pagemap *pgmap);
 
 struct writeback_control;
 #if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
@@ -187,6 +188,10 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
+bool dax_map_protected(struct dax_device *dax_dev);
+void dax_set_readwrite(struct dax_device *dax_dev);
+void dax_set_noaccess(struct dax_device *dax_dev);
+
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
 vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
-- 
2.35.1

