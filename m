Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC84B35C0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 15:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiBLO6i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Feb 2022 09:58:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiBLO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:58:36 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ECF214;
        Sat, 12 Feb 2022 06:58:32 -0800 (PST)
Date:   Sat, 12 Feb 2022 14:58:12 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v14 8/9] [already applied to mips-fixes] MIPS: DTS: CI20:
 fix how ddc power is enabled
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
Message-Id: <0L577R.CVAM5NCZN3F72@crapouillou.net>
In-Reply-To: <6722afd4a89d2bf0d95e49e6738ff50bf9f26245.1644675567.git.hns@goldelico.com>
References: <cover.1644675566.git.hns@goldelico.com>
        <6722afd4a89d2bf0d95e49e6738ff50bf9f26245.1644675567.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le sam., févr. 12 2022 at 15:19:26 +0100, H. Nikolaus Schaller 
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
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Since it's already applied you don't have to send this patch anymore.

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


