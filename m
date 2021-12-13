Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728CE472DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhLMNuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:50:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:24085 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhLMNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403407; x=1670939407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H78wXTXXuw8PaU+PgD8S4+N9qMEmQIjcQi7EIS13OcA=;
  b=yAcDLR2+ZNkdI/n9s1QhHY8T1P9fAKk9kfCoTyrU+Dw5qgCmeaHif6NU
   9EJHmOnIfTQYCjpyIwjF+dBAm2Tvei1szdacdjQReaxXchUeAoJbyygAv
   2EA60+SgSdRVoY62f3iYhchMVFGdHWpMYtAPoGj2zB3u1XdNyWYUc9E8g
   y+52vTnQxpKIP3S9fCQGocnOHhTfMVcE0a9/oQ394aVcJ54z6t3OxHFvt
   1M1wi8Do49tSg7BsSbjTLqDpKi9UXr322se8bUoQXuhuQAFMztehtif/X
   vk7l2jfgnvaPVlxOonkzkUDk1dha58buGXN82hjMnI4/mEIKZxyI925mo
   A==;
IronPort-SDR: eWBff/uRDr2Z5xSKXWdtV1ZbhOTVSwHfufL4EFuH6rV3LSBYs/2Y7mmbWuEvZX3Fg+3X4cP14b
 eRYmrwfriQnxSg3qVgGgUaND0SlIvz1rfWNjtEJBzrlV1nRaYMy1eWZJB/yjQ/fBGyYgfbti83
 HvEqpg2weyjCC+j9oJmBN9KgSeNSZigONOIlee9jsDC0EWvQA05rd6QLDa3CwB1B3Fql0c52wu
 PQsiibf2mdlzwGrKpxLdpcN5XHNHetgHYqwnnLiEbyFIbFTNXuCda9MEZoAS8+Dd2BMg4YDMnd
 hdDWRTv/cmCt7cXAhmQRpyQs
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="139571324"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:50:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:50:06 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:49:54 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 00/23] media: atmel: atmel-isc: implement media controller
Date:   Mon, 13 Dec 2021 15:49:17 +0200
Message-ID: <20211213134940.324266-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


Eugen Hristev (23):
  MAINTAINERS: add microchip csi2dc
  dt-bindings: media: atmel: csi2dc: add bindings for microchip csi2dc
  media: atmel: introduce microchip csi2dc driver
  media: atmel: atmel-isc: split the clock code into separate source
    file
  media: atmel: atmel-isc: replace video device name with module name
  media: atmel: atmel-sama7g5-isc: fix ispck leftover
  media: atmel: atmel-isc-base: use streaming status when queueing
    buffers
  media: atmel: atmel-isc-base: remove frameintervals VIDIOC
  media: atmel: atmel-isc-base: report frame sizes as full supported
    range
  media: atmel: atmel-isc-base: implement mbus_code support in enumfmt
  media: atmel: atmel-isc-base: fix bytesperline value for planar
    formats
  media: atmel: atmel-isc: implement media controller
  ARM: dts: at91: sama7g5: add nodes for video capture
  ARM: configs: at91: sama7: add xisc and csi2dc
  ARM: multi_v7_defconfig: add atmel video pipeline modules
  media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
  media: atmel: atmel-isc-base: use mutex to lock awb workqueue from
    streaming
  media: atmel: atmel-isc-base: add wb debug messages
  media: atmel: atmel-isc-base: clamp wb gain coefficients
  media: atmel: atmel-sama7g5-isc: fix UYVY input format mbus_code typo
  media: atmel: atmel-isc: add raw Bayer 8bit 10bit output formats
  media: atmel: atmel-isc: compact the controller formats list
  media: atmel: atmel-isc: change format propagation to subdev into only
    verification

 .../bindings/media/microchip,csi2dc.yaml      | 197 +++++
 MAINTAINERS                                   |  14 +-
 arch/arm/boot/dts/sama7g5.dtsi                |  48 ++
 arch/arm/configs/multi_v7_defconfig           |   3 +
 arch/arm/configs/sama7_defconfig              |   2 +
 drivers/media/platform/Makefile               |   1 +
 drivers/media/platform/atmel/Kconfig          |  15 +
 drivers/media/platform/atmel/Makefile         |   4 +-
 drivers/media/platform/atmel/atmel-isc-base.c | 790 ++++++-----------
 drivers/media/platform/atmel/atmel-isc-clk.c  | 311 +++++++
 drivers/media/platform/atmel/atmel-isc-mc.c   | 287 +++++++
 drivers/media/platform/atmel/atmel-isc.h      |  49 ++
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  59 +-
 .../media/platform/atmel/atmel-sama7g5-isc.c  |  72 +-
 .../media/platform/atmel/microchip-csi2dc.c   | 806 ++++++++++++++++++
 15 files changed, 2085 insertions(+), 573 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
 create mode 100644 drivers/media/platform/atmel/atmel-isc-clk.c
 create mode 100644 drivers/media/platform/atmel/atmel-isc-mc.c
 create mode 100644 drivers/media/platform/atmel/microchip-csi2dc.c

-- 
2.25.1

