Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4645587372
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiHAVjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiHAVjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:39:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D748332BAA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659389986; x=1690925986;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=2TRrQmR/AJHa5JY3LfOcodzanBoUk0lyvL46o2TT+0c=;
  b=bZ6HpONixbJMIUVDJ9bEeMIz1iDh/BqfwN3mxqReA19TQqJGUqpgovb/
   1GNXPVojxzPXyJCo/z36q9kyH3OOE5y2oONEq8M6kxUyfKglDczs0V6tG
   d9krw5jRlifMfjOXz/45/08jA7u0P370h1RjPSRTXx0S1CYeorHm3my4s
   dzONETZRcdQOJhjYbz37cPpq04wqKj3qUYbWdGKRYm3HtfretuvjufiXS
   JHnX60zWsMkHdUAarsQMSTxwMxx46Swfy2QNjxquoFJ4qYLn9dXQDMC4c
   94CSkINhPI5pzZCuHuSYp6B6bJpBU2VdO027/pKceYkPeJ9uxEGGbCfqd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="289270566"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="289270566"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 14:39:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="661333788"
Received: from jrluquin-mobl.amr.corp.intel.com (HELO [10.212.184.211]) ([10.212.184.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 14:39:45 -0700
Message-ID: <62bd9c59-59c9-0352-b1c5-7336cdf2552d@linux.intel.com>
Date:   Mon, 1 Aug 2022 14:39:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 3/6] x86/tdx: Add TDX Guest event notify interrupt
 support
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <19db3f9edf0af05424fd16d0c7a1ea23766e8330.camel@intel.com>
Content-Language: en-US
In-Reply-To: <19db3f9edf0af05424fd16d0c7a1ea23766e8330.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/22 3:18 AM, Kai Huang wrote:
> On Wed, 2022-07-27 at 20:44 -0700, Kuppuswamy Sathyanarayanan wrote:
>> Host-guest event notification via configured interrupt vector is useful
>> in cases where a guest makes an asynchronous request and needs a
>> callback from the host to indicate the completion or to let the host
>> notify the guest about events like device removal. One usage example is,
>> callback requirement of GetQuote asynchronous hypercall.
>>
>> In TDX guest, SetupEventNotifyInterrupt hypercall can be used by the
>> guest to specify which interrupt vector to use as an event-notify
>> vector to the VMM. Details about the SetupEventNotifyInterrupt
>> hypercall can be found in TDX Guest-Host Communication Interface
>> (GHCI) Specification, sec 3.5 "VP.VMCALL<SetupEventNotifyInterrupt>".
>> Add a tdx_hcall_set_notify_intr() helper function to implement the
>> SetupEventNotifyInterrupt hypercall.
>>
>> As per design VMM will post the event completion IRQ using the same CPU
>> in which SetupEventNotifyInterrupt hypercall request is received. So
>> allocate an IRQ vector from "x86_vector_domain", and set the CPU
>> affinity of the IRQ vector to the current CPU.
> 
> Set the affinity to the CPU isn't good enough.  Please call out we need a non-
> migratable IRQ here, i.e. userspace is not allowed to change the affinity which
> can cause the vector being reallocated from another cpu.

Agree. I will include the relevant details.

> 
>>
>> Please note that this patch only reserves the IRQ number. It is
>> expected that the user of event notify IRQ (like GetQuote handler) will
>> directly register the handler for "tdx_notify_irq" IRQ by using
>> request_irq() with  IRQF_SHARED flag set. Using IRQF_SHARED will enable
>> multiple users to use the same IRQ for event notification.


>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Acked-by: Wander Lairson Costa <wander@redhat.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>  arch/x86/coco/tdx/tdx.c    | 84 ++++++++++++++++++++++++++++++++++++++
>>  arch/x86/include/asm/tdx.h |  2 +
>>  2 files changed, 86 insertions(+)
>>
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 205f98f42da8..3563b208979c 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -8,12 +8,16 @@
>>  #include <linux/miscdevice.h>
>>  #include <linux/mm.h>
>>  #include <linux/io.h>
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
>>  #include "tdx.h"
>>  
>> @@ -24,6 +28,7 @@
>>  
>>  /* TDX hypercall Leaf IDs */
>>  #define TDVMCALL_MAP_GPA		0x10001
>> +#define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
>>  
>>  /* MMIO direction */
>>  #define EPT_READ	0
>> @@ -42,6 +47,7 @@
>>  #define DRIVER_NAME	"tdx-guest"
>>  
>>  static struct miscdevice tdx_misc_dev;
>> +int tdx_notify_irq = -1;
>>  
>>  /*
>>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>> @@ -107,6 +113,31 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>>  		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
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
>> +	/* Minimum vector value allowed is 32 */
>> +	if (vector < 32)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Register callback vector address with VMM. More details
>> +	 * about the ABI can be found in TDX Guest-Host-Communication
>> +	 * Interface (GHCI), sec titled
>> +	 * "TDG.VP.VMCALL<SetupEventNotifyInterrupt>".
>> +	 */
>> +	if (_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0))
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
>> +
> 
> I don't think this function is super useful.  I guess it's just better to openly
> call the _tdx_hypercall() directly in below.  With some comments, this way makes
> the code more clear that we don't want any scheduling during the IRQ/vector
> allocation and the hypervisor to guarantee the vector is always allocated on the
> CPU where the hypercall is called.
> 
> Also, checking vector < 32 isn't needed, as the hypercall is guaranteed to
> return error in such case as suggested by GHCI (otherwise it is VMM bug).
> 
> The irq_domain_alloc_irqs() call also guarantees the allocated vector will never
> < 32.  If really needed, you can just add a WARN_ON(vector < 32) right before
> calling the hypercall.

Agree. I will move this to tdx_arch_init().

> 
>>  static u64 get_cc_mask(void)
>>  {
>>  	struct tdx_module_output out;
>> @@ -830,3 +861,56 @@ static int __init tdx_guest_init(void)
>>  	return 0;
>>  }
>>  device_initcall(tdx_guest_init)
>> +
>> +/* Reserve an IRQ from x86_vector_domain for TD event notification */
>> +static int __init tdx_arch_init(void)
>> +{
>> +	struct irq_alloc_info info;
>> +	struct irq_cfg *cfg;
>> +	int cpu;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return 0;
>> +
>> +	/* Make sure x86 vector domain is initialized */
>> +	if (!x86_vector_domain) {
>> +		pr_err("x86 vector domain is NULL\n");
>> +		return 0;
>> +	}
> 
> I don't think  this check is needed.  x86_vector_domain is guaranteed to be non-
> NULL in arch_early_irq_init():
> 
>         x86_vector_domain = irq_domain_create_tree(...);
> 
>         BUG_ON(x86_vector_domain == NULL);

Makes sense. I can remove the above check.

> 
>> +
>> +	init_irq_alloc_info(&info, NULL);
>> +
>> +	/*
>> +	 * Event notification vector will be delivered to the CPU
>> +	 * in which TDVMCALL_SETUP_NOTIFY_INTR hypercall is requested.
>> +	 * So set the IRQ affinity to the current CPU.
>> +	 */
>> +	cpu = get_cpu();
>> +
>> +	info.mask = cpumask_of(cpu);
>> +
>> +	tdx_notify_irq = irq_domain_alloc_irqs(x86_vector_domain, 1,
>> +				NUMA_NO_NODE, &info);
>> +
>> +	if (tdx_notify_irq < 0) {
>> +		pr_err("Event notification IRQ allocation failed %d\n",
>> +				tdx_notify_irq);
>> +		goto init_failed;
>> +	}
>> +
>> +	irq_set_handler(tdx_notify_irq, handle_edge_irq);
>> +
>> +	cfg = irq_cfg(tdx_notify_irq);
>> +	if (!cfg) {
>> +		pr_err("Event notification IRQ config not found\n");
>> +		goto init_failed;
>> +	}
>> +
>> +	if (tdx_hcall_set_notify_intr(cfg->vector))
>> +		pr_err("Setting event notification interrupt failed\n");
> 
> So the request_irq() with IRQF_NOBALANCING isn't in this patch but in later
> patch.  Nor the IRQ is made affinity kernel-managed in this patch.  This means
> for this patch alone, the IRQ is migratable (i.e. usespace can change its
> affinity).  In another words, this patch depends on later patch to work.  I
> don't think this is right/good.
> 
> Perhaps we can explicitly call irq_modify_status() to set IRQF_NOBALANCING here?
> 
> 	irq_modify_status(tdx_notify_irq, 0, IRQ_NO_BALANCING);


I just tested it. It seems to work fine. With the above change, I see 
IRQD_NO_BALANCING dstate flag (in /sys/kernel/debug/irq/irqs/xx). I will
include this change.


> 
> But again, I am not expert here.  It would be helpful if some expert can help to
> check whether this is good way to handle.
> 
> 



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
