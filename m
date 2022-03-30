Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297E44ECF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351565AbiC3WUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351522AbiC3WU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:20:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB124F14;
        Wed, 30 Mar 2022 15:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648678719; x=1680214719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/z/ma86eqzanXki5Ihx3YhnJb2wCkQvdd7lMiO0am9M=;
  b=YZ1No4uTNbDLVLPmaMRlY0HMxE7D7D0qf9GsJopGyD+0vGH/ND1pWl0U
   Qn69jUNOAtmrepgqMQf3yJEUExC6i3qtgkO0IfnnBjsK51TuL2775CBQ+
   BhLsrQrzOzyY0IJL5wsVm+r8IGg4+KuipfMaSknwo3SnrBlgoBiLVyw21
   DpT/EnFmHDaYP/LB7Fja4xzJsFxNoAaH7kWgZDZsoEpv5i3AmGhjFOwsY
   m/veUnwbLfC5mKiEWCyxv1QElLISEO5mDGNDzKe7tZ3r9l9kOoKM5jqoY
   vwcdAzBgNpmYdcVzpDDNVJC3/WuTdpWLiMQATPK/QYMVyR/zkNKD2IdmM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="346095971"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="346095971"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="788171890"
Received: from ksanitha-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.123.221])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:18:23 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 4/6] x86/tdx: Add TDX Guest event notify interrupt vector support
Date:   Wed, 30 Mar 2022 15:18:03 -0700
Message-Id: <4f32bf1c75cdbeaeb3999fb8525f19f4bf4e7a0d.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
References: <cover.1648664666.git.sathyanarayanan.kuppuswamy@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate 0xec IRQ vector address for TDX guest to receive the event
completion notification from VMM. Since this vector address will be
sent to VMM via hypercall, allocate a fixed address and move
LOCAL_TIMER_VECTOR vector address by 1 byte. Also add related IDT
handler to process the notification event.

It will be mainly used by attestation driver to receive Quote event
completion notification from host.

Add support to track the notification event status via /proc/interrupts.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c            | 47 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/hardirq.h     |  4 +++
 arch/x86/include/asm/idtentry.h    |  4 +++
 arch/x86/include/asm/irq_vectors.h |  7 ++++-
 arch/x86/include/asm/tdx.h         |  4 +++
 arch/x86/kernel/irq.c              |  7 +++++
 6 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 14ba87b1e885..aab5d17fb454 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -12,6 +12,10 @@
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/apic.h>
+#include <asm/idtentry.h>
+#include <asm/irq_regs.h>
+#include <asm/desc.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
@@ -48,6 +52,28 @@
 #define TDVMCALL_GET_QUOTE_ERR		0x8000000000000000
 #define TDVMCALL_GET_QUOTE_QGS_UNAVIL	0x8000000000000001
 
+/*
+ * Handler used to report notifications about
+ * TDX_GUEST_EVENT_NOTIFY_VECTOR IRQ. Currently it will be
+ * used only by the attestation driver. So, race condition
+ * with read/write operation is not considered.
+ */
+static void (*tdx_event_notify_handler)(void);
+
+/* Helper function to register tdx_event_notify_handler */
+void tdx_setup_ev_notify_handler(void (*handler)(void))
+{
+        tdx_event_notify_handler = handler;
+}
+EXPORT_SYMBOL_GPL(tdx_setup_ev_notify_handler);
+
+/* Helper function to unregister tdx_event_notify_handler */
+void tdx_remove_ev_notify_handler(void)
+{
+        tdx_event_notify_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(tdx_remove_ev_notify_handler);
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -112,6 +138,21 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/* TDX guest event notification handler */
+DEFINE_IDTENTRY_SYSVEC(sysvec_tdx_event_notify)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	inc_irq_stat(irq_tdx_event_notify_count);
+
+	if (tdx_event_notify_handler)
+		tdx_event_notify_handler();
+
+	ack_APIC_irq();
+
+	set_irq_regs(old_regs);
+}
+
 /*
  * tdx_mcall_tdreport() - Generate TDREPORT_STRUCT using TDCALL.
  *
@@ -827,5 +868,11 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
 	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
 
+	alloc_intr_gate(TDX_GUEST_EVENT_NOTIFY_VECTOR,
+			asm_sysvec_tdx_event_notify);
+
+	if (tdx_hcall_set_notify_intr(TDX_GUEST_EVENT_NOTIFY_VECTOR))
+		pr_warn("Setting event notification interrupt failed\n");
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 275e7fd20310..3955b81f9241 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -44,6 +44,10 @@ typedef struct {
 	unsigned int irq_hv_reenlightenment_count;
 	unsigned int hyperv_stimer0_count;
 #endif
+#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
+	unsigned int tdx_ve_count;
+	unsigned int irq_tdx_event_notify_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 8ccc81d653b3..8ca55780df20 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -693,6 +693,10 @@ DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_xen_hvm_callback);
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_kvm_asyncpf_interrupt);
 #endif
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+DECLARE_IDTENTRY_SYSVEC(TDX_GUEST_EVENT_NOTIFY_VECTOR,	sysvec_tdx_event_notify);
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 43dcb9284208..82ac0c0a34b1 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -104,7 +104,12 @@
 #define HYPERV_STIMER0_VECTOR		0xed
 #endif
 
-#define LOCAL_TIMER_VECTOR		0xec
+#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
+/* Vector on which TDX Guest event notification is delivered */
+#define TDX_GUEST_EVENT_NOTIFY_VECTOR	0xec
+#endif
+
+#define LOCAL_TIMER_VECTOR		0xeb
 
 #define NR_VECTORS			 256
 
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 23c5023704a3..ba00ba8f5635 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -70,6 +70,10 @@ int tdx_mcall_tdreport(void *data, void *reportdata);
 
 int tdx_hcall_get_quote(void *data, u64 len);
 
+void tdx_setup_ev_notify_handler(void (*handler)(void));
+
+void tdx_remove_ev_notify_handler(void);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 766ffe3ba313..a96ecd866723 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -181,6 +181,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ",
 			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
+#endif
+#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
+	seq_printf(p, "%*s: ", prec, "TGN");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ",
+			   irq_stats(j)->irq_tdx_event_notify_count);
+	seq_puts(p, "  TDX Guest event notification\n");
 #endif
 	return 0;
 }
-- 
2.25.1

