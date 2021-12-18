Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4FA4797F4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhLRBDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:03:14 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:27350 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLRBDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:03:11 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 1BI12mhi002928;
        Sat, 18 Dec 2021 10:02:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1BI12mhi002928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639789369;
        bh=g8kubEqzXtZebCqaSj9BAbqYgVkf91ju4F7inIn8m3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HQhqD+YdFOz/Ik3CiDJJHisluY+hIeooMONVi2AArR7U/FX/HzVd8IQPGdAODydCU
         FNjE9bOyfEOSwSifeecA3gLKsW1OeiMGuTRF4p7WiSmz9gLip48gyo3Dy3GDQrKS4D
         LOZWV0SE6kKGk+CyfUOud5w7gK9r4yLdvr811KXpFX7oy6mbjVFL3kgDnJv4ek0O1B
         kQAUP+umUawzx50N10vOdSECmnsLS3QGSgkM/6vjyLN77LAuEYxZDE7IpH2xlhb0bB
         9yAFWDIo5vxC6MS8Bu/iDnJNyUao+sOksgnxRbTJAtVpytt3LcNZDWHSl3inv/OaeH
         wQVzPFOAI2/lg==
X-Nifty-SrcIP: [209.85.210.173]
Received: by mail-pf1-f173.google.com with SMTP id k64so3555716pfd.11;
        Fri, 17 Dec 2021 17:02:48 -0800 (PST)
X-Gm-Message-State: AOAM533XZVhXvQpb233pLg2ZOVwCaA41kqestkwg1nF0Ea10zRhz11H3
        j+vhuor31e9rGKj8HLWNVL9ibSCrD2Zv4ppeujw=
X-Google-Smtp-Source: ABdhPJzGjAbGv+I/bTwhfwziv7WOMTBsph6E+WB3YL1WNppfKcKxQIdMdXPcqqda5/GSDFyziRC3MBP9P76MWkCI0SA=
X-Received: by 2002:a05:6a00:2d1:b0:4af:437c:5f50 with SMTP id
 b17-20020a056a0002d100b004af437c5f50mr5577166pft.32.1639789367863; Fri, 17
 Dec 2021 17:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20211207140334.10461-1-semen.protsenko@linaro.org> <CAPLW+4n-BjSHK4gdP=cGvAE+pZDfvYTO4yy09yNRJgSXt2VArg@mail.gmail.com>
In-Reply-To: <CAPLW+4n-BjSHK4gdP=cGvAE+pZDfvYTO4yy09yNRJgSXt2VArg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 18 Dec 2021 10:02:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdPMjZozjuwp5Z=_pXi-7JMXXcG0CMW+dWWX4GxJX-qg@mail.gmail.com>
Message-ID: <CAK7LNAQdPMjZozjuwp5Z=_pXi-7JMXXcG0CMW+dWWX4GxJX-qg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Report enabled nodes with duplicated address
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 1:11 AM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Tue, 7 Dec 2021 at 16:03, Sam Protsenko <semen.protsenko@linaro.org> wrote:
> >
> > Duplicated unit address is a normal case, as long as no more than one
> > node using that address is enabled. Having duplicated addresses is
> > already allowed by '-Wno-unique_unit_address' in DTC_FLAGS. But two
> > simultaneously enabled nodes sharing the same address is usually
> > incorrect. Add '-Wunique_unit_address_if_enabled' flag to report
> > warnings for such case when doing "make dtbs_check".
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Reported-by: Rob Herring <robh@kernel.org>
> > Suggested-by: Rob Herring <robh@kernel.org>
> > ---
> > NOTE: After applying this patch, a lot of warnings appear on "make
> > dtbs_check". I'm not completely sure if it's ok, so feel free to Nack.
> >
>
> Hi Rob,
>
> Do you think this patch is feasible? You asked me to send it before,
> though I now see it leads to a lot of errors being revealed when doing
> "make dtbs" and "make dtbs_check". Please let me know if it's Ack or
> Nack -- I'm fine with any resolution, just want to know if I should
> continue to carry it in my local branch or drop it.
>
> Thanks!


This is up to Rob.
I do not mind either way.

>
> >  scripts/Makefile.lib | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index ce6142238835..2f00c996d2e3 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -315,7 +315,8 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
> >         -Wno-alias_paths \
> >         -Wno-graph_child_address \
> >         -Wno-simple_bus_reg \
> > -       -Wno-unique_unit_address
> > +       -Wno-unique_unit_address \
> > +       -Wunique_unit_address_if_enabled
> >  endif
> >
> >  ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
> > --
> > 2.30.2
> >



-- 
Best Regards
Masahiro Yamada
