Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07FA597245
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbiHQPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiHQPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:00:38 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4419D9DB4F;
        Wed, 17 Aug 2022 07:59:55 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27HExIXk024020;
        Wed, 17 Aug 2022 23:59:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27HExIXk024020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660748359;
        bh=FHt2nZrGSCf9qOiD+r5SuwxQICecd3mmE4Ixe0LI74o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BuLVQoLue5bdPxYZKtA0km06WMwIjeTWGNEH2H5YAPLnANatHAojD52WGxKQ3+e4R
         /2keW2hRsCybPEitAcPJbQ421et3T3muUqxlKImUFSv+pKkuYBlGf9yzTeLLy8u4c5
         F8/yeuCshPjE8UPI6a1A+9BjP4u3xWppDFbDIX/sy0TClfKfjQ9xPq79tdse4/TSsh
         sB56yiD+65uthK/RO55RNqcI7Ny+kOSVVkDDabAXN41//3PtteBTeHeLMddJRvyYJN
         RKnF/FclCw8YD+szns51WmTWPvos6e3JAwXQ9GNx8RkeoODAdQZAprgAu6YQiZMQuK
         gsFg+EyfiWJVg==
X-Nifty-SrcIP: [209.85.221.50]
Received: by mail-wr1-f50.google.com with SMTP id f8so2832162wru.13;
        Wed, 17 Aug 2022 07:59:19 -0700 (PDT)
X-Gm-Message-State: ACgBeo1dVcfZnEZd2/Wgl5vM1t1xW3crEp1jaG5W0Fyp2+40k19vAW9P
        wy70G0gj+CMidx0zkB23NowNEkFhtd04tItR5Wo=
X-Google-Smtp-Source: AA6agR6CbTRfX2of9AxOS02diGmGtpMLUScSdMhG/oInVkxzstjB3b5SizwmELRx8+M3XRta/GU+UAO6T4P7zadKzRU=
X-Received: by 2002:a5d:6d89:0:b0:225:16c2:6816 with SMTP id
 l9-20020a5d6d89000000b0022516c26816mr4942806wrs.380.1660748357841; Wed, 17
 Aug 2022 07:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220813230928.1260981-1-masahiroy@kernel.org>
In-Reply-To: <20220813230928.1260981-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 17 Aug 2022 23:58:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0jxKzBE454dVB48UEOK4TsfK7skcKNeLNu92XkjuaEQ@mail.gmail.com>
Message-ID: <CAK7LNAS0jxKzBE454dVB48UEOK4TsfK7skcKNeLNu92XkjuaEQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix the modules order between drivers and libs
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 8:10 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit b2c885549122 ("kbuild: update modules.order only when contained
> modules are updated") accidentally changed the modules order.
>
> Prior to that commit, the modules order was determined based on
> vmlinux-dirs, which lists core-y/m, drivers-y/m, libs-y/m, in this order.
>
> Now, subdir-modorder lists them in a different order: core-y/m, libs-y/m,
> drivers-y/m.
>
> Presumably, there was no practical issue because the modules in drivers
> and libs are orthogonal, but there is no reason to have this distortion.
>
> Get back to the original order.
>
> Fixes: b2c885549122 ("kbuild: update modules.order only when contained modules are updated")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


Applied to linux-kbuild/fixes.


>
>  Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5f5c43a52455..c4e06e8020f1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1113,13 +1113,11 @@ vmlinux-alldirs := $(sort $(vmlinux-dirs) Documentation \
>                      $(patsubst %/,%,$(filter %/, $(core-) \
>                         $(drivers-) $(libs-))))
>
> -subdir-modorder := $(addsuffix modules.order,$(filter %/, \
> -                       $(core-y) $(core-m) $(libs-y) $(libs-m) \
> -                       $(drivers-y) $(drivers-m)))
> -
>  build-dirs     := $(vmlinux-dirs)
>  clean-dirs     := $(vmlinux-alldirs)
>
> +subdir-modorder := $(addsuffix /modules.order, $(build-dirs))
> +
>  # Externally visible symbols (used by link-vmlinux.sh)
>  KBUILD_VMLINUX_OBJS := $(head-y) $(patsubst %/,%/built-in.a, $(core-y))
>  KBUILD_VMLINUX_OBJS += $(addsuffix built-in.a, $(filter %/, $(libs-y)))
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
