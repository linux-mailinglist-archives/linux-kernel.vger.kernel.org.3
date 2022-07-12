Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132BD570EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiGLAQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiGLAPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:15:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184FB8BA99
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584896; x=1689120896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qKKsYPnFKnFFJPzOZhVWU6Nqf98mNpvKExXx01NfN9M=;
  b=dzJxJV077CaU1ysDrYo1ZJ69sjV12GqISlqo3Jee/A2NfcA70MzTsxrw
   PhQ0tMJgdkD73KbEEMRfAl6Krx1PxLyaWn3sxeHM9/T008+H6Xb9Uotff
   eHoPyzb0Dn418fl6M7oltZLxD8TeOnSuzp5VXrn6uktAccPC/IkQ1ke/G
   J8L9WaH2MAtex5DRVJt1AWtULhZvmH87zWOz+NFvWnFz2XZ2xQMkW9l+Q
   hwdMnuWwbyOXBJbITUrPdzydffqPR2VcScCmhirnZVi76qG0YlJlZ6afd
   3f+EzIm16u+1SE9UtOAHD0hGxwdK8LfDrRlZyCY6D/FE6pStDFV5dV+xr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285929340"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="285929340"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445865"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:14 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 23/25] iommu/vt-d: Remove unnecessary check in intel_iommu_add()
Date:   Tue, 12 Jul 2022 08:09:06 +0800
Message-Id: <20220712000908.3431936-24-baolu.lu@linux.intel.com>
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

The Intel IOMMU hot-add process starts from dmar_device_hotplug(). It
uses the global dmar_global_lock to synchronize all the hot-add and
hot-remove paths. In the hot-add path, the new IOMMU data structures
are allocated firstly by dmar_parse_one_drhd() and then initialized by
dmar_hp_add_drhd(). All the IOMMU units are allocated and initialized
in the same synchronized path. There is no case where any IOMMU unit
is created and then initialized for multiple times.

This removes the unnecessary check in intel_iommu_add() which is the
last reference place of the global IOMMU array.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220702015610.2849494-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 36b3649a83e8..2f64ff6e6e75 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3460,9 +3460,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
 
-	if (g_iommus[iommu->seq_id])
-		return 0;
-
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
 	if (ret)
 		goto out;
-- 
2.25.1

