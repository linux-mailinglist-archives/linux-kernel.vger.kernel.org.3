Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF645495F85
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350566AbiAUNOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:14:45 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:38416 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380598AbiAUNOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642770883; x=1674306883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ReEeyKlw3Br3MVtTng1dDKMNcyqh3/EtMacl1TY/yr0=;
  b=p20HBqNOMM7P5p9DkTPs7UtJAAYOGCEtTulIalOSMvfnzn1bRZEtMbeI
   zsVpiWQ1WwNW1Am3QsOxulO6QSierp3oM8p0OnbTyBOmN/HvDHflgWp3d
   7B9hs2XndUOIOlmedwQ7v2Nd6VG0b2A2Jne7MYL+R5SSnGVYOwSPlIZB6
   vxTdmkyGSwbXkLJydT/tBVYZSw1SC98H/l+0fQ0y0bzKnMkrwfvMIA/Lb
   d2DlNXw4gwkp576YbyX4kVZ/xyv+a/aO8LTucuibQeQUsA30y1u4tETZ5
   RcTcNLCVRfruYceLUtRhlRCy8W5q/ddsEVttIbqqECtWb+uTH1LjDNIH8
   Q==;
IronPort-SDR: OxQNeC6cb/ggLpPj4XDjUiAHEqfNXLQNKYBnGmntA4sME/6DZmiZu9o/pKT+XtXa8/cHqHP5NC
 m0UIW4r7owRGOONHM2SwRatgOrFn2o9nZBGRKj7ToN9q1fqpqZcN0IPS1Ygc8kwF5iCcYBJnC2
 KnZ5QeBL2UAsVLlzUmUfHDKL4sNgz0jqVhEEo7wiqXTX4ffbvKGMyvIgYDQa8ryqqxLT2fGs6c
 y7ILWo4Y/GFgQefkcckvbCIt1DR3h3z9/3khQsUQUZdyJLF1neUoH3t4i+XAb4N3xTkJicwPC9
 PsW2Y0rTN92QI7lIbZgPgL+S
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="150454000"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:14:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:14:41 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:14:25 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 00/11] media: atmel: atmel-isc: implement media controller
Date:   Fri, 21 Jan 2022 15:14:05 +0200
Message-ID: <20220121131416.603972-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series is the v4 series that attempts to support media controller in the
atmel ISC and XISC drivers.
The CSI2DC driver was accepted thus removed from the patch series, together with
other patches.

Important note: this series applies on top of current media_staging tree, as it
relies on previous patches in the series which were accepted.

Changes in v4:
-> as reviewed by Hans, added new patch to remove the 'stop' variable and reworked
one patch that was using it
-> as reviewed by Jacopo, reworked some parts of the media controller implementation

Thanks to everyone who reviewed my work !

Eugen


Previous cover letter from v3:

This series is the v3 of the series that attempts to support media controller
in the atmel ISC and XISC drivers.
This series also includes the csi2dc driver which was previously sent in a
separate series:
https://www.spinics.net/lists/linux-media/msg181042.html
https://www.spinics.net/lists/linux-media/msg181044.html
The driver now addresses comments received in latest v5 series from last year.

The series includes some minor changes and fixes that improve the isc common
code base, like removing the enum frameintervals VIDIOC, fixing bytesperline
for planar formats, etc.

Many thanks to folks from libcamera who helped a lot with understanding
how a media controller driver should behave.

Feedback is welcome !

Changes in v3:
- change in bindings, small fixes in csi2dc driver and conversion to mc
for the isc-base.
- removed some MAINTAINERS patches and used patterns in MAINTAINERS

Changes in v2:
- integrated many changes suggested by Jacopo in the review of the v1 series.
- add a few new patches


Eugen Hristev (11):
  media: atmel: atmel-isc: replace 'stop' variable with vb2 calls
  media: atmel: atmel-isc-base: use streaming status when queueing
    buffers
  media: atmel: atmel-isc: implement media controller
  media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
  media: atmel: atmel-isc-base: use mutex to lock awb workqueue from
    streaming
  media: atmel: atmel-isc: compact the controller formats list
  media: atmel: atmel-isc: change format propagation to subdev into only
    verification
  dt-bindings: media: microchip,xisc: add bus-width of 14
  ARM: dts: at91: sama7g5: add nodes for video capture
  ARM: configs: at91: sama7: add xisc and csi2dc
  ARM: multi_v7_defconfig: add atmel video pipeline modules

 .../bindings/media/microchip,xisc.yaml        |   2 +-
 arch/arm/boot/dts/sama7g5.dtsi                |  49 ++
 arch/arm/configs/multi_v7_defconfig           |   3 +
 arch/arm/configs/sama7_defconfig              |   2 +
 drivers/media/platform/atmel/Makefile         |   2 +-
 drivers/media/platform/atmel/atmel-isc-base.c | 455 +++++++++++-------
 .../media/platform/atmel/atmel-isc-scaler.c   | 250 ++++++++++
 drivers/media/platform/atmel/atmel-isc.h      |  43 +-
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  67 ++-
 .../media/platform/atmel/atmel-sama7g5-isc.c  |  72 ++-
 10 files changed, 694 insertions(+), 251 deletions(-)
 create mode 100644 drivers/media/platform/atmel/atmel-isc-scaler.c

-- 
2.25.1

