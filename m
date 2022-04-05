Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB18B4F23DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiDEHB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiDEHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:01:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C651114F;
        Mon,  4 Apr 2022 23:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6176FB81B9C;
        Tue,  5 Apr 2022 06:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99179C340F3;
        Tue,  5 Apr 2022 06:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141962;
        bh=xdVJ6MiXCgUiEDCXuJS72oLZgMu5JCOWRp9+umyL0uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSbkt/OXAYEqSJcfWBHF4OruvmTbnAXCwNtFMU1yg3WxHRfgswlJRySII9Gk3j/rp
         aCNv/vPfGeqn0c9ynhPdFQjruPEOKgr4Jnwsgh9GoRPU8lbWDE4QsdZVpzdgvZVie6
         mvaMYYkoSaT83zmqvF+/No3egqGbuCPC1Qnx6e+o50D6ikcaHkzkGDeGt9ucnesPAT
         LfQcHtQCTU4CK5bRJn79Jkhfh9cJtyNbuewkIrvcmVu15xNy8bvhyTxjYGxZDGtkuO
         Qj8BSidcJsU9E+dQAkztk5q1jLUUZ2EHgpYWsqn4JxeV0KrOexDu++1q/v+47MV+yc
         TWTpAufKiInXw==
Date:   Tue, 5 Apr 2022 10:00:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 10/30] x86/sgx: Create utility to validate user
 provided offset and length
Message-ID: <YkvpEX4Hpj0Wnnhc@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <7ebe0aa8cc6ce11eaf032c3796823bcc08df27fe.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ebe0aa8cc6ce11eaf032c3796823bcc08df27fe.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:18AM -0700, Reinette Chatre wrote:
> User provided offset and length is validated when parsing the parameters
> of the SGX_IOC_ENCLAVE_ADD_PAGES ioctl(). Extract this validation
> into a utility that can be used by the SGX2 ioctl()s that will
> also provide these values.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> No changes since V2
> 
> Changes since V1:
> - New patch
> 
>  arch/x86/kernel/cpu/sgx/ioctl.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 83df20e3e633..f487549bccba 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -372,6 +372,26 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
>  	return ret;
>  }
>  
> +/*
> + * Ensure user provided offset and length values are valid for
> + * an enclave.
> + */
> +static int sgx_validate_offset_length(struct sgx_encl *encl,
> +				      unsigned long offset,
> +				      unsigned long length)
> +{
> +	if (!IS_ALIGNED(offset, PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (!length || length & (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	if (offset + length - PAGE_SIZE >= encl->size)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /**
>   * sgx_ioc_enclave_add_pages() - The handler for %SGX_IOC_ENCLAVE_ADD_PAGES
>   * @encl:       an enclave pointer
> @@ -425,14 +445,10 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
>  	if (copy_from_user(&add_arg, arg, sizeof(add_arg)))
>  		return -EFAULT;
>  
> -	if (!IS_ALIGNED(add_arg.offset, PAGE_SIZE) ||
> -	    !IS_ALIGNED(add_arg.src, PAGE_SIZE))
> -		return -EINVAL;
> -
> -	if (!add_arg.length || add_arg.length & (PAGE_SIZE - 1))
> +	if (!IS_ALIGNED(add_arg.src, PAGE_SIZE))
>  		return -EINVAL;
>  
> -	if (add_arg.offset + add_arg.length - PAGE_SIZE >= encl->size)
> +	if (sgx_validate_offset_length(encl, add_arg.offset, add_arg.length))
>  		return -EINVAL;
>  
>  	if (copy_from_user(&secinfo, (void __user *)add_arg.secinfo,
> -- 
> 2.25.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
