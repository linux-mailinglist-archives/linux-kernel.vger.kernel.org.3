Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A2357C28C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiGUDHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiGUDHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:07:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7576968
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:07:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y15so560284plp.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JJsfXNv1FHZgTAoKlvGqSQpITNzAU7fYy3uQqMo2kbI=;
        b=ik/mzHqQMTGzBtVOhu6+Tszpi2JCmMfPnLKH3y1IZ+IUv+bz214IzHXI54X1w+Zde5
         CKPoPlGnq69cu39KLhs+0Jubu+aTXBXItoxPyPIwVnAv4ZjVTRVeZb0jVny/HG1khddJ
         GsOHPvuFrhHApaY+WTi5u7uoSRGVUdWh1sSQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JJsfXNv1FHZgTAoKlvGqSQpITNzAU7fYy3uQqMo2kbI=;
        b=AnzsVtKxUIaYPN3dHkSXF3G542j3ip9ZmHqOiln0v7TVIx7bsxdSnmmuuoJW2HFnKx
         QXqA3Ma4i8NOOw4AF8TZqUOeU2N86QxY2L9N5sbEbjx+IsaRjuWDfb6wEH259ylfVNG9
         Jd+B65xYz26xY+kas7g0DtfO8/ZnKwQecz/maPZ2mfiOZDlm0NyT9UI84+uOj+DiVcL8
         qUoQDdb0wqixC5i8V+Q+fiqIwjj/8RuI6zy7VDuqSsB1PeCWXjlKt0zJ0T7hEHlAD7yc
         AYQMy4LE3lwbsKInGHSMKveAOXbmuVBKm8uiT/xlO33YHTF9wuGXNqMn6AM41yklbviY
         2uFA==
X-Gm-Message-State: AJIora/lr7X79pCpY6lOSBlCWbWO+AqQ7nti+XGzhZNLRcNjlywTiIQS
        G4YS/WpTc5MyFv/tjRTfSGIHHu6Eilj8cQ==
X-Google-Smtp-Source: AGRyM1vd8vVEUotQ5VpffOqWTYHhp2UChlLFW4c/qTqVN0sXNLfpBQb6TiQQF38vJTd3HPi3JPMSPg==
X-Received: by 2002:a17:902:ecca:b0:16b:d519:d1df with SMTP id a10-20020a170902ecca00b0016bd519d1dfmr40385385plh.170.1658372836470;
        Wed, 20 Jul 2022 20:07:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h34-20020a632122000000b003fcf1279c84sm235305pgh.33.2022.07.20.20.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 20:07:16 -0700 (PDT)
Date:   Wed, 20 Jul 2022 20:07:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] lkdtm: Disable return thunks in rodata.c
Message-ID: <202207202006.5FA88C7981@keescook>
References: <8ec0039712f252693049c70ed3891d39a2357112.1658155446.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec0039712f252693049c70ed3891d39a2357112.1658155446.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 07:50:25AM -0700, Josh Poimboeuf wrote:
> The following warning was seen:
> 
>   WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:557 apply_returns (arch/x86/kernel/alternative.c:557 (discriminator 1))
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc4-00008-gee88d363d156 #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
>   RIP: 0010:apply_returns (arch/x86/kernel/alternative.c:557 (discriminator 1))
>   Code: ff ff 74 cb 48 83 c5 04 49 39 ee 0f 87 81 fe ff ff e9 22 ff ff ff 0f 0b 48 83 c5 04 49 39 ee 0f 87 6d fe ff ff e9 0e ff ff ff <0f> 0b 48 83 c5 04 49 39 ee 0f 87 59 fe ff ff e9 fa fe ff ff 48 89
> 
> The warning happened when apply_returns() failed to convert "JMP
> __x86_return_thunk" to RET.  It was instead a JMP to nowhere, due to the
> thunk relocation not getting resolved.
> 
> That rodata.o code is objcopy'd to .rodata, and later memcpy'd, so
> relocations don't work (and are apparently silently ignored).
> 
> LKDTM is only used for testing, so the naked RET should be fine.  So
> just disable return thunks for that file.
> 
> While at it, disable objtool and KCSAN for the file.
> 
> Fixes: 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/lkml/Ys58BxHxoDZ7rfpr@xsang-OptiPlex-9020/
> Debugged-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/Makefile           | 1 +
>  drivers/misc/lkdtm/Makefile | 9 ++++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 1f40dad30d50..7854685c5f25 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -27,6 +27,7 @@ RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
>  RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
>  endif
>  
> +export RETHUNK_CFLAGS
>  export RETPOLINE_CFLAGS
>  export RETPOLINE_VDSO_CFLAGS
>  
> diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
> index 2e0aa74ac185..95ef971b5e1c 100644
> --- a/drivers/misc/lkdtm/Makefile
> +++ b/drivers/misc/lkdtm/Makefile
> @@ -13,10 +13,13 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
>  lkdtm-$(CONFIG_LKDTM)		+= fortify.o
>  lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
>  
> -KASAN_SANITIZE_rodata.o		:= n
>  KASAN_SANITIZE_stackleak.o	:= n
> -KCOV_INSTRUMENT_rodata.o	:= n
> -CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
> +
> +KASAN_SANITIZE_rodata.o			:= n
> +KCSAN_SANITIZE_rodata.o			:= n
> +KCOV_INSTRUMENT_rodata.o		:= n
> +OBJECT_FILES_NON_STANDARD_rodata.o	:= y
> +CFLAGS_REMOVE_rodata.o			+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
>  
>  OBJCOPYFLAGS :=
>  OBJCOPYFLAGS_rodata_objcopy.o	:= \
> -- 
> 2.36.1
> 

-- 
Kees Cook
