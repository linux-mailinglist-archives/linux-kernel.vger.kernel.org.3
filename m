Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702A64D3ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiCIUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiCIUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:08:31 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919B9DECC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646856451; x=1678392451;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=vqAgO5Hj65MNywbPhSvspwjP9xV2an55S1XITiL2rCs=;
  b=WxtvJAq4BJFBON00/prxE0O9DbGRJIc0+hLwxJgatPnEyRRf8hjUXTWn
   EPq0pCkExKlrrceyFvSghWXi4QnOCw+riu4JaV+BaInLn28qZcwp2y0dV
   gsy3zOPccYyHpDTlB7AoEysAsBHFNO9eXYbe/rWiXtXtezcCCXNIIRiBp
   HNV6jgEI8rgjFL9bJZsb+uBBOIim9NSG7ZEGMVZLblNWFJexcxJZv7hBH
   3Ctv+wEAxVhcuRO0Lf1UIYMpH/ZV9LfIKC7a8/O5bGjOl+bDiXwJIh2Xm
   avke7SWdK8aArP3XllKltn1QR5Ai4xxvBoGBxBQkK+Ef989BedDnRfazj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318304179"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="318304179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 12:07:30 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="642285288"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 12:07:29 -0800
Message-ID: <f368d524-f676-d112-5bd0-0eeba6b77ff5@intel.com>
Date:   Wed, 9 Mar 2022 12:07:22 -0800
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
 <20220302142806.51844-28-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 27/30] x86/kvm: Use bounce buffers for TD guest
In-Reply-To: <20220302142806.51844-28-kirill.shutemov@linux.intel.com>
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

On 3/2/22 06:28, Kirill A. Shutemov wrote:
> --- a/arch/x86/coco/tdx.c
> +++ b/arch/x86/coco/tdx.c
> @@ -5,6 +5,7 @@
>  #define pr_fmt(fmt)     "tdx: " fmt
>  
>  #include <linux/cpufeature.h>
> +#include <linux/swiotlb.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> @@ -627,5 +628,7 @@ void __init tdx_early_init(void)
>  	x86_platform.guest.enc_tlb_flush_required = tdx_tlb_flush_required;
>  	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
>  
> +	swiotlb_force = SWIOTLB_FORCE;
> +
>  	pr_info("Guest detected\n");
>  }

AMD currently does:

        if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
                swiotlb_force = SWIOTLB_FORCE;

which somewhat begs the question of why we can't do the

	swiotlb_force = SWIOTLB_FORCE;

thing in:

void __init mem_encrypt_init(void)
{
        if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
                return;

/// Here

I recall there being a reason for this.  But I don't see any mention in
the changelog.
