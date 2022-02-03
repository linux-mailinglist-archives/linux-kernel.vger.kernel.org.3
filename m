Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5291D4A8D36
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354048AbiBCU24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiBCU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:28:55 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BB3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 12:28:54 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t7so5562136ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 12:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dE4PlMp2a1dru6Yvr00TjP4LGifoJOnJbdvY7D0qQXE=;
        b=izHSx7DC4nrqxIgxZRJkLP9jOC0nX6OfOCw+aiU4VxfU9p5iz1d7bXgrw5YhlDziGm
         AD6Zm0kby2e8DxyVhgQ8XNP0oOpOYLl92qCaXWrYGTPukz9i49rNYFd/t1e9gR5SlE2y
         uS3F4L4tKzV42KA7Lr2MPHcS4xw2HI0EFg3MQJhbiqQMYaGbpq0jCm0tKZSM+Zx+tHCg
         Zof8dEsghHqoIZUdw92oCH5W9rejr813ucYe6ddVV715SkDVYUCHFkc3wiPfJ9BsfsHv
         X9Xu+5i6cAArxarL7kIkWKLSBOQ9zY3kePqnlfv/rOjQEjQTdjukJLT+Kb+RjMtUptJu
         uyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dE4PlMp2a1dru6Yvr00TjP4LGifoJOnJbdvY7D0qQXE=;
        b=WMB2uhXnA2ojTPrap+UgyexbtJK6dOaprNxSgHhkU4qeRPu9odGYE2A6XyvMjhsR8L
         whWOGHbcoIop+fOJtik0mrmHeAau1ET4su+elSxpEtyEbmDNuzsELSJ3CRxRYI+sRx1y
         dwEC5akY9FqIqTArydt773o2zENtrkO5dW59b9Ar8XgpHAuUdZqKQC8GAsrlO/p6OPq7
         +0MbN1EVqLEd0FZ+t6XOs/l5bMqPUGQpYKREDbllA5AMbzmHebgPCikH0Cr2tRNjlIpI
         uW3vG7ZwuAWyM+w0F2G0dPs4uDndmHVsZiX6wlW/qM+VAoik0BZTZg5vg7zGZirRnBt7
         v/Tw==
X-Gm-Message-State: AOAM530ddUyKMHOY9lUlisP2LuRyaKgf8qpcl+i3hgu84D6CZfQrO+iU
        Bemuv4ev7b+9vHyv9N8TgOGwekYhlTcXJNt9JJJMYg==
X-Google-Smtp-Source: ABdhPJy0aTO74XJaMQm8cnUoj9YZULLzzNoEu5Fotpi4riNes6buUASDKHj9PbVaIvqx9IzWIEvDToQ7m/JIp7ytPXg=
X-Received: by 2002:a05:651c:3c7:: with SMTP id f7mr19348599ljp.62.1643920132893;
 Thu, 03 Feb 2022 12:28:52 -0800 (PST)
MIME-Version: 1.0
References: <20220203173307.1033257-1-keescook@chromium.org> <20220203173307.1033257-4-keescook@chromium.org>
In-Reply-To: <20220203173307.1033257-4-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 12:28:41 -0800
Message-ID: <CAKwvOdm7LUUotbk+mQbzXR6=UC+oEBNtq_mQbCUt0arqAbw43Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] Compiler Attributes: Add __diagnose_as for Clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
>
> Clang will perform various compile-time diagnostics on uses of various
> functions (e.g. simple bounds-checking on strcpy(), etc). These
> diagnostics can be assigned to other functions (for example, new
> implementations of the string functions under CONFIG_FORTIFY_SOURCE)
> using the "diagnose_as_builtin" attribute. This allows those functions
> to retain their compile-time diagnostic warnings.
>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/compiler_attributes.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index dc3bf2a6e1c9..df9c7e5e8818 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -100,6 +100,19 @@
>  # define __copy(symbol)
>  #endif
>
> +/*
> + * Optional: not supported by gcc
> + * Optional: only supported since clang >= 14.0
> + * Optional: not supported by icc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#diagnose_as_builtin
> + */
> +#if __has_attribute(__diagnose_as_builtin__)
> +# define __diagnose_as(builtin...)     __attribute__((__diagnose_as_builtin__(builtin)))
> +#else
> +# define __diagnose_as(builtin...)
> +#endif
> +
>  /*
>   * Don't. Just don't. See commit 771c035372a0 ("deprecate the '__deprecated'
>   * attribute warnings entirely and for good") for more information.
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
