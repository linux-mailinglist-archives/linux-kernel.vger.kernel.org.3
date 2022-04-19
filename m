Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD0507615
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355786AbiDSRKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355552AbiDSRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C663FE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388024; x=1681924024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+5b3IZ2C5Hrv6G06EbPOOwQd6d5B5Nj2B016UVv3rJ8=;
  b=XqY1aV5zQ9Ph/ZicmT9XrhToK0wx5AhoVazf08z8j32Igsb4ZiJKQT12
   Gj6fxqmYtpjiyR3pnTV8Ezd6vgpXAOzWVcsIYSQPDOn73/Pd0mGx3RvJ+
   Kph+NAN1y6LBRUvge1RpBbOv+nBH3Gh772MQvBmC0FU37oZymY8uAOA1C
   MjkyeuZ6scrP2g9K5kEPkmJJKNyR0aqxJ8kvRKwchnGx5X89cks2xuvKc
   6ED4DJ/XvCccENTu9EF531BfTNYBSnlmm37N6+pDgSq4flBJU7f2E1WcD
   g6xdcQiM7ExxMHHZLZoOCK8GFxfrHiLy5WNHdCaMlwY0Ek2vBAQc9IU9L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263991827"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263991827"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="861588314"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:02 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 15/44] mm/pkeys: Introduce pks_set_noaccess()
Date:   Tue, 19 Apr 2022 10:06:20 -0700
Message-Id: <20220419170649.1022246-16-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

After a valid access consumers will want to change PKS protections back
to No Access for their pkey.

Define pks_set_noaccess() to update the specified pkey.

Add documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Move to pks.h
	Change pkey type to u8
	From 0day
		Fix documentation link
	From Dave Hansen
		use pkey
		s/pks_mk*/pks_set*/

Changes for V8
	Make the call inline
	Split this patch out from 'Add PKS kernel API'
	Include documentation in this patch
---
 Documentation/core-api/protection-keys.rst |  2 +-
 include/linux/pks.h                        | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 3af92e1cbffd..78904d98519b 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -147,7 +147,7 @@ Changing permissions of individual keys
 ---------------------------------------
 
 .. kernel-doc:: include/linux/pks.h
-        :identifiers: pks_set_readwrite
+        :identifiers: pks_set_readwrite pks_set_noaccess
 
 MSR details
 ~~~~~~~~~~~
diff --git a/include/linux/pks.h b/include/linux/pks.h
index 8b705a937b19..9f18f8b4cbb1 100644
--- a/include/linux/pks.h
+++ b/include/linux/pks.h
@@ -10,6 +10,18 @@
 
 void pks_update_protection(u8 pkey, u8 protection);
 
+/**
+ * pks_set_noaccess() - Disable all access to the domain
+ * @pkey: the pkey for which the access should change.
+ *
+ * Disable all access to the domain specified by pkey.  This is not a global
+ * update and only affects the current running thread.
+ */
+static inline void pks_set_noaccess(u8 pkey)
+{
+	pks_update_protection(pkey, PKEY_DISABLE_ACCESS);
+}
+
 /**
  * pks_set_readwrite() - Make the domain Read/Write
  * @pkey: the pkey for which the access should change.
@@ -24,6 +36,7 @@ static inline void pks_set_readwrite(u8 pkey)
 
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
+static inline void pks_set_noaccess(u8 pkey) {}
 static inline void pks_set_readwrite(u8 pkey) {}
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
-- 
2.35.1

