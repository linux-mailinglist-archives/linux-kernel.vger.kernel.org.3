Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032854AF359
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiBINy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiBINyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:54:24 -0500
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 05:54:19 PST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72845C0613CA;
        Wed,  9 Feb 2022 05:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644414675;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=GQPlm8vXIXC8cptkyzh61KD3Ta4Bb5Atb1Q/XX/fIIc=;
    b=nXvev9PnWSndJCcJCBvMUmbwaNkRqZLfQDSglDhXULYjxYGbDbPZJoj04m3UCaTLy+
    23EYzRVfbbvbsbb/rOdAAxdb1DS+zdhowalOY7ZQPbie8p7uCMGUAXHJ1aDuY9+gPA6X
    zwJTgtw82SHU0z36ZdOFWsXb7RwOZpC7U0y5m45ujETDScUgRPxHWnrKPRvn9AZZBnR/
    wtAowmeKX5tXtoDaGQVOQRlPSul9fWwn/K9D/H9rAFpOlrMpVxGprGmdKzk1i3136DPz
    Vqq8khCrV2klN0R/146pIf02+czmtlCang8G9OPKOtBcg9rX0rmZB3M9FIsvGQpRjnBg
    t/1g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3iMYawg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y19DpFguL
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 9 Feb 2022 14:51:15 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v13 5/9] drm/synopsys+ingenic: repair hot plug detection
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <4ED17R.TVHQS4U654LE@crapouillou.net>
Date:   Wed, 9 Feb 2022 14:51:15 +0100
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
        dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <29373704-13B1-4E40-873B-A13826A9859B@goldelico.com>
References: <cover.1643819482.git.hns@goldelico.com>
 <08fb9549042d35c1904fd977e68aa52f74f755b0.1643819482.git.hns@goldelico.com>
 <4ED17R.TVHQS4U654LE@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 09.02.2022 um 13:01 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Nikolaus,
>=20
> Le mer., f=C3=A9vr. 2 2022 at 17:31:19 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> so that it calls drm_kms_helper_hotplug_event().
>> We need to set .poll_enabled but that struct component
>> can only be accessed in the core code. Hence we add a public
>> setter function.
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 +++++++++
>> drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c | 2 ++
>> include/drm/bridge/dw_hdmi.h              | 1 +
>> 3 files changed, 12 insertions(+)
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c =
b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 54d8fdad395f5..52e7cd2e020d3 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -3216,6 +3216,15 @@ static int dw_hdmi_parse_dt(struct dw_hdmi =
*hdmi)
>> 	return 0;
>> }
>> +void dw_hdmi_enable_poll(struct dw_hdmi *hdmi, bool enable)
>> +{
>> +	if (hdmi->bridge.dev)
>> +		hdmi->bridge.dev->mode_config.poll_enabled =3D enable;
>> +	else
>> +		dev_warn(hdmi->dev, "no hdmi->bridge.dev");
>> +}
>> +EXPORT_SYMBOL_GPL(dw_hdmi_enable_poll);
>> +
>> struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>> 			      const struct dw_hdmi_plat_data *plat_data)
>> {
>> diff --git a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c =
b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
>> index 34e986dd606cf..90547a28dc5c7 100644
>> --- a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
>> +++ b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
>> @@ -55,6 +55,8 @@ ingenic_dw_hdmi_mode_valid(struct dw_hdmi *hdmi, =
void *data,
>> 	if (mode->clock > 216000)
>> 		return MODE_CLOCK_HIGH;
>> +	dw_hdmi_enable_poll(hdmi, true);
>> +
>=20
> It would be a better idea to move this patch before the patch that =
creates ingenic-dw-hdmi.c. Then you wouldn't have to patch a file that =
was just introduced.

The main reason to have a separate patch was that I was not sure what is =
already merged somewhere and what is not.
And fixing something which is not yet introduced makes it quite =
difficult to explain, why it is needed at all...

So I would prefer to leave it as is until more comments arrive.

>=20
> As for the patch itself, I guess it's fine, but is that really needed? =
My understanding is that it's the hdmi-connector's job to poll.

The hardware gpio that we can define for the hdmi-connector seems not to =
be available on all CI20 boards.

Hence we must trigger (enable) the poll logic of the dw-hdmi bridge from =
the SoC specialization.
This seems to be best done in the ingenic-dw-hdmi driver.

Unless someone has a better idea how the dw-hdmi driver could find out =
that it should poll if a connector is defined.
The base driver seems as if it has been developed long ago without =
connectors and bridge chains in mind.
Hence we are retrofitting fixes for changes introduced outside the =
drivers.

BR,
Nikolaus

