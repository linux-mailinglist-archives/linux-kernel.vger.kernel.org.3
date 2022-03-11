Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3CE4D6A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiCKXNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiCKXMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:12:50 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6A2710D0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647040306; x=1678576306;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=uuSBPgW8Uq91Uvfhx+gXO07IUIcD2MzJovC3YjcLuEo=;
  b=nE66KPzmKQTbVVA1bqPtKiWFVz1HGjjvn1U8cXNqYfuIvTaMem1uXmJ9
   63RHmCdcw/6xlOMsQt4dC8AdcjwWkdojpiW1QDNlVDhiHGbGuNOnBRagx
   Ti7FP0r1Y0klirxfOFIxisdrGuK+ZF7QOZ2+yWgxOJCaksNDTBxkQVnDk
   1nI0NpsV244O7ujnMRI7RYkubwtGCwKl/JdZrBqa8d8DjIW+t/ftQGKsh
   RQwT3ICOtxN6MALECSNgTTbB0A29Ai0caKav+DuFcDAZnIsU4djgh5jax
   qHzHc8EW5rpBEf6oiC11Su5yuNDejrJizdeGAXc+EEYyIOs5DnAiRb7Gn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="237824556"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="237824556"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 12:59:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="645052848"
Received: from cpeirce-mobl1.amr.corp.intel.com (HELO [10.212.128.243]) ([10.212.128.243])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 12:59:24 -0800
Message-ID: <70e08bd5-187a-daee-2822-1d9a437a9cff@intel.com>
Date:   Fri, 11 Mar 2022 12:59:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20220311190749.338281-1-namit@vmware.com>
 <20220311190749.338281-3-namit@vmware.com>
 <a2a43395-b848-a4f9-4065-109387680701@intel.com>
 <AC8D21EA-CD32-4F9F-B5C1-ED8804EC76FF@vmware.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RESEND PATCH v3 2/5] x86/mm: check exec permissions on fault
In-Reply-To: <AC8D21EA-CD32-4F9F-B5C1-ED8804EC76FF@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 12:38, Nadav Amit wrote:
>> On Mar 11, 2022, at 11:41 AM, Dave Hansen <dave.hansen@intel.com> wrote:
...
>> Can any sane code trigger this?
> 
> Well, regarding this question and the previous one: I do not think that
> this scenario is possible today since mprotect() holds the mmap_lock
> for write. There is no other code that I am aware of that toggles
> the NX bit on a present entry.
> 
> But I will not bet my life on it. That’s the reason for the somewhat
> vague phrasing that I used.

From the userspace perspective, mmap(MAP_FIXED) can do this too.  But,
sane userspace can't rely on the syscall to have done any work and the
TLB flushing is currently done before the syscall returns.

I'd put it this way:

	Today, it is possible for a thread to end up in access_error()
	for a PF_INSN fault and observe a VM_EXEC VMA.  If you are
	generous, this could be considered a spurious fault.

	However, the faulting thread would have had to race with the
	thread which was changing the PTE and the VMA and is currently
	*in* mprotect() (or some other syscall).  In other words, the
	faulting thread can encounter this situation, but it never had
	any assurance from the kernel that it wouldn't fault.  This is
	because the faulting thread never had a chance to observe the
	syscall return.

	There is no evidence that the existing behavior can cause any
	issues with sane userspace.

>>> index d0074c6ed31a..ad0ef0a6087a 100644
>>> --- a/arch/x86/mm/fault.c
>>> +++ b/arch/x86/mm/fault.c
>>> @@ -1107,10 +1107,28 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>>> 				       (error_code & X86_PF_INSTR), foreign))
>>> 		return 1;
>>>
>>> -	if (error_code & X86_PF_WRITE) {
>>> +	if (error_code & (X86_PF_WRITE | X86_PF_INSTR)) {
>>> +		/*
>>> +		 * CPUs are not expected to set the two error code bits
>>> +		 * together, but to ensure that hypervisors do not misbehave,
>>> +		 * run an additional sanity check.
>>> +		 */
>>> +		if ((error_code & (X86_PF_WRITE|X86_PF_INSTR)) ==
>>> +					(X86_PF_WRITE|X86_PF_INSTR)) {
>>> +			WARN_ON_ONCE(1);
>>> +			return 1;
>>> +		}
>>
>> access_error() is only used on the do_user_addr_fault() side of things.
>> Can we stick this check somewhere that also works for kernel address
>> faults?  This is a generic sanity check.  It can also be in a separate
>> patch.
> 
> I can wrap it in a different function and also call it from
> do_kern_addr_fault() or spurious_kernel_fault().
> 
> Anyhow, spurious_kernel_fault() should handle spurious faults on
> executable code correctly. 

This is really about checking the sanity of the "hardware"-provided
error code.  Let's just do it in  handle_page_fault(), maybe hidden in a
function like:

void check_error_code_sanity(unsigned long error_code)
{
	WARN_ON_ONCE(...);
}

You can leave the X86_PF_PK check in place for now.  It's probably going
away soon anyway.

>> Also, we should *probably* stop talking about CPUs here.  If there's
>> ever something wonky with error code bits, I'd put my money on a weird
>> hypervisor before any kind of CPU issue.
> 
> I thought I manage to convey exactly that in the comment. Can you provide
> a better phrasing?

Maybe:

	/*
	 * X86_PF_INSTR for instruction _fetches_.  Fetches never write.
	 * X86_PF_WRITE should never be set with X86_PF_INSTR.
	 *
	 * This is most likely due to a buggy hypervisor.
	 */
