Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3854D10B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346427AbiFOSiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:38:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFE2B24E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655318333; x=1686854333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=42G8vZDc4ZHYS75nOGwaWESZ7FvKXE+QO9Erz/QcALA=;
  b=E5ckm/JsL9Fv6ylE9OjGR7LBM2Z/Vi28UfZ8UoJFz9qBlq8ASHwSxbus
   aWsIaHRBQUJ184LJRVE8Gci2xaPfoURG47PeMBtuHMaEgSXwzYDuBOH3N
   G1jQ+WIU5diLrevDDrM2OqdIWcmpVZH26pYnCZKHypH+j0gTnoBfhRMDf
   BVpdjH2Ea5cVdfIZvfl9pYCs6CJm5AHgg/YPGG6iZqTjemcX/FvZkMsAE
   +eo6IOSXlDzC8YyohQ1DrpO3jcniu+K8SoZNm1c3MbzOwgjkjutPVQ6Zl
   8Jl5lJiwt/HdPjhkJlS81gD1EWOqf1LQ+jsUAEgN1keAIu+oskduvDd2c
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280102116"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="280102116"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 11:12:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="559273984"
Received: from mjortiz-mobl.amr.corp.intel.com (HELO [10.212.185.241]) ([10.212.185.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 11:12:35 -0700
Message-ID: <2a6e0dbb-89e3-9735-de20-132992d699b4@intel.com>
Date:   Wed, 15 Jun 2022 11:12:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross
 to a shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 05:01, Kirill A. Shutemov wrote:
> load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
> 
> In TDX guests, the second page can be shared page and VMM may configure
> it to trigger #VE.
> 
> Kernel assumes that #VE on a shared page is MMIO access and tries to
> decode instruction to handle it. In case of load_unaligned_zeropad() it
> may result in confusion as it is not MMIO access.
> 
> Fix it by detecting split page MMIO accesses and fail them.
> load_unaligned_zeropad() will recover using exception fixups.
> 
> The issue was discovered by analysis. It was not triggered during the
> testing.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 7d6d484a6d28..3bcaf2170ede 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -333,8 +333,8 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
>  
>  static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  {
> +	unsigned long *reg, val, vaddr;
>  	char buffer[MAX_INSN_SIZE];
> -	unsigned long *reg, val;
>  	struct insn insn = {};
>  	enum mmio_type mmio;
>  	int size, extend_size;
> @@ -360,6 +360,19 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  			return -EINVAL;
>  	}
>  
> +	/*
> +	 * Reject EPT violation #VEs that split pages.
> +	 *
> +	 * MMIO accesses suppose to be naturally aligned and therefore never
> +	 * cross a page boundary. Seeing split page accesses indicates a bug
> +	 * or load_unaligned_zeropad() that steps into unmapped shared page.

Isn't this "unmapped" thing a rather superfluous implementation detail?

For the guest, it just needs to know that it *CAN* #VE on access to MMIO
and that it needs to be prepared.  The fact that MMIO is implemented
with TDX shared memory *AND* that "unmapped shared pages" can cause
#VE's seems like too much detail.

Also, is this all precise?  Are literal unmapped shared pages the *ONLY*
thing that a hypervisor can do do case a #VE?  What about, say, reserved
bits being set in a shared EPT entry?

I was thinking a comment like this might be better:

>         /*
>          * Reject EPT violation #VEs that split pages.
>          *
>          * MMIO accesses are supposed to be naturally aligned and therefore
>          * never cross page boundaries. Seeing split page accesses indicates
>          * a bug or a load_unaligned_zeropad() that stepped into an MMIO page.
>          *
>          * load_unaligned_zeropad() will recover using exception fixups.
>          */


