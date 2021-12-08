Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD746D111
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhLHKgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhLHKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:36:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3FCC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 02:32:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1muuFc-0003cK-1S; Wed, 08 Dec 2021 11:32:40 +0100
Message-ID: <5a8b84e91bd8e7670a0d0108e4affe9b964202cb.camel@pengutronix.de>
Subject: Re: [RFC V2 0/6] media: Hantro: Split iMX8MQ VPU into G1 and G2
 with blk-ctrl support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
Cc:     cphealy@gmail.com, hverkuil@xs4all.nl,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Date:   Wed, 08 Dec 2021 11:32:36 +0100
In-Reply-To: <f85da774-ccb3-85de-edd6-5333ed8d0503@collabora.com>
References: <20211207015446.1250854-1-aford173@gmail.com>
         <f85da774-ccb3-85de-edd6-5333ed8d0503@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 08.12.2021 um 10:32 +0100 schrieb Benjamin Gaignard:
> Le 07/12/2021 à 02:54, Adam Ford a écrit :
> 
> > Currently, the VPU in the i.MQ8MQ is appearing as one codec, but in
> > reality, it's two IP blocks called G1 and G2.  There is initialization
> > code in VPU code to pull some clocks, resets and other features which
> > has been integrated into the vpu-blk-ctrl for the i.MX8M Mini and a
> > similar method can be used to make the VPU codec's operate as
> > stand-alone cores without having to know the details of each other
> > or the quirks unique to the i.MX8MQ, so the remaining code can be
> > left more generic.
> > 
> > This series was started by Lucas Stach with one by Benjamin Gaignard.
> > Most patches have been modified slightly by me.  It's in an RFC state
> > because I wasn't sure how to best handle the signatures and wasn't sure
> > if I could base it off the branch I did.
> > 
> > Since the g-streamer and media trees are in a constant state of
> > change, this series is based on
> > 
> > git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
> > 
> > The downstream code from NXP shows the G1 and G2 clocks running
> > at 600MHz, but between the TRM and the datasheet, there is some
> > discrepancy.  Because the NXP reference code used 600MHz, that is
> > what was chosen here.  Users who need to adjust their G1 and G2
> > clocks can do so in their board files.
> 
> Hi Adam,
> 
> Thanks for your patches, I have been able to reproduce VP9 results on my side (Fluster 147/303).
> In past I have notice spurious errors when using 600MHz clock on HEVC decode but not with 300MHz.

The max supported G2 clock frequency is 660MHz but needs a higher
voltage. The maximum supported  frequency at the default 0.9V is
550MHz. We should not configure the clocks for the higher than that, as
long as there is no support in the VPU driver to scale the voltage
along with the frequency. Same as with the GPU we should stick to base
frequency levels for the nominal operating mode.

Regards,
Lucas

> 
> Regards,
> Benjamin
> 
> > 
> > Fluster Results:
> > 
> > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > Ran 90/135 tests successfully               in 61.966 secs
> > 
> > ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > Ran 55/61 tests successfully               in 7.660 secs
> > 
> > 
> > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > Ran 144/303 tests successfully               in 162.665 secs
> > 
> > Changes log:
> > 
> > V2:  Make vpu-blk-ctrl enable G2 clock when enabling fuses.
> >       Remove syscon from device tree and binding example
> >       Added modified nxp,imx8mq-vpu.yaml from Benjamin Gaignard
> > 
> > Adam Ford (2):
> >    media: hantro: split i.MX8MQ G1 and G2 code
> >    arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl
> > 
> > Benjamin Gaignard (1):
> >    dt-bindings: media: nxp,imx8mq-vpu: Update the bindings for G2 support
> > 
> > Lucas Stach (3):
> >    dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
> >    dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
> >    soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
> > 
> >   .../bindings/media/nxp,imx8mq-vpu.yaml        |  58 +++++----
> >   .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      |  71 +++++++++++
> >   arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  69 ++++++----
> >   drivers/soc/imx/imx8m-blk-ctrl.c              |  68 +++++++++-
> >   drivers/staging/media/hantro/hantro_drv.c     |   4 +-
> >   drivers/staging/media/hantro/hantro_hw.h      |   2 +-
> >   drivers/staging/media/hantro/imx8m_vpu_hw.c   | 119 +++---------------
> >   include/dt-bindings/power/imx8mq-power.h      |   3 +
> >   8 files changed, 237 insertions(+), 157 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
> > 
> > 
> > base-commit: d1888b0bfd2ddef2e8a81505ffa200b92cc32e0c


