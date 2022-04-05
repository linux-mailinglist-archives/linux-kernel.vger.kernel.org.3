Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6384F23DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiDEHBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiDEHBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:01:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE411161;
        Mon,  4 Apr 2022 23:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C73F615C3;
        Tue,  5 Apr 2022 06:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378FFC340F3;
        Tue,  5 Apr 2022 06:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141987;
        bh=U1fBPraKIzHhHhMLi/mA9d/aAmGzp3FblwWY7spBafs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqAaPLD0XM/guXZR7OEYhglnKBNyW2td4Hq9pGIrSCBocWVqzxZIpBvWnScSHXLyN
         onZrpYKYShgPh0in7/6+zyUsbAkUyqOZNfGl993Uvkws7mf5TlKLdDetaEqjKqcJa9
         sODuhg98ZNeUYQj5m+sJpLmeXFnOaItIHrlaWVYYA2ht7txHy+W2ctMLt4b6qYLiIo
         awx/MDbVZxKgDm/xuYNFnOH+uPKBp8+Cop7TMJDh1jy9xxBIBCvSU/bEjW5WLjTqOO
         tCZojHgCfAhuMbDoXIJUAEtbYfqLNU/kzNKcsiFBxtGa4Ys7NeKNmWhqDwoIBep8xg
         qLtipnEVKyx/Q==
Date:   Tue, 5 Apr 2022 10:00:58 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 11/30] x86/sgx: Keep record of SGX page type
Message-ID: <YkvpKoACFDtyHpzE@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <ddd25a12cc1d593f6560fa1cbc4c8018cb04a4ae.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd25a12cc1d593f6560fa1cbc4c8018cb04a4ae.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:19AM -0700, Reinette Chatre wrote:
> SGX2 functions are not allowed on all page types. For example,
> ENCLS[EMODPR] is only allowed on regular SGX enclave pages and
> ENCLS[EMODPT] is only allowed on TCS and regular pages. If these
> functions are attempted on another type of page the hardware would
> trigger a fault.
> 
> Keep a record of the SGX page type so that there is more
> certainty whether an SGX2 instruction can succeed and faults
> can be treated as real failures.
> 
> The page type is a property of struct sgx_encl_page
> and thus does not cover the VA page type. VA pages are maintained
> in separate structures and their type can be determined in
> a different way. The SGX2 instructions needing the page type do not
> operate on VA pages and this is thus not a scenario needing to
> be covered at this time.
> 
> struct sgx_encl_page hosting this information is maintained for each
> enclave page so the space consumed by the struct is important.
> The existing sgx_encl_page->vm_max_prot_bits is already unsigned long
> while only using three bits. Transition to a bitfield for the two
> members to support the additional information without increasing
> the space consumed by the struct.
> 
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - Update changelog to motivate transition to bitfield that
>   was previously done when (now removed) vm_run_prot_bits was
>   added.
> 
> Changes since V1:
> - Add Acked-by from Jarkko.
> 
>  arch/x86/include/asm/sgx.h      | 3 +++
>  arch/x86/kernel/cpu/sgx/encl.h  | 3 ++-
>  arch/x86/kernel/cpu/sgx/ioctl.c | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index d67810b50a81..eae20fa52b93 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -239,6 +239,9 @@ struct sgx_pageinfo {
>   * %SGX_PAGE_TYPE_REG:	a regular page
>   * %SGX_PAGE_TYPE_VA:	a VA page
>   * %SGX_PAGE_TYPE_TRIM:	a page in trimmed state
> + *
> + * Make sure when making changes to this enum that its values can still fit
> + * in the bitfield within &struct sgx_encl_page
>   */
>  enum sgx_page_type {
>  	SGX_PAGE_TYPE_SECS,
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index 1b15d22f6757..07abfc70c8e3 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -27,7 +27,8 @@
>  
>  struct sgx_encl_page {
>  	unsigned long desc;
> -	unsigned long vm_max_prot_bits;
> +	unsigned long vm_max_prot_bits:8;
> +	enum sgx_page_type type:16;
>  	struct sgx_epc_page *epc_page;
>  	struct sgx_encl *encl;
>  	struct sgx_va_page *va_page;
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index f487549bccba..0c211af8e948 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -107,6 +107,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
>  		set_bit(SGX_ENCL_DEBUG, &encl->flags);
>  
>  	encl->secs.encl = encl;
> +	encl->secs.type = SGX_PAGE_TYPE_SECS;
>  	encl->base = secs->base;
>  	encl->size = secs->size;
>  	encl->attributes = secs->attributes;
> @@ -344,6 +345,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
>  	 */
>  	encl_page->encl = encl;
>  	encl_page->epc_page = epc_page;
> +	encl_page->type = (secinfo->flags & SGX_SECINFO_PAGE_TYPE_MASK) >> 8;
>  	encl->secs_child_cnt++;
>  
>  	if (flags & SGX_PAGE_MEASURE) {
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
