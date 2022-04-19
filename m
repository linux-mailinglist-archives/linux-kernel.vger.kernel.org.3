Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCE250763A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356131AbiDSRM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355644AbiDSRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAAF10FE0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388030; x=1681924030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3BionnZDsSMnuwX2BAiBk9rbYY0AKD+hMHLH+ghigtE=;
  b=RizUCaLobAXEIIzFcRfC/9OpC5TnNc2hI89tZacGy49twPIFfV/TKwHb
   T56ABHZNiHjw+hilhDmRTGGtZNj5ghMowEY0rFGiTcSuhAFwPSmUxifpr
   w/rw1gAM+0lLLRsRifk2o0dC0KtDQEbvk24YVDTUJFl2gIiR6AUeB5FAr
   10Jtb9dUeWG64PgRvZZ7gtq2SEks4AKSbtsrqwaD+2ZQnfmUmOBd9P/Kh
   792HPcmUNRaqVJVlJ6LszN0XkM1U39+Qvi3tVAaiMkkK9cu2Y2vTV1RfJ
   t1wF5FI3Y4eQf2jyk3GyL3FdJPOXnAHFckdBeSSTgOPL6lDqlcG2VZQDX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263991861"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263991861"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="804734133"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:10 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 24/44] mm/pkeys: Add pks_available()
Date:   Tue, 19 Apr 2022 10:06:29 -0700
Message-Id: <20220419170649.1022246-25-ira.weiny@intel.com>
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

If PKS is configured within the kernel but the CPU does not support PKS,
the PKS calls remain safe to execute even without protection.  However,
adding the overhead of these calls on CPUs which don't support PKS is
inefficient and best avoided.

Define pks_available() to allow users to check if PKS is enabled on the
current system.

The implementation of pks_available() is placed in the asm headers while
being directly exported via linux/pks.h to allow for the inline calling
of cpu_feature_enabled() by consumers outside of the architecture.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Driven by a request by Dan Williams to make this static inline
		Place this in pks.h to avoid header conflicts while
		allowing for an optimized call to cpu_feature_enabled()

Changes for V8
	s/pks_enabled/pks_available
---
 Documentation/core-api/protection-keys.rst |  3 +++
 arch/x86/include/asm/pks.h                 | 12 ++++++++++++
 include/linux/pks.h                        |  8 ++++++++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index c5f0f5d39929..47bcb38fff4f 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -152,6 +152,9 @@ Changing permissions of individual keys
 .. kernel-doc:: arch/x86/mm/pkeys.c
         :identifiers: pks_update_exception
 
+.. kernel-doc:: arch/x86/include/asm/pks.h
+        :identifiers: pks_available
+
 Overriding Default Fault Behavior
 ---------------------------------
 
diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index de67d5b5a2af..cab42aadea07 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -2,8 +2,20 @@
 #ifndef _ASM_X86_PKS_H
 #define _ASM_X86_PKS_H
 
+#include <asm/cpufeature.h>
+
 #ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
 
+/**
+ * pks_available() - Is PKS available on this system
+ *
+ * Return if PKS is currently supported and enabled on this system.
+ */
+static inline bool pks_available(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_PKS);
+}
+
 void pks_setup(void);
 void x86_pkrs_load(struct thread_struct *thread);
 void pks_save_pt_regs(struct pt_regs *regs);
diff --git a/include/linux/pks.h b/include/linux/pks.h
index 2ea5fb57f2dc..151a3fda9de4 100644
--- a/include/linux/pks.h
+++ b/include/linux/pks.h
@@ -8,6 +8,9 @@
 
 #include <uapi/asm-generic/mman-common.h>
 
+#include <asm/pks.h>
+
+bool pks_available(void);
 void pks_update_protection(u8 pkey, u8 protection);
 void pks_update_exception(struct pt_regs *regs, u8 pkey, u8 protection);
 
@@ -40,6 +43,11 @@ typedef bool (*pks_key_callback)(struct pt_regs *regs, unsigned long address,
 
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
+static inline bool pks_available(void)
+{
+	return false;
+}
+
 static inline void pks_set_noaccess(u8 pkey) {}
 static inline void pks_set_readwrite(u8 pkey) {}
 static inline void pks_update_exception(struct pt_regs *regs,
-- 
2.35.1

