Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27644FA112
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbiDIBae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbiDIB3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315BC10A95B;
        Fri,  8 Apr 2022 18:27:29 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ps2WXVNgYl4nyJI2lRV8TC/2vaAhuztayn9bqbA/J/w=;
        b=MBxwKd088u8bW+Cpm2mKYKYEVqI3EhcSvrXcB1l8VwzhCi+tvbeqmhPqc5Am4cTlhVQRAh
        J1rHgpdI0ci1NnHy7Zoll9SEsg4t5YNXydvX18JZ/3nloPYmo/R9wmHefKdWnSTMQJ0w9I
        hveG8ImnCwhoXGsaNjoVniSTxv4NXqEydF77ECTxJ8PhkzrrFQ11/e3/p7qFXny1Jz9ZbQ
        PPbiHikVjLqzCUEj6wmT8Tz7NupQyhabwg1r/niqbGfy0Qyhxiak6c5VY3xcx11Wu0w2F5
        vyJAxOCv3LxRbj1eXFhdCU8H6y1D/u28Yl00XC6Jt6rhkHLHFP5Ly5s3Ui6Jpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ps2WXVNgYl4nyJI2lRV8TC/2vaAhuztayn9bqbA/J/w=;
        b=yXhkmX2GSHbkrWVoXepIAo/p5nknbuxb3ZepgH8DFEhMB0Pudc+MIpeCqXsPCKn5Vlvcr9
        jwA1N179VwQSMADQ==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Wire up KVM hypercalls
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-20-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-20-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946764736.4207.8968915625205947075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     cfb8ec7a31f234b4519c104f1cc9accbc8b393a9
Gitweb:        https://git.kernel.org/tip/cfb8ec7a31f234b4519c104f1cc9accbc8b393a9
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:28 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:52 -07:00

x86/tdx: Wire up KVM hypercalls

KVM hypercalls use the VMCALL or VMMCALL instructions. Although the ABI
is similar, those instructions no longer function for TDX guests.

Make vendor-specific TDVMCALLs instead of VMCALL. This enables TDX
guests to run with KVM acting as the hypervisor.

Among other things, KVM hypercall is used to send IPIs.

Since the KVM driver can be built as a kernel module, export
tdx_kvm_hypercall() to make the symbols visible to kvm.ko.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-20-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c         | 17 +++++++++++++++++
 arch/x86/include/asm/kvm_para.h | 22 ++++++++++++++++++++++
 arch/x86/include/asm/tdx.h      | 11 +++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cc14b7c..f50f530 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -64,6 +64,23 @@ static u64 hcall_func(u64 exit_reason)
 	return exit_reason;
 }
 
+#ifdef CONFIG_KVM_GUEST
+long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
+		       unsigned long p3, unsigned long p4)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = nr,
+		.r11 = p1,
+		.r12 = p2,
+		.r13 = p3,
+		.r14 = p4,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
+#endif
+
 /*
  * Used for TDX guests to make calls directly to the TD module.  This
  * should only be used for calls that have no legitimate reason to fail
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 56935eb..57bc74e 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -7,6 +7,8 @@
 #include <linux/interrupt.h>
 #include <uapi/asm/kvm_para.h>
 
+#include <asm/tdx.h>
+
 #ifdef CONFIG_KVM_GUEST
 bool kvm_check_and_clear_guest_paused(void);
 #else
@@ -32,6 +34,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 static inline long kvm_hypercall0(unsigned int nr)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, 0, 0, 0, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr)
@@ -42,6 +48,10 @@ static inline long kvm_hypercall0(unsigned int nr)
 static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, p1, 0, 0, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1)
@@ -53,6 +63,10 @@ static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
 				  unsigned long p2)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, p1, p2, 0, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2)
@@ -64,6 +78,10 @@ static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
 				  unsigned long p2, unsigned long p3)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, p1, p2, p3, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3)
@@ -76,6 +94,10 @@ static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
 				  unsigned long p4)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, p1, p2, p3, p4);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3), "S"(p4)
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 9ffd0d2..020c81a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -76,5 +76,16 @@ static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
+long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
+		       unsigned long p3, unsigned long p4);
+#else
+static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
+				     unsigned long p2, unsigned long p3,
+				     unsigned long p4)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
