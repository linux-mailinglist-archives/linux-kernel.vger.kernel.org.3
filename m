Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D0C4D5045
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbiCJRXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245014AbiCJRXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A971719CCFB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932908; x=1678468908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YWrHF323fKzmMvTAQ5OGka1RcQpaIQBfJCMlhK0zcn4=;
  b=Gfi6G2SBXXsQIBYJ+4Mo1WFQTsysS/T7k2cbjUV3wHRn5s4dAFvUkPQd
   JcOE5Ulm9gY1Wol2i0dc82mjx0RY+xYXzBIzJDYBjR0prZd9E7XOp8WYj
   XErb5LInUozvCKImzyZDZCtg8a8ivIGQFUYjjWvre8fgwEjZLR5JkXQGG
   i+Uq/Kg0GALkFn5L0UM3/HEdSlLZufJ28Bp4mZDgYnA30l1/y+CpaHk4C
   i3AysXX3K0JHuT8AhS9JgT+GTteCPnuRBO7Kwxv95QdVAeF99So3yVxlI
   Gm7BJoWiWopgeec4zog/JDsa/seOZhOS6v+cTh9ja5GvTfkcAq+ToWoUn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="254142181"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="254142181"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="712450536"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:47 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 37/45] memremap_pages: Introduce devmap_protected()
Date:   Thu, 10 Mar 2022 09:20:11 -0800
Message-Id: <20220310172019.850939-38-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 include/linux/mm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9ab799403004..4ca24329848a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1151,6 +1151,23 @@ static inline bool pgmap_protection_available(void)
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

