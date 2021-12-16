Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF27247751D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhLPO6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhLPO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:58:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132DFC061574;
        Thu, 16 Dec 2021 06:58:45 -0800 (PST)
Received: from [IPv6:2a01:e0a:120:3210:647b:8ae3:3908:58d6] (unknown [IPv6:2a01:e0a:120:3210:647b:8ae3:3908:58d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DD3061F463F9;
        Thu, 16 Dec 2021 14:58:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639666723; bh=BTdDikXpF4XSx021w9PRTEKVLDa7Vof8nDF6T89RUCg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PbS5VrVK3UMCLMI7wxt0g+wotYuMxgcYrjS7sJj2+Y6QdsAoGvx9o383Sz85bwlQA
         x5vLKVKL3t3bBPOgBztuJnop3EWS6MgZ4E0tBMDD2gwDRTy8ktMOQlf2EXnroX83dY
         rATCENy9mcDZTSuI1DmqRjCIKwHRiOvD4MYoP2kKl+W7f7r61S1JY5mM5tVC59FpTD
         7ePBuhvMzOsDopFmYhdcQXdFyJohMPBjtyuu/pFHpP3KA5LUBALqftc7zJhIRm5ZlK
         9bWyz/4Ncmx35NqEtMjkuLz81NP05g25WtdsL+CMsBnyX90iTP2T6jymNMV8W/T/M3
         i3k3OJ6nAqGjw==
Subject: Re: [PATCH V2 00/10] media: hantro: imx8mq/imx8mm: Let VPU decoders
 get controlled by vpu-blk-ctrl
To:     Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
Cc:     abel.vesa@nxp.com, aford@beaconembedded.com,
        hverkuil-cisco@xs4all.nl,
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
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20211216111256.2362683-1-aford173@gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <32791d1e-c81e-ea11-c7a6-e8cbebe49a5e@collabora.com>
Date:   Thu, 16 Dec 2021 15:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216111256.2362683-1-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 16/12/2021 à 12:12, Adam Ford a écrit :
> Both the i.MX8MQ and i.MX8MM have G1 and G2 decoders.
> The two decoders are similar, but the imx8mm lacks the
> post-processor, so they will have distinct compatible flags.
>
>  From what I can tell, the G2 decoder wasn't working, so splitting
> the i.MX8MQ VPU into G1 and G2 makes it easier to control them
> independently since the TRM of both the i.MX8MQ and
> i.MX8MM list them as distinct IP blocks. This also allowed G2 to
> become available.
>
> With them being split, the power-domain can shift to the
> vpu-blk-ctrl which is available on both i.MX8MQ and i.MX8MM,
> but some of bits are different, so they'll have separate bindings.
>
> Lastly, with the G1 and G2 operational, enable the i.MX8MM.
> On the i.MX8MM, the clock speed of 600MHz was chosen to match
> the default of the kernel repo from NXP and can be overwritten
> by board files for anyone who under/over volts the power rail.
>
> There seems to be some disagreement between the TRM and the Datasheet
> for the imx8mq as to whether the speed should be 300MHz (TRM) or
> 600MHz (datasheet), so feedback from NXP would be very much
> appreciated.
>
> The repo used as the starting point was:
> git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
>
> Fluster was run on both i.MX8MM and i.MX8MQ
>
> At 600 MHz, the i.MX8MM had the following:
>
> ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> Ran 55/61 tests successfully               in 8.299 secs
>
> ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> Ran 90/135 tests successfully               in 71.200 secs
>
> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> Ran 139/303 tests successfully               in 218.079 secs
>
> The i.MX8MQ had the following:
>
> ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> Ran 55/61 tests successfully               in 7.732 secs
>
> ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> Ran 90/135 tests successfully               in 58.558 secs
>
> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> Ran 144/303 tests successfully               in 271.373 secs

I have tested this series on top of media_stage/master branch
with IMX6MQ:

./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
Ran 57/61 tests successfully               in 32.725 secs

./fluster.py run -d GStreamer-H.264-V4L2SL-Gst1.0
Ran 89/135 tests successfully               in 131.632 secs

./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
Ran 146/303 tests successfully               in 304.345 secs

./fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -j 1
Ran 77/147 tests successfully               in 1047.211 secs

For this series:

Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Thanks to fix this problem.
Benjamin

>
> V2:  Remove references to legacy dt-binding from YAML, but keep
>       it in the driver so older device trees can still be used.
>       Fix typos in YAML
>       Remove reg-names, interrupt-names, and clock-names from YAML,
>       since each node will only have one of each, they're not necessary
>       Add Fluster scores to cover letter for i.MX8MQ
>
> Adam Ford (7):
>    dt-bindings: media: nxp,imx8mq-vpu: Split G1 and G2 nodes
>    media: hantro: Allow i.MX8MQ G1 and G2 to run independently
>    arm64: dts: imx8mq: Enable both G1 and G2 VPU's with vpu-blk-ctrl
>    arm64: dts: imx8mm: Fix VPU Hanging
>    dt-bindings: media: nxp,imx8mq-vpu: Add support for G1 and G2 on
>      imx8mm
>    media: hantro: Add support for i.MX8MM
>    arm64: dts: imx8mm: Enable Hantro G1 and G2 video decoders
>
> Lucas Stach (3):
>    dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
>    dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
>    soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
>
>   .../bindings/media/nxp,imx8mq-vpu.yaml        | 93 +++++++++++--------
>   .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      | 71 ++++++++++++++
>   arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 23 ++++-
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 63 ++++++++-----
>   drivers/soc/imx/imx8m-blk-ctrl.c              | 68 +++++++++++++-
>   drivers/staging/media/hantro/hantro_drv.c     |  3 +
>   drivers/staging/media/hantro/hantro_hw.h      |  3 +
>   drivers/staging/media/hantro/imx8m_vpu_hw.c   | 75 ++++++++++++---
>   include/dt-bindings/power/imx8mq-power.h      |  3 +
>   9 files changed, 324 insertions(+), 78 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
>
>
> base-commit: d1888b0bfd2ddef2e8a81505ffa200b92cc32e0c
