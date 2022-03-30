Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3744ED04D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351852AbiC3Xp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbiC3Xp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:45:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F905167C0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648683850; x=1680219850;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=3lqC2A8Q2GM/5G4MmdDtAAAEsrPpKTG9OIXicflGVWo=;
  b=GtYf2UOEdmlgfiYq2K6luiohHVt/yTsWDlTdAphiqdUAvKXuSWBkkRY0
   UJw/tKTrqirj5P0kQoSDjdu+I6i/fJdo7rxrUVICHTXyKKFCi8NHkLCTs
   MQuLbuvKloXvRR1h5kLtsSbUTPXHntuPa6ZuBuuMRp76ixZIxsTNlBWYj
   WRolRBLg/TqMgS/QrFn6869tcDXdDpyM7PXV3Fk+z7h4wKuLQDJXRfHmH
   1sinaIlo8dUNPJdXDt5NrJGhcUf2of08EhVmq2SH9VCsiol+EhvoFb+p6
   ed9ZYLYU3Fd/f27TwZmwr9/Eg6iUxsFuTjFZHMFuDWLwggQ58FlNYnP9I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247172339"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="247172339"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:44:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="654202760"
Received: from rbaile3x-mobl.amr.corp.intel.com (HELO [10.209.48.111]) ([10.209.48.111])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:44:09 -0700
Message-ID: <9e84cdea-754c-1864-4c54-66beeba7f921@intel.com>
Date:   Wed, 30 Mar 2022 16:44:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-22-kirill.shutemov@linux.intel.com>
 <2847763c-6202-9e2a-54c5-44c761b59a63@intel.com>
 <20220324152415.grt6xvhblmd4uccu@black.fi.intel.com>
 <4c0c05a8-08f2-7d5d-6746-a92d0d3c5ef0@intel.com>
 <20220330231609.ymxekzgdp2pd7gfy@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv7 21/30] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
In-Reply-To: <20220330231609.ymxekzgdp2pd7gfy@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 16:16, Kirill A. Shutemov wrote:
> On Mon, Mar 28, 2022 at 12:17:35PM -0700, Dave Hansen wrote:
>> Is there anything in the trampoline code or start_secondary() that would
>> cause damage if it got run later than the kernel expects?
> 
> I didn't find anything specific.
> 
> But I tried to simulate similar scenario by returning -EIO just after
> writing wake up command in acpi_wakeup_cpu(). System booted, but there is
> a warning in the dmesg:
> 
> WARNING: CPU: 0 PID: 1 at kernel/irq/chip.c:210 irq_startup+0x2a3/0x2b0
> 
> System seems recovered fine, but I'm not sure what will happen if
> wake up is delayed by VMM.

That shouldn't be too hard to simulate.  Just add a spin loop at the
beginning of start_secondary() that can spin for grotesque amounts of
time and have it get more grotesque with each CPU that boots.

If you're still booting CPUs when userspace comes up, you've done as
much damage as possible.

But, I do think there are two relatively discrete problems here:
1. How long do we wait for a secondary CPU to actually ack the MADT
   wakeup?  (the answer might be "don't wait").
2. How do we verify that a woken-up CPU actually booted all the way?

Even if #1 is a loooooong time, it might get stalled before it fully boots.

So, for this patch, let's just remove the timeout.  If the boot CPU
hangs (spins forever) because the VMM is being naughty, I'm OK with it.
 It's hard to do too much damage when you're spinning.

#2 seems like a separate issue to tackle.  Maybe it's as simple as
waiting for the secondary CPU to mark itself as online.

The only question is whether #2 is a big enough deal that it has to be
tackled before starting to merge the TDX guest support.

>>> Patch below drops timeout handling completely. Any opinions?
>>>
>>> Other option would be to check in the trampoline code that initiated wake
>>> up is legitimate. But it should only be untrue if VMM acting weird (or
>>> virtual BIOS is buggy). I don't think it's right side to deal with the
>>> problem.
>>
>> Yeah, that would just be a band-aid.  If we are worried about the
>> secondary CPU doing some damage at a random time, the host can just wait
>> until *after* the wakeup check.
> 
> VMM cannot wake up secondary CPU on its own. Guest has to initiate it by
> writing into the mailbox. Reader of the mailbox command is also within
> trust boundary -- it loops inside virtual BIOS code. But VMM can
> *postpone* reacting to the command by not scheduling the secondary.

Right.  I was just pointing out that if we add a check early in the boot
code, the VMM can postpone its naughtiness until after the check.

>>>>>         /*
>>>>>          * If the CPU wakeup process is successful, store the
>>>>>          * status in apic_id_wakemap to prevent re-wakeup
>>>>>          * requests.
>>>>>          */
>>>>>         physid_set(apicid, apic_id_wakemap);
>>>>>
>>>>>         return 0;
>>>>> }
>>>>
>>>> If this goes wrong, won't the new wakeup just timeout?  Do we really
>>>> need a dedicated mechanism to stop re-wakeups?  How much of a problem is
>>>> this going to be?
>>>
>>> Well, it can provide a proper diagnostics and a distinct error code. If
>>> you think it is unneeded we can drop it.
>>
>> It looks like debugging that you add when you're bringing something up.
>>  I'm not sure of its utility going forward.  I'd just zap it for now and
>> bring it back later if it's really needed.
> 
> Sathya pointed out that this protection was added based on request[1] by
> Rafael.
> 
> TDX should be safe from re-wakeups as we forbid offlining CPUs, but the
> wake up method suppose to be generic, not limited to TDX.
> 
> [1] https://lore.kernel.org/all/CAJZ5v0jonk2Pb2HUHMoe69vnCV4+EV9XZpo2LwKrnYPF3CxD_A@mail.gmail.com/

Fair enough.  Please just add that reasoning somewhere.
