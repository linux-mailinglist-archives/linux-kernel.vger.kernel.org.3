Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545FA4C8EA9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiCAPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiCAPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:13:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1625AA66EC;
        Tue,  1 Mar 2022 07:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B9061635;
        Tue,  1 Mar 2022 15:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B47C340EE;
        Tue,  1 Mar 2022 15:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646147551;
        bh=nhjoO2U16ehs9nVncYaKUrXUw/1VXcwyAGAuJhstjd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VILTBHfHCFmcMOBwjJrG0uAZPIXDz1NSseZXGwyBJSppITz8cgwiso19pp6rZYSnw
         XSbXGsRRwRDluwzgoqyVq6SY2YISDFqPKupEDIcTE5bBFhfYVTNMXl/tTP3iYvWbCW
         /iPZUdsqx2pGrUeR73Io0FiGhyLw5hACQt7a0WUS8eMi8hL+3G+nffAd0S1q73P4Qd
         8GSnHyKpS75DYTb+hSQbwANc+/VhNeWdpHfIBpEycve6VwVoc3dP6y/9l/t2Jkwdtu
         nvgC1czza6ZhCoZLvWka/ER4dPNVqz5m7pO9VEShZAqqyAdXRUREUzqrp2HUdG8D55
         Ym6poS0GlpPtQ==
Date:   Tue, 1 Mar 2022 16:13:13 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/25] x86/sgx: Support adding of pages to initialized
 enclave
Message-ID: <Yh44CahjtgAarDad@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:11AM -0800, Reinette Chatre wrote:
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index 848a28d28d3d..1b6ce1da7c92 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -123,4 +123,6 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *page);
>  struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>  					 unsigned long addr);
>  
> +struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
> +void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
>  #endif /* _X86_ENCL_H */
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 5dddb3c9f742..de0bf68ee842 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -17,7 +17,7 @@
>  #include "encl.h"
>  #include "encls.h"
>  
> -static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
> +struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
>  {
>  	struct sgx_va_page *va_page = NULL;
>  	void *err;
> @@ -43,7 +43,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
>  	return va_page;
>  }
>  
> -static void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
> +void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
>  {
>  	encl->page_cnt--;

Nit: this should be a separate patch, e.g.

  x86/sgx: Export sgx_encl_{grow,shrink}()

  In order to use sgx_encl_{grow,shrink}() in the page augementation code
  located in encl.c, export these functions.

BR, Jarkko
