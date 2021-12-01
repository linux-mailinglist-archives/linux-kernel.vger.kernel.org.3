Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E35464488
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhLABhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbhLABg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:36:59 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA176C061746;
        Tue, 30 Nov 2021 17:33:39 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x6so28476402iol.13;
        Tue, 30 Nov 2021 17:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6+Hsl2E7Fnoefi4agcFRg7vLMjgK5Iu6TjBvSeyeqU=;
        b=i+kUWaVqqQZG9C824ctJ3vKTiwSiGEPuzWPmD6nxB1isjgMBq9ueQVb2J7WGfUoOsP
         dAokJBh1JXTjMUA107+TkDuGzB7CfvcQkFrZiGrOVchE9y4N2Tu7JXfjuNqCRrmFnEM4
         /R+zMMiycEZBYYqbQzW+hPEIUvCVcmnwGlRLsuDjU6+s0rNjIZSWYlD+rARVK5XDDADQ
         MAY7uj621/0AaiL1xZg8GyVdhpLD3CyrqiGBBC4xlT5w9b+TwkYPgRsP9/GIY52vUP3I
         biMS4DaVlzka/KAJ3UeGvDjmSDp4FeFxiFGkHEbLhRDVAA6oz8Cc5CJzImWZga6sEkLD
         s1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6+Hsl2E7Fnoefi4agcFRg7vLMjgK5Iu6TjBvSeyeqU=;
        b=kW9gKhWisogNtn2K3+02auZqWhll+9JFLLkFPIeJLLd/7j2MMG+yXnl2EUCMmhL+jt
         4NpzW0FB9TRqGbEFdMAZyp64+ce3W+uR66vwlN05PgjrFyD4rzOuIj6ms79Db3XOQSmO
         VHGwJkC/WEovG3aa8ATAv/BI03Q9YqiHM1hfpN2AGkvnjXRGxWfTOnIg67hlgGT9+/FI
         ltkg28BqpWartsz5s5XYqgDRYckfZcwo658S4qMio4JWRTk5cQIYM+iTouFG/bNLCwWD
         61/EQUI1pgFPTcPwLk7IZRlFfD0fDAma5URiJO7iQ6idWFFRRisIttdL1xwS2TtI0frj
         /JOA==
X-Gm-Message-State: AOAM5332I/Ho9nMT4LB8HVbT0GSNFsldK/xkw7/eAYI0sOcwgHlkPI3R
        Bsh85J0/AvTwUCieQ2j3+ZfUjwWCMWUBRJpt
X-Google-Smtp-Source: ABdhPJyW+HrcS0ZmOpkgFwvWGKGW6/Hwc9Osh0IEW7UhpCwjn64FvGv3Cn9B4lISIyqF86IIatHz8w==
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr4265751iow.55.1638322418535;
        Tue, 30 Nov 2021 17:33:38 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:b7ee:f768:f33c:c028])
        by smtp.gmail.com with ESMTPSA id u24sm11856737ior.20.2021.11.30.17.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 17:33:38 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, hverkuil@xs4all.nl,
        tharvey@gateworks.com, nicolas@ndufresne.ca,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
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
Subject: [RFC V2 0/2] arm64: imx8mm: Enable Hantro VPUs
Date:   Tue, 30 Nov 2021 19:33:27 -0600
Message-Id: <20211201013329.15875-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M has two Hantro video decoders, called G1 and G2 which appear
to be related to the video decoders used on the i.MX8MQ, but because of
how the Mini handles the power domains, the VPU driver does not need to
handle all the functions, nor does it support the post-processor,
so a new compatible flag is required.

With the suggestion from Hans Verkuil, I was able to get the G2 splat to go away
with changes to FORCE_MAX_ZONEORDER, but I found I could also set cma=512M, however
it's unclear to me if that's an acceptable alternative.

At the suggestion of Ezequiel Garcia and Nicolas Dufresne I have some
results from Fluster. However, the G2 VPU appears to fail most tests.

./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
Ran 90/135 tests successfully               in 76.431 secs

 ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
Ran 55/61 tests successfully               in 21.454 secs

./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
Ran 0/303 tests successfully               in 20.016 secs

Each day seems to show more and more G2 submissions, and gstreamer seems to be 
still working on the VP9, so I am not sure if I should drop G2 as well.


Adam Ford (2):
  media: hantro: Add support for i.MX8M Mini
  arm64: dts: imx8mm: Enable VPU-G1 and VPU-G2

 arch/arm64/boot/dts/freescale/imx8mm.dtsi   | 41 +++++++++++++++
 drivers/staging/media/hantro/hantro_drv.c   |  2 +
 drivers/staging/media/hantro/hantro_hw.h    |  2 +
 drivers/staging/media/hantro/imx8m_vpu_hw.c | 57 +++++++++++++++++++++
 4 files changed, 102 insertions(+)

-- 
2.32.0

