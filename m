Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E694CC2CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiCCQbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiCCQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:31:36 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E941C19CCE8;
        Thu,  3 Mar 2022 08:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646325032;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=FNsO/YbF9gcd5KbkSaCy1MSI7WoJeV00dX16xOx2Y5A=;
    b=pn3qtMxglTiWK6zY0z78sbxIv32sQ8slpTmknaEj3CHDTVbtDyLIbK4DfA1xolAWhb
    Zl7Oxe5jTHj/2gMJWsZ06HZ3UlOCrd2le6vfjhlG/EETVYMWod+VUe2gW3xMy5+hiAE7
    V8Ul9iRC8NzXmXNwjlN0kkHt035sTgc5PHS05/lf+qhXj7YsLoL9Yi8PA6xWbomCSPla
    IW1pUBvBe3XBxSXhxsxOdPaxpR8dUtGHKSXlJAZgM3BMTIqqInjwvcBZWCmo/OBbyy6w
    7lcIigD78usl8kLT0hJrqruDtqzEKWT+Otz0Q0/YS6DPJ7sPf3mAo8RGHj4qXfU91wxF
    WPlw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw47tT+k="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey23GUW0Ph
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Thu, 3 Mar 2022 17:30:32 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v16 1/4] drm/bridge: dw-hdmi: introduce
 dw_hdmi_enable_poll()
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <983e9064-17ad-e646-f37d-ca9173ba0967@baylibre.com>
Date:   Thu, 3 Mar 2022 17:30:31 +0100
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
Message-Id: <C8AE9A7A-E288-4637-ACAD-40CD33CD5F8C@goldelico.com>
References: <cover.1645895582.git.hns@goldelico.com>
 <e54838849f80454b863f9f5634dd10f79ef7bb8f.1645895582.git.hns@goldelico.com>
 <983e9064-17ad-e646-f37d-ca9173ba0967@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> Am 03.03.2022 um 17:23 schrieb Neil Armstrong =
<narmstrong@baylibre.com>:
>=20
> Hi,
>=20
> On 26/02/2022 18:12, H. Nikolaus Schaller wrote:
>> so that specialization drivers like ingenic-dw-hdmi can enable =
polling.
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 +++++++++
>>  include/drm/bridge/dw_hdmi.h              | 1 +
>>  2 files changed, 10 insertions(+)
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c =
b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 4befc104d2200..43e375da131e8 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -3217,6 +3217,15 @@ static int dw_hdmi_parse_dt(struct dw_hdmi =
*hdmi)
>>  	return 0;
>>  }
>>  +void dw_hdmi_enable_poll(struct dw_hdmi *hdmi, bool enable)
>> +{
>> +	if (hdmi->bridge.dev)
>> +		hdmi->bridge.dev->mode_config.poll_enabled =3D enable;
>> +	else
>> +		dev_warn(hdmi->dev, "no hdmi->bridge.dev");
>> +}
>> +EXPORT_SYMBOL_GPL(dw_hdmi_enable_poll);
>> +
>>  struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>>  			      const struct dw_hdmi_plat_data *plat_data)
>>  {
>> diff --git a/include/drm/bridge/dw_hdmi.h =
b/include/drm/bridge/dw_hdmi.h
>> index 2a1f85f9a8a3f..963960794b40e 100644
>> --- a/include/drm/bridge/dw_hdmi.h
>> +++ b/include/drm/bridge/dw_hdmi.h
>> @@ -196,5 +196,6 @@ enum drm_connector_status =
dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
>>  void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
>>  			    bool force, bool disabled, bool rxsense);
>>  void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
>> +void dw_hdmi_enable_poll(struct dw_hdmi *hdmi, bool enable);
>>    #endif /* __IMX_HDMI_H__ */
>=20
> As I understand, this is because the IRQ line of the dw-hdmi IP isn't =
connected right ? and you use the display-connector ddc gpio instead ?

Yes. The IRQ line is not connected on all boards as far as I can see.

>=20
> In this case I think the Ingenic DRM core should call =
drm_kms_helper_poll_init(drm) instead.

Ah, that is good. it seems to do "dw_hdmi_enable_poll()" in a more =
generic way.

Will test and rework for v17 asap.

BR and thanks,
Nikolaus

