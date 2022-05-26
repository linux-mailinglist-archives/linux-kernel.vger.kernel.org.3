Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056015350E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbiEZOjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347685AbiEZOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C127ECEBB9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653575948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ml+pRF/A/MpBrIvAqGV2py687V13DhTfdNhix+Imz6s=;
        b=GNTT/nCCWgCuPVNf1iLs0n/xhs2UvWRXAP3u7EzuHHmGIt2D/ede6VvTbWMb3GTvU0EVkL
        u+bSWIvwy52IWO9ICs0Ra4pMH/87B+C7xukiSCydnTRcx8guMfnxfEB24UqkhEuYSJZqcu
        vRh/90iWyhWRSF9+HhYcfModfr1N2I4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-TK7Fj8qpMgi-tpJwKQW5FA-1; Thu, 26 May 2022 10:39:04 -0400
X-MC-Unique: TK7Fj8qpMgi-tpJwKQW5FA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A13EE966222;
        Thu, 26 May 2022 14:39:03 +0000 (UTC)
Received: from fedora (unknown [10.22.16.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id 70B7B1410DD5;
        Thu, 26 May 2022 14:39:00 +0000 (UTC)
Date:   Thu, 26 May 2022 11:38:59 -0300
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
Subject: Re: [PATCH v7 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
Message-ID: <Yo+RA8EZJx82xmjn@fedora>
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220524040517.703581-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524040517.703581-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 09:05:16PM -0700, Kuppuswamy Sathyanarayanan wrote:
> set_memory_*crypted() functions are used to modify the "shared" page
> attribute of the given memory. Using these APIs will modify the page
> attributes of the aliased mappings (which also includes the direct
> mapping).
> 
> But such aliased mappings modification is not desirable in use cases
> like TDX guest, where the requirement is to create the shared mapping
> without touching the direct map. It is used when allocating VMM shared
> buffers using alloc_pages()/vmap()/set_memory_*crypted() API
> combinations.
> 
> So to support such use cases, add support for noalias variants of
> set_memory_*crypted() functions.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/include/asm/set_memory.h |  2 ++
>  arch/x86/mm/pat/set_memory.c      | 26 ++++++++++++++++++++------
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
> index 78ca53512486..0e5fc2b818be 100644
> --- a/arch/x86/include/asm/set_memory.h
> +++ b/arch/x86/include/asm/set_memory.h
> @@ -46,7 +46,9 @@ int set_memory_wb(unsigned long addr, int numpages);
>  int set_memory_np(unsigned long addr, int numpages);
>  int set_memory_4k(unsigned long addr, int numpages);
>  int set_memory_encrypted(unsigned long addr, int numpages);
> +int set_memory_encrypted_noalias(unsigned long addr, int numpages);
>  int set_memory_decrypted(unsigned long addr, int numpages);
> +int set_memory_decrypted_noalias(unsigned long addr, int numpages);
>  int set_memory_np_noalias(unsigned long addr, int numpages);
>  int set_memory_nonglobal(unsigned long addr, int numpages);
>  int set_memory_global(unsigned long addr, int numpages);
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 0656db33574d..4475f6e3bebb 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -1976,7 +1976,8 @@ int set_memory_global(unsigned long addr, int numpages)
>   * __set_memory_enc_pgtable() is used for the hypervisors that get
>   * informed about "encryption" status via page tables.
>   */
> -static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
> +static int __set_memory_enc_pgtable(unsigned long addr, int numpages,
> +		bool enc, int checkalias)
>  {
>  	pgprot_t empty = __pgprot(0);
>  	struct cpa_data cpa;
> @@ -2004,7 +2005,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	/* Notify hypervisor that we are about to set/clr encryption attribute. */
>  	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
>  
> -	ret = __change_page_attr_set_clr(&cpa, 1);
> +	ret = __change_page_attr_set_clr(&cpa, checkalias);
>  
>  	/*
>  	 * After changing the encryption attribute, we need to flush TLBs again
> @@ -2024,29 +2025,42 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	return ret;
>  }
>  
> -static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> +static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc,
> +		int checkalias)
>  {
>  	if (hv_is_isolation_supported())
>  		return hv_set_mem_host_visibility(addr, numpages, !enc);
>  
>  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> -		return __set_memory_enc_pgtable(addr, numpages, enc);
> +		return __set_memory_enc_pgtable(addr, numpages, enc, checkalias);
>  
>  	return 0;
>  }
>  
>  int set_memory_encrypted(unsigned long addr, int numpages)
>  {
> -	return __set_memory_enc_dec(addr, numpages, true);
> +	return __set_memory_enc_dec(addr, numpages, true, 1);
>  }
>  EXPORT_SYMBOL_GPL(set_memory_encrypted);
>  
>  int set_memory_decrypted(unsigned long addr, int numpages)
>  {
> -	return __set_memory_enc_dec(addr, numpages, false);
> +	return __set_memory_enc_dec(addr, numpages, false, 1);
>  }
>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
>  
> +int set_memory_encrypted_noalias(unsigned long addr, int numpages)
> +{
> +	return __set_memory_enc_dec(addr, numpages, true, 0);
> +}
> +EXPORT_SYMBOL_GPL(set_memory_encrypted_noalias);
> +
> +int set_memory_decrypted_noalias(unsigned long addr, int numpages)
> +{
> +	return __set_memory_enc_dec(addr, numpages, false, 0);
> +}
> +EXPORT_SYMBOL_GPL(set_memory_decrypted_noalias);
> +
>  int set_pages_uc(struct page *page, int numpages)
>  {
>  	unsigned long addr = (unsigned long)page_address(page);
> -- 
> 2.25.1
> 
> 

Acked-by: Wander Lairson Costa <wander@redhat.com>

