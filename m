Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B8B4C3547
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiBXTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiBXTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:04:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA14A1E017D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645729450; x=1677265450;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=cia5oKJxlQnNWcyfcLJl3PXOjDFqv+fRs+nhPfQzUzs=;
  b=bhvBpWkgDoU/8DrgmU2pmaNGFxGu4MDjhqgBBmtPz+qze63oI9+WG9rK
   y2M8CTRetnBaIbqvZjfZolbYvCjdt2QUk3yAwyyhQibi2wQ+9SIX1uBUb
   aLAb45el28xZZTdqwMzp63kf1fZC9F3CFRNUufFSONJoPjcvn5VqzJajf
   hcGpNfpoe4d7W7F7pCV1E75KIoF+MlKXgwvxq6nuvuKTfzXR6qA5gpNBs
   WRO7NvKAoihu9YVcwjT7elTy1o/PvyhG08xfoWz+u/BXFAxuX5/fD9Wtg
   WfgSN0pIqi4gBSlVCrB50RBknconvYA9lLVJgNdpv9r1gLqLIlBaPv9uR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239725205"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="239725205"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 11:04:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548895003"
Received: from vpirogov-mobl.amr.corp.intel.com (HELO [10.252.137.68]) ([10.252.137.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 11:04:09 -0800
Message-ID: <51b6613d-eabd-941d-19b2-95b33ec27e99@intel.com>
Date:   Thu, 24 Feb 2022 11:04:04 -0800
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
 <20220224155630.52734-11-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 10/30] x86/tdx: Handle CPUID via #VE
In-Reply-To: <20220224155630.52734-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
>  static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
>  {
> -	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> -	return false;
> +	switch (ve->exit_reason) {
> +	case EXIT_REASON_CPUID:
> +		return handle_cpuid(regs);
> +	default:
> +		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> +		return false;
> +	}
>  }

What does this mean for userspace?  What kinds of things are we ceding
to the (untrusted) VMM to supply to userspace?

>  /* Handle the kernel #VE */
> @@ -200,6 +235,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
>  		return read_msr(regs);
>  	case EXIT_REASON_MSR_WRITE:
>  		return write_msr(regs);
> +	case EXIT_REASON_CPUID:
> +		return handle_cpuid(regs);
>  	default:
>  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>  		return false;
What kinds of random CPUID uses in the kernel at runtime need this
handling?  Is it really OK that we let the VMM inject arbitrary CPUID
values into random CPUID uses in the kernel... silently?

Is this better than just returning 0's, for instance?
