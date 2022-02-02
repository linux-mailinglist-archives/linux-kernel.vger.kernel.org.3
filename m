Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5392A4A7730
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbiBBR5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:57:11 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:58140 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346408AbiBBR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:56:50 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:7139:eada:2ff6:73dd])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9DB5F2F3;
        Wed,  2 Feb 2022 18:56:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643824608;
        bh=4gzDfwsslGC43s2cDQGFo1Ma/YkrMy2T0iVVt4XdW98=;
        h=From:To:Cc:Subject:Date:From;
        b=hkAxVsjg1EjMt48KzwBeXPKiG1aHIMclx+f8YVSUufY7dqMc5f0L0Brbzb0+xk193
         yKxfAHweAtIK/l2feZsBytcFqvaOZQWYgfcwThsgGi14aANYdVnlDNZqamjN1xlrli
         bY6SMnOh14x8Tj6r5iNhvOiP/cGV2I+ZdZywrNJ4=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v3 00/11] Add support for BCM2835 camera interface (unicam)
Date:   Wed,  2 Feb 2022 18:56:28 +0100
Message-Id: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

This patch series adds the BCM2835 CCP2/CSI2 camera interface named
unicam. This driver is already used in the out-of-tree linux-rpi
repository [1], and this work aims to support it in mainline.

The series is based on top of:
- Rebased on top of 5.16 Tomi Valkeinen's multiplexed stream work, on
  his multistream/work branch [2] which has been submitted as v10 at the
  time of this writing. The objective is to demonstrate the use of
  multiplexed streams on a real world widely used example as well as
  supporting unicam mainline.
- The "Add 12bit and 14bit luma-only formats" series [3] is partly
  applied (the Y10P format bug) the new formats are now part of this
  series.

The series is made of 11 patches:
- 1/11 and 2/11 introduce the new formats needed for the unicam driver
- 3/11 introduces dt-bindings documentation and MAINTAINERS entry I have
  tentatively assigned maintainership, is this fine ?
- 4/11 adds the driver support in media/platform
- 5/11 introduces the csi nodes in the bcm2711 file, in a disabled state
- 6/11 to 10/11 modifies imx219 driver to make it use the multiplexed
  streams API
- 11/11 is the imx219 dtsi file tested on my RPi 4b with the mainline
  dtb and not the downstream dtb anymore. *This patch is not intended to
be applied*.

All those patches are in my tree [4].

Patch 4/11 comes from the linux-rpi work [1] with substantial
modifications:
- Removed the non-mc API which is deprecated, and not needed upstream
- Moved from one video node with two source pads (image and embedded) to
  two video nodes
- Added a subdev between the sensor and the video nodes to properly
  route the streams
- Added support for multiplexed streams API

In order to test it, one will need a RPi board and the camv2 (imx219)
sensor.  An updated v4l-utils is also needed [5] to have support for
multiplexed streams.

v4l2-compliance passes on both video devices, without streaming testing
though with one exception: as the colorspace support is removed in v3,
we now have:

test VIDIOC_G_FMT: OK
  fail: v4l2-test-formats.cpp(363): colorspace >= 0xff
  fail: v4l2-test-formats.cpp(465): testColorspace(!node->is_io_mc,
	pix.pixelformat, pix.colorspace, pix.ycbcr_enc, pix.quantization)
test VIDIOC_TRY_FMT: FAIL
  fail: v4l2-test-formats.cpp(363): colorspace >= 0xff
  fail: v4l2-test-formats.cpp(465): testColorspace(!node->is_io_mc,
	pix.pixelformat, pix.colorspace, pix.ycbcr_enc, pix.quantization)
test VIDIOC_S_FMT: FAIL

This series since its v2 does integrate the device tree nodes into the
upstream BCM2835 or BCM2711 device tree support.

In order to properly configure the media pipeline, it is needed to call
the usual ioctls, and configure routing in order to send the embedded
data from the sensor to the "unicam-embedded" device node :

```
media=0
media-ctl -d${media} -l "'imx219 2-0010':0->'unicam-subdev':0 [1]"
media-ctl -d${media} -l "'unicam-subdev':1->'unicam-image':0 [1]"
media-ctl -d${media} -v -R "'unicam-subdev' [0/0->1/0[1],0/1->2/0[1]]"
media-ctl -d${media} -V "'imx219 2-0010':0/0 [fmt:SRGGB10_1X10/3280x2464 field:none]"
v4l2-ctl -d0 --set-fmt-video width=3280,height=2464,pixelformat='pRAA',field=none
media-ctl -d${media} -v -V "'imx219 2-0010':0/1 [fmt:METADATA_8/16384x1 field:none]"
media-ctl -d${media} -p
```

Be sure to configure the routes before setting the format, as s_routing
resets the default format.

The media-ctl topology is:
```
pi@raspberrypi:~ $ media-ctl -d${media} -p
Media controller API version 5.16.0

Media device information
------------------------
driver          unicam
model           unicam
serial          
bus info        platform:fe801000.csi
hw revision     0x0
driver version  5.16.0

Device topology
- entity 1: unicam-subdev (3 pads, 3 links, 2 routes)
            type V4L2 subdev subtype Unknown flags 0
            device node name /dev/v4l-subdev0
	routes:
		0/0 -> 1/0 [ACTIVE]
		0/1 -> 2/0 [ACTIVE]
	pad0: Sink
		[stream:0 fmt:SRGGB10_1X10/3280x2464 field:none colorspace:raw]
		[stream:1 fmt:METADATA_8/16384x1 field:none]
		<- "imx219 2-0010":0 [ENABLED,IMMUTABLE]
	pad1: Source
		[stream:0 fmt:SRGGB10_1X10/3280x2464 field:none colorspace:raw]
		-> "unicam-image":0 [ENABLED,IMMUTABLE]
	pad2: Source
		[stream:0 fmt:METADATA_8/16384x1 field:none]
		-> "unicam-embedded":0 [ENABLED,IMMUTABLE]

- entity 5: imx219 2-0010 (1 pad, 1 link, 2 routes)
            type V4L2 subdev subtype Sensor flags 0
            device node name /dev/v4l-subdev1
	routes:
		0/0 -> 0/0 [ACTIVE, IMMUTABLE, SOURCE]
		0/0 -> 0/1 [ACTIVE, SOURCE]
	pad0: Source
		[stream:0 fmt:SRGGB10_1X10/3280x2464 field:none colorspace:raw
		crop.bounds:(8,8)/3280x2464
		crop:(8,8)/3280x2464]
		[stream:1 fmt:METADATA_8/16384x1 field:none
		crop.bounds:(8,8)/3280x2464
		crop:(8,8)/3280x2464]
		-> "unicam-subdev":0 [ENABLED,IMMUTABLE]

- entity 9: unicam-image (1 pad, 1 link, 0 route)
            type Node subtype V4L flags 1
            device node name /dev/video0
	pad0: Sink
		<- "unicam-subdev":1 [ENABLED,IMMUTABLE]

- entity 15: unicam-embedded (1 pad, 1 link, 0 route)
             type Node subtype V4L flags 0
             device node name /dev/video1
	pad0: Sink
		<- "unicam-subdev":2 [ENABLED,IMMUTABLE]

```

Then a frame can be capture with yavta:
`yavta --capture=1 /dev/video0 -F/tmp/test-#.bin`

In v3, capture on the metadata node (/dev/video1 in my case) can't be
started if capture on image node (/dev/video0) is not already started.
This can be tested using yavta, letting it capture frames indefinitely
and start another yavta instance on the /dev/video1 node.


Side note:
My tree [4] also includes a backport for the unicam-isp drivers, it is
then possible, and it has been successfully tested, to use libcamera and
qcam to display the camera output.

[1]: https://github.com/raspberrypi/linux/tree/rpi-5.15.y
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git/log/?h=multistream/work
[3]: https://patchwork.linuxtv.org/project/linux-media/list/?series=7099
[4]: https://github.com/jhautbois/linux-rpi/tree/jmh/tomba/multistream/next/work-v10-with-laurent-isp-v3
[5]: https://github.com/jhautbois/v4l-utils/tree/jmh/tomi-multiplexed-streams

Jean-Michel Hautbois (11):
  media: v4l: Add V4L2-PIX-FMT-Y12P format
  media: v4l: Add V4L2-PIX-FMT-Y14P format
  media: dt-bindings: media: Add bindings for bcm2835-unicam
  media: bcm2835-unicam: Add support for CCP2/CSI2 camera interface
  ARM: dts: bcm2711: Add unicam CSI nodes
  media: imx219: Rename mbus codes array
  media: imx219: Switch from open to init_cfg
  media: imx219: Introduce the set_routing operation
  media: imx219: use a local v4l2_subdev to simplify reading
  media: imx219: Add support for the V4L2 subdev active state
  media: bcm283x: Include the imx219 node

 .../bindings/media/brcm,bcm2835-unicam.yaml   |  107 +
 .../media/v4l/pixfmt-yuv-luma.rst             |   44 +
 MAINTAINERS                                   |    8 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |    1 +
 arch/arm/boot/dts/bcm2711.dtsi                |   25 +
 arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi     |  102 +
 drivers/media/i2c/imx219.c                    |  344 ++-
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    2 +
 drivers/media/platform/bcm2835/Kconfig        |   21 +
 drivers/media/platform/bcm2835/Makefile       |    3 +
 .../media/platform/bcm2835/bcm2835-unicam.c   | 2586 +++++++++++++++++
 .../media/platform/bcm2835/vc4-regs-unicam.h  |  253 ++
 13 files changed, 3349 insertions(+), 148 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-imx219.dtsi
 create mode 100644 drivers/media/platform/bcm2835/Kconfig
 create mode 100644 drivers/media/platform/bcm2835/Makefile
 create mode 100644 drivers/media/platform/bcm2835/bcm2835-unicam.c
 create mode 100644 drivers/media/platform/bcm2835/vc4-regs-unicam.h

-- 
2.32.0

