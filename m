Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703434BC189
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbiBRVHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:07:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBRVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:07:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB1D10FD3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645218439; x=1676754439;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ky/sFQgO7G6Nqidx2wlMpJdnhLfeu8rxJY8dSggBnjY=;
  b=lc486d1Wnx/de476iln/+sDYX/k4OHk3lMf02TUZBaG9uHCM+ZNrJoqq
   YkYUoEeiA0Aks54LX65Cqha5SCdHD10KWhnfeflSFX+QrHHof/sRoFHfN
   hCHkg+7wsWWPZXpuoooq0m82022STcCTw5cVZr89I3ABJHL2jIIZ/Krj6
   +EVuMzhzdaOP2CBvFA+DMLs42M0XRhTf/CgHzfgmN3xaAKTFtB8o9hAKD
   TeoTioqlPtx04VpEAworo0hliC2tBqmj7fJz8JFVYdd8l+awIN+oivkVF
   yGHUJWOlGiW+sa9yd2vALYgIAHnfkx5yyxazzJzRii2cN3698NREB30if
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="275807313"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="275807313"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:07:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="682613294"
Received: from jabonill-mobl1.amr.corp.intel.com (HELO [10.251.27.55]) ([10.251.27.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 13:07:17 -0800
Message-ID: <5252a906-41e7-ec92-3b99-4a8d5cff4f0f@intel.com>
Date:   Fri, 18 Feb 2022 13:07:11 -0800
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
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-4-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv3 03/32] x86/tdx: Detect running as a TDX guest in early
 boot
In-Reply-To: <20220218161718.67148-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 08:16, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> cc_platform_has() API is used in the kernel to enable confidential
> computing features. Since TDX guest is a confidential computing
> platform, it also needs to use this API.

I'm struggling to connect the relevance of this paragraph to the patch
below.

I went through the whole series and I don't see any modifications to
cc_platform_has() or checks for X86_FEATURE_TDX_GUEST that seem like
they influence cc_platform_has().

What the heck am I missing?

> In preparation of extending cc_platform_has() API to support TDX guest,
> use CPUID instruction to detect support for TDX guests in the early
> boot code (via tdx_early_init()). Since copy_bootdata() is the first
> user of cc_platform_has() API, detect the TDX guest status before it.

This is good.  It tells us *why* it is initialized in that location.

> Since cc_plaform_has() API will be used frequently across the boot
> code, instead of repeatedly detecting the TDX guest status using the
> CPUID instruction, detect once and cache the result.

Isn't this a remnant of an old implementation where there was a separate
'tdx_enabled' variable in addition to X86_FEATURE_TDX_GUEST?

Does this "caching" refer to X86_FEATURE_TDX_GUEST or the old thing?

> Define a synthetic feature flag (X86_FEATURE_TDX_GUEST) and set this
> bit in a valid TDX guest platform.


> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 391c4cac8958..ea4190c53db6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -880,6 +880,18 @@ config ACRN_GUEST
>  	  IOT with small footprint and real-time features. More details can be
>  	  found in https://projectacrn.org/.
>  
> +config INTEL_TDX_GUEST
> +	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
> +	depends on X86_64 && CPU_SUP_INTEL
> +	depends on X86_X2APIC
> +	help
> +	  Support running as a guest under Intel TDX.  Without this support,
> +	  the guest kernel can not boot or run under TDX.
> +	  TDX includes memory encryption and integrity capabilities
> +	  which protect the confidentiality and integrity of guest
> +	  memory contents and CPU state. TDX guests are protected from
> +	  potential attacks from the VMM.

Nit: I don't think "potential" is the right word there.  "some" might
work better.
