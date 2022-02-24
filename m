Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05444C34EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiBXSnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiBXSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:43:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0820D51B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 10:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645728183; x=1677264183;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=y/bGeuO2u8Zn7HXsvFk9tlnXkxIAjc9N5n2NQK7v5M0=;
  b=ZWVrQknd9qxGMd6yEKExz0+CbDF47zH96wIuSi71e+i9T7SXIvW+4Enr
   6e72Yk68U5AfiLgblHG3rcmCxFiirEp9fKcyJEoxPhbadW13tGxfLlgrU
   CBGGx8sUfWfeO4/EmnnHiJz3jFd5vhpNm4zP6sahH/egAbYKKgPH+LZHb
   6vl82u+gU16/zB9MSQCAdyK2syRBP8+6sJf7OiqsIul3Jh4Vg4P1wpjSB
   Xv7K2YN07h4wbhCr6pF/saOrVJtkq41kcmL1f0iYRV88GdFb/u9NYL0lE
   Dm2J46LVCzw+lx7lbf5pUy3dpIUndUNPtgxDLyGcxmWwZEddz4OROOiQT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315537658"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="315537658"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 10:43:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548882659"
Received: from vpirogov-mobl.amr.corp.intel.com (HELO [10.252.137.68]) ([10.252.137.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 10:43:01 -0800
Message-ID: <9b4b3581-925b-32a8-8a4f-fdd8d98f2164@intel.com>
Date:   Thu, 24 Feb 2022 10:42:56 -0800
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
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-9-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 08/30] x86/tdx: Add HLT support for TDX guests
In-Reply-To: <20220224155630.52734-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> The HLT instruction is a privileged instruction, executing it stops
> instruction execution and places the processor in a HALT state. It
> is used in kernel for cases like reboot, idle loop and exception fixup
> handlers. For the idle case, interrupts will be enabled (using STI)
> before the HLT instruction (this is also called safe_halt()).
> 
> To support the HLT instruction in TDX guests, it needs to be emulated
> using TDVMCALL (hypercall to VMM). More details about it can be found
> in Intel Trust Domain Extensions (Intel TDX) Guest-Host-Communication
> Interface (GHCI) specification, section TDVMCALL[Instruction.HLT].
> 
> In TDX guests, executing HLT instruction will generate a #VE, which is
> used to emulate the HLT instruction. But #VE based emulation will not
> work for the safe_halt() flavor, because it requires STI instruction to
> be executed just before the TDCALL. Since idle loop is the only user of
> safe_halt() variant, handle it as a special case.
> 
> To avoid *safe_halt() call in the idle function, define the
> tdx_guest_idle() and use it to override the "x86_idle" function pointer
> for a valid TDX guest.
> 
> Alternative choices like PV ops have been considered for adding
> safe_halt() support. But it was rejected because HLT paravirt calls
> only exist under PARAVIRT_XXL, and enabling it in TDX guest just for
> safe_halt() use case is not worth the cost.

Thanks for all the history and background here.

> diff --git a/arch/x86/coco/tdcall.S b/arch/x86/coco/tdcall.S
> index c4dd9468e7d9..3c35a056974d 100644
> --- a/arch/x86/coco/tdcall.S
> +++ b/arch/x86/coco/tdcall.S
> @@ -138,6 +138,19 @@ SYM_FUNC_START(__tdx_hypercall)
>  
>  	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>  
> +	/*
> +	 * For the idle loop STI needs to be called directly before the TDCALL
> +	 * that enters idle (EXIT_REASON_HLT case). STI instruction enables
> +	 * interrupts only one instruction later. If there is a window between
> +	 * STI and the instruction that emulates the HALT state, there is a
> +	 * chance for interrupts to happen in this window, which can delay the
> +	 * HLT operation indefinitely. Since this is the not the desired
> +	 * result, conditionally call STI before TDCALL.
> +	 */
> +	testq $TDX_HCALL_ISSUE_STI, %rsi
> +	jz .Lskip_sti
> +	sti
> +.Lskip_sti:
>  	tdcall
>  
>  	/*
> diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
> index 86a2f35e7308..0a2e6be0cdae 100644
> --- a/arch/x86/coco/tdx.c
> +++ b/arch/x86/coco/tdx.c
> @@ -7,6 +7,7 @@
>  #include <linux/cpufeature.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
> +#include <asm/vmx.h>
>  
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
> @@ -59,6 +60,62 @@ static void get_info(void)
>  	td_info.attributes = out.rdx;
>  }
>  
> +static u64 __cpuidle __halt(const bool irq_disabled, const bool do_sti)
> +{
> +	struct tdx_hypercall_args args = {
> +		.r10 = TDX_HYPERCALL_STANDARD,
> +		.r11 = EXIT_REASON_HLT,
> +		.r12 = irq_disabled,
> +	};
> +
> +	/*
> +	 * Emulate HLT operation via hypercall. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), section 3.8 TDG.VP.VMCALL<Instruction.HLT>.
> +	 *
> +	 * The VMM uses the "IRQ disabled" param to understand IRQ
> +	 * enabled status (RFLAGS.IF) of the TD guest and to determine
> +	 * whether or not it should schedule the halted vCPU if an
> +	 * IRQ becomes pending. E.g. if IRQs are disabled, the VMM
> +	 * can keep the vCPU in virtual HLT, even if an IRQ is
> +	 * pending, without hanging/breaking the guest.
> +	 */
> +	return __tdx_hypercall(&args, do_sti ? TDX_HCALL_ISSUE_STI : 0);
> +}
> +
> +static bool handle_halt(void)
> +{
> +	/*
> +	 * Since non safe halt is mainly used in CPU offlining
> +	 * and the guest will always stay in the halt state, don't
> +	 * call the STI instruction (set do_sti as false).
> +	 */
> +	const bool irq_disabled = irqs_disabled();
> +	const bool do_sti = false;
> +
> +	if (__halt(irq_disabled, do_sti))
> +		return false;
> +
> +	return true;
> +}

One other note: I really do like the silly:

	const bool do_sti = false;

variables as opposed to doing gunk like:

	__halt(irq_disabled, false));

Thanks for doing that.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
