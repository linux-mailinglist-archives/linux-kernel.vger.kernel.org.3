Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851144F23E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiDEHHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiDEHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A186BDF;
        Tue,  5 Apr 2022 00:04:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9A3B6159D;
        Tue,  5 Apr 2022 07:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7326C340F3;
        Tue,  5 Apr 2022 07:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649142256;
        bh=xPCoouKuVD/FCQuSL+zTNSHrzURRvmCXBeKfzIAELoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZg1WVb+tKu2Mxr/E1Nl7JMdj/PkH1IQRkcZpVMkVMB/CnATO78F9Oajmakc9ErBM
         BjdEl6xZZjNQFJ9w2GxGVtiYDqVXpuXWk9nwzhXMa193AcQ3qFUkpVDnC45xCpMm5/
         KrWI9zV6iAVQ6dHr1YCLbqc2EwQuvU5s7MSxJjWwm3/CSF074WwEh5PNYM1gafJyoQ
         AfjTAuZOI+Zdo18uOp3rn//3g1iSd3DiG3wTBThK+WRQR+fT8YAkyxa+SeBPUSDATH
         DwLpUjLYtFdDBqWefIjLBo2ukKvM3i5Vw9Llogry27D6zUhU2zQou5MIF+3NOuiKBO
         yk3VKw3LH0a7A==
Date:   Tue, 5 Apr 2022 10:05:27 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 16/30] x86/sgx: Tighten accessible memory range after
 enclave initialization
Message-ID: <YkvqN2eSJJdAuiWE@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <9f9e9582029dee93b5b37f2fb4dc062be9fe1fde.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9e9582029dee93b5b37f2fb4dc062be9fe1fde.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:24AM -0700, Reinette Chatre wrote:
> Before an enclave is initialized the enclave's memory range is unknown.
> The enclave's memory range is learned at the time it is created via the
> SGX_IOC_ENCLAVE_CREATE ioctl() where the provided memory range is
> obtained from an earlier mmap() of /dev/sgx_enclave. After an enclave
> is initialized its memory can be mapped into user space (mmap()) from
> where it can be entered at its defined entry points.
> 
> With the enclave's memory range known after it is initialized there is
> no reason why it should be possible to map memory outside this range.
> 
> Lock down access to the initialized enclave's memory range by denying
> any attempt to map memory outside its memory range.
> 
> Locking down the memory range also makes adding pages to an initialized
> enclave more efficient. Pages are added to an initialized enclave by
> accessing memory that belongs to the enclave's memory range but not yet
> backed by an enclave page. If it is possible for user space to map
> memory that does not form part of the enclave then an access to this
> memory would eventually fail. Failures range from a prompt general
> protection fault if the access was an ENCLU[EACCEPT] from within the
> enclave, or a page fault via the vDSO if it was another access from
> within the enclave, or a SIGBUS (also resulting from a page fault) if
> the access was from outside the enclave.
> 
> Disallowing invalid memory to be mapped in the first place avoids
> preventable failures.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> No changes since V2
> 
> Changes since V1:
> - Add comment (Jarkko).
> 
>  arch/x86/kernel/cpu/sgx/encl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index fa4f947f8496..7909570736a0 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -409,6 +409,11 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>  
>  	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
>  
> +	/* Disallow mapping outside enclave's address range. */
> +	if (test_bit(SGX_ENCL_INITIALIZED, &encl->flags) &&
> +	    (start < encl->base || end > encl->base + encl->size))
> +		return -EACCES;
> +
>  	/*
>  	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
>  	 * conflict with the enclave page permissions.
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
