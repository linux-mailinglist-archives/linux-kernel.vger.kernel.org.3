Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB24C9540
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiCAT5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbiCAT5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:57:18 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5887460F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:56:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i11so28753479lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMi6jfjPmOmbZli1oBeEnCLh26RC8er1sFN7ImcKi+o=;
        b=hquZMrM0xczMD9ZZ2fmNHpKRRvIiE7LGxeRQJjMZze98rNEK5Ra0HRlOcHxK1KVi4e
         FQBN2HtdkQyg3o4uLsn9EldD2THulu/j3z0J4c66DGvW7dy1eAyfhY+zPXLMelBK2NVs
         vFTKlgnUUtURZxAVCwYSSRSsE1DD1TOPa1gDQr3nPyXjuZyynXejfYtMrPNZv4qIlUpD
         asXGdBdEC/EqRmjLSKU9coJTyUmLsswdnWGR9v05EWG09syjtZNPsGSHcVR0+xDYzlUn
         xQ2tt273NyMVjhC6JJKYVK3HJjm31oXEOGz7C5tWg61kUtCoX5BnnE6UEYkhMFnA1EZr
         /tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMi6jfjPmOmbZli1oBeEnCLh26RC8er1sFN7ImcKi+o=;
        b=mSzNAaRGtQx3n1AHWsyP5HbcnnzYxKsJfUSXPx/jgeX9KTsjeCxCWwzth1VVyYOjHJ
         iK4pbYhOtRXvMuA976Nf2BaPU2cInmUDvEjU1J6qdvBB9KwRYXFQzxBSrB+yXBazchnP
         BedezbU06/7AHuqcqJUx8ekf0SYRQMCgTyerayG6TBi0qk1gFlidaIyPpDO7p2XXJpEj
         i3trbsiIHrIPJS6GE6rhdoW7c6zflelr9lcC5gG1ZU1jjwRfy5TMuYcdw1++NR5Ba1ZW
         TCNJI9HvxoP7Qoukojn/Q3b/m4FnBlcP/3ZKVjvrUUV8cbZDjRpwTIxOW6SBrzRy8+Ao
         De1Q==
X-Gm-Message-State: AOAM532Ry4CJA3YuFX3W2ZfoCwmBCbgZZbRiviBHOn/srX+SRClLvXvY
        Tk9cESTxtz2PjI2tXU8FpdyhGqa1LxgQfMZTEausTA==
X-Google-Smtp-Source: ABdhPJxHJ28ixWzc8Cw9z63iY2V3Qs825Z5wYOByAiHrKjX3T4RD+ppSjBBfmC8N5GLCMcFfzTk1/mPc6px+kJRbpbg=
X-Received: by 2002:a19:2d11:0:b0:445:65c7:5f1e with SMTP id
 k17-20020a192d11000000b0044565c75f1emr16420364lfj.184.1646164576477; Tue, 01
 Mar 2022 11:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-3-arnd@kernel.org>
In-Reply-To: <20220301145233.3689119-3-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Mar 2022 11:56:05 -0800
Message-ID: <CAKwvOdnABhWN9-o0J0cN2epDJby=JX5BNGr6U_w4WiFZ7qbwig@mail.gmail.com>
Subject: Re: [PATCH 3/3] Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 6:52 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> As we change the C language standard for the kernel from gnu89 to
> gnu11, it makes sense to also update the version for user space
> compilation.
>
> Some users have older native compilers than what they use for
> kernel builds, so I considered using gnu99 as the default version
> for wider compatibility with gcc-4.6 and earlier.
>
> However, testing with older compilers showed that we already require
> HOSTCC version 5.1 as well because a lot of host tools include
> linux/compiler.h that uses __has_attribute():
>
>   CC      tools/objtool/exec-cmd.o
> In file included from tools/include/linux/compiler_types.h:36:0,
>                  from tools/include/linux/compiler.h:5,
>                  from exec-cmd.c:2:
> tools/include/linux/compiler-gcc.h:19:5: error: "__has_attribute" is not defined [-Werror=undef]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patches!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 37ef6a555dcd..7c9be7f1ccd4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -432,7 +432,7 @@ HOSTCXX     = g++
>  endif
>
>  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> -                           -O2 -fomit-frame-pointer -std=gnu89 \
> +                           -O2 -fomit-frame-pointer -std=gnu11 \
>                             -Wdeclaration-after-statement
>  export KBUILD_USERLDFLAGS :=
>
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
