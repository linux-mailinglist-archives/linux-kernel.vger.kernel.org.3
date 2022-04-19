Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48993507616
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355917AbiDSRLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355658AbiDSRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E33DED9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388034; x=1681924034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ql2r7AqKnHApM/EHR/Pff0tcNQI0JekmA3IUxRweYz0=;
  b=JWymLZw2iN/fu/UnU9KDK1Ev49ZQ0YD22Nx4Yy9+nFJFLuZaeNU7ikFq
   LTIyZ+rFp5K5dBfQaUDv5QM8nyEtQ/qr/qelwVpsIFsWlyxLvbq+zvBDV
   7D7KFX1dZvEZJ4qPHR1yY1KzIZuAIyg+ichRv4OgYOfP9v1Shx6XDyWmr
   VbT1MjJiyApB36ZQjKYO7l9qc6tOX+2Q/tCDTT2Q8iidwcZautNB8hDzw
   Jqng7ncuIhEC0d8apjUz+6DSRGc5L9J1nYGEGwyn3T0L8eQ9++/YkTLOU
   CGGHFJwNJe2zV/0b61PDaKl01dS15SH2rY4GxlTONvQ5tAowbUL6YWgTK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="288918165"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="288918165"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="576192246"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:11 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 25/44] memremap_pages: Add Kconfig for DEVMAP_ACCESS_PROTECTION
Date:   Tue, 19 Apr 2022 10:06:30 -0700
Message-Id: <20220419170649.1022246-26-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Changes for V10
	Rebased to latest

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
index 29c272974aa9..fe1752e6e76c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -797,6 +797,24 @@ config ZONE_DEVICE
 
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
 #
 # Helpers to mirror range of the CPU page tables of a process into device page
 # tables.
-- 
2.35.1

