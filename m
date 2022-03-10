Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E84D3E71
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbiCJAwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiCJAwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:52:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D25A6E56B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646873493; x=1678409493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lkeupvj4kynTUScTDJhfQz76mAOO5ubgDQN4+bqAFrA=;
  b=jMHOnKYQi2RrjC34divGYtrvX/ZFvgoK4u64V+GJoE6YHUo4PkpxfpTZ
   3f8DltYDBka2bWPkjnkv0XDxuorTqxTPS5gvijlVA/lxPTmu/6unHPeWQ
   Txct4qZDi1qJ4FjGVoF1dqkj+rAIA0utWsSoS/7kkalgn61Djeq564qAp
   nx1zNtxwt85Wc2y6JfxiAHd3T/h0FiDpMWA/CQFhYACn7gOiW+bRO1R81
   60SB1QX5cP/kJIRbfu5ZYxdkxr6V7ehlkA6/wknq9ZvFGFUv99VYlFwIr
   En+L0cMiBHYLTP8QjKUlGAVT/p+FBSPKEPrcaJXtmvjkmXYuzl/Yd6T8F
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255313771"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="255313771"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:51:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="496053296"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2022 16:51:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 70C69211; Thu, 10 Mar 2022 02:51:45 +0200 (EET)
Date:   Thu, 10 Mar 2022 03:51:45 +0300
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 11/30] x86/tdx: Handle in-kernel MMIO
Message-ID: <20220310005145.hzv2lzxgs7uxblfr@black.fi.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-12-kirill.shutemov@linux.intel.com>
 <81a7ad6d-6bd9-7674-3229-67a5cd2e485a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a7ad6d-6bd9-7674-3229-67a5cd2e485a@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:26:28PM -0800, Dave Hansen wrote:
> On 3/2/22 06:27, Kirill A. Shutemov wrote:
> > In non-TDX VMs, MMIO is implemented by providing the guest a mapping
> > which will cause a VMEXIT on access and then the VMM emulating the
> > instruction that caused the VMEXIT. That's not possible for TDX VM.
> > 
> > To emulate an instruction an emulator needs two things:
> > 
> >   - R/W access to the register file to read/modify instruction arguments
> >     and see RIP of the faulted instruction.
> > 
> >   - Read access to memory where instruction is placed to see what to
> >     emulate. In this case it is guest kernel text.
> > 
> > Both of them are not available to VMM in TDX environment:
> > 
> >   - Register file is never exposed to VMM. When a TD exits to the module,
> >     it saves registers into the state-save area allocated for that TD.
> >     The module then scrubs these registers before returning execution
> >     control to the VMM, to help prevent leakage of TD state.
> > 
> >   - Memory is encrypted a TD-private key. The CPU disallows software
> >     other than the TDX module and TDs from making memory accesses using
> >     the private key.
> 
> Memory encryption has zero to do with this.  The TDX isolation
> mechanisms are totally discrete from memory encryption, although they
> are "neighbors" of sorts.

Hm. I don't see why you say encryption is not relevant. VMM (host kernel)
has ultimate access to guest memory cypher text. It can read it as
cypher text without any issue (using KeyID-0).

Could you elaborate on the point?

> > == Patching TDX drivers ==
> > 
> > Rather than touching the entire kernel, it might also be possible to
> > just go after drivers that use MMIO in TDX guests.  Right now, that's
> > limited only to virtio and some x86-specific drivers.
> > 
> > All virtio MMIO appears to be done through a single function, which
> > makes virtio eminently easy to patch.
> > 
> > This approach will be adopted in the future, removing the bulk of
> > MMIO #VEs. The #VE-based MMIO will remain serving non-virtio use cases.
> 
> This still doesn't *quite* do it for me for a justification.  Why can't
> the non-virtio cases be converted as well?  Why doesn't the "patching
> MMIO sites" work for x86 code too?
> 
> You really need to convince us that *this* approach will be required
> forever.

What if I add:

	Many drivers can potentially be used inside TDX guest (e.g. via device
	passthough or random device emulation by VMM), but very few will.
	Patching every possible driver is not practical. #VE-based MMIO provides
	functionality for everybody. Performance-critical cases can be optimized
	as needed.

?

> > +static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > +{
> > +	char buffer[MAX_INSN_SIZE];
> > +	unsigned long *reg, val;
> > +	struct insn insn = {};
> > +	enum mmio_type mmio;
> > +	int size, extend_size;
> > +	u8 extend_val = 0;
> > +
> > +	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
> > +		return false;
> > +
> > +	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
> > +		return false;
> > +
> > +	mmio = insn_decode_mmio(&insn, &size);
> > +	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
> > +		return false;
> > +
> > +	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
> > +		reg = insn_get_modrm_reg_ptr(&insn, regs);
> > +		if (!reg)
> > +			return false;
> > +	}
> > +
> > +	ve->instr_len = insn.length;
> > +
> > +	switch (mmio) {
> > +	case MMIO_WRITE:
> > +		memcpy(&val, reg, size);
> > +		return mmio_write(size, ve->gpa, val);
> > +	case MMIO_WRITE_IMM:
> > +		val = insn.immediate.value;
> > +		return mmio_write(size, ve->gpa, val);
> > +	case MMIO_READ:
> > +	case MMIO_READ_ZERO_EXTEND:
> > +	case MMIO_READ_SIGN_EXTEND:
> > +		break;
> > +	case MMIO_MOVS:
> > +	case MMIO_DECODE_FAILED:
> > +		/*
> > +		 * MMIO was accessed with an instruction that could not be
> > +		 * decoded or handled properly. It was likely not using io.h
> > +		 * helpers or accessed MMIO accidentally.
> > +		 */
> > +		return false;
> > +	default:
> > +		/* Unknown insn_decode_mmio() decode value? */
> > +		BUG();
> > +	}
> 
> BUG()s are bad.  The set of insn_decode_mmio() return codes is known at
> compile time.  If we're really on the lookout for unknown values, why
> not just:
> 
> 	BUILD_BUG_ON(NR_MMIO_TYPES != 6); // or whatever

This doesn't work.

We can pretend that the function only forced to return values from the
enum. The truth is that it can return whatever int it wants. Type system
in C is too week to guarantee anything here. The BUG() is backstop for it.

This BUILD_BUG_ON() is useless. Compiler complains about missing case in
the switch anyway.

> Also, there are *lots* of ways for this function to just fall over and
> fail.  Why does this particular failure mode deserve a BUG()?
> 
> Is there a reason a BUG() is better than returning failure which
> presumably sets off the #GP-like logic?

BUG() here makes it clear that the handler itself is buggy. Returning
false and kicking in #GP-like logic indicates that something wrong with
the code that triggered #VE. I think it is an important distinction.

> Also, now that I've read this a few times, I've been confused by the
> same thing a few times.  This is handling instructions that might read
> or write or do both, correct?
> 
> Should that be made explicit in a function comment?

Hm. Okay. Something like

/* Handle reads from and writes to MMIO region. */

before the function?

-- 
 Kirill A. Shutemov
