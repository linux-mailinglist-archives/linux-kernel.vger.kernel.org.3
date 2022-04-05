Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D004F23E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiDEHFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiDEHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:05:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2011A3C;
        Tue,  5 Apr 2022 00:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1817CE1BE9;
        Tue,  5 Apr 2022 07:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946A0C340F3;
        Tue,  5 Apr 2022 07:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649142205;
        bh=BxQ+fzJKngiRHE9r2lus0aRxgxUHFJ1D2qvDYFkjl8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZMNJJ8FKR6UcMY/PkXH45FJSz4VtbQxSUpqT+4Bg5tQZmdgzMuevBlcP6gF2Qkjl
         dC+TJc9IoSTS4tHv0FBTS7nkNLk34/tvTZwQZErOQIcZYy0P0JRvl5oHlsRlYc4Xe/
         2bwjSpOvWjsIzC6S+ZteDEvrKc7WbZNIskG/CuyUjrhQB4MZBfdBs1TWxxIu35EYkD
         VtctgXwDWstGhNq9DjZlO8ESHlbUskqDiHoXl+NFWlLBEx8UISdxdUooVukVFVEL9L
         9H6SYfJaMdbkgw1aHicK4u92JyPep5uOpE6bShEQj3OSw83LSuSZpk3cX5l0X7pY+U
         BrD5nUMgnDtJg==
Date:   Tue, 5 Apr 2022 10:04:36 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 12/30] x86/sgx: Export sgx_encl_{grow,shrink}()
Message-ID: <YkvqBJ/5pfTRBvr4@kernel.org>
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <97f03b1ad11ff70839bdf239609a62957c804523.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f03b1ad11ff70839bdf239609a62957c804523.1648847675.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 09:49:20AM -0700, Reinette Chatre wrote:
> In order to use sgx_encl_{grow,shrink}() in the page augmentation code
> located in encl.c, export these functions.
> 
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - New patch.
> 
>  arch/x86/kernel/cpu/sgx/encl.h  | 2 ++
>  arch/x86/kernel/cpu/sgx/ioctl.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index 07abfc70c8e3..9d673d9531f0 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -120,5 +120,7 @@ bool sgx_va_page_full(struct sgx_va_page *va_page);
>  void sgx_encl_free_epc_page(struct sgx_epc_page *page);
>  struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
>  					 unsigned long addr);
> +struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
> +void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
>  
>  #endif /* _X86_ENCL_H */
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 0c211af8e948..746acddbb774 100644
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
>  
> -- 
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
