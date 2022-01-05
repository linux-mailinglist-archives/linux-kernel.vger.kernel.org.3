Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F65485195
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiAELEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiAELEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:04:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAA2C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 03:04:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n545t-0008W1-8N; Wed, 05 Jan 2022 12:04:37 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n545q-0004qQ-DW; Wed, 05 Jan 2022 12:04:34 +0100
Date:   Wed, 5 Jan 2022 12:04:34 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 4/4] ARM: dts: imx6dl: plym2m, prtvt7, victgo:  make
 use of new resistive-adc-touch driver
Message-ID: <20220105110434.GG303@pengutronix.de>
References: <20211122124310.2796505-1-o.rempel@pengutronix.de>
 <20211122124310.2796505-4-o.rempel@pengutronix.de>
 <20211206010627.GK4216@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211206010627.GK4216@dragon>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:58:52 up 25 days, 19:44, 81 users,  load average: 1.02, 1.06,
 1.07
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

sorry for the delay, I just came back to work.

On Mon, Dec 06, 2021 at 09:06:28AM +0800, Shawn Guo wrote:
> On Mon, Nov 22, 2021 at 01:43:10PM +0100, Oleksij Rempel wrote:
> > The tsc2046 is an ADC used as touchscreen controller. To share as mach
> > code as possible, we should use it as actual ADC + virtual tochscreen
> > controller.
> > With this patch we make use of the new kernel IIO and HID infrastructure.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> One space is enough in subject "victgo:  make".

done.

> > ---
> >  arch/arm/boot/dts/imx6dl-plym2m.dts | 55 ++++++++++++++++++++---------
> >  arch/arm/boot/dts/imx6dl-prtvt7.dts | 53 ++++++++++++++++++++-------
> >  arch/arm/boot/dts/imx6dl-victgo.dts | 55 +++++++++++++++++++++--------
> >  3 files changed, 120 insertions(+), 43 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/imx6dl-plym2m.dts
> > index 60fe5f14666e..e2afedae85cb 100644
> > --- a/arch/arm/boot/dts/imx6dl-plym2m.dts
> > +++ b/arch/arm/boot/dts/imx6dl-plym2m.dts
> > @@ -101,6 +101,17 @@ reg_12v0: regulator-12v0 {
> >  		regulator-min-microvolt = <12000000>;
> >  		regulator-max-microvolt = <12000000>;
> >  	};
> > +
> > +	touchscreen {
> > +		compatible = "resistive-adc-touch";
> > +		io-channels = <&adc 1>, <&adc 3>, <&adc 4>, <&adc 5>;
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
> > @@ -129,26 +140,38 @@ &ecspi2 {
> >  	pinctrl-0 = <&pinctrl_ecspi2>;
> >  	status = "okay";
> >  
> > -	touchscreen@0 {
> > -		compatible = "ti,tsc2046";
> > +	adc: adc@0 {
> 
> Isn't label name "adc" too generic?

I do not have strong opinion about this. Currently we have no
restrictions for the node names:
Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
Documentation/devicetree/bindings/iio/adc/adc.yaml

I can name it touchscreen-adc@0 or something like this. What are your
preferences?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
