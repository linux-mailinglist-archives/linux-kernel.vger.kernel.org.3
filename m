Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A125756A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiGNU4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbiGNU4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:56:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D948C6BC28
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657832160; x=1689368160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bylWxNy7ZO2FuTcacAyR09nPLvx2YYji/zgIN7VtvyY=;
  b=LaUlWrFfanLcN9EELPGNPbHvwmCnOQhwxOwotPV6InwmqY/rv3i+WOcd
   Po6Ygybkj3p3RxBepNzaGvTa6MQkqsyprGj2vmqd+GyFOloKv9IbN8n82
   WhYxEiWXQXXdMqx2MIFyM5m/9Ynteojza9QM1Qx2oTbkQ5gOr2q6Nak7k
   zDnui0rII3yyDkChhG+w3kFCKbp5PT4s12tszMBl8sSrLYhJ5ZxfY5zGi
   qHfW5RE2ZSx6PwjjRtJH0wuOrAcvAUoPOKJp3wbWqI8Tl7QV8SAqL2h/Y
   eE81taq5eDZ2PiafHiQYEcqvkMEdpBUJELSkTYsyUdFa8INJLsPNthZBa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268653968"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="268653968"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:55:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="593503478"
Received: from jlphipps-mobl.amr.corp.intel.com (HELO [10.209.4.88]) ([10.209.4.88])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:55:54 -0700
Message-ID: <4421372e-14b5-1c6d-e4bf-5a88a2c88ab8@linux.intel.com>
Date:   Thu, 14 Jul 2022 13:55:53 -0700
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
 <503e7135-782c-b72b-6f55-3c4acf55921b@linux.intel.com>
 <434ff0edcd5a0f1eb671bb2850ef5444ac1359a3.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <434ff0edcd5a0f1eb671bb2850ef5444ac1359a3.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/22 3:42 AM, Kai Huang wrote:
> On Wed, 2022-07-13 at 17:46 -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi Kai/Dave,
>>
>> On 6/27/22 4:21 AM, Kai Huang wrote:
>>> On Sat, 2022-06-25 at 15:35 +1200, Yao, Jiewen wrote:
>>>> Thank you, Jun.
>>>>
>>>> Yes. I confirmed that we will include below change to GHCI.next spec.
>>>>
>>>> ================
>>>> 3.5 TDG.VP.VMCALL<SetupEventNotifyInterrupt>
>>>>
>>>> From: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an interrupt at the requested-interrupt vector into the TD via the posted-interrupt descriptor. "
>>>>
>>>> To: "The host VMM should use SEAMCALL [TDWRVPS] leaf to inject an interrupt at the requested-interrupt vector into the TD VCPU that executed TDG.VP.VMCALL <SetupEventNotifyInterrupt> via the posted-interrupt descriptor. "
>>>>
>>>
>>> Hi Sathy,
>>>
>>> With this change, I don't think we should use system vector anymore.  Instead,
>>> we just need one non-migratable IRQ which has a fixed vector on a fixed cpu.
>>>
>>
>> Thanks. As suggested, I have attempted to allocate IRQ vector at runtime
>> using irq_domain_alloc_irqs() call. Vector is allocated from
>> "x86_vector_domain" as Kai suggested.
> 
> I am not expert either. I said "idea only" in my first reply :)
> 
>>
>> Since I am not well versed in this area, I would like expert comments on it.
>> Mainly for IRQ allocation logic in tdx_late_init(). I have tested this version using
>> QEMU and it works fine.
>>
>>
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 928dcf7a20d9..dcc878546574 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -5,12 +5,16 @@
>>  #define pr_fmt(fmt)     "tdx: " fmt
>>  
>>  #include <linux/cpufeature.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/numa.h>
>>  #include <asm/coco.h>
>>  #include <asm/tdx.h>
>>  #include <asm/vmx.h>
>>  #include <asm/insn.h>
>>  #include <asm/insn-eval.h>
>>  #include <asm/pgtable.h>
>> +#include <asm/irqdomain.h>
>>  
>>  /* TDX module Call Leaf IDs */
>>  #define TDX_GET_INFO                   1
>> @@ -19,6 +23,7 @@
>>  
>>  /* TDX hypercall Leaf IDs */
>>  #define TDVMCALL_MAP_GPA               0x10001
>> +#define TDVMCALL_SETUP_NOTIFY_INTR     0x10004
>>  
>>  /* MMIO direction */
>>  #define EPT_READ       0
>> @@ -34,6 +39,26 @@
>>  #define VE_GET_PORT_NUM(e)     ((e) >> 16)
>>  #define VE_IS_IO_STRING(e)     ((e) & BIT(4))
>>  
>> +/*
>> + * Handler used to report notifications about
>> + * TDX_GUEST_EVENT_NOTIFY_VECTOR IRQ. Currently it will be
>> + * used only by the attestation driver. So, race condition
>> + * with read/write operation is not considered.
>> + */
>> +static void (*tdx_event_notify_handler)(void);
>> +
>> +/* Helper function to register tdx_event_notify_handler */
>> +void tdx_setup_ev_notify_handler(void (*handler)(void))
>> +{
>> +       tdx_event_notify_handler = handler;
>> +}
>> +
>> +/* Helper function to unregister tdx_event_notify_handler */
>> +void tdx_remove_ev_notify_handler(void)
>> +{
>> +       tdx_event_notify_handler = NULL;
>> +}
>> +
> 
> Looks it's weird that you still need it.  Couldn't we pass the function to
> handle GetQuote directly to request_irq()?


Since event notification is not only specific to attestation, I did not want to
directly tie it to GetQuote handler.

Alternative approach is, to make this IRQ vector shared and let its users do
request_irq() and free_irq() directly.

Something like below?

--- a/arch/x86/coco/tdx/attest.c
+++ b/arch/x86/coco/tdx/attest.c
@@ -399,7 +399,7 @@ static const struct file_operations tdx_attest_fops = {
 
 static int __init tdx_attestation_init(void)
 {
-       int ret;
+       int ret, irq;
 
        /* Make sure we are in a valid TDX platform */
        if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
@@ -422,6 +422,14 @@ static int __init tdx_attestation_init(void)
                return ret;
        }
 
+       irq = tdx_get_evirq();
+
+       if (irq < 0)
+               return -EIO;
+
+       if (request_irq(irq, quote_callback_handler, IRQF_NOBALANCING|IRQF_SHARED,
+                               "tdx_quote", &miscdev))
+               pr_err("Register GetQuote IRQ handler failed\n");
        return 0;
 }
 device_initcall(tdx_attestation_init)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 2d09a7a4005e..e2e043fe488d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -41,6 +41,13 @@
 #define VE_GET_PORT_NUM(e)     ((e) >> 16)
 #define VE_IS_IO_STRING(e)     ((e) & BIT(4))
 
+static int tdx_evirq = -1;
+
+int tdx_get_evirq(void)
+{
+       return tdx_evirq;
+}
+
 /*
  * Handler used to report notifications about
  * TDX_GUEST_EVENT_NOTIFY_VECTOR IRQ. Currently it will be
@@ -866,16 +873,16 @@ static int __init tdx_late_init(void)
         */
        info.mask = cpumask_of(cpu);
 
-       evirq = irq_domain_alloc_irqs(x86_vector_domain, 1, NUMA_NO_NODE, &info);
+       tdx_evirq = irq_domain_alloc_irqs(x86_vector_domain, 1, NUMA_NO_NODE, &info);
 
-       irq_set_handler(evirq, handle_edge_irq);
+       irq_set_handler(tdx_evirq, handle_edge_irq);
 
-       cfg = irq_cfg(evirq);
+       cfg = irq_cfg(tdx_evirq);
 
        if (tdx_hcall_set_notify_intr(cfg->vector))
                pr_err("Setting event notification interrupt failed\n");

-       if (request_irq(evirq, tdx_ev_handler, IRQF_NOBALANCING, "tdx_evirq", NULL))
-               pr_err("Request event IRQ failed\n");

 
        put_cpu();
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index eb4db837cc44..79b5220f5f5d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -71,12 +71,15 @@ void tdx_setup_ev_notify_handler(void (*handler)(void));
 
 void tdx_remove_ev_notify_handler(void);
 
+int tdx_get_evirq(void);
+
 #else
 
 static inline void tdx_early_init(void) { };
 static inline void tdx_safe_halt(void) { };
 
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
+static inline int tdx_get_evirq(void) { return -1; };
 
 #endif /* CONFIG_INTEL_TDX_GUEST */



> 
>>  /*
>>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>>   * return code.
>> @@ -98,6 +123,31 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>>                 panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>>  }
>>  
>> +/*
>> + * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
>> + *
>> + * @vector: Vector address to be used for notification.
>> + *
>> + * return 0 on success or failure error number.
>> + */
>> +static long tdx_hcall_set_notify_intr(u8 vector)
>> +{
>> +       /* Minimum vector value allowed is 32 */
>> +       if (vector < 32)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Register callback vector address with VMM. More details
>> +        * about the ABI can be found in TDX Guest-Host-Communication
>> +        * Interface (GHCI), sec titled
>> +        * "TDG.VP.VMCALL<SetupEventNotifyInterrupt>".
>> +        */
>> +       if (_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0))
>> +               return -EIO;
>> +
>> +       return 0;
>> +}
>> +
>>  static u64 get_cc_mask(void)
>>  {
>>         struct tdx_module_output out;
>> @@ -775,3 +825,52 @@ void __init tdx_early_init(void)
>>  
>>         pr_info("Guest detected\n");
>>  }
>> +
>> +static irqreturn_t tdx_ev_handler(int irq, void *dev_id)
>> +{
>> +       tdx_event_notify_handler();
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static int __init tdx_late_init(void)
>> +{
>> +        struct irq_alloc_info info;
>> +       struct irq_cfg *cfg;
>> +       int evirq, cpu;
>> +
>> +       if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +               return 0;
>> +
>> +       if (!x86_vector_domain) {
>> +               pr_err("x86 vector domain is NULL\n");
>> +               return 0;
>> +       }
>> +
>> +       init_irq_alloc_info(&info, NULL);
>> +
>> +       evirq = irq_domain_alloc_irqs(x86_vector_domain, 1, NUMA_NO_NODE, &info);
> 
> If I read correctly, if you set info->mask to cpumask_of(cpu), and pass it to
> irq_domain_alloc_irqs(), the x86_vector_domain.alloc will immediately allocate a
> vector on the given cpu, so you don't need to call irq_set_affinity() and wait
> to allocate the vector on _this_ cpu until request_irq().

Agreed. I moved it to info.mask.

> 
>> +
>> +       cpu = get_cpu();
>> +
>> +       irq_set_handler(evirq, handle_edge_irq);
>> +
>> +       /*
>> +        * Event notification vector will be delivered to the CPU
>> +        * in which TDVMCALL_SETUP_NOTIFY_INTR hypercall is requested.
>> +        * So set the IRQ affinity to the current CPU.
>> +        */
>> +       irq_set_affinity(evirq, cpumask_of(cpu));
>> +
>> +       if (request_irq(evirq, tdx_ev_handler, 0, "tdx_evirq", NULL))
>> +               pr_err("Request event IRQ failed\n");
>> +
>> +       cfg = irq_cfg(evirq);
>> +
>> +       if (tdx_hcall_set_notify_intr(cfg->vector))
>> +               pr_err("Setting event notification interrupt failed\n");
>> +
>> +       put_cpu();
> 
> So the IRQ's affinity isn't kernel managed.  Also looks it doesn't have anything
> like IRQF_NOBALANCING to prevent it from being migrated.  If I understand
> correctly, userspace can still change the affinity which could cause the vector
> being reallocated on another cpu?
> 
> Perhaps you can pass IRQF_NO_BALANCING to request_irq()?

Makes sense. Tried it and it works. I will include this change.

> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
