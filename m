Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6624554C9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348032AbiFON3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348446AbiFON2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:28:33 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308952F02D;
        Wed, 15 Jun 2022 06:28:32 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F25FC1C0BC8; Wed, 15 Jun 2022 15:28:30 +0200 (CEST)
Date:   Wed, 15 Jun 2022 15:28:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>, Ondrej Jirman <x@xff.cz>,
        Martijn Braam <martijn@brixit.nl>,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add initial support for Pine64
 PinePhone Pro
Message-ID: <20220615132827.GB1429@bug>
References: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
 <20220529031705.278631-3-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529031705.278631-3-tom@tom-fitzhenry.me.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +	// Per "RK 3399 SARADC", page 8.
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 1>;
> +		io-channel-names = "buttons";
> +		keyup-threshold-microvolt = <1600000>;
> +		poll-interval = <100>;
> +
> +		button-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			press-threshold-microvolt = <100000>;
> +		};
> +
> +		button-down {
> +			label = "Volume Down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			press-threshold-microvolt = <300000>;
> +		};
> +	};

Wow. Quite a hack...


> +	// Per "RK3399 GPIO", page 11.
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&red_led_pin &green_led_pin &blue_led_pin>;


> + led-standby { + color = <LED_COLOR_ID_RED>; + default-state = "off"; + function = 

I wish LED was connected to PWM, not to simple GPIO...

Plus, it is really one RGB LED, right? It should be handled as such.

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
