Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAD46DE93
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbhLHWyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhLHWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:54:11 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0355DC061746;
        Wed,  8 Dec 2021 14:50:38 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 14so4597806ioe.2;
        Wed, 08 Dec 2021 14:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMi1WPOBzI4R2YZ5HVYQx/dnfliDDCI8Msm6WyR+eh4=;
        b=XcTrSwtnNRn21WNNBvMrv1NLcY+Mu2z72raACo/rJ6Taqa/EMOV2oNk4pwj4EmSvLt
         luGUbISzvvMt4KSslR634zeGU7QYraSlBBEYjYNASBeA99EN9gyzY0p3wkqYQQhmphEs
         8l6EQVJ9oSaQ7qdsh3KMQ5fyqkh0iQTq9sXGOyz+HT58120MR9jLg5eqv6VmCk0b0gqW
         34LQEiA0JxmeDCBx2kRlrxNHM5UZLoMzC557S3/8Anr6qDjJTuoMvojX8ltnjNtmc2Lp
         sdaKeArGSaq2svysxh0W+nXexC/NVpk3OK92mdkaPLWl6MwyxoTVlfMCYz+CxLRAeJ0i
         tSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMi1WPOBzI4R2YZ5HVYQx/dnfliDDCI8Msm6WyR+eh4=;
        b=ggcxL0UyDMH17Fv6R8hUbFKVo5asIfw0SlsplkJ1kAJyLMqDbnNdWqvzrnU6qNmhpd
         95tgs/si8ynPfEsy9gSsuJIbCFeC5JjvzyQVLCcBvtwKvobfxp5/gqdYxY17Shi3Q+8x
         clHliwc5yK0/NuzHPvxvQE1lCycpd3yRUYSBhRufWlDmEWfxCOwq2V06e0jQbeYI9HI5
         ylDH4rIK3ayRXHsAz3cuam+9wbRVk7C1sAJ3P46EBKQHpBkxmhtGNO0e0VpyZ2sxHE8H
         sSjrSwnnl6fb0h29FezkmcZoReoDdtM0vqzQot/C3ov5ovtmkUGrOQIiYGcN5ui/V4cG
         Omhg==
X-Gm-Message-State: AOAM5334rLyGf/NKYcfC++zsWu9m7/a0pCwPzQJBQygJp9v4ZWxYq0RX
        U9roa3jbhU76U0QR9OZ5feQTrBoPYfjcGQ==
X-Google-Smtp-Source: ABdhPJzZJP3Os1XE981Rf8W5rVV6iSlxLLkvkEoeb5qMER1aAj+4hxIA+fbfp5SLUrLTyxyWqwN1AA==
X-Received: by 2002:a6b:b490:: with SMTP id d138mr10603468iof.180.1639003837735;
        Wed, 08 Dec 2021 14:50:37 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:269a:1aa2:f1d9:8dbb])
        by smtp.gmail.com with ESMTPSA id t6sm2378751ioi.51.2021.12.08.14.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:50:37 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
        aford@beaconembedded.com, nicolas@ndufresne.ca,
        Adam Ford <aford173@gmail.com>,
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
Subject: [PATCH 00/10] media: hantro: imx8mq/imx8mm: Let VPU decoders get controlled by vpu-blk-ctrl
Date:   Wed,  8 Dec 2021 16:50:19 -0600
Message-Id: <20211208225030.2018923-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the i.MX8MQ and i.MX8MM have G1 and G2 decoders.
The two decoders are similar, but the imx8mm lacks the
post-processor, so they will have distinct compatible flags.
Splitting the i.MX8MQ VPU into G1 and G2 makes it easier to
control them independently since the TRM of both the i.MX8MQ and
i.MX8MM list them as distinct IP blocks.  With them being split,
the power-domain can shift to the vpu-blk-ctrl which is available
on both i.MX8MQ and i.MX8MM but some of bits are different, so
they'll have separate device tree bindings.
Lastly, with the G1 and G2 operational, enable the i.MX8MM.
On the i.MX8MM, the clock speed of 600MHz was chosen to match
the default of the kernel repo from NXP and can be overwritten
by board files for anyone who under/over volts the power rail.

The repo used as the starting point was:
   git://linuxtv.org/hverkuil/media_tree.git for-v5.17e

This media hantro group has been especially helpful in helping
me get up to speed on how it works.

Fluster was run on the i.MX8M Mini at 600 MHz:

./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
Ran 55/61 tests successfully               in 8.299 secs

./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
Ran 90/135 tests successfully               in 71.200 secs

./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
Ran 139/303 tests successfully               in 218.079 secs


Adam Ford (7):
  dt-bindings: media: nxp,imx8mq-vpu: Support split G1 and G2 nodes with
    vpu-blk-ctrl
  media: hantro: Allow i.MX8MQ G1 and G2 to run independently
  arm64: dts: imx8mq: Enable both G1 and G2 VPU's with vpu-blk-ctrl
  arm64: dts: imx8mm: Fix VPU Hanging
  dt-bindings: media: nxp,imx8mq-vpu: Enable support for i.MX8M Mini
  media: hantro: Add support for i.MX8MM
  arm64: dts: imx8mm: Enable Hantro G1 and G2 video decoders

Lucas Stach (3):
  dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
  dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
  soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl

 .../bindings/media/nxp,imx8mq-vpu.yaml        | 85 ++++++++++++++-----
 .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      | 71 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 29 ++++++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 69 +++++++++------
 drivers/soc/imx/imx8m-blk-ctrl.c              | 68 ++++++++++++++-
 drivers/staging/media/hantro/hantro_drv.c     |  3 +
 drivers/staging/media/hantro/hantro_hw.h      |  3 +
 drivers/staging/media/hantro/imx8m_vpu_hw.c   | 84 +++++++++++++++---
 include/dt-bindings/power/imx8mq-power.h      |  3 +
 9 files changed, 357 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml

base-commit: d1888b0bfd2ddef2e8a81505ffa200b92cc32e0c

-- 
2.32.0

