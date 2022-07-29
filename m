Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0015584CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiG2Hrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiG2HrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:47:22 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29210402DD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:46:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r24so2789637qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7a2a0ZLCLii8uN3XM9tRZ1FUmDJCQ4nEqHpPYUeU1zY=;
        b=lCPqwpRvt/NnqR0ZT0novgznUAPcweloyzGT0IX8/zddycJU89DRSkB+oFLmpschbb
         AkOOCugD++rl8invHxWlDbFHzH8HTaPpZKFS6ukn5qn99+sIxSsBCdYHxmvU7yJKMsQ5
         aez4q352RrBSNOY21itFbb9FZZI6D/LvMFP+NIILvGnwCRbA65H7Xi8rDX0eXbACPKFw
         6pZRXhOV4Fzz+0R7CNHkko+GrjeC6IeVy9+j/DSjULjgFRyLf6lsall7TMJ+14sFanqX
         XfrYyWQUvAhw6+CGY4+8NtqnN/pvbyi4su/WbLZgnrXTOs1Fp5YN/WDYwT0fWHx2HFKb
         k6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7a2a0ZLCLii8uN3XM9tRZ1FUmDJCQ4nEqHpPYUeU1zY=;
        b=cVFKANJ+wCWiXTQHhn7QPrRpVsX4gSziF072GHQQHzzLY+4k2nMg/Ge2N9dGlE6o7g
         g8AxTXCAVJEasylfGO14XsHWDA7VJYcRUJisWeTKX+6ZuNofhDPwxBUPnC2VGRA4bITz
         N3MRqHwiXYuLOkqB2qpgpLNo37zA1d2rWwNVc85Fp4du4sGIFct09nZRFWojaK5VXSLj
         Y3HPhTkgeRcijR8C5o+0o5Eqf81o8l0HNMEDBOaYvscJB493XkgH7zXjPih8KQE6U2Fs
         DY7pKn7osmTeFCKczby64mgW0QW5RGnLjRdLl4VqVW/WCw0+ur0aJZ4o6OTLVGzLeBCW
         3Usg==
X-Gm-Message-State: AJIora9U2llRhlOtoAIPIy69PW7PhS9rc/1483FHzUHA/49pWBl81HDr
        MoF1oCfGRl1KI9PXwXKGYjBuVJbpOycYWWE7QHbxgmfIkxyoig==
X-Google-Smtp-Source: AGRyM1t17J23zmT/KYA0kbJ3uBVjWNhg+kTZLWesv1/WiyxQ4ejCi05swyXT+0SsIdppg6OYNtteLB+rxLJ8PcETGrg=
X-Received: by 2002:ac8:5942:0:b0:31f:39f6:aba7 with SMTP id
 2-20020ac85942000000b0031f39f6aba7mr2229638qtz.295.1659080792592; Fri, 29 Jul
 2022 00:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
 <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com>
 <CAA8EJprM4WAgfVTJ15azFtSH6POL5uuseHO=zVxRd44RmqKZjw@mail.gmail.com> <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 29 Jul 2022 10:46:21 +0300
Message-ID: <CAA8EJprMsEE-fkpP=QGgpCga5rb9_mJF51cvRjeWsG7NBeijSA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while
 checking dtbs
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 at 10:05, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Jul 29, 2022 at 3:53 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Fri, 29 Jul 2022 at 08:55, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Thu, Jul 28, 2022 at 2:36 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > It is useful to be able to recheck dtbs files against a limited set of
> > > > > DT schema files. This can be accomplished by using differnt
> > > > > DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> > > > > for some reason if_changed_rule doesn't pick up the rule_dtc changes
> > > > > (and doesn't retrigger the build).
> > > > >
> > > > > Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> > > > > and dt-validate into a single new command. Then if_changed_dep triggers
> > > > > on DT_SCHEMA_FILES changes and reruns the build/check.
> > > > >
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > > >  scripts/Makefile.lib | 14 ++++++--------
> > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > > index c88b98b5dc44..3df470289382 100644
> > > > > --- a/scripts/Makefile.lib
> > > > > +++ b/scripts/Makefile.lib
> > > > > @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> > > > >  DT_BINDING_DIR := Documentation/devicetree/bindings
> > > > >  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> > > > >
> > > > > -quiet_cmd_dtb_check =  CHECK   $@
> > > > > -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > > > > +quiet_cmd_dtb =        DTC/CHECK   $@
> > > >
> > > > This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
> > > > always do just 'DTC'. I can fixup when applying.
> > > >
> > > > I'll give it a few days for other comments.
> > >
> > >
> > >
> > > When you change DT_SCHEMA_FILES, re-running dt-validate should be enough.
> > > You do not need to re-run dtc.
> > >
> > > I guess the strangeness comes from the fact that you are trying to do the
> > >  two different things in a single rule.
> >
> > The issue is that with the current rules the dt-validate isn't
> > re-executed on DT_SCHEMA_FILES changes. Thus comes my proposal.
>
> Correct.
>
> What I said is like this.
>
> # touch the timestamp file, %.dtb.checked
> $(obj)/%.dtb.checked: $(obj)/%.dtb $(DT_TMP_SCHEMA) FORCE
>         $(call if_changed_rule,dtb_check)
>
> $(obj)/%.dtb: $(src)/%.dts $(DTC) $FORCE
>         $(call if_changed_rule,dtc)
>
> $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>         $(call if_changed_dep,dtc)
>
>
> With the dtc/check split, we can avoid unneeded regeneration of
> %.dtb when DT_TMP_SCHEMA or DT_SCHEMA_FILES is
> changed.
>
>
> One drawback is we track %.dtb.checked and and %.dtb separately,
> so something like 53182e81f47d4ea0c727c49ad23cb782173ab849
> may come back.

It's up to you and Rob, but I'd really prefer a simpler solution here.
Regenerating dtbs sounds like a minor pain compared to hacking the
top-level Makefile again. What I really like is that if one has
CHECK_DTBS=y (for whatever reason), he can not generate dtb without
validation.

> BTW, we do not check %.dtbo, why?
>
> At least, 53182e81f47d4ea0c727c49ad23cb782173ab849
> was trying to check %.dtbo

The commit ef8795f3f1ce ("dt-bindings: kbuild: Use DTB files for
validation") separated .dtb and .dtbo paths. dt-validate is not
prepared to be executed on top of the .dtbo file. And this is quite
logical. The dtbo is an overlay, a patch. So it doesn't have to follow
the schema on its own. We should probably make sure that multi-dtb
files generated via fdtoverlay are also validated, but it can go in a
separate commit.

-- 
With best wishes
Dmitry
