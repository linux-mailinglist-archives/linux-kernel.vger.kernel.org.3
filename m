Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779AD47A881
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhLTLU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhLTLU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:20:26 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F309BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 03:20:25 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so12117926otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLN1SpZ6RD9asc3ZvM6rC3P2ObMSptNgs+ADFfU5zGQ=;
        b=SzJmJWxJofq+BOBNg17kTJWsdgeWt71gm9KzwgqNGL3NDojTvxjVSlIiLbtYVyEg+P
         6HTIp0INCi18kRaZtBINKPWEs173N9uVVKBTWaNvbTThYFePj5iUPjg0SIT/iVu6kL4V
         hBId2FeLX8anQHjVI9ZxMCvmzdTB4UPnpQhMHo26XHSrTyRoe7zig6z2ULehK+v/qsR6
         /FRFvaTZN7EGbcy6fkhYqxU85T1c4NDgVYpBa+aX0Zo3ufqvY152GTULprMKRYE84FrO
         va44wLI7Y+uyVip4/3t7kw/2CLrgqd3uIZNhnhwL3VZw5U7fI62/JPYOhvfsSCxKn/Ns
         mbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLN1SpZ6RD9asc3ZvM6rC3P2ObMSptNgs+ADFfU5zGQ=;
        b=sA1hgO0qLiJA2IauMx61K0TZmIspiXtqcxR5D73mYMPSR1tm6itJ8m7MKDpJEQq+wI
         Th+k1bIqw9AYiMGDJsuhm9hLxkdzd1CvG3p7uRs8zDRDjO9j75UP8ljI/52JMbuiPvpT
         cPuiBs9WGvJ7GVMJbLD69hDPD5TO9HrfJazfWM/3flfJduQwyA5XnAQlvzcbUZ+UVVdn
         829+bKcitUg83d1iRKl0UQPosiIRk64b1gXTKAG/B4IkKT/n625Mk+dkLI21VYAVrZdJ
         2xZ/ZXWTOqDTtu8xY5DFf7aKqCuNEugSBpa8FgIyvmKY0kKuX+ssE4AaWbp3YeXLaKXp
         oHKQ==
X-Gm-Message-State: AOAM532vfl2msXoHeXeToVHaLkLiNctYCpiMR4A8gU3nJgt1Iwb/yrF+
        FXTjYLuVz2vdERXBxi6t10QETUAgHZv23FyV+OLaGg==
X-Google-Smtp-Source: ABdhPJzSlPIJkA1oGSHCiY9lUxcpVIcPbSbiO7nCLYrL/Eu2m6zXlIrODGvtzVGXAFhlr1ndpdPOJmgd8OKEAYm5yi4=
X-Received: by 2002:a9d:2ae1:: with SMTP id e88mr10590196otb.157.1639999225023;
 Mon, 20 Dec 2021 03:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20211220035448.12054-1-yajun.deng@linux.dev>
In-Reply-To: <20211220035448.12054-1-yajun.deng@linux.dev>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Dec 2021 12:20:13 +0100
Message-ID: <CANpmjNPsCVkq7SsVL-xpktGe3RsJnRGTJxEPZ60VUt1w_5QgPQ@mail.gmail.com>
Subject: Re: [PATCH] init: fix the wrong __setup_param() definition
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     keescook@chromium.org, samitolvanen@google.com, ojeda@kernel.org,
        masahiroy@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 at 04:55, Yajun Deng <yajun.deng@linux.dev> wrote:
>
> The parameters in __setup_param() should be four rather than three when
> MODULE isn't definited.

This is actually "when MODULE is defined". __setup_param() becomes a
nop when compiling as a module.

But that begs the question: why hasn't this been caught before?
Probably because nobody should be using __setup_param() if something
can also be compiled as a module, in which case module_param() and
friends should be used. But perhaps there are valid usecases where i
t's meant to become a nop if MODULE.

I don't object this fix, since the !MODULE __setup_param() seems like
it was meant to be defined.

Just curious: did you actually encounter a problem with some new code
using __setup_param()?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  include/linux/init.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/init.h b/include/linux/init.h
> index d82b4b2e1d25..62a77850f10e 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -355,7 +355,7 @@ void __init parse_early_options(char *cmdline);
>
>  #else /* MODULE */
>
> -#define __setup_param(str, unique_id, fn)      /* nothing */
> +#define __setup_param(str, unique_id, fn, early)/* nothing */
>  #define __setup(str, func)                     /* nothing */
>  #endif
>
> --
> 2.32.0
>
