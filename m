Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A255057EAA7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiGWAeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGWAeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:34:23 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43798246D;
        Fri, 22 Jul 2022 17:34:21 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 26N0Y09R021050;
        Sat, 23 Jul 2022 09:34:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 26N0Y09R021050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658536441;
        bh=RVyxmU6w2hKmkKjVqxY3k5xGesiVVZUE6Qda81Yil5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CnaaStUm5lwcDDgnvcoHtRhI9g9Hj2UD0mFivWgQ9TXC0e+wcSWDICqtgCA4VVyNZ
         KOUayWTnng3O06XB7hnZuM68DqZVAwNL02hOc/8sdwj1bC5Wp1eP1AbusZbWAjweUq
         y/nZnSCii48PwPhIAUr7ZMLVBRpBb98+1MQ3Pe5vr+AiDJ6txtMt5ctgo0DsbzvUVi
         Y/QlM4vi5hGcmlIQbks7nXsGaOmVm2X5gjgsfWSoQthW3sbnX6ZN6NQ3h8UB/HLZnB
         gLR3BnEybJgHj7QNOnBysG66U1Gih3iUx8S9G2spveERabUd8uTSPiv916QuAr3kGX
         JH+iLSowUm73w==
X-Nifty-SrcIP: [209.85.221.52]
Received: by mail-wr1-f52.google.com with SMTP id n12so8503947wrc.8;
        Fri, 22 Jul 2022 17:34:01 -0700 (PDT)
X-Gm-Message-State: AJIora85ecYxX3IjRSFU5UWh5lvr8EDURw2noW0pg/FUazQNcox2gQ41
        lm8oFblg9vMGA1vOK69vOPSGlU4cSSsM/63TWqM=
X-Google-Smtp-Source: AGRyM1sq0fCTIgtFFn2MLkvMra5q7ss5/nqd6TfpnI/TBo055eWmc2bnOhR4KMgJSEGaHvnv7WiWQKxzYhABCTobl4A=
X-Received: by 2002:a05:6000:104c:b0:21d:87bf:63a2 with SMTP id
 c12-20020a056000104c00b0021d87bf63a2mr1319505wrx.461.1658536439845; Fri, 22
 Jul 2022 17:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220716093122.137494-1-masahiroy@kernel.org> <Ytp4PyBcCfRsVaG5@bergen.fjasle.eu>
In-Reply-To: <Ytp4PyBcCfRsVaG5@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 23 Jul 2022 09:33:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNASFLKfDaPgWRzq2dw0939eLbcn5Y4A-qtSEfZs9BDecRg@mail.gmail.com>
Message-ID: <CAK7LNASFLKfDaPgWRzq2dw0939eLbcn5Y4A-qtSEfZs9BDecRg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add dtbs_prepare target
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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

On Fri, Jul 22, 2022 at 7:14 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Sat, 16 Jul 2022 18:31:22 +0900 Masahiro Yamada wrote:
> > Factor out the common prerequisites for DT compilation into the new
> > target, dtbs_prepare.
> >
> > Add comments in case you wonder why include/config/kernel.release is
> > the prerequisite. Our policy is that installation targets must not
> > (re)compile any build artifacts in the tree. If we make modules_install
> > depend on include/config/kernel.release and it is executed under the
> > root privilege, it may be owned by root.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index a9bd55edb75e..8aa4dbb8f878 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1367,16 +1367,22 @@ endif
> >
> >  ifneq ($(dtstree),)
> >
> > -%.dtb: include/config/kernel.release scripts_dtc
> > +%.dtb: dtbs_prepare
> >       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> >
> > -%.dtbo: include/config/kernel.release scripts_dtc
> > +%.dtbo: dtbs_prepare
> >       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>
> Is there a reason, why both rules are not unified?  I guess it is, but
> I can't see it.



See the GNU Make manual:
https://www.gnu.org/software/make/manual/html_node/Pattern-Examples.html

The last paragraph, "This pattern rule has two targets ..."



%.dtb %.dtbo: dtbs_prepare
         ...

means foo.dtb and foo.dtbo are generated at the same
time by the rule.  This is strange.





>
> >
> > -PHONY += dtbs dtbs_install dtbs_check
> > -dtbs: include/config/kernel.release scripts_dtc
> > +PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
> > +dtbs: dtbs_prepare
> >       $(Q)$(MAKE) $(build)=$(dtstree)
> >
> > +# include/config/kernel.release is not actually required for building DTBs,
> > +# but for installing DTBs because INSTALL_DTBS_PATH contains $(KERNELRELEASE).
> > +# We do not want to move it to dtbs_install. The policy is installation
> > +# targets (, which may run as root) must not modify the tree.
>
> Is the comma after the opening parenthesis intended?


I will rephrase the comment in v2.




>
> Kind regards,
> Nicolas
>
> > +dtbs_prepare: include/config/kernel.release scripts_dtc
> > +
> >  ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
> >  export CHECK_DTBS=y
> >  dtbs: dt_binding_check
> > --
> > 2.34.1



-- 
Best Regards
Masahiro Yamada
