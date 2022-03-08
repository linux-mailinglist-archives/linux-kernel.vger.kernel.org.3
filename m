Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1148C4D0E13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244973AbiCHCmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiCHCmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:42:52 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2895FF8;
        Mon,  7 Mar 2022 18:41:56 -0800 (PST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2282fRuk021508;
        Tue, 8 Mar 2022 11:41:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2282fRuk021508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646707287;
        bh=dIG2VPMsnVYbGxtxO8Vc7Lbp+Yb1NvYeghBz0Pji3jA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FOttpyanVYwF5btaC2s39yxa/odBY3+ChCCItsgPg6qMGOfRHK0S0FKiDfUfwOajR
         8Vt/Uvxp5F8Tdksl69cCJ/ekw/P6SzR78Ad6cWX3J/WMn8F0bVDKEZQm1+8tNbl3yZ
         fLAFrjuIN2J8Atj+VdHgbxV+FJFeAtnI7WrC0i9r6/pTwIlA0OA67Ycl+FjUhQ+5h5
         Jsy4dnfQLcYtiqDfjC6ILQNT9khXJRTI2YnEWIvua9VAvij8dmdeov72J12cGdwxEa
         m1iOD081PObm+kaIyR/0Cilei8h7fQrncJ1VdFaHWmOlrHoIyayD/IL0mnQeRn8uG+
         20sYUYoQXjjlw==
X-Nifty-SrcIP: [209.85.210.173]
Received: by mail-pf1-f173.google.com with SMTP id d187so16097551pfa.10;
        Mon, 07 Mar 2022 18:41:27 -0800 (PST)
X-Gm-Message-State: AOAM530y4X2OBjyicH+fNZIPJa3YbTiOw3orCRVRATeGoNJibSqznrOm
        ozlNgRRQUmqeRc7+2Nt7VZYVadt5UZmzY8qIzs4=
X-Google-Smtp-Source: ABdhPJyo1UeijE84hLaWLo4gJvDwARPIDyzyN4dn18Z2U4P8rtqqqsoRri0Oc4An0yMQ3CrQB8gC6XpSjMUifjPusZ8=
X-Received: by 2002:a05:6a00:a1d:b0:4f6:d122:cd08 with SMTP id
 p29-20020a056a000a1d00b004f6d122cd08mr16201014pfh.68.1646707286783; Mon, 07
 Mar 2022 18:41:26 -0800 (PST)
MIME-Version: 1.0
References: <87k0dbosis.fsf@irisa.fr> <CAK7LNARV4ax0t-drWMx0G==gDmcpXJoOvRuRQ6dS440245AwjQ@mail.gmail.com>
 <87zgm41xwp.fsf@irisa.fr>
In-Reply-To: <87zgm41xwp.fsf@irisa.fr>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Mar 2022 11:40:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmwT3s2s88_wD4FvthCR0=EJYginf5qFXs4dh59oTcoQ@mail.gmail.com>
Message-ID: <CAK7LNASmwT3s2s88_wD4FvthCR0=EJYginf5qFXs4dh59oTcoQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: add KCONFIG_ALLCONFIG support for tinyconfig
To:     RANDRIANAINA Georges Aaron <georges-aaron.randrianaina@irisa.fr>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Acher <mathieu.acher@irisa.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 5, 2022 at 7:44 PM RANDRIANAINA Georges Aaron
<georges-aaron.randrianaina@irisa.fr> wrote:
>
>
> Masahiro Yamada <masahiroy@kernel.org> writes:
>
> > On Fri, Mar 4, 2022 at 2:27 AM Randrianaina Georges Aaron
> > <georges-aaron.randrianaina@irisa.fr> wrote:
> >>
> >> Since f8f0d06438e5, tinyconfig overrides KCONFIG_ALLCONFIG to
> >> include kernel/configs/tiny-base.config. However, this ignores
> >> user's preset if defined.
> >>
> >> This modification checks if the user has set KCONFIG_ALLCONFIG
> >> and if so, concatenates it with kernel/configs/tiny-base.config
> >> to be used as preset config symbols.
> >>
> >> Signed-off-by: Randrianaina Georges Aaron <georges-aaron.randrianaina@irisa.fr>
> >> ---
> >>  scripts/kconfig/Makefile | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> >> index b8ef0fb4bbef..337693fb4762 100644
> >> --- a/scripts/kconfig/Makefile
> >> +++ b/scripts/kconfig/Makefile
> >> @@ -102,7 +102,13 @@ configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/c
> >>
> >>  PHONY += tinyconfig
> >>  tinyconfig:
> >> +ifeq ($(KCONFIG_ALLCONFIG),)
> >>         $(Q)KCONFIG_ALLCONFIG=kernel/configs/tiny-base.config $(MAKE) -f $(srctree)/Makefile allnoconfig
> >> +else
> >> +       $(Q)cat $(KCONFIG_ALLCONFIG) <(echo) kernel/configs/tiny-base.config > .tmp.config
> >
> >
> > I assume "<(echo)" exists here to insert a blank line.
> > The process substitution is a bash'ism.
> >
> > If you execute it on Debian or its variants, where /bin/sh is a symlink
> > to dash, it fails.
> >
> > masahiro@grover:~/ref/linux$ make  KCONFIG_ALLCONFIG=/tmp/dummy.config
> > tinyconfig
> > /bin/sh: 1: Syntax error: "(" unexpected
> > make[1]: *** [scripts/kconfig/Makefile:108: tinyconfig] Error 2
> > make: *** [Makefile:619: tinyconfig] Error 2
> >
> >
> >
> > We can delete '<(echo)', but another issue is that this does not work
> > with O=<dir> option.
>
> Yes, we can delete `<(echo)`. We can solve the remaining issue by adding
> `$(srctree)` in the presets' path to make it work with O=<dir>.


Yes.


-- 
Best Regards
Masahiro Yamada
