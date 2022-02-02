Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2494F4A6ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245739AbiBBKfA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Feb 2022 05:35:00 -0500
Received: from aposti.net ([89.234.176.197]:47018 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbiBBKe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:34:59 -0500
Date:   Wed, 02 Feb 2022 10:34:39 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v12 8/9] MIPS: DTS: CI20: fix how ddc power is enabled
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
        dri-devel@lists.freedesktop.org
Message-Id: <RPAO6R.YM0J1CDEYDMG@crapouillou.net>
In-Reply-To: <5a46a4784de0d2ecda16a4923037a3027dc00a45.1643632014.git.hns@goldelico.com>
References: <cover.1643632014.git.hns@goldelico.com>
        <5a46a4784de0d2ecda16a4923037a3027dc00a45.1643632014.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun., janv. 31 2022 at 13:26:54 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> Originally we proposed a new hdmi-5v-supply regulator reference
> for CI20 device tree but that was superseded by a better idea to use
> the already defined "ddc-en-gpios" property of the "hdmi-connector".
> 
> Since "MIPS: DTS: CI20: Add DT nodes for HDMI setup" has already
> been applied to v5.17-rc1, we add this on top.
> 
> Fixes: ae1b8d2c2de9 ("MIPS: DTS: CI20: Add DT nodes for HDMI setup")
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  arch/mips/boot/dts/ingenic/ci20.dts | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts 
> b/arch/mips/boot/dts/ingenic/ci20.dts
> index 3e336b3dbb109..ab6e3dc0bc1d0 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -83,6 +83,8 @@ hdmi_out: connector {
>  		label = "HDMI OUT";
>  		type = "a";
> 
> +		ddc-en-gpios = <&gpa 25 GPIO_ACTIVE_HIGH>;
> +
>  		port {
>  			hdmi_con: endpoint {
>  				remote-endpoint = <&dw_hdmi_out>;
> @@ -114,17 +116,6 @@ otg_power: fixedregulator@2 {
>  		gpio = <&gpf 14 GPIO_ACTIVE_LOW>;
>  		enable-active-high;
>  	};
> -
> -	hdmi_power: fixedregulator@3 {
> -		compatible = "regulator-fixed";
> -
> -		regulator-name = "hdmi_power";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -
> -		gpio = <&gpa 25 0>;
> -		enable-active-high;
> -	};
>  };
> 
>  &ext {
> @@ -576,8 +567,6 @@ &hdmi {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pins_hdmi_ddc>;
> 
> -	hdmi-5v-supply = <&hdmi_power>;
> -
>  	ports {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> --
> 2.33.0
> 


