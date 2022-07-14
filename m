Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16AD5740A4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiGNArB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNAq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:46:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB4493
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657759618; x=1689295618;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gEKqLMaqgk2aWl53YYMJCctBgaVLRjyQHMrjbXLwb+o=;
  b=NfzoKBfmuDsW/xjXPoicqld/p8F1cI8txkFEfYU8s+pCwgm9X7aC/tNd
   0EhGTnm6cIFZmCLtKf7XQHdftjR6YvZCoayFD2fNPPNyKSYJvOJLIG7YG
   hWIK1jzP58gX2MwgWB9AkA78d+9WgOHkLBPDxYMoBc+tNJ/7uzAbs9tRh
   xotp4P1rQOTkL0kaa8/nidpTsa4I8egEdm/1uDimxnD1P0+f/Lg0gFnN2
   61MsGj7r2gD/rr6KRx16zA9Hm3AF0Q55JRR+njj5//NA+X/AdPqT62qKL
   Teb9U61Npcgp13lG6vkPMETS7zkW5PmEBxZI0A9uIdWQwZPh/ylOnjupi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="311027888"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="311027888"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 17:46:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="841961372"
Received: from ceeveret-mobl.amr.corp.intel.com (HELO [10.209.100.219]) ([10.209.100.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 17:46:57 -0700
Message-ID: <503e7135-782c-b72b-6f55-3c4acf55921b@linux.intel.com>
Date:   Wed, 13 Jul 2022 17:46:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        "Yao, Jiewen" <jiewen.yao@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
 <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
 <385B219C-4DB2-480C-913C-411AB4D644ED@intel.com>
 <MW4PR11MB5872E3B775A680678331D6358CB79@MW4PR11MB5872.namprd11.prod.outlook.com>
 <9c7d99469179340eeecabaf3e9c414fc98900626.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <9c7d99469179340eeecabaf3e9c414fc98900626.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai/Dave,

On 6/27/22 4:21 AM, Kai Huang wrote:
> On Sat, 2022-06-25 at 15:35 +1200, Yao, Jiewen wrote:
>> Thank you, Jun.
>>
>> Yes. I confirmed that we will include below change to GHCI.next spec.
>>
>> ================
>> 3.5 TDG.VP.VMCALL<SetupEventNotifyInterrupt>
>>
>> From: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an interrupt at the requested-interrupt vector into the TD via the posted-interrupt descriptor. "
>>
>> To: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an interrupt at the requested-interrupt vector into the TD VCPU that executed TDG.VP.VMCALL <SetupEventNotifyInterrupt> via the posted-interrupt descriptor. "
>>
> 
> Hi Sathy,
> 
> With this change, I don't think we should use system vector anymore.  Instead,
> we just need one non-migratable IRQ which has a fixed vector on a fixed cpu.
> 

Thanks. As suggested, I have attempted to allocate IRQ vector at runtime
using irq_domain_alloc_irqs() call. Vector is allocated from
"x86_vector_domain" as Kai suggested.

Since I am not well versed in this area, I would like expert comments on it.
Mainly for IRQ allocation logic in tdx_late_init(). I have tested this version using
QEMU and it works fine.


diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 928dcf7a20d9..dcc878546574 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -5,12 +5,16 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
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
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO                   1
@@ -19,6 +23,7 @@
 
 /* TDX hypercall Leaf IDs */
 #define TDVMCALL_MAP_GPA               0x10001
+#define TDVMCALL_SETUP_NOTIFY_INTR     0x10004
 
 /* MMIO direction */
 #define EPT_READ       0
@@ -34,6 +39,26 @@
 #define VE_GET_PORT_NUM(e)     ((e) >> 16)
 #define VE_IS_IO_STRING(e)     ((e) & BIT(4))
 
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
+       tdx_event_notify_handler = handler;
+}
+
+/* Helper function to unregister tdx_event_notify_handler */
+void tdx_remove_ev_notify_handler(void)
+{
+       tdx_event_notify_handler = NULL;
+}
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -98,6 +123,31 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
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
+       /* Minimum vector value allowed is 32 */
+       if (vector < 32)
+               return -EINVAL;
+
+       /*
+        * Register callback vector address with VMM. More details
+        * about the ABI can be found in TDX Guest-Host-Communication
+        * Interface (GHCI), sec titled
+        * "TDG.VP.VMCALL<SetupEventNotifyInterrupt>".
+        */
+       if (_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0))
+               return -EIO;
+
+       return 0;
+}
+
 static u64 get_cc_mask(void)
 {
        struct tdx_module_output out;
@@ -775,3 +825,52 @@ void __init tdx_early_init(void)
 
        pr_info("Guest detected\n");
 }
+
+static irqreturn_t tdx_ev_handler(int irq, void *dev_id)
+{
+       tdx_event_notify_handler();
+       return IRQ_HANDLED;
+}
+
+static int __init tdx_late_init(void)
+{
+        struct irq_alloc_info info;
+       struct irq_cfg *cfg;
+       int evirq, cpu;
+
+       if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+               return 0;
+
+       if (!x86_vector_domain) {
+               pr_err("x86 vector domain is NULL\n");
+               return 0;
+       }
+
+       init_irq_alloc_info(&info, NULL);
+
+       evirq = irq_domain_alloc_irqs(x86_vector_domain, 1, NUMA_NO_NODE, &info);
+
+       cpu = get_cpu();
+
+       irq_set_handler(evirq, handle_edge_irq);
+
+       /*
+        * Event notification vector will be delivered to the CPU
+        * in which TDVMCALL_SETUP_NOTIFY_INTR hypercall is requested.
+        * So set the IRQ affinity to the current CPU.
+        */
+       irq_set_affinity(evirq, cpumask_of(cpu));
+
+       if (request_irq(evirq, tdx_ev_handler, 0, "tdx_evirq", NULL))
+               pr_err("Request event IRQ failed\n");
+
+       cfg = irq_cfg(evirq);
+
+       if (tdx_hcall_set_notify_intr(cfg->vector))
+               pr_err("Setting event notification interrupt failed\n");
+
+       put_cpu();
+
+       return 0;
+}
+late_initcall(tdx_late_init);
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


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
