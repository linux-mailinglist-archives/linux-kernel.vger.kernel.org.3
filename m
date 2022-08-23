Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277B559EA81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiHWSFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiHWSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:04:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEE1E342D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661271133; x=1692807133;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AfGSdAd6EDB5gfzTGKPfnSDQO5AzCDlqiMD6qVO+jfU=;
  b=NociFIMzTAdmYPDaRnrQR2/nZT+Rzms5lPPgG/AwapnolgaEYKECrmYi
   lxWbZpMYcoV98cf4JL6t2YIqVtUOamRuQ1tym/qLf3LtAKg4B3x+7s3/y
   Q38yZJFnR1OG16HtRGjtT+Zw2zWZrUfMsx9RV5gBjvlMSwqqiWWhOe5QB
   oU6sG/si5KG24HjsHLoz0twZJV/ll6uN56iun/0xXCXWGOf55JCz3tzT8
   piTaHMfmSV6Y8jwjHggYRosUqKVjcM90XvR2+xm+uDe4g0W5FX9ZUAmBH
   Md/Ajktf7KnqYm3mKs5pI9nD0g67bpuqzscn6CxvyNuOrcoDAzKMXwoP0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="273484645"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="273484645"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 09:11:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="677679835"
Received: from tmnguye8-mobl1.amr.corp.intel.com (HELO [10.212.174.243]) ([10.212.174.243])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 09:11:54 -0700
Message-ID: <82c396c3-3f6d-759d-ba4b-38745b7f0884@intel.com>
Date:   Tue, 23 Aug 2022 09:11:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/4] x86/microcode: Place siblings in NMI loop while
 update in progress
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Tony Luck <tony.luck@intel.com>
References: <20220816043754.3258815-1-ashok.raj@intel.com>
 <20220816043754.3258815-6-ashok.raj@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220816043754.3258815-6-ashok.raj@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 21:37, Ashok Raj wrote:
> Microcode updates need a guarantee that the thread sibling that is waiting
> for the update to finish on the primary core will not execute any
> instructions until the update is complete. This is required to guarantee
> any MSR or instruction that's being patched will be executed before the
> update is complete.

I don't think this is a great way to describe the problem.  Even in this
patch, the thread sibling is doing something far from "not executing any
instructions".

	Microcode updates affect the state of the running CPU.  In the
	case of hyperthreads, the thread initiating the update is in a
	known state (WRMSR), but its hyperthreads can be running around
	executing arbitrary instructions.

	If one of these arbitrary instructions is being patched by the
	update, <insert symptoms here>.  The existing code uses
	stop_machine() to keep userspace from running and puts the
	kernel in a relatively safe wait loop.  But, that loop can be
	still be interrupted by NMIs.

	The NMI code and NMI handlers can also execute relatively
	arbitrary instructions.

	== Solution ==

	Park sibling CPU threads in a newly-registered NMI handler while
	the primary CPU thread does the microcode update.

	This ensures that...  It removes the possibility for...


> After the stop_machine() rendezvous, an NMI handler is registered. If an
> NMI were to happen while the microcode update is not complete, the
> secondary thread will spin until the ucode update state is cleared.

This is a case where switching it imperative voice would make it a lot
more clear.

Also, maybe I'm blind or misreading this, but the code _looks_ to do
this, in this order:

> +	ret = register_nmi_handler(NMI_LOCAL, ucode_nmi_cb, NMI_FLAG_FIRST,
> +				   "ucode_nmi");
...
>  	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);

It registers the NMI handler _before_ the stop_machine().

The description so far is (maybe) telling us what the code does.  But,
it doesn't say what the end result is.  *How* does this address the problem?

I _think_ all this ends up doing in the end is ensuring that arbitrary
NMI handlers don't run since it uses NMI_FLAG_FIRST.  I'm not completely
sure how it guarantees that it *is* first.

Also, for this to be bulletproof, what would have to be true?  I *think*
the entire NMI entry path and _this_ (new) handler has to be free of
instructions that could go bonkers during a microcode update.  How do we
know what those instructions *are*, btw?  Have you audited the NMI entry
path to make sure it is free of those instructions?  Is everything still
safe even with CONFIG_DEBUG_ENTRY in place where NMIs can be nested?

This is also the place in the changelog where you can discuss the
attributes of this solution.  It's all C code, for instance.  That is
both good (easy to code up and review) but, bad because the C compiler
might be doing fancy things that go amok during a ucode update.

For instance, you can discuss why this can safely ignore the primary
thread instead of calling it out as one of the "couple of choices".

> Couple of choices discussed are:
> 
> 1. Rendezvous inside the NMI handler, and also perform the update from
>    within the handler. This seemed too risky and might cause instability
>    with the races that we would need to solve. This would be a difficult
>    choice.
>    	1.a Since the primary thread of every core is performing a wrmsr
> 	for the update, once the wrmsr has started, it can't be
> 	interrupted. Hence its not required to NMI the primary thread of
> 	the core. Only the secondary thread needs to be parked in NMI
> 	before the update begins.
> 	Suggested by From Andy Cooper

What are the races that need to be solved?  What would make it unstable?

> 2. Thomas (tglx) suggested that we could look into masking all the LVT
>    originating NMI's. Such as LINT1, Perf control LVT entries and such.
>    Since we are in the rendezvous loop, we don't need to worry about any
>    NMI IPI's generated by the OS.
> 
>    The one we didn't have any control over is the ACPI mechanism of sending
>    notifications to kernel for Firmware First Processing (FFM). Apparently
>    it seems there is a PCH register that BIOS in SMI would write to
>    generate such an interrupt (ACPI GHES).
> 3. This is a simpler option. OS registers an NMI handler and doesn't do any
>    NMI rendezvous dance. But if an NMI were to happen, we check if any of
>    the CPUs thread siblings have an update in progress. Only those CPUs
>    would take an NMI. The thread performing the wrmsr() will only take an
>    NMI after the completion of the wrmsr 0x79 flow.
> 
>    [ Lutomirsky thinks this is weak, and what happens from taking the
>    interrupt and the path to the registered callback handler might be
>    exposed.]
> 
>    Seems like 1.a is the best candidate.
> 
> The algorithm is something like this:
> 
> After stop_machine() all threads are executing __reload_late()
> 
> nmi_callback()
> {
> 	if (!in_ucode_update)
> 		return NMI_DONE;

I'm not sure 'in_ucode_update' is even needed.  It seems redundant with
the sibling_mask, especially since this callback is not even registered
until after 'in_ucode_update=1'.

>  static atomic_t late_cpus_in;
>  static atomic_t late_cpus_out;
> +static atomic_t nmi_cpus;	// number of CPUs that enter NMI
> +static atomic_t nmi_timeouts;   // number of siblings that timeout
> +static atomic_t nmi_siblings;   // Nmber of siblings that enter NMI
> +static atomic_t in_ucode_update;// Are we in microcode update?
> +
> +static struct cpumask all_sibling_mask;

I haven't gone through this in detail.  But, this is a *LOT* of state
and my gut feeling is that there is some major simplification that can
be done here.  I don't doubt that this works, but I do doubt that this
is as simple and straightforward as we can make it.

I don't get, for instance, why you care about rendez->callin.  Why does
it matter if a CPU is in the NMI handler loop versus being in the
stop_machine() handler?  With nested NMIs, you need to handle being
anywhere in the NMI entry code, and you can end up in there from either
the stop_machine() hander *OR* the new NMI handler.

