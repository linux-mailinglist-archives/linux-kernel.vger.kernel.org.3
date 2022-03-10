Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B85C4D5034
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244587AbiCJRWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244605AbiCJRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EC8198EE0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932867; x=1678468867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qGe2ITb8rdP9lmNwk3HBu7sNalczSXfiao1EWBl3J7M=;
  b=UkHcOXNnZrjO3quahnIEKmdhidqeXGheaDH5YZEaPfugselp45bjw8G/
   N4y/CouIpgpuvB6ctTdC1Fc5LyHX1dLGt+UXuEuZlUzfTPbgTSkPQbHLN
   K7WAOCufQYoJ6jZI40X19ScSvZmPfTMg7pn05moeHlnJKEUVODk4eQ9bg
   GcEA5VF9cdO9vKS1nGHd4zT3P20PwbVtMPKQLbnD68IJA0v9zoeY5kYbq
   1WDSH3Kd2pN7z7XLruirHViVwz/5usBw4iGESeEgrStzgWzilAS5htyUk
   8UGPycj5VT6E2tH9ECWMojWZPrf3AzaLKCO6iQjo8rCE/NevsUm9i1LgL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="252879360"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="252879360"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:07 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="611816018"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:07 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 20/45] mm/pkeys: PKS testing, add a fault call back
Date:   Thu, 10 Mar 2022 09:19:54 -0800
Message-Id: <20220310172019.850939-21-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

PKS testing will need to know when a fault occurs due to it's actions so
that it can properly determine functionality.

Install a PKS fault handler for the PKS test pkey.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	New Patch
---
 arch/x86/mm/pkeys.c | 6 +++++-
 include/linux/pks.h | 7 +++++++
 lib/pks/pks_test.c  | 6 ++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index a3b27b7811da..39867d39460b 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -243,7 +243,11 @@ static DEFINE_PER_CPU(u32, pkrs_cache);
  *	#endif
  *	};
  */
-static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = { 0 };
+static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = {
+#ifdef CONFIG_PKS_TEST
+	[PKS_KEY_TEST]		= pks_test_fault_callback,
+#endif
+};
 
 static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
 				    bool write, u16 key)
diff --git a/include/linux/pks.h b/include/linux/pks.h
index d0d8bf1aaa1d..208f88fcb48c 100644
--- a/include/linux/pks.h
+++ b/include/linux/pks.h
@@ -44,4 +44,11 @@ static inline void pks_set_readwrite(u8 pkey) {}
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
+#ifdef CONFIG_PKS_TEST
+
+bool pks_test_fault_callback(struct pt_regs *regs, unsigned long address,
+			     bool write);
+
+#endif /* CONFIG_PKS_TEST */
+
 #endif /* _LINUX_PKS_H */
diff --git a/lib/pks/pks_test.c b/lib/pks/pks_test.c
index 2fc92aaa54e8..37f2cd7d0f56 100644
--- a/lib/pks/pks_test.c
+++ b/lib/pks/pks_test.c
@@ -85,6 +85,12 @@ static void debug_result(const char *label, int test_num,
 		     sd->last_test_pass ? "PASS" : "FAIL");
 }
 
+bool pks_test_fault_callback(struct pt_regs *regs, unsigned long address,
+			     bool write)
+{
+	return false;
+}
+
 static void *alloc_test_page(u8 pkey)
 {
 	return __vmalloc_node_range(PKS_TEST_MEM_SIZE, 1, VMALLOC_START,
-- 
2.35.1

