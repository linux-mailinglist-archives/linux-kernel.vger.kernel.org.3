Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFEC584B57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiG2F4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiG2F4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:56:14 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897879EE8;
        Thu, 28 Jul 2022 22:56:11 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 26T5tXmw009590;
        Fri, 29 Jul 2022 14:55:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 26T5tXmw009590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659074134;
        bh=DnvzI67gOmEywdaRg5LcyVuyJs1mZicZdoCVJ0sG/Zw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iU1xPV+gspQicXUBfnJdv27Cy6uH189ToOcGrsZc6rz6EfVJKAFW8PyGtl8sqduVz
         DEKOnQpDN/kk5sQMstVuoURakgTfcmaXkcY+MvH3ZVmPRsIZLBRWiFZ3GZoFMAx3P5
         jQtim5RtP0l/4KemdKy1MRNZ7rEzuawGCVOMcmS6P8hdgDoL2x4j0xd1cFkpfWE7ls
         2d7twDaN1EVZTApreZLIJxhqOCYsLIikcdrd5xT38Oy2/6xZuZIreIF0w5dtIg5xua
         RAfyu6FxAZBywHMuye7/mVxBadGANZ6fUZmZjggaYsERdMtRJ39YY92ShyALXQzkHi
         r8keC4xcV5HRA==
X-Nifty-SrcIP: [209.85.221.47]
Received: by mail-wr1-f47.google.com with SMTP id z17so1524wrq.4;
        Thu, 28 Jul 2022 22:55:34 -0700 (PDT)
X-Gm-Message-State: ACgBeo3eAti7KcMEFTzmPU6lXQMjSYzXkXgZgIMVKO1jQoQX5mN2TlBP
        B9g6iusWlmMlwg9AOstfYGZsub+qd6QHBOZ55bI=
X-Google-Smtp-Source: AA6agR64oZVyi4GteBfd0tFx+1t3jcq6sq+GtP6R5+/HXQbl3lcoIt90ALtGAC1an8WMDpPRuA2JJjrNw9mwq6hVkb4=
X-Received: by 2002:adf:d1e2:0:b0:21d:d40b:d816 with SMTP id
 g2-20020adfd1e2000000b0021dd40bd816mr1184607wrd.682.1659074132901; Thu, 28
 Jul 2022 22:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org> <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
In-Reply-To: <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 29 Jul 2022 14:54:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com>
Message-ID: <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while
 checking dtbs
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 2:36 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > It is useful to be able to recheck dtbs files against a limited set of
> > DT schema files. This can be accomplished by using differnt
> > DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> > for some reason if_changed_rule doesn't pick up the rule_dtc changes
> > (and doesn't retrigger the build).
> >
> > Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> > and dt-validate into a single new command. Then if_changed_dep triggers
> > on DT_SCHEMA_FILES changes and reruns the build/check.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  scripts/Makefile.lib | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index c88b98b5dc44..3df470289382 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> >  DT_BINDING_DIR := Documentation/devicetree/bindings
> >  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> >
> > -quiet_cmd_dtb_check =  CHECK   $@
> > -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > +quiet_cmd_dtb =        DTC/CHECK   $@
>
> This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
> always do just 'DTC'. I can fixup when applying.
>
> I'll give it a few days for other comments.



When you change DT_SCHEMA_FILES, re-running dt-validate should be enough.
You do not need to re-run dtc.

I guess the strangeness comes from the fact that you are trying to do the
 two different things in a single rule.


--
Best Regards
Masahiro Yamada
