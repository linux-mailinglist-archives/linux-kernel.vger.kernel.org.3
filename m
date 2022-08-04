Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48BD589EAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiHDP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiHDP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66955FACC;
        Thu,  4 Aug 2022 08:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 669AD6133D;
        Thu,  4 Aug 2022 15:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19A8C43470;
        Thu,  4 Aug 2022 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659626833;
        bh=GcT+t3fY2lBiq6UnUtFwmaQDgH7RekWK+46407Ycrqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nE+9jzIcYkkGohg5oz+E1uC/dhSOAqMTfaFtqoa8w0fsiTsl6MsKNsmlYh+YRjNn5
         9yon2bNXQBvryirZls8imSj6rsu6Jx6riDA/2kMRhojnKgWDZh3N+uaV38saUipYv+
         tIJnUNMwyUfMlXixT9GK0lj0uBP46b8v2qTpVbEyYTmbN5QiBEZZmWP+U/uXYwFTA+
         rFmAPgWgKoDFqbrOhbWenUr3DjWSbX2yGB/pH3H5VRyiSzumkJlhMMtRIU928r5NmJ
         REaLruqAHipb/iELkTqQD18Rf+xJAd5/rolPd351HOWunlcFNEoccvE+DZSEKMkLDZ
         p8C24HHBWDe/A==
Received: by mail-vs1-f42.google.com with SMTP id q190so5283662vsb.7;
        Thu, 04 Aug 2022 08:27:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo1JMr40fzSQHIAWfm6k81n/r9zADLbmYOlltbKfSi5g0/gTWWo4
        t+4LCdtu6W+bPweFyyzAuIczgGNCQLjeRHd7Xg==
X-Google-Smtp-Source: AA6agR6SZ2PuCPGzJQoQL+fdjB++pN0JauXVh7VtZVxDBoP7C7j7EeWOJv3bMZRCBrH7oAAf5w3X5aq5n5P7SN/A3Wo=
X-Received: by 2002:a67:c19c:0:b0:386:3a4b:dd5 with SMTP id
 h28-20020a67c19c000000b003863a4b0dd5mr1017211vsj.53.1659626832642; Thu, 04
 Aug 2022 08:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
 <CAL_JsqJjLn8ypBo+bBoO+CE-si7gemP02fi8EWk97QRPPpNoVg@mail.gmail.com>
 <CAK7LNARXbXZFpxiHuLhzjJ4YahfV6z3dNPAdkkmeOXONBx8u3w@mail.gmail.com>
 <CAA8EJprM4WAgfVTJ15azFtSH6POL5uuseHO=zVxRd44RmqKZjw@mail.gmail.com>
 <CAK7LNAQU42fpqPqUipZYx+685B+Rc8JGdaKcP3TdfQWUept1nQ@mail.gmail.com> <CAA8EJprMsEE-fkpP=QGgpCga5rb9_mJF51cvRjeWsG7NBeijSA@mail.gmail.com>
In-Reply-To: <CAA8EJprMsEE-fkpP=QGgpCga5rb9_mJF51cvRjeWsG7NBeijSA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 4 Aug 2022 09:27:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLptaL_Uv++dEzUx83n3c+AAu9rYUv6Zbb7sLbJE35wWA@mail.gmail.com>
Message-ID: <CAL_JsqLptaL_Uv++dEzUx83n3c+AAu9rYUv6Zbb7sLbJE35wWA@mail.gmail.com>
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

On Fri, Jul 29, 2022 at 1:46 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 29 Jul 2022 at 10:05, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Fri, Jul 29, 2022 at 3:53 PM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Fri, 29 Jul 2022 at 08:55, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > On Thu, Jul 28, 2022 at 2:36 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jul 27, 2022 at 4:06 AM Dmitry Baryshkov
> > > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > > >
> > > > > > It is useful to be able to recheck dtbs files against a limited set of
> > > > > > DT schema files. This can be accomplished by using differnt
> > > > > > DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
> > > > > > for some reason if_changed_rule doesn't pick up the rule_dtc changes
> > > > > > (and doesn't retrigger the build).
> > > > > >
> > > > > > Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
> > > > > > and dt-validate into a single new command. Then if_changed_dep triggers
> > > > > > on DT_SCHEMA_FILES changes and reruns the build/check.
> > > > > >
> > > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > ---
> > > > > >  scripts/Makefile.lib | 14 ++++++--------
> > > > > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > > > > index c88b98b5dc44..3df470289382 100644
> > > > > > --- a/scripts/Makefile.lib
> > > > > > +++ b/scripts/Makefile.lib
> > > > > > @@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> > > > > >  DT_BINDING_DIR := Documentation/devicetree/bindings
> > > > > >  DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
> > > > > >
> > > > > > -quiet_cmd_dtb_check =  CHECK   $@
> > > > > > -      cmd_dtb_check =  $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> > > > > > +quiet_cmd_dtb =        DTC/CHECK   $@
> > > > >
> > > > > This is supposed to be 7 chars or less. DTCCHK or DTC_CHK perhaps. Or
> > > > > always do just 'DTC'. I can fixup when applying.
> > > > >
> > > > > I'll give it a few days for other comments.
> > > >
> > > >
> > > >
> > > > When you change DT_SCHEMA_FILES, re-running dt-validate should be enough.
> > > > You do not need to re-run dtc.
> > > >
> > > > I guess the strangeness comes from the fact that you are trying to do the
> > > >  two different things in a single rule.
> > >
> > > The issue is that with the current rules the dt-validate isn't
> > > re-executed on DT_SCHEMA_FILES changes. Thus comes my proposal.
> >
> > Correct.
> >
> > What I said is like this.
> >
> > # touch the timestamp file, %.dtb.checked
> > $(obj)/%.dtb.checked: $(obj)/%.dtb $(DT_TMP_SCHEMA) FORCE

Not really a fan of the thousands of files that creates. Maybe if it
was turned into something useful like a list of schemas that apply to
the dtb. IOW, a dependency list. That would speed up re-running after
a schema change. Though if a schema change created new dependencies,
that wouldn't work.

> >         $(call if_changed_rule,dtb_check)
> >
> > $(obj)/%.dtb: $(src)/%.dts $(DTC) $FORCE
> >         $(call if_changed_rule,dtc)
> >
> > $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> >         $(call if_changed_dep,dtc)
> >
> >
> > With the dtc/check split, we can avoid unneeded regeneration of
> > %.dtb when DT_TMP_SCHEMA or DT_SCHEMA_FILES is
> > changed.
> >
> >
> > One drawback is we track %.dtb.checked and and %.dtb separately,
> > so something like 53182e81f47d4ea0c727c49ad23cb782173ab849
> > may come back.
>
> It's up to you and Rob, but I'd really prefer a simpler solution here.
> Regenerating dtbs sounds like a minor pain compared to hacking the
> top-level Makefile again. What I really like is that if one has
> CHECK_DTBS=y (for whatever reason), he can not generate dtb without
> validation.

I lean towards just rebuilding the dtbs. That's pretty quick and
ensures we get dtc warnings with schema warnings. In the long run, I
would like to make the schema checks not optional to run. The
impediment to doing that is lots of warnings (but not not some
platforms), adding a tool dependency, and validation time.

> > BTW, we do not check %.dtbo, why?
> >
> > At least, 53182e81f47d4ea0c727c49ad23cb782173ab849
> > was trying to check %.dtbo
>
> The commit ef8795f3f1ce ("dt-bindings: kbuild: Use DTB files for
> validation") separated .dtb and .dtbo paths. dt-validate is not
> prepared to be executed on top of the .dtbo file. And this is quite
> logical. The dtbo is an overlay, a patch. So it doesn't have to follow
> the schema on its own. We should probably make sure that multi-dtb
> files generated via fdtoverlay are also validated, but it can go in a
> separate commit.

It needs some attention to see how well validation of overlays works or not.

Rob
