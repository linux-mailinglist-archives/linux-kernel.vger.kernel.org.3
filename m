Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F994D5038
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244700AbiCJRXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244810AbiCJRW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7673119ABC8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932893; x=1678468893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEi5ixatEXIaTvJUZfAEuR4Ot8ERUfY1XluRiIAdkXA=;
  b=D1lloPreyr01uUGUggX9kNI9lNqPSvKTvB9QvguRXhjSD0amodXwEiEQ
   5+gSrBElG7yztmY5+72Q3CJt/OaNZlShURfAyyu9A6IRjvgKAPcvpv47N
   wZYomQfU1X+dp91zkQCMpFar01xvc5comH5CVrmqjG869McRjfGYDxhp0
   GvptGnyhl+YqRNrfegxlW/1onuK8IxeguOOfeRZtWUVUAQ5mvevsWAwY5
   EdNC3OCJGpnfEKqGqjnv+FHM+aqN5E7dgWnLfUZdn0LIsNEgMHlIelbwf
   9rllC6VKprrG9L0t1GwnNUgQbL+KJizD7jWM/r69rgVxjuvIDV6d/Dd4p
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237484381"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="237484381"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="554738100"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:32 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 30/45] mm/pkeys: Introduce pks_update_exception()
Date:   Thu, 10 Mar 2022 09:20:04 -0800
Message-Id: <20220310172019.850939-31-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 5fdc83a39d4e..22ad58a93423 100644
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
index 6327e32d7237..9b2a6a62d433 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -409,6 +409,18 @@ void pks_setup(void)
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
@@ -422,21 +434,51 @@ void pks_setup(void)
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
index 224fc3bbd072..45156f358776 100644
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

