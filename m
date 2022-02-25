Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7E54C4F18
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiBYTqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiBYTqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:46:47 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE3210465
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645818374; x=1677354374;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=mOgN86aJZ91+6Wbt1y1CVDWdjxEmy422XHUD/oq8jcw=;
  b=njgWqdvTOCrWBbRps31IcbTS+vpxRUn+jZtjB0gZvAn52DNVg/qoWsUK
   p+E9Aa4Br2rTbdTVBVUotoTUdXL3nGCXn225UHUlyknbYB6VE9yYMsiJ0
   bLO1Y8fPfl+tlT2GIqPLVWETqJ4qbgPvSq3j3IUt/9MP7kMVpa4Hhe19n
   dJdKBdhj9x9h6Y2+n3a8rli9IRfy273v4mzGBC/SNuqAYKtFjYRgJd5RL
   JAYtmEhkbZrU8ME4teVKgeDqUTr4uJVNY+Hm9CchiXvnaugQrIjp130kg
   wcwSzyCGvRAKmoumBn7w2bw3Gh8pri4bJcNereed71gLHjy38a5KPIU/K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="236075496"
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="236075496"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 11:46:13 -0800
X-IronPort-AV: E=Sophos;i="5.90,137,1643702400"; 
   d="scan'208";a="533689021"
Received: from wreed-mobl.amr.corp.intel.com (HELO [10.212.247.12]) ([10.212.247.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 11:46:10 -0800
Message-ID: <e0a91991-9648-5c3e-62dc-342c9d8ed957@intel.com>
Date:   Fri, 25 Feb 2022 11:46:04 -0800
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
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-8-kirill.shutemov@linux.intel.com>
 <c6ad42a0-ab19-befd-5760-2bcc992df732@intel.com>
 <20220225193059.6zn6owzpbggxfqqv@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 07/30] x86/traps: Add #VE support for TDX guest
In-Reply-To: <20220225193059.6zn6owzpbggxfqqv@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 11:30, Kirill A. Shutemov wrote:
> On Thu, Feb 24, 2022 at 10:36:02AM -0800, Dave Hansen wrote:
>> On 2/24/22 07:56, Kirill A. Shutemov wrote:
>>> Virtualization Exceptions (#VE) are delivered to TDX guests due to
>>> specific guest actions which may happen in either user space or the
>>> kernel:
>>>
>>>  * Specific instructions (WBINVD, for example)
>>>  * Specific MSR accesses
>>>  * Specific CPUID leaf accesses
>>>  * Access to unmapped pages (EPT violation)
>>
>> Considering that you're talking partly about userspace, it would be nice
>> to talk about what "unmapped" really means here.
> 
> I'm not sure what you want to see here. Doesn't EPT violation describe it?
> 
> It can happen to userspace too, but we don't expect it to be use used and
> SIGSEGV the process if it happens.

How about just:

 * Access to specific guest physical addresses

That makes it clear that we're not really talking about userspace
unmapped pages.

...
>>> +	 * module also treats virtual NMIs as inhibited if the #VE valid flag is
>>> +	 * set, e.g. so that NMI=>#VE will not result in a #DF.
>>> +	 */
>>
>> Are we missing anything valuable if we just trim the comment down to
>> something like:
>>
>> 	/*
>> 	 * Called during #VE handling to retrieve the #VE info from the
>> 	 * TDX module.
>>  	 *
>> 	 * This should called done early in #VE handling.  A "nested"
>> 	 * #VE which occurs before this will raise a #DF and is not
>> 	 * recoverable.
>> 	 */
> 
> This variant of the comment lost information about #VE-valid flag and
> doesn't describe how NMI is inhibited.

IMNHO, the "#VE valid" flag is a super-fine implementation detail.  I'd
personally deal with that in Documentation or the changelog instead of a
comment.

>>> +#ifdef CONFIG_INTEL_TDX_GUEST
>>> +
>>> +#define VE_FAULT_STR "VE fault"
>>> +
>>> +static void ve_raise_fault(struct pt_regs *regs, long error_code)
>>> +{
>>> +	if (user_mode(regs)) {
>>> +		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code, VE_FAULT_STR);
>>> +		return;
>>> +	}
>>> +
>>> +	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR))
>>> +		return;
>>> +
>>> +	die_addr(VE_FAULT_STR, regs, error_code, 0);
>>> +}
>>> +
>>> +/*
>>> + * Virtualization Exceptions (#VE) are delivered to TDX guests due to
>>> + * specific guest actions which may happen in either user space or the
>>> + * kernel:
>>> + *
>>> + *  * Specific instructions (WBINVD, for example)
>>> + *  * Specific MSR accesses
>>> + *  * Specific CPUID leaf accesses
>>> + *  * Access to unmapped pages (EPT violation)
>>> + *
>>> + * In the settings that Linux will run in, virtualization exceptions are
>>> + * never generated on accesses to normal, TD-private memory that has been
>>> + * accepted.
>>
>> This actually makes a lot more sense as a code comment than changelog.
>> It would be really nice to circle back here and actually refer to the
>> functions that accept memory.
> 
> We don't have such functions at this point in the patchset. Do you want
> the comment to be updated once we get them introduced?

Yes, please.  Supplement the comment when the functions are introduced
later.
