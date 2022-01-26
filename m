Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5970249C6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiAZJ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiAZJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:59:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75081C061744
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:59:04 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nCf4s-0000R5-C2; Wed, 26 Jan 2022 10:58:58 +0100
Message-ID: <d5a15039255d13cf4321bf1c18f49a9cdb666607.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mn-venice-gw7902: disable gpu
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>, Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adam Ford <aford173@gmail.com>
Date:   Wed, 26 Jan 2022 10:58:56 +0100
In-Reply-To: <20220126093558.GL4686@dragon>
References: <20211216161227.31960-1-tharvey@gateworks.com>
         <20220126093558.GL4686@dragon>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 26.01.2022 um 17:35 +0800 schrieb Shawn Guo:
> On Thu, Dec 16, 2021 at 08:12:27AM -0800, Tim Harvey wrote:
> > Since commit 99aa29932271 ("arm64: dts: imx8mn: Enable GPU")
> > imx8mn-venice-gw7902 will hang during kernel init because it uses
> > a MIMX8MN5CVTI which does not have a GPU.
> 
> I do not quite follow on this.  i.MX8MN integrates a GPU, and
> MIMX8MN5CVTI is built on i.MX8MN, correct?  If so, how comes
> MIMX8MN5CVTI doesn't have a GPU?
> 
It's a fused-down variant of the i.MX8MN that has the GPU disabled by
fuses.

> > 
> > Disable pgc_gpumix to work around this. We also disable the GPU devices
> > that depend on the gpumix power domain and pgc_gpu to avoid them staying
> > in a probe deferred state forever.
> 
> Is this an indication that GPU should be disabled in imx8mn.dtsi and
> enabled board by board?
> 
There's a trade-off here: most boards will probably use the full
variants that include the GPU, so probably less boards will need to
disable the GPU, as done here, than boards that need to enable it when
the base DT disables the GPU.

Same story as with the i.MX6 where there are some SKUs that disable the
VPU by fuses: we enable it in the base DT and if you happen to build a
very low-cost board that uses the fused-down version you need to
disable it in the board DT.

Regards,
Lucas

> Shawn
> 
> > 
> > Cc: Adam Ford <aford173@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  .../boot/dts/freescale/imx8mn-venice-gw7902.dts      | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > index 236f425e1570..2d58005d20e4 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
> > @@ -220,6 +220,10 @@
> >  	};
> >  };
> >  
> > +&disp_blk_ctrl {
> > +	status = "disabled";
> > +};
> > +
> >  /* off-board header */
> >  &ecspi2 {
> >  	pinctrl-names = "default";
> > @@ -251,6 +255,10 @@
> >  	};
> >  };
> >  
> > +&gpu {
> > +	status = "disabled";
> > +};
> > +
> >  &i2c1 {
> >  	clock-frequency = <100000>;
> >  	pinctrl-names = "default";
> > @@ -546,6 +554,10 @@
> >  	status = "okay";
> >  };
> >  
> > +&pgc_gpumix {
> > +	status = "disabled";
> > +};
> > +
> >  /* off-board header */
> >  &sai3 {
> >  	pinctrl-names = "default";
> > -- 
> > 2.17.1
> > 


