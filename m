Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CEE464A99
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348234AbhLAJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242304AbhLAJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:31:23 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C530C061574;
        Wed,  1 Dec 2021 01:28:03 -0800 (PST)
Received: from [IPv6:2a01:e0a:120:3210:81b0:4101:d4f2:ecb7] (unknown [IPv6:2a01:e0a:120:3210:81b0:4101:d4f2:ecb7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D03FE1F456A8;
        Wed,  1 Dec 2021 09:28:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638350881; bh=GOanvQHnMURC6UIEgHUa/+fTqbcJzEywsBQPZpD0MJA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=St1k4d/bgtbXVPjdtfbYA9aV4V9ZWSYVYtYwv4/c4FjJvQMSIbZKlzc18tl6VVxys
         +9+W64Jyao7xM80jFjcykCzfwQDYjw89p7rBHr5qi0Cc1R05nxmVPzOT0jlpRb9rG9
         6FBaB7Bag9wbRydqBhvX98QQGE9a6Xra6HO0xPpuZqDpIwqp6DeX9+mhrm8A+8cnl+
         HvLVl0bZkut7JlsYbQhDgdZw4Nt7bFrJQEyef6DumdrKef6n2MMUspFScI6081vh7B
         kaRZc9wY5l5YgSoO6GU2a0YWVRzaKeCyY+7HBAIl0LGQcQfDovjeL7PEXy/4stwN8y
         kMEDbFLZRlL9g==
Subject: Re: [RFC V2 0/2] arm64: imx8mm: Enable Hantro VPUs
To:     Adam Ford <aford173@gmail.com>, linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, hverkuil@xs4all.nl,
        tharvey@gateworks.com, nicolas@ndufresne.ca,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
References: <20211201013329.15875-1-aford173@gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <a07677bc-0a18-c910-222d-d6faee3fe5a0@collabora.com>
Date:   Wed, 1 Dec 2021 10:27:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201013329.15875-1-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 01/12/2021 à 02:33, Adam Ford a écrit :
> The i.MX8M has two Hantro video decoders, called G1 and G2 which appear
> to be related to the video decoders used on the i.MX8MQ, but because of
> how the Mini handles the power domains, the VPU driver does not need to
> handle all the functions, nor does it support the post-processor,
> so a new compatible flag is required.
>
> With the suggestion from Hans Verkuil, I was able to get the G2 splat to go away
> with changes to FORCE_MAX_ZONEORDER, but I found I could also set cma=512M, however
> it's unclear to me if that's an acceptable alternative.
>
> At the suggestion of Ezequiel Garcia and Nicolas Dufresne I have some
> results from Fluster. However, the G2 VPU appears to fail most tests.
>
> ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> Ran 90/135 tests successfully               in 76.431 secs
>
>   ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> Ran 55/61 tests successfully               in 21.454 secs
>
> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> Ran 0/303 tests successfully               in 20.016 secs
>
> Each day seems to show more and more G2 submissions, and gstreamer seems to be
> still working on the VP9, so I am not sure if I should drop G2 as well.

I think it is going in the good direction.
I'm trying to do the same on IMX6MQ but still have hang issue on G2.

Regards,
Benjamin

>
> Adam Ford (2):
>    media: hantro: Add support for i.MX8M Mini
>    arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2
>
>   arch/arm64/boot/dts/freescale/imx8mm.dtsi   | 41 +++++++++++++++
>   drivers/staging/media/hantro/hantro_drv.c   |  2 +
>   drivers/staging/media/hantro/hantro_hw.h    |  2 +
>   drivers/staging/media/hantro/imx8m_vpu_hw.c | 57 +++++++++++++++++++++
>   4 files changed, 102 insertions(+)
>
