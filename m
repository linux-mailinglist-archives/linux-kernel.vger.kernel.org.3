Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895EB46D026
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhLHJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLHJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:36:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74184C0617A1;
        Wed,  8 Dec 2021 01:33:00 -0800 (PST)
Received: from [IPv6:2a01:e0a:120:3210:9928:73b0:79a4:e623] (unknown [IPv6:2a01:e0a:120:3210:9928:73b0:79a4:e623])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 39CCF1F45A1D;
        Wed,  8 Dec 2021 09:32:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638955978; bh=qdoGNUS0B38g/vQl8OYWvSbXd37jJA7vB7+2VrQDEBo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nJ8VNPLOSjOYZBedj0grLrp18tc5OnjuKMsPV07CFaOr4tQuywGpklRmMhlMXjMJe
         kpthjLYUO6CMUJGV5jxCi1qX9YhRPVDNIs2zAL0QmV2eh8j7imKbYNpQFLRSFa1VuS
         G+8lxXDTfyUi1KlHQh9LQkMCg1DlXLkZP/ngthXFt2cC6QStIBGAIEBrSEm6J4zIL0
         EXorkYrmiitvE9lQLwyTxnHXSMk2PrUsdEimtUT46tb0ualBFzLQmGcYCz5GGO5tBL
         t1wIc1nA2WdnH1QCeaaXG/9IyrMeIaXf5B4KzrRehwz20bE4HRzXh3dRZ7cLvCin3Y
         /+txpI5hwgjvQ==
Subject: Re: [RFC V2 0/6] media: Hantro: Split iMX8MQ VPU into G1 and G2 with
 blk-ctrl support
To:     Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
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
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20211207015446.1250854-1-aford173@gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <f85da774-ccb3-85de-edd6-5333ed8d0503@collabora.com>
Date:   Wed, 8 Dec 2021 10:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211207015446.1250854-1-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 07/12/2021 à 02:54, Adam Ford a écrit :

> Currently, the VPU in the i.MQ8MQ is appearing as one codec, but in
> reality, it's two IP blocks called G1 and G2.  There is initialization
> code in VPU code to pull some clocks, resets and other features which
> has been integrated into the vpu-blk-ctrl for the i.MX8M Mini and a
> similar method can be used to make the VPU codec's operate as
> stand-alone cores without having to know the details of each other
> or the quirks unique to the i.MX8MQ, so the remaining code can be
> left more generic.
>
> This series was started by Lucas Stach with one by Benjamin Gaignard.
> Most patches have been modified slightly by me.  It's in an RFC state
> because I wasn't sure how to best handle the signatures and wasn't sure
> if I could base it off the branch I did.
>
> Since the g-streamer and media trees are in a constant state of
> change, this series is based on
>
> git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
>
> The downstream code from NXP shows the G1 and G2 clocks running
> at 600MHz, but between the TRM and the datasheet, there is some
> discrepancy.  Because the NXP reference code used 600MHz, that is
> what was chosen here.  Users who need to adjust their G1 and G2
> clocks can do so in their board files.

Hi Adam,

Thanks for your patches, I have been able to reproduce VP9 results on my side (Fluster 147/303).
In past I have notice spurious errors when using 600MHz clock on HEVC decode but not with 300MHz.

Regards,
Benjamin

>
> Fluster Results:
>
> ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> Ran 90/135 tests successfully               in 61.966 secs
>
> ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> Ran 55/61 tests successfully               in 7.660 secs
>
>
> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> Ran 144/303 tests successfully               in 162.665 secs
>
> Changes log:
>
> V2:  Make vpu-blk-ctrl enable G2 clock when enabling fuses.
>       Remove syscon from device tree and binding example
>       Added modified nxp,imx8mq-vpu.yaml from Benjamin Gaignard
>
> Adam Ford (2):
>    media: hantro: split i.MX8MQ G1 and G2 code
>    arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl
>
> Benjamin Gaignard (1):
>    dt-bindings: media: nxp,imx8mq-vpu: Update the bindings for G2 support
>
> Lucas Stach (3):
>    dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
>    dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
>    soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
>
>   .../bindings/media/nxp,imx8mq-vpu.yaml        |  58 +++++----
>   .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      |  71 +++++++++++
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  69 ++++++----
>   drivers/soc/imx/imx8m-blk-ctrl.c              |  68 +++++++++-
>   drivers/staging/media/hantro/hantro_drv.c     |   4 +-
>   drivers/staging/media/hantro/hantro_hw.h      |   2 +-
>   drivers/staging/media/hantro/imx8m_vpu_hw.c   | 119 +++---------------
>   include/dt-bindings/power/imx8mq-power.h      |   3 +
>   8 files changed, 237 insertions(+), 157 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
>
>
> base-commit: d1888b0bfd2ddef2e8a81505ffa200b92cc32e0c
