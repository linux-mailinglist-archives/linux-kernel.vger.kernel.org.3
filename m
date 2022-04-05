Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6724F21DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiDECsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiDECse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:48:34 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3117538D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:55:00 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2351slYC031730
        for <linux-kernel@vger.kernel.org>; Tue, 5 Apr 2022 10:54:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2351slYC031730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649123688;
        bh=BZqpMP9OnBPMQP9yZDJGu4UQXOLFYVeLZWykIihy5vA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tqPhO1GoXh/5l3l1nAUpOPChsl1wbUg7BcpV6r8auyYo6+cOYiF/VR/93WDH4+q7Y
         UXsZmO1TjJlkTd4lBOWyoKNADo2iW13Uu2+v4rtXAiH5G5gMA3lajHVWjXqntRDMYW
         ama+GlGyd6Zt37dzjtx2D/LvJ9y71soDBsyufJ/3MvM3ivfNpSh3SOkhW+MswrM49D
         08XzlcNiUq+3VHrMVVPRIgoGoAKM8iOAYlDDEEGKg6aHr029STL2f9+0F15f+mA41h
         tzmDD2fU9ra+7CnOJ6VEna64j5A1lMqYmK9LA3REMxc2TrIsjbGa5dk1rXhc0TLjUn
         Q201B+eLHwWQg==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id j8so9641342pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:54:47 -0700 (PDT)
X-Gm-Message-State: AOAM530bp7NRgphVLjxoerVjfnO2feQ+bPWP9sUnxAFi/HhTZdstJrg6
        vKRw7JT5kMyvoxerxtD9EXMdkgVl6bxooLSB8TM=
X-Google-Smtp-Source: ABdhPJw7i4Bl3cgYF5GL7LELB6T+8VsdQz64gO8ln8C2/GXWuSdkIhmdrdyO8iwVIkhqwS4NRc5zIdd6xtrCmN59Xz8=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr1147223plr.136.1649123686883; Mon, 04
 Apr 2022 18:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220330183409.2025109-1-ndesaulniers@google.com>
In-Reply-To: <20220330183409.2025109-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 5 Apr 2022 10:53:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvbFMnhrokkbQZjmCYTmj-v4pR60-5dYpezBNDm6imug@mail.gmail.com>
Message-ID: <CAK7LNAQvbFMnhrokkbQZjmCYTmj-v4pR60-5dYpezBNDm6imug@mail.gmail.com>
Subject: Re: [PATCH] kbuild: uapi: use -fsyntax-only rather than -S
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 3:34 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The UAPI header tests are checking that the generated headers do not
> have syntax errors. There's no need to run the rest of the compilation
> pipeline after semantic analysis has run. Replace -S -o /dev/null with
> -fsyntax-only.
>

Applied to linux-kbuild.
Thanks.


> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  usr/include/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 7b283d43f00d..bf193e205dbe 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -89,7 +89,7 @@ extra-y := $(patsubst $(obj)/%.h,%.hdrtest, $(shell find $(obj) -name '*.h' 2>/d
>  # Include the header twice to detect missing include guard.
>  quiet_cmd_hdrtest = HDRTEST $<
>        cmd_hdrtest = \
> -               $(CC) $(c_flags) -S -o /dev/null -x c /dev/null \
> +               $(CC) $(c_flags) -fsyntax-only -x c /dev/null \
>                         $(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
>                 $(PERL) $(srctree)/$(src)/headers_check.pl $(obj) $(SRCARCH) $<; \
>                 touch $@
>
> base-commit: 74164d284b2909de0ba13518cc063e9ea9334749
> --
> 2.35.1.1021.g381101b075-goog
>


-- 
Best Regards
Masahiro Yamada
