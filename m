Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A014D234B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbiCHV1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiCHV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:27:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D30C50B1E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646774797; x=1678310797;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=y8RxfV//+4n3/Vm4Co6qAm5r4LIx+CuMhr9RsKi0r/U=;
  b=nINPh/VMozEQ58/z2qCqVLcfjpLoJbv3reJ7MnNbwQxBvQ23YxZjFbId
   Gya44qgkzUEwcPxSdrFnPAafgKm31L7UujTAl7JVkfJlM5/Y2SM+1UKJE
   URWK2CS2k2o5tXNtkoheR2FAHVlkCRBDm0w6QxKij2Q/QRH9NBIOjb3nX
   3SwriPDA+2CS4UGKLZBTL6GG7XxQOuOB4MBYq9SDgAxBp6GyXtk2ag2jf
   Zb3d3UwACzzjlV9AxSsZwbSnMfGGJg79QPbAJLchTUjUjG4i6WqIP5CvL
   9HObHtrNgPbcENooPSMB8yXdV1W4QG1jptPHbHXn2LC0N5xIi9QgICZBH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="279539464"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="279539464"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:26:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547410709"
Received: from ntebyanx-mobl7.amr.corp.intel.com (HELO [10.212.224.65]) ([10.212.224.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 13:26:35 -0800
Message-ID: <81a7ad6d-6bd9-7674-3229-67a5cd2e485a@intel.com>
Date:   Tue, 8 Mar 2022 13:26:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-12-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 11/30] x86/tdx: Handle in-kernel MMIO
In-Reply-To: <20220302142806.51844-12-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:27, Kirill A. Shutemov wrote:
> In non-TDX VMs, MMIO is implemented by providing the guest a mapping
> which will cause a VMEXIT on access and then the VMM emulating the
> instruction that caused the VMEXIT. That's not possible for TDX VM.
> 
> To emulate an instruction an emulator needs two things:
> 
>   - R/W access to the register file to read/modify instruction arguments
>     and see RIP of the faulted instruction.
> 
>   - Read access to memory where instruction is placed to see what to
>     emulate. In this case it is guest kernel text.
> 
> Both of them are not available to VMM in TDX environment:
> 
>   - Register file is never exposed to VMM. When a TD exits to the module,
>     it saves registers into the state-save area allocated for that TD.
>     The module then scrubs these registers before returning execution
>     control to the VMM, to help prevent leakage of TD state.
> 
>   - Memory is encrypted a TD-private key. The CPU disallows software
>     other than the TDX module and TDs from making memory accesses using
>     the private key.

Memory encryption has zero to do with this.  The TDX isolation
mechanisms are totally discrete from memory encryption, although they
are "neighbors" of sorts.

> In TDX the MMIO regions are instead configured by VMM to trigger a #VE
> exception in the guest.
> 
> Add #VE handling that emulates the MMIO instruction inside the guest and
> converts it into a controlled hypercall to the host.
> 
> MMIO addresses can be used with any CPU instruction that accesses
> memory. Address only MMIO accesses done via io.h helpers, such as
> 'readl()' or 'writeq()'.
> 
> Any CPU instruction that accesses memory can also be used to access
> MMIO.  However, by convention, MMIO access are typically performed via
> io.h helpers such as 'readl()' or 'writeq()'.
> 
> The io.h helpers intentionally use a limited set of instructions when
> accessing MMIO.  This known, limited set of instructions makes MMIO
> instruction decoding and emulation feasible in KVM hosts and SEV guests
> today.
> 
> MMIO accesses are performed without the io.h helpers are at the mercy of

		^ s/are//

> the compiler.  Compilers can and will generate a much more broad set of
> instructions which can not practically be decoded and emulated.  TDX
> guests will oops if they encounter one of these decoding failures.
> 
> This means that TDX guests *must* use the io.h helpers to access MMIO.
> 
> This requirement is not new.  Both KVM hosts and AMD SEV guests have the
> same limitations on MMIO access.
> 
> === Potential alternative approaches ===
> 
> == Paravirtualizing all MMIO ==
> 
> An alternative to letting MMIO induce a #VE exception is to avoid
> the #VE in the first place. Similar to the port I/O case, it is
> theoretically possible to paravirtualize MMIO accesses.
> 
> Like the exception-based approach offered here, a fully paravirtualized
> approach would be limited to MMIO users that leverage common
> infrastructure like the io.h macros.
> 
> However, any paravirtual approach would be patching approximately 120k
> call sites. Any paravirtual approach would need to replace a bare memory
> access instruction with (at least) a function call. With a conservative
> overhead estimation of 5 bytes per call site (CALL instruction),
> it leads to bloating code by 600k.
> 
> Many drivers will never be used in the TDX environment and the bloat
> cannot be justified.
> 
> == Patching TDX drivers ==
> 
> Rather than touching the entire kernel, it might also be possible to
> just go after drivers that use MMIO in TDX guests.  Right now, that's
> limited only to virtio and some x86-specific drivers.
> 
> All virtio MMIO appears to be done through a single function, which
> makes virtio eminently easy to patch.
> 
> This approach will be adopted in the future, removing the bulk of
> MMIO #VEs. The #VE-based MMIO will remain serving non-virtio use cases.

This still doesn't *quite* do it for me for a justification.  Why can't
the non-virtio cases be converted as well?  Why doesn't the "patching
MMIO sites" work for x86 code too?

You really need to convince us that *this* approach will be required
forever.

> diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
> index d00b367f8052..e6163e7e3247 100644
> --- a/arch/x86/coco/tdx.c
> +++ b/arch/x86/coco/tdx.c
> @@ -8,11 +8,17 @@
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> +#include <asm/insn.h>
> +#include <asm/insn-eval.h>
>  
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
>  #define TDX_GET_VEINFO			3
>  
> +/* MMIO direction */
> +#define EPT_READ	0
> +#define EPT_WRITE	1
> +
>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>   * return code.
> @@ -200,6 +206,112 @@ static bool handle_cpuid(struct pt_regs *regs)
>  	return true;
>  }
>  
> +static bool mmio_read(int size, unsigned long addr, unsigned long *val)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = hcall_func(EXIT_REASON_EPT_VIOLATION),
> +		.r12 = size,
> +		.r13 = EPT_READ,
> +		.r14 = addr,
> +		.r15 = *val,
> +	};
> +
> +	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
> +		return false;
> +	*val = args.r11;
> +	return true;
> +}
> +
> +static bool mmio_write(int size, unsigned long addr, unsigned long val)
> +{
> +	return !_tdx_hypercall(hcall_func(EXIT_REASON_EPT_VIOLATION), size,
> +			       EPT_WRITE, addr, val);
> +}
> +
> +static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> +{
> +	char buffer[MAX_INSN_SIZE];
> +	unsigned long *reg, val;
> +	struct insn insn = {};
> +	enum mmio_type mmio;
> +	int size, extend_size;
> +	u8 extend_val = 0;
> +
> +	if (copy_from_kernel_nofault(buffer, (void *)regs->ip, MAX_INSN_SIZE))
> +		return false;
> +
> +	if (insn_decode(&insn, buffer, MAX_INSN_SIZE, INSN_MODE_64))
> +		return false;
> +
> +	mmio = insn_decode_mmio(&insn, &size);
> +	if (WARN_ON_ONCE(mmio == MMIO_DECODE_FAILED))
> +		return false;
> +
> +	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
> +		reg = insn_get_modrm_reg_ptr(&insn, regs);
> +		if (!reg)
> +			return false;
> +	}
> +
> +	ve->instr_len = insn.length;
> +
> +	switch (mmio) {
> +	case MMIO_WRITE:
> +		memcpy(&val, reg, size);
> +		return mmio_write(size, ve->gpa, val);
> +	case MMIO_WRITE_IMM:
> +		val = insn.immediate.value;
> +		return mmio_write(size, ve->gpa, val);
> +	case MMIO_READ:
> +	case MMIO_READ_ZERO_EXTEND:
> +	case MMIO_READ_SIGN_EXTEND:
> +		break;
> +	case MMIO_MOVS:
> +	case MMIO_DECODE_FAILED:
> +		/*
> +		 * MMIO was accessed with an instruction that could not be
> +		 * decoded or handled properly. It was likely not using io.h
> +		 * helpers or accessed MMIO accidentally.
> +		 */
> +		return false;
> +	default:
> +		/* Unknown insn_decode_mmio() decode value? */
> +		BUG();
> +	}

BUG()s are bad.  The set of insn_decode_mmio() return codes is known at
compile time.  If we're really on the lookout for unknown values, why
not just:

	BUILD_BUG_ON(NR_MMIO_TYPES != 6); // or whatever

Also, there are *lots* of ways for this function to just fall over and
fail.  Why does this particular failure mode deserve a BUG()?

Is there a reason a BUG() is better than returning failure which
presumably sets off the #GP-like logic?

Also, now that I've read this a few times, I've been confused by the
same thing a few times.  This is handling instructions that might read
or write or do both, correct?

Should that be made explicit in a function comment?

> +	/* Handle reads */
> +	if (!mmio_read(size, ve->gpa, &val))
> +		return false;
> +
> +	switch (mmio) {
> +	case MMIO_READ:
> +		/* Zero-extend for 32-bit operation */
> +		extend_size = size == 4 ? sizeof(*reg) : 0;
> +		break;
> +	case MMIO_READ_ZERO_EXTEND:
> +		/* Zero extend based on operand size */
> +		extend_size = insn.opnd_bytes;
> +		break;
> +	case MMIO_READ_SIGN_EXTEND:
> +		/* Sign extend based on operand size */
> +		extend_size = insn.opnd_bytes;
> +		if (size == 1 && val & BIT(7))
> +			extend_val = 0xFF;
> +		else if (size > 1 && val & BIT(15))
> +			extend_val = 0xFF;
> +		break;
> +	default:
> +		/* All other cases has to be covered with the first switch() */
> +		BUG();
> +	}
> +
> +	if (extend_size)
> +		memset(reg, extend_val, extend_size);
> +	memcpy(reg, &val, size);
> +	return true;
> +}
> +
>  void tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out;
> @@ -247,6 +359,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  		return write_msr(regs);
>  	case EXIT_REASON_CPUID:
>  		return handle_cpuid(regs);
> +	case EXIT_REASON_EPT_VIOLATION:
> +		return handle_mmio(regs, ve);
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return false;

