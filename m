Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB964928BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbiAROvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:51:42 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:45047 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbiAROvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1642517405;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ZRxpxg3yvouQAHplNdqcixEdp4kkISs4RaC904ODu7k=;
    b=hNwHinG2rTQaKv3C6d0gISmOqkfnhWNRV6Ah3N6zsvxCgyoT0wOYRd+TerJWXIYAdA
    qaSBRfk3Bb8ulktRCmZG4s0yx/tPyE5JmcjEcyg8HOnjpb6yVvEFQgNALs3L/66KNsDW
    mn7JDHSo0qIoOaJWjlBPH35dAXNdUzVprw+IZumktCYCd2azohcR9OxRGxF3Pf+F+p6l
    FNBzp6iKWUPDbVPq6Wu+Jw6D0h9gY9Q8WQAbhWuQw/r2aZM6+/b6I6e2hlJP8K+mcLvy
    AVK83W5E6P65/kkR+5KitWgU76F6/5s5nZ6z9nR96fluRXsuepjID9MrziOcubl9Ms10
    C97g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3iMITlA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.37.6 DYNA|AUTH)
    with ESMTPSA id D61423y0IEo3h0y
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 18 Jan 2022 15:50:03 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v5 2/7] drm/ingenic: Add support for JZ4780 and HDMI
 output
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5BC61397-AF28-45CD-83F6-FA2C760F3995@goldelico.com>
Date:   Tue, 18 Jan 2022 15:50:01 +0100
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Paul Boddie <paul@boddie.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C846BAFB-473D-41D8-93B9-B9ECDD1846C1@goldelico.com>
References: <cover.1633436959.git.hns@goldelico.com>
 <2c7d0aa7d3ef480ebb996d37c27cbaa6f722728b.1633436959.git.hns@goldelico.com>
 <FXTI0R.3FZIJZ7UYSNQ@crapouillou.net>
 <7CEBB741-2218-40A7-9800-B3A154895274@goldelico.com>
 <Q6U72R.9HY4TXLC6RWV2@crapouillou.net>
 <229EBE4C-6555-41DE-962F-D82798AEC650@goldelico.com>
 <HQY82R.69JHJIC64HDO1@crapouillou.net>
 <5BC61397-AF28-45CD-83F6-FA2C760F3995@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
any insights on the JZ_REG_LCD_OSDC issue below?

There is a second, unrelated issue with the introduction of

"drm/bridge: display-connector: implement bus fmts callbacks"

which breaks bus format negotiations.

These are the two last unsolved issues to submit a fully working driver.

> Am 22.12.2021 um 15:03 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
>> Am 08.11.2021 um 10:37 schrieb Paul Cercueil <paul@crapouillou.net>:
>>=20
>> Hi Nikolaus,
>>=20
>> Le dim., nov. 7 2021 at 21:25:38 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>>> Hi Paul,
>>>>>>>=20
>>>>>>> @@ -1274,7 +1319,7 @@ static int ingenic_drm_bind(struct device =
*dev, bool has_components)
>>>>>>> 	/* Enable OSD if available */
>>>>>>> 	if (soc_info->has_osd)
>>>>>>> -		regmap_write(priv->map, JZ_REG_LCD_OSDC, =
JZ_LCD_OSDC_OSDEN);
>>>>>>> +		regmap_set_bits(priv->map, JZ_REG_LCD_OSDC, =
JZ_LCD_OSDC_OSDEN);
>>>>>> This change is unrelated to this patch, and I'm not even sure =
it's a valid change. The driver shouldn't rely on previous register =
values.
>>>>> I think I already commented that I think the driver should also =
not reset
>>>>> previous register values to zero.
>>>> You did comment this, yes, but I don't agree. The driver *should* =
reset the registers to zero. It should *not* have to rely on whatever =
was configured before.
>>>> Even if I did agree, this is a functional change unrelated to =
JZ4780 support, so it would have to be splitted to its own patch.
>>> Well it is in preparation of setting more bits that are only =
available for the jz4780.
>>> But it will be splitted into its own patch for other reasons - if we =
ever make osd working...
>>>>> If I counted correctly this register has 18 bits which seem to =
include
>>>>> some interrupt masks (which could be initialized somewhere else) =
and we
>>>>> write a constant 0x1.
>>>>> Of course most other bits are clearly OSD related (alpha =
blending),
>>>>> i.e. they can have any value (incl. 0) if OSD is disabled. But =
here we
>>>>> enable it. I think there may be missing some setting for the other =
bits.
>>>>> So are you sure, that we can unconditionally reset *all* bits
>>>>> except JZ_LCD_OSDC_OSDEN for the jz4780?
>>>>> Well I have no experience with OSD being enabled at all. I.e. I =
have no
>>>>> test scenario.
>=20
> It turns out that the line
>=20
> 		ret =3D clk_prepare_enable(priv->lcd_clk);
>=20
> initializes JZ_REG_LCD_OSDC to 0x00010005 (i.e. printk tells 0x0 =
before).

more detailled test shows that it is the underlying=20

	clk_enable(priv->lcd_clk)

(i.e. not the prepare).
>=20
> and writing=20
>=20
> 		regmap_write(priv->map, JZ_REG_LCD_OSDC, =
JZ_LCD_OSDC_OSDEN);
>=20
> overwrites it with 0x00000001.
>=20
> This makes the HDMI monitor go/stay black until I write manually 0x5 =
to
> JZ_REG_LCD_OSDC.
>=20
> This means that JZ_LCD_OSDC_ALPHAEN must be enabled on jz4780 as well.
> Hence overwriting just with JZ_LCD_OSDC_OSDEN breaks it.
>=20
> Now the questions:
> a) 0x5 is understandable that it sets JZ_LCD_OSDC_ALPHAEN - but why is =
it needed?
>   Is this a not well documented difference between jz4740/60/70/80?
> b) how can clk_prepare_enable() write 0x00010005 to JZ_REG_LCD_OSDC? =
Bug or feature?
>   Something in cgu driver going wrong?

I now suspect that it is an undocumented SoC feature.

> c) what do your SoC or panels do if you write 0x5 to JZ_REG_LCD_OSDC?
> d) 0x00010005 also has bit 16 set which is undocumented... But this is =
a don't care
>   according to jz4780 PM.

BR and thanks,
Nikolaus

