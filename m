Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D785C49E987
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245441AbiA0R5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:57:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:65504 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244998AbiA0Rzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306148; x=1674842148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TPB2LrmlUVsHBLkS8/W1ZpxXOGwMXL8e5PUJSM7dUI8=;
  b=mQFPB2LlCR7Kocqq2sbAjxLPjhj3YvSTrpLYYd3eMhPUykgby1VJncT9
   8q8jro8VaTekqbUKPiDwyFzvd4BauvxxmaNyWJ0pvmz4R0YKUzsND2Xii
   lF33ssx1+umUNlwGdMoDp4f1V5frKHgCQA+3bUsE/sjrc4kRPSH9wZEOg
   RSZA8JHjdyB74SHOuP7iYARlhBMmOhnUhejhvPqwN4k0FrptBA5ijMxdF
   gavLPMDbe5KdRkxMhUB2N/FqQufS3oa5ktJUcANe5l/GJp0B0t/eoLrGd
   UfQCCoWc5nAqcJP92SWfixX9E/8REkbJw/kyvjq/92xF8eG0GibN0Elck
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899150"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899150"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796214"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 43/44] nvdimm/pmem: Enable stray access protection
Date:   Thu, 27 Jan 2022 09:55:04 -0800
Message-Id: <20220127175505.851391-44-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Now that all valid kernel access' to PMEM have been annotated with
{__}pgmap_mk_{readwrite,noaccess}() PGMAP_PROTECTION is safe to enable
in the pmem layer.

Implement the pmem_map_protected() and pmem_mk_{readwrite,noaccess}() to
communicate this memory has extra protection to the upper layers if
PGMAP_PROTECTION is specified.

Internally, the pmem driver uses a cached virtual address,
pmem->virt_addr (pmem_addr).  Use __pgmap_mk_{readwrite,noaccess}()
directly when PGMAP_PROTECTION is active on the device.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Rebase to 5.17-rc1
	Remove global param
	Add internal structure which uses the pmem device and pgmap
		device directly in the *_mk_*() calls.
	Add pmem dax ops callbacks
	Use pgmap_protection_available()
	s/PGMAP_PKEY_PROTECT/PGMAP_PROTECTION
---
 drivers/nvdimm/pmem.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 58d95242a836..2afff8157233 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -138,6 +138,18 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
 	return BLK_STS_OK;
 }
 
+static void __pmem_mk_readwrite(struct pmem_device *pmem)
+{
+	if (pmem->pgmap.flags & PGMAP_PROTECTION)
+		__pgmap_mk_readwrite(&pmem->pgmap);
+}
+
+static void __pmem_mk_noaccess(struct pmem_device *pmem)
+{
+	if (pmem->pgmap.flags & PGMAP_PROTECTION)
+		__pgmap_mk_noaccess(&pmem->pgmap);
+}
+
 static blk_status_t pmem_do_read(struct pmem_device *pmem,
 			struct page *page, unsigned int page_off,
 			sector_t sector, unsigned int len)
@@ -149,7 +161,10 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
 		return BLK_STS_IOERR;
 
+	__pmem_mk_readwrite(pmem);
 	rc = read_pmem(page, page_off, pmem_addr, len);
+	__pmem_mk_noaccess(pmem);
+
 	flush_dcache_page(page);
 	return rc;
 }
@@ -181,11 +196,14 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	 * after clear poison.
 	 */
 	flush_dcache_page(page);
+
+	__pmem_mk_readwrite(pmem);
 	write_pmem(pmem_addr, page, page_off, len);
 	if (unlikely(bad_pmem)) {
 		rc = pmem_clear_poison(pmem, pmem_off, len);
 		write_pmem(pmem_addr, page, page_off, len);
 	}
+	__pmem_mk_noaccess(pmem);
 
 	return rc;
 }
@@ -301,11 +319,36 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
 	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
 }
 
+static bool pmem_map_protected(struct dax_device *dax_dev)
+{
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+
+	return (pmem->pgmap.flags & PGMAP_PROTECTION);
+}
+
+static void pmem_mk_readwrite(struct dax_device *dax_dev)
+{
+	__pmem_mk_readwrite(dax_get_private(dax_dev));
+}
+
+static void pmem_mk_noaccess(struct dax_device *dax_dev)
+{
+	__pmem_mk_noaccess(dax_get_private(dax_dev));
+}
+
 static const struct dax_operations pmem_dax_ops = {
 	.direct_access = pmem_dax_direct_access,
 	.zero_page_range = pmem_dax_zero_page_range,
 };
 
+static const struct dax_operations pmem_protected_dax_ops = {
+	.direct_access = pmem_dax_direct_access,
+	.zero_page_range = pmem_dax_zero_page_range,
+	.map_protected = pmem_map_protected,
+	.mk_readwrite = pmem_mk_readwrite,
+	.mk_noaccess = pmem_mk_noaccess,
+};
+
 static ssize_t write_cache_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -427,6 +470,8 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->pfn_flags = PFN_DEV;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		if (pgmap_protection_available())
+			pmem->pgmap.flags |= PGMAP_PROTECTION;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pfn_sb = nd_pfn->pfn_sb;
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
@@ -440,6 +485,8 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.range.end = res->end;
 		pmem->pgmap.nr_range = 1;
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		if (pgmap_protection_available())
+			pmem->pgmap.flags |= PGMAP_PROTECTION;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
@@ -474,7 +521,10 @@ static int pmem_attach_disk(struct device *dev,
 	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_range);
 	disk->bb = &pmem->bb;
 
-	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
+	if (pmem->pgmap.flags & PGMAP_PROTECTION)
+		dax_dev = alloc_dax(pmem, &pmem_protected_dax_ops);
+	else
+		dax_dev = alloc_dax(pmem, &pmem_dax_ops);
 	if (IS_ERR(dax_dev)) {
 		rc = PTR_ERR(dax_dev);
 		goto out;
-- 
2.31.1

