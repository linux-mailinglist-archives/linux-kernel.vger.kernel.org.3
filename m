Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0219A4F23F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiDEHMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiDEHME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D54B1E2;
        Tue,  5 Apr 2022 00:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05957615FE;
        Tue,  5 Apr 2022 07:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBBAC340EE;
        Tue,  5 Apr 2022 07:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649142604;
        bh=R0qfjYmhRyfgzwAdAmpXuqarK6SmFDQ1XokwxK9loxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9Eevjye9Rlmz7JV6Frf1lwqsLbud2Y9zSDCIowIUYts0TKrl5ypkN4QO1cgmJaen
         WMi20mJZrflA2PBUknzisE9r4iZ58n6vkXrUtxSJ/uLjAz52FlmrKvznyxBIJtEDh1
         tvSP4CGqk8mPiXsxaHeW742OPj+G5lloQf//ajwlrZoZ7pn7OXc0vyU9u6zyNke7MV
         Wo0smeuYEGKeqjvRfzrMEi3ipSzRYKTA4POp2wPhTHj0112AxsaxrtrvpZrkCtz4R7
         LAVXEEdp/OEPrXz1uboo0n22UqMFXCWxjlCnAndVVsJDVPEDj+yPkMgxGpBkC+qN6p
         LfLjiIYihFTHg==
Date:   Tue, 5 Apr 2022 10:11:15 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 19/30] x86/sgx: Free up EPC pages directly to support
 large page ranges
Message-ID: <Ykvrk4hYvBEnNOOl@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <b3a17e1ce7bcd14db3c28903e8a97f094998ae74.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3a17e1ce7bcd14db3c28903e8a97f094998ae74.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:27AM -0700, Reinette Chatre wrote:
> The page reclaimer ensures availability of EPC pages across all
> enclaves. In support of this it runs independently from the
> individual enclaves in order to take locks from the different
> enclaves as it writes pages to swap.
> 
> When needing to load a page from swap an EPC page needs to be
> available for its contents to be loaded into. Loading an existing
> enclave page from swap does not reclaim EPC pages directly if
> none are available, instead the reclaimer is woken when the
> available EPC pages are found to be below a watermark.
> 
> When iterating over a large number of pages in an oversubscribed
> environment there is a race between the reclaimer woken up and
> EPC pages reclaimed fast enough for the page operations to proceed.
> 
> Ensure there are EPC pages available before attempting to load
> a page that may potentially be pulled from swap into an available
> EPC page.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> No changes since V2
> 
> Changes since v1:
> - Reword commit message.
> 
>  arch/x86/kernel/cpu/sgx/ioctl.c | 6 ++++++
>  arch/x86/kernel/cpu/sgx/main.c  | 6 ++++++
>  arch/x86/kernel/cpu/sgx/sgx.h   | 1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 515e1961cc02..f88bc1236276 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -777,6 +777,8 @@ sgx_enclave_restrict_permissions(struct sgx_encl *encl,
>  	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
>  		addr = encl->base + modp->offset + c;
>  
> +		sgx_direct_reclaim();
> +
>  		mutex_lock(&encl->lock);
>  
>  		entry = sgx_encl_load_page(encl, addr);
> @@ -934,6 +936,8 @@ static long sgx_enclave_modify_type(struct sgx_encl *encl,
>  	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
>  		addr = encl->base + modt->offset + c;
>  
> +		sgx_direct_reclaim();
> +
>  		mutex_lock(&encl->lock);
>  
>  		entry = sgx_encl_load_page(encl, addr);
> @@ -1129,6 +1133,8 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
>  	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
>  		addr = encl->base + params->offset + c;
>  
> +		sgx_direct_reclaim();
> +
>  		mutex_lock(&encl->lock);
>  
>  		entry = sgx_encl_load_page(encl, addr);
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 6e2cb7564080..545da16bb3ea 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -370,6 +370,12 @@ static bool sgx_should_reclaim(unsigned long watermark)
>  	       !list_empty(&sgx_active_page_list);
>  }
>  
> +void sgx_direct_reclaim(void)
> +{
> +	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
> +		sgx_reclaim_pages();
> +}

Please, instead open code this to both locations - not enough redundancy
to be worth of new function. Causes only unnecessary cross-referencing
when maintaining. Otherwise, I agree with the idea.

BR, Jarkko

