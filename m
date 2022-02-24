Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E3F4C2DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiBXN5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiBXN5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:57:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3FA193E4;
        Thu, 24 Feb 2022 05:56:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p15so4514334ejc.7;
        Thu, 24 Feb 2022 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JvjC8tOWTk4ODYODZzdMtmR/l6m49ciAB7j3vCNUEKE=;
        b=lpE8irlSiGXh7sX+ApcfCqZMcLOWT3BV2SoJuR6yoXxjVTbN376LudqUY4cYo09a2j
         GVClT6gnbnZMTdWUU362FYpLM7X/akhmv1w0kXzn0RL7IDN7EQCsSEmHzQRFou8Dfv9t
         9KMsc3FGy3cINoFy54zRgtm/iIMXmzcIlFmtTwTbBdevlLFq3Sr607iFQjfs+wVp5/Ly
         D443ODWNO651n/FuG+UPxNMSAsxLCFLghLca9u2tp1YjdBW0+slOzNEElUG+1ZFR30rU
         lThoClN3B0e1+XuEoARAN0+9N2i/bxmQDKfj7EjghBO8KpLIM6cV46RB+H5urVrlgE7J
         0MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JvjC8tOWTk4ODYODZzdMtmR/l6m49ciAB7j3vCNUEKE=;
        b=tilmnfImERi1WC39ZfjWhfzAo/ltKAilCvvEid87/F33GxLL5ajWCs5kWgO8c2ZfPN
         FFPcNw8436QgKy+1SbLWRIA9Tna0Q95AGOYfChrjIepfMQz1d3TAvvJU0/gl0uD/xJsU
         EEzKD/Bwvm4DWjENSNoZhwOTDsrUyXOhk8l2plrsIyJ+glxIcS/8z6BelxueWFdpjV4P
         8ZRqDwTA3IUHWjVOotNiOS3NBM5O+ws/mCYxPtlUFOb31md1lognfxarkEltwxKkdLx8
         cTKmWsUEUhT5i+GjlnnFdrWFFqgrQTDt+7WSYrm2zCb3NpvCqEU0542ErShilFsNpY/H
         utUw==
X-Gm-Message-State: AOAM532ODMtesKUyt7H7a8AwYfcw4MwrFnSEQjC5dia/JdBraeBRvNvt
        /ZTJZSY+qTJCREoZRWpYYd8=
X-Google-Smtp-Source: ABdhPJzNOQ43PD6/sw6hM1w1ZVcS0jJ7lCKae7Uwa2cuV0H3vipEiMdyluuTU7eaIA4cQC1Ipng/IQ==
X-Received: by 2002:a17:906:6716:b0:6cc:7d95:90af with SMTP id a22-20020a170906671600b006cc7d9590afmr2333918ejp.442.1645710998117;
        Thu, 24 Feb 2022 05:56:38 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id l12sm1450564edt.1.2022.02.24.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:56:36 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:56:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2 3/3] pwm: pwm-mediatek: Beautify error messages text
Message-ID: <YheOk3emaxePPBdr@orome>
References: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
 <20220214140339.112500-3-angelogioacchino.delregno@collabora.com>
 <e3222caa-ec69-2e90-ef81-666b03da656d@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hLgd3YADIvX8W0Kp"
Content-Disposition: inline
In-Reply-To: <e3222caa-ec69-2e90-ef81-666b03da656d@mediatek.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hLgd3YADIvX8W0Kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 02:47:33PM +0800, Macpaul Lin wrote:
> On 2/14/22 10:03 PM, AngeloGioacchino Del Regno wrote:
> > As a cherry-on-top cleanup, make error messages clearer to read
> > by changing instances of "clock: XXXX failed" to a more readable
> > "Failed to get XXXX clock". Also add "of" to unsupported period
> > error.
> >=20
> > This is purely a cosmetic change; no "real" functional changes.
> >=20
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >   drivers/pwm/pwm-mediatek.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> > index 6b39f3d69e41..568b13a48717 100644
> > --- a/drivers/pwm/pwm-mediatek.c
> > +++ b/drivers/pwm/pwm-mediatek.c
> > @@ -146,7 +146,7 @@ static int pwm_mediatek_config(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> >   	if (clkdiv > PWM_CLK_DIV_MAX) {
> >   		pwm_mediatek_clk_disable(chip, pwm);
> > -		dev_err(chip->dev, "period %d not supported\n", period_ns);
> > +		dev_err(chip->dev, "period of %d ns not supported\n", period_ns);
> >   		return -EINVAL;
> >   	}
> > @@ -229,12 +229,12 @@ static int pwm_mediatek_probe(struct platform_dev=
ice *pdev)
> >   	pc->clk_top =3D devm_clk_get(&pdev->dev, "top");
> >   	if (IS_ERR(pc->clk_top))
> >   		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_top),
> > -				     "clock: top failed\n");
> > +				     "Failed to get top clock\n");
> >   	pc->clk_main =3D devm_clk_get(&pdev->dev, "main");
> >   	if (IS_ERR(pc->clk_main))
> >   		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_main),
> > -				     "clock: main failed\n");
> > +				     "Failed to get main clock\n");
> >   	for (i =3D 0; i < pc->soc->num_pwms; i++) {
> >   		char name[8];
> > @@ -244,7 +244,7 @@ static int pwm_mediatek_probe(struct platform_devic=
e *pdev)
> >   		pc->clk_pwms[i] =3D devm_clk_get(&pdev->dev, name);
> >   		if (IS_ERR(pc->clk_pwms[i]))
> >   			return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_pwms[i]),
> > -					     "clock: %s failed\n", name);
> > +					     "Failed to get %s clock\n", name);
> >   	}
> >   	pc->chip.dev =3D &pdev->dev;
> >=20
>=20
> The format of these debug messages "clock: top" or "clock: main" is meant=
 to
> keep both human and machine's readability at the same time.
> This kind of format is much more easier to parse by scripts, which the
> driver's category and sub nodes are separated by delimiters . If a fail l=
og
> has been provided, the script could indicated where the issue might exists
> probably. Device vender, field application engineer, and driver maintainer
> could be able to write and use the error log parser before debugging.

Does such a script truly exist? Given that most error messages don't
follow this format, I would expect it to be only very marginally useful.
Typically the prefix that the dev_printk() variants add is enough
information to deduct where the error happens, at which point it's back
to good old grep to find the matching string to localize exactly.

> I'm not sure if this kind of format will be better. Like, "Failed to get
> clock: %s".
>=20
> If most people like this kind of solution ("Failed to get clock: %s\n"),
> then you can have the reviewed-by tag.
> Thanks!
>=20
> Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>

I'm going to assume that the scriptability is a theoretical argument, so
I'll take this. Let me know if you do rely on the exact format and I can
drop this again.

Thierry

--hLgd3YADIvX8W0Kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXjpMACgkQ3SOs138+
s6FoBg/+NpTmPhqKdcsDVyDY31nGjMYlEUy6Nw5EhAVdvlZLargR9lpl9mfNPc3O
Xg7RzdL6W2GGqPy938wLzqWZbjoaBV0Z0DUUn3sJg6qNE+fgov4dNLt2oQis0VpP
/hhDVm//BRgVCm0iuQLmNDxAGkPCBcDilqEY3a+wpta9KCf4SDnAyRMeY52tDW0p
AzpQXZd6WG8l7lezkEdebof6ZCUf4qO0MS/KlEpQaV/QgtVDjSLetrPBNhex3wG+
JCO928Bmx5kHdX2pRSUSFgZOY9KkqOHWbjcUudNj4sFpL4HtON/p/r0rRtL43eTs
ReFrgnvwP1Xv1ZuXqmjVrztBbUy2n79oFO/Ok+gVUChqw97V5rOSlKNDFzEKtHn2
mDdQIeW/Uvj4QcPzszw4LqdixtjD4ZXCm0evqAVuxpyL+G0eCW7oR4yqFsDwKmxb
RGDjQcvb/8fOeO3gmzmHr1jkdzM+2EUKDAKg5HMpXWLdTYNgemndNkFkF6NUF37e
2SdQhQHp7lUwOTgUr3bxCYZfz+mr6X2eI7bW7udizQs4SdqHUq4aMvtsnn9edzs0
0J8D+C32TQlN9z/bLrZoyQ7TWG23moIMaC4w/1XThI+fldS0WALdqwOs6i2FwTle
ShFCQanNvWwpqc4ijB8a7BNYxmTL76DbiMuB0odKBHZ8+FlvWZc=
=GvaV
-----END PGP SIGNATURE-----

--hLgd3YADIvX8W0Kp--
