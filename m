Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E734A0425
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351780AbiA1XKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:10:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:9057 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351797AbiA1XK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643411427; x=1674947427;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=XpKab4uNQUdpvhLF1knf4E4kUDvkXGcbGb7oNXJ1OBk=;
  b=MhHhKNOHAi9WcPG5dw9sI48GtIK+M6T+kIQEWi2HuTYxpLxNbfnRfSHd
   EkbDYkM7krjdLsRFPkWy/NP5Rv8oQveiieDPPCZ+rdoB9ZEOHsVAM21sd
   oBm3aMeqBlON5qUaLGmoZTl2Eidoyfbtl2eic71CsZ2DylKFCPWT3l2NE
   TjWm1+PsIGMFl/zpPIg8gYRtsq+pWCuHtiaVBeumnodq3XLcb63Vp3w1P
   OOKY+zfq2LRwDra4FRDlgiQvMSHIBGrJ02YPkcuLfWqwvYb9wmYfAL/+J
   8q807BDeWi3UvlwM6HYKhShpUO6i6nF5U1L0xhDFVAZQH09Uqn2JYoNir
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247162500"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247162500"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:10:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697245965"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:10:25 -0800
Message-ID: <01a47dd8-4717-7b07-39ad-45fee1f78311@intel.com>
Date:   Fri, 28 Jan 2022 15:10:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-9-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 08/44] x86/fault: Adjust WARN_ON for PKey fault
In-Reply-To: <20220127175505.851391-9-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Previously if a Protection key fault occurred it indicated something
> very wrong because user page mappings are not supposed to be in the
> kernel address space.

This is missing a key point.  The problem is PK faults on "*kernel*
addresses.

> Now PKey faults may happen on kernel mappings if the feature is enabled.

One nit: I've been using "pkeys" and "pkey" as the terms.  I usually
don't capitalize them except at the beginning of a sentence.

> If PKS is enabled, avoid the warning in the fault path.
> 
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  arch/x86/mm/fault.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index d0074c6ed31a..6ed91b632eac 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1148,11 +1148,15 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
>  		   unsigned long address)
>  {
>  	/*
> -	 * Protection keys exceptions only happen on user pages.  We
> -	 * have no user pages in the kernel portion of the address
> -	 * space, so do not expect them here.
> +	 * X86_PF_PK (Protection key exceptions) may occur on kernel addresses
> +	 * when PKS (PKeys Supervisor) is enabled.
> +	 *
> +	 * However, if PKS is not enabled WARN if this exception is seen
> +	 * because there are no user pages in the kernel portion of the address
> +	 * space.
>  	 */
> -	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
> +	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
> +		     (hw_error_code & X86_PF_PK));
>  
>  #ifdef CONFIG_X86_32
>  	/*

I'm wondering if this warning is even doing us any good.  I'm pretty
sure it's never triggered on me at least.  Either way, let's not get too
carried away with the comment.  I think this should do:

	/*
	 * PF_PF faults should only occur on kernel
	 * addresses when supervisor pkeys are enabled.
	 */
