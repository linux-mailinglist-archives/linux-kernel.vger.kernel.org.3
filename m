Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E55492BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346855AbiARQ7P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jan 2022 11:59:15 -0500
Received: from aposti.net ([89.234.176.197]:56650 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbiARQ7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:59:14 -0500
Date:   Tue, 18 Jan 2022 16:58:58 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v5 2/7] drm/ingenic: Add support for JZ4780 and HDMI
 output
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
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
Message-Id: <AI0X5R.YWIZO63QXTF4@crapouillou.net>
In-Reply-To: <C846BAFB-473D-41D8-93B9-B9ECDD1846C1@goldelico.com>
References: <cover.1633436959.git.hns@goldelico.com>
        <2c7d0aa7d3ef480ebb996d37c27cbaa6f722728b.1633436959.git.hns@goldelico.com>
        <FXTI0R.3FZIJZ7UYSNQ@crapouillou.net>
        <7CEBB741-2218-40A7-9800-B3A154895274@goldelico.com>
        <Q6U72R.9HY4TXLC6RWV2@crapouillou.net>
        <229EBE4C-6555-41DE-962F-D82798AEC650@goldelico.com>
        <HQY82R.69JHJIC64HDO1@crapouillou.net>
        <5BC61397-AF28-45CD-83F6-FA2C760F3995@goldelico.com>
        <C846BAFB-473D-41D8-93B9-B9ECDD1846C1@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Le mar., janv. 18 2022 at 15:50:01 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> Hi Paul,
> any insights on the JZ_REG_LCD_OSDC issue below?

Sorry, I missed your previous email. I blame the holidays ;)

> There is a second, unrelated issue with the introduction of
> 
> "drm/bridge: display-connector: implement bus fmts callbacks"
> 
> which breaks bus format negotiations.
> 
> These are the two last unsolved issues to submit a fully working 
> driver.
> 
>>  Am 22.12.2021 um 15:03 schrieb H. Nikolaus Schaller 
>> <hns@goldelico.com>:
>> 
>>>  Am 08.11.2021 um 10:37 schrieb Paul Cercueil 
>>> <paul@crapouillou.net>:
>>> 
>>>  Hi Nikolaus,
>>> 
>>>  Le dim., nov. 7 2021 at 21:25:38 +0100, H. Nikolaus Schaller 
>>> <hns@goldelico.com> a écrit :
>>>>  Hi Paul,
>>>>>>>> 
>>>>>>>>  @@ -1274,7 +1319,7 @@ static int ingenic_drm_bind(struct 
>>>>>>>> device *dev, bool has_components)
>>>>>>>>  	/* Enable OSD if available */
>>>>>>>>  	if (soc_info->has_osd)
>>>>>>>>  -		regmap_write(priv->map, JZ_REG_LCD_OSDC, 
>>>>>>>> JZ_LCD_OSDC_OSDEN);
>>>>>>>>  +		regmap_set_bits(priv->map, JZ_REG_LCD_OSDC, 
>>>>>>>> JZ_LCD_OSDC_OSDEN);
>>>>>>>  This change is unrelated to this patch, and I'm not even sure 
>>>>>>> it's a valid change. The driver shouldn't rely on previous 
>>>>>>> register values.
>>>>>>  I think I already commented that I think the driver should also 
>>>>>> not reset
>>>>>>  previous register values to zero.
>>>>>  You did comment this, yes, but I don't agree. The driver 
>>>>> *should* reset the registers to zero. It should *not* have to 
>>>>> rely on whatever was configured before.
>>>>>  Even if I did agree, this is a functional change unrelated to 
>>>>> JZ4780 support, so it would have to be splitted to its own patch.
>>>>  Well it is in preparation of setting more bits that are only 
>>>> available for the jz4780.
>>>>  But it will be splitted into its own patch for other reasons - if 
>>>> we ever make osd working...
>>>>>>  If I counted correctly this register has 18 bits which seem to 
>>>>>> include
>>>>>>  some interrupt masks (which could be initialized somewhere 
>>>>>> else) and we
>>>>>>  write a constant 0x1.
>>>>>>  Of course most other bits are clearly OSD related (alpha 
>>>>>> blending),
>>>>>>  i.e. they can have any value (incl. 0) if OSD is disabled. But 
>>>>>> here we
>>>>>>  enable it. I think there may be missing some setting for the 
>>>>>> other bits.
>>>>>>  So are you sure, that we can unconditionally reset *all* bits
>>>>>>  except JZ_LCD_OSDC_OSDEN for the jz4780?
>>>>>>  Well I have no experience with OSD being enabled at all. I.e. I 
>>>>>> have no
>>>>>>  test scenario.
>> 
>>  It turns out that the line
>> 
>>  		ret = clk_prepare_enable(priv->lcd_clk);
>> 
>>  initializes JZ_REG_LCD_OSDC to 0x00010005 (i.e. printk tells 0x0 
>> before).
> 
> more detailled test shows that it is the underlying
> 
> 	clk_enable(priv->lcd_clk)
> 
> (i.e. not the prepare).
>> 
>>  and writing
>> 
>>  		regmap_write(priv->map, JZ_REG_LCD_OSDC, JZ_LCD_OSDC_OSDEN);
>> 
>>  overwrites it with 0x00000001.
>> 
>>  This makes the HDMI monitor go/stay black until I write manually 
>> 0x5 to
>>  JZ_REG_LCD_OSDC.
>> 
>>  This means that JZ_LCD_OSDC_ALPHAEN must be enabled on jz4780 as 
>> well.
>>  Hence overwriting just with JZ_LCD_OSDC_OSDEN breaks it.
>> 
>>  Now the questions:
>>  a) 0x5 is understandable that it sets JZ_LCD_OSDC_ALPHAEN - but why 
>> is it needed?
>>    Is this a not well documented difference between jz4740/60/70/80?
>>  b) how can clk_prepare_enable() write 0x00010005 to 
>> JZ_REG_LCD_OSDC? Bug or feature?
>>    Something in cgu driver going wrong?
> 
> I now suspect that it is an undocumented SoC feature.

Not at all. If the clock is disabled, the LCD controller is disabled, 
so all the registers read zero, this makes sense. You can only read the 
registers when the clock is enabled. On some SoCs, reading disabled 
registers can even cause a complete lockup.

Why is this JZ_LCD_OSDC_ALPHAEN bit needed now? I remember it working 
fine last time I tried, and now I indeed get a black screen unless this 
bit is set. The PM doesn't make it obvious that the bit is required, 
but that wouldn't be surprising.

Anyway, feel free to send a patch to fix it (with a Fixes: tag). 
Ideally something like this:

u32 osdc = 0;
...
if (soc_info->has_osd)
    osdc |= JZ_LCD_OSDC_OSDEN;
if (soc_info->has_alpha)
    osdc |= JZ_LCD_OSDC_ALPHAEN;
regmap_write(priv->map, JZ_REG_LCD_OSDC, osdc);

This also ensures that the OSDC register is properly initialized in the 
!has_osd case. The driver shouldn't rely on pre-boot values in the 
registers.

Cheers,
-Paul

> 
>>  c) what do your SoC or panels do if you write 0x5 to 
>> JZ_REG_LCD_OSDC?
>>  d) 0x00010005 also has bit 16 set which is undocumented... But this 
>> is a don't care
>>    according to jz4780 PM.
> 
> BR and thanks,
> Nikolaus
> 


