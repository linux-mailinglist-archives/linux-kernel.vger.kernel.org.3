Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F344C56FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiBZRNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBZRN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:13:28 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BEFBD7CC;
        Sat, 26 Feb 2022 09:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1645895556;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=rAYy4Z35sSvRmW3KU/N66fatHaFpRvigK4dz2yH4zPQ=;
    b=RqqY8R83HtnL0jTR22tpkHKb0et4BaXXkFDbAnYqGNqqnpFOX9QewquRUQJaZa3rSW
    BG/4dxSRpQFuQuMZ2+VUJ+bCkZRBHbDVopudOmBGnxDS/WZhnCKgqDUy6dEuYESKatQb
    CUUThk3ThvCcrps0vfp4qr5HIamaMGW9KyP5wxhRsu3+kT85dNTBcFv0Cs4dmD/07ISv
    7MS7g/W6qrEhi1nHziGAHNhVLGpxroWY4BT9OMlXNiPgQyuo5N3F2PfAqZXevz4upvoI
    jhBSkOG7tCzQmA7a3dD7JjXmof7qoARDyYeVmz1CW+w/t0FstTI69LCo1X08z2VYjWP6
    6wTg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw43sTrQ="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 SBL|AUTH)
    with ESMTPSA id V41e6fy1QHCYE1v
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Sat, 26 Feb 2022 18:12:34 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v15 4/7] drm/bridge: dw-hdmi: repair interworking with
 hdmi-connector for jz4780
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <9c6f5c0b-5879-736f-344f-dfa12a0d7937@baylibre.com>
Date:   Sat, 26 Feb 2022 18:12:34 +0100
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Harry Wentland <harry.wentland@amd.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        letux-kernel@openphoenux.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F01AD9B-EA49-4A34-A421-43E9E6268311@goldelico.com>
References: <cover.1644681054.git.hns@goldelico.com>
 <d4d08582c49ec089095dd0ede4cdf2752f9d1eb8.1644681054.git.hns@goldelico.com>
 <9c6f5c0b-5879-736f-344f-dfa12a0d7937@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> Am 21.02.2022 um 09:11 schrieb Neil Armstrong =
<narmstrong@baylibre.com>:
>=20
> Hi,
>=20
> On 12/02/2022 16:50, H. Nikolaus Schaller wrote:
>> Commit 7cd70656d1285b ("drm/bridge: display-connector: implement bus =
fmts callbacks")
>> introduced a new mechanism to negotiate bus formats between hdmi =
connector
>> and the synopsys hdmi driver inside the jz4780.
>> By this, the dw-hdmi is no longer the only bridge and sets up a list
>> of formats in dw_hdmi_bridge_atomic_get_output_bus_fmts().
>> This includes MEDIA_BUS_FMT_UYVY8_1X16 which is chosen for the jz4780 =
but only
>> produces a black screen.
>> This fix is based on the observation that max_bpc =3D 0 when running =
this
>> function while info->bpc =3D 8. Since the formats checks before this =
always test
>> for max_bpc >=3D info->pbc indirectly my assumption is that we must =
check it
>> here as well.
>> Adding the proposed patch makes the CI20/jz4780 panel work again in
>> MEDIA_BUS_FMT_RGB888_1X24 mode.
>> Fixes: 7cd70656d1285b ("drm/bridge: display-connector: implement bus =
fmts callbacks")
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c =
b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index b0d8110dd412c..826a055a7a273 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2620,10 +2620,10 @@ static u32 =
*dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>>  		output_fmts[i++] =3D MEDIA_BUS_FMT_RGB101010_1X30;
>>  	}
>>  -	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
>> +	if (max_bpc >=3D info->bpc && info->color_formats & =
DRM_COLOR_FORMAT_YCBCR422)
>>  		output_fmts[i++] =3D MEDIA_BUS_FMT_UYVY8_1X16;
>>  -	if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
>> +	if (max_bpc >=3D info->bpc && info->color_formats & =
DRM_COLOR_FORMAT_YCBCR444)
>>  		output_fmts[i++] =3D MEDIA_BUS_FMT_YUV8_1X24;
>>    	/* Default 8bit RGB fallback */
>=20
> Please do the same for all other cases and change the patch subject to =
something more accurate like:
> "drm/bridge: dw-hdmi: take display info bpc in account for bus formats =
negociation"

thank you very much for this analysis.

In fact my fix was also not correctly doing the right comparisons. The =
rules should have the
same structure as for all cases before, i.e. check for >=3D 8 and then =
handle both color formats.
I have fixed and tested on my CI20 board and updated the description and =
Fixes: tags.

v16 will come now (as part of the jz4780 hdmi series).

BR and thanks,
Nikolaus

