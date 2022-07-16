Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2978576FED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiGPPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:39:29 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E185E03A;
        Sat, 16 Jul 2022 08:39:28 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 26GFd0QT023258;
        Sun, 17 Jul 2022 00:39:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 26GFd0QT023258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657985941;
        bh=4LPVf+VR1PUnzuCLPExyIR/KKB7VKA49OluYxgnCfT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lRcUsT+IT2FEeRmQ/kIvtzFEUHKFNses9XYR9U80+DhIuCmP8seuYazfJAxR5mbHU
         7Lr0WZM2euUnhu7iMmOyMJuiUCBLkkszRzHY+kRtX/eU++lds6fT/TO+t/XzJ2MRFq
         LL28dfaYGgdBKWY27xfpEEOA4jJnkmAEHkstsC9FPTN9DYplPadheL7dtwczRImpYy
         c/IN4rC2UEFzgJaAY5VeSpRrBwWKD1/mGgYLyDJtFJVX+hHUOKp80FAhsqziygUZgJ
         x4JEr2k8vVmvUjwvgAV9X2vLBdYvVg2jB6tAdLEhRH02OQgx/ToDJqcxOgkyh7M8jE
         UBVKLdJ/qN24w==
X-Nifty-SrcIP: [209.85.221.42]
Received: by mail-wr1-f42.google.com with SMTP id bu1so10611259wrb.9;
        Sat, 16 Jul 2022 08:39:01 -0700 (PDT)
X-Gm-Message-State: AJIora9npfsk6h3MHvJK7098D7CS5Pnb4JhaKjeQrq8hiabD85USt7rZ
        Koz33VFcWnx21PQbJ8YhYK3C5jgZHwyoDi49g0o=
X-Google-Smtp-Source: AGRyM1vEf22qrd4TZhzJSKlvInLrRBhABoNNiiwlnYREq7ffKWXvCaHg1t6Aho78RtepXgbIyUvuInxqCGht/FdrNPw=
X-Received: by 2002:adf:d1e2:0:b0:21d:d40b:d816 with SMTP id
 g2-20020adfd1e2000000b0021dd40bd816mr6491732wrd.682.1657985939613; Sat, 16
 Jul 2022 08:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220714050243.16411-1-masahiroy@kernel.org> <20220714050243.16411-3-masahiroy@kernel.org>
In-Reply-To: <20220714050243.16411-3-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 17 Jul 2022 00:38:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASP+aXcVY9sm+yM0pYFBCqPxqA-n8TYEwDpqSCjRXx_zg@mail.gmail.com>
Message-ID: <CAK7LNASP+aXcVY9sm+yM0pYFBCqPxqA-n8TYEwDpqSCjRXx_zg@mail.gmail.com>
Subject: Re: [PATCH 3/4] kbuild: error out if $(KBUILD_EXTMOD) contains % or :
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
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

On Thu, Jul 14, 2022 at 2:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> If the directory pass given to KBUILD_EXTMOD (or M=) contains % or :,

This is a typo.

directory pass -> directory path




> the module fails to build.
>
> % is used in pattern rules, and : as the separator of dependencies.
>
> Bail out with a clearer error message.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index faa4880f25f7..ecda62e27553 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -129,6 +129,9 @@ endif
>  $(if $(word 2, $(KBUILD_EXTMOD)), \
>         $(error building multiple external modules is not supported))
>
> +$(foreach x, % :, $(if $(findstring $x, $(KBUILD_EXTMOD)), \
> +       $(error module directory path cannot contain '$x')))
> +
>  # Remove trailing slashes
>  ifneq ($(filter %/, $(KBUILD_EXTMOD)),)
>  KBUILD_EXTMOD := $(shell dirname $(KBUILD_EXTMOD).)
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
