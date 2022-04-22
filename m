Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB1A50B949
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448242AbiDVN7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiDVN7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:59:46 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A695A091;
        Fri, 22 Apr 2022 06:56:51 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id r189so14625482ybr.6;
        Fri, 22 Apr 2022 06:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iDPNffDsOVUBxUnp9TXoN3e3G+vjyNtpWrssmYmq2dA=;
        b=Nm7Hob+qmw7s8XAKOE7ienQbCUXWM4WR2v4nAlSqPYSEBDPv9gLkq4dYi6KtcHSF/W
         eqCLnlssVCLeTiRze8o/L55ofFqbV4AENpLkf6dYspMQEAWMahkBwTfHpMDfczSTBszU
         XZ2/2gw7kw0QQCf5lZBEw3tekw8LZHeEeapoTDqzq3K4OuRp0M44P+0R0rjzY0cTo6MW
         Uq4ZE31YRw5PF4EozkZUjJgj/r2tdo+gRmlkFkNWKUiPLHOcJc3LQ0Hqk3LMmJ6QWAsi
         RRVQUcmVJKkVTZ6XvFsfMo1snnfBmxvawPwUFiTnYEXJ65yymkY+AgzUDHXQAryqjCez
         UxFw==
X-Gm-Message-State: AOAM530gCmIFZpjCECC+bJhPrLhGxBY5wVMk9tq9Xl+ddUmwdSsJY1yF
        JUV5SWWcCkd9hZP5YWFKTg25+HQr9/dtTTGRUhk=
X-Google-Smtp-Source: ABdhPJyBNPF8LeeZTlSD9oYDWJ2zTJMDFP27IcbyVgGUNGc+NtQbRO4eruB9oDz9d3dvsiS7Y5wo5ImNhWRgquJQDtY=
X-Received: by 2002:a25:3cc3:0:b0:63e:6ee9:4840 with SMTP id
 j186-20020a253cc3000000b0063e6ee94840mr4789222yba.153.1650635810900; Fri, 22
 Apr 2022 06:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220418180814.1811136-1-trix@redhat.com>
In-Reply-To: <20220418180814.1811136-1-trix@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 15:56:40 +0200
Message-ID: <CAJZ5v0ivfLtbEL2h1ivATmTTE0+AxWXeZnbCrfF8R=Y-7rfkcA@mail.gmail.com>
Subject: Re: [PATCH] powercap/dtpm: move dtpm_subsys definition to dtpm.c
To:     Tom Rix <trix@redhat.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 8:08 PM Tom Rix <trix@redhat.com> wrote:
>
> Smatch reports this issue
> dtpm_devfreq.c:200:24: warning: symbol 'dtpm_devfreq_ops'
>   was not declared. Should it be static?
>
> dtpm_devfreq_ops is declared in dtpm_subsys.h where it
> is also used
>
> extern struct dtpm_subsys_ops dtpm_devfreq_ops;
> struct dtpm_subsys_ops *dtpm_subsys[] = {
> ...
>         &dtpm_devfreq_ops,
>
> Global variables should not be defined in header files.
> This only works because dtpm.c is the only includer
> of dtpm_subsys.h and user of dtpm_susys[].
>
> Move the definition of dtpm_subsys[] to dtpm.c and change
> the storage-class specifier to static.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Daniel, any comments?

Or do you want to pick it up yourself?

> ---
>  drivers/powercap/dtpm.c        | 9 +++++++++
>  drivers/powercap/dtpm_subsys.h | 9 ---------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index ce920f17f45f..827a2509bec7 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -29,6 +29,15 @@
>
>  #define DTPM_POWER_LIMIT_FLAG 0
>
> +static struct dtpm_subsys_ops *dtpm_subsys[] = {
> +#ifdef CONFIG_DTPM_CPU
> +       &dtpm_cpu_ops,
> +#endif
> +#ifdef CONFIG_DTPM_DEVFREQ
> +       &dtpm_devfreq_ops,
> +#endif
> +};
> +
>  static const char *constraint_name[] = {
>         "Instantaneous",
>  };
> diff --git a/drivers/powercap/dtpm_subsys.h b/drivers/powercap/dtpm_subsys.h
> index db1712938a96..2db9a3efba93 100644
> --- a/drivers/powercap/dtpm_subsys.h
> +++ b/drivers/powercap/dtpm_subsys.h
> @@ -10,13 +10,4 @@
>  extern struct dtpm_subsys_ops dtpm_cpu_ops;
>  extern struct dtpm_subsys_ops dtpm_devfreq_ops;
>
> -struct dtpm_subsys_ops *dtpm_subsys[] = {
> -#ifdef CONFIG_DTPM_CPU
> -       &dtpm_cpu_ops,
> -#endif
> -#ifdef CONFIG_DTPM_DEVFREQ
> -       &dtpm_devfreq_ops,
> -#endif
> -};
> -
>  #endif
> --
> 2.27.0
>
