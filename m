Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF8C4B1AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346583AbiBKAyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:54:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346579AbiBKAyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:54:54 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1825F68
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:54:54 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id l19so7548254pfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uzcyDJDNi5GmBv4U03eJWryB2XjhMP5736i1b/gjtS0=;
        b=OJcJvg1lIs62N3GjVa8/LTlfS7upa/xr+/yqej93ZLvKvNvWRieu71wpl5TeXuyvcg
         R6bQb60X5tmf18alMuGNwUqhlONmwHDA1MWkfgookl0SVxVUgxt0PFdERfjV9Qp+8wzS
         BHxJC5W6t1DrtJBHsXc1qgwdpV2s1Efulp2PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uzcyDJDNi5GmBv4U03eJWryB2XjhMP5736i1b/gjtS0=;
        b=NwGgEtvZwsB8/mYu8hWNjbMws9+8qCHYx7Y6lQMhSwoyKR43LZ3PrX2AzSt3IEwMZl
         Ha4ru7w0igJep+CA04Ufnt0E+cAuscv8uyQznnR632hipt8yt3w2/kWHYwUqgmn/44cO
         YG4MKIxataB5nBlgtTu712yZTD1q8sN/toJkGqy0oY928QbkhjJTd4urVULFk+mRsrSP
         Ayj5Gv0UWwbYtIp4BUy39vfomyZ8EJno9f2OW41hR3bL/h9zD+Z4OvdovDX/Qe9qntNO
         ea3sQBfEItyRDHmSVVH2nGaBT3sTDOcegrcFkaH4vjcRYq5auBiLUPp4gsAJy4eKaKz8
         s3mg==
X-Gm-Message-State: AOAM5332zBHRR0WJfL7LptttIwCiYCxiYvAQD/k78bcxZ8nnSB0Fcjos
        m/Nb6djpyJaI3/d/4Vhs1BfGWA==
X-Google-Smtp-Source: ABdhPJy4Ogb4My/UrDG5DujzJYCV/hk5yDp0cjrcj7xH+goA5f18ojJcRJubslgwxb7Z2pArOua10A==
X-Received: by 2002:a05:6a00:178d:: with SMTP id s13mr9977850pfg.47.1644540893586;
        Thu, 10 Feb 2022 16:54:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x23sm24719940pfh.216.2022.02.10.16.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:54:53 -0800 (PST)
Date:   Thu, 10 Feb 2022 16:54:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 04/12] powerpc: Prepare func_desc_t for refactorisation
Message-ID: <202202101653.9128E58B84@keescook>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <86c393ce0a6f603f94e6d2ceca08d535f654bb23.1634457599.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c393ce0a6f603f94e6d2ceca08d535f654bb23.1634457599.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 02:38:17PM +0200, Christophe Leroy wrote:
> In preparation of making func_desc_t generic, change the ELFv2
> version to a struct containing 'addr' element.
> 
> This allows using single helpers common to ELFv1 and ELFv2.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/module_64.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index a89da0ee25e2..b687ef88c4c4 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -33,19 +33,13 @@
>  #ifdef PPC64_ELF_ABI_v2
>  
>  /* An address is simply the address of the function. */
> -typedef unsigned long func_desc_t;
> +typedef struct {
> +	unsigned long addr;
> +} func_desc_t;
>  
>  static func_desc_t func_desc(unsigned long addr)
>  {
> -	return addr;
> -}
> -static unsigned long func_addr(unsigned long addr)
> -{
> -	return addr;
> -}
> -static unsigned long stub_func_addr(func_desc_t func)
> -{
> -	return func;
> +	return (func_desc_t){addr};

There's only 1 element in the struct, so okay, but it hurt my eyes a
little. I would have been happier with:

	return (func_desc_t){ .addr = addr; };

But of course that also looks bonkers because it starts with "return".
So no matter what I do my eyes bug out. ;)

So it's fine either way. :)

Reviewed-by: Kees Cook <keescook@chromium.org>


>  }
>  
>  /* PowerPC64 specific values for the Elf64_Sym st_other field.  */
> @@ -70,14 +64,6 @@ static func_desc_t func_desc(unsigned long addr)
>  {
>  	return *(struct func_desc *)addr;
>  }
> -static unsigned long func_addr(unsigned long addr)
> -{
> -	return func_desc(addr).addr;
> -}
> -static unsigned long stub_func_addr(func_desc_t func)
> -{
> -	return func.addr;
> -}
>  static unsigned int local_entry_offset(const Elf64_Sym *sym)
>  {
>  	return 0;
> @@ -93,6 +79,16 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>  }
>  #endif
>  
> +static unsigned long func_addr(unsigned long addr)
> +{
> +	return func_desc(addr).addr;
> +}
> +
> +static unsigned long stub_func_addr(func_desc_t func)
> +{
> +	return func.addr;
> +}
> +
>  #define STUB_MAGIC 0x73747562 /* stub */
>  
>  /* Like PPC32, we need little trampolines to do > 24-bit jumps (into
> -- 
> 2.31.1
> 

-- 
Kees Cook
