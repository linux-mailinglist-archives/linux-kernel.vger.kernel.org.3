Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41460464F56
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349591AbhLAOGy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Dec 2021 09:06:54 -0500
Received: from aposti.net ([89.234.176.197]:49768 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234728AbhLAOGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:06:51 -0500
Date:   Wed, 01 Dec 2021 14:03:14 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v10 4/8] drm/ingenic: Add dw-hdmi driver for jz4780
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Boddie <paul@boddie.org.uk>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Message-Id: <EDWF3R.CMVWMJL42OH9@crapouillou.net>
In-Reply-To: <46070A95-0FA9-43F9-A9A9-52A7B58B88F5@goldelico.com>
References: <cover.1638307601.git.hns@goldelico.com>
        <4daf0c5dbed2c47c97003ab8de0a7dbd2a335dc3.1638307601.git.hns@goldelico.com>
        <LKTF3R.YREPOCHOSMQN2@crapouillou.net> <Yad69aTXcGixXvy3@sirena.org.uk>
        <46070A95-0FA9-43F9-A9A9-52A7B58B88F5@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus, Mark,

Le mer., déc. 1 2021 at 14:51:51 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> Hi,
> 
>>  Am 01.12.2021 um 14:39 schrieb Mark Brown <broonie@kernel.org>:
>> 
>>  On Wed, Dec 01, 2021 at 01:02:45PM +0000, Paul Cercueil wrote:
>>>  Le mar., nov. 30 2021 at 22:26:37 +0100, H. Nikolaus Schaller
>> 
>>>>  +	regulator = devm_regulator_get_optional(&pdev->dev, "hdmi-5v");
>>>>  +	if (IS_ERR(regulator)) {
>>>>  +		ret = PTR_ERR(regulator);
>> 
>>  Why is this using _optional()?  This should only be done when the 
>> supply
>>  can be physically absent
> 
> There can be +5V for HDMI but without a regulator that is visible to 
> or controllable
> by the driver.

There is always a power supply though. Either a controllable one 
(through e.g. a GPIO), or it's just connected to the mains +5V; the pin 
is never left floating. In the second case, in DTS the "hdmi-5v" would 
be connected to some 5v regulator, even if it's just a dummy VCC-5V 
regulator. So Mark has a point.

> So hdmi-5v can be simply missing in DTS in which case the driver does 
> not need to
> care about. The driver just can't turn it on or off.

Please make it mandatory in DTS then, and use devm_regulator_get() in 
the driver.

Cheers,
-Paul

>>  (in which case I'd expect to see special
>>  handling).
> 
> The special case is to not enable/disable the regulator if it does 
> not exist
> and assume that there is hardware providing it otherwise (the driver 
> can't know
> that except by using get_optional). This is done by the code below
> 
>>>>  +	if (IS_ERR(regulator)) {
> 
> ...
> 
>>  +	if (!regulator)
>>  +		return 0;
>> 
>>  +	ret = regulator_enable(regulator);
> 
> ...
> 
> BR and thanks,
> Nikolaus
> 
> 
> 
> 


