Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B427A54597C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiFJBMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiFJBMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:12:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137221D3DF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 18:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 279A4CE31DF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F35AC3411F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654823559;
        bh=il/LrihYHiXpEhIbBQUxhLmQw77pGHQu3lBlJgMP7t4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h5XWo6HZF6YBmntwAftx+xHpRIGzBxcR+ybykaSvmbjVa5Qw+D3KDvdI3YvVyMAUp
         lXt4IYHVpL5PP33m3DjAh4xklYQXOketnw11Zd4jM/B013UHMobMRRGpD3IQ5rdIvC
         f/13zm7uKFdWIQ26Ql9V/Af4OOpxlhOH8eumkSCYVQCXdkTaInWLt+YphWjPwM4llL
         71g0VUd/r+2DPDIp83YL1NGhl7kkaLqw0JEngsRei/6c5ienAm4BuuET5Dn+JPvFUO
         SJweynlhxiSfuSZ5J/KTu2qL679VH2HkQ2INqJoxZrEyxoSbZAqLbl0ZdfCukWCW8s
         Yx74H7MyZwVig==
Received: by mail-vs1-f52.google.com with SMTP id j39so3174969vsv.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 18:12:39 -0700 (PDT)
X-Gm-Message-State: AOAM533TkAPbDk3W+xRmZ3wH0+ZPvReu5xkVDsgTr7ym5vOPIo+Zu/9L
        kt1c+MT9qADAPFqjgRAyerGdBZfLGE+jb7+Hv5A=
X-Google-Smtp-Source: ABdhPJwHkuSsO830yc4vLKdSnrTtacPei6UOBwiX+MMBbBdgE7ksep8FxixzkTda/vPdKhLDQNUa1vuYTAHYjpipJX4=
X-Received: by 2002:a05:6102:5493:b0:34b:b583:f557 with SMTP id
 bk19-20020a056102549300b0034bb583f557mr12260032vsb.2.1654823558327; Thu, 09
 Jun 2022 18:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220608120849.1695191-1-heiko@sntech.de> <CAJF2gTT_xihu58V43bQ0X-WS0STCT5RNjiEHdwPBaoXmrnX2OA@mail.gmail.com>
 <7523610.lvqk35OSZv@diego>
In-Reply-To: <7523610.lvqk35OSZv@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 10 Jun 2022 09:12:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTXT1UusfCDrccqd1X=16Z2Gg9+cvvhSjohF+D_ukVEiw@mail.gmail.com>
Message-ID: <CAJF2gTTXT1UusfCDrccqd1X=16Z2Gg9+cvvhSjohF+D_ukVEiw@mail.gmail.com>
Subject: Re: [PATCH] riscv: don't warn for sifive erratas in modules
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>, Ron Economos <re@w6rz.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 5:58 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Guo,
>
> Am Donnerstag, 9. Juni 2022, 03:39:24 CEST schrieb Guo Ren:
> > On Wed, Jun 8, 2022 at 8:09 PM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > The SiFive errata code contains code checking applicable erratas
> > > vs. actually applied erratas to suggest missing erratas to the
> > > user when their Kconfig options are not enabled.
> > >
> > > In the main kernel image one can be quite sure that all available
> > > erratas appear at least once, so that check will succeed.
> > > On the other hand modules can very well not use any errata-relevant
> > > code, so the newly added module-alternative support may also patch
> > > the module code, but not touch SiFive-specific erratas at all.
> > >
> > > So to restore the original behaviour don't warn when patching
> > > modules. This will keep the warning if necessary for the main kernel
> > > image but prevent spurious warnings for modules.
> > >
> > > Of course having such a vendor-specific warning may not be needed at
> > > all, as CONFIG_ERRATA_SIFIVE is selected by CONFIG_SOC_SIFIVE and the
> > > individual erratas are default-y so disabling them requires
> > > deliberate action anyway. But for now just restore the old behaviour.
> > >
> > > Fixes: a8e910168bba ("riscv: implement module alternatives")
> > > Reported-by: Ron Economos <re@w6rz.net>
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  arch/riscv/errata/sifive/errata.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/si=
five/errata.c
> > > index 672f02b21ce0..1031038423e7 100644
> > > --- a/arch/riscv/errata/sifive/errata.c
> > > +++ b/arch/riscv/errata/sifive/errata.c
> > > @@ -111,6 +111,7 @@ void __init_or_module sifive_errata_patch_func(st=
ruct alt_entry *begin,
> > >                         cpu_apply_errata |=3D tmp;
> > >                 }
> > >         }
> > > -       if (cpu_apply_errata !=3D cpu_req_errata)
> > > +       if (stage !=3D RISCV_ALTERNATIVES_MODULE &&
> > > +           cpu_apply_errata !=3D cpu_req_errata)
> > if (cpu_apply_errata &=3D ~cpu_req_errata)
>
> Hmm, I don't see what that changes?
+       if (stage !=3D RISCV_ALTERNATIVES_MODULE &&
+           cpu_apply_errata !=3D cpu_req_errata)
                warn_miss_errata(cpu_req_errata - cpu_apply_errata);
+       else if (cpu_apply_errata &=3D ~cpu_req_errata)
                warn_miss_errata(cpu_req_errata - cpu_apply_errata);

All module's errata should be a subset of the main kernel. Not just
skip the check of MODULE.

>
>
> > Shall we still guarantee the module's must be a subset of the main kern=
el.'s?
>
> The warning generated there is mainly to warn about some Kconfig options
> not being enabled and in individual modules even no errata usage may be
> required.
>
>
> The intent for the patch is to restore how things behaved before
> module-alternatives were introduced, so I don't really want to
> introduce functional changes ;-) .
>
> But also in the future we could debate if that warning is helpful at all,
> as the erratas are enabled automatically by CONFIG_SOC_SIFIVE and
> thus disabling individual erratas requires someone to turn them off
> manually in their .config .
>
>
> Heiko
>
> > >                 warn_miss_errata(cpu_req_errata - cpu_apply_errata);
> > >  }
> > > --
> > > 2.35.1
> > >
> >
> >
> >
>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
