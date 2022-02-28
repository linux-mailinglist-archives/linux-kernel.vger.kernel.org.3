Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF54C71DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbiB1Qm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiB1QmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:42:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E785BCF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646066505; x=1677602505;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=hINsW3nG0StFV5R9Bj0BGAQv7ZLAVr/axcjJiTzTIco=;
  b=fgwlpCotSAuhvZYQyvEMETGTfoO+iFhSAWM8/+CC73UBHIiEYl7tw11F
   13Pl9GLvncLtoZnhswReXL5IOzcvO1fPJkl02YWaAWOEgMp8L0dwUpuFG
   6a1U4iF5UkfUifBfQHPHuSLX3x5eom7hgyh1cWaTX9KegD2vUeMeqDS0C
   uva1u0lXCR8+pw31IszG+P8OsshNcUG/piBxkPPvsIxwldoWJYpoj4ACO
   xfCpc5nCaU2Qep0eSJyMi2AYxonEVLF4CqDtM+8o/LPzcqdgR2X3SmB5A
   wfajgFcweLECfqvzMlNPe540NUpWO7Jl3S2yAXyOQ10f1GKUCc1v6SebM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="232896724"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="232896724"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:41:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="550310747"
Received: from eliasbro-mobl.amr.corp.intel.com (HELO [10.212.174.65]) ([10.212.174.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:41:43 -0800
Message-ID: <7a8c4e5e-c0ba-ee8e-a912-c71f89b4d4f2@intel.com>
Date:   Mon, 28 Feb 2022 08:41:38 -0800
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
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-11-kirill.shutemov@linux.intel.com>
 <51b6613d-eabd-941d-19b2-95b33ec27e99@intel.com>
 <20220227010733.abapkmyaroglcafl@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 10/30] x86/tdx: Handle CPUID via #VE
In-Reply-To: <20220227010733.abapkmyaroglcafl@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/22 17:07, Kirill A. Shutemov wrote:
> On Thu, Feb 24, 2022 at 11:04:04AM -0800, Dave Hansen wrote:
>> On 2/24/22 07:56, Kirill A. Shutemov wrote:
>>>  static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
>>>  {
>>> -	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>>> -	return false;
>>> +	switch (ve->exit_reason) {
>>> +	case EXIT_REASON_CPUID:
>>> +		return handle_cpuid(regs);
>>> +	default:
>>> +		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>>> +		return false;
>>> +	}
>>>  }
>>
>> What does this mean for userspace?  What kinds of things are we ceding
>> to the (untrusted) VMM to supply to userspace?
> 
> Here's what I see called from userspace.
> CPUID(AX=0x2)
> CPUID(AX=0xb, CX=0x0)
> CPUID(AX=0xb, CX=0x1)
> CPUID(AX=0x40000000, CX=0xfffaba17)
> CPUID(AX=0x80000007, CX=0x121)

Hi Kirill,

I'm not quite sure what to make of this.  Is this an *exhaustive* list
of CPUID values?  Or is this an example of what you see on one system
and one boot of userspace?

What I really want to get at is what this *means*.

For instance, maybe all of these are in the hypervisor CPUID space.
Those basically *must* be supplied by the hypervisor.

>>>  /* Handle the kernel #VE */
>>> @@ -200,6 +235,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>>>  		return read_msr(regs);
>>>  	case EXIT_REASON_MSR_WRITE:
>>>  		return write_msr(regs);
>>> +	case EXIT_REASON_CPUID:
>>> +		return handle_cpuid(regs);
>>>  	default:
>>>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>>>  		return false;
>> What kinds of random CPUID uses in the kernel at runtime need this
>> handling?
> 
> CPUID(AX=0x2)
> CPUID(AX=0x6, CX=0x0)
> CPUID(AX=0xb, CX=0x0)
> CPUID(AX=0xb, CX=0x1)
> CPUID(AX=0xb, CX=0x2)
> CPUID(AX=0xf, CX=0x0)
> CPUID(AX=0xf, CX=0x1)
> CPUID(AX=0x10, CX=0x0)
> CPUID(AX=0x10, CX=0x1)
> CPUID(AX=0x10, CX=0x2)
> CPUID(AX=0x10, CX=0x3)
> CPUID(AX=0x16, CX=0x0)
> CPUID(AX=0x1f, CX=0x0)
> CPUID(AX=0x40000000, CX=0x0)
> CPUID(AX=0x40000000, CX=0xfffaba17)
> CPUID(AX=0x40000001, CX=0x0)
> CPUID(AX=0x80000002, CX=0x0)
> CPUID(AX=0x80000003, CX=0x0)
> CPUID(AX=0x80000004, CX=0x0)
> CPUID(AX=0x80000007, CX=0x0)
> CPUID(AX=0x80000007, CX=0x121)

OK, that's a good list.  I guess I need to decode those and make sense
of them.  Any help would be appreciated and would speed along this
review process.

>> Is it really OK that we let the VMM inject arbitrary CPUID
>> values into random CPUID uses in the kernel... silently?
> 
> We realise that this is possible vector of attack and plan to implement
> proper filtering. But it is beyon core enabling.
> 
>> Is this better than just returning 0's, for instance?
> 
> Plain 0 injection breaks the boot. More complicated solution is need.

OK, so we're leaving the kernel open to something that might be an
attack vector: we know that we don't know how this might be bad.  It's a
"known unknown"[1].

That doesn't seem *horrible*.  But, it also doesn't seem great.  There
are a lot of ways to address the situation.  But, simply not mentioning
it in the changelog or cover letter isn't a great way to handle it.

Where do we *want* this to be?  I'll take a stab at it:

In a perfect world, we'd simply keep a list of things that come from the
hypervisor and others where the kernel wants to provide the CPUID data.
 But, there are always going to be new uses of CPUID.  There's no way we
can keep a 100% complete list.

That means that the kernel needs to handle unknown CPUID use.  There are
currently no known stupidly simple solutions like "return all 0's".

The other simplest solution is to just call into the hypervisor no
matter what the CPUID use is.  This puts the kernel at the mercy of the
hypervisor to some unknown degree.  But, it is OK given a benign hypervisor.

The kernel can WARN() or taint on the situation for now until you
develop a a more robust list of items that can be deferred to the
hypervisor.

1. https://en.wikipedia.org/wiki/There_are_known_knowns
