Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539B44B27CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350781AbiBKO2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:28:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiBKO2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:28:05 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05D8C7;
        Fri, 11 Feb 2022 06:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589683; x=1676125683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MKDoPVkuHIq+33Y64fqol9qvZyUA4rLWQUVSaAFy+xE=;
  b=LZRoQ2oK+emWAvDkDDDOylZXZSlePiJ4XFMLKzujvoFiv4jgYDKzlOFz
   Z9cnP3bMWkdk8tqMPrenpTB5oqZ0upqAjU2sV2mvD0xAAKHOcwfLft4mL
   bKPsbKTiZrvTJeVfRJB3MQwJPDB6+PJjx6Hu+IJw3EFq8NKEmuAMhKrFy
   xrm6VPzS5zZ3WTxm45psqwVTH9XteLSxom1a3lMw0aIqRMbv7gYzqFIZ+
   joQXe7BgOJNABZiQF9Fypgv0TvcumeiPnR0coRM3INAYP5KrmG8qMjbDM
   PoOB6nKJdjROzgndPn4A5WBsJConfqaMe+pWr+HT0U1jIq7Da8buJFWU9
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042278"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 Feb 2022 15:28:00 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 11 Feb 2022 15:28:01 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 11 Feb 2022 15:28:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1644589680; x=1676125680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MKDoPVkuHIq+33Y64fqol9qvZyUA4rLWQUVSaAFy+xE=;
  b=j5i1aRLqHFqcv+Blo3WMTwucR7ouBBn58aYXhsbzkLhQsi//OSbYFGQa
   Yfb9ZCPAvrv/ey+kje9tqXrA56Bn/xaMyomb/lqFZ5ZekmOviVVEmVN8J
   zPDX+dfg303jXiY5yvJd/0aiocJn5f2tt4BhR/ehCFBYBgqtSzhpJ3vqE
   5toA44umYFt+30z+3AeZFg8ll/63GaHRG760OKkGt3W12uYd9MEqnIp4M
   m6A4+ldO7oeyYsTeQtWvrW5t0egkEGePnfijIKdE/NJf0QPxY482eyhGs
   mI/z1e3iukYwyEcfDbz1qkpCrq1Z/oUWia4/S0SWxzs+A6NDxdlItjZ8K
   g==;
X-IronPort-AV: E=Sophos;i="5.88,361,1635199200"; 
   d="scan'208";a="22042276"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Feb 2022 15:28:00 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 32BC9280065;
        Fri, 11 Feb 2022 15:28:00 +0100 (CET)
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
Subject: [PATCH v2 0/9] imx7/imx8mm media / csi patches
Date:   Fri, 11 Feb 2022 15:27:43 +0100
Message-Id: <20220211142752.779952-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

thanks for the feedback in v1.

Changes in v2:
* Switch back from bool to enum for distinguishing imx5/6 and imx7/8
* Added missing colorspace settings in PATCH 5
* Added PATCH 8 for hardening media-imx code

Below is theoriginal message slightly modified to match the v2 changes.

This is a set of patch for imx7 media drivers based on next-20220210. With
this set I was able to capture video frames from a MIPI CSI-2 camera in my
TQMa8MQML + MBA8MX hardware. The actual camera used is a Vision Components
'VC MIPI IMX327 C' camera. IMX327 is compatible to IMX290. Patch 9 shows the
DT overlay I'm using, not suitable for merging.
Please ignore the FPGA part, this is mainly for power supply and GPIO reset
line. This is currently a custom driver I'm working on, but I do not want to
focus on in this series.

Please note I tested this only on this imx8 platform.

First thanks to Dorota for the patchset at [1] (patches 1-4) which is necessary
to capture correct images.

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

Alexander Stein (5):
  media: imx: imx7_mipi_csis: store colorspace in set_fmt as well
  media: imx: imx7_media-csi: Add support for additional Bayer patterns
  media: imx: utils: Add more Bayer formats
  media: imx: utils: initialize local variable
  [DNI] arm64: dts: tqma8mqml: add IMX327 MIPI-CSI overlay

Dorota Czaplejewicz (4):
  media: imx: Store the type of hardware implementation
  media: imx: Forward type of hardware implementation
  media: imx: Use dedicated format handler for i.MX7/8
  media: imx: Fail conversion if pixel format not supported

 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 .../imx8mm-tqma8mqml-mba8mx-imx327.dts        |  95 ++++++++++++
 drivers/staging/media/imx/imx-ic-prpencvf.c   |   3 +-
 drivers/staging/media/imx/imx-media-capture.c |  20 ++-
 drivers/staging/media/imx/imx-media-csi.c     |   3 +-
 drivers/staging/media/imx/imx-media-utils.c   | 136 +++++++++++++++++-
 drivers/staging/media/imx/imx-media.h         |  11 +-
 drivers/staging/media/imx/imx7-media-csi.c    |  15 +-
 drivers/staging/media/imx/imx7-mipi-csis.c    |   4 +
 9 files changed, 275 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx-imx327.dts

-- 
2.25.1

