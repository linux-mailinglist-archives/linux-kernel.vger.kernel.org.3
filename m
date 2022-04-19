Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28933507625
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355993AbiDSRMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355664AbiDSRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:10:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB21412086
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388044; x=1681924044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oZIm80ulIEDYKtHknpk3AI06Sl6C4d9v82++CYANf+8=;
  b=a60QbO05PqpqiywfvVvA2bDCo5Woruq2i+fLTCed/lgGd2Z1fK07pg90
   oNZPVfZkRvRYayr/D11SG0836Cc8gm2UlEsjnEh2agVzAznC1UBqaQvnC
   p980w8g/xvY0k2VORY/1p6whQzXnaJwo4OEcIWPsWGVyUNyNmGXvT/Z5E
   bm3d9DkeRlgIiFerunTnC2Rft8pQHqLmYiFIItQyHfj90msByribav7UB
   lhdr33bvu5JOzEh2dFbeqzYcktXNRtXUYQ0gBv1C9qeGD/uYW6hW3QNSa
   GhBF9XJhyPj0MGX14BLT5GvN8tr5wFegJVaLhowAcoEAQ1d/UyTRoxZtc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245710131"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245710131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="576192310"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:24 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 39/44] mm/pkeys: PKS testing, add a fault call back
Date:   Tue, 19 Apr 2022 10:06:44 -0700
Message-Id: <20220419170649.1022246-40-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes for V10
	Adjust for the PMEM use case being added first.

Changes for V9
	New Patch
---
 arch/x86/mm/pkeys.c | 3 +++
 include/linux/pks.h | 7 +++++++
 lib/pks/pks_test.c  | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index e9a8c67f6b66..9e0948766427 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -248,6 +248,9 @@ static const pks_key_callback pks_key_callbacks[PKS_KEY_MAX] = {
 #ifdef CONFIG_DEVMAP_ACCESS_PROTECTION
 	[PKS_KEY_PGMAP_PROTECTION]   = pgmap_pks_fault_callback,
 #endif
+#ifdef CONFIG_PKS_TEST
+	[PKS_KEY_TEST]		= pks_test_fault_callback,
+#endif
 };
 
 static bool pks_call_fault_callback(struct pt_regs *regs, unsigned long address,
diff --git a/include/linux/pks.h b/include/linux/pks.h
index 151a3fda9de4..fd0ed09dd143 100644
--- a/include/linux/pks.h
+++ b/include/linux/pks.h
@@ -57,4 +57,11 @@ static inline void pks_update_exception(struct pt_regs *regs,
 
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

