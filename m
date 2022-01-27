Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F7749E972
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245056AbiA0R43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:19418 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244891AbiA0Rzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306131; x=1674842131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=klKmNgWFiTbZ7mbu6bCq0GUu9+o0tnvTpl/zZa5vWuY=;
  b=RJITqKgX2xV4bdabKSV/zxj4Bf61FWP5l/6vwC8clBaZICckXRPsoqpK
   nwEHytSk1HRVAboCjX+QXKqW1mvguM0fCMA1s80L+Hz0Q1wH/LTNgCJ37
   nMT9ESTgItFq9WfDO9FyLqEZlhHGYf81xA+1pzm8tQhCI0tuzWgaVIbc1
   dVGNwnlVg1DvRBP3wZpZd4uROaKFDrC7aHRuwZu4uWxeab0xw+fh5ZWgd
   SDgJNsDH6mWvS3B3j8jyQD8mN2x/Yuk4RSW/PlFatNH2djfWmirhA+PGo
   JJ9PIvrtSTt4bKYk5lrMYvtJvnYgS/TeYG86f1sfeqkqPvN6eE3xjRnR9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302441"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302441"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796144"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:11 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 26/44] x86/fault: Print PKS MSR on fault
Date:   Thu, 27 Jan 2022 09:54:47 -0800
Message-Id: <20220127175505.851391-27-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

If a PKS fault occurs it will be easier to debug it if the PKS MSR value
at the time of the fault is known.

Add pks_dump_fault_info() to dump the PKRS MSR on fault if enabled.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Split this into it's own patch.
---
 arch/x86/include/asm/pks.h |  2 ++
 arch/x86/mm/fault.c        |  3 +++
 arch/x86/mm/pkeys.c        | 11 +++++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index 82baa594cb3b..fc3c66f1bb04 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -8,6 +8,7 @@ void pks_setup(void);
 void pks_write_current(void);
 void pks_save_pt_regs(struct pt_regs *regs);
 void pks_restore_pt_regs(struct pt_regs *regs);
+void pks_dump_fault_info(struct pt_regs *regs);
 
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
@@ -15,6 +16,7 @@ static inline void pks_setup(void) { }
 static inline void pks_write_current(void) { }
 static inline void pks_save_pt_regs(struct pt_regs *regs) { }
 static inline void pks_restore_pt_regs(struct pt_regs *regs) { }
+static inline void pks_dump_fault_info(struct pt_regs *regs) { }
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 030eb3e08550..697c06f08103 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -549,6 +549,9 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		 (error_code & X86_PF_PK)    ? "protection keys violation" :
 					       "permissions violation");
 
+	if (error_code & X86_PF_PK)
+		pks_dump_fault_info(regs);
+
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
 		struct desc_ptr idt, gdt;
 		u16 ldtr, tr;
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 33b7f84ed33b..bdd700d5ad03 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -288,6 +288,17 @@ void pks_restore_pt_regs(struct pt_regs *regs)
 	pks_write_pkrs(current->thread.pks_saved_pkrs);
 }
 
+void pks_dump_fault_info(struct pt_regs *regs)
+{
+	struct pt_regs_auxiliary *aux_pt_regs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	aux_pt_regs = &to_extended_pt_regs(regs)->aux;
+	pr_alert("PKRS: 0x%x\n", aux_pt_regs->pks_thread_pkrs);
+}
+
 /*
  * PKS is independent of PKU and either or both may be supported on a CPU.
  *
-- 
2.31.1

