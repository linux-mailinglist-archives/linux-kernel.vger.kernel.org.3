Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2039E4D2214
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349848AbiCHT6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244501AbiCHT57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:57:59 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18BD37A14
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646769421; x=1678305421;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=aZEUJmSSAeZVOiFwyACXX/kSeEDJVemxlPb7zkMozd0=;
  b=ECJjdHbv4R2x4eYZENI2FMdiFxG3Za+eaNNJqKnyy7r/D+992VdQWUKK
   GAKIsu0Oy3QdFPI9uRR79tS9TeUZ0urZ8oUhd3kRMjK8O9QLfYbfvebp2
   /uwkxf0evqpp8D8ndlA/mYO1zomkhMaRjAEkijSAQLmJd+j+cyh+4Xcm2
   Ox4vJQ7/8s/JCd80foscxx9AHpVaN0HlwJfw2BENwpMJARqkxORoAw+Cq
   r+V/sZ0PIqY2kfWM4q0tCjxu8CX+EYy4fRyGqkxcQIYfbdtB3miU4BflL
   1kwYo5wl0NyOapXqh7/QvDkxzh8RABJBL+7NiWHYOwG94Oy5gN7/DIfLi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242241380"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="242241380"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 11:57:01 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547387096"
Received: from ntebyanx-mobl7.amr.corp.intel.com (HELO [10.212.224.65]) ([10.212.224.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 11:56:59 -0800
Message-ID: <aa8c421f-b1e1-f62b-a289-c686d69f6293@intel.com>
Date:   Tue, 8 Mar 2022 11:56:52 -0800
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
 <20220302142806.51844-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
In-Reply-To: <20220302142806.51844-3-kirill.shutemov@linux.intel.com>
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

On 3/2/22 06:27, Kirill A. Shutemov wrote:
> Secure Arbitration Mode (SEAM) is an extension of VMX architecture.  It
> defines a new VMX root operation (SEAM VMX root) and a new VMX non-root
> operation (SEAM VMX non-root) which are both isolated from the legacy
> VMX operation where the host kernel runs.
> 
> A CPU-attested software module (called 'TDX module') runs in SEAM VMX
> root to manage and protect VMs running in SEAM VMX non-root.  SEAM VMX
> root is also used to host another CPU-attested software module (called
> 'P-SEAMLDR') to load and update the TDX module.
> 
> Host kernel transits to either P-SEAMLDR or TDX module via the new
> SEAMCALL instruction, which is essentially a VMExit from VMX root mode
> to SEAM VMX root mode.  SEAMCALLs are leaf functions defined by
> P-SEAMLDR and TDX module around the new SEAMCALL instruction.
> 
> A guest kernel can also communicate with TDX module via TDCALL
> instruction.
> 
> TDCALLs and SEAMCALLs use an ABI different from the x86-64 system-v ABI.
> RAX is used to carry both the SEAMCALL leaf function number (input) and
> the completion status (output).  Additional GPRs (RCX, RDX, R8-R11) may
> be further used as both input and output operands in individual leaf.
> 
> TDCALL and SEAMCALL share the same ABI and require the largely same
> code to pass down arguments and retrieve results.
> 
> Define an assembly macro that can be used to implement C wrapper for
> both TDCALL and SEAMCALL.

It's probably also worth mentioning that the SEAMCALL half won't get
used in this series.

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index ba8042ce61c2..e5ff8ed59adf 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -8,6 +8,33 @@
>  #define TDX_CPUID_LEAF_ID	0x21
>  #define TDX_IDENT		"IntelTDX    "
>  
> +/*
> + * SW-defined error codes.
> + *
> + * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
> + * TDX module.
That's a bit clunky.  Perhaps replace it with this:

 * Bits 47:40 == 0xFF indicate a "Reserved" status code class that is
   never used by the TDX module.

> + */
> +#define TDX_ERROR			(1UL << 63)
> +#define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(40, 47))
> +#define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | 0xFFFF0000ULL)
> +
> +#ifndef __ASSEMBLY__

The "UL" construct doesn't work in the assembler.  But, this won't shoIf
you use _BITUL, it will do the hard work for you.

> +/*
> + * Used to gather the output registers values of the TDCALL and SEAMCALL
> + * instructions when requesting services from the TDX module.
> + *
> + * This is a software only structure and not part of the TDX module/VMM ABI.
> + */
> +struct tdx_module_output {
> +	u64 rcx;
> +	u64 rdx;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +};

With those fixed:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
