Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2235350DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiEZOjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347772AbiEZOjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E35DE309
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653575914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+1HACeQnvMjyjM9LidVlSlz5PsFXjtWLItm3vLo09A=;
        b=K+9G1BFvES79AeIt5j1uO2jaQ8w9fFO7LdiSgzHL/Rc79seEoY6KeYqDhzoAJPrKAGFEXN
        gu0/hOg5vMABjR4CSP4PrHahPK9Ij6vCYJLP+tM77brv/lIg5XOB0ULVMrUMCsVp1unmiD
        w/GpJHJDqSp6bKb3Crh2BM/MKVQepcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-0mJejaKpMDqPHb3HJ4ZTOQ-1; Thu, 26 May 2022 10:38:31 -0400
X-MC-Unique: 0mJejaKpMDqPHb3HJ4ZTOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21A3396622C;
        Thu, 26 May 2022 14:38:30 +0000 (UTC)
Received: from fedora (unknown [10.22.16.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8CB9663F54;
        Thu, 26 May 2022 14:38:26 +0000 (UTC)
Date:   Thu, 26 May 2022 11:38:25 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/5] x86/mm: Make tdx_enc_status_changed() vmalloc
 address compatible
Message-ID: <Yo+Q4SWkQiURJFEM@fedora>
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220524040517.703581-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524040517.703581-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 09:05:15PM -0700, Kuppuswamy Sathyanarayanan wrote:
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
> -- 
> 2.25.1
> 
> 

Acked-by: Wander Lairson Costa <wander@redhat.com>

