Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE064AC0FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390142AbiBGOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346694AbiBGONR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:13:17 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE1C0401C3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644243196; x=1675779196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hGogMlAz2ABL6mZ3F5RdiX3bnIRNxQzIMwuH0LxLLDw=;
  b=iNxgyhf4mK4NfnPUUq6J8jQz+noAif4ARgAHeZ7x26ElM0SdsiQdcuzF
   ia+Z6eKWhnsYgo4JRMX1sFXYMnZ6PkpteJNLheGhyAib6wSLdbPJyrgI0
   K2PhP3KUtLy2ynemxzF8NGDRvyeVfM2KJGiYQNjP69p2rVNc5x62R0UYP
   cgVD3Fg0Ew+fzp1r6TqfdRp+UySCEOWtY3rV3oF/dDVbGtH2d+lSe2rUI
   fbdDbV0KR/lNhckXCveZ/YakaxeqLba7TGVepcd592Oaa6myFdLe7TSky
   IHi4NnWPBlGLhTebrMkD9K9tl2SVTXEAXwirPfOTBFGvHuKO5bSDIvaic
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="229371937"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="229371937"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 06:12:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="481594287"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 07 Feb 2022 06:12:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF32A31D; Mon,  7 Feb 2022 16:12:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Date:   Mon,  7 Feb 2022 16:12:40 +0200
Message-Id: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler is not happy about hidden declaration of intel_iommu_ops.

.../iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?

Move declaration to header file to make compiler happy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: made sure it compiles with IRQ_REMAP=y, INTEL_IOMMU=n (Lu)
 drivers/iommu/intel/dmar.c  | 2 --
 include/linux/intel-iommu.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 915bff76fe96..b114e09a647d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -66,8 +66,6 @@ static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
 static int alloc_iommu(struct dmar_drhd_unit *drhd);
 static void free_iommu(struct intel_iommu *iommu);
 
-extern const struct iommu_ops intel_iommu_ops;
-
 static void dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
 {
 	/*
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 69230fd695ea..1036c1900b5c 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -813,6 +813,8 @@ bool context_present(struct context_entry *context);
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 					 u8 devfn, int alloc);
 
+extern const struct iommu_ops intel_iommu_ops;
+
 #ifdef CONFIG_INTEL_IOMMU
 extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
-- 
2.34.1

