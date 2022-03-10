Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989D34D505A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbiCJRWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbiCJRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77859198EEB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932868; x=1678468868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rBkz60AtuW8mZx5N9YupMXAeEZuYPMoQ0o7MiBkuL74=;
  b=CSe2rAnxXOvswyGx7os9Tgm33XXo4a3/1lR2Kg5wmX0eImy3zhsRaID4
   mFkSyHF0dU/tNRZvIEl1Fu+YzpNau1qTWgOf4aQD4+Qc8dFjOYyp7NfkF
   stQHQ+NPPsZKZGGH/WdGPS9Lz6AiCmyPCGU1IcmHYmp/SBkePC/qqArQh
   X77tT1zMJJVQCxMTjT1xM6XAesrOq6GYdZkWzzCah2g6H5LwBvvekAOPD
   j8UEUufB7hCFYPM2qsfvlsottmwYeigDWzt54FmDZ1pqce7Qj928lMmm5
   dhCeTRDDHIXFWogHo6woC6eatklQLZH7YDjPsr/LE3K8n2DgAHh7AUy3p
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235261474"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="235261474"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="712450049"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:03 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 18/45] mm/pkeys: Introduce pks_set_noaccess()
Date:   Thu, 10 Mar 2022 09:19:52 -0800
Message-Id: <20220310172019.850939-19-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index e6564f5336b7..2ec35349ecfd 100644
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

