Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3402B4653DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351868AbhLAR1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbhLAR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:27:04 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A769C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:23:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so261185pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykCOSl1DR1nooY0Igc75aTkUdtgWWtVr7m16LxU2Evo=;
        b=QY/uWasz8CDavm3HQOwoN783a1XibY4AIEjRICoXuDJ3rcT6sX940BzyeEElAZSMKH
         aVzwrCRWWk6s6yElOL/+zaTSWXLJLcOSpriN40a8Ecms3EoHKBrvt44FeFNk8LOPA07R
         xHNMD8O+Dsus7qnBJjp8Gh1M7O9DvFqhQjPvBdsMtygny3z23nTbPWu0DC+BXrZ+t02u
         dEKbme+x2iCOn14x51iomJkKVqdVzww7pF2v7VH4zCGt7XfwvdfWVfBlsyyqFq/i4iA3
         ZFqrU7YrdyN4B6olG90FeZJsR7zVsyHy+mntkq8IGddNBIC83VYeQQK/vsKgXX1ydpUD
         m2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykCOSl1DR1nooY0Igc75aTkUdtgWWtVr7m16LxU2Evo=;
        b=fU6xTPcJXp6fWnY5cqwOhaKpOU1xkjre1BTdMk0ipPvubFYLCa3O2v9B61+lRhrmBl
         ZzU+v02Wl2t/qiCV9EpU02plVGB4XesNIzZPMk8VJ6B68Q4Tr62gl5PPUZ7421JvvK9R
         ry8wv1QlDJrRIt9hMLhH0cdAEcODqHP8eX/iqAkRugx6CFraT5DSeWc0/ehKOLvupXds
         fh8on/+XL/7gWoqybrSf+ViuhXm2xMHiAXxnE0NZ5pM864p8T+kzd8yxZfEdZYW7JRDA
         eNSMXReliXTOy9QutFvOi4qBYs8+cT2maUfx8TjBpPP/BY5BvHDAFZ1mLuvVl4ep0JPa
         UizA==
X-Gm-Message-State: AOAM530w6pi58fJS35a9lz7PbqM1xw6UyYebUmaLTCS6qEZvtGF9M5Av
        auADV9gDaA3ETe8134KvUkhp1fmmpMZ5rPjMoEzgqSMK5jlzYORV
X-Google-Smtp-Source: ABdhPJyzb1DYRJAzXFYCNHh3xxtvOFlxqgyxfdSYfvQhBWij59zsgTe/H6UhPJaD87eZQQzGMhfXZONUPEbRm8yF9Go=
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr9151438pjb.66.1638379422917;
 Wed, 01 Dec 2021 09:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20211201013329.15875-1-aford173@gmail.com>
In-Reply-To: <20211201013329.15875-1-aford173@gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 1 Dec 2021 09:23:31 -0800
Message-ID: <CAJ+vNU1jENmWAR_5E98Vgb53ctxjxSWJewPW0YC4Yp4DuYTn3g@mail.gmail.com>
Subject: Re: [RFC V2 0/2] arm64: imx8mm: Enable Hantro VPUs
To:     Adam Ford <aford173@gmail.com>, l.stach@pengutronix.de
Cc:     linux-media@vger.kernel.org, ezequiel@vanguardiasur.com.ar,
        hverkuil@xs4all.nl, nicolas@ndufresne.ca, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 5:33 PM Adam Ford <aford173@gmail.com> wrote:
>
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
>  ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> Ran 55/61 tests successfully               in 21.454 secs
>
> ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> Ran 0/303 tests successfully               in 20.016 secs
>
> Each day seems to show more and more G2 submissions, and gstreamer seems to be
> still working on the VP9, so I am not sure if I should drop G2 as well.
>
>
> Adam Ford (2):
>   media: hantro: Add support for i.MX8M Mini
>   arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2
>
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi   | 41 +++++++++++++++
>  drivers/staging/media/hantro/hantro_drv.c   |  2 +
>  drivers/staging/media/hantro/hantro_hw.h    |  2 +
>  drivers/staging/media/hantro/imx8m_vpu_hw.c | 57 +++++++++++++++++++++
>  4 files changed, 102 insertions(+)
>

Adam,

That's for the patches!

I tested just this series on top of v5.16-rc3 on an
imx8mm-venice-gw73xx-0x and found that if I loop fluster I can end up
getting a hang within 10 to 15 mins or so when imx8m_blk_ctrl_power_on
is called for VPUMIX pd :
while [ 1 ]; do uptime; ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0; done
...
[  618.838436] imx-pgc imx-pgc-domain.6: failed to command PGC
[  618.844407] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain

I added prints in imx_pgc_power_{up,down} and
imx8m_blk_ctrl_power_{on,off} to get some more context
...
Ran 55/61 tests successfully               in 8.685 secs
 17:16:34 up 17 min,  0 users,  load average: 3.97, 2.11, 0.93
********************************************************************************
********************
Running test suite VP8-TEST-VECTORS with decoder GStreamer-VP8-V4L2SL-Gst1.0
Using 4 parallel job(s)
********************************************************************************
********************

[TEST SUITE      ] (DECODER                    ) TEST VECTOR               ... R
ESULT
----------------------------------------------------------------------
[ 1023.114806] imx8m_blk_ctrl_power_on vpublk-g1
[ 1023.119669] imx_pgc_power_up vpumix
[ 1023.124307] imx-pgc imx-pgc-domain.6: failed to command PGC
[ 1023.130006] imx8m-blk-ctrl 38330000.blk-ctrl: failed to power up bus domain

While this wouldn't be an issue with this series it does indicate we
still have something racy in blk-ctrl. Can you reproduce this (and if
not what kernel are you based on)? Perhaps you or Lucas have some
ideas?

Best regards,

Tim
