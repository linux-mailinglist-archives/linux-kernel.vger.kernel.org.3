Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079CC4673CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379493AbhLCJVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379483AbhLCJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:21:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9BAC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 01:17:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mt4hE-0000j9-TQ; Fri, 03 Dec 2021 10:17:36 +0100
Message-ID: <6a274996f96c799db2efef4498a8fc42e78e1d2d.camel@pengutronix.de>
Subject: Re: [RFC V3 0/2] arm64: imx8mm: Enable Hantro VPUs
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Tim Harvey <tharvey@gateworks.com>, Adam Ford <aford173@gmail.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Date:   Fri, 03 Dec 2021 10:17:33 +0100
In-Reply-To: <CAJ+vNU2t7Yp5OGtWj432Y-8hL62nQBbG58zM-gAj5YfuCO__sA@mail.gmail.com>
References: <20211202041627.291625-1-aford173@gmail.com>
         <CAHCN7xJHuOFTQBQWk1yKsk3M0iDB7aKc0=L2DisUoSXVeO3xXQ@mail.gmail.com>
         <CAJ+vNU2t7Yp5OGtWj432Y-8hL62nQBbG58zM-gAj5YfuCO__sA@mail.gmail.com>
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

Am Donnerstag, dem 02.12.2021 um 10:54 -0800 schrieb Tim Harvey:
> On Thu, Dec 2, 2021 at 4:29 AM Adam Ford <aford173@gmail.com> wrote:
> > 
> > On Wed, Dec 1, 2021 at 10:17 PM Adam Ford <aford173@gmail.com> wrote:
> > > 
> > > The i.MX8M has two Hantro video decoders, called G1 and G2 which appear
> > > to be related to the video decoders used on the i.MX8MQ, but because of
> > > how the Mini handles the power domains, the VPU driver does not need to
> > > handle all the functions, so a new compatible flag is required.
> > > 
> > > V3 is rebased from git://linuxtv.org/hverkuil/media_tree.git for-v5.17c
> > > This branch has support for VP9.
> > > 
> > > I set cma=512M, but this may not be enough memory as some tests appeard to run out of memory
> > > 
> > > V3 of this series has several changes:
> > > 
> > > Update imx8m_vpu_hw to add missing 'reg' reference names for G2 and include references to VP9
> > > Update device tree to remove IMX8MQ_VPU_RESET, remove some duplicate vpu clock parenting
> > > Fix missing reg-names from vpu_g2 node.
> > > Apply patch [1] to manage the power domains powering down.
> > > [1] - https://lore.kernel.org/linux-arm-kernel/20211016210547.171717-1-marex@denx.de/t/
> > > 
> > > With the above, the following Fluster scores are produced:
> > > 
> > > G1:
> > > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > > Ran 90/135 tests successfully               in 74.406 secs
> > > 
> > > ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > > Ran 55/61 tests successfully               in 8.080 secs
> > > 
> > > G2:
> > > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > > Ran 127/303 tests successfully               in 203.873 secs
> > > 
> > > Fluster and G-Streamer were both built from their respective git repos using their respective master/main branches.
> > > 
> > 
> > I should note, that both interrupts appear to be triggering.
> > 
> > # cat /proc/interrupts |grep codec
> >  57:      13442          0          0          0     GICv3  39 Level
> >   38300000.video-codec
> >  58:       7815          0          0          0     GICv3  40 Level
> >   38310000.video-codec
> > 
> 
> Adam,
> 
> On another thread you had let me know that you also removed the reset
> from the pgc_vpumix power domain which does appear to resolve the
> hang:
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index eb9dcd9d1a31..31710af544dc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -681,7 +681,6 @@
>                                                 clocks = <&clk
> IMX8MM_CLK_VPU_DEC_ROOT>;
>                                                 assigned-clocks =
> <&clk IMX8MM_CLK_VPU_BUS>;
>                                                 assigned-clock-parents
> = <&clk IMX8MM_SYS_PLL1_800M>;
> -                                               resets = <&src
> IMX8MQ_RESET_VPU_RESET>;
>                                         };
> 
>                                         pgc_vpu_g1: power-domain@7 {
> 
> That would make such a patch have a 'Fixes commit d39d4bb15310
> ("arm64: dts: imx8mm: add GPC node")' but of course that vpu domain
> isn't active until your series so I'm not sure if we should send this
> separate or squash it with "arm64: dts: imx8mm: Enable VPU-G1 and
> VPU-G2". I'm also not clear if removing the reset requires some
> further discussion with Lucas.
> 
I'm fine with removing the reset when it fixes things. In normal
operation the reset should already be triggered by the GPC itself via a
hardware mechanism. We know that this doesn't work for the GPU reset on
the i.MX8MM, so we have the ability for the driver to handle it by
poking the SRC explicitly.

Adding the reset to the VPU DT description wasn't done because I know
that we need it, but more of a "I know that things are broken with the
GPU domain, so better be safe than sorry with the VPU domain". My line
of thought clearly was that it may not be needed, but it may prevent
some issues in the long run. If it is _causing_ issues however, there
is no need to discuss anything, just get rid of it.

Regards,
Lucas

