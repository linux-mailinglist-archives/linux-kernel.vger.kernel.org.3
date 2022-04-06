Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D74F6639
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiDFRE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbiDFRC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:02:58 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C872E3CBC;
        Wed,  6 Apr 2022 07:50:19 -0700 (PDT)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 236Eo6Eu013696;
        Wed, 6 Apr 2022 23:50:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 236Eo6Eu013696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649256606;
        bh=aJtWq7m2T0/+3KJgorXCTf2UFkplPYxZGc852IFsbgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uXq6RrQrwVcwoPCimSVtNVYxbuBWdZUJf3qKuZELt6GhA7lzgPa3XTHRJRQJnSPh7
         cofzTrqc+MNVmRFZeRYkQlDA5T61630tPebbAdZUqT5gkFnEnRSgOfv/iHzrN8S9EK
         3jpmO+6RDejwH/RFwGriDIuleSdhUxXW1Tz4l6ReI33F2md0PrmyQhohNjrE1Mr47b
         J6Jr/74KXOm7mRGlwZ7hZAcQVfVO3sjaKh6HHAW6d3NeqsLwnkIw9ObAVOsoBiNrFr
         4T5sk/6xYHuX62ol4OcHuxb4fawt/Rq050FcE/VzHyR+jUbNJHrPe7XqvjiLmaMBF/
         8J1l7XQLSkBIQ==
X-Nifty-SrcIP: [209.85.210.172]
Received: by mail-pf1-f172.google.com with SMTP id s2so2669303pfh.6;
        Wed, 06 Apr 2022 07:50:06 -0700 (PDT)
X-Gm-Message-State: AOAM5339KhjgVNSHW/pUWA6InudNE6mnzl7uAfyfwr+MrJCm2JQ3Lj2V
        Li8YX2pLAorbi5+2BYjkxApFKRD1Ic0tHOgXLmk=
X-Google-Smtp-Source: ABdhPJzu9DVaBTPJLv31xmASpFadfhtH5LcW85UY2Jql+SNKJ10n7waejSRW7TByuFyw9dxLVG1/XYjaQ2PdOI325xs=
X-Received: by 2002:a05:6a00:a02:b0:4fd:f9dd:5494 with SMTP id
 p2-20020a056a000a0200b004fdf9dd5494mr9431657pfh.68.1649256605549; Wed, 06 Apr
 2022 07:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220405113359.2880241-1-masahiroy@kernel.org>
 <20220405113359.2880241-8-masahiroy@kernel.org> <YkyjkAWb56wqL3iK@fjasle.eu> <CAK7LNATUZesT6JsyrQu-ryU+PahwSwX3UVdxnJhyYDetnR_s1A@mail.gmail.com>
In-Reply-To: <CAK7LNATUZesT6JsyrQu-ryU+PahwSwX3UVdxnJhyYDetnR_s1A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 6 Apr 2022 23:49:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvibpEkFGJQ5MZS6O9rLpOn+RakbwKqOJwO_MqDOzbjA@mail.gmail.com>
Message-ID: <CAK7LNASvibpEkFGJQ5MZS6O9rLpOn+RakbwKqOJwO_MqDOzbjA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] kbuild: get rid of duplication in the first line
 of *.mod files
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 2:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Apr 6, 2022 at 5:16 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
> >
> > On Tue, Apr 05, 2022 at 08:33:55PM +0900 Masahiro Yamada wrote:
> > > The first line of *.mod lists the member objects of the module.
> > > This list may contain duplication if the same object is added multiple
> > > times, like this:
> > >
> > >   obj-m := foo.o
> > >   foo-$(CONFIG_FOO1_X) += foo1.o
> > >   foo-$(CONFIG_FOO1_Y) += foo1.o
> > >   foo-$(CONFIG_FOO2_X) += foo2.o
> > >   foo-$(CONFIG_FOO2_Y) += foo2.o
> > >
> > > This is probably not a big deal. As far as I know, the only small
> > > problem is scripts/mod/sumversion.c parses the same file over again.
> > > This can be avoided by adding $(sort ...). It has a side-effect that
> > > sorts the objects alphabetically, but it is not a big deal, either.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > > Changes in v2:
> > >   - new
> > >
> > >  scripts/Makefile.build | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > index 3ef2373f0a57..63625877aeae 100644
> > > --- a/scripts/Makefile.build
> > > +++ b/scripts/Makefile.build
> > > @@ -307,8 +307,10 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
> > >       $(call if_changed,cc_prelink_modules)
> > >  endif
> > >
> > > +multi-m-prereqs = $(sort $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)))
> > > +
> > >  cmd_mod = { \
> > > -     echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
> > > +     echo $(if $(multi-m-prereqs), $(multi-m-prereqs), $(@:.mod=.o)); \
> >
> > I'd rather expected to see $(or) here, too, as in commit 5c8166419acf ("kbuild:
> > replace $(if A,A,B) with $(or A,B)").
>
> Ah, good catch.
>
> I fixed it up locally.


I changed my mind.
I will throw away 07 and 08.

I will send different patches later.




>
> Thanks for the review.


-- 
Best Regards
Masahiro Yamada
