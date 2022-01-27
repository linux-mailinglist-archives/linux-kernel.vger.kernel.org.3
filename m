Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADC49E984
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245146AbiA0R5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:57:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:19413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244887AbiA0Rzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306141; x=1674842141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N0Tv6h4FB/cnby57OzSRsvLwV94sj1hOq8tCorWfjUU=;
  b=PvEbuGjY3Eo+yEZGX4dvh5M2DEhUMo6dFW0dERwAXKsn4MRNOkapidoT
   UjxL/2irzlOZG975XrowBC33Ey2HSjvjpoBDuLX3Z8YaVFF43Yub6zI9X
   qggMGHcpeQBIoMIyX8CyxFvFSfGXAlFlZMH8ncEupbFUgU9wQWRHKuu1I
   V78Z+DJF0OJBxk5tylwc07lCdCNlTUx77PHec0/Z1LEudKv/pEcTto8EC
   asKYIs3N97ZJ3AeSITi3OPivc02eEQyE2nm8yl7cJquk9UrWBgVWHqmM3
   QYK3YZRMhmiOGw/l3t8dkxw3R0DlEESr9Z0ciyALc8b677Po4UgPcKJun
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302449"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302449"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796162"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 31/44] mm/pkeys: Add pks_available()
Date:   Thu, 27 Jan 2022 09:54:52 -0800
Message-Id: <20220127175505.851391-32-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKS code calls will not fail if they are called and a CPU does not
support the PKS feature.  There will be no protection but the API is
safe to call.  However, adding the overhead of these calls on CPUs which
don't support PKS is inefficient

Define pks_available() to allow users to check if PKS is enabled on the
current system.  If not they can chose to optimize around the PKS calls.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	s/pks_enabled/pks_available
---
 Documentation/core-api/protection-keys.rst |  3 +++
 arch/x86/mm/pkeys.c                        | 10 ++++++++++
 include/linux/pkeys.h                      |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 267efa2112e7..27c9701d4aeb 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -151,6 +151,9 @@ Changing permissions of individual keys
 .. kernel-doc:: arch/x86/mm/pkeys.c
         :identifiers: pks_update_exception
 
+.. kernel-doc:: arch/x86/mm/pkeys.c
+        :identifiers: pks_available
+
 Overriding Default Fault Behavior
 ---------------------------------
 
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index f30ac8215785..fa71037c1dd0 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -418,6 +418,16 @@ static void __pks_update_protection(int pkey, u32 protection)
 	pks_write_pkrs(current->thread.pks_saved_pkrs);
 }
 
+/**
+ * pks_available() - Is PKS available on this system
+ *
+ * Return if PKS is currently supported and enabled on this system.
+ */
+bool pks_available(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_PKS);
+}
+
 /*
  * Do not call this directly, see pks_mk*().
  *
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index a53e4f2c41af..ec5463c373a1 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -55,6 +55,7 @@ static inline bool arch_pkeys_enabled(void)
 
 #include <uapi/asm-generic/mman-common.h>
 
+bool pks_available(void);
 void pks_update_protection(int pkey, u32 protection);
 void pks_update_exception(struct pt_regs *regs, int pkey, u32 protection);
 
@@ -87,6 +88,11 @@ typedef bool (*pks_key_callback)(struct pt_regs *regs, unsigned long address,
 
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
+static inline bool pks_available(void)
+{
+	return false;
+}
+
 static inline void pks_mk_noaccess(int pkey) {}
 static inline void pks_mk_readwrite(int pkey) {}
 static inline void pks_update_exception(struct pt_regs *regs,
-- 
2.31.1

