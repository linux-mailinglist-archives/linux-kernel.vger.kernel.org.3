Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB65C503179
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356321AbiDOWEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiDOWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:04:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB70D3A1BC;
        Fri, 15 Apr 2022 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650060093; x=1681596093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oydq3+d7mQBMPGq1EzH0wO2zS1pExRBKPUcB38S3vLo=;
  b=iWPJmoWV2Gq9sUIqmzJwgJM/xs56g26NQrS4Y2YAAQbKirkAbEz72D9D
   1oQ2PA0Bth/rVXSVnkBDdwJrp1Dzhe0UVf5R+q0vCaE949IXwl64OH7p+
   eNGGE+515yixmDZRtc0zvbCOI5VQDzBrlimi1zqes2W8y4xTERIos3gkO
   QbpA+Jac27ZxT5S31aXwSk5Bz48f4AgV3K45dcpxrGB2TbGr16BY5laOe
   DE6wNwvsId67V9Rh9ie7pfIFNy1FsAo0w5NwyvaOd3TXAPQXsp+Z7rYQe
   Do7J43weh1KQhVkzDWSny6B5vnqoHYXZgJmcEQxtfEnfYAUM85ogbxFzo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="288303534"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="288303534"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="612949097"
Received: from smashtou-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.128.210])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:31 -0700
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
Subject: [PATCH v3 3/4] x86/tdx: Add TDX Guest event notify interrupt support
Date:   Fri, 15 Apr 2022 15:01:08 -0700
Message-Id: <20220415220109.282834-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host-guest event notification via configured interrupt vector is
useful in cases where guest makes asynchronous request (like
attestation quote generate request) and need a callback from host to
indicate the completion or to let host notify the guest about events
like device removal

In TDX guest, SetupEventNotifyInterrupt hypercall can be used by the
guest to specify which interrupt vector to use as an event-notify
vector to the VMM. Details about the SetupEventNotifyInterrupt
hypercall can be found in TDX Guest-Host Communication Interface
(GHCI) Specification, sec 3.5 "VP.VMCALL<SetupEventNotifyInterrupt>".
Add a tdx_hcall_set_notify_intr() helper function to implement the
SetupEventNotifyInterrupt hypercall.

Reserve 0xec IRQ vector address for TDX guest to receive the event
completion notification from VMM. Also add related IDT handler to
process the notification event.

Add support to track the notification event status via
/proc/interrupts.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c            | 77 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/hardirq.h     |  3 ++
 arch/x86/include/asm/idtentry.h    |  4 ++
 arch/x86/include/asm/irq_vectors.h |  7 ++-
 arch/x86/include/asm/tdx.h         |  4 ++
 arch/x86/kernel/irq.c              |  7 +++
 6 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c259d81a5d7f..3b6fdfb31e87 100644
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
@@ -22,6 +26,7 @@
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_GET_QUOTE		0x10002
+#define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -41,6 +46,28 @@
 #define TDCALL_RETURN_CODE_MASK		0xffffffff00000000
 #define TDCALL_RETURN_CODE(a)		((a) & TDCALL_RETURN_CODE_MASK)
 
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
@@ -105,6 +132,21 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
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
@@ -182,6 +224,35 @@ long tdx_hcall_get_quote(void *data, u64 len)
 }
 EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
 
+/*
+ * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
+ *
+ * @vector        : Vector address to be used for notification.
+ *
+ * return 0 on success or failure error number.
+ */
+static long tdx_hcall_set_notify_intr(u8 vector)
+{
+	u64 ret;
+
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
+	ret = _tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
@@ -772,5 +843,11 @@ void __init tdx_early_init(void)
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
index 275e7fd20310..582deff56210 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -44,6 +44,9 @@ typedef struct {
 	unsigned int irq_hv_reenlightenment_count;
 	unsigned int hyperv_stimer0_count;
 #endif
+#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
+	unsigned int irq_tdx_event_notify_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 72184b0b2219..331d343e1d46 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -700,6 +700,10 @@ DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_xen_hvm_callback);
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
index 014cc6192dc5..7b8479f46757 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -71,6 +71,10 @@ long tdx_mcall_tdreport(void *data, void *reportdata);
 
 long tdx_hcall_get_quote(void *data, u64 len);
 
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

