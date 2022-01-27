Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A549E95D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiA0Rza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:19418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244712AbiA0RzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306115; x=1674842115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOpGQHbLg5P47A/NaN991tZuJORFucxdhxqawe4Tf4o=;
  b=NN1lDplokQSk92k5E8edBTaxR2pCD7yA0s/Oemuzn7osUYaFTdzgBb5b
   fBgrRapZPfWZ0lC3EpiljD87uypwqHD13XKEvDg/jjwmliNeSa0V/UhvE
   qtQVQzjTudz0zlXOyZSKz7NPPCsgoraffNgNPBBPx2wJg5TFdiFF8xgUT
   aGHt0bGcsWwUsIel9IDbYLyP9bUSaZxo7CTNSUJiWNvR2THqx/VPX5b0W
   27XiA0BtiENeJLVUK4BYCMxPLweLcMhcWiDWEwf2hPOV6zeCzDmPrsq1V
   JZp9cn1LC9dbPcTAAFGVpw3t/2/UzgZZeaMdWhdXFxEmFhcYVCpCgceMz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302427"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302427"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796103"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 17/44] mm/pkeys: Introduce pks_mk_noaccess()
Date:   Thu, 27 Jan 2022 09:54:38 -0800
Message-Id: <20220127175505.851391-18-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

After a valid access for a PKS protected page Users will need to change
the protections back to No Access for their Pkey

Define pks_mk_noaccess() to update the specified Pkey

Add documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Make the call inline
	Split this patch out from 'Add PKS kernel API'
	Include documentation in this patch
---
 Documentation/core-api/protection-keys.rst |  2 +-
 include/linux/pkeys.h                      | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index e4a27b93f3d4..115afc67153f 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -145,7 +145,7 @@ Changing permissions of individual keys
 ---------------------------------------
 
 .. kernel-doc:: include/linux/pks-keys.h
-        :identifiers: pks_mk_readwrite
+        :identifiers: pks_mk_readwrite pks_mk_noaccess
 
 MSR details
 -----------
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 73b554b99123..5f4965f5449b 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -57,6 +57,18 @@ static inline bool arch_pkeys_enabled(void)
 
 void pks_update_protection(int pkey, u32 protection);
 
+/**
+ * pks_mk_noaccess() - Disable all access to the domain
+ * @pkey: the pkey for which the access should change.
+ *
+ * Disable all access to the domain specified by pkey.  This is not a global
+ * update and only affects the current running thread.
+ */
+static inline void pks_mk_noaccess(int pkey)
+{
+	pks_update_protection(pkey, PKEY_DISABLE_ACCESS);
+}
+
 /**
  * pks_mk_readwrite() - Make the domain Read/Write
  * @pkey: the pkey for which the access should change.
@@ -71,6 +83,7 @@ static inline void pks_mk_readwrite(int pkey)
 
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
+static inline void pks_mk_noaccess(int pkey) {}
 static inline void pks_mk_readwrite(int pkey) {}
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
-- 
2.31.1

