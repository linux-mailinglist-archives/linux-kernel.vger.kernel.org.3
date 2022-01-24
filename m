Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A614498834
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbiAXSVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:21:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:44634 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232267AbiAXSVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643048510; x=1674584510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y26tplK4MBeJTPKdULtMzAi3fXJk9jnVW3LLq/q0kbA=;
  b=E+kJA/nEgQFNVULdUQmiyNdGDZaLvQ4Uytu2Yc9e4+gPD4I3ihXAs2p4
   G8Wc/4Jys1AE8USaoVzsMcCEg/S98bGN4uRQHh6GmZyxK7KJpJztH7INJ
   Kff/8aNeXb9/NtaZkPeZVFo6XsJWiJ+IgWQTlqhOpEJ3+h1GW7JT1/V/Q
   NlL00YW1BtdCQMX/SZAqd2DT+3PXDwijWx9LqMJsGzqx61UjC3BmXlO1J
   MzcN1q/WT9tZ8estfzusy/gz0rXskuripvEdq+I+lwfYRl5fC2CNuJlI0
   loUxC4DX5qt1aO4+N07qjJVfkG9UN8F57VMH/Yvwx/FvaAVaUxi++WCqs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="306828256"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306828256"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:21:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695519102"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:21:49 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] highmem: Document kunmap_local()
Date:   Mon, 24 Jan 2022 10:21:38 -0800
Message-Id: <20220124182138.816693-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <Ye6bhQG6b6caYurD@infradead.org>
References: <Ye6bhQG6b6caYurD@infradead.org>
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
cause some questions.[1]

Document that any address in the page can be used in kunmap_local() to
clarify this for future users.

[1] https://lore.kernel.org/lkml/20211213154543.GM3538886@iweiny-DESK2.sc.intel.com/

Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V2
	Use suggested verbiage from Christoph Hellwig
---
 include/linux/highmem-internal.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 0a0b2b09b1b8..a77be5630209 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -246,6 +246,16 @@ do {								\
 	__kunmap_atomic(__addr);				\
 } while (0)
 
+/**
+ * kunmap_local - Unmap a page mapped via kmap_local_page().
+ * @__addr: An address within the page mapped
+ *
+ * @__addr can be any address within the mapped page.  Commonly it is the
+ * address return from kmap_local_page(), but it can also include offsets.
+ *
+ * Unmapping should be done in the reverse order of the mapping.  See
+ * kmap_local_page() for details.
+ */
 #define kunmap_local(__addr)					\
 do {								\
 	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
-- 
2.31.1

