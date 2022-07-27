Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0383258322E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiG0Sjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243305AbiG0SjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:39:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4E58B5F;
        Wed, 27 Jul 2022 10:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 457CAB8200D;
        Wed, 27 Jul 2022 17:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9146C433B5;
        Wed, 27 Jul 2022 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658943378;
        bh=Xl6d7YyAtLFXVLl6Ln+ny8Wog2OwDSUSA9+ZSYKIOdw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IYPAGyhuvTrsIitUMGuHCgmfmlfCeZIGgKOXoWE1/ZITtnddMLiyh8HQ9KXCxZwtK
         q+czlO4HrUOL4WmwUYUtxAZR5wLXRTgmQSxnIymXS/tvmehJPVZsV50eF/ryhWxPgm
         kvR9oVsvJImHrKn5+eXBEjBwOQmP69Tofq7kW4/7NvzK8hAFe3E2CJzSf+a1go8XID
         5EUHIth9R6DtkHl6zxjhfhWm20bAm0yJ8+BEidXmx5i7Sc6XUOGHY0bPUAoLmC3dTW
         j52n66WRU3C6VR55rTGdLcQh/af5GuGqr9m+hyKjQg9vGuNf9JQHmAxNZh3KmNXJdi
         38YpuO07hImug==
Received: by mail-vs1-f51.google.com with SMTP id 125so17261625vsx.7;
        Wed, 27 Jul 2022 10:36:18 -0700 (PDT)
X-Gm-Message-State: AJIora+HBLR2Y4VYxJFFcXCY5ak8xckOJcc7FTC6mRYkUC3ze6m+tyVK
        rHcHstXbAFtkYNYS+8f1eyB9U9I3t9hNO+ygQg==
X-Google-Smtp-Source: AGRyM1sqajAmGpG1DBpnRP1OvqhcDouhF5LqwT+puFHiLc7y1VR9ZhXVBVVc1JXtlVOPyDLfejXswbayiyasf8Agx3o=
X-Received: by 2002:a05:6102:21aa:b0:35a:1419:1bc7 with SMTP id
 i10-20020a05610221aa00b0035a14191bc7mr2601385vsb.26.1658943377685; Wed, 27
 Jul 2022 10:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 27 Jul 2022 11:36:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
Message-ID: <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while
 checking dtbs
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> It is useful to be able to recheck dtbs files against a limited set of
> DT schema files. This can be accomplished by using differnt
> DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> for some reason if_changed_rule doesn't pick up the rule_dtc changes
> (and doesn't retrigger the build).
>
> Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> and dt-validate into a single new command. Then if_changed_dep triggers
> on DT_SCHEMA_FILES changes and reruns the build/check.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  scripts/Makefile.lib | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index c88b98b5dc44..3df470289382 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
>  DT_BINDING_DIR := Documentation/devicetree/bindings
>  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
>
> -quiet_cmd_dtb_check =  CHECK   $@
> -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> +quiet_cmd_dtb =        DTC/CHECK   $@

This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
always do just 'DTC'. I can fixup when applying.

I'll give it a few days for other comments.

> +      cmd_dtb =        $(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> +else
> +quiet_cmd_dtb = $(quiet_cmd_dtc)
> +      cmd_dtb = $(cmd_dtc)
>  endif
>
> -define rule_dtc
> -       $(call cmd_and_fixdep,dtc)
> -       $(call cmd,dtb_check)
> -endef
> -
>  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
> -       $(call if_changed_rule,dtc)
> +       $(call if_changed_dep,dtb)
>
>  $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>         $(call if_changed_dep,dtc)
> --
> 2.35.1
>
