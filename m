Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0434552174
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243889AbiFTPpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241246AbiFTPpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:45:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3561AD9A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655739900; x=1687275900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kwFyPrcXQzBzBHOmxRRGZvhaz2P5fQm59g0ZK8s9EH0=;
  b=STPYeZpS7inmAbImlzBJmBF0QdjAbTdNz/PmyADFQz7Jop57wkXASZnN
   r62XNh+e632rEp0Nt55Mik5kqN0VGzFiVSY0gLV0XjTsLHRK42eQING0/
   7Tv+FAUc/p0+8Vbtl1Z+L53WxCVqlV+s+5wOtPPXyCeZyMeM0w1kEz1Qe
   Xi8ICha/PgnYzUVq4sk1RBQtrJVg8j7n8jcBtbflvbQKUTLnH/6wSheHe
   uYvRp0DMbNQKdE5hmDfkJTKXWKdDS8lGt73I3MzTLTX7H60iwzEc6PkR0
   cb6qmUt00/a7zLnvWz4lNmdYCKGkHlTYXaQIlMIrOwADfW1p8ZRYSB8QK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="305362732"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="305362732"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:44:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="689517521"
Received: from jwtschan-mobl.amr.corp.intel.com (HELO [10.209.124.185]) ([10.209.124.185])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:44:59 -0700
Message-ID: <efb2cdab-289b-8757-fe5e-5348519b0474@linux.intel.com>
Date:   Mon, 20 Jun 2022 08:44:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v8 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Content-Language: en-US
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
        linux-kernel@vger.kernel.org,
        "Nakajima, Jun" <jun.nakajima@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <78873cc1db47ba00a4c01f38290521c1a6072820.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

+ Jun

On 6/20/22 5:33 AM, Kai Huang wrote:
> On Wed, 2022-06-08 at 19:52 -0700, Kuppuswamy Sathyanarayanan wrote:
>> Host-guest event notification via configured interrupt vector is useful
>> in cases where a guest makes an asynchronous request and needs a
>> callback from the host to indicate the completion or to let the host
>> notify the guest about events like device removal. One usage example is,
>> callback requirement of GetQuote asynchronous hypercall.
> 
> Although this paragraph is from GHCI spec, IMHO it is not very helpful.  In
> fact, I think this paragraph is not that right and should be removed from GHCI.
> The reason is such event notification from VMM in cases like "device removal" is
> too vague.  There's no _specification_ in GHCI around which "device removal"
> should VMM inject such event.  For instance, I _think_ the Qemu enumerated ACPI-
> based hotplug should continue to work in TD.

Yes. It just says that it *can* be used to signal a device removal. It is just
an example for where it can be used. But I agree that such a use case is vague.
If it makes it better, I am fine with removing it.

Copied from sec 3.5 TDG.VP.VMCALL<SetupEventNotifyInterrupt>:

"Example of an operation that can use the event notify is the host
VMM signaling a device removal to the TD, in response to which a TD may
unload a device driver."

> 
> That being said, if a TD has multiple devices, it cannot know whether the VMM
> will inject the removal event via the vector set by SetupEventNotifyInterrupt. 
> And for the same device in the same TD, different VMMs may use different way to
> notify its removal.

As per current design, If it is used for device removal, I think all registered
device drivers will get the notification and the individual device driver has
to check whether it is applicable for them.

If the SetupEventNotifyInterrupt TDVMCALL specification is extended to specify
the exact device or use case detail, then it can optimize the implementation.

> 
> It seems GetQuote is the only user of SetupEventNotifyInterrupt.  Maybe we
> should just declare it is for GetQuote.

Ok.

> 
> Isaku, what do you think?  Does this make sense?
> 
>>
>> In TDX guest, SetupEventNotifyInterrupt hypercall can be used by the
>> guest to specify which interrupt vector to use as an event-notify
>> vector to the VMM. Details about the SetupEventNotifyInterrupt
>> hypercall can be found in TDX Guest-Host Communication Interface
>> (GHCI) Specification, sec 3.5 "VP.VMCALL<SetupEventNotifyInterrupt>".
>> Add a tdx_hcall_set_notify_intr() helper function to implement the
>> SetupEventNotifyInterrupt hypercall.
> 
> As you also used "can" above, the GHCI only says the VMM _CAN_ inject the vector
> set by SetupEventNotifyInterrupt, but not must (3.3 TDG.VP.VMCALL<GetQuote>). 
> This means theoretically TD should implement pooling mode in case VMM doesn't
> support injecting event via vector done by SetupEventNotifyInterrupt?

Yes. But GetQuote specification does not talk about the pooling mode
use case as well. So I think it is just a wording confusion.

> 
> Perhaps we should update the GHCI spec to use must..

Ok.

> 
>>
>> Reserve 0xec IRQ vector address for TDX guest to receive the event
>> completion notification from VMM. Also add related IDT handler to
>> process the notification event.
> 
> Here lacks why we need to choose to reserve a system vector.  For instance, why
> we cannot choose to use device IRQ way which only requires one vector on one

As you have explained below, as per current spec, it just expects a system
vector.

> cpu.  As you can see reserving a system vector isn't ideal especially for
> attestation as it is not a frequent operation.  It is wasteful of using IRQ

I agree that event notification is currently only used for attestation. But I
think in future there could be other use cases for it. If the intention is just
to use it for attestation, then we can just modify the GetQuote TDVMCALL to pass
the vector address, and there is no need for new TDVMCALL. I think the intention
here is to have generic method for VMM to notify TD about some events. I am not
clear about the possible future use cases, so I cannot comment on frequency of
its use.

Jun, any comments?



> resource especially on server systems with a lot of CPUs.

FWIW, this reservation is protected with CONFIG_INTEL_TDX_GUEST. So it will be
reserved only for TDX use case.


> 
> The reason is SetupEventNotifyInterrupt TDVMCALL only has one argument, which is
> vector, but cannot specify which CPU that the VMM should inject the event to. 
> The GHCI spec doesn't say which CPU the VMM should inject to (i.e. must inject
> to the CPU on which SetupEventNotifyInterrupt is called), so we can only assume
> VMM can inject to any CPU.
> 
> Btw, x86 maintainers,
> 
> I'd like to check with you to see whether we should improve the existing
> SetupEventNotifyInterrupt so we can choose to use request_irq() style for
> attestation.  Using request_irq() means we don't need to reserve a system
> vector, but can allocate a vector dynamically when needed.
> 
> Assuming we update SetupEventNotifyInterrupt to also allow TD to specify which
> CPU (i.e. via APICID) to inject (along with the vector), my understanding is we
> can use below way (idea only) to dynamically allocate a vector on one CPU when
> attestation is needed:
> 
> 
> 	int cpu, vector;
> 	int irq;
> 
> 	// request an IRQ, and prevent it from being migrated
> 	irq = __irq_domain_alloc_irqs(x86_vector_domain, 0, 1, ...);
> 	request_irq(irq, ...);
> 	
> 	// get vector, cpu from irq
> 
> 	TDVMCALL<SetupEventNotifyInterrupt>(vector, 
> 		apic->cpu_present_to_apidid(cpu));
> 	
> Is this reasonable? If yes, is it worth to do?
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
