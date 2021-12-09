Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC3F46F796
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhLIXlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 18:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhLIXlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 18:41:19 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F63C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:37:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z6so5075631plk.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2djF0P4/pIiIN2tn2/N0Kxd449t54dXIhZh8UA9W5m0=;
        b=AsoDzv/qewrgwQFk+1LG/Q5IZ5JNhPI2jMNNToGHWKcru+V88AmBdb6PebMs2sZ2bh
         Bm6xB2omaLLkax8Ap731YYd05k4Jf4H8LLLKrMjscvyelECxoaSNmAtCPN/aQITNQd2W
         o5Iz6GlxcqnCxinVCrDZ3xgmqQvIx08sjij5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2djF0P4/pIiIN2tn2/N0Kxd449t54dXIhZh8UA9W5m0=;
        b=JXlNmYTiWA7tgGg8gJtw4InFzD1eLtXCXqcn5XzvqvmDcfcZ9gQd719Q7Mba/nuTwQ
         vum0u+G+BBxxZyhjRQolOXjpaKGa+ey7BXJMxmRYpYGcTbQgc/+jO90fdRyztWYK2aBw
         GeqiS8AJPqg1/dLajq15FJCuhkx3234yGu4uJT739sMxxfLKRscDSXmekZoUNXCanvTI
         9KQ5JW+qH0Tsph0jgrjskuWr97jEYy13yBsfoxFpLnCDnEV8OaG6olOkTEqPwLjdR+4I
         nXn4nSvHx6n2RQuBf94y2KLnYPeewaTQCMEtblPjkYIZvPVqdLw74AQG2LOUbLUP+Ywg
         Dp8Q==
X-Gm-Message-State: AOAM53272Jz9UCGBJ/Kzpwz44o8lUjZ2D/ryVSFvjbzEPPPfsQdlRann
        iRgFGVH2NysTZz0e9Ri/Jc8CSQ==
X-Google-Smtp-Source: ABdhPJzm9FnroTff4RdxY1rNi5NMwYvwjDB+MJJSwjZNCUJhLA7OKf5Bg/Xd1vkVwPTjlOP0idl9MA==
X-Received: by 2002:a17:90a:880a:: with SMTP id s10mr19407803pjn.214.1639093064920;
        Thu, 09 Dec 2021 15:37:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7sm192558pfj.41.2021.12.09.15.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 15:37:44 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:37:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/boot/string: Add missing function declarations
Message-ID: <202112091536.2DDF0DF@keescook>
References: <20211119175325.3668419-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119175325.3668419-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 09:53:25AM -0800, Kees Cook wrote:
> Silence "missing function declaration" warnings from string.h when
> building under W=1.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Hi, just a quick ping on this little fix.

Thanks!

-Kees

>  arch/x86/boot/string.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/boot/string.h b/arch/x86/boot/string.h
> index a232da487cd2..e5d2c6b8c2f1 100644
> --- a/arch/x86/boot/string.h
> +++ b/arch/x86/boot/string.h
> @@ -8,8 +8,10 @@
>  #undef memcmp
>  
>  void *memcpy(void *dst, const void *src, size_t len);
> +void *memmove(void *dst, const void *src, size_t len);
>  void *memset(void *dst, int c, size_t len);
>  int memcmp(const void *s1, const void *s2, size_t len);
> +int bcmp(const void *s1, const void *s2, size_t len);
>  
>  /* Access builtin version by default. */
>  #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
> @@ -25,6 +27,7 @@ extern size_t strnlen(const char *s, size_t maxlen);
>  extern unsigned int atou(const char *s);
>  extern unsigned long long simple_strtoull(const char *cp, char **endp,
>  					  unsigned int base);
> +long simple_strtol(const char *cp, char **endp, unsigned int base);
>  
>  int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
>  int boot_kstrtoul(const char *s, unsigned int base, unsigned long *res);
> -- 
> 2.30.2
> 

-- 
Kees Cook
