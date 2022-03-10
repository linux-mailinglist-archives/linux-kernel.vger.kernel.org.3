Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C8A4D50F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245202AbiCJRyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiCJRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:54:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F0DFA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646934790; x=1678470790;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=q+I63CMumq1kuvNXZtDwkWWhDmI0tqQDvrLdv4Ex6AQ=;
  b=j049exgZsGU1vXOa/tdnXsasFEUVFS4L0LeIeTMpX1ouEJVCb5xDrlYF
   AisEDEoMjx0JALb7yLu511Lb/HeX8hIJ+Uc0vRX+z3HC/mVcCB99siuQl
   n6COIPuZUWQ2OSg9HxjEPVu+arOp7I2zck8hBokEb39vNWUddJ2LTRAWS
   cXbtG/Vc6prjo9S9YpOoG6vGR3DwmL8RM/suPxbeVE2IKHEfYxTvap21U
   MxRUAWmJh6vK9SzKHqN7X7WH7J5WEWm3jUPux9bf9KNaE6igA2X9PVeze
   DIb/tntDAGefm0MQuiT+CikXYVOMK1rOYgNKLyUF63g4nRPy29mEVCbVM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255057481"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255057481"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:53:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="688744651"
Received: from efrantz-mobl1.amr.corp.intel.com (HELO [10.212.252.101]) ([10.212.252.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:53:08 -0800
Message-ID: <9b2836ce-5267-8342-65eb-1084ba7e0cdf@intel.com>
Date:   Thu, 10 Mar 2022 09:53:01 -0800
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
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-12-kirill.shutemov@linux.intel.com>
 <81a7ad6d-6bd9-7674-3229-67a5cd2e485a@intel.com>
 <20220310005145.hzv2lzxgs7uxblfr@black.fi.intel.com>
 <da0056e8-58cf-2c95-fe66-4dad1ae9c4da@intel.com>
 <20220310164839.erpjijvxwuzjql5x@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 11/30] x86/tdx: Handle in-kernel MMIO
In-Reply-To: <20220310164839.erpjijvxwuzjql5x@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 08:48, Kirill A. Shutemov wrote:
> On Wed, Mar 09, 2022 at 05:06:11PM -0800, Dave Hansen wrote:
>> On 3/9/22 16:51, Kirill A. Shutemov wrote:
>>> On Tue, Mar 08, 2022 at 01:26:28PM -0800, Dave Hansen wrote:
>>>> Memory encryption has zero to do with this.  The TDX isolation
>>>> mechanisms are totally discrete from memory encryption, although they
>>>> are "neighbors" of sorts.
>>>
>>> Hm. I don't see why you say encryption is not relevant. VMM (host kernel)
>>> has ultimate access to guest memory cypher text. It can read it as
>>> cypher text without any issue (using KeyID-0).
>>>
>>> Could you elaborate on the point?
>>
>> I think you're just confusing what TDX has with MKTME.  The whitepaper says:
>>
>>> The TD-bit associated with the line in memory seeks to
>>> detect software or devices attempting to read memory
>>> encrypted with private KeyID, using a shared KeyID, to reveal
>>> the ciphertext. On such accesses, the MKTME returns a fixed
>>> pattern to prevent ciphertext analysis.
>>
>> I think several firstborn were sacrificed to get that bit.  Let's not
>> forget why we have it. :)
> 
> Okay, I missed the memo. I will drop reference to encryption:
> 
>   - The CPU disallows software other than the TDX module and TDs from
>     making memory accesses using the private key. Without the correct
>     key VMM has no way to access TD-private memory.

I think this is good enough:

   - All guest code is expected to be in TD-private memory.  Being
     private to the TD, VMMs have no way to access TD-private memory and
     no way to read the instruction to decode and emulate it.

We don't have to rehash what private memory is or how it is implemented.

>> This problem was laid out as having three cases:
>> 1. virtio
>> 2. x86-specific drivers
>> 3. random drivers (everything else)
>>
>> #1 could be done with paravirt
>> #2 is unspecified and unknown
>> #3 use doesn't as far as I know exist in TDX guests today
> 
> #2 doesn't matter from performance point of view and there is no
> convenient place where they can be intercepted as they are scattered
> across the tree. Patching them doesn't bring any benefit, only pain.

I'd feel a lot better if this was slightly better specified.  Even
booting with a:

	printf("rip: %lx\n", regs->rip);

in the #VE handler would give some hard data about these.  This still
feels to me like something that Sean got booting two years ago and
nobody has really reconsidered.

> #3 some customers already declared that they will use device passthough
> (yes, it is not safe). CSP may want to emulate random device, depending on
> setup. Like, a power button or something.

I'm not sure I'm totally on board with that.

But, let's try to make a coherent changelog out of that mess.

	This approach is bad for performance.  But, it has (virtually)
	no impact on the size of the kernel image and will work for a
	wide variety of drivers.  This allows TDX deployments to use
	arbitrary devices and device drivers, including virtio.  TDX
	customers have asked for the capability to use random devices in
	their deployments.

	In other words, even if all of the work was done to
	paravirtualize all x86 MMIO users and virtio, this approach
	would still be needed.  There is essentially no way to get rid
	of this code.

	This approach is functional for all in-kernel MMIO users current
	and future and does so with a minimal amount of code and kernel
	image bloat.

Does that summarize it?

>>> BUG() here makes it clear that the handler itself is buggy. Returning
>>> false and kicking in #GP-like logic indicates that something wrong with
>>> the code that triggered #VE. I think it is an important distinction.
>>
>> OK, then how about a WARN_ON() which is followed by the #GP?
> 
> You folks give mixed messages. Thomas was very unhappy when I tried to add
> code that recovers from WBINVD:
> 
> https://lore.kernel.org/all/87y22uujkm.ffs@tglx
> 
> It is exactly the same scenario: kernel code is buggy and has to be fixed.
> 
> So, what the policy?

Lately, I've tried to subscribe to the "there is NO F*CKING EXCUSE to
knowingly kill the kernel" policy[1].

You don't add a BUG_ON() unless the kernel has no meaningful way to
continue.  It's not for a "hey, that's weird..." kind of thing.  Like,
"hey, the instruction decoder looks confused, that's weird."

>> Let's say insn_decode_mmio() does something insane like:
>>
>> 	return -EINVAL;
>>
>> Should we really be killing the kernel for that?
> 
> Note that #GP is most likely kill kernel as well. We handle in-kernel
> MMIO. There are no many chances for recover.
> 
> Is it really the big deal?

No, not really.

But, I'd like to see one of two things:
1. Change the BUG()s to WARN()s.
2. Make it utterly clear that handle_mmio() is for handling kernel MMIO
   only.  Definitely change the naming, possibly add a check for
   user_mode().  In other words, make it even _less_ generic.

None of that should be hard.

BTW, the BUG()s made me think about how the gp_try_fixup_and_notify()
code would work for MMIO.  For instance, are there any places where
fixup might be done for MMIO?  If so, an earlier BUG() wouldn't allow
the fixup to occur.

Do we *WANT* #VE's to be exposed to the #GP fixup machinery?

1.
https://lore.kernel.org/all/CA+55aFwyNTLuZgOWMTRuabWobF27ygskuxvFd-P0n-3UNT=0Og@mail.gmail.com/
