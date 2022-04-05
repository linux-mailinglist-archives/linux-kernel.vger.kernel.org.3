Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8B4F23BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiDEGz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiDEGzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8366C91546;
        Mon,  4 Apr 2022 23:53:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 202F56158E;
        Tue,  5 Apr 2022 06:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308E7C340F3;
        Tue,  5 Apr 2022 06:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141598;
        bh=R2Aj79mJA5Nt9aiKfrYCcBadm1RYNQmwTSLFqRL6scE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yfhh8gAKT4UR2pN8DFqGYNtbz8FWzVMAFnTJeXx7GPDu1Tu5UE3B24GlWpKxo4w8V
         Dte7UL9HtTWWFbxKqZ1XknH16xXSFMsnP7bNifBki8x5fagwk0kmAB/HrL+axGkdBd
         E6ZG6PFcSPZJzHGQRQLL+2tlPhCauYUcx34TWyhBdCwwLXVPv2yZm/uKHjlYCkLtar
         mVDCgD9RPsAKSNTWNdTS1zRKkfCoAnGjvLtmi6bYG71UkBz6+PwjSm+LRNEetUFkqU
         Bwa/gjS33CYiOzZ6cvKxxVEw9Z0myu8TB3vo4CB0wQ+KXMgAn4yPOsix4lx3VtCQwH
         KPF79lTBBcGFQ==
Date:   Tue, 5 Apr 2022 09:54:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 04/30] x86/sgx: Add wrapper for SGX2 EAUG function
Message-ID: <YkvnpSAezhnkth2Z@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <db6a2a6b394d9900ce8e3abb1b471b61b7e25c53.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6a2a6b394d9900ce8e3abb1b471b61b7e25c53.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:12AM -0700, Reinette Chatre wrote:
> Add a wrapper for the EAUG ENCLS leaf function used to
> add a page to an initialized enclave.
> 
> EAUG:
> 1) Stores all properties of the new enclave page in the SGX
>    hardware's Enclave Page Cache Map (EPCM).
> 2) Sets the PENDING bit in the EPCM entry of the enclave page.
>    This bit is cleared by the enclave by invoking ENCLU leaf
>    function EACCEPT or EACCEPTCOPY.
> 
> Access from within the enclave to the new enclave page is not
> possible until the PENDING bit is cleared.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> No changes since V2
> 
> Changes since V1:
> - Split original patch ("x86/sgx: Add wrappers for SGX2 functions")
>   in three to introduce the SGX2 functions separately (Jarkko).
> - Rewrite commit message to include how the EPCM within the hardware
>   is changed by the SGX2 function as well as any calling
>   conditions (Jarkko).
> 
>  arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
> index 7a1ecf704ec1..99004b02e2ed 100644
> --- a/arch/x86/kernel/cpu/sgx/encls.h
> +++ b/arch/x86/kernel/cpu/sgx/encls.h
> @@ -227,4 +227,10 @@ static inline int __emodt(struct sgx_secinfo *secinfo, void *addr)
>  	return __encls_ret_2(EMODT, secinfo, addr);
>  }
>  
> +/* Zero a page of EPC memory and add it to an initialized enclave. */
> +static inline int __eaug(struct sgx_pageinfo *pginfo, void *addr)
> +{
> +	return __encls_2(EAUG, pginfo, addr);
> +}
> +
>  #endif /* _X86_ENCLS_H */
> -- 
> 2.25.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
