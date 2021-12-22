Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8F47D356
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245571AbhLVOES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:04:18 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:28003 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbhLVOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1640181829;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Ox+SYUQb3svJHHmkCc93VKFLaFLcKBoVyhvEXXfA+EE=;
    b=e9fhHejEYi5bM0L0/bPIESG6Cp43JknOAGnuYjz2TX77xJrOCoitqSmA+HMLCZnAWf
    qdUImKt6FCDmr5jjfJt4LBaTdcu7HDczd+hgMy1bQzoBlGxnAK/q0mCCx5213HrbIagt
    7kMFKD7lep60v1bHi60EsDint0dNhOrpeOY0uQmueTAUVY7yq79Qbr+XvF+Zb/j+QYWg
    H/ZEh/L5/nZWsRWPVPiUzSv01T2GuTiA71Cz5+PKw8mqXOvaE+m1nZRH4vOD0xszoV1I
    CiFXIhy3EghVJJzrlyTUeDhABsEhCcftqND5a5ieaHRUug3Ry4a0TNpExJzZm35ZWr2M
    Y2Bg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3iMUXTw=="
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
    by smtp.strato.de (RZmta 47.35.3 DYNA|AUTH)
    with ESMTPSA id 404833xBME3li7v
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 22 Dec 2021 15:03:47 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v5 2/7] drm/ingenic: Add support for JZ4780 and HDMI
 output
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <HQY82R.69JHJIC64HDO1@crapouillou.net>
Date:   Wed, 22 Dec 2021 15:03:46 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BC61397-AF28-45CD-83F6-FA2C760F3995@goldelico.com>
References: <cover.1633436959.git.hns@goldelico.com>
 <2c7d0aa7d3ef480ebb996d37c27cbaa6f722728b.1633436959.git.hns@goldelico.com>
 <FXTI0R.3FZIJZ7UYSNQ@crapouillou.net>
 <7CEBB741-2218-40A7-9800-B3A154895274@goldelico.com>
 <Q6U72R.9HY4TXLC6RWV2@crapouillou.net>
 <229EBE4C-6555-41DE-962F-D82798AEC650@goldelico.com>
 <HQY82R.69JHJIC64HDO1@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Paul,
sorry to go back here...

DDC power control is working now (and I now understand that a typo in my =
work-in-progress
ci20.dts had switched the DDC SDA to active "1" without powering DDC and =
that may be beyond
what the monitor wanted to see and therefore DDC edid isn't reliable any =
more... Other
HDMI devices are more probably robust).

I have also tested HPD and could make events passed to user-space by =
setting poll_mode.

There is one subtle thing in ingenic-drm-drv I do not yet understand:

> Am 08.11.2021 um 10:37 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le dim., nov. 7 2021 at 21:25:38 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> Hi Paul,
>>>>>>=20
>>>>>> @@ -1274,7 +1319,7 @@ static int ingenic_drm_bind(struct device =
*dev, bool has_components)
>>>>>> 	/* Enable OSD if available */
>>>>>> 	if (soc_info->has_osd)
>>>>>> -		regmap_write(priv->map, JZ_REG_LCD_OSDC, =
JZ_LCD_OSDC_OSDEN);
>>>>>> +		regmap_set_bits(priv->map, JZ_REG_LCD_OSDC, =
JZ_LCD_OSDC_OSDEN);
>>>>> This change is unrelated to this patch, and I'm not even sure it's =
a valid change. The driver shouldn't rely on previous register values.
>>>> I think I already commented that I think the driver should also not =
reset
>>>> previous register values to zero.
>>> You did comment this, yes, but I don't agree. The driver *should* =
reset the registers to zero. It should *not* have to rely on whatever =
was configured before.
>>> Even if I did agree, this is a functional change unrelated to JZ4780 =
support, so it would have to be splitted to its own patch.
>> Well it is in preparation of setting more bits that are only =
available for the jz4780.
>> But it will be splitted into its own patch for other reasons - if we =
ever make osd working...
>>>> If I counted correctly this register has 18 bits which seem to =
include
>>>> some interrupt masks (which could be initialized somewhere else) =
and we
>>>> write a constant 0x1.
>>>> Of course most other bits are clearly OSD related (alpha blending),
>>>> i.e. they can have any value (incl. 0) if OSD is disabled. But here =
we
>>>> enable it. I think there may be missing some setting for the other =
bits.
>>>> So are you sure, that we can unconditionally reset *all* bits
>>>> except JZ_LCD_OSDC_OSDEN for the jz4780?
>>>> Well I have no experience with OSD being enabled at all. I.e. I =
have no
>>>> test scenario.

It turns out that the line

		ret =3D clk_prepare_enable(priv->lcd_clk);

initializes JZ_REG_LCD_OSDC to 0x00010005 (i.e. printk tells 0x0 =
before).

and writing=20

		regmap_write(priv->map, JZ_REG_LCD_OSDC, =
JZ_LCD_OSDC_OSDEN);

overwrites it with 0x00000001.

This makes the HDMI monitor go/stay black until I write manually 0x5 to
JZ_REG_LCD_OSDC.

This means that JZ_LCD_OSDC_ALPHAEN must be enabled on jz4780 as well.
Hence overwriting with JZ_LCD_OSDC_OSDEN breaks it.

I didn't notice before because my test setup had some additional private =
patches
+ reverts and it did not properly revert to regmap_write.

Now the questions:
a) 0x5 is understandable that it sets JZ_LCD_OSDC_ALPHAEN - but why is =
it needed?
   Is this a not well documented difference between jz4740/60/70/80?
b) how can clk_prepare_enable() write 0x00010005 to JZ_REG_LCD_OSDC? Bug =
or feature?
   Something in cgu driver going wrong?
c) what do your SoC or panels do if you write 0x5 to JZ_REG_LCD_OSDC?
d) 0x00010005 also has bit 16 set which is undocumented... But this is a =
don't care
   according to jz4780 PM.

BR and thanks,
Nikolaus

