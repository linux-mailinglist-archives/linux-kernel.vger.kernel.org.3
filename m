Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A684D38EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiCIShe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiCIShc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:37:32 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D468D16F973
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646850993; x=1678386993;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=kmooId2x6uppul63Zqn9+EU+OKkrfGfyhz8W09C9Vns=;
  b=X5pYbpGNVP2LZuUU+rEfvTPSDxW7ccdgneL2JB559uOh0a8pT2YtahsZ
   ragEevXmdJXSwmArtoZKPwCDwSrFX8tcQAPEJtIKHv3AIUuT59q/XhErr
   +1aGV7TeaZbkkfHQx1n2OuN6TlvErYARwBF63QBuMzleOzBKArMp+OUtO
   yb1X39R3fwNKT5/NlyuqSpGFxdzoNAVDtVdGI/2YFPp+18EMkNXp4crvw
   JeCjOgdHjuPvx4dKtb+z+VJz/VW71/cXFMGCFHQ6zGd72IFQJ9gqI3Yam
   JSdzRy9OMpJYG3hec7HpEePNp7YGuRHubsIgDzwzYD+KPEx/zbpDLYWA8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="341488844"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="341488844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 10:36:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="642257354"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 10:36:32 -0800
Message-ID: <79432a51-4d26-1fcb-81f2-6a9e7a44706f@intel.com>
Date:   Wed, 9 Mar 2022 10:36:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     aarcange@redhat.com, ak@linux.intel.com, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
References: <e39f4ae8-b75d-6b84-1971-d9e27199877e@intel.com>
 <20220309160139.22831-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5.1 04/30] x86/tdx: Extend the confidential computing API
 to support TDX guests
In-Reply-To: <20220309160139.22831-1-kirill.shutemov@linux.intel.com>
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

On 3/9/22 08:01, Kirill A. Shutemov wrote:
> +/*
> + * Wrapper for __tdx_module_call() for cases when the call doesn't suppose to
> + * fail. Panic if the call fails.
> + */
> +static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
> +				   struct tdx_module_output *out)
> +{
> +	if (__tdx_module_call(fn, rcx, rdx, r8, r9, out))
> +		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
> +}

That comment didn't do much for me.  I know it's a wrapper.  I know it
panics() if the call returns a failure.  That's what the code *does*.  I
want a comment to tell me *why* it does that.

I _think_ I may have been getting this confused with the TDVMCALL mechanism.

All TDVMCALLs that return with rax==0 are fatal, we jump right to a ud2
instruction.  A __tdx_module_call() (via TDCALL) with rax==0 doesn't
*have* to be fatal.  But, this establishes a policy that all TDCALLs via
tdx_module_call() *ARE* fatal.

How about this for a comment?

/*
 * Used for TDX guests to make calls directly to the TD module.  This
 * should only be used for calls that have no legitimate reason to fail
 * or where the kernel can not survive the call failing.
 */

That tells me a *LOT*: This is a guest -> TD module thing.  Not a host
thing, not a hypercall.  And, no the naming isn't good enough to tell me
that.  Also, it give me advice.  It tells me when I should use this
function.  If it look at the call site, it even makes sense.  A guest
can't even build a sane PTE without this call succeeding.  If *COURSE*
we panic() if the call fails.

You could even call this information out in the comment in get_info():


...
	 * The GPA width that comes out of this call is critical.  TDX
	 * guests can not meaningfully run without it.
	 */


Then it all kinda fits together.  Oh, this panic() is awfully harsh.
Oh, it's only supposed to be used for important things that the guest
really needs.  Then there's a comment about why it needs it so badly.

Otherwise the panic() just looks superfluous and mean.
