Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45FA584C60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiG2HFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiG2HFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:05:10 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF1E804B5;
        Fri, 29 Jul 2022 00:05:05 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 26T74ixh006854;
        Fri, 29 Jul 2022 16:04:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 26T74ixh006854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659078285;
        bh=zgcVv9ou1RtF1Lk7IdDqlk85KCCiF+CiJyanFd0uOSk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SdByZfjXpf0pNYUp54aHfa77D/Ec4GTD5+bpn7mjtH5/3OV3ic1nnleP4c70DkZvY
         OyzKSB8BEd3gTU5RqWr7YCh/MOkMwgF/IEZRY9j0iyhReqZupNOyj0WdhyCD+hoyFR
         PlZf4AgoxZhWuMxg2VpyRO1QHONQ9zx+SI5+3fc9waLFGqpQjMv6bc2ayLgJKHmBk5
         RobSY9dsbY0V6V8O5MLBpAmXaAjINhod23Ykz2mJwhaF2adVMgf7a/vWGExY+hfLBq
         XAEaJhA8V7fBcKbhrVocrTt9tJQTmZrfSwL4K1Wdbw5TRB6L95k0GJEmV3kDK+Rvxx
         KClzS7lTp1Dlw==
X-Nifty-SrcIP: [209.85.221.44]
Received: by mail-wr1-f44.google.com with SMTP id h8so4892625wrw.1;
        Fri, 29 Jul 2022 00:04:45 -0700 (PDT)
X-Gm-Message-State: ACgBeo3aJX0Q3DXuZSOrIsAOtt9vcl/IkpzPKPfx/o6sSKd5a7TnNAO+
        KFqKTSngtWGvnWM1FcGIKBTOgKejAH9W7zjji80=
X-Google-Smtp-Source: AA6agR5p/eqFZH1NGWuPsZLVtJ0LrfcEDmeMMGzeyjq6QZGNrTguS/ZpVQuCo6woW1u3tXiDtxEdD9QTCPJVXdAzfEw=
X-Received: by 2002:adf:d1e2:0:b0:21d:d40b:d816 with SMTP id
 g2-20020adfd1e2000000b0021dd40bd816mr1352131wrd.682.1659078283592; Fri, 29
 Jul 2022 00:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
 <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com> <CAA8EJprM4WAgfVTJ15azFtSH6POL5uuseHO=zVxRd44RmqKZjw@mail.gmail.com>
In-Reply-To: <CAA8EJprM4WAgfVTJ15azFtSH6POL5uuseHO=zVxRd44RmqKZjw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 29 Jul 2022 16:03:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com>
Message-ID: <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while
 checking dtbs
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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

On Fri, Jul 29, 2022 at 3:53 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 29 Jul 2022 at 08:55, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Thu, Jul 28, 2022 at 2:36 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
> > > <dmitry.baryshkov@linaro.org> wrote:
> > > >
> > > > It is useful to be able to recheck dtbs files against a limited set of
> > > > DT schema files. This can be accomplished by using differnt
> > > > DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> > > > for some reason if_changed_rule doesn't pick up the rule_dtc changes
> > > > (and doesn't retrigger the build).
> > > >
> > > > Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> > > > and dt-validate into a single new command. Then if_changed_dep triggers
> > > > on DT_SCHEMA_FILES changes and reruns the build/check.
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >  scripts/Makefile.lib | 14 ++++++--------
> > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > index c88b98b5dc44..3df470289382 100644
> > > > --- a/scripts/Makefile.lib
> > > > +++ b/scripts/Makefile.lib
> > > > @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> > > >  DT_BINDING_DIR := Documentation/devicetree/bindings
> > > >  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> > > >
> > > > -quiet_cmd_dtb_check =  CHECK   $@
> > > > -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > > > +quiet_cmd_dtb =        DTC/CHECK   $@
> > >
> > > This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
> > > always do just 'DTC'. I can fixup when applying.
> > >
> > > I'll give it a few days for other comments.
> >
> >
> >
> > When you change DT_SCHEMA_FILES, re-running dt-validate should be enough.
> > You do not need to re-run dtc.
> >
> > I guess the strangeness comes from the fact that you are trying to do the
> >  two different things in a single rule.
>
> The issue is that with the current rules the dt-validate isn't
> re-executed on DT_SCHEMA_FILES changes. Thus comes my proposal.

Correct.



What I said is like this.



# touch the timestamp file, %.dtb.checked
$(obj)/%.dtb.checked: $(obj)/%.dtb $(DT_TMP_SCHEMA) FORCE
        $(call if_changed_rule,dtb_check)

$(obj)/%.dtb: $(src)/%.dts $(DTC) $FORCE
        $(call if_changed_rule,dtc)

$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
        $(call if_changed_dep,dtc)


With the dtc/check split, we can avoid unneeded regeneration of
%.dtb when DT_TMP_SCHEMA or DT_SCHEMA_FILES is
changed.


One drawback is we track %.dtb.checked and and %.dtb separately,
so something like 53182e81f47d4ea0c727c49ad23cb782173ab849
may come back.






BTW, we do not check %.dtbo, why?

At least, 53182e81f47d4ea0c727c49ad23cb782173ab849
was trying to check %.dtbo




> --
> With best wishes
> Dmitry



-- 
Best Regards
Masahiro Yamada
