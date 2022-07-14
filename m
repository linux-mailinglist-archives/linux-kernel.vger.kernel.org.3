Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831ED575641
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiGNURY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiGNURU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:17:20 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1D9DC1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:17:18 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 758A51F986;
        Thu, 14 Jul 2022 22:17:16 +0200 (CEST)
Date:   Thu, 14 Jul 2022 22:17:08 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tom Rini <trini@konsulko.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3] kbuild: Enable DT schema checks for %.dtb targets
Message-ID: <20220714201708.snbd4uhaeythe4ct@SoMainline.org>
References: <20220623144357.297252-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623144357.297252-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-23 17:43:57, Dmitry Baryshkov wrote:
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

Thanks, glad to see this back rather than having to resort to reverting
75e895343d5a ("Revert "kbuild: Enable DT schema checks for %.dtb
targets"") locally.

Tested-by: Marijn Suijten <marijn.suijten@somainline.org>

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
> -	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +ifneq ($(VALIDATE_DT),)
> +DT_YAML = $(dtstree)/$*.dt.yaml
> +DT_CHECK = dt_binding_check
> +export CHECK_DTBS=y
> +endif
>  
> -%.dtbo: include/config/kernel.release scripts_dtc
> -	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +%.dtb: include/config/kernel.release scripts_dtc $(DT_CHECK)
> +	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@ $(DT_YAML)
> +
> +%.dtbo: include/config/kernel.release scripts_dtc $(DT_CHECK)
> +	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@ $(DT_YAML)
>  
>  PHONY += dtbs dtbs_install dtbs_check
>  dtbs: include/config/kernel.release scripts_dtc
> @@ -1654,6 +1660,10 @@ help:
>  	@echo  '		3: more obscure warnings, can most likely be ignored'
>  	@echo  '		e: warnings are being treated as errors'
>  	@echo  '		Multiple levels can be combined with W=12 or W=123'
> +	@$(if $(dtstree), \
> +		echo '  make VALIDATE_DT=y [targets] Validate all DT processsed during the build'; \
> +		echo '         This can be applied both to "dtbs" and to individual "foo.dtb" targets' ; \
> +		)
>  	@echo  ''
>  	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
>  	@echo  'For further info see the ./README file'
> -- 
> 2.35.1
> 
