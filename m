Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C562D4F23A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiDEGyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiDEGy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E18F980;
        Mon,  4 Apr 2022 23:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62526615A2;
        Tue,  5 Apr 2022 06:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752D2C340F3;
        Tue,  5 Apr 2022 06:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141550;
        bh=v7z72dbrfllNwSuS1yJpqUd9r16VRMOOi8QhiM6FL/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=op5/E34fFr1cgn3ydddUqkZDqvvHOzU4t34WtfU+UFBfD8np8jU12XW4tkcoxHaVo
         /95fv2mPNotokRUi1A96S3FuJmCS/e0PbF6A18oL5LRdaW7SbFwLr9XQnfAEp6Txhd
         b1RFikRocm4kyr36Zhw/ZKI2jLv9EiBpPKXdjuHmzGPxHU/JBBQukyH09g1n1m8L+/
         3fg+3w8BL7m9vP5Sp0WYmK6xCW3jjrGciRdQ80KjNjvKwDpkvmweAfihHs/N4h8ZO/
         jUcaVo0D01pNFZMFvcqgT3fXjX/jji6wOjm1f2W6y2VBbdAFN7kHG3vA9axeejvYbI
         jFO2+4hesnXaw==
Date:   Tue, 5 Apr 2022 09:53:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/30] x86/sgx: Add wrapper for SGX2 EMODT function
Message-ID: <YkvndW7rfjUjRuAj@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <b99fcb7d39062dab80c612b32db4a4894c66ed39.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b99fcb7d39062dab80c612b32db4a4894c66ed39.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:11AM -0700, Reinette Chatre wrote:
> Add a wrapper for the EMODT ENCLS leaf function used to
> change the type of an enclave page as maintained in the
> SGX hardware's Enclave Page Cache Map (EPCM).
> 
> EMODT:
> 1) Updates the EPCM page type of the enclave page.
> 2) Sets the MODIFIED bit in the EPCM entry of the enclave page.
>    This bit is reset by the enclave by invoking ENCLU leaf
>    function EACCEPT or EACCEPTCOPY.
> 
> Access from within the enclave to the enclave page is not possible
> while the MODIFIED bit is set.
> 
> After changing the enclave page type by issuing EMODT the kernel
> needs to collaborate with the hardware to ensure that no logical
> processor continues to hold a reference to the changed page. This
> is required to ensure no required security checks are circumvented
> and is required for the enclave's EACCEPT/EACCEPTCOPY to succeed.
> Ensuring that no references to the changed page remain is
> accomplished with the ETRACK flow.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> No changes since V2
> 
> Changes since V1:
> - Split original patch ("x86/sgx: Add wrappers for SGX2 functions")
>   in three to introduce the SGX2 functions separately (Jarkko).
> - Rewrite commit message to include how the EPCM within the hardware
>   is changed by the SGX2 function as well as the calling
>   conditions (Jarkko).
> 
>  arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
> index 2b091912f038..7a1ecf704ec1 100644
> --- a/arch/x86/kernel/cpu/sgx/encls.h
> +++ b/arch/x86/kernel/cpu/sgx/encls.h
> @@ -221,4 +221,10 @@ static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
>  	return __encls_ret_2(EMODPR, secinfo, addr);
>  }
>  
> +/* Change the type of an EPC page. */
> +static inline int __emodt(struct sgx_secinfo *secinfo, void *addr)
> +{
> +	return __encls_ret_2(EMODT, secinfo, addr);
> +}
> +
>  #endif /* _X86_ENCLS_H */
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
