Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CFD4AE71E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242560AbiBICma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242104AbiBIBKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:10:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554FEC06174F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:10:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so3596594pjl.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 17:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=krZ7XDngCuaQ/kaEDAhJETqO/lCcgabbGCGZ64ZW5mg=;
        b=B01e8AvROu8wzAWvnNc18YbXO4k2zAp/FgRgRHBcFtqjYpKfCKhf7Kc6cTHWN3J1h+
         Ckp20PmKRI8ExSgFiVFMDw1LR/I0GvkZyP8im4vYtSfL6Hyvf9Qg+MXw9i4rui+Giqwl
         3JFxHmZuIKASMn6wPqEmWknLrINw4rKAFikTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=krZ7XDngCuaQ/kaEDAhJETqO/lCcgabbGCGZ64ZW5mg=;
        b=Xl3Y4Zm1BolcIeAi63x++0YEKSQKh48Jnl8n9LQGgwz0auNwG3PEYwgC3cwaI0SYTF
         nJCC5kYPazDC3MfdbxOaC8vFdg+Ov+YAiJIt7/aJD8FK1xeivhEv8sDmJUPT3lkxiSBe
         LdrbCSzwwUbDQWwgJsnfXEfhSbqphDcj2RBJw/DgJlCssDE0or/DANhX+5logc3xN0bF
         6HWq5mNXTYyxahAD2v9Trr2q+pSWG0vRhNwChcZ11/M2mpe7ObcNDcYe5uFFuu07DF6B
         ODMjHnTmNLPky8pcaXjD26fXqCiJ6c54kgKw5xpxaE706AOcnn+YbIjUkpVAcTMZ8T1F
         QtLw==
X-Gm-Message-State: AOAM532a/1euv2PzTWSpS6cq+W4X+w0btgjZwXn8ZK48wy+l8RKcjRig
        Ypq+BDBDWihFn270L5e9WSrraA==
X-Google-Smtp-Source: ABdhPJzRY0y5DOmxHW5tLxcTUeq347A0tFTU13T02PtIPhjLsx9UZtCJcdBxPe9IpIDlMO7MS7TXZg==
X-Received: by 2002:a17:903:41c6:: with SMTP id u6mr7045085ple.74.1644369031529;
        Tue, 08 Feb 2022 17:10:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4sm17437326pfl.106.2022.02.08.17.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 17:10:31 -0800 (PST)
Date:   Tue, 8 Feb 2022 17:10:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 03/35] x86/cpufeatures: Add CET CPU feature flags for
 Control-flow Enforcement Technology (CET)
Message-ID: <202202081709.96226C0B@keescook>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-4-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130211838.8382-4-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 01:18:06PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Add CPU feature flags for Control-flow Enforcement Technology (CET).
> 
> CPUID.(EAX=7,ECX=0):ECX[bit 7] Shadow stack
> CPUID.(EAX=7,ECX=0):EDX[bit 20] Indirect Branch Tracking

It looks like this only adds the SHSTK bit, maybe drop mention of IBT
here.

I wonder if we could land this (and the IBT part) without waiting for
everything else in the respective series?

-Kees

> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
> 
> v1:
>  - Remove IBT, can be added in a follow on IBT series.
> 
> Yu-cheng v25:
>  - Make X86_FEATURE_IBT depend on X86_FEATURE_SHSTK.
> 
> Yu-cheng v24:
>  - Update for splitting CONFIG_X86_CET to CONFIG_X86_SHADOW_STACK and
>    CONFIG_X86_IBT.
>  - Move DISABLE_IBT definition to the IBT series.
> 
>  arch/x86/include/asm/cpufeatures.h       | 1 +
>  arch/x86/include/asm/disabled-features.h | 8 +++++++-
>  arch/x86/kernel/cpu/cpuid-deps.c         | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 6db4e2932b3d..c3eb94b13fef 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -355,6 +355,7 @@
>  #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
>  #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
>  #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
> +#define X86_FEATURE_SHSTK		(16*32+ 7) /* Shadow Stack */
>  #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
>  #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
>  #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
> diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
> index 8f28fafa98b3..b7728f7afb2b 100644
> --- a/arch/x86/include/asm/disabled-features.h
> +++ b/arch/x86/include/asm/disabled-features.h
> @@ -65,6 +65,12 @@
>  # define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
>  #endif
>  
> +#ifdef CONFIG_X86_SHADOW_STACK
> +#define DISABLE_SHSTK	0
> +#else
> +#define DISABLE_SHSTK	(1 << (X86_FEATURE_SHSTK & 31))
> +#endif
> +
>  /*
>   * Make sure to add features to the correct mask
>   */
> @@ -85,7 +91,7 @@
>  #define DISABLED_MASK14	0
>  #define DISABLED_MASK15	0
>  #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
> -			 DISABLE_ENQCMD)
> +			 DISABLE_ENQCMD|DISABLE_SHSTK)
>  #define DISABLED_MASK17	0
>  #define DISABLED_MASK18	0
>  #define DISABLED_MASK19	0
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index c881bcafba7d..bf1b55a1ba21 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -78,6 +78,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
>  	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
>  	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
> +	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
>  	{}
>  };
>  
> -- 
> 2.17.1
> 

-- 
Kees Cook
