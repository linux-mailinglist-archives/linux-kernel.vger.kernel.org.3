Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8074B31BD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 01:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354339AbiBLALK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 19:11:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiBLALI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 19:11:08 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9AD71
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:11:06 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id c10so1876720ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+YNFIwiPxLTkItYxer4dG/fpwVBfSqMZccPHFp7vxg=;
        b=NZmpYtE1ZxGwyElBafNkR5Vh4aJ8GXSp8VaQeOCOYBp1VwWwJJUiMoqzK17BW/4uj3
         O/Bjb64AuEPECbQVWeqjuSaFrC0YdyNmezhrG4nROa2GQvx2EneQQg2wnNtoRgPp1ggN
         OFSD6+ETUvQm77IU1jJ+pT4dmpbrhfgADQIrss1BP9ugdFCm7lg/JiZVjTz9NG/Pj3Cz
         1Xu9zzyYdkDQFd263M2qwapK2JYXj3dfI35qkOLskaoX/OMxefQkduSQcLWXVFV8MlWH
         kOMlWq2vcq2kECVxwdpy7QxIR/dDz58R3lpLYrUI7u9ER9fOo293JUoB6eEvKJeb+N4p
         WcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+YNFIwiPxLTkItYxer4dG/fpwVBfSqMZccPHFp7vxg=;
        b=JXLbcarqD3ORa59u5jj4IwxTmSe01bXDk2HxxbLMqONG7UMsfemMnxTv5ffhpJqmu1
         A9VMblZ8xgDChNxNBw22XNmiaoP33NMbwMNu7c+20j5VVXxAPhmUXYv0H0VGYAZlM+AZ
         mzQLTOYQb2IpLRYZYAiL2/RQ9goh+r52HBl08pi5xhAc5N8Z3JtdMDWXHvYeLNLFC7G2
         eBKMuopYDFQ6jjWW3wTOA40afboAo4xeNjM4xNat6fNZFOXQLs7+Usc+Wyq/N219vlH8
         XVoboTK67YUHT7jlo2K0Ru6ZGorr5iunnZE5J/Kscrmis9IKCJxlC1yi5p984400BZ9e
         Iz0g==
X-Gm-Message-State: AOAM531lTsy+wed1uMNJ7ojtDfdURyQCOGLsyqZMLMuyq/t6rlG1e3qm
        o+Xdk5MYvIzvJUUQFD9o3Lio1+gk0Nf8fH/DqBC0AQ==
X-Google-Smtp-Source: ABdhPJxOrcM/KH1/6FO4cPzkkOj/gwwGf25IRof3rUjEqWDzpbM8wMR1DaoWZd5wnEo9gwL91nU/CwzRAJEj0PcTDv0=
X-Received: by 2002:a05:651c:2121:: with SMTP id a33mr2450328ljq.220.1644624664475;
 Fri, 11 Feb 2022 16:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20220211014313.1790140-1-aik@ozlabs.ru>
In-Reply-To: <20220211014313.1790140-1-aik@ozlabs.ru>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Feb 2022 16:10:52 -0800
Message-ID: <CAKwvOdkKsoYw9KOfwdHYg7OkTz0TQ6YgZZcqQ5PNg+_O1Q5bgg@mail.gmail.com>
Subject: Re: [RFC PATCH kernel] trace: Make FTRACE_MCOUNT_USE_RECORDMCOUNT configurable
To:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Sami, Kees

Do you guys remember why we don't support
FTRACE_MCOUNT_USE_RECORDMCOUNT with LTO?
https://patchwork.kernel.org/project/linux-kbuild/patch/20201013003203.4168817-12-samitolvanen@google.com/?

On Thu, Feb 10, 2022 at 5:43 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> For whatever reason LLVM does not allow LTO (Link Time Optimization) if
> FTRACE_MCOUNT_USE_RECORDMCOUNT is enabled.
>
> This allows disabling just this option instead of disabling all FTRACE
> options.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> Or disabling FTRACE is the right thing to do if HAS_LTO_CLANG=y?
>
> Came from arch/Kconfig:
>
> config HAS_LTO_CLANG
>         def_bool y
>         depends on CC_IS_CLANG && LD_IS_LLD && AS_IS_LLVM
>         depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
>         depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
>         depends on ARCH_SUPPORTS_LTO_CLANG
>         depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT  <======
>         depends on !KASAN || KASAN_HW_TAGS
>         depends on !GCOV_KERNEL
>
>
> ---
>  kernel/trace/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index a5eb5e7fd624..87d82d2b0b0b 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -704,7 +704,8 @@ config FTRACE_MCOUNT_USE_OBJTOOL
>         depends on FTRACE_MCOUNT_RECORD
>
>  config FTRACE_MCOUNT_USE_RECORDMCOUNT
> -       def_bool y
> +       bool "Enable FTRACE_MCOUNT_USE_RECORDMCOUNT"
> +       default y
>         depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
>         depends on !FTRACE_MCOUNT_USE_CC
>         depends on !FTRACE_MCOUNT_USE_OBJTOOL
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
