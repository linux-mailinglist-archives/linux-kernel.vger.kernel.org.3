Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4761E4A70F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbiBBMlg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Feb 2022 07:41:36 -0500
Received: from aposti.net ([89.234.176.197]:46104 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240128AbiBBMlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:41:35 -0500
Date:   Wed, 02 Feb 2022 12:41:21 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v12 2/9] drm/ingenic: Add support for JZ4780 and HDMI
 output
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Message-Id: <XKGO6R.LTTYDEGZ8RJH3@crapouillou.net>
In-Reply-To: <78F51BD7-112A-458D-8FCE-6A67572A182B@goldelico.com>
References: <cover.1643632014.git.hns@goldelico.com>
        <6a7b188769a7ad477bf8cb71e1b9bc086b92388d.1643632014.git.hns@goldelico.com>
        <N7AO6R.7I6FABF106MT1@crapouillou.net>
        <1F27171F-DFCA-4707-8F50-D1A343F6D78E@goldelico.com>
        <CYEO6R.2QDXEFO5G1WQ3@crapouillou.net>
        <37CB6D86-4295-4281-BF3E-3E4B40E74196@goldelico.com>
        <5ZFO6R.M6Z7S3EBA1YC1@crapouillou.net>
        <78F51BD7-112A-458D-8FCE-6A67572A182B@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer., févr. 2 2022 at 13:33:15 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> 
> 
>>  Am 02.02.2022 um 13:28 schrieb Paul Cercueil <paul@crapouillou.net>:
>> 
>> 
>> 
>>  Le mer., févr. 2 2022 at 13:17:14 +0100, H. Nikolaus Schaller 
>> <hns@goldelico.com> a écrit :
>>>  Hi Paul,
>>>>  Am 02.02.2022 um 13:06 schrieb Paul Cercueil 
>>>> <paul@crapouillou.net>:
>>>>  Hi Nikolaus,
>>>>>>>  @@ -446,6 +454,9 @@ static int 
>>>>>>> ingenic_drm_plane_atomic_check(struct drm_plane *plane,
>>>>>>>  	if (!crtc)
>>>>>>>  		return 0;
>>>>>>>  +	if (plane == &priv->f0)
>>>>>>>  +		return -EINVAL;
>>>>>>  This will break JZ4725B -> JZ4770 SoCs, the f0 plane is 
>>>>>> perfectly usable there.
>>>>>  Hm. I think it was your request/proposal to add this [1]?
>>>>  Because otherwise with your current patchset the f0 plane does 
>>>> not work *on JZ4780*.
>>>  Not that I am eager to fix that, but...
>>>  maybe it could be better to fix than having the check and -EINVAL 
>>> depend on SoC compatible string
>>>  (or some new flag in soc_info. plane_f0_not_working)?
>> 
>>  Totally agree! A proper fix would be much better. A 
>> "plane_f0_not_working" in the meantime is OK with me.
> 
> Ok, then I'll prepare a v13 with plane_f0_not_working.
> 
>> 
>>  Note that there are other things not working with your current 
>> implementation, for instance you cannot set the X/Y start position 
>> of the f1 plane, which means it's only really usable for fullscreen 
>> desktop/windows.
> 
> Is setting x/y possible for the other SoC?

Yes. They support different x/y positions, sizes, and pixel format for 
both f0, f1 and IPU planes.

-Paul

>> 
>>>>  It does work on older SoCs.
>>>>>  What I have forgotten is why the f0 plane should not be usable 
>>>>> for jz4780.
>>>>  We return an error here to prevent userspace from using the f0 
>>>> plane until it's effectively working on the JZ4780.
>>>  Well, what would be not working with that plane if user-space 
>>> would try to use it?
>> 
>>  From what I remember, it wouldn't show anything on screen, and 
>> after that trying to use the f1 plane wouldn't work either.
> 
> Ok. That may become a big project to fix. So let's do step 1 first.
> 
> BR and thanks,
> NIkolaus
> 


