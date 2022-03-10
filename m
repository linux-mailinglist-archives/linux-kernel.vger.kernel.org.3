Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0910A4D3E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiCJBHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiCJBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:07:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F54120F7B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646874379; x=1678410379;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=++BWQpsuRxYiihQso6NfVi3dQLURo/BWY44J4oawpWk=;
  b=BEnoYa8v8Yxw9IcJBXio+NY7iW7iHK/K9mfnx1v17Y1bqCDLpNkH5YMD
   pp0IoRyiZaFaO9+NSW1P1WoDXdtMQ6hSqSd5ZcHCMM1oqNEkHHs8egmkE
   2TtfkeGqAGffaFJEtQWvrCKpQ3z4kcHTkN/d0IvI3mn2RGJ6qTmXjnYpu
   D6a4H9nzP2WFoAAnvcz5K64LXF3KK7ppsTZr6Iusttyhh+/mVlcvBwU3e
   iQ2zbRuoPP20mR4Uno6gO54Hyf0ZjDJlVTU12vGKa1LsOLlKxSU0Wm+EI
   b3MaFCdfmgF+DVaUC7spePglJs8zeDW2LTNNEXyIFxu9lK2VGKsLLnJl2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235736951"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="235736951"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:06:19 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="642364762"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:06:18 -0800
Message-ID: <da0056e8-58cf-2c95-fe66-4dad1ae9c4da@intel.com>
Date:   Wed, 9 Mar 2022 17:06:11 -0800
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
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 11/30] x86/tdx: Handle in-kernel MMIO
In-Reply-To: <20220310005145.hzv2lzxgs7uxblfr@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 16:51, Kirill A. Shutemov wrote:
> On Tue, Mar 08, 2022 at 01:26:28PM -0800, Dave Hansen wrote:
>> Memory encryption has zero to do with this.  The TDX isolation
>> mechanisms are totally discrete from memory encryption, although they
>> are "neighbors" of sorts.
> 
> Hm. I don't see why you say encryption is not relevant. VMM (host kernel)
> has ultimate access to guest memory cypher text. It can read it as
> cypher text without any issue (using KeyID-0).
> 
> Could you elaborate on the point?

I think you're just confusing what TDX has with MKTME.  The whitepaper says:

> The TD-bit associated with the line in memory seeks to
> detect software or devices attempting to read memory
> encrypted with private KeyID, using a shared KeyID, to reveal
> the ciphertext. On such accesses, the MKTME returns a fixed
> pattern to prevent ciphertext analysis.

I think several firstborn were sacrificed to get that bit.  Let's not
forget why we have it. :)

>>> Rather than touching the entire kernel, it might also be possible to
>>> just go after drivers that use MMIO in TDX guests.  Right now, that's
>>> limited only to virtio and some x86-specific drivers.
>>>
>>> All virtio MMIO appears to be done through a single function, which
>>> makes virtio eminently easy to patch.
>>>
>>> This approach will be adopted in the future, removing the bulk of
>>> MMIO #VEs. The #VE-based MMIO will remain serving non-virtio use cases.
>>
>> This still doesn't *quite* do it for me for a justification.  Why can't
>> the non-virtio cases be converted as well?  Why doesn't the "patching
>> MMIO sites" work for x86 code too?
>>
>> You really need to convince us that *this* approach will be required
>> forever.
> 
> What if I add:
> 
> 	Many drivers can potentially be used inside TDX guest (e.g. via device
> 	passthough or random device emulation by VMM), but very few will.
> 	Patching every possible driver is not practical. #VE-based MMIO provides
> 	functionality for everybody. Performance-critical cases can be optimized
> 	as needed.

This problem was laid out as having three cases:
1. virtio
2. x86-specific drivers
3. random drivers (everything else)

#1 could be done with paravirt
#2 is unspecified and unknown
#3 use doesn't as far as I know exist in TDX guests today

>>> +static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>>> +{
>>> +	char buffer[MAX_INSN_SIZE];
>>> +	unsigned long *reg, val;
>>> +	struct insn insn = {};
>>> +	enum mmio_type mmio;
>>> +	int size, extend_size;
>>> +	u8 extend_val = 0;
>>> +
>>> +	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
>>> +		return false;
>>> +
>>> +	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
>>> +		return false;
>>> +
>>> +	mmio = insn_decode_mmio(&insn, &size);
>>> +	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
>>> +		return false;
>>> +
>>> +	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
>>> +		reg = insn_get_modrm_reg_ptr(&insn, regs);
>>> +		if (!reg)
>>> +			return false;
>>> +	}
>>> +
>>> +	ve->instr_len = insn.length;
>>> +
>>> +	switch (mmio) {
>>> +	case MMIO_WRITE:
>>> +		memcpy(&val, reg, size);
>>> +		return mmio_write(size, ve->gpa, val);
>>> +	case MMIO_WRITE_IMM:
>>> +		val = insn.immediate.value;
>>> +		return mmio_write(size, ve->gpa, val);
>>> +	case MMIO_READ:
>>> +	case MMIO_READ_ZERO_EXTEND:
>>> +	case MMIO_READ_SIGN_EXTEND:
>>> +		break;
>>> +	case MMIO_MOVS:
>>> +	case MMIO_DECODE_FAILED:
>>> +		/*
>>> +		 * MMIO was accessed with an instruction that could not be
>>> +		 * decoded or handled properly. It was likely not using io.h
>>> +		 * helpers or accessed MMIO accidentally.
>>> +		 */
>>> +		return false;
>>> +	default:
>>> +		/* Unknown insn_decode_mmio() decode value? */
>>> +		BUG();
>>> +	}
>>
>> BUG()s are bad.  The set of insn_decode_mmio() return codes is known at
>> compile time.  If we're really on the lookout for unknown values, why
>> not just:
>>
>> 	BUILD_BUG_ON(NR_MMIO_TYPES != 6); // or whatever
> 
> This doesn't work.
> 
> We can pretend that the function only forced to return values from the
> enum. The truth is that it can return whatever int it wants. Type system
> in C is too week to guarantee anything here. The BUG() is backstop for it.
> 
> This BUILD_BUG_ON() is useless. Compiler complains about missing case in
> the switch anyway.
> 
>> Also, there are *lots* of ways for this function to just fall over and
>> fail.  Why does this particular failure mode deserve a BUG()?
>>
>> Is there a reason a BUG() is better than returning failure which
>> presumably sets off the #GP-like logic?
> 
> BUG() here makes it clear that the handler itself is buggy. Returning
> false and kicking in #GP-like logic indicates that something wrong with
> the code that triggered #VE. I think it is an important distinction.

OK, then how about a WARN_ON() which is followed by the #GP?

Let's say insn_decode_mmio() does something insane like:

	return -EINVAL;

Should we really be killing the kernel for that?

>> Also, now that I've read this a few times, I've been confused by the
>> same thing a few times.  This is handling instructions that might read
>> or write or do both, correct?
>>
>> Should that be made explicit in a function comment?
> 
> Hm. Okay. Something like
> 
> /* Handle reads from and writes to MMIO region. */
> 
> before the function?

There are really two halves to the function.  It would be nice to be
explicit about how the function is laid out and why reads take a bit
more handling at the end than writes.

That might be obvious to someone who has written an emulator or two but
it would be nice to include for the uninitiated.
