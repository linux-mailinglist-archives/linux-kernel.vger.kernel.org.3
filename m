Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957E059C99D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiHVUJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiHVUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:09:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C851A0E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661198945; x=1692734945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3lntCW8tAwLfXyBJz2LcFV/4aMYlTAULIq84PkjceU=;
  b=kS03XLUjtkYmpsZWKKnyRXD8xgsqgXIYnFczZtigOhUAY2+cJK53F7NJ
   P9qeazAMqYe2sYBDPXUNied+Gu8FRbqL+iJ7o5mZpow8koIoIQDH5RIWT
   PykABPrESd8Ej6TRebCZDLGE+V7t4Zhwhy6kSk2dl97kcZq75Q+eQLvSh
   ITC3U+CUA/MumGHZ/u/Oo5fRcpKjXuF8LhaVCPIYAchHS08mqGlArkggu
   CRXjsPQeKmsJsHojWdtkYpI8hwdEQIxu7qR+VGT8C36RK+o/HvxM+62yh
   4QudD7ihIZJfxTcihRBn5/2aSZjNjkkhzNXVtLg5R9QFbX/NwR3UdG9rj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="276539358"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="276539358"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698414222"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 13:09:04 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] iommu: Use the user PGD for SVA if PTI is enabled
Date:   Mon, 22 Aug 2022 13:12:13 -0700
Message-Id: <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With page table isolation, the kernel manages two sets of page tables
for each process: one for user one for kernel. When enabling SVA, the
current x86 IOMMU drivers bind device and PASID with the kernel copy
of the process page table.

While there is no known "Meltdown" type of DMA attack, exposing
kernel mapping to DMA intended for userspace makes the system vulnerable
unnecessarily. It also breaks the intention of PTI.

This patch replaces kernel page table PGD with the user counterpart,
thus fulfill the promise of PTI on the DMA side.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/amd/iommu_v2.c | 4 +++-
 drivers/iommu/intel/svm.c    | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 696d5555be57..aea3075b94af 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -600,6 +600,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	struct pasid_state *pasid_state;
 	struct device_state *dev_state;
 	struct mm_struct *mm;
+	pgd_t *pgd;
 	u32 sbdf;
 	int ret;
 
@@ -645,8 +646,9 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (ret)
 		goto out_unregister;
 
+	pgd = static_cpu_has(X86_FEATURE_PTI) ? kernel_to_user_pgdp(mm->pgd) : mm->pgd;
 	ret = amd_iommu_domain_set_gcr3(dev_state->domain, pasid,
-					__pa(pasid_state->mm->pgd));
+					__pa(pgd));
 	if (ret)
 		goto out_clear_state;
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 8bcfb93dda56..7472cd98d3e8 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -332,6 +332,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	struct intel_svm *svm;
 	unsigned long sflags;
 	int ret = 0;
+	pgd_t *pgd;
 
 	svm = pasid_private_find(mm->pasid);
 	if (!svm) {
@@ -394,7 +395,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
 			PASID_FLAG_SUPERVISOR_MODE : 0;
 	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
+
+	pgd = static_cpu_has(X86_FEATURE_PTI) ? kernel_to_user_pgdp(mm->pgd) : mm->pgd;
+	ret = intel_pasid_setup_first_level(iommu, dev, pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	if (ret)
 		goto free_sdev;
-- 
2.25.1

