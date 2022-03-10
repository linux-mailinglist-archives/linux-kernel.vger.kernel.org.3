Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7BD4D504D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbiCJRYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245048AbiCJRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF319D619
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932912; x=1678468912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tvRXjoAFFcc2ruAmi1/nDqUmMjQ6lnLDMTZxTsUwIc=;
  b=LpQ1jAPcPMfsYIESCR9aU+zM94hd/R5w5I8zjFNf3DNRy9/heVtNLAUg
   inlyIYZfp+8hmF66RwuK3czZZWeedq0F3aI67emjmo4fCTaAQ0rpJKQze
   nyyU8ShCeaDKY7w8YS5x/cAOn7f2oae7zaGES0+F5pcthwckNW6wD9Ets
   ciqiZWuOubE9U8q3seD3d4lXDzie+dAFJaCF3CNfySrOiDSHp9N6UAWbd
   xJqKYs0PU/jRk981UjjvikH0FMAcE5Gf1IkagIkPn+z6XA/R6b8eYSL2P
   eOpP7X6mX48J8emrbL34uDKUmcV67eM3TJLop4Insq77QEFxaFcdHpC/q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="252879520"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="252879520"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:43 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="633064588"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:43 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 35/45] memremap_pages: Introduce pgmap_protection_available()
Date:   Thu, 10 Mar 2022 09:20:09 -0800
Message-Id: <20220310172019.850939-36-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

PMEM will flag additional dev_pagemap protection through (struct
dev_pagemap)->flags.  However, it is more efficient to know if that
protection is available prior to requesting it and failing the mapping.

Define pgmap_protection_available() to check if protection is available
prior to being requested.  The name of pgmap_protection_available() was
specifically chosen to isolate the implementation of the protection from
higher level users.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Clean up commit message
	From Dan Williams
		make call stack static inline throughout this call and
			pks_available() such that callers calls
			cpu_feature_enabled() directly

Changes for V8
	Split this out to it's own patch.
	s/pgmap_protection_enabled/pgmap_protection_available
---
 include/linux/mm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5744a3fc4716..9ab799403004 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -31,6 +31,7 @@
 #include <linux/sizes.h>
 #include <linux/sched.h>
 #include <linux/pgtable.h>
+#include <linux/pks.h>
 #include <linux/kasan.h>
 
 struct mempolicy;
@@ -1143,6 +1144,22 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
+#ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
+
+static inline bool pgmap_protection_available(void)
+{
+	return pks_available();
+}
+
+#else
+
+static inline bool pgmap_protection_available(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_DEVMAP_ACCESS_PROTECTION */
+
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
-- 
2.35.1

