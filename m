Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3775472F5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiFKIlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiFKIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:41:16 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC310C8;
        Sat, 11 Jun 2022 01:41:13 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 25B8ekfq022701;
        Sat, 11 Jun 2022 17:40:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 25B8ekfq022701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654936847;
        bh=GjObk4qkn+wKKzrcBcuYF59rT44eRBod2haAId0PbXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PREvLjGPWl2vpwAWxu9YrCKddWls2iwOpHhGWM+1kaRRovK1JCxy+uSn609YV0gI3
         08EmkdWb1tfsUC5IIRcF9TVUwP2tsuiirzSg3n/Q/5KcSgJup393cJvlf8XIHkSOLq
         304Rmb98sPeK4Nix+tSz/RQgmbXaOLkBV0yssM2ySNpzx2x88QOUpmD6ssrxiP3mNr
         m7dnQhG+MZmxSvlpNzh281ddse/dHcTvqFdvIaBZobn3pqDYiBAsteRN1Iswjqoz24
         tKpNmExTO5+ytUN2BKTKoNdEjCDwykfiKV0j2dShtcgnxPnLWqhxYO+7DW75Pn7Y2C
         BF5+6NoT+6RPg==
X-Nifty-SrcIP: [209.85.221.45]
Received: by mail-wr1-f45.google.com with SMTP id k19so1264016wrd.8;
        Sat, 11 Jun 2022 01:40:47 -0700 (PDT)
X-Gm-Message-State: AOAM533aqmBDJmpKIHiSMTAPCFboIOAaWR17yTdHiC79kqgPKrImZ5FI
        Je+xhNvngpWKDRv9DW6auFIkMvwcJHOJHeQ7FbM=
X-Google-Smtp-Source: ABdhPJyiHW2W3e41O1pSCmct30Roanq1/4GAP7WtMOyFwG8Wk3ea+wpvffMHRIqX+Lt7EbWt196HX8/OmJhdHyIm+Iw=
X-Received: by 2002:adf:f902:0:b0:20e:66db:b9d2 with SMTP id
 b2-20020adff902000000b0020e66dbb9d2mr48895378wrr.682.1654936845690; Sat, 11
 Jun 2022 01:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220610213453.630304-1-alvin@pqrs.dk> <20220610213959.bjrw6nrxaby2lb3g@bang-olufsen.dk>
In-Reply-To: <20220610213959.bjrw6nrxaby2lb3g@bang-olufsen.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 11 Jun 2022 17:40:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQaN0pH01Ntsn9jRxciaiYtWUA8MJeJ9ELiXrrbQwms6g@mail.gmail.com>
Message-ID: <CAK7LNAQaN0pH01Ntsn9jRxciaiYtWUA8MJeJ9ELiXrrbQwms6g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use a pipe rather than process substitution
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 6:40 AM Alvin =C5=A0ipraga <ALSI@bang-olufsen.dk> w=
rote:
>
> On Fri, Jun 10, 2022 at 11:34:52PM +0200, Alvin =C5=A0ipraga wrote:
> > From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
> >
> > Bash process substitution of the form `foo < <(bar)`, as found in
> > scripts/check-local-export, can cause issues in chrooted environments
> > and with tools such as pseudo. The blamed commit started to cause build
> > errors for me when using the Yocto project's devshell environment;
> > devshell uses pseudo internally:
> >
> > .../scripts/check-local-export: line 51: /dev/fd/63: No such file or di=
rectory
> >
> > Replace the process substitution with a simple pipe into the while loop=
.
> > This is functionally equivalent and more portable than the former. Note
> > that pipefail is enabled so that the script terminates when ${NM} fails=
.
> >
> > Link: https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D13288
> > Fixes: 31cb50b5590f ("kbuild: check static EXPORT_SYMBOL* by script ins=
tead of modpost")
> > Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Oops, I forgot to check the linux-kbuild list before sending this patch. =
I see
> that a more robust patch has been posted which addresses a separate issue=
, but
> which also solves the issue I was trying to address:
>
> https://lore.kernel.org/linux-kbuild/20220608011100.486735-1-masahiroy@ke=
rnel.org/raw
>
> Please ignore this. Thanks!
>
> Kind regards,
> Alvin

No problem. I did not notice I had broken yocto builds,
and it is good to know it has been solved as well.
Thanks for the report.



--=20
Best Regards
Masahiro Yamada
