Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76695441A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiFICxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiFICwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:52:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9C71A15C6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654743164; x=1686279164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZUdhtuCT+AgAPEJzu+YmE67fal44Ztn/xCMaaPq/s4=;
  b=DtDtXys7S8YzTggSIGBjVNJDoJklIBXeMoPB6HX7W5fNGhMXouMAlM8t
   wQYc9F7F5v3f4nwygCe0SO/U7HEM3VZ8rWYZVSPNJoG7NfcB1Hwsmzpbm
   uyeuoFOgcWkg0npL4q3OI9NZM1d6PJi0Q9U7PLxdshzybI0gl/io7BQQ5
   WYbnCZ8mExHpI6qax1WeYe9zWW6sTSVEeMBpMgqMfspdzEgLhqp9KGXze
   QgZH5VpsgEMdEMcmb+k3KFYd1gmEBSyoq+bEmu+hvE16zm+mgfTdkkF/8
   FAy5Hg+zVXEmVb5w+O1MJE8nK794v3rdnMQq3Im/4ZC9MkwT0RxSzwKg5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="363452722"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="363452722"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:52:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="683711293"
Received: from smsarifr-mobl.amr.corp.intel.com (HELO skuppusw-desk1.home) ([10.212.139.233])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:52:42 -0700
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
Subject: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt support
Date:   Wed,  8 Jun 2022 19:52:17 -0700
Message-Id: <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Reserve 0xec IRQ vector address for TDX guest to receive the event
completion notification from VMM. Also add related IDT handler to
process the notification event.

Add support to track the notification event status via
/proc/interrupts.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c            | 71 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/hardirq.h     |  3 ++
 arch/x86/include/asm/idtentry.h    |  4 ++
 arch/x86/include/asm/irq_vectors.h |  7 ++-
 arch/x86/include/asm/tdx.h         |  4 ++
 arch/x86/kernel/irq.c              |  7 +++
 6 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 03deb4d6920d..94542876f26a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -11,6 +11,10 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/apic.h>
+#include <asm/idtentry.h>
+#include <asm/irq_regs.h>
+#include <asm/desc.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
@@ -19,6 +23,7 @@
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA		0x10001
+#define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -34,6 +39,26 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
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
+	tdx_event_notify_handler = handler;
+}
+
+/* Helper function to unregister tdx_event_notify_handler */
+void tdx_remove_ev_notify_handler(void)
+{
+	tdx_event_notify_handler = NULL;
+}
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -98,6 +123,46 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
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
@@ -688,5 +753,11 @@ void __init tdx_early_init(void)
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
index 72184b0b2219..655086dd940e 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -700,6 +700,10 @@ DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_xen_hvm_callback);
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_kvm_asyncpf_interrupt);
 #endif
 
+#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
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
index 020c81a7c729..eb4db837cc44 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,10 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
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

