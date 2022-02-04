Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B14A9905
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358592AbiBDMP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:15:28 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:1606 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238672AbiBDMPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976925; x=1675512925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cR70RHsoqfuHVwt9ephCevXoTQCZ6y12xcf3PcFCPD8=;
  b=fztZE5epAsQlkkYSZDTXsH3R2anP8JwJML5LjgGd6uYT3tgRF40S+w1k
   0+eifEkhyNYZ2LkDMUF72JzJU+Ri10wdkCtpbjLoQsFZzVqw5FmcrVWml
   sKXiTX0NaRAe8rc1soOJTkDRu8V+tIUQc7PB5guuUMCwy8xd74DmajJYr
   wjbv/hPRicCx4o/DUMVjV6eMLvgZecSpfWPahTNGPaN+iYY0KL6a1s+fo
   zN5M6V6X7OuyVD4c4041QfHdtDbukZQyBqWBzJNG3jQ6P4S40JNKadNYz
   loEJAaSUolZctyC5oopz0si7sA/QqYI7Jg7i5qSfgr3UFh1Ys7ZhwZwsk
   g==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903425"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Feb 2022 13:15:24 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Feb 2022 13:15:24 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Feb 2022 13:15:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976924; x=1675512924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cR70RHsoqfuHVwt9ephCevXoTQCZ6y12xcf3PcFCPD8=;
  b=f22/CAbkl0kptFrKHwO6g9mz8G61RbHtS73+8Ux/s8UR1zEAZNMCQI3H
   TB9IL5pVUCdn9SMlW69VQ9PM+QO41KPoJWAgZ+mefdqXgLP3siqRvNfjm
   kH4XSI3mpkueFPP68o0NS+srM6vRL3uCncCYirCAo2zE+y0/DS/5vaZXS
   tTegvvpNecZpBOxx4YtDYtBoBVR/KSmUYapygvoDZYb2ImNQKoZgM3Hub
   6K2+Z25m/vxg8CTvnoH0N4kzIcl45hFIvKwQhn/B8TDS0vf5kAWXYZ38U
   S7rPiiSz5XwMxWkN1w0Nb16L9Ay4LqhmFByjMeVD3U6iRSPKuyO3zWKPy
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903424"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Feb 2022 13:15:24 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1B667280065;
        Fri,  4 Feb 2022 13:15:24 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] imx7/imx8mm media / csi patches
Date:   Fri,  4 Feb 2022 13:15:06 +0100
Message-Id: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

this is a set of patch for imx[7] media drivers based on next-20220203. With
this set I was able to capture video frames from a MIPI CSI-2 camera in my
TQMa8MQML + MBA8MX hardware. The actual camera used is a Vision Components
'VC MIPI IMX327 C' camera. IMX327 is compatible to IMX290. Patch 8 shows the
DT overlay I'm using, not suitable for merging.
Please ignore the FPGA part, this is mainly for power supply and GPIO reset
line. This is currently a custom driver I'm working on, but I do not want to
focus on in this series.

Please note I tested this only on this imx8 platform.

First thanks to Dorota for the patchset at [1] (patches 1-4) which is necessary
to capture correct images. I integrated Hans' review into it. I hope the
I didn't make a mistake and the original author is kept along. I used v4 for that
patchset, it is v1 again in this set. I hope this is not confusing.

Starting from patch 5 there are small fixes which allows me to configure my
media device.

Device configuration:
```
media-ctl -l "'imx290 2-001a':0->'csis-32e30000.mipi-csi':0 [1]"
media-ctl -V "'imx290 2-001a':0 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw]"
media-ctl -V "'csi':0 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw]"
v4l2-ctl -d0 --set-fmt-video width=1920,height=1080,pixelformat='RG10',field=none
media-ctl -p
```

The media-ctl topology is:
```
# media-ctl -p
Media controller API version 5.17.0

Media device information
------------------------
driver          imx7-csi
model           imx-media
serial          
bus info        platform:32e20000.csi
hw revision     0x0
driver version  5.17.0

Device topology
- entity 1: csi (2 pads, 2 links)
            type V4L2 subdev subtype Unknown flags 0
            device node name /dev/v4l-subdev0
        pad0: Sink
                [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw xfer:none ycbcr:601 quantization:full-range]
                <- "csis-32e30000.mipi-csi":1 [ENABLED,IMMUTABLE]
        pad1: Source
                [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw xfer:none ycbcr:601 quantization:full-range]
                -> "csi capture":0 [ENABLED,IMMUTABLE]

- entity 4: csi capture (1 pad, 1 link)
            type Node subtype V4L flags 0
            device node name /dev/video0
        pad0: Sink
                <- "csi":1 [ENABLED,IMMUTABLE]

- entity 10: csis-32e30000.mipi-csi (2 pads, 2 links)
             type V4L2 subdev subtype Unknown flags 0
             device node name /dev/v4l-subdev1
        pad0: Sink
                [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw xfer:709 ycbcr:601 quantization:lim-range]
                <- "imx290 2-001a":0 [ENABLED]
        pad1: Source
                [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw xfer:709 ycbcr:601 quantization:lim-range]
                -> "csi":0 [ENABLED,IMMUTABLE]

- entity 15: imx290 2-001a (1 pad, 1 link)
             type V4L2 subdev subtype Sensor flags 0
             device node name /dev/v4l-subdev2
        pad0: Source
                [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw]
                -> "csis-32e30000.mipi-csi":0 [ENABLED]
```

Note: MIPI CSI settle times are not calculated correctly right now and need a
manual overwrite:
echo 13 > /sys/kernel/debug/32e30000.mipi-csi/ths_settle 
echo 2 > /sys/kernel/debug/32e30000.mipi-csi/tclk_settle

I ignored the settings for xfer, ycbcr and quantization for now. I do neither
know how they will affect me nor what it should be.
Also I did not focus on v4l2-compliance tool, this is a further task as well.
IMHO imx7-mipi-csis.c should also create an immutable link to the camera
sensor.

Regards,
Alexander

[1] https://patchwork.linuxtv.org/project/linux-media/patch/20211104113631.206899-2-dorota.czaplejewicz@puri.sm/

Alexander Stein (4):
  media: imx: imx7_mipi_csis: store colorspace in set_fmt as well
  media: imx: imx7_media-csi: Add support for additional Bayer patterns
  media: imx: utils: Add more Bayer formats
  [DNI] arm64: dts: tqma8mqml: add IMX327 MIPI-CSI overlay

Dorota Czaplejewicz (4):
  media: imx: Store the type of hardware implementation
  media: imx: Forward type of hardware implementation
  media: imx: Use dedicated format handler for i.MX7/8
  media: imx: Fail conversion if pixel format not supported

 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 .../imx8mm-tqma8mqml-mba8mx-imx327.dts        |  95 +++++++++++++
 drivers/staging/media/imx/imx-ic-prpencvf.c   |   3 +-
 drivers/staging/media/imx/imx-media-capture.c |  20 ++-
 drivers/staging/media/imx/imx-media-csi.c     |   3 +-
 drivers/staging/media/imx/imx-media-utils.c   | 130 +++++++++++++++++-
 drivers/staging/media/imx/imx-media.h         |   6 +-
 drivers/staging/media/imx/imx7-media-csi.c    |  15 +-
 drivers/staging/media/imx/imx7-mipi-csis.c    |   1 +
 9 files changed, 262 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx-imx327.dts

-- 
2.25.1

