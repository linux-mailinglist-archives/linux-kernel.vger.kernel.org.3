Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3205837AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiG1Dol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiG1Doc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:44:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C185C96B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658979871; x=1690515871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTTSZhgjkRjTEP61mV1Ufgfpmy1St1UumLY6oPsETEk=;
  b=IbXpQqR8340AWfNsjtF1ClkPbrjaBewsBM1PAQs94OrbL+kda2FO5FOr
   RHMadhBkboXasV8a2VKtPwIcLXO48AFj4aJH0PNAMkAIECFrgnjf5WneJ
   Ve+1x/IYV8lLkZ1mCgpFJiRvKPqv9F2eNRPICWNnZ0og2RbFx5YmppKnc
   CWbXQ+UtmTixEHkDzp8VbCT3sHYKkhdeiFRSQjVjhQi3mP1qcIR81Cw4M
   lCTqIarhF8Cz60n98DmA8Bjvr4l7kBK5NQrxW5A075kIjSG0dOsGaczdS
   sjLu6jGcIfxLy7gFceaU7FcXYT5ysgC5WB9AqLRBe/wdZU1zfCXUCfhHF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="275292807"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="275292807"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="600676739"
Received: from hurleyst-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.106.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:30 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/6] x86/tdx: Add TDX Guest event notify interrupt support
Date:   Wed, 27 Jul 2022 20:44:17 -0700
Message-Id: <20220728034420.648314-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host-guest event notification via configured interrupt vector is useful
in cases where a guest makes an asynchronous request and needs a
callback from the host to indicate the completion or to let the host
notify the guest about events like device removal. One usage example is,
callback requirement of GetQuote asynchronous hypercall.

In TDX guest, SetupEventNotifyInterrupt hypercall can be used by the
guest to specify which interrupt vector to use as an event-notify
vector to the VMM. Details about the SetupEventNotifyInterrupt
hypercall can be found in TDX Guest-Host Communication Interface
(GHCI) Specification, sec 3.5 "VP.VMCALL<SetupEventNotifyInterrupt>".
Add a tdx_hcall_set_notify_intr() helper function to implement the
SetupEventNotifyInterrupt hypercall.

As per design VMM will post the event completion IRQ using the same CPU
in which SetupEventNotifyInterrupt hypercall request is received. So
allocate an IRQ vector from "x86_vector_domain", and set the CPU
affinity of the IRQ vector to the current CPU.

Please note that this patch only reserves the IRQ number. It is
expected that the user of event notify IRQ (like GetQuote handler) will
directly register the handler for "tdx_notify_irq" IRQ by using
request_irq() with  IRQF_SHARED flag set. Using IRQF_SHARED will enable
multiple users to use the same IRQ for event notification.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c    | 84 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/tdx.h |  2 +
 2 files changed, 86 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 205f98f42da8..3563b208979c 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,12 +8,16 @@
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/numa.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/irqdomain.h>
 
 #include "tdx.h"
 
@@ -24,6 +28,7 @@
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
+#define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -42,6 +47,7 @@
 #define DRIVER_NAME	"tdx-guest"
 
 static struct miscdevice tdx_misc_dev;
+int tdx_notify_irq = -1;
 
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
@@ -107,6 +113,31 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/*
+ * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
+ *
+ * @vector: Vector address to be used for notification.
+ *
+ * return 0 on success or failure error number.
+ */
+static long tdx_hcall_set_notify_intr(u8 vector)
+{
+	/* Minimum vector value allowed is 32 */
+	if (vector < 32)
+		return -EINVAL;
+
+	/*
+	 * Register callback vector address with VMM. More details
+	 * about the ABI can be found in TDX Guest-Host-Communication
+	 * Interface (GHCI), sec titled
+	 * "TDG.VP.VMCALL<SetupEventNotifyInterrupt>".
+	 */
+	if (_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0))
+		return -EIO;
+
+	return 0;
+}
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
@@ -830,3 +861,56 @@ static int __init tdx_guest_init(void)
 	return 0;
 }
 device_initcall(tdx_guest_init)
+
+/* Reserve an IRQ from x86_vector_domain for TD event notification */
+static int __init tdx_arch_init(void)
+{
+	struct irq_alloc_info info;
+	struct irq_cfg *cfg;
+	int cpu;
+
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return 0;
+
+	/* Make sure x86 vector domain is initialized */
+	if (!x86_vector_domain) {
+		pr_err("x86 vector domain is NULL\n");
+		return 0;
+	}
+
+	init_irq_alloc_info(&info, NULL);
+
+	/*
+	 * Event notification vector will be delivered to the CPU
+	 * in which TDVMCALL_SETUP_NOTIFY_INTR hypercall is requested.
+	 * So set the IRQ affinity to the current CPU.
+	 */
+	cpu = get_cpu();
+
+	info.mask = cpumask_of(cpu);
+
+	tdx_notify_irq = irq_domain_alloc_irqs(x86_vector_domain, 1,
+				NUMA_NO_NODE, &info);
+
+	if (tdx_notify_irq < 0) {
+		pr_err("Event notification IRQ allocation failed %d\n",
+				tdx_notify_irq);
+		goto init_failed;
+	}
+
+	irq_set_handler(tdx_notify_irq, handle_edge_irq);
+
+	cfg = irq_cfg(tdx_notify_irq);
+	if (!cfg) {
+		pr_err("Event notification IRQ config not found\n");
+		goto init_failed;
+	}
+
+	if (tdx_hcall_set_notify_intr(cfg->vector))
+		pr_err("Setting event notification interrupt failed\n");
+
+init_failed:
+	put_cpu();
+	return 0;
+}
+arch_initcall(tdx_arch_init);
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 020c81a7c729..8f933e67547f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,8 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+extern int tdx_notify_irq;
+
 #else
 
 static inline void tdx_early_init(void) { };
-- 
2.25.1

