Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A3516E36
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384667AbiEBKjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384695AbiEBKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:39:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD512BFA;
        Mon,  2 May 2022 03:35:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD1991F896;
        Mon,  2 May 2022 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651487731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dn9XSHCKolq6/lQSxksAI1EWQRJzfzUctxGyNj4FIbc=;
        b=H4Pm0Q0yA3s++FBy4JhcAn+VXsuwbz8Fxq1+g7xdI//6lmgPdtYrk9qwl89iFjgY0q+v9A
        vFfgslZCIPHnKronaXZ/xRH87DKgxyVR8/JSXQlT/q/Pwr5ghzvKTpZcu2JAFb64XOum3g
        5KuwBjjGXfL0jKv0D9JkVIZKHfgyH5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651487731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dn9XSHCKolq6/lQSxksAI1EWQRJzfzUctxGyNj4FIbc=;
        b=ganiifpaAbCaoGrzd9cDb8HCGMIpNTyU2n6eScpJ0CJfhXLvFgc8nPVsZ6QrNcNCjCSg1R
        3/CwDrQVFXtGwPAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DFCC133E5;
        Mon,  2 May 2022 10:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dugIEvKzb2IfRQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 02 May 2022 10:35:30 +0000
Message-ID: <c120e1c4-ac5c-afd5-8dd1-b4b51e0dcca9@suse.de>
Date:   Mon, 2 May 2022 12:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Alain Volmat <alain.volmat@foss.st.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Alison Wang <alison.wang@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Chen-Yu Tsai <wens@csie.org>, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Evan Quan <evan.quan@amd.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hao Fang <fanghao11@huawei.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        John Stultz <john.stultz@linaro.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kevin Hilman <khilman@baylibre.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marek Vasut <marex@denx.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Samuel Holland <samuel@sholland.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Stefan Agner <stefan@agner.ch>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Yong Wu <yong.wu@mediatek.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20220502084830.285639-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20220502084830.285639-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bZs9O7gVydbPyh0mFowmyKkQ"
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bZs9O7gVydbPyh0mFowmyKkQ
Content-Type: multipart/mixed; boundary="------------JAaQiYXsw1Wg2huPZuTUbFwL";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexey Brodkin <abrodkin@synopsys.com>, Alison Wang <alison.wang@nxp.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Brian Starkey <brian.starkey@arm.com>, Chen Feng <puck.chen@hisilicon.com>,
 Chen-Yu Tsai <wens@csie.org>, Chia-I Wu <olvaffe@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
 Evan Quan <evan.quan@amd.com>, Fabio Estevam <festevam@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans de Goede <hdegoede@redhat.com>, Hao Fang <fanghao11@huawei.com>,
 Hyun Kwon <hyun.kwon@xilinx.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Joel Stanley <joel@jms.id.au>,
 John Stultz <john.stultz@linaro.org>, Jyri Sarha <jyri.sarha@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Mario Limonciello <mario.limonciello@amd.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
 NXP Linux Team <linux-imx@nxp.com>, Neil Armstrong
 <narmstrong@baylibre.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Nirmoy Das <nirmoy.das@amd.com>, =?UTF-8?Q?Noralf_Tr=c3=b8nnes?=
 <noralf@tronnes.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Paul Cercueil <paul@crapouillou.net>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sam Ravnborg <sam@ravnborg.org>, Samuel Holland <samuel@sholland.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Solomon Chiu <solomon.chiu@amd.com>, Stefan Agner <stefan@agner.ch>,
 Tian Tao <tiantao6@hisilicon.com>, Tomi Valkeinen <tomba@kernel.org>,
 Xinliang Liu <xinliang.liu@linaro.org>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, Yong Wu <yong.wu@mediatek.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 spice-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Message-ID: <c120e1c4-ac5c-afd5-8dd1-b4b51e0dcca9@suse.de>
Subject: Re: [PATCH 0/3] drm: Allow simpledrm to setup its emulated FB as
 firmware provided
References: <20220502084830.285639-1-javierm@redhat.com>
In-Reply-To: <20220502084830.285639-1-javierm@redhat.com>

--------------JAaQiYXsw1Wg2huPZuTUbFwL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmF2aWVyDQoNCkFtIDAyLjA1LjIyIHVtIDEwOjQ4IHNjaHJpZWIgSmF2aWVyIE1hcnRp
bmV6IENhbmlsbGFzOg0KPiBIZWxsbywNCj4gDQo+IFRoaXMgc2VyaWVzIGNvbnRhaW4gcGF0
Y2hlcyBzdWdnZXN0ZWQgYnkgVGhvbWFzIFppbW1lcm1hbm5hcyBhIGZlZWRiYWNrIGZvcg0K
PiAiW1JGQyBQQVRDSCB2NCAwMC8xMV0gRml4IHNvbWUgcmFjZSBiZXR3ZWVuIHN5c2ZiIGRl
dmljZSByZWdpc3RyYXRpb24gYW5kDQo+IGRyaXZlcnMgcHJvYmUiIFswXS4NCj4gDQo+IFNp
bmNlIG90aGVyIGNoYW5nZXMgaW4gWzBdIHdlcmUgbW9yZSBjb250cm92ZXJzaWFsLCBJIGRl
Y2lkZWQgdG8ganVzdCBzcGxpdA0KPiB0aGlzIHBhcnQgaW4gYSBuZXcgcGF0Y2gtc2V0IGFu
ZCByZXZpc2l0IHRoZSByZXN0IG9mIHRoZSBwYXRjaGVzIGxhdGVyLg0KPiANCj4gUGF0Y2gg
IzEgaXMganVzdCBhIGNsZWFudXAgc2luY2Ugd2hlbiB3b3JraW5nIG9uIHRoaXMgbm90aWNl
ZCB0aGF0IHNvbWUgRFJNDQo+IGRyaXZlcnMgd2VyZSBwYXNzaW5nIGFzIHByZWZlcnJlZCBi
aXRzIHBlciBwaXhlbCB0byBkcm1fZmJkZXZfZ2VuZXJpY19zZXR1cCgpDQo+IHRoZSB2YWx1
ZSB0aGF0IGlzIHRoZSBkZWZhdWx0IGFueXdheXMuDQo+IA0KPiBQYXRjaCAjMiByZW5hbWVz
IHRoZSAncHJlZmVycmVkX2JwcCcgZHJtX2ZiZGV2X2dlbmVyaWNfc2V0dXAoKSBwYXJhbWV0
ZXIgdG8NCj4gJ29wdGlvbnMnLCBhbmQgbWFrZSB0aGlzIGEgbXVsdGkgZmllbGQgcGFyYW1l
dGVyIHNvIHRoYXQgaXQgY2FuIGJlIGV4dGVuZGVkDQo+IGxhdGVyIHRvIHBhc3Mgb3RoZXIg
b3B0aW9ucyBhcyB3ZWxsLg0KPiANCj4gUGF0Y2ggIzMgZmluYWxseSBhZGRzIHRoZSBuZXcg
RFJNX0ZCX0ZXIG9wdGlvbiBhbmQgbWFrZXMgc2ltcGxlZHJtIHRvIHVzZSBpdA0KPiBzbyB0
aGF0IHRoZSByZWdpc3RlcmVkIGZyYW1lYnVmZmVyIGRldmljZSBpcyBhbHNvIG1hcmtlZCBh
cyBmaXJtd2FyZSBwcm92aWRlZC4NCg0KRm9yIHRoZSB3aG9sZSBwYXRjaHNldDoNCg0KUmV2
aWV3ZWQtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KDQpU
aGFua3MgYSBsb3QhDQoNCj4gDQo+IFswXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDIyMDQyOTA4NDI1My4xMDg1OTExLTEtamF2aWVybUByZWRoYXQuY29tLw0KPiANCj4g
DQo+IEphdmllciBNYXJ0aW5leiBDYW5pbGxhcyAoMyk6DQo+ICAgIGRybTogUmVtb3ZlIHN1
cGVyZmx1b3VzIGFyZyB3aGVuIGNhbGxpbmcgdG8gZHJtX2ZiZGV2X2dlbmVyaWNfc2V0dXAo
KQ0KPiAgICBkcm0vZmItaGVscGVyOiBSZW5hbWUgcHJlZmVycmVkX2JwcCBkcm1fZmJkZXZf
Z2VuZXJpY19zZXR1cCgpDQo+ICAgICAgcGFyYW1ldGVyDQo+ICAgIGRybTogQWxsb3cgc2lt
cGxlZHJtIHRvIHNldHVwIGl0cyBlbXVsYXRlZCBGQiBhcyBmaXJtd2FyZSBwcm92aWRlZA0K
PiANCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgICAgICAg
fCAgNiArKystLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hcm0vaGRsY2RfZHJ2LmMgICAgICAg
ICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FybS9tYWxpZHBfZHJ2LmMg
ICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYXNwZWVkL2FzcGVl
ZF9nZnhfZHJ2LmMgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hc3QvYXN0
X2Rydi5jICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL2F0
bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2RjLmMgIHwgIDIgKy0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vZHJtX2Rydi5jICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9kcm1fZmJfaGVscGVyLmMgICAgICAgICAgICAgICB8IDI1ICsrKysrKysrKysr
KysrKystLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vZnNsLWRjdS9mc2xfZGN1X2RybV9kcnYu
YyAgICAgfCAgMiArLQ0KPiAgIC4uLi9ncHUvZHJtL2hpc2lsaWNvbi9oaWJtYy9oaWJtY19k
cm1fZHJ2LmMgICB8ICAyICstDQo+ICAgLi4uL2dwdS9kcm0vaGlzaWxpY29uL2tpcmluL2tp
cmluX2RybV9kcnYuYyAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vaW14L2Rjc3Mv
ZGNzcy1rbXMuYyAgICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9pbXgv
aW14LWRybS1jb3JlLmMgICAgICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJt
L2luZ2VuaWMvaW5nZW5pYy1kcm0tZHJ2LmMgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL2dw
dS9kcm0vbWNkZS9tY2RlX2Rydi5jICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICAgICAgICB8ICAyICstDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL21lc29uL21lc29uX2Rydi5jICAgICAgICAgICAgIHwgIDIgKy0N
Cj4gICBkcml2ZXJzL2dwdS9kcm0vbXhzZmIvbXhzZmJfZHJ2LmMgICAgICAgICAgICAgfCAg
MiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9wbDExMS9wbDExMV9kcnYuYyAgICAgICAgICAg
ICB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfZHJ2LmMgICAgICAgICAg
ICAgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vcmNhci1kdS9yY2FyX2R1X2Ry
di5jICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zdGkvc3RpX2Rydi5j
ICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL3N0bS9kcnYu
YyAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vc3Vu
NGkvc3VuNGlfZHJ2LmMgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS90aWRzcy90aWRzc19kcnYuYyAgICAgICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9n
cHUvZHJtL3RpbGNkYy90aWxjZGNfZHJ2LmMgICAgICAgICAgIHwgIDIgKy0NCj4gICBkcml2
ZXJzL2dwdS9kcm0vdGlueS9hcmNwZ3UuYyAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS90aW55L2JvY2hzLmMgICAgICAgICAgICAgICAgICB8ICAyICst
DQo+ICAgZHJpdmVycy9ncHUvZHJtL3RpbnkvY2lycnVzLmMgICAgICAgICAgICAgICAgIHwg
IDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uYyAgICAgICAgICAg
ICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS90dmUyMDAvdHZlMjAwX2Rydi5jICAg
ICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL3Zib3h2aWRlby92Ym94X2Ry
di5jICAgICAgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vdmM0L3ZjNF9kcnYu
YyAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8v
dmlydGdwdV9kcnYuYyAgICAgICAgICB8ICAyICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL3hs
bngvenlucW1wX2Rwc3ViLmMgICAgICAgICAgIHwgIDIgKy0NCj4gICBpbmNsdWRlL2RybS9k
cm1fZmJfaGVscGVyLmggICAgICAgICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysr
DQo+ICAgMzYgZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgMzkgZGVsZXRpb25z
KC0pDQo+IA0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2
ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCk1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgwOSwgQUcgTsO8cm5i
ZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------JAaQiYXsw1Wg2huPZuTUbFwL--

--------------bZs9O7gVydbPyh0mFowmyKkQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmJvs/EFAwAAAAAACgkQlh/E3EQov+Bv
yxAAyojQIwyTt0AkQrH8ujHQ2z3VZLLTBfvwuS0Xf7dxJnvpnddrmMLeQjx/dJgIsu5Kpoq+cC89
JF4cEgYrs1G9WTVDlxCJ6aMAA8EV3lRH6ECyFZrbc8MNiebvArPucqStj6VQiaLNYDS/TMGBTBdO
/rxHsubsTAALLJkWsuEoSJMATSrWyqdxzVwj0DUmMZCc2p3zF7+PakvAE8OHpzNOQYg++vORApLq
4qHowqHrVSPpbACr+XhYpOMuzo4dWJDx98HuVrzXDNOBtcll5tTGTOuJv2tJw+aotRhGuV71ALNd
yKPP2+GV+kCwNOVcr8OEnfCQa26DsIzooE2SlHwcnIRksqxoKiheTT9YCL+LA7cY0K+h2ybmjqaS
awZ5pzqRq9egCdFc1KGCctvRxm+BVVnXHGJ4nsGtQp8Z34tClsjquHGR1BFfNw1NEG/jOh7iFY/j
kvo5qlUcKW28ooufV/c7fZ/u0M++S9nJSgAO3XnXwG2DhZ0FtKz95EsfKAQZLY/fFv/m05mdr/KZ
OIZ/OcBWfPLwNcR9MVHSArO1VYFUqQSsi8IJUhYZKKhpYmAXrF/h0YeUOLlLRvfB4OtuuOyZQ+zt
Y2UtHrTmNm7pHfj2IOCPJDvnLfbMUsQQvYxpBWIF5lslFkzCrnECTSy/8Ue36oRlan7yclndRQvm
h0A=
=gWxx
-----END PGP SIGNATURE-----

--------------bZs9O7gVydbPyh0mFowmyKkQ--
