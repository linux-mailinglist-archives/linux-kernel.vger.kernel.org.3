Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593B34C3A72
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiBYApl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:45:37 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB303278CA8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:45:06 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id e6so1791278pgn.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AgCpvurnIsx+CM7zLZM7fo69fiubsVvjRCC9+sss7iU=;
        b=nATaO3sK7s6TmEQoOqBSVIYE23U+tGVLi3lHbL2ydOmkpkVA7T8oUKACvo9+K6tMSp
         LGRNwNfFoAXSjXjtU6iaJXILFwV/pmODRnvdC77ZSBQW66Bk7Vt6kIS6Ad+YkBn3/dRm
         aGozX47JfdKVoSbNvhfo9s9qN6+cVS6jfkNbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AgCpvurnIsx+CM7zLZM7fo69fiubsVvjRCC9+sss7iU=;
        b=gLLLxfl691xITawuXEjvxS6EwAg4ttTXi2Qr6CDrLtX/OIHIwyALBIq2mGpni9XjDP
         M6LRhyGhy1QVF00aEz515RLS5DMhO/EMR8cGCfXutD8PZCtcu3CNwAboXGIcpo1m/SH4
         r0OndxmgySOn4k6uVoT6mB6GUflcneImjENo2Jn3/IH1YmPZSBA9JDnt/6FutNXy0Pau
         YaXdICNv3/iRQSl4Z7qhlwnhNBj7yzKEBxRSA4G5U5Dl32Jgn7ckK3fUOaE3oPmDJEVz
         bVSD/0ZQUfenmQkCWRCDBb+LA3yGMyBK2D3DCKW8ht/LFsDDrZxLqsZ4HpzRlURK/GYu
         yovw==
X-Gm-Message-State: AOAM530mcU3usQqbPwu/S1xYllYEDhsNBDmGt5qVp+C+hlADVVml+Dzf
        /Zfcl3YoKXspqfu66nihgSSBp37dJw+/2g==
X-Google-Smtp-Source: ABdhPJzI6MTE2754OF+nJkW2lFF1p48ddIC8mo8FX7U2H60k7chqMyE9AjY3g2N/AgqfJCMBNIX+1w==
X-Received: by 2002:a63:a509:0:b0:36c:6a53:7cd with SMTP id n9-20020a63a509000000b0036c6a5307cdmr4153830pgf.403.1645749906317;
        Thu, 24 Feb 2022 16:45:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm698599pfi.98.2022.02.24.16.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:45:05 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:45:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 08/39] x86/linkage: Add ENDBR to SYM_FUNC_START*()
Message-ID: <202202241643.1258DB72D8@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.481071290@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.481071290@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:46PM +0100, Peter Zijlstra wrote:
> Ensure the ASM functions have ENDBR on for IBT builds, this follows
> the ARM64 example. Unlike ARM64, we'll likely end up overwriting them
> with poison.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/linkage.h |   39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> --- a/arch/x86/include/asm/linkage.h
> +++ b/arch/x86/include/asm/linkage.h
> @@ -3,6 +3,7 @@
>  #define _ASM_X86_LINKAGE_H
>  
>  #include <linux/stringify.h>
> +#include <asm/ibt.h>
>  
>  #undef notrace
>  #define notrace __attribute__((no_instrument_function))
> @@ -34,5 +35,43 @@
>  
>  #endif /* __ASSEMBLY__ */
>  
> +/*
> + * compressed and purgatory define this to disable EXPORT,
> + * hijack this same to also not emit ENDBR.
> + */
> +#ifndef __DISABLE_EXPORTS

It's certainly cleaner to avoid increasing boot stub image size, but
there's no _harm_ in including them, yes?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
