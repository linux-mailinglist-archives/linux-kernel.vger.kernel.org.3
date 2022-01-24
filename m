Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0984976E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 02:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbiAXBau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 20:30:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:50683 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238668AbiAXBat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 20:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642987849; x=1674523849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ey+n2vpf3UL7JY06ddv7LGT5N6OBRc7eHh0eSLSCsF4=;
  b=EcbWGnPwXvkFL8z5O85aKzV0/KOLYNbdwrng4TxLEihUEEvpn8MgOpwL
   S6aWmQkkudwWShnkQ8QmfOZCY2BXkytKjkMTGRgMz+OFMDPdT2BiJT7vm
   4xMGp23wT5LxXRMrTgO6wRLtqOYH2BjVpZvlnFqbhq2Qnzz0yLUZwl7iN
   +fJaUoew5UxZ3PKHux6nSmxCqsGHrGdEsN7Qi5kR5stTKISHGQmiAHh3m
   YOGFO8fY+ZIf2BP7+1OwxYIdJPydnC+YUSd5kY7Sj3473c33SaVetLjQv
   wt9QJ2RXxsuJe1Ax5lHKmXaBvVyu5K2/BOXdj+WRjhX/sf3BwIGjb7bTM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="225920905"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="225920905"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:30:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627316501"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 17:30:48 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] highmem: Document kunmap_local()
Date:   Sun, 23 Jan 2022 17:30:44 -0800
Message-Id: <20220124013045.806718-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Some users of kmap() add an offset to the kmap() address to be used
during the mapping.

When converting to kmap_local_page() the base address does not
need to be stored because any address within the page can be used in
kunmap_local().  However, this was not clear from the documentation and
caused some questions.[1]

Document that any address in the page can be used in kunmap_local() to
clarify this for future users.

[1] https://lore.kernel.org/lkml/20211213154543.GM3538886@iweiny-DESK2.sc.intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/highmem-internal.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 0a0b2b09b1b8..fb2d3e033c01 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -246,6 +246,17 @@ do {								\
 	__kunmap_atomic(__addr);				\
 } while (0)
 
+/**
+ * kunmap_local - Unmap a page mapped via kmap_local_page().
+ * @__addr: An address within the page mapped
+ *
+ * __addr is often an address returned from kmap_local_page().  However,
+ * this address can be any address within the mapped page.  It does not need to
+ * be the exact address returned from kmap_local_page()
+ *
+ * Unmapping should be done in the reverse order of the mapping.  See
+ * kmap_local_page() for details.
+ */
 #define kunmap_local(__addr)					\
 do {								\
 	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
-- 
2.31.1

