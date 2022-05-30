Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85165537966
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiE3Krx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiE3Krn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:47:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74397CB67
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653907653; x=1685443653;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   mime-version:date:content-transfer-encoding;
  bh=o5SGoknLhcf36naf8dL6NWETDY5hMeyO9OFdAjzRBRg=;
  b=IhWj4q+ATeByo99j7QWu9H1fmdUqAn6CUAgd+B5w9ox5v5B5UE1K5aIQ
   LbIOnkXfN3vzwNKrDrceOiZS3B9XHRLjlc+Uam8S0pEiJZocV6H2FXeGj
   ex5UIe7CaldQpdG0XI2LII0VxsUoKLGuNsIfQTm0f3kKg22hhejd4gqaP
   nRldWCbGN3aYwwUQ/9jQeRNaBAPYd7VkZLTSWhPbK6g71vFd768IcdakE
   dkzq4eFmRmlL7eIWhvD+Fnm346e1edcLD7oVpo3fMk9GufTTKp71VAWWK
   /lkydqE3aYNrQCCHSJBQb2kyP/MBfTJKJ7dMuFuxp27TM05Rb/+oIN5IX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="275056254"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="275056254"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 03:47:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="529128753"
Received: from machambe-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.36.179])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 03:47:27 -0700
Message-ID: <ba5aa2939e81f730396d41120aa603df7999d937.camel@intel.com>
Subject: Re: [PATCH v7 3/5] x86/mm: Make tdx_enc_status_changed() vmalloc
 address compatible
From:   Kai Huang <kai.huang@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220524040517.703581-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220524040517.703581-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 30 May 2022 22:47:15 +1200
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 21:05 -0700, Kuppuswamy Sathyanarayanan wrote:
> set_memory_*crypted() APIs are used to change encryption or decryption
> page attributes for the given address. It also by default support the
> conversion for the vmalloc'ed memory address.
> 
> In TDX Guest, tdx_enc_status_changed() function is triggered by
> set_memory_*crypted() APIs when converting memory from/to shared or
> private. Internally this function uses __pa() for physical address
> conversion, which breaks the vmalloc address compatibility of the
> set_memory_*crypted() APIs.
> 
> So add support to fix the vmalloc'ed address compatibility issue.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index b49211994864..37d58675ccf1 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -15,6 +15,7 @@
>  #include <asm/idtentry.h>
>  #include <asm/irq_regs.h>
>  #include <asm/desc.h>
> +#include <asm/io.h>
>  
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
> @@ -680,8 +681,14 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
>   */
>  static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  {
> -	phys_addr_t start = __pa(vaddr);
> -	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> +	phys_addr_t start, end;
> +
> +	if (is_vmalloc_addr((void *)vaddr))
> +		start = vmalloc_to_pfn((void *) vaddr) << PAGE_SHIFT;
> +	else
> +		start = __pa(vaddr);
> +
> +	end = start + numpages * PAGE_SIZE;
>  
>  	if (!enc) {
>  		/* Set the shared (decrypted) bits: */

AMD uses lookup_address() which doesn't require the vaddr being vmap() address.
Shouldn't TDX use the same way?

-- 
Thanks,
-Kai


