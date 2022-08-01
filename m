Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A69587382
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 23:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiHAVrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 17:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiHAVra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 17:47:30 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 006D733A1E;
        Mon,  1 Aug 2022 14:47:28 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,209,1654527600"; 
   d="scan'208";a="129950924"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 06:47:28 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 716E64108B8D;
        Tue,  2 Aug 2022 06:47:23 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/4] Add driver for CSI2 and CRU modules found on Renesas RZ/G2L SoC
Date:   Mon,  1 Aug 2022 22:47:14 +0100
Message-Id: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
* https://www.renesas.com/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en&r=1467981

Currently the driver has been tested using yavta and Gstreamer
on RZ/G2L SMARC EVK using the ov5645 sensor on CSI2 interface
only.

RFC v2: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

RFC v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (4):
  media: dt-bindings: media: Document RZ/G2L CSI-2 block
  media: dt-bindings: media: Document RZ/G2L CRU
  media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
  media: platform: Add Renesas RZ/G2L CRU driver

 .../bindings/media/renesas,rzg2l-cru.yaml     | 142 ++++
 .../bindings/media/renesas,rzg2l-csi2.yaml    | 149 ++++
 drivers/media/platform/renesas/Kconfig        |   1 +
 drivers/media/platform/renesas/Makefile       |   1 +
 .../media/platform/renesas/rzg2l-cru/Kconfig  |  34 +
 .../media/platform/renesas/rzg2l-cru/Makefile |   6 +
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 371 +++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    | 144 ++++
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 702 +++++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.h   |  49 ++
 .../platform/renesas/rzg2l-cru/rzg2l-dma.c    | 728 ++++++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-v4l2.c   | 354 +++++++++
 12 files changed, 2681 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-cru.yaml
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.h
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-dma.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-v4l2.c

-- 
2.25.1

