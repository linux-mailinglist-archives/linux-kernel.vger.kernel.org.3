Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7857F4A56E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiBAF1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiBAF07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:26:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB9AC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:26:58 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nElgr-0006gu-WF; Tue, 01 Feb 2022 06:26:54 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nElgo-00085c-RL; Tue, 01 Feb 2022 06:26:50 +0100
Date:   Tue, 1 Feb 2022 06:26:50 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        Robin van der Gracht <robin@protonic.nl>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Jander <david@protonic.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] ARM: dts: imx6dl: plym2m, prtvt7, victgo: make
 use of new resistive-adc-touch driver
Message-ID: <20220201052650.GA29389@pengutronix.de>
References: <20220131102841.1955032-1-o.rempel@pengutronix.de>
 <20220131102841.1955032-5-o.rempel@pengutronix.de>
 <YfgDToubMLxZsy34@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfgDToubMLxZsy34@ravnborg.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:19:47 up 52 days, 14:05, 47 users,  load average: 0.17, 0.16,
 0.12
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Mon, Jan 31, 2022 at 04:42:06PM +0100, Sam Ravnborg wrote:
> On Mon, Jan 31, 2022 at 11:28:40AM +0100, Oleksij Rempel wrote:
> > The tsc2046 is an ADC used as touchscreen controller. To share as mach
>                                                                     much
> > code as possible, we should use it as actual ADC + virtual touchscreen
> > controller.
> > With this patch we make use of the new kernel IIO and HID infrastructure.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6dl-plym2m.dts | 59 +++++++++++++++++++++--------
> >  arch/arm/boot/dts/imx6dl-prtvt7.dts | 57 +++++++++++++++++++++-------
> >  arch/arm/boot/dts/imx6dl-victgo.dts | 59 ++++++++++++++++++++++-------
> >  3 files changed, 132 insertions(+), 43 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/imx6dl-plym2m.dts
> > index 60fe5f14666e..73c7622bfe0f 100644
> > --- a/arch/arm/boot/dts/imx6dl-plym2m.dts
> > +++ b/arch/arm/boot/dts/imx6dl-plym2m.dts
> > @@ -101,6 +101,18 @@ reg_12v0: regulator-12v0 {
> >  		regulator-min-microvolt = <12000000>;
> >  		regulator-max-microvolt = <12000000>;
> >  	};
> > +
> > +	touchscreen {
> > +		compatible = "resistive-adc-touch";
> > +		io-channels = <&adc_ts 1>, <&adc_ts 3>, <&adc_ts 4>,
> > +                              <&adc_ts 5>;
> > +		io-channel-names = "y", "z1", "z2", "x";
> > +		touchscreen-min-pressure = <64687>;
> > +		touchscreen-inverted-x;
> > +		touchscreen-inverted-y;
> > +		touchscreen-x-plate-ohms = <300>;
> > +		touchscreen-y-plate-ohms = <800>;
> > +	};
> >  };
> >  
> >  &can1 {
> > @@ -129,26 +141,41 @@ &ecspi2 {
> >  	pinctrl-0 = <&pinctrl_ecspi2>;
> >  	status = "okay";
> >  
> > -	touchscreen@0 {
> > -		compatible = "ti,tsc2046";
> > +	adc_ts: adc@0 {
> > +		compatible = "ti,tsc2046e-adc";
> >  		reg = <0>;
> >  		pinctrl-0 = <&pinctrl_tsc2046>;
> >  		pinctrl-names ="default";
> > -		spi-max-frequency = <100000>;
> > -		interrupts-extended = <&gpio3 20 IRQ_TYPE_EDGE_FALLING>;
> > -		pendown-gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
> > +		spi-max-frequency = <1000000>;
> > +		interrupts-extended = <&gpio3 20 IRQ_TYPE_LEVEL_LOW>;
> > +		#io-channel-cells = <1>;
> 
> I quickly skimmed the patch - we seem to loose the pendown-gpio in most
> of the patches - I do not see it replaced.

pendown-gpio is not used by the new driver. It is replace by the IIO
trigger. Please see this comment:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/adc/ti-tsc2046.c?h=testing#n521

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
