Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3958F49578C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 02:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiAUBGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 20:06:04 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:28300 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229499AbiAUBGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:06:03 -0500
X-IronPort-AV: E=Sophos;i="5.88,303,1635174000"; 
   d="scan'208";a="107750887"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Jan 2022 10:06:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8F397417762A;
        Fri, 21 Jan 2022 10:05:58 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH v2 0/4] Add driver for Renesas RZ/G2L CRU module
Date:   Fri, 21 Jan 2022 01:05:39 +0000
Message-Id: <20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series aims to add driver support to CRU module found
on Renesas RZ/G2L SoC.

The Camera Data Receiving Unit (CRU) consists of a MIPI CSI-2
block and an Image Processing block. The Image Processing block
can receive video data received from the external Digital Parallel
Interface or MIPI CSI-2 block, and perform appropriate image
processing for each.

More details:
* https://renesas.info/wiki/File:CRU.png
* https://www.renesas.com/document/mah/
  rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en&r=1467981

Currently the driver has been tested using yavta and Gstreamer
on RZ/G2L SMARC EVK using the ov5645 sensor on CSI2 interface
only.

Patches are dependent on millstream series [0] and subdev active state series [1].

[0] https://lore.kernel.org/linux-media/20211130141536.891878-1-tomi.valkeinen@ideasonboard.com/T/#t
[1] https://lore.kernel.org/linux-media/20211217135022.364954-1-tomi.valkeinen@ideasonboard.com/T/#t

v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (4):
  media: dt-bindings: media: Document RZ/G2L CSI-2 block
  media: dt-bindings: media: Document RZ/G2L CRU
  media: platform: Add CRU driver for RZ/G2L SoC
  media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver

 .../bindings/media/renesas,rzg2l-cru.yaml     | 152 +++
 .../bindings/media/renesas,rzg2l-csi2.yaml    | 151 +++
 drivers/media/platform/Kconfig                |   1 +
 drivers/media/platform/Makefile               |   2 +
 .../media/platform/renesas/rzg2l-cru/Kconfig  |  28 +
 .../media/platform/renesas/rzg2l-cru/Makefile |   5 +
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 432 ++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    | 155 +++
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 928 ++++++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-dma.c    | 722 ++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-v4l2.c   | 360 +++++++
 11 files changed, 2936 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c

-- 
2.17.1

