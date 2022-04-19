Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7773F50762F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiDSRLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355707AbiDSRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DA5140EF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388049; x=1681924049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BeVeTCAa8T+wbEw6iF6i/AKwrHy3n4a/PM6Pqzd7T5Y=;
  b=l1ZvKx1U6IdYogizIOizAungFpkIGcmHVMZE5YM0LIqpIf7cJA3Qk4UI
   rqoyB7oVZ3uYHlftwu5FtyF/ruE+39JxFm3pmMP1JTZg9NBGzy0HoFy5/
   Cizs0RqhBbab2GMNXQY8GMwa+caMgSxk1qOMjhszMqsWkndR2xN77h7PL
   VEdYRRpBGQlPSq7EHI1XPrV0bg/mNeQJcC7OQyuI0yoilGKBH4GFj/HlK
   wojgTo99VGYhxAoJv26XqOKnnTWLn4e/gOoF866PgOkzvNyQtEAFzOWg9
   4rnxaTTBILp0iZ39A8gk1Fth2/WbXpWJVelXcGhwlDrstDQf+o0i2wjz/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="243750621"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="243750621"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="702255106"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:13 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 28/44] memremap_pages: Introduce devmap_protected()
Date:   Tue, 19 Apr 2022 10:06:33 -0700
Message-Id: <20220419170649.1022246-29-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Consumers of protected dev_pagemaps can check the PGMAP_PROTECTION flag to
see if the devmap is protected.  However, most contexts will have a struct
page not the pagemap structure directly.

Define devmap_protected() to determine if a page is part of a
dev_pagemap mapping and if the page is protected by additional
protections.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V10
	Move code from mm.h to memremap.h
		Upstream separated memremap.h functionality from mm.h
		dc90f0846df4 ("mm: don't include <linux/memremap.h> in <linux/mm.h>")
---
 include/linux/memremap.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 02c415b1b278..6325f00096ec 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -223,6 +223,23 @@ static inline bool pgmap_protection_available(void)
 	return pks_available();
 }
 
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
 #else
 
 static inline bool pgmap_protection_available(void)
-- 
2.35.1

