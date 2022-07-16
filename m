Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7105576C85
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiGPINo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGPINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:13:43 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA8311;
        Sat, 16 Jul 2022 01:13:41 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 26G8DIfZ029242;
        Sat, 16 Jul 2022 17:13:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 26G8DIfZ029242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657959199;
        bh=+v1uQMo3ZvSGLmyQ08/uYCDWhLeGHbb+CTN6DjFWfno=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TQsEstghDthg8mhcEQtKay7sVd894ZCIceJqFvoWrKxe6AC9W0MtETPaSXseMru3j
         PFdGCMyIXx9zPJXZkvHPOAoQ2obIAV/WMApJ7NxL2tR1hMd8FujR/npYL6n8fPOkG9
         Womk1TLl4zyWNU4TkvIVzqPqABSjlRtC7MiBsLxRUFt6peiZQKiX4XKoAzBwekDxbO
         Cb0oXNozlWWcrkPPZp1sqP7X5HUtvOSW7gbXDJl0k1qaq6WRQ58MJmC8jq8pAu81uz
         zkoVZgxzqYv3tgRZUSAZ51KqBT+8NEbPhgnHbEr0u9gKzIVu7areR8iEd9Bhgw4BCm
         o98n+53YN7epg==
X-Nifty-SrcIP: [209.85.221.43]
Received: by mail-wr1-f43.google.com with SMTP id r14so9675602wrg.1;
        Sat, 16 Jul 2022 01:13:18 -0700 (PDT)
X-Gm-Message-State: AJIora95OyzQnn7TwwA/4XNfygwGAcXdnbJWpUe45qtF/pLey904OM8B
        rFtH68d7r7YTcNeIipa1IN6owLwt1P8/UAQ+874=
X-Google-Smtp-Source: AGRyM1tFDgDUOKrocw3ze5eE6GIC91t1YbhGR1tyjE4wXbjW08NtqHFzsdP4Fgnwub89UXf8TNq75evk0g5D5iJJUiA=
X-Received: by 2002:a05:6000:104c:b0:21d:87bf:63a2 with SMTP id
 c12-20020a056000104c00b0021d87bf63a2mr15224596wrx.461.1657959197095; Sat, 16
 Jul 2022 01:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220623144357.297252-1-dmitry.baryshkov@linaro.org> <CAL_JsqLi31FPBdYPzEW__UmfMTur-0428okopFYVaCbwm045gg@mail.gmail.com>
In-Reply-To: <CAL_JsqLi31FPBdYPzEW__UmfMTur-0428okopFYVaCbwm045gg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 16 Jul 2022 17:12:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMUoPh8sBWWjenf8p6R1kv80ar17-qN-wH9zjNMtnfrQ@mail.gmail.com>
Message-ID: <CAK7LNASMUoPh8sBWWjenf8p6R1kv80ar17-qN-wH9zjNMtnfrQ@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Enable DT schema checks for %.dtb targets
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tom Rini <trini@konsulko.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 8:02 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 23, 2022 at 8:44 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > It is possible to build a single dtb, but not with DT schema validation
> > enabled. Enable the schema validation to run for %.dtb and %.dtbo
> > targets. Anyone building a dtb for a specific platform *should* pay
> > attention to schema warnings.
> >
> > This could be supported with a separate %.dt.yaml target instead.
> > However, the .dt.yaml format is considered an intermediate format and
> > could possibly go away at some point if schema checking is integrated
> > into dtc. Also, the plan is to enable the schema checks by default once
> > platforms are free of warnings, and this is a move in that direction.
> >
> > This patch differs from the previous one ([1]) in the fact that it
> > requires specifying VALIDATE_DT=1 to run the checks while doing the
> > build. Thus default build procedures would not obtain additional build
> > dependency, while maintainers can still build a single DTB file an get
> > only corresponding warnings.
>
> I'd rather this be a kconfig option, so that eventually 'make
> allmodconfig; make dtbs' also runs the schema checks. If something can
> be enabled for allmodconfig, then builders will automatically start
> testing it. Though the extra dependency is a problem here.


The dependency on libyaml is gone.

As for the dependency on dt-schema, is it a good idea to
pull it into the kernel tree somewhere,
like we periodically sync scripts/dtc/ with its upstream?

Any other problematic tool dependency?





>
> >
> > [1] https://lore.kernel.org/all/20210913145146.766080-1-robh@kernel.org/
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: linux-kbuild@vger.kernel.org
> > Co-developed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  Makefile | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index c43d825a3c4c..0942922384c4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1365,11 +1365,17 @@ endif
> >
> >  ifneq ($(dtstree),)
> >
> > -%.dtb: include/config/kernel.release scripts_dtc
> > -       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> > +ifneq ($(VALIDATE_DT),)
> > +DT_YAML = $(dtstree)/$*.dt.yaml
>
> .dt.yaml files are deprecated now. This probably doesn't do anything.

Right, this causes a build error.


masahiro@grover:~/ref/linux$ make ARCH=arm64 VALIDATE_DT=1
arm/foundation-v8.dtb
arch/arm64/Makefile:36: Detected assembler with broken .inst;
disassembly will be unreliable
  DTC     arch/arm64/boot/dts/arm/foundation-v8.dtb
  CHECK   arch/arm64/boot/dts/arm/foundation-v8.dtb
/home/masahiro/ref/linux/arch/arm64/boot/dts/arm/foundation-v8.dtb:
sysreg@10000: '#address-cells' is a required property
From schema: /home/masahiro/ref/linux/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
/home/masahiro/ref/linux/arch/arm64/boot/dts/arm/foundation-v8.dtb:
sysreg@10000: '#size-cells' is a required property
From schema: /home/masahiro/ref/linux/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
make[1]: *** No rule to make target
'arch/arm64/boot/dts/arm/foundation-v8.dt.yaml'.  Stop.
make: *** [Makefile:1379: arm/foundation-v8.dtb] Error 2







--
Best Regards

Masahiro Yamada
