Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54C476F98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhLPLNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhLPLNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:13:14 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4409FC061574;
        Thu, 16 Dec 2021 03:13:14 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id x6so34406369iol.13;
        Thu, 16 Dec 2021 03:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=54oWWoqoZRE1KomV36qp17pwppN05XALT4TsXIurcA8=;
        b=cItagiJJAz7DHAfCxPnMgC4HuMPJL3dRt3szmXX+GaUxfZ0rOhAq2f25XNBCk8Xo46
         ZC3jnDok91LDP/J0Aojhf8S+RVc/UGmhRKbnOdqPyEZAi3vqM4tkTUlvhQ00fg1vvRgm
         2uYkYPp7AqaID4zqBsI+5lrt7U5EN4ek6mAL6K3m4MCUOxi5Bn8ZcAakI0bQ1fS13l7c
         As7EPAEOqBrOBHM8kFPlxvO6ZeJY/0N4DYB4IuA5zTxdxumdJ0vm88nlquyLbzyFaAxS
         Dq0nuOaqsJipOx15C++m7ysQBYRUgX+qXtVN80idfexI+j/TGQcR5ciJY4KtrKX4G+dS
         JrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=54oWWoqoZRE1KomV36qp17pwppN05XALT4TsXIurcA8=;
        b=PYQy2GTcotot02T695ZpzY1i14HZQotQylmj/nHuwlDCVtKQS6OiaIdm6XSeO4qS5s
         9FTOf+5HfWLAwKPTX6sylEUa3ab9Od1E2rWIALOrAp1H18YPNgkiLsaoQ+Oe7y6OBQzq
         wl7rMbxM1KmOpwjzINLSsOg0OY5YuqyfMQQSU0yOh8DuhHFgyzVdy8dIuVJKYz1uJtb8
         LXj71gRiO6heVD3pB0AndRzZ17fa4YAM9iDp8V8asD/rhEFk9z2E+cFMQTr8qHNcHJXJ
         iVau+BMoKwS2yEhbdv8mTm3YVh+1LDfpJ94MQm0NMKvUgm+nIm7hgKdoCunzYi52h2sw
         Sp9g==
X-Gm-Message-State: AOAM53269KBsQx1WzkAvn7wMGvGUPXp1IWLGJSkdg7PGWR+qY8Soa2SR
        8nuM1ijagCymlxDUge3H2Ald413FARQcJLd5
X-Google-Smtp-Source: ABdhPJwvVo8tPWOUQxrNaQVlLXq+RAbTp5V12nskk+dTmerWZP7vQgxY7ozL9koGj1zxFhGi3B4yWw==
X-Received: by 2002:a05:6638:33a6:: with SMTP id h38mr9195152jav.185.1639653193110;
        Thu, 16 Dec 2021 03:13:13 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:fe22:1652:55f7:5197])
        by smtp.gmail.com with ESMTPSA id h1sm3090946iow.31.2021.12.16.03.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:13:12 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     abel.vesa@nxp.com, aford@beaconembedded.com,
        benjamin.gaignard@collabora.com, hverkuil-cisco@xs4all.nl,
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
Subject: [PATCH V2 00/10] media: hantro: imx8mq/imx8mm: Let VPU decoders get controlled by vpu-blk-ctrl
Date:   Thu, 16 Dec 2021 05:12:45 -0600
Message-Id: <20211216111256.2362683-1-aford173@gmail.com>
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
git://linuxtv.org/hverkuil/media_tree.git for-v5.17e

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

V2:  Remove references to legacy dt-binding from YAML, but keep
     it in the driver so older device trees can still be used.
     Fix typos in YAML
     Remove reg-names, interrupt-names, and clock-names from YAML,
     since each node will only have one of each, they're not necessary
     Add Fluster scores to cover letter for i.MX8MQ

Adam Ford (7):
  dt-bindings: media: nxp,imx8mq-vpu: Split G1 and G2 nodes
  media: hantro: Allow i.MX8MQ G1 and G2 to run independently
  arm64: dts: imx8mq: Enable both G1 and G2 VPU's with vpu-blk-ctrl
  arm64: dts: imx8mm: Fix VPU Hanging
  dt-bindings: media: nxp,imx8mq-vpu: Add support for G1 and G2 on
    imx8mm
  media: hantro: Add support for i.MX8MM
  arm64: dts: imx8mm: Enable Hantro G1 and G2 video decoders

Lucas Stach (3):
  dt-bindings: power: imx8mq: add defines for VPU blk-ctrl domains
  dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
  soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl

 .../bindings/media/nxp,imx8mq-vpu.yaml        | 93 +++++++++++--------
 .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      | 71 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 23 ++++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 63 ++++++++-----
 drivers/soc/imx/imx8m-blk-ctrl.c              | 68 +++++++++++++-
 drivers/staging/media/hantro/hantro_drv.c     |  3 +
 drivers/staging/media/hantro/hantro_hw.h      |  3 +
 drivers/staging/media/hantro/imx8m_vpu_hw.c   | 75 ++++++++++++---
 include/dt-bindings/power/imx8mq-power.h      |  3 +
 9 files changed, 324 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml


base-commit: d1888b0bfd2ddef2e8a81505ffa200b92cc32e0c
-- 
2.32.0

