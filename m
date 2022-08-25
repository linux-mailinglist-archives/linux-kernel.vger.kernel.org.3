Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BE95A1553
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbiHYPNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHYPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:13:38 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DDA5A3E4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ds1ED9/E8RnGTPOcmFhmM3nxfl6XFIk5DEUz5wvPIYY=; b=XM7AfOD/00Npw2p+NjBfouwELf
        I9bRHc2R4q55W61qDwzprV6raEBmp4A4jIPmklgYwmujyF0ZIsrepW67YNfWDpYTQejiqU9UfqPgu
        mLwLWAV5zakGYqrErCtzYBGrEqWkK/I2qst6oBbL5qVI12WDJ14XSDOOvRgSJlxheFZKfmjx5bf4n
        Gk+1H7L8wo6G2gMVjrLOhbMm1TG24aLDoJYl7EU+tXEf21icteOQdosRQJ5RsbGNc2n6g9FGV4VH8
        RrJn1xVGCUvZumcitD1aHU1U76EUa9VdCG9QH08Xd74yBAyeiWBUMrUxhU5cSSEYP/n3RhqRonkjf
        lUzM52kQ==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=49886)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oREY2-0007oo-36; Thu, 25 Aug 2022 17:13:34 +0200
Message-ID: <863beb42-1012-b38a-0c3d-89b7e035aa82@tronnes.org>
Date:   Thu, 25 Aug 2022 17:13:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 05/35] drm/connector: Add TV standard property
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
 <37a76651-a457-e50d-9a05-00ca9ed5d729@tronnes.org>
 <20220825134408.dioj2lbycl7jm3ld@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220825134408.dioj2lbycl7jm3ld@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 25.08.2022 15.44, skrev Maxime Ripard:
> Hi,
> 
> On Sat, Aug 20, 2022 at 10:12:46PM +0200, Noralf Trønnes wrote:
>>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>>> index 1e9996b33cc8..78275e68ff66 100644
>>> --- a/include/drm/drm_connector.h
>>> +++ b/include/drm/drm_connector.h
>>> @@ -143,6 +143,32 @@ enum subpixel_order {
>>>  
>>>  };
>>>  
>>> +#define DRM_MODE_TV_NORM_NTSC_443	(1 << 0)
>>> +#define DRM_MODE_TV_NORM_NTSC_J		(1 << 1)
>>> +#define DRM_MODE_TV_NORM_NTSC_M		(1 << 2)
>>> +#define DRM_MODE_TV_NORM_PAL_60		(1 << 3)
>>> +#define DRM_MODE_TV_NORM_PAL_B		(1 << 4)
>>> +#define DRM_MODE_TV_NORM_PAL_D		(1 << 5)
>>> +#define DRM_MODE_TV_NORM_PAL_G		(1 << 6)
>>> +#define DRM_MODE_TV_NORM_PAL_H		(1 << 7)
>>> +#define DRM_MODE_TV_NORM_PAL_I		(1 << 8)
>>> +#define DRM_MODE_TV_NORM_PAL_M		(1 << 9)
>>> +#define DRM_MODE_TV_NORM_PAL_N		(1 << 10)
>>> +#define DRM_MODE_TV_NORM_PAL_NC		(1 << 11)
>>> +#define DRM_MODE_TV_NORM_SECAM_60	(1 << 12)
>>> +#define DRM_MODE_TV_NORM_SECAM_B	(1 << 13)
>>> +#define DRM_MODE_TV_NORM_SECAM_D	(1 << 14)
>>> +#define DRM_MODE_TV_NORM_SECAM_G	(1 << 15)
>>> +#define DRM_MODE_TV_NORM_SECAM_K	(1 << 16)
>>> +#define DRM_MODE_TV_NORM_SECAM_K1	(1 << 17)
>>> +#define DRM_MODE_TV_NORM_SECAM_L	(1 << 18)
>>> +#define DRM_MODE_TV_NORM_HD480I		(1 << 19)
>>> +#define DRM_MODE_TV_NORM_HD480P		(1 << 20)
>>> +#define DRM_MODE_TV_NORM_HD576I		(1 << 21)
>>> +#define DRM_MODE_TV_NORM_HD576P		(1 << 22)
>>> +#define DRM_MODE_TV_NORM_HD720P		(1 << 23)
>>> +#define DRM_MODE_TV_NORM_HD1080I	(1 << 24)
>>> +
>>
>> This is an area where DRM overlaps with v4l2, see:
>> - include/dt-bindings/display/sdtv-standards.h
>> - v4l2_norm_to_name()
>>
>> Maybe we should follow suit, but if we do our own thing please mention
>> why in the commit message.
> 
> Are you suggesting that we'd share that definition with v4l2?
> 

If possible, yes.

> I've tried to share some code in the past between v4l2 and DRM, and it
> got completely shut down so it's not something I'd like to try again, if
> possible.
> 

But that is a good enough reason not to do so. I just got the impression
from some of Laurent's emails a while back that there was some
cooperativ atmosphere, but I might be mistaken in my reading/understanding.

It is ofc possible to just copy the values from sdtv-standards.h, but I
see that hd* is missing from that list, so not sure if there's much
point if it has to be extended without changing the source.

We can at least use the names from v4l2_norm_to_name(), but from a quick
look it seems you already do so.

Noralf.
