Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA3576A52
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiGOXC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiGOXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:02:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604BC52FDD;
        Fri, 15 Jul 2022 16:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDFEE61E4C;
        Fri, 15 Jul 2022 23:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C08C3411E;
        Fri, 15 Jul 2022 23:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657926129;
        bh=EKzIF14lKdREt9dKPXCkZcQ1LZ5Kt1BUS7VzPXQVbbU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m+bYhIOkq5XrOzytDNT64tEz8fTSk90GWooU/HYAAwNKJABnt/EUhBwl6pjASCszr
         087fEOubPu8C9QPRI2Cpy36NxU+/tKkkmAni/lwKoXgF1up+ZzH439an8hdMH91Qo3
         sh6BnJxeoQPgpp/uw9eMiKR8jRkWNWI4N9+Cj9rKuyDQC0xa1m7P6m+T57N9AST5jl
         0QJZPA2DcgzlQZDKy53EVZw7ioLu/UJmQ52lsJv7mKnLdLY9/gX/8FlFTg3FP4nPYx
         wgTSMZdChZjWteQGXQd+p7NKrSfycbRYzv6ycSPrsSI5jkiS85SM1rIkT82v/175Pu
         zKhh2Y9fG1rUA==
Received: by mail-ua1-f41.google.com with SMTP id s3so2983427uaq.2;
        Fri, 15 Jul 2022 16:02:09 -0700 (PDT)
X-Gm-Message-State: AJIora8+czrX6go6cEAff0B3SK5Z+OQPEzgI5mEVt33cndCQlet7WyCh
        nrM87RLrJ3pPez/jK8VGNTHLOa1cLri+tOSVuA==
X-Google-Smtp-Source: AGRyM1ssXJTc3E14BnWkkD+VwK/VlT14tabaHM7d86SXd4B99OmSLHerTOBhI1fA6sEz666mOPdG44UUVuGBObKH95k=
X-Received: by 2002:ab0:298e:0:b0:382:982e:9ba8 with SMTP id
 u14-20020ab0298e000000b00382982e9ba8mr6338928uap.36.1657926128193; Fri, 15
 Jul 2022 16:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220623144357.297252-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20220623144357.297252-1-dmitry.baryshkov@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Jul 2022 17:01:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLi31FPBdYPzEW__UmfMTur-0428okopFYVaCbwm045gg@mail.gmail.com>
Message-ID: <CAL_JsqLi31FPBdYPzEW__UmfMTur-0428okopFYVaCbwm045gg@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Enable DT schema checks for %.dtb targets
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tom Rini <trini@konsulko.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 8:44 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> It is possible to build a single dtb, but not with DT schema validation
> enabled. Enable the schema validation to run for %.dtb and %.dtbo
> targets. Anyone building a dtb for a specific platform *should* pay
> attention to schema warnings.
>
> This could be supported with a separate %.dt.yaml target instead.
> However, the .dt.yaml format is considered an intermediate format and
> could possibly go away at some point if schema checking is integrated
> into dtc. Also, the plan is to enable the schema checks by default once
> platforms are free of warnings, and this is a move in that direction.
>
> This patch differs from the previous one ([1]) in the fact that it
> requires specifying VALIDATE_DT=1 to run the checks while doing the
> build. Thus default build procedures would not obtain additional build
> dependency, while maintainers can still build a single DTB file an get
> only corresponding warnings.

I'd rather this be a kconfig option, so that eventually 'make
allmodconfig; make dtbs' also runs the schema checks. If something can
be enabled for allmodconfig, then builders will automatically start
testing it. Though the extra dependency is a problem here.

>
> [1] https://lore.kernel.org/all/20210913145146.766080-1-robh@kernel.org/
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Co-developed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Makefile | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c43d825a3c4c..0942922384c4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1365,11 +1365,17 @@ endif
>
>  ifneq ($(dtstree),)
>
> -%.dtb: include/config/kernel.release scripts_dtc
> -       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +ifneq ($(VALIDATE_DT),)
> +DT_YAML = $(dtstree)/$*.dt.yaml

.dt.yaml files are deprecated now. This probably doesn't do anything.

> +DT_CHECK = dt_binding_check
> +export CHECK_DTBS=y
> +endif
>
> -%.dtbo: include/config/kernel.release scripts_dtc
> -       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +%.dtb: include/config/kernel.release scripts_dtc $(DT_CHECK)
> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@ $(DT_YAML)
> +
> +%.dtbo: include/config/kernel.release scripts_dtc $(DT_CHECK)
> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@ $(DT_YAML)
>
>  PHONY += dtbs dtbs_install dtbs_check
>  dtbs: include/config/kernel.release scripts_dtc
> @@ -1654,6 +1660,10 @@ help:
>         @echo  '                3: more obscure warnings, can most likely be ignored'
>         @echo  '                e: warnings are being treated as errors'
>         @echo  '                Multiple levels can be combined with W=12 or W=123'
> +       @$(if $(dtstree), \
> +               echo '  make VALIDATE_DT=y [targets] Validate all DT processsed during the build'; \

Typo.


> +               echo '         This can be applied both to "dtbs" and to individual "foo.dtb" targets' ; \
> +               )
>         @echo  ''
>         @echo  'Execute "make" or "make all" to build all targets marked with [*] '
>         @echo  'For further info see the ./README file'
> --
> 2.35.1
>
