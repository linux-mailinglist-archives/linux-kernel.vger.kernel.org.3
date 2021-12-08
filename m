Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8044C46D486
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhLHNjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:39:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45232 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhLHNjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:39:53 -0500
Received: from [IPv6:2a01:e0a:120:3210:9928:73b0:79a4:e623] (unknown [IPv6:2a01:e0a:120:3210:9928:73b0:79a4:e623])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5FDF81F45C58;
        Wed,  8 Dec 2021 13:36:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638970579; bh=T21DsC5WunBNF8almSy/Pv06AmMgo6zWaeFNxDn4064=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ie6bllBZvUbJ8qRV5YkgwvVshsAED4wNMwBPtOkfuUUSthqKkrGwx3KB+HC0cqek/
         WtZudzhSK8pLL/2cB9WzfdxoC11+UzOBtc3Y6bFeH1S9T4Jc8TOqRu2oEXTEVFrfYD
         sqIAJeqyjwj2wCCpj/xR8VbcwCZnc4N7VpC5YIYcATQKQWN59j9TgMhMeWvVMM80rf
         690B0N65kHWNu8EH4yvj8/vWuQTpg7lYZZOS4X5bwNk6nI7jTpzGI0/+dQ3rN/RJqL
         i8qnaiWEUgfsMwE7azQV0wcGirqC8W1D38XCPjYwlwAxnXvfXJ7yRvsSaMueTnQkjI
         +5KOAOmFmKLPw==
Subject: Re: [RFC V2 0/6] media: Hantro: Split iMX8MQ VPU into G1 and G2 with
 blk-ctrl support
To:     Lucas Stach <l.stach@pengutronix.de>,
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
References: <20211207015446.1250854-1-aford173@gmail.com>
 <f85da774-ccb3-85de-edd6-5333ed8d0503@collabora.com>
 <5a8b84e91bd8e7670a0d0108e4affe9b964202cb.camel@pengutronix.de>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <4cc3404b-7f8a-6c87-8c1c-ace399f9edd3@collabora.com>
Date:   Wed, 8 Dec 2021 14:36:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5a8b84e91bd8e7670a0d0108e4affe9b964202cb.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 08/12/2021 à 11:32, Lucas Stach a écrit :
> Am Mittwoch, dem 08.12.2021 um 10:32 +0100 schrieb Benjamin Gaignard:
>> Le 07/12/2021 à 02:54, Adam Ford a écrit :
>>
>>> Currently, the VPU in the i.MQ8MQ is appearing as one codec, but in
>>> reality, it's two IP blocks called G1 and G2.  There is initialization
>>> code in VPU code to pull some clocks, resets and other features which
>>> has been integrated into the vpu-blk-ctrl for the i.MX8M Mini and a
>>> similar method can be used to make the VPU codec's operate as
>>> stand-alone cores without having to know the details of each other
>>> or the quirks unique to the i.MX8MQ, so the remaining code can be
>>> left more generic.
>>>
>>> This series was started by Lucas Stach with one by Benjamin Gaignard.
>>> Most patches have been modified slightly by me.  It's in an RFC state
>>> because I wasn't sure how to best handle the signatures and wasn't sure
>>> if I could base it off the branch I did.
>>>
>>> Since the g-streamer and media trees are in a constant state of
>>> change, this series is based on
>>>
>>> git://linuxtv.org/hverkuil/media_tree.git for-v5.17e
>>>
>>> The downstream code from NXP shows the G1 and G2 clocks running
>>> at 600MHz, but between the TRM and the datasheet, there is some
>>> discrepancy.  Because the NXP reference code used 600MHz, that is
>>> what was chosen here.  Users who need to adjust their G1 and G2
>>> clocks can do so in their board files.
>> Hi Adam,
>>
>> Thanks for your patches, I have been able to reproduce VP9 results on my side (Fluster 147/303).
>> In past I have notice spurious errors when using 600MHz clock on HEVC decode but not with 300MHz.

The results for Fluster HEVC are 77/147 so no regressions :-)

Regards,
Benjamin

>> The max supported G2 clock frequency is 660MHz but needs a higher
>> voltage. The maximum supported  frequency at the default 0.9V is
>> 550MHz. We should not configure the clocks for the higher than that, as
>> long as there is no support in the VPU driver to scale the voltage
>> along with the frequency. Same as with the GPU we should stick to base
>> frequency levels for the nominal operating mode.
>>
>> Regards,
>> Lucas
>>
>> Regards,
>> Benjamin
>>
>>> Fluster Results:
>>>
>>> ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
>>> Ran 90/135 tests successfully               in 61.966 secs
>>>
>>> ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
>>> Ran 55/61 tests successfully               in 7.660 secs
>>>
>>>
>>> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
>>> Ran 144/303 tests successfully               in 162.665 secs
>>>
>>> Changes log:
>>>
>>> V2:  Make vpu-blk-ctrl enable G2 clock when enabling fuses.
>>>        Remove syscon from device tree and binding example
>>>        Added modified nxp,imx8mq-vpu.yaml from Benjamin Gaignard
>>>
>>> Adam Ford (2):
>>>     media: hantro: split i.MX8MQ G1 and G2 code
>>>     arm64: dts: imx8mq: Split i.MX8MQ G1 and G2 with vpu-blk-ctrl
>>>
>>> Benjamin Gaignard (1):
>>>     dt-bindings: media: nxp,imx8mq-vpu: Update the bindings for G2 support
>>>
>>> Lucas Stach (3):
>>>     dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
>>>     dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
>>>     soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl
>>>
>>>    .../bindings/media/nxp,imx8mq-vpu.yaml        |  58 +++++----
>>>    .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      |  71 +++++++++++
>>>    arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  69 ++++++----
>>>    drivers/soc/imx/imx8m-blk-ctrl.c              |  68 +++++++++-
>>>    drivers/staging/media/hantro/hantro_drv.c     |   4 +-
>>>    drivers/staging/media/hantro/hantro_hw.h      |   2 +-
>>>    drivers/staging/media/hantro/imx8m_vpu_hw.c   | 119 +++---------------
>>>    include/dt-bindings/power/imx8mq-power.h      |   3 +
>>>    8 files changed, 237 insertions(+), 157 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
>>>
>>>
>>> base-commit: d1888b0bfd2ddef2e8a81505ffa200b92cc32e0c
>
