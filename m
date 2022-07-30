Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF4585B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiG3RUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiG3RUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 13:20:52 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131A517588;
        Sat, 30 Jul 2022 10:20:49 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 26UHKUAB027213;
        Sun, 31 Jul 2022 02:20:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 26UHKUAB027213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659201631;
        bh=JttvlRFg6A7a6IS9/qWvYj23vzeOPXItUhbK0OqnR88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OA1rWReB+yU0ViAT+X2ZE2pzIcrKI2uvXQrXFXFnlaDCKWg79Qb900GmZZsks0mOp
         2zqlk8PQRQQv0yTxafU+MMJSgHfuEMlFFNuBJE8A5y3o0UEJ0ilYfQftQ0eg63fbVZ
         vjroVuAWuBWYh0v9+CRzRdP6EYi35XqVfBMutsD1iDQtJE1JNc4WBb7RHR0qP9jam4
         F/1fUvxpOHWp5/OZBFKrmuHjBnYh4ctKd/yoh1RRXsQUzGSJmEbWXp7CxwP1pppaxl
         e5IfI1uxHtQ3BKkkjPVZEb6TpU+HLKgxl2E6k00lHL+mPVaxGEVqaUdAKrDZ+fifQL
         pRWEhIgZDBdLw==
X-Nifty-SrcIP: [209.85.128.47]
Received: by mail-wm1-f47.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso3786512wmq.3;
        Sat, 30 Jul 2022 10:20:31 -0700 (PDT)
X-Gm-Message-State: AJIora9Gkp/bQe4WCziq3B9LnYWMWv+LFJXUHLVP4/5i9bRvgGAGjAjY
        aLfJn/c6mKhwvwvhbrbfj90YYYDSJMOiiRu2o+8=
X-Google-Smtp-Source: AGRyM1uDfrzdG2MpOEaQMQhWUN572domreJD0fYw/Z9G/D4OnxReQJfSj1Ne7OzwKiTweGxMO35J8ylaPdNRnomBqUk=
X-Received: by 2002:a05:600c:35ce:b0:3a3:1b7f:bbd8 with SMTP id
 r14-20020a05600c35ce00b003a31b7fbbd8mr5877386wmq.22.1659201629632; Sat, 30
 Jul 2022 10:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220724095919.436126-1-masahiroy@kernel.org>
In-Reply-To: <20220724095919.436126-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 31 Jul 2022 02:19:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ7rkSGBs0FLU=f54iAX58U3kkKJ25eT4-6u=W=aoA0nA@mail.gmail.com>
Message-ID: <CAK7LNAQ7rkSGBs0FLU=f54iAX58U3kkKJ25eT4-6u=W=aoA0nA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add dtbs_prepare target
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 7:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Factor out the common prerequisites for DT compilation into the new
> target, dtbs_prepare.
>
> Add comments to explain why include/config/kernel.release is the
> prerequisite. Our policy is that installation targets must not rebuild
> anything in the tree. If 'make modules_install' is executed as root,
> include/config/kernel.release may be owned by root.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>

Applied to linux-kbuild.

> Changes for v2:
>  - rephase the comment more concise
>
>  Makefile | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index dee707c98bbe..a2a030f41e65 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1370,16 +1370,21 @@ endif
>
>  ifneq ($(dtstree),)
>
> -%.dtb: include/config/kernel.release scripts_dtc
> +%.dtb: dtbs_prepare
>         $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>
> -%.dtbo: include/config/kernel.release scripts_dtc
> +%.dtbo: dtbs_prepare
>         $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>
> -PHONY += dtbs dtbs_install dtbs_check
> -dtbs: include/config/kernel.release scripts_dtc
> +PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
> +dtbs: dtbs_prepare
>         $(Q)$(MAKE) $(build)=$(dtstree)
>
> +# include/config/kernel.release is actually needed when installing DTBs because
> +# INSTALL_DTBS_PATH contains $(KERNELRELEASE). However, we do not want to make
> +# dtbs_install depend on it as dtbs_install may run as root.
> +dtbs_prepare: include/config/kernel.release scripts_dtc
> +
>  ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
>  export CHECK_DTBS=y
>  dtbs: dt_binding_check
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
