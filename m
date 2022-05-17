Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4535752A83D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351013AbiEQQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351072AbiEQQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:36:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E7CE1B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652805365; x=1684341365;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C2Z0RiuXriPADgGLLBzT0TeztOBn4bNSdseruseNy80=;
  b=HCIw3dA6ldATu9E+/btWKGsgIWZS7Af96zuymmtuuwJZg5hPjdd2AoCx
   m35PNqOzAJhbYsQ7rVCWMSSDGbMJ73GHjCFPIpAqlLw1GwXw3v7u+ZGci
   x9LCuixPyhmaysEUElwXm8CxXMAfUVRsf4HdpKyJWxjM1Sp484Qdmw3H/
   YuUlacXYxHyPJmsau62B2u9OPSmLb1UYG636r9FIAGEPzCZOvsRVYwsaJ
   pdTr00pQmnVwX4CVZy9lpiFvFNUJpvTq37YFZ9S3pOOwoXpCaqvZZ5iYT
   4NghWJ1pewX9+H5dwK2edK2TwJGqQxwh6bvObhLnHfGxgzeT1l4bmO4vE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="296525672"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="296525672"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:36:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="672931173"
Received: from danielga-mobl.amr.corp.intel.com (HELO [10.212.245.96]) ([10.212.245.96])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:36:03 -0700
Message-ID: <e73cb19e-7dab-2fc1-b947-fac70fd607d2@intel.com>
Date:   Tue, 17 May 2022 09:36:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/tdx: Handle load_unaligned_zeropad() page-cross to a
 shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220517153021.11116-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 08:30, Kirill A. Shutemov wrote:
> load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
> 
> In TDX guest the second page can be shared page and VMM may configure it
> to trigger #VE.
> 
> Kernel assumes that #VE on a shared page is MMIO access and tries to
> decode instruction to handle it. In case of load_unaligned_zeropad() it
> may result in confusion as it is not MMIO access.
> 
> Check fixup table before trying to handle MMIO.

Is this a theoretical problem or was it found in practice?

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 03deb4d6920d..5fbdda2f2b86 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -11,6 +11,8 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/pgtable.h>
> +#include <asm/trapnr.h>
> +#include <asm/extable.h>
>  
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
> @@ -296,6 +298,26 @@ static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	if (WARN_ON_ONCE(user_mode(regs)))
>  		return false;
>  
> +	/*
> +	 * load_unaligned_zeropad() relies on exception fixups in case of the
> +	 * word being a page-crosser and the second page is not accessible.
> +	 *
> +	 * In TDX guest the second page can be shared page and VMM may

	In TDX guests,

> +	 * configure it to trigger #VE.
> +	 *
> +	 * Kernel assumes that #VE on a shared page is MMIO access and tries to
> +	 * decode instruction to handle it. In case of load_unaligned_zeropad()
> +	 * it may result in confusion as it is not MMIO access.
> +	 *
> +	 * Check fixup table before trying to handle MMIO.
> +	 */
> +	if (fixup_exception(regs, X86_TRAP_VE, 0, ve->gla)) {
> +		/* regs->ip is adjusted by fixup_exception() */
> +		ve->instr_len = 0;
> +
> +		return true;
> +	}

This 've->instr_len = ' stuff is just a hack.

ve_info is a software structure.  Why not just add a:

	bool ip_adjusted;

which defaults to false, then we have:

	/*
	 * Adjust RIP if the exception was handled
	 * but RIP was not adjusted.
	 */
	if (!ret && !ve_info->ip_adjusted)
		regs->ip += ve_info->instr_len;

One other oddity I just stumbled upon:

static bool handle_mmio(struct pt_regs *regs, struct ve_info *ve)
{
...
        ve->instr_len = insn.length;

Why does that need to override 've->instr_len'?  What was wrong with the
gunk in r10 that came out of TDX_GET_VEINFO?
