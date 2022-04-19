Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C942C507611
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355687AbiDSRLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355643AbiDSRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE02E0F7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388030; x=1681924030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qf9xNshiJlT4pUpMy4BR/enTPIkN1TfITI3Rx0+jKd0=;
  b=eU0hVwuKY2MekCinKD7zEdlmMrN5s4AKXw5y67VrkWMwlbgtL5RKugqV
   odBmctpfwvElPdgZqw9WF42RuDTjh0FPz/qPGUcJP9vu9EC0flyyt6sxL
   ZEOZTVbalLMaedVClcxjZeulX+JisiP76xjGhm5RzQ6reRK0dohI6loQ4
   r6GHtTDd2NNnDgjFJ0v9N69ztqY5nToS+pI56YTvdCHCy6h0mBBrvm58y
   tw9ZgR+hRej6wR54L8S2tmIdxKnOBOiR5xrY2LdisVk66lCxaNRh5lMOZ
   W+97+hcvNSvdRFG4nfiKazaygOY+uOI358DNhxuKTU8ZcblrdoIcHBHVm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263991859"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263991859"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="529397236"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:09 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 23/44] mm/pkeys: Introduce pks_update_exception()
Date:   Tue, 19 Apr 2022 10:06:28 -0700
Message-Id: <20220419170649.1022246-24-ira.weiny@intel.com>
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

Some PKS use cases will want to catch permissions violations with the
fault callback mechanism and optionally allow the access.

The pks_set_*() calls update the protection of the current running
context.  They will not work to change the protections of a thread which
has been interrupted.  Therefore updating a thread from within an
exception requires a different method.

Introduce pks_update_exception() which updates the faulted threads
protections in addition to the current context.

Add documentation

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Add preemption disable around pkrs per cpu cache
	Update commit message
	Change pkey type to u8
	s/pks_saved_pkrs/pkrs

Changes for V8
	Remove the concept of abandoning a pkey in favor of using the
		custom fault handler via this new pks_update_exception()
		call
	Without an abandon call there is no need for an abandon mask on
		sched in, new thread creation, or within exceptions...
	This now lets all invalid access' fault
	Ensure that all entry points into the pks has feature checks...
	Place abandon fault check before the test callback to ensure
		testing does not detect the double fault of the abandon
		code and flag it incorrectly as a fault.
	Change return type of pks_handle_abandoned_pkeys() to bool
---
 Documentation/core-api/protection-keys.rst |  3 ++
 arch/x86/mm/pkeys.c                        | 58 +++++++++++++++++++---
 include/linux/pks.h                        |  5 ++
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index f309cecc3915..c5f0f5d39929 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -149,6 +149,9 @@ Changing permissions of individual keys
 .. kernel-doc:: include/linux/pks.h
         :identifiers: pks_set_readwrite pks_set_noaccess
 
+.. kernel-doc:: arch/x86/mm/pkeys.c
+        :identifiers: pks_update_exception
+
 Overriding Default Fault Behavior
 ---------------------------------
 
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index a993c9b23815..975ed206d957 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -405,6 +405,18 @@ void pks_setup(void)
 	cr4_set_bits(X86_CR4_PKS);
 }
 
+static void __pks_update_protection(u8 pkey, u8 protection)
+{
+	u32 pkrs;
+
+	pkrs = current->thread.pkrs;
+	current->thread.pkrs = pkey_update_pkval(pkrs, pkey, protection);
+
+	preempt_disable();
+	pks_write_pkrs(current->thread.pkrs);
+	preempt_enable();
+}
+
 /*
  * Do not call this directly, see pks_set*().
  *
@@ -418,21 +430,51 @@ void pks_setup(void)
  */
 void pks_update_protection(u8 pkey, u8 protection)
 {
-	u32 pkrs;
-
 	if (!cpu_feature_enabled(X86_FEATURE_PKS))
 		return;
 
 	if (WARN_ON_ONCE(pkey >= PKS_KEY_MAX))
 		return;
 
-	pkrs = current->thread.pkrs;
-	current->thread.pkrs = pkey_update_pkval(pkrs, pkey,
-						 protection);
-	preempt_disable();
-	pks_write_pkrs(current->thread.pkrs);
-	preempt_enable();
+	__pks_update_protection(pkey, protection);
 }
 EXPORT_SYMBOL_GPL(pks_update_protection);
 
+/**
+ * pks_update_exception() - Update the protections of a faulted thread
+ *
+ * @regs: Faulting thread registers
+ * @pkey: pkey to update
+ * @protection: protection bits to use.
+ *
+ * CONTEXT: Exception
+ *
+ * pks_update_exception() updates the faulted threads protections in addition
+ * to the protections within the exception.
+ *
+ * This is useful because the pks_set_*() functions will not work to change the
+ * protections of a thread which has been interrupted.  Only the current
+ * context is updated by those functions.  Therefore, if a PKS fault callback
+ * wants to update the faulted threads protections it must call
+ * pks_update_exception().
+ */
+void pks_update_exception(struct pt_regs *regs, u8 pkey, u8 protection)
+{
+	struct pt_regs_extended *ept_regs;
+	u32 old;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	if (WARN_ON_ONCE(pkey >= PKS_KEY_MAX))
+		return;
+
+	__pks_update_protection(pkey, protection);
+
+	ept_regs = to_extended_pt_regs(regs);
+	old = ept_regs->aux.pkrs;
+	ept_regs->aux.pkrs = pkey_update_pkval(old, pkey, protection);
+}
+EXPORT_SYMBOL_GPL(pks_update_exception);
+
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
diff --git a/include/linux/pks.h b/include/linux/pks.h
index d0d8bf1aaa1d..2ea5fb57f2dc 100644
--- a/include/linux/pks.h
+++ b/include/linux/pks.h
@@ -9,6 +9,7 @@
 #include <uapi/asm-generic/mman-common.h>
 
 void pks_update_protection(u8 pkey, u8 protection);
+void pks_update_exception(struct pt_regs *regs, u8 pkey, u8 protection);
 
 /**
  * pks_set_noaccess() - Disable all access to the domain
@@ -41,6 +42,10 @@ typedef bool (*pks_key_callback)(struct pt_regs *regs, unsigned long address,
 
 static inline void pks_set_noaccess(u8 pkey) {}
 static inline void pks_set_readwrite(u8 pkey) {}
+static inline void pks_update_exception(struct pt_regs *regs,
+					u8 pkey,
+					u8 protection)
+{ }
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
-- 
2.35.1

