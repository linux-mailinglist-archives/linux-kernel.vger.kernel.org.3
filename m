Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A640C49E971
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245186AbiA0R41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:65473 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244871AbiA0Rz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306128; x=1674842128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/5kL3YPno2knWFgAR17WabOcz7J2U7N6UL4fD+Thy3U=;
  b=JRXOIhlIl4KHc3SCLLhQ5lcYtAh3zmBGXWR8LZuFEVQNpcCm5u3ZUaQi
   nagUaIbl23Utpv2aPSaWi3Sq6F35jT/tU86yVELADh3gBJZnG8jkdScfZ
   3XY3f/gBKqu+QIzduB6c5umb4NDiNUoxWdLqhiuPYvkFzZr0kFNV+elFL
   0dSzFpCDKAcSR+u5VROyHQABDkahtIqVej0JlRlrIOGNTlEIfcoS2m6dA
   EntaeO4HBuE03psqRpPzkfXQCHKn3O+k4GD/nRqQMkLYVrA+Da+NcCVcM
   JuItDueeZuP9GxyaPdU1+HEND4qUXK6migGpAsrLTpG5Q78Ig9NyQ/1XP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899133"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899133"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796177"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 35/44] memremap_pages: Introduce devmap_protected()
Date:   Thu, 27 Jan 2022 09:54:56 -0800
Message-Id: <20220127175505.851391-36-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Users of protected dev_pagemaps can check the PGMAP_PROTECTION flag to
see if the devmap is protected.  However, most callers operate on struct
page's not the pagemap directly.

Define devmap_protected() to determine if a page is part of a
dev_pagemap mapping and if so if the page is protected by the additional
protections.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/mm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2ae99bee6e82..6e4a2758e3d3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1145,6 +1145,23 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 
 #ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
 
+DECLARE_STATIC_KEY_FALSE(dev_pgmap_protection_static_key);
+
+/*
+ * devmap_protected() requires a reference on the page to ensure there is no
+ * races with dev_pagemap tear down.
+ */
+static inline bool devmap_protected(struct page *page)
+{
+	if (!static_branch_unlikely(&dev_pgmap_protection_static_key))
+		return false;
+	if (!is_zone_device_page(page))
+		return false;
+	if (page->pgmap->flags & PGMAP_PROTECTION)
+		return true;
+	return false;
+}
+
 bool pgmap_protection_available(void);
 
 #else
-- 
2.31.1

