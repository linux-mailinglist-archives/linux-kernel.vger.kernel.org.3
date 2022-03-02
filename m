Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A664C9A55
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiCBBWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCBBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:22:09 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA8E50047;
        Tue,  1 Mar 2022 17:21:15 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id h126so338750ybc.1;
        Tue, 01 Mar 2022 17:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2FJt3wZ2aC/AYzG97/OeEx9hgBhhRCpW1mrvr74R3VY=;
        b=CCvP2op0INjqscSf7KL0YIMiHDDQNCK450i8SkOUKzEyIZ6COzqHu7BGbD1BAOyM/h
         ADaGPVAAgKkUc9YnE+/PLFzeN9rYRHNdZbYdoOSPcw3kFmPanpYw3QgHJQ2reEdbEu1l
         1F0LIWLqF3GKrqLbXlZ4dz89FMU4tp8gTf+iK5aBfuxE3EICVQOkSzFmu52abedVqDO2
         FFWK9/HbdjrRPH7r4TjvykjaXBGtdrkVi/R+Mj9AMUuIbQdE24QElTXGewHc57XDipA5
         XBTS/j5E1QfTNwta8cJjSYJRCwi/t8/GlJNsovsx+nXs9CxkadIbNIaCOSlMCRNSIUQx
         sY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2FJt3wZ2aC/AYzG97/OeEx9hgBhhRCpW1mrvr74R3VY=;
        b=qpSj7n50mAi5/RRb6UjCOUpDHiD/XGxLpKvOuGA3vdfqjZaeY2oMTSDkElNhKxALuZ
         FLgaUlRKCtldhp/8PsZYy74SU6Dbu+zx4gLKgXIgzLI26sJchiMaeuyVQUzy9R/p+R5e
         m4T1VBewodwdQzkXIk/SRzE2KT2hx/dAKs0WIkYU6NWzxOVYm9R/mqV870AxU28IUJuG
         oE4QiF5JEBGplu7qAzniOwqB+FjRdqqiFN0KtupHBXmWvNllDNtuanaRw4FimeJDX6dS
         96cCsJGuyMw2xCK5ImrObyxSKIRNDKgZ3jmbPDQTOcNyy03olGuholtJ696SqeKlTiux
         tknw==
X-Gm-Message-State: AOAM531W0nYPXsNS+vhIjhd7BgdY8BAFJ9PC9QfzU1PAoOe4kC0cuxKu
        Sc0i0sLI5hdkkqouV2zw69P3tZEj8Nu8fPVfQ8Q=
X-Google-Smtp-Source: ABdhPJwSSPPrIFaaXxkU7hcBCBx3NM30v0YRu2iOdoDrr8ecZbsjnbs2oLKu9WUxBjWvKtPthlTCHPGwv/YvovKGSjM=
X-Received: by 2002:a25:f802:0:b0:628:7f76:c232 with SMTP id
 u2-20020a25f802000000b006287f76c232mr4889053ybd.366.1646184074382; Tue, 01
 Mar 2022 17:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20220228223642.1136229-1-pgwipeout@gmail.com> <242bae88-5dde-f005-6580-6024d51e0700@rock-chips.com>
In-Reply-To: <242bae88-5dde-f005-6580-6024d51e0700@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 1 Mar 2022 20:21:03 -0500
Message-ID: <CAMdYzYrrZvZfC42cYYtUMRTyp-EfNBLpu1YJ-0zcr8DKw-x03Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: avoid logspam when cd-broken
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 1, 2022 at 8:04 PM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Hi Peter,
>
> =E5=9C=A8 2022/3/1 6:36, Peter Geis =E5=86=99=E9=81=93:
> > The dw_mmc-rockchip driver drops a large amound of logspam constantly
> > when the cd-broken flag is enabled.
> > Set the warning to be debug ratelimited in this case.
> >
>
> May I know which platform did you use?

It's rk3566.

>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >   drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_m=
mc-rockchip.c
> > index 95d0ec0f5f3a..d0ebf0afa42a 100644
> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > @@ -50,8 +50,13 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *hos=
t, struct mmc_ios *ios)
> >               cclkin =3D ios->clock * RK3288_CLKGEN_DIV;
> >
> >       ret =3D clk_set_rate(host->ciu_clk, cclkin);
> > -     if (ret)
> > -             dev_warn(host->dev, "failed to set rate %uHz\n", ios->clo=
ck);
> > +     if (ret) {
> > +             /* this screams when card detection is broken */
> > +             if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
> > +                     dev_dbg_ratelimited(host->dev, "failed to set rat=
e %uHz\n", ios->clock);
> > +             else
> > +                     dev_warn(host->dev, "failed to set rate %uHz\n", =
ios->clock);
> > +     }
> >
> >       bus_hz =3D clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
> >       if (bus_hz !=3D host->bus_hz) {
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
