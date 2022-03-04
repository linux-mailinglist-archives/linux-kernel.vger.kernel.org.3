Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2394CD9BE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiCDRJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiCDRJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:09:01 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3706FA1C;
        Fri,  4 Mar 2022 09:08:11 -0800 (PST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 224H7TJn026744;
        Sat, 5 Mar 2022 02:07:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 224H7TJn026744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646413650;
        bh=clO24AIUhkpLyHKt4VwOj26EUiZu3YGOoBgC6FInb/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vB4mc9lpAxKTaSGWELa/nOh1eER5RXmvGF7p55+SnT7ikTNe9plFUaBfYVQ7fzjba
         LQ8sCRqGJK/zb7OiTsnp2xJWM1ujBbPgS+VGP0XMoOjJbXnqwt4b48Hgx+BEsxVmS9
         aN8FEp8ghkoXwcOHuIMW0GRdu/RV6/yhwOMUXd4qbgE910xr0dvbcCyjANMptc+Rv0
         W27XEB3eapuE46Qa9AaMY/8Rni6g2lhDeADcXA7YUbfNQYs1cV2yOtG/9GASVMLAK/
         eEaSlGm6/IhGaDunCqK6s/I2uU6T5Ugkz6YtUWIrez+5wx44ej39wIVYcGH81Eq2pD
         YoUROA2Yq+f2g==
X-Nifty-SrcIP: [209.85.216.51]
Received: by mail-pj1-f51.google.com with SMTP id kx1-20020a17090b228100b001bf2dd26729so1351196pjb.1;
        Fri, 04 Mar 2022 09:07:30 -0800 (PST)
X-Gm-Message-State: AOAM5338GhUF5aYSbE9wP+sLR6Qxp5QtbEWxb7IW3+65ZT4wuouI4BAQ
        08egsczkL0k3TSuDZ06iPYuyrpJcfAbQ773Qd0I=
X-Google-Smtp-Source: ABdhPJzOgJ7utPN1EIWgXOch2+XWbpfDYZOzUWJE/LSSNuapKAXwaRM9iBI/Hm69pRw6cqUdD3+hLOutIyQrxQLQBA8=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr42721007plr.136.1646413649332; Fri, 04
 Mar 2022 09:07:29 -0800 (PST)
MIME-Version: 1.0
References: <87k0dbosis.fsf@irisa.fr>
In-Reply-To: <87k0dbosis.fsf@irisa.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 5 Mar 2022 02:06:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARV4ax0t-drWMx0G==gDmcpXJoOvRuRQ6dS440245AwjQ@mail.gmail.com>
Message-ID: <CAK7LNARV4ax0t-drWMx0G==gDmcpXJoOvRuRQ6dS440245AwjQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: add KCONFIG_ALLCONFIG support for tinyconfig
To:     Randrianaina Georges Aaron <georges-aaron.randrianaina@irisa.fr>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Acher <mathieu.acher@irisa.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 4, 2022 at 2:27 AM Randrianaina Georges Aaron
<georges-aaron.randrianaina@irisa.fr> wrote:
>
> Since f8f0d06438e5, tinyconfig overrides KCONFIG_ALLCONFIG to
> include kernel/configs/tiny-base.config. However, this ignores
> user's preset if defined.
>
> This modification checks if the user has set KCONFIG_ALLCONFIG
> and if so, concatenates it with kernel/configs/tiny-base.config
> to be used as preset config symbols.
>
> Signed-off-by: Randrianaina Georges Aaron <georges-aaron.randrianaina@irisa.fr>
> ---
>  scripts/kconfig/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index b8ef0fb4bbef..337693fb4762 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -102,7 +102,13 @@ configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/c
>
>  PHONY += tinyconfig
>  tinyconfig:
> +ifeq ($(KCONFIG_ALLCONFIG),)
>         $(Q)KCONFIG_ALLCONFIG=kernel/configs/tiny-base.config $(MAKE) -f $(srctree)/Makefile allnoconfig
> +else
> +       $(Q)cat $(KCONFIG_ALLCONFIG) <(echo) kernel/configs/tiny-base.config > .tmp.config


I assume "<(echo)" exists here to insert a blank line.
The process substitution is a bash'ism.

If you execute it on Debian or its variants, where /bin/sh is a symlink
to dash, it fails.

masahiro@grover:~/ref/linux$ make  KCONFIG_ALLCONFIG=/tmp/dummy.config
tinyconfig
/bin/sh: 1: Syntax error: "(" unexpected
make[1]: *** [scripts/kconfig/Makefile:108: tinyconfig] Error 2
make: *** [Makefile:619: tinyconfig] Error 2



We can delete '<(echo)', but another issue is that this does not work
with O=<dir> option.


masahiro@grover:~/ref/linux$ make O=foo
KCONFIG_ALLCONFIG=/tmp/dummy.config tinyconfig
make[1]: Entering directory '/home/masahiro/ref/linux/foo'
  GEN     Makefile
  HOSTCC  scripts/basic/fixdep
cat: kernel/configs/tiny-base.config: No such file or directory
make[2]: *** [../scripts/kconfig/Makefile:108: tinyconfig] Error 1
make[1]: *** [/home/masahiro/ref/linux/Makefile:619: tinyconfig] Error 2
make[1]: Leaving directory '/home/masahiro/ref/linux/foo'
make: *** [Makefile:219: __sub-make] Error 2





> +       $(Q)KCONFIG_ALLCONFIG=.tmp.config $(MAKE) -f $(srctree)/Makefile allnoconfig
> +       $(Q)rm -f .tmp.config
> +endif
>         $(Q)$(MAKE) -f $(srctree)/Makefile tiny.config
>
>  # CHECK: -o cache_dir=<path> working?
> --
> 2.34.1



--
Best Regards
Masahiro Yamada
