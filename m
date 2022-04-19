Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE650761B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355912AbiDSRLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355657AbiDSRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95728EA5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388032; x=1681924032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8HY8BDua6BN4XkwHxR01tuvztdYTdoms4hurcP8Ocpo=;
  b=U6qi3nPgQlvWwHsJBPyCKGZ8EofngQ1XOE7OJmb7mH2+kzbVocAl6DmN
   rT9+sYjxZhaMldriTek4uZoqm6szYSe/O0i79U3mWa6FZuJCSzZdqgnij
   TF7tEXAAGWSvzFgFefCqFY8XxQzicIc8prhsWvuwFnMCCA9cKLuB1zL/m
   9wHEnZcx6CkgCfM+6Sy1G3/YNXDvYjpp7MftpQ6OP/2Yxz4/WrcTb3gSc
   3W1VBHTvnX+ZXRMMB9KuktVABofp+AviJrJTT2lBVA2M6oBta7fGVRCUC
   knzrc6Qlhvq/vrO//Cir670VKGO+Tp41tUKp4m24p98aNz8+3Qfkkis+e
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350267610"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="350267610"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="510207192"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:11 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 26/44] memremap_pages: Introduce pgmap_protection_available()
Date:   Tue, 19 Apr 2022 10:06:31 -0700
Message-Id: <20220419170649.1022246-27-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes for V10
	Move code from mm.h to memremap.h
		Upstream separated memremap.h functionality from mm.h
		dc90f0846df4 ("mm: don't include <linux/memremap.h> in <linux/mm.h>")

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
 include/linux/memremap.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 8af304f6b504..7980d0db8617 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -6,6 +6,7 @@
 #include <linux/range.h>
 #include <linux/ioport.h>
 #include <linux/percpu-refcount.h>
+#include <linux/pks.h>
 
 struct resource;
 struct device;
@@ -214,4 +215,20 @@ static inline void put_dev_pagemap(struct dev_pagemap *pgmap)
 		percpu_ref_put(&pgmap->ref);
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
 #endif /* _LINUX_MEMREMAP_H_ */
-- 
2.35.1

