Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF08A49BA15
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587607AbiAYRSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349515AbiAYRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:36 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A1C06175C;
        Tue, 25 Jan 2022 09:12:22 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id i62so8789784ioa.1;
        Tue, 25 Jan 2022 09:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rEGsemrF2MpzSaFtK9a7VF5CyiT+4zDqlNQARTClDqQ=;
        b=Yr5rkQ+Cfop1lHOifCaGoLJxKWI2LMh8BioL2QjX0YQjrkl7z5j2kslX/qSYjfrAoj
         3fLbcFjT6zN+yQF1aKFf/5twSFjPebGQn0pBJN17I/uYpWJvNk5quHdjJz8aDySHuhgA
         E9/mZNNxf0OtRNq75/F9SXEprbxbgR972rs/a8nAw8UYU5y5eX+sKOluGoBu2tG+M3Q6
         fErxvGYBwejOhBLbIHaSdwGAnnm2BeYor9SRtz3Tcf5oRPOx2tNTlMQV2JFWp+dTf+ke
         bH7Mx5u0YhZ+f452asyi7GFHSqy+18njZ05kV/v4NbjQAN7Xwyn37s/StZphwXaHZVD+
         XXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rEGsemrF2MpzSaFtK9a7VF5CyiT+4zDqlNQARTClDqQ=;
        b=wS5d838lOjTGEe8gH+3poHS8YR7BNmX+o8CnETuNvl/ckSuip1cjSJkwHgPRVV3awG
         3Ca3KU6TUIIEibVKoeHqMSdNJP9davTh4oc5yvo21WfOwQE71WVAaBEoctBCK2COWd3J
         bbD319oS5G8YWNTKrPKiXPf02Avv8/4GLRzq7XUhQlKA7KNtGJMv5LeN4Mc3QJ18hI42
         e5OeDkbW05Lbn8joY9JU8RW7CyuXJq+xTVon9aCD3sRrcg8oCE0YVCBbYao5zzcI8mUX
         wwrSxoNLx/cyzU6nj4rPPCVthn5IFmAXzODz+CCL+pwi2AnUia7ct/5Lgz0h+IHyJEIz
         OCgQ==
X-Gm-Message-State: AOAM532jUuB/QeubEGJ5tZZ6rhW+H5Fzw+pQ1sYw66tQSTbvHXzgTWv0
        SuY3Gslcbtj5zCeiEYbQMFXFn2i4kpc=
X-Google-Smtp-Source: ABdhPJyw9E4BKoePLJL9BheAFhK0qfF07y/A5HfI3ABp3cWjHBjSS1QZYlxecizs/mFXZQVRZQgiLQ==
X-Received: by 2002:a05:6638:32a5:: with SMTP id f37mr9731853jav.208.1643130740951;
        Tue, 25 Jan 2022 09:12:20 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6592:b6fe:71b1:9f4c])
        by smtp.gmail.com with ESMTPSA id m14sm8090291iov.0.2022.01.25.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:19 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
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
Subject: [PATCH V4 00/11] media: hantro: imx8mq/imx8mm: Let VPU decoders get controlled by vpu-blk-ctrl
Date:   Tue, 25 Jan 2022 11:11:17 -0600
Message-Id: <20220125171129.472775-1-aford173@gmail.com>
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

V4:  Add a comment and a notice based on feedback from Ezequiel Garcia
     if the older compatible flag is used.
     Add new patch which removes a reference to vpu from imx8mq-tqma8mq
     because the VPU is enabled by default and it's not needed.  Without
     this change, its device tree would fail to build.

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



Adam Ford (8):
  arm64: dts: imx8mq-tqma8mq: Remove redundant vpu reference
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
 .../boot/dts/freescale/imx8mq-tqma8mq.dtsi    |  4 --
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 63 +++++++++-------
 drivers/soc/imx/imx8m-blk-ctrl.c              | 66 +++++++++++++++++
 drivers/staging/media/hantro/hantro_drv.c     | 11 +++
 drivers/staging/media/hantro/hantro_hw.h      |  2 +
 drivers/staging/media/hantro/imx8m_vpu_hw.c   | 62 ++++++++++++----
 include/dt-bindings/power/imx8mq-power.h      |  3 +
 10 files changed, 292 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.32.0

