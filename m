Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1595A3DBB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiH1Nbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 09:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiH1Nbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 09:31:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6B24BF6;
        Sun, 28 Aug 2022 06:31:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kk26so10943685ejc.11;
        Sun, 28 Aug 2022 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=3kAQ5K5eIGeNzDKGV7oJwvNpJhXIVKVpoG1HfB4JozY=;
        b=eb5Ic9mBKxmCXT4VEX4X3k03ETsaS0PsYLQ8P8JU+gR0JYwlPM99sPaBbeGhFXNKx3
         baUT3670yeoQYOUVl6CijcTr80ZtczMvGKZFVYXM2n8oVB21oCWwP5vGMB8n8k21FHIp
         rIbSyHTIcqsF+WuR5q5yhPVnEZebHVTU/FFWRu+99In0OE9USrDAw6acibAxcEiGavzl
         AsgwaeZDuJXE7bZcFwt+fiZt8k/yqP2+quh/M/mmKh9WVEHLKk6NuXAjMz2B1UHjLBMz
         vgTegNFhVP2lwoRnRdSeKXHKMkgqbS24b4QsrLImVtU51vcCoFH9pl5ZcHuZkzT3Pvc+
         2EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=3kAQ5K5eIGeNzDKGV7oJwvNpJhXIVKVpoG1HfB4JozY=;
        b=nRUhqB2m59AFGdSXorotjABxAy6Wq3bLzUBfSp2QJh/COISo8dFPUehuvpt9msLdjI
         dUcGLAFOya6FarXxrzDqHmZNPBV3/a43VL8Ya7Bb0AZXeL6feKHFTvEvyc6/6KapxQdm
         wF4MGeR0YBGMchngFRbfWBvd5poRMA7+2ZhfGx0mwdMyB4vqM07Hz/sbavaJSDmfpPxA
         FGuAbStJ7nXR2WgfYNAlJxb0XSNYbsknY5bUDpbg1DNaosDmz/F3H0XnGMhHaKeuTnph
         QYPAV22ol9l9j686DR4oFpu53t7NESFNNrRWMO8D+KS/R5n4PCskH3KdzXOkakC74fRz
         rDfg==
X-Gm-Message-State: ACgBeo34YSeNToXhN/kYUkhvD71aWcXdC38CmzM6wLDHOiy76glbs3N0
        VlG8piDKPDKJa4rHdeJCZjfUFFZf0Me2SpoFJkTvDmAqC/8=
X-Google-Smtp-Source: AA6agR6zBCSj61ZaiC1HeGBPBcbfD8D5Jpk3eyz7rwdjBX+3i8bk51euxSQ0qpv7vpRQ8puqRxcBiIyPK8f4B6sEJGU=
X-Received: by 2002:a17:906:730d:b0:73d:c8a1:a6ae with SMTP id
 di13-20020a170906730d00b0073dc8a1a6aemr11016005ejc.540.1661693497381; Sun, 28
 Aug 2022 06:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220818050019.1924408-1-keguang.zhang@gmail.com> <20220821171030.wc343w6zmrtcz5to@mobilestation>
In-Reply-To: <20220821171030.wc343w6zmrtcz5to@mobilestation>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Sun, 28 Aug 2022 21:31:25 +0800
Message-ID: <CAJhJPsW0HTs+=PD2JvXZVTkm9zrnRYKtEwLNv3dsVsf1AUNjDQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: loongson32: Fix the validation failure of LS1B &
 LS1C Ethernet PHY
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,
Your patch also works for me.
But what about the plat_dat->interface? Is it obsolete?

Serge Semin <fancer.lancer@gmail.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=80 01:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Keguang
>
> On Thu, Aug 18, 2022 at 01:00:19PM +0800, Keguang Zhang wrote:
> > From: Kelvin Cheung <keguang.zhang@gmail.com>
> >
> > The Ethernet of LS1B/LS1C doesn't work due to the stmmac driver
> > using phylink_generic_validate() instead of stmmac_validate().
> > Moreover the driver assumes the PHY interface mode
> > passed in platform data is always supported.
> >
> > stmmaceth stmmaceth.0 eth0: validation of gmii with support 00000000,00=
000000,000062cf and advertisement 00000000,00000000,000062cf failed: -EINVA=
L
> > stmmaceth stmmaceth.0 eth0: stmmac_open: Cannot attach to PHY (error: -=
22)
> >
> > This patch sets phy_interface field of platform data.
>
> I've got a similar fix in my repo, though didn't have a chance to test
> it out due to lacking any loongson hardware. I've discovered the
> issues on my still going way of the STMMAC driver refactoring. Anyway
> IMO the problem is a bit different than you describe and should be
> fixed in a bit different way. Please see a patch attached to this
> email. Could you test it out on your hw? If it fixes the problem you
> can resend it as v2 patch.
>
> -Sergey
>
> >
> > Fixes: 04a0683f7db4 ("net: stmmac: convert to phylink_generic_validate(=
)")
> > Fixes: d194923d51c9 ("net: stmmac: fill in supported_interfaces")
> > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> > ---
> >  arch/mips/loongson32/common/platform.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongso=
n32/common/platform.c
> > index 794c96c2a4cd..741aace80b80 100644
> > --- a/arch/mips/loongson32/common/platform.c
> > +++ b/arch/mips/loongson32/common/platform.c
> > @@ -147,8 +147,10 @@ static struct plat_stmmacenet_data ls1x_eth0_pdata=
 =3D {
> >       .phy_addr               =3D -1,
> >  #if defined(CONFIG_LOONGSON1_LS1B)
> >       .interface              =3D PHY_INTERFACE_MODE_MII,
> > +     .phy_interface          =3D PHY_INTERFACE_MODE_MII,
> >  #elif defined(CONFIG_LOONGSON1_LS1C)
> >       .interface              =3D PHY_INTERFACE_MODE_RMII,
> > +     .phy_interface          =3D PHY_INTERFACE_MODE_RMII,
> >  #endif
> >       .mdio_bus_data          =3D &ls1x_mdio_bus_data,
> >       .dma_cfg                =3D &ls1x_eth_dma_cfg,
> >
> > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> > --
> > 2.34.1
> >



--=20
Best regards,

Kelvin Cheung
