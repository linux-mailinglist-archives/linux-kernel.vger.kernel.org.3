Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13694ECFED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351774AbiC3XRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiC3XRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:17:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0CE3ED39
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648682155; x=1680218155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m/7CjYuMWY08xwAmPMhVQWQ1Y3PeYnxyC+1owlFjJgs=;
  b=XO3gxT/n/UcvgeYDSPee5kZ+SKtG4OPpjNyDQR6n3jhNJz8TWRs1JHB5
   qrCvfxp5BlYOjAKbAoAc1V/L6N5vFQ7xybM3TCFi19UU2FfLTtmft/gko
   efDPjj4aTeaKaJDRLOwqkDd4evLet7i2AWTSy0JJ+T73bmpAr1TOZi4mM
   rBAj3sARS7ReLUS6whE3tJUs4Rw1BTUDGf5sEJyZvm85z/EVNfyGbFTgd
   uwqHwCszktxTjECH8LjYAiAlIw2H/yQYAs5sVjoEDzn45f0/e9KNpiFLv
   Y5ylWwpBuJFoIChkmA8POisYqQQV2Gsuy73alGmb/w6Ybk5CgsdORAhg7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259641425"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259641425"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="586183314"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2022 16:15:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E893D144; Thu, 31 Mar 2022 02:16:09 +0300 (EEST)
Date:   Thu, 31 Mar 2022 02:16:09 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
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
Subject: Re: [PATCHv7 21/30] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
Message-ID: <20220330231609.ymxekzgdp2pd7gfy@black.fi.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-22-kirill.shutemov@linux.intel.com>
 <2847763c-6202-9e2a-54c5-44c761b59a63@intel.com>
 <20220324152415.grt6xvhblmd4uccu@black.fi.intel.com>
 <4c0c05a8-08f2-7d5d-6746-a92d0d3c5ef0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c0c05a8-08f2-7d5d-6746-a92d0d3c5ef0@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:17:35PM -0700, Dave Hansen wrote:
> On 3/24/22 08:24, Kirill A. Shutemov wrote:
> > On Fri, Mar 18, 2022 at 11:23:59AM -0700, Dave Hansen wrote:
> >> On 3/18/22 08:30, Kirill A. Shutemov wrote:
> >>> +	/*
> >>> +	 * After writing the wakeup command, wait for maximum timeout of 0xFF
> >>> +	 * for firmware to reset the command address back zero to indicate
> >>> +	 * the successful reception of command.
> >>> +	 * NOTE: 0xFF as timeout value is decided based on our experiments.
> >>> +	 *
> >>> +	 * XXX: Change the timeout once ACPI specification comes up with
> >>> +	 *      standard maximum timeout value.
> >>> +	 */
> >>> +	timeout = 0xFF;
> >>> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
> >>> +		cpu_relax();
> >>
> >> I don't feel like this was ever actually resolved.  This timeout
> >> basically boiled down to "this value seems to work for us".  There are
> >> also *SURELY* timeouts that are going to happen here.
> > 
> > It makes me think if it can be an attack vector: once kernel initiated
> > wake up of a secondary vCPU it has no control on how long it takes.
> 
> I don't think that's a meaningful attack vector for TDX.  Hosts always
> have a choice to not run the guest.  Sure, they can hang the boot CPU
> forever if they don't run the secondary CPU.  But, they can also do that
> by just not ever running the boot CPU in the first place.
> 
> > I worry that malicious VMM can induce timeout intentionally, but then wake
> > up the secondary CPU when kernel doesn't expect it. After quick look I was
> > not able to convince myself that kernel can deal with this without a
> > problem.
> > 
> > Is it legitimate concern?
> 
> The only thing I'd be worried about would be a secondary CPU going off
> and doing things that it's not supposed to because *it* thinks it is in
> boot code and the other CPUs are off doing normal runtime things.
> 
> I don't know the boot code well enough to guess where it would hang or
> what damage it could do.  I suspect it would get hung up on something
> like 'cpu_callout_mask'.
> 
> Is there anything in the trampoline code or start_secondary() that would
> cause damage if it got run later than the kernel expects?

I didn't find anything specific.

But I tried to simulate similar scenario by returning -EIO just after
writing wake up command in acpi_wakeup_cpu(). System booted, but there is
a warning in the dmesg:

WARNING: CPU: 0 PID: 1 at kernel/irq/chip.c:210 irq_startup+0x2a3/0x2b0

System seems recovered fine, but I'm not sure what will happen if
wake up is delayed by VMM.

> > Patch below drops timeout handling completely. Any opinions?
> > 
> > Other option would be to check in the trampoline code that initiated wake
> > up is legitimate. But it should only be untrue if VMM acting weird (or
> > virtual BIOS is buggy). I don't think it's right side to deal with the
> > problem.
> 
> Yeah, that would just be a band-aid.  If we are worried about the
> secondary CPU doing some damage at a random time, the host can just wait
> until *after* the wakeup check.

VMM cannot wake up secondary CPU on its own. Guest has to initiate it by
writing into the mailbox. Reader of the mailbox command is also within
trust boundary -- it loops inside virtual BIOS code. But VMM can
*postpone* reacting to the command by not scheduling the secondary.

> >>>         /*
> >>>          * If the CPU wakeup process is successful, store the
> >>>          * status in apic_id_wakemap to prevent re-wakeup
> >>>          * requests.
> >>>          */
> >>>         physid_set(apicid, apic_id_wakemap);
> >>>
> >>>         return 0;
> >>> }
> >>
> >> If this goes wrong, won't the new wakeup just timeout?  Do we really
> >> need a dedicated mechanism to stop re-wakeups?  How much of a problem is
> >> this going to be?
> > 
> > Well, it can provide a proper diagnostics and a distinct error code. If
> > you think it is unneeded we can drop it.
> 
> It looks like debugging that you add when you're bringing something up.
>  I'm not sure of its utility going forward.  I'd just zap it for now and
> bring it back later if it's really needed.

Sathya pointed out that this protection was added based on request[1] by
Rafael.

TDX should be safe from re-wakeups as we forbid offlining CPUs, but the
wake up method suppose to be generic, not limited to TDX.

[1] https://lore.kernel.org/all/CAJZ5v0jonk2Pb2HUHMoe69vnCV4+EV9XZpo2LwKrnYPF3CxD_A@mail.gmail.com/

-- 
 Kirill A. Shutemov
