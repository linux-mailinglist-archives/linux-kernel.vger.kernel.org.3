Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B264F23A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiDEGyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiDEGyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:54:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D02B8EB49;
        Mon,  4 Apr 2022 23:52:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCC5F6159E;
        Tue,  5 Apr 2022 06:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA868C340F3;
        Tue,  5 Apr 2022 06:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141531;
        bh=lCqkXTufzxbSDnMkR4GwJJwvmnqlcgqAt0uLPFaqBpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDi8rGUDyLGFXcKYA/Toc5HLEF0eYMA1dklZqBkAePaYQkn+qibEAftdtOhg9neJA
         yhtpagzhmlsEJoYqxhLyj6+wDzKje6TxX+/v/jFW6RroMx7X/rUhz9Pv+Dpa6DwFi6
         zwjnLRTXV8GA5kEnMzkb+IblSocUkmQ1h4mDfVyPLI9wNn87br44xB5YmIzziTJ4c7
         b1uy62EzfK6KsTvu/ZpFwdSIQUwtJJ5c4alru78FjG2jKXGEiojLqM/fh9NaHAt5cv
         yJIaFXyPAX+QzRiy5u8PMHvjkfTGtFvP10sZPf7R2WXfMV1prv87NAmYpbTxG/9MED
         MdhSE3ekrHV5A==
Date:   Tue, 5 Apr 2022 09:53:22 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 02/30] x86/sgx: Add wrapper for SGX2 EMODPR function
Message-ID: <YkvnYiVCNAABq/LQ@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <e3add7b7c104dab4580c82202193939d2e2b21c5.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3add7b7c104dab4580c82202193939d2e2b21c5.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:10AM -0700, Reinette Chatre wrote:
> Add a wrapper for the EMODPR ENCLS leaf function used to
> restrict enclave page permissions as maintained in the
> SGX hardware's Enclave Page Cache Map (EPCM).
> 
> EMODPR:
> 1) Updates the EPCM permissions of an enclave page by treating
>    the new permissions as a mask. Supplying a value that attempts
>    to relax EPCM permissions has no effect on EPCM permissions
>    (PR bit, see below, is changed).
> 2) Sets the PR bit in the EPCM entry of the enclave page to
>    indicate that permission restriction is in progress. The bit
>    is reset by the enclave by invoking ENCLU leaf function
>    EACCEPT or EACCEPTCOPY.
> 
> The enclave may access the page throughout the entire process
> if conforming to the EPCM permissions for the enclave page.
> 
> After performing the permission restriction by issuing EMODPR
> the kernel needs to collaborate with the hardware to ensure that
> all logical processors sees the new restricted permissions. This
> is required for the enclave's EACCEPT/EACCEPTCOPY to succeed and
> is accomplished with the ETRACK flow.
> 
> Expand enum sgx_return_code with the possible EMODPR return
> values.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - Add detail to changelog that PR bit is set when EPCM permissions
>   not changed when relaxing of permissions using EMODPR attempted.
> 
> Changes since V1:
> - Split original patch ("x86/sgx: Add wrappers for SGX2 functions")
>   in three to introduce the SGX2 functions separately (Jarkko).
> - Rewrite commit message to include how the EPCM within the hardware
>   is changed by the SGX2 function as well as the calling
>   conditions (Jarkko).
> - Make short description more specific to which permissions (EPCM
>   permissions) the function modifies.
> 
>  arch/x86/include/asm/sgx.h      | 5 +++++
>  arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> index 3f9334ef67cd..d67810b50a81 100644
> --- a/arch/x86/include/asm/sgx.h
> +++ b/arch/x86/include/asm/sgx.h
> @@ -65,17 +65,22 @@ enum sgx_encls_function {
>  
>  /**
>   * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
> + * %SGX_EPC_PAGE_CONFLICT:	Page is being written by other ENCLS function.
>   * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
>   *				been completed yet.
>   * %SGX_CHILD_PRESENT		SECS has child pages present in the EPC.
>   * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
>   *				public key does not match IA32_SGXLEPUBKEYHASH.
> + * %SGX_PAGE_NOT_MODIFIABLE:	The EPC page cannot be modified because it
> + *				is in the PENDING or MODIFIED state.
>   * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
>   */
>  enum sgx_return_code {
> +	SGX_EPC_PAGE_CONFLICT		= 7,
>  	SGX_NOT_TRACKED			= 11,
>  	SGX_CHILD_PRESENT		= 13,
>  	SGX_INVALID_EINITTOKEN		= 16,
> +	SGX_PAGE_NOT_MODIFIABLE		= 20,
>  	SGX_UNMASKED_EVENT		= 128,
>  };
>  
> diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
> index 0e22fa8f77c5..2b091912f038 100644
> --- a/arch/x86/kernel/cpu/sgx/encls.h
> +++ b/arch/x86/kernel/cpu/sgx/encls.h
> @@ -215,4 +215,10 @@ static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
>  	return __encls_ret_3(EWB, pginfo, addr, va);
>  }
>  
> +/* Restrict the EPCM permissions of an EPC page. */
> +static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
> +{
> +	return __encls_ret_2(EMODPR, secinfo, addr);
> +}
> +
>  #endif /* _X86_ENCLS_H */
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
