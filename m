Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1ED4C35F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiBXTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiBXTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:37:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E613D107A95
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645731414; x=1677267414;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=zXoTW/dJmE8wojx7Hr/0TpruOTakiX6eGzL2WENLgKE=;
  b=IdSBefoimv5u02vE8zibqZMzSc3rwcYttCts2X1p1bYlo+tJiwGNil9V
   RgdQe22jJ5xL8rmF5BL/UMfYv8RqXp8DpbR1xVSouqiSQqg/4Wd/LSZSH
   gG8VTCfGIbI9ArnOy1DhsPRdR6hGema1tNlLyMl2Mfb8qbpUkhdYDY+n6
   5psSarGI53u/bL+lfx71RbaO8gkTEWLcn7Ah+mFPE/cJubopl5wS7yub3
   ZM13lO0fcvm9azmltPzWAc1PAWGkFmOFAAqhy7JyeFo3MjPML7TH9XnD6
   3ztgTDyMvynqUC186cxuHdnTmmA4587ysAbfSAcme8yUiJ2L03MImVswM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="249914136"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="249914136"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 11:36:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548908550"
Received: from vpirogov-mobl.amr.corp.intel.com (HELO [10.252.137.68]) ([10.252.137.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 11:36:52 -0800
Message-ID: <30b7f884-11a3-5d2e-d883-17e2d5af7c74@intel.com>
Date:   Thu, 24 Feb 2022 11:36:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-10-kirill.shutemov@linux.intel.com>
 <67dfdb0c-c483-ec3c-4fb8-57086ffde9bf@intel.com>
 <YhfWwHE4nZfQWPCl@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 09/30] x86/tdx: Add MSR support for TDX guests
In-Reply-To: <YhfWwHE4nZfQWPCl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 11:04, Sean Christopherson wrote:
> On Thu, Feb 24, 2022, Dave Hansen wrote:
>> On 2/24/22 07:56, Kirill A. Shutemov wrote:
>>> diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
>>> index 0a2e6be0cdae..89992593a209 100644
>>> --- a/arch/x86/coco/tdx.c
>>> +++ b/arch/x86/coco/tdx.c
>>> @@ -116,6 +116,44 @@ void __cpuidle tdx_safe_halt(void)
>>>  		WARN_ONCE(1, "HLT instruction emulation failed\n");
>>>  }
>>>  
>>> +static bool read_msr(struct pt_regs *regs)
>>> +{
>>> +	struct tdx_hypercall_args args = {
>>> +		.r10 = TDX_HYPERCALL_STANDARD,
>>> +		.r11 = EXIT_REASON_MSR_READ,
>> Just a minor note: these "EXIT_REASON_FOO"'s in r11 are effectively
>> *the* hypercall being made, right?
>>
>> The hypercall is being made in response to what would have otherwise
>> been a MSR read VMEXIT.  But, it's a *bit* goofy to see them here when
>> the TDX guest isn't doing any kind of VMEXIT.
> But the TDX guest is doing a VM-Exit, that's all TDCALL is, an exit to the host.
> r10 states that this is a GHCI-standard hypercall, r11 holds the reason why the
> guest is exiting to the host.  The guest could pretty it up by redefining all the
> VM-Exit reasons as TDX_REQUEST_MSR_READ or whatever, but IMO diverging from
> directly using EXIT_REASON_* will be annoying in the long run, e.g. will make it
> more difficult to grep KVM + kernel to understand the end-to-end flow.

I understand that it looks like an "exit" if you know how it's
implemented, know the history and squint at it funny.  But, r11 is not
an exit reason.  It's a hypercall number that just sometimes happens to
also take an exit reason as a convention.  Don't confuse that with "r11
*is* an exit reason".

Heck, look at the GHCI spec.  Does it simply cede some of the
sub-function space and map them directly to VMEXIT reasons?  Nope.  It
goes to the trouble of individually defining them:

	12 Instruction.HLT
	30 Instruction.IO
	31 Instruction.RDMSR
	32 Instruction.WRMSR
	48 #VE.RequestMMIO
	65 Instruction.PCONFIG

I'm not saying we need 15 new #defines.  It would be really nice like
you say to be able to connect the host and guest sides with a grep.  I
wouldn't hate if we did something like:

	.r11 = hcall_func(EXIT_REASON_MSR_READ),

That retains greppability, but also tells you that r11 is a function
number.  It even gives a nice place to stick a comment to say what the
heck is going on:

/*
 * The TDG.VP.VMCALL-Instruction-execution sub-functions are defined
 * independently from but are currently matched 1:1 with VMX
 * EXIT_REASONs.  Reusing the KVM EXIT_REASON macros makes it easier to
 * connect the host and guest sides of these calls.
 */
static u64 hcall_func(u64 exit_reason)
{
	return exit_reason;
}

Like I said, this is all a minor note.  But, things like this really go
a long way for folks like me who don't spend our days looking at the KVM
code or thinking deeply about how the hypercall is implemented.
