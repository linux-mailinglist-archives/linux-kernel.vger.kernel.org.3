Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB54C3416
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiBXRy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiBXRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:54:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90974275795
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645725262; x=1677261262;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=tYEwnjk4lBYRrx5EhWLikwGdOyioL/Al5KgYOVvpgpU=;
  b=fgxmfAh+bt2SkmPzdpUfxDuMcAJlUdnpKdVK0vIAYfajVlf+EgaKkbq+
   9vhnKZTTinE8jfTRq/vbOi21i1IJ18Eybwk/nitWAMIQcFiEvxJVcvGvl
   +lNTIDrTkPOa+wD12e56IOhzjXhMu8YS7TYBE7oDvsdHwdIoHGZ3xMSUL
   84tFcEGYqx7kBvEeDaeL+KjWKPD2YmmadRow/6RbxVdN4cVRDIrE00n//
   GTkRS8UWwmJPFtnG6nG60K5rY/6/OCxZHZqa+qEWFIdcU8xE8gxssWXi0
   yhyTmeiWcfWXieRoSZICZFxSecIIhH6f6v1nMKtym/B3+obTp5wbSGjSF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="338740426"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="338740426"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 09:54:22 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548858675"
Received: from vpirogov-mobl.amr.corp.intel.com (HELO [10.252.137.68]) ([10.252.137.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 09:54:21 -0800
Message-ID: <d51dc9c2-61e5-c8dd-e358-e4ab3d5429ac@intel.com>
Date:   Thu, 24 Feb 2022 09:54:16 -0800
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
 <20220224155630.52734-6-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 05/30] x86/tdx: Extend the confidential computing API to
 support TDX guests
In-Reply-To: <20220224155630.52734-6-kirill.shutemov@linux.intel.com>
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

> +/* TDX module Call Leaf IDs */
> +#define TDX_GET_INFO			1
> +
> +static struct {
> +	unsigned int gpa_width;
> +	unsigned long attributes;
> +} td_info __ro_after_init;

This defines part of an ABI (TDX_GET_INFO) and then a structure right
next to it which is not part of the ABI.  That's really confusing.

It's further muddied by "attributes" being unused in this patch.  Why
bother declaring it and assigning a value to it that won't be used?  Why
even *have* a structure for a single value?

>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>   * return code.
> @@ -25,6 +34,30 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>  	return __tdx_hypercall(&args, 0);
>  }
>  
> +static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
> +				   struct tdx_module_output *out)
> +{
> +	if (__tdx_module_call(fn, rcx, rdx, r8, r9, out))
> +		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
> +}
> +
> +static void get_info(void)
> +{
> +	struct tdx_module_output out;
> +
> +	/*
> +	 * TDINFO TDX module call is used to get the TD execution environment
> +	 * information like GPA width, number of available vcpus, debug mode
> +	 * information, etc. More details about the ABI can be found in TDX
> +	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
> +	 * [TDG.VP.INFO].
> +	 */
> +	tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
> +
> +	td_info.gpa_width = out.rcx & GENMASK(5, 0);
> +	td_info.attributes = out.rdx;
> +}

This left me wondering two things.  First, why this bothers storing
'gpa_width' when it's only used to generate a mask?  Why not just store
the mask in the structure?

Second, why have the global 'td_info' instead of just declaring it on
the stack.  It is only used within a single function.  Having it on the
stack is *REALLY* nice because the code ends up looking like:

	struct foo foo;
	get_info(&foo);
	cc_set_bar(foo.bar);

The dependencies and scope are just stupidly obvious if you do that.

>  void __init tdx_early_init(void)
>  {
>  	u32 eax, sig[3];
> @@ -37,5 +70,15 @@ void __init tdx_early_init(void)
>  
>  	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>  
> +	get_info();
> +
> +	cc_set_vendor(CC_VENDOR_INTEL);
> +
> +	/*
> +	 * The highest bit of a guest physical address is the "sharing" bit.
> +	 * Set it for shared pages and clear it for private pages.
> +	 */
> +	cc_set_mask(BIT_ULL(td_info.gpa_width - 1));
> +
>  	pr_info("Guest detected\n");
>  }
I really want to start acking these things and get them moved along to
the next step.  There are a few too many open questions, though.
