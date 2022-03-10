Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E254D503F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244786AbiCJRZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbiCJRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:58 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5919CCCD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932902; x=1678468902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTk+9fg3xxqlLphYlniN0akUys2MoAwrAiQS3zSHa5s=;
  b=cnGrwBY1AAh37DILFmya9+CgvTsnU3Y70mRRnMkUzbzX/2JEmijfyC4p
   eozW2yy3ziM/iZS9yECzwlbLsjmaOrfwFgA7e1muvdHd974E/VuKnvqWD
   lE8E/v4LU3/tyMMT253kwkyR8HU1UrUzkzq50ZDch3bBTxZEXeHEKFnMw
   2nrfRtNVrFwUor14ZeJM8EbIaSaZURi64n1HuVr3YaDdOiRlpJQRXmD/p
   c9fVp+BaAaQ4fPA114Qf9pDtapbg6bCVfiRV4rfo4xXIoXXOuOc1+4CYF
   TOwcNd2zTCrX5j0LwwZUl/0YDFkdUBZTHOBscR3ZBUhKZauFghQmGQfVB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237484393"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="237484393"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:41 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="510984375"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:41 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 34/45] memremap_pages: Add Kconfig for DEVMAP_ACCESS_PROTECTION
Date:   Thu, 10 Mar 2022 09:20:08 -0800
Message-Id: <20220310172019.850939-35-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The persistent memory (PMEM) driver uses the memremap_pages facility to
provide 'struct page' metadata (vmemmap) for PMEM.  Given that PMEM
capacity may be orders of magnitude higher capacity than System RAM it
presents a large vulnerability surface to stray writes.  Unlike stray
writes to System RAM, which may result in a crash or other undesirable
behavior, stray writes to PMEM additionally are more likely to result in
permanent data loss. Reboot is not a remediation for PMEM corruption
like it is for System RAM.

Given that PMEM access from the kernel is limited to a constrained set
of locations (PMEM driver, Filesystem-DAX, and direct-I/O to a DAX
page), it is amenable to supervisor pkey protection.

Add a Kconfig option to configure additional devmap protections using
PKS.

Only PMEM which is advertised to the memory subsystem needs this
protection.  Therefore, the feature depends on NVDIMM_PFN.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Change this to enable arch pks consumer for mutual exclusion
		with testing all pkeys
	From Dan Williams
		Default to no
		Clean up commit message

Changes for V8
	Split this out from
		[PATCH V7 13/18] memremap_pages: Add access protection via supervisor Protection Keys (PKS)
---
 mm/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 850372b6aaec..ba8a557dcf81 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -776,6 +776,24 @@ config ZONE_DEVICE
 
 	  If FS_DAX is enabled, then say Y.
 
+config DEVMAP_ACCESS_PROTECTION
+	bool "Access protection for memremap_pages()"
+	depends on NVDIMM_PFN
+	depends on ARCH_HAS_SUPERVISOR_PKEYS
+	select ARCH_ENABLE_PKS_CONSUMER
+	default n
+
+	help
+	  Enable extra protections on device memory.  This protects against
+	  unintended access to devices such as a stray writes.  This feature is
+	  particularly useful to protect against corruption of persistent
+	  memory.
+
+	  This depends on architecture support of supervisor PKeys and has no
+	  overhead if the architecture does not support them.
+
+	  If you have persistent memory say 'Y'.
+
 config DEV_PAGEMAP_OPS
 	bool
 
-- 
2.35.1

