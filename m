Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A06570EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiGLAQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGLAPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:15:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06902AC56
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584884; x=1689120884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+PRn+weX3k7n//TPZyvFREn2hlm1uJvICybl4nuKpt8=;
  b=GxxE4KH0x+zj7WoJlCuukrQQLf0PqUWnJmLE/CtG6cp7Agb78Lk0xiv6
   0hcI4fFhvv96YN/aTxJMAZDolft/b1wzqddW2oMq/w5TTE4dApFvml2S/
   9Zi2B4Kn/66j4Kg/ZaLVsnWSTltmN6xGI4/IQEHgr1Q4Z8pMOD8B41msk
   I9AU21wz09wZzn1gbunwH5ik2wdbbuDw/M68/uv3NLNt7HUOtPjWfbSP9
   lsM2BFjT6ieIFbfYvSbe+lIoQf9eTDGRcpMz6W60SrClSHN+qkd5qMJtt
   krUBRmAAgnq9llErs5t5/ykXO2rYEGyCtoj3YOOCJfQusbwMTje2bE0hB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="265213623"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="265213623"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445863"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:11 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] iommu/vt-d: Use IDA interface to manage iommu sequence id
Date:   Tue, 12 Jul 2022 08:09:04 +0800
Message-Id: <20220712000908.3431936-22-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch dmar unit sequence id allocation and release from bitmap to IDA
interface.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220702015610.2849494-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/dmar.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 2a5e0f91e647..6327b34f5aa7 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -60,7 +60,7 @@ LIST_HEAD(dmar_drhd_units);
 
 struct acpi_table_header * __initdata dmar_tbl;
 static int dmar_dev_scope_status = 1;
-static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
+static DEFINE_IDA(dmar_seq_ids);
 
 static int alloc_iommu(struct dmar_drhd_unit *drhd);
 static void free_iommu(struct intel_iommu *iommu);
@@ -1023,28 +1023,6 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 	return err;
 }
 
-static int dmar_alloc_seq_id(struct intel_iommu *iommu)
-{
-	iommu->seq_id = find_first_zero_bit(dmar_seq_ids,
-					    DMAR_UNITS_SUPPORTED);
-	if (iommu->seq_id >= DMAR_UNITS_SUPPORTED) {
-		iommu->seq_id = -1;
-	} else {
-		set_bit(iommu->seq_id, dmar_seq_ids);
-		sprintf(iommu->name, "dmar%d", iommu->seq_id);
-	}
-
-	return iommu->seq_id;
-}
-
-static void dmar_free_seq_id(struct intel_iommu *iommu)
-{
-	if (iommu->seq_id >= 0) {
-		clear_bit(iommu->seq_id, dmar_seq_ids);
-		iommu->seq_id = -1;
-	}
-}
-
 static int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
@@ -1062,11 +1040,14 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	if (!iommu)
 		return -ENOMEM;
 
-	if (dmar_alloc_seq_id(iommu) < 0) {
+	iommu->seq_id = ida_alloc_range(&dmar_seq_ids, 0,
+					DMAR_UNITS_SUPPORTED - 1, GFP_KERNEL);
+	if (iommu->seq_id < 0) {
 		pr_err("Failed to allocate seq_id\n");
-		err = -ENOSPC;
+		err = iommu->seq_id;
 		goto error;
 	}
+	sprintf(iommu->name, "dmar%d", iommu->seq_id);
 
 	err = map_iommu(iommu, drhd->reg_base_addr);
 	if (err) {
@@ -1150,7 +1131,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 err_unmap:
 	unmap_iommu(iommu);
 error_free_seq_id:
-	dmar_free_seq_id(iommu);
+	ida_free(&dmar_seq_ids, iommu->seq_id);
 error:
 	kfree(iommu);
 	return err;
@@ -1183,7 +1164,7 @@ static void free_iommu(struct intel_iommu *iommu)
 	if (iommu->reg)
 		unmap_iommu(iommu);
 
-	dmar_free_seq_id(iommu);
+	ida_free(&dmar_seq_ids, iommu->seq_id);
 	kfree(iommu);
 }
 
-- 
2.25.1

