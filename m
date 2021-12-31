Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5C482436
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 14:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhLaNeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 08:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhLaNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 08:34:20 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED25C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 05:34:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h2so49755081lfv.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 05:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wp/ltEVoPdzx2pRrEQ4BgyolvgNnR0QMjtwXZXnrtlw=;
        b=iJgVB5rwvhuY7YqV1NkNfAfGGzf3TsdX+4Yvwz+pt4/gquZhGZvP6eouNx6pVtQmQx
         Y4/cKGy4OMIlCsWlgJMlmX7nXH0J7tkezAKvB70haBI7YFAQXX1VWNAxVLB9GSt/x7zL
         oj70jZ5FUcOIw5KhZIBQrrZkC5kOT4qLtbmw0fXa6/7cSSmg+VFZjVCarnNUem/Vw/l6
         3/fMA3eyE/dgMBlhJqkwakQCLWnqmTIYsnzR/Q8w1tHguBwB+c9cPGWV/NXMt03vgf9h
         RGOemVhzhGdPcStcVEdgzYZGRdXmLMtuEygLD+Q3LljaF4c+tYjJ0OF5YEKAlHfplTMj
         VfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wp/ltEVoPdzx2pRrEQ4BgyolvgNnR0QMjtwXZXnrtlw=;
        b=vtHYngtgAfODaA3IVCabPsWYMtqMx468HYlQFfwZLoUIZQEFXgW+Kag2D30tK9e9Um
         wDAm+XQNhzl70MHuKXJ/L3sjUPsRMNUi9cZmFBMVUaYIs80KvLjW7xhmRRln62U9qgfA
         344BXoK7FzdHWN+xU+aU2gK0oowebRbE0wsYfo7OCQYFa3A2ezbyeHEPw/4ahzqdozq4
         RGZga7KZ38ZG9DfAcWc5ppbQPXNp5K+4TQteq7ImtxF2IDiBUk9Uhph0VSv3MPy9ITcU
         HdlIWuqzNYxoNLj2O3sgOaVVuAIv1L72MzIsYnXj6b7FZ59uUZe040kOdg5LGzz1WuAk
         awLg==
X-Gm-Message-State: AOAM5310CMhHu2LJXS/e9RUcjXUagsyCIdPe7Sh3oQfvLMdqEDeyGrSe
        P+qWEDtHMRjcVN1j/VWkouL0a55O6xCQN4vNaOKT2w==
X-Google-Smtp-Source: ABdhPJyRGhHv/2JtqLwUHFfFhC+MlVhOY4g6rwByr1LJ1qx2O3WBLs8LcdIWIt/sNquPovNd06q+x9OHrETHj/cwPtw=
X-Received: by 2002:a05:6512:3d9e:: with SMTP id k30mr31899208lfv.184.1640957657751;
 Fri, 31 Dec 2021 05:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org> <20211218130014.4037640-2-daniel.lezcano@linaro.org>
In-Reply-To: <20211218130014.4037640-2-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Dec 2021 14:33:41 +0100
Message-ID: <CAPDyKFpY4i0Mtb==8zknsuG0HdhPW2fXFvEN+AJScVmT65A-ow@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] powercap/drivers/dtpm: Move dtpm table from init
 to data section
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The dtpm table is used to let the different dtpm backends to register
> their setup callbacks in a single place and preventing to export
> multiple functions all around the kernel. That allows the dtpm code to
> be self-encapsulated.

Well, that's not entirely true. The dtpm code and its backends (or
ops, whatever we call them) are already maintained from a single
place, the /drivers/powercap/* directory. I assume we intend to keep
it like this going forward too, right?

That is also what patch4 with the devfreq backend continues to conform to.

>
> The dtpm hierarchy will be passed as a parameter by a platform
> specific code and that will lead to the creation of the different dtpm
> nodes.
>
> The function creating the hierarchy could be called from a module at
> init time or when it is loaded. However, at this moment the table is
> already freed as it belongs to the init section and the creation will
> lead to a invalid memory access.
>
> Fix this by moving the table to the data section.

With the above said, I find it a bit odd to put a table in the data
section like this. Especially, since the only remaining argument for
why, is to avoid exporting functions, which isn't needed anyway.

I mean, it would be silly if we should continue to put subsystem
specific tables in here, to just let them contain a set of subsystem
specific callbacks.

>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Kind regards
Uffe

> ---
>  include/asm-generic/vmlinux.lds.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 42f3866bca69..50d494d94d6c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -362,7 +362,8 @@
>         BRANCH_PROFILE()                                                \
>         TRACE_PRINTKS()                                                 \
>         BPF_RAW_TP()                                                    \
> -       TRACEPOINT_STR()
> +       TRACEPOINT_STR()                                                \
> +       DTPM_TABLE()
>
>  /*
>   * Data section helpers
> @@ -723,7 +724,6 @@
>         ACPI_PROBE_TABLE(irqchip)                                       \
>         ACPI_PROBE_TABLE(timer)                                         \
>         THERMAL_TABLE(governor)                                         \
> -       DTPM_TABLE()                                                    \
>         EARLYCON_TABLE()                                                \
>         LSM_TABLE()                                                     \
>         EARLY_LSM_TABLE()                                               \
> --
> 2.25.1
>
