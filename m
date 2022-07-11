Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26556D301
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiGKCfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKCfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63ADF36;
        Sun, 10 Jul 2022 19:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2739261047;
        Mon, 11 Jul 2022 02:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32143C341C8;
        Mon, 11 Jul 2022 02:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657506952;
        bh=U5JfLaTDMJDWXhQ3M7TBmA+YrHYx+pIWdYRWiHn/62s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hl+so+OY8l+S8nfO4wI8BzRze5s1P2/8/PTp6XOeZqE9XLTP4AECUZXa2huTZ93WB
         KdXuF3v6WSDpbmNyb07syhNqQs5OholW21GjAYrpKACjyTFgMgxEICwOhpGqtKN/Y6
         O1vI3six+4rbZDVkKe3vV2HntEQbmsoxYs4h5vIPBbr0Gz8bX/ay3DBupMUgOMeupN
         TozBVqmT5KXJTP1dKMKKhgA8og6Q5KE0glP1xolHo9Cj9EttyrkBzdkBc8KlTnaEd3
         AdWX0aSZxXQOaMHM2tIGtlxLvotsLp4RaS474tXLjS7mI2EB536uFr6XFoOxX0Sz5D
         54Y3xamP6+8sQ==
Date:   Mon, 11 Jul 2022 05:35:47 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] x86/sgx: Drop 'page_index' from sgx_backingf
Message-ID: <YsuMgzDtBP82bz5m@kernel.org>
References: <20220708162124.8442-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708162124.8442-1-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:21:24AM -0700, Kristen Carlson Accardi wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Storing the 'page_index' value in the sgx_backing struct is
> dead code and no longer needed.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 1 -
>  arch/x86/kernel/cpu/sgx/encl.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 19876ebfb504..fa93586a536c 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -735,7 +735,6 @@ static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
>  		return PTR_ERR(pcmd);
>  	}
>  
> -	backing->page_index = page_index;
>  	backing->contents = contents;
>  	backing->pcmd = pcmd;
>  	backing->pcmd_offset = page_pcmd_off & (PAGE_SIZE - 1);
> diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
> index 332ef3568267..eeb1a53ddf48 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.h
> +++ b/arch/x86/kernel/cpu/sgx/encl.h
> @@ -78,7 +78,6 @@ struct sgx_va_page {
>  };
>  
>  struct sgx_backing {
> -	pgoff_t page_index;
>  	struct page *contents;
>  	struct page *pcmd;
>  	unsigned long pcmd_offset;
> -- 
> 2.20.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
