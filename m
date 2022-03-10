Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853B4D504E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244884AbiCJRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245135AbiCJRXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:11 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584B198D07
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932923; x=1678468923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6pPXC0JSSSMuLc8Wn5aZ29lRSQ2lCEZPmuGWTz0kMM=;
  b=l5J6JC7/oIbdMXY0HinjoJsV8GWAGsMKsufeyMHMzR4YZ1PZSY66Mlpq
   DJvEG9YSTHGwetdPwFhc5sn1wwE8y0+XAu6l9M8uKHW39pacn56A9HSfH
   BM1ByDghpBnmoVfqzAU9X0IA7A5LaYKj8IhdlEAAJmaOcTIKfHSLiPMCg
   bUXlZ4893eiJaJ3nXZDN1gIVXLUpON6amTzxWdR94ww43bhhZ3dOd0aVL
   hMJBXG+iTXmIs9VazkR07uycVWk/rO7ACVXTlpAVERyVVKcY+lF2fIWYS
   6rygLsxOwNkuuhzVztneqBbZLbNF6+Mxbu8MefyJ9CuFJn2g0qnUhIxT/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316033214"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="316033214"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:22:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="688732698"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:22:02 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 44/45] nvdimm/pmem: Enable stray access protection
Date:   Thu, 10 Mar 2022 09:20:18 -0800
Message-Id: <20220310172019.850939-45-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The persistent memory (PMEM) driver uses the memremap_pages facility to
provide 'struct page' metadata (vmemmap) for PMEM.  Given that PMEM
capacity maybe orders of magnitude higher capacity than System RAM it
presents a large vulnerability surface to stray writes.  Unlike stray
writes to System RAM, which may result in a crash or other undesirable
behavior, stray writes to PMEM additionally are more likely to result in
permanent data loss. Reboot is not a remediation for PMEM corruption
like it is for System RAM.

Now that all valid kernel access' to PMEM have been annotated with
{__}pgmap_set_{readwrite,noaccess}() PGMAP_PROTECTION is safe to enable
in the pmem layer.

Set PGMAP_PROTECTION if pgmap protections are available and set the
pgmap property of the dax device for it's use.

Internally, the pmem driver uses a cached virtual address,
pmem->virt_addr (pmem_addr).  Call __pgmap_set_{readwrite,noaccess}()
directly when PGMAP_PROTECTION is active on those mappings.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Remove the dax operations and pass the pgmap to the dax_device
		for its use.
	s/pgmap_mk_*/pgmap_set_*/
	s/pmem_mk_*/pmem_set_*/

Changes for V8
	Rebase to 5.17-rc1
	Remove global param
	Add internal structure which uses the pmem device and pgmap
		device directly in the *_mk_*() calls.
	Add pmem dax ops callbacks
	Use pgmap_protection_available()
	s/PGMAP_PKEY_PROTECT/PGMAP_PROTECTION
---
 drivers/nvdimm/pmem.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 58d95242a836..2c7b18da7974 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -138,6 +138,18 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
 	return BLK_STS_OK;
 }
 
+static void pmem_set_readwrite(struct pmem_device *pmem)
+{
+	if (pmem->pgmap.flags & PGMAP_PROTECTION)
+		__pgmap_set_readwrite(&pmem->pgmap);
+}
+
+static void pmem_set_noaccess(struct pmem_device *pmem)
+{
+	if (pmem->pgmap.flags & PGMAP_PROTECTION)
+		__pgmap_set_noaccess(&pmem->pgmap);
+}
+
 static blk_status_t pmem_do_read(struct pmem_device *pmem,
 			struct page *page, unsigned int page_off,
 			sector_t sector, unsigned int len)
@@ -149,7 +161,11 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
 	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
 		return BLK_STS_IOERR;
 
+	/* Enable direct use of pmem->virt_addr */
+	pmem_set_readwrite(pmem);
 	rc = read_pmem(page, page_off, pmem_addr, len);
+	pmem_set_noaccess(pmem);
+
 	flush_dcache_page(page);
 	return rc;
 }
@@ -181,11 +197,15 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 	 * after clear poison.
 	 */
 	flush_dcache_page(page);
+
+	/* Enable direct use of pmem->virt_addr */
+	pmem_set_readwrite(pmem);
 	write_pmem(pmem_addr, page, page_off, len);
 	if (unlikely(bad_pmem)) {
 		rc = pmem_clear_poison(pmem, pmem_off, len);
 		write_pmem(pmem_addr, page, page_off, len);
 	}
+	pmem_set_noaccess(pmem);
 
 	return rc;
 }
@@ -427,6 +447,8 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->pfn_flags = PFN_DEV;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		if (pgmap_protection_available())
+			pmem->pgmap.flags |= PGMAP_PROTECTION;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pfn_sb = nd_pfn->pfn_sb;
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
@@ -440,6 +462,8 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.range.end = res->end;
 		pmem->pgmap.nr_range = 1;
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		if (pgmap_protection_available())
+			pmem->pgmap.flags |= PGMAP_PROTECTION;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
@@ -481,6 +505,8 @@ static int pmem_attach_disk(struct device *dev,
 	}
 	set_dax_nocache(dax_dev);
 	set_dax_nomc(dax_dev);
+	if (pmem->pgmap.flags & PGMAP_PROTECTION)
+		set_dax_pgmap(dax_dev, &pmem->pgmap);
 	if (is_nvdimm_sync(nd_region))
 		set_dax_synchronous(dax_dev);
 	rc = dax_add_host(dax_dev, disk);
-- 
2.35.1

