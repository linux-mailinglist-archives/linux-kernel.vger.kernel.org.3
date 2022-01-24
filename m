Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F2497748
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbiAXCbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240814AbiAXCbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:31:33 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66178C06173B;
        Sun, 23 Jan 2022 18:31:33 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id h23so17705069iol.11;
        Sun, 23 Jan 2022 18:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p13TQCGRgvTCj7GLIu8Z93zm/cda7I2vNls+/ZaL0QM=;
        b=JBqdhLlyiTRdjTAFVH2wDzWwLUlOYdDczEEuEf3zHgPMq7wBbGHcAuS+BNwoDx5jm4
         JFCeOQ1konG8R5lKoNXtYBPDwh9BbIptwVvqRBup3R0p5AWm15vQg/MkRwRVPqno9Qrt
         Gb9FgCFYqRtcXQvE+Gx9I1Nr6rziQBKGK0BuUOHQWl5yd1320wVfpphrLhkqmlM8TK4G
         cEZFceZGifQnrJ2ChiiYOes9MtiEZJm8hfqNXexTFcn9xW5zRliNSeVJUL4lwq1XHkjw
         zFW+KTAWl8Av+kfeLL2jpULggIOn3BQRpq1wA5/BkkB+JrBthfm1c9iId2VMg0A8N6wv
         8YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p13TQCGRgvTCj7GLIu8Z93zm/cda7I2vNls+/ZaL0QM=;
        b=S7tOJCerVtfqQgLA6Jp0AFfUfEqMJZ6Z0W4lF15aRb+BF5vJpVRm4VB2FwYNTB8YV9
         1G1njWsJzkRAiTNNjuBvxRUgFgcHNYaxywpT0eoJDsTlq0xCo0Db5T0Mh7yGE+VTH/rw
         rlANFTNjfKl+GFzuuC4c/0EqabhpMlNBb/N55+CmesthvusVqStUt3MczrpCKShuYmTE
         /DwGyMW52ejT+NsMtZde4B6JWcwwq073AFBCnfQpPvGbCxq5k/qMYQUg8kEaNvleszjW
         4wbBNMwRgKlMtMUtHACeDi/p5uGfCFA2YHFRCK9JxV9k5SMPZBiSzWoMU2urahzJ3o7X
         gUqg==
X-Gm-Message-State: AOAM531Y4rUPIzmBEpWPIyYrz/NLt57Qzk6Jnnc558MNP6XK8zeKMOPc
        aWROT2dW+T9FFN20kWC762nKl5pLepU=
X-Google-Smtp-Source: ABdhPJzHCWRlnTtYi6nXYxXBg2TQ4f+2rkUAUGFd1hsyBRLoC3kM1to4BkOmAaLnPAU6IfQ3gDwJ/Q==
X-Received: by 2002:a05:6602:1407:: with SMTP id t7mr7255403iov.78.1642991491139;
        Sun, 23 Jan 2022 18:31:31 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:582d:ad0e:e5a6:94b6])
        by smtp.gmail.com with ESMTPSA id w4sm6625633ilq.56.2022.01.23.18.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 18:31:30 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH V3 00/10] media: hantro: imx8mq/imx8mm: Let VPU decoders get controlled by vpu-blk-ctrl
Date:   Sun, 23 Jan 2022 20:31:14 -0600
Message-Id: <20220124023125.414794-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the i.MX8MQ and i.MX8MM have G1 and G2 decoders.
The two decoders are similar, but the imx8mm lacks the
post-processor, so they will have distinct compatible flags.

From what I can tell, the G2 decoder wasn't working, so splitting
the i.MX8MQ VPU into G1 and G2 makes it easier to control them
independently since the TRM of both the i.MX8MQ and
i.MX8MM list them as distinct IP blocks. This also allowed G2 to
become available.

With them being split, the power-domain can shift to the
vpu-blk-ctrl which is available on both i.MX8MQ and i.MX8MM,
but some of bits are different, so they'll have separate bindings.

Lastly, with the G1 and G2 operational, enable the i.MX8MM.
On the i.MX8MM, the clock speed of 600MHz was chosen to match
the default of the kernel repo from NXP and can be overwritten
by board files for anyone who under/over volts the power rail.

There seems to be some disagreement between the TRM and the Datasheet
for the imx8mq as to whether the speed should be 300MHz (TRM) or
600MHz (datasheet), so feedback from NXP would be very much
appreciated.

The repo used as the starting point was:
5.17-rc1

Fluster was run on both i.MX8MM and i.MX8MQ

At 600 MHz, the i.MX8MM had the following:

./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
Ran 55/61 tests successfully               in 8.299 secs

./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
Ran 90/135 tests successfully               in 71.200 secs

./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
Ran 139/303 tests successfully               in 218.079 secs

The i.MX8MQ had the following:

./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
Ran 55/61 tests successfully               in 7.732 secs

./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
Ran 90/135 tests successfully               in 58.558 secs

./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
Ran 144/303 tests successfully               in 271.373 secs

V3:  Rebase on 5.17-RC1.
     Remove imx8mm-vpu-g2 since it's identical to imx8mq-vpu-g2
     Remove unnecessary examples in YAML files.
     Remove some unused variables.

V2:  Remove references to legacy dt-binding from YAML, but keep
     it in the driver so older device trees can still be used.
     Fix typos in YAML
     Remove reg-names, interrupt-names, and clock-names from YAML,
     since each node will only have one of each, they're not necessary
     Add Fluster scores to cover letter for i.MX8MQ


Adam Ford (7):
  dt-bindings: media: nxp, imx8mq-vpu: Split G1 and G2 nodes
  media: hantro: Allow i.MX8MQ G1 and G2 to run independently
  arm64: dts: imx8mq: Enable both G1 and G2 VPU's with vpu-blk-ctrl
  arm64: dts: imx8mm: Fix VPU Hanging
  dt-bindings: media: nxp, imx8mq-vpu: Add support for G1 on imx8mm
  media: hantro: Add support for i.MX8MM Hantro-G1
  arm64: dts: imx8mm: Enable Hantro G1 and G2 video decoders

Lucas Stach (3):
  dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
  dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
  soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl

 .../bindings/media/nxp,imx8mq-vpu.yaml        | 68 ++++++++----------
 .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      | 71 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 23 +++++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 63 +++++++++-------
 drivers/soc/imx/imx8m-blk-ctrl.c              | 66 +++++++++++++++++
 drivers/staging/media/hantro/hantro_drv.c     |  2 +
 drivers/staging/media/hantro/hantro_hw.h      |  2 +
 drivers/staging/media/hantro/imx8m_vpu_hw.c   | 62 ++++++++++++----
 include/dt-bindings/power/imx8mq-power.h      |  3 +
 9 files changed, 283 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.32.0

