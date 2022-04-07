Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8134F7DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbiDGLTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244774AbiDGLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:18:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD46005D;
        Thu,  7 Apr 2022 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649330153;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=c1j57OzkC5NhGusvepHfUpBDwheH8518tflcTdvtQXI=;
    b=Ne/byUbqDQ8NO3Y+LUdT7kFrvAV8rZPg4xQAgkYqHhgSNssycLc7GSsRbtOpIv34mm
    kos8DK6qvFMbxPVyqlso1fzT+29puPH4Tx8EzUQs+ueHy5IC+iDkooe/cJPCq/LKLVKR
    DG7N8xchPvGSRHvJnw31g3ki/4fVjbVRRUOTAdRawaI+twGwj96RoVl19VX5kFclCIHZ
    NWEDt8UoZYIABZfmR7LznpxsC9gulnyqv3wonnpZ7eFdNoDGKGJYhMEDFvmse2aIyHyO
    rbFq8Pk/cJ55o3089CDVhqYuasPYCf3Js/YPw4l+v1aAI+Bq1tUwxRxO4Wl+GQ2tUven
    uHzQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3i8MRqg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy37BFrjx4
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 7 Apr 2022 13:15:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v17 5/6] drm/bridge: dw-hdmi: add YCBCR formats only if
 CSC is available
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <9d3f8bfb-74f7-cbd9-a6f5-1e8acae4c13b@baylibre.com>
Date:   Thu, 7 Apr 2022 13:15:52 +0200
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        letux-kernel@openphoenux.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8A7AD7C-8FE0-4183-9B84-2F569EC9DA40@goldelico.com>
References: <cover.1649262368.git.hns@goldelico.com>
 <d5801eb7733a616df30fef1d192e88ad147afc1c.1649262368.git.hns@goldelico.com>
 <9d3f8bfb-74f7-cbd9-a6f5-1e8acae4c13b@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 07.04.2022 um 10:29 schrieb Neil Armstrong =
<narmstrong@baylibre.com>:
>=20
> On 06/04/2022 18:26, H. Nikolaus Schaller wrote:
>> otherwise they will produce a black HDMI screen.
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c =
b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index b5a665c5e406e..ec40dd8865065 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2628,10 +2628,12 @@ static u32 =
*dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>>  		output_fmts[i++] =3D MEDIA_BUS_FMT_RGB101010_1X30;
>>  	}
>>  -	if (hdmi->sink_is_hdmi && info->color_formats & =
DRM_COLOR_FORMAT_YCBCR422)
>> +	if (hdmi->csc_available && hdmi->sink_is_hdmi &&
>> +	    (info->color_formats & DRM_COLOR_FORMAT_YCBCR422))
>>  		output_fmts[i++] =3D MEDIA_BUS_FMT_UYVY8_1X16;
>>  -	if (hdmi->sink_is_hdmi && info->color_formats & =
DRM_COLOR_FORMAT_YCBCR444)
>> +	if (hdmi->csc_available && hdmi->sink_is_hdmi &&
>> +	    (info->color_formats & DRM_COLOR_FORMAT_YCBCR444))
>>  		output_fmts[i++] =3D MEDIA_BUS_FMT_YUV8_1X24;
>>    	/* Default 8bit RGB fallback */
>=20
> This patch shouldn't be needed anymore with proper filtering in patch =
1.

It can indeed be removed as well.

BR and thanks,
Nikolaus

