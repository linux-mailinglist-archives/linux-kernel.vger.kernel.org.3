Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C562A49E962
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiA0Rzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:65458 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244568AbiA0RzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306116; x=1674842116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4WzwXFLi0aZeUn6o8i43ScgQBDszfxXlboNeSVTWdms=;
  b=ghg2PP9DwPtAuHklKV0GoaCaCCoA3lu0CZFksmr3a4ZLm05VnRaOejHj
   92chEC9dPpzkiRNNORG35w+bVgh1a9YK9bDh1S67rRxbvzGyKcMuNkNUG
   +bTLjmeq1RBSPlroeL8L3FhMvOx0NXIHN8R2JXZjvSy+hJYlXD9f3VAeX
   TTL9J02SqObv9uDktSQ/nKL0GXIMnqz21QIJxOfEm1h1F/dbjkQA8Hq6b
   /xTVojPfOMuSPlkhGj8sFenVToHJYxvBurMfhk6uHHEAKAXuuxdR2TfJt
   q2gp00kKl7G5mFTKtzrOkTnKN/T7NtKqz0rWx7AGvWI8XXNglBiTJ8CPZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899118"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899118"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796054"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:07 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 04/44] x86/pkeys: Add additional PKEY helper macros
Date:   Thu, 27 Jan 2022 09:54:25 -0800
Message-Id: <20220127175505.851391-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Avoid open coding shift and mask operations by defining and using helper
macros for PKey operations.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Move ahead of other patches.
	Simplify to only the macros used in the series
---
 arch/x86/include/asm/pkeys_common.h | 5 ++++-
 arch/x86/include/asm/pkru.h         | 8 ++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index 08c736669244..d02ab5bc3fff 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -6,6 +6,9 @@
 #define PKR_WD_BIT 0x2u
 #define PKR_BITS_PER_PKEY 2
 
-#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
+#define PKR_PKEY_SHIFT(pkey)	(pkey * PKR_BITS_PER_PKEY)
+
+#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
+#define PKR_WD_KEY(pkey)	(PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
 
 #endif /*_ASM_X86_PKEYS_COMMON_H */
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index 06980dd42946..81ddf88ac3c9 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -15,17 +15,13 @@ extern u32 init_pkru_value;
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
-
-	return !(pkru & (PKR_AD_BIT << pkru_pkey_bits));
+	return !(pkru & PKR_AD_KEY(pkey));
 }
 
 static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
-
 	/* Access-disable disables writes too so check both bits here. */
-	return !(pkru & ((PKR_AD_BIT|PKR_WD_BIT) << pkru_pkey_bits));
+	return !(pkru & (PKR_AD_KEY(pkey) | PKR_WD_KEY(pkey)));
 }
 
 static inline u32 read_pkru(void)
-- 
2.31.1

