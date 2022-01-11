Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1021B48B1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbiAKQQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiAKQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:16:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6307FC06173F;
        Tue, 11 Jan 2022 08:16:18 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:14a3:8100:5418:23c4:e539:4c3e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 34B4D1F43A6D;
        Tue, 11 Jan 2022 16:16:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641917776;
        bh=muUEMhPkB5+Mwz9H9LDBDxIwqrYP43WUUDow2/1iw3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=ZdIqIVgD0WQ2GphykMRdLgPdfYMn2WoqS6phci+kJpILWleNoaznlTqgvmoUdDuoG
         oMKsErC9RuWKsAvLjm5fn+HOWVDX+d1kD78nuj4KgT0mGMLaH/5K+BI2afZ6pbYP4U
         72njJJu8z/xil6J+k3VI7325kfqlDtcTXjbm4LxLFCZN3ZETXkX2fFafHz7Queytpx
         1HVSn8owDF75BTdzX66GSKh0aLldE5aozs1ZLVkvw+g92cYDkg3dyA2eenyRfpIYkA
         2uTT/5LMtYkMyklDQwoHnvCNe0SCcGOgAVDm79ib7Roi3qaZjWJHe9QxYorGBmjgYY
         Fwcp/XyWxU4Rw==
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com, bob.beckett@collabora.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        rdunlap@infradead.org, daniel@0x0f.com
Subject: [PATCH v5 0/6] staging: media: wave5: add wave5 codec driver
Date:   Tue, 11 Jan 2022 18:15:58 +0200
Message-Id: <20220111161604.22579-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wave5 codec is a stateful encoder/decoder.
It is found on the JH7100 SoC.

The driver currently supports V4L2_PIX_FMT_HEVC, V4L2_PIX_FMT_H264.

This driver has so far been tested on pre-silicon FPGA and on the beta BeagleV
board which uses the StarFive JH7100 beta SoC.

Testing on FPGA shows it working fine, though the FPGA uses polled interrupts
and copied buffers between the host and it's on board RAM.

Testing on BeagleV shows buffer corruption that is currently attributed to a
known silicon issue in the SoC that makes the cache coherent interconnect not
so coherent.
This can likely be solved when the riscv non-coherent dma support lands and
provide optional v4l2 non-contiguous allocator, though it remains to be seen
whether support non-coherent use cases will be useful in real world hw.

Until we can test and resolve any issues on final silicon (due 2H 2021)
this driver should remain in staging.

We currently tested only the decoder.
Testing the encoder is currently impossible because of the BeagleV buffer problems,
That will need to be tested once we have fixed beaglev buffer problems.

v4l2-compliance tests:

# v4l2-compliance -d0
v4l2-compliance SHA: not available
, 64 bits, 64-bit time_t

Compliance test for vpu-dec device /dev/video0:

Driver Info:
	Driver name      : vpu-dec
	Card type        : vpu-dec
	Bus info         : platform:vpu-dec
	Driver version   : 5.14.0
	Capabilities     : 0x84204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps      : 0x04204000
		Video Memory-to-Memory Multiplanar
		Streaming
		Extended Pix Format
	Detected Stateful Decoder

Required ioctls:
	test VIDIOC_QUERYCAP: OK

Allow for multiple opens:
	test second /dev/video0 open: OK
	test VIDIOC_QUERYCAP: OK
	test VIDIOC_G/S_PRIORITY: OK
	test for unlimited opens: OK

	test invalid ioctls: OK
Debug ioctls:
	test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
	test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
	test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
	test VIDIOC_ENUMAUDIO: OK (Not Supported)
	test VIDIOC_G/S/ENUMINPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDIO: OK (Not Supported)
	Inputs: 0 Audio Inputs: 0 Tuners: 0

Output ioctls:
	test VIDIOC_G/S_MODULATOR: OK (Not Supported)
	test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
	test VIDIOC_ENUMAUDOUT: OK (Not Supported)
	test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
	test VIDIOC_G/S_AUDOUT: OK (Not Supported)
	Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
	test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
	test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
	test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
	test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls:
	test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
	test VIDIOC_QUERYCTRL: OK
	test VIDIOC_G/S_CTRL: OK
	test VIDIOC_G/S/TRY_EXT_CTRLS: OK
	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
	test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
	Standard Controls: 2 Private Controls: 1

Format ioctls:
	test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
	test VIDIOC_G/S_PARM: OK (Not Supported)
	test VIDIOC_G_FBUF: OK (Not Supported)
	test VIDIOC_G_FMT: OK
	test VIDIOC_TRY_FMT: OK
	test VIDIOC_S_FMT: OK
	test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
	test Cropping: OK (Not Supported)
	test Composing: OK
	test Scaling: OK (Not Supported)

Codec ioctls:
	test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
	test VIDIOC_G_ENC_INDEX: OK (Not Supported)
	test VIDIOC_(TRY_)DECODER_CMD: OK

Buffer ioctls:
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
	test VIDIOC_EXPBUF: OK
	test Requests: OK (Not Supported)

Total for vpu-dec device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 0

changes since v4:

* refactor functions in wave5-hw and fix bug reported by Daniel Palmer
* rename functions and variables to better names
* change variable types such as replacing s32 with u32 and int with bool as appropriate

changes since v3:

* Fixing all issues commented by Dan Carpenter
* Change file names to have wave5- prefix
* In wave5_vpu_probe, enable the clocks before reading registers, as commented from Daniel Palmer
* Add more to the TODO list,

changes since v2:

Main fixes includes:
* change the yaml and dirver code to support up to 4 clks (instead of one)
* fix Kconfig format
* remove unneeded cast,
* change var types
* change var names, func names
* checkpatch fixes

changes since v1:

Fix chanes due to comments from Ezequiel and Dan Carpenter. Main fixes inclueds:
* move all files to one dir 'wave5'
* replace private error codes with standart error codes
* fix extra spaces
* various checkpatch fixes
* replace private 'DPRINTK' macro with standart 'dev_err/dbg ..'
* fix error handling
* add more possible fixes to the TODO file


Dafna Hirschfeld (4):
  staging: media: wave5: Add vpuapi layer
  staging: media: wave5: Add the vdi layer
  staging: media: wave5: Add the v4l2 layer
  staging: media: wave5: Add TODO file

Robert Beckett (2):
  dt-bindings: media: staging: wave5: add yaml devicetree bindings
  media: wave5: Add wave5 driver to maintainers file

 .../bindings/staging/media/cnm,wave.yaml      |   73 +
 MAINTAINERS                                   |    9 +
 drivers/staging/media/Kconfig                 |    2 +
 drivers/staging/media/Makefile                |    1 +
 drivers/staging/media/wave5/Kconfig           |   12 +
 drivers/staging/media/wave5/Makefile          |   10 +
 drivers/staging/media/wave5/TODO              |   64 +
 drivers/staging/media/wave5/wave5-hw.c        | 3442 +++++++++++++++++
 drivers/staging/media/wave5/wave5-regdefine.h |  650 ++++
 drivers/staging/media/wave5/wave5-vdi.c       |  260 ++
 drivers/staging/media/wave5/wave5-vdi.h       |   81 +
 drivers/staging/media/wave5/wave5-vpu-dec.c   | 1343 +++++++
 drivers/staging/media/wave5/wave5-vpu-enc.c   | 1499 +++++++
 drivers/staging/media/wave5/wave5-vpu.c       |  358 ++
 drivers/staging/media/wave5/wave5-vpu.h       |   73 +
 drivers/staging/media/wave5/wave5-vpuapi.c    | 1050 +++++
 drivers/staging/media/wave5/wave5-vpuapi.h    | 1141 ++++++
 drivers/staging/media/wave5/wave5-vpuconfig.h |   84 +
 drivers/staging/media/wave5/wave5-vpuerror.h  |  455 +++
 drivers/staging/media/wave5/wave5.h           |   82 +
 20 files changed, 10689 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/media/cnm,wave.yaml
 create mode 100644 drivers/staging/media/wave5/Kconfig
 create mode 100644 drivers/staging/media/wave5/Makefile
 create mode 100644 drivers/staging/media/wave5/TODO
 create mode 100644 drivers/staging/media/wave5/wave5-hw.c
 create mode 100644 drivers/staging/media/wave5/wave5-regdefine.h
 create mode 100644 drivers/staging/media/wave5/wave5-vdi.c
 create mode 100644 drivers/staging/media/wave5/wave5-vdi.h
 create mode 100644 drivers/staging/media/wave5/wave5-vpu-dec.c
 create mode 100644 drivers/staging/media/wave5/wave5-vpu-enc.c
 create mode 100644 drivers/staging/media/wave5/wave5-vpu.c
 create mode 100644 drivers/staging/media/wave5/wave5-vpu.h
 create mode 100644 drivers/staging/media/wave5/wave5-vpuapi.c
 create mode 100644 drivers/staging/media/wave5/wave5-vpuapi.h
 create mode 100644 drivers/staging/media/wave5/wave5-vpuconfig.h
 create mode 100644 drivers/staging/media/wave5/wave5-vpuerror.h
 create mode 100644 drivers/staging/media/wave5/wave5.h

-- 
2.17.1

