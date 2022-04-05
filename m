Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0C4F23C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiDEG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiDEG56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:57:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7531004;
        Mon,  4 Apr 2022 23:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 840ADB81B9C;
        Tue,  5 Apr 2022 06:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0100CC3410F;
        Tue,  5 Apr 2022 06:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649141755;
        bh=l8dvUlb3U48S/MWZxo9VRCxlg4l3/8kSPeGWEIhVYNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPX15kAdYpktxUsJlFKHWTZ0Na9i/R4938XmSH4yARwnto9kzAjKsnLu2dLuN99vA
         kgmw23OI22neTl/WRymI7gOwKCkgWpIQrP/r1/8TXYz4z3cYMoiFBCF7fyFZ9b6vPu
         mGeYZ7fPY97pCibs0mUPqyldJqrQvpHP80tBInNDuwtmY3d1P6cw4KX+08jyADemPP
         /ZfLX9MU3zzEFEEIhR8lzZsv+12n4HG7ly4dC6Jw/5pyuPYTtaFot0D4V7NXtuAjiV
         idWIWpe7m6e0peiWRa639Ld+wjAwasZVdaMPzXbZ9uJIbu/CjTz5bj/YN/fDvQwuWS
         Yfk+2OT2jxa6w==
Date:   Tue, 5 Apr 2022 09:57:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 07/30] x86/sgx: Rename sgx_encl_ewb_cpumask() as
 sgx_encl_cpumask()
Message-ID: <YkvoQgvOiNe5n5g2@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <c42cb6298d69cacd48872f97d11df694074803d8.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c42cb6298d69cacd48872f97d11df694074803d8.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:15AM -0700, Reinette Chatre wrote:
> sgx_encl_ewb_cpumask() is no longer unique to the reclaimer where it
> is used during the EWB ENCLS leaf function when EPC pages are written
> out to main memory and sgx_encl_ewb_cpumask() is used to learn which
> CPUs might have executed the enclave to ensure that TLBs are cleared.
> 
> Upcoming SGX2 enabling will use sgx_encl_ewb_cpumask() during the
> EMODPR and EMODT ENCLS leaf functions that make changes to enclave
> pages. The function is needed for the same reason it is used now: to
> learn which CPUs might have executed the enclave to ensure that TLBs
> no longer point to the changed pages.
> 
> Rename sgx_encl_ewb_cpumask() to sgx_encl_cpumask() to reflect the
> broader usage.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> No changes since V2
> 
> Changes since V1:
> - New patch split from original "x86/sgx: Use more generic name for
>   enclave cpumask function" (Jarkko).
> 
>  arch/x86/kernel/cpu/sgx/encl.c | 6 +++---
>  arch/x86/kernel/cpu/sgx/encl.h | 2 +-
>  arch/x86/kernel/cpu/sgx/main.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index c6525eba74e8..8de9bebc4d81 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -614,7 +614,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
>  }
>  
>  /**
> - * sgx_encl_ewb_cpumask() - Query which CPUs might be accessing the enclave
> + * sgx_encl_cpumask() - Query which CPUs might be accessing the enclave
>   * @encl: the enclave
>   *
>   * Some SGX functions require that no cached linear-to-physical address
> @@ -639,7 +639,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
>   * The following flow is used to support SGX functions that require that
>   * no cached linear-to-physical address mappings are present:
>   * 1) Execute ENCLS[ETRACK] to initiate hardware tracking.
> - * 2) Use this function (sgx_encl_ewb_cpumask()) to query which CPUs might be
> + * 2) Use this function (sgx_encl_cpumask()) to query which CPUs might be
>   *    accessing the enclave.
>   * 3) Send IPI to identified CPUs, kicking them out of the enclave and
>   *    thus flushing all locally cached linear-to-physical address mappings.
> @@ -656,7 +656,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
>   *
>   * Return: cpumask of CPUs that might be accessing @encl
>   */
> -const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
> +const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl)
>  {
>  	cpumask_t *cpumask = &encl->cpumask;
>  	struct sgx_encl_mm *encl_mm;
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index d2acb4debde5..e59c2cbf71e2 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -105,7 +105,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>  
>  void sgx_encl_release(struct kref *ref);
>  int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
> -const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl);
> +const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
>  int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
>  			 struct sgx_backing *backing);
>  void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 2de85f459492..fa33922879bf 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -249,7 +249,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
>  			 * miss cpus that entered the enclave between
>  			 * generating the mask and incrementing epoch.
>  			 */
> -			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
> +			on_each_cpu_mask(sgx_encl_cpumask(encl),
>  					 sgx_ipi_cb, NULL, 1);
>  			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
>  		}
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

