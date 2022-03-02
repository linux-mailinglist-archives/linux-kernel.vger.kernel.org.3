Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF14CB1C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbiCBWIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiCBWIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:08:42 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D8381B2;
        Wed,  2 Mar 2022 14:07:56 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7BAE2E0003;
        Wed,  2 Mar 2022 22:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646258874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lS1QSNcGHjM0XgM4B7WgVQryBpLLi9DEmZbSo/cMOS4=;
        b=Ote3cmIhGhk7KJS0xw+Cs7bF1JY7KqFtTRznRFMQ/c46qky2tYY2cIXY9hVGQhEJmqX9OP
        U4xAt/K0wnm3Pqa/OMt74VIPtie+FSN1/BBxcmCT/JeieyOhACx7AGDMbqF6ZfQypTKlXI
        usISbdehawZc35+D+zq3QOh4KdWaqG3kgnMaMiJ2L0nUcsUrVZHdZKAW7ZeI7sOxN+3a+C
        sxMDAANwX3dg/bf9wWVAXGLuBGBHoOrQBtGnVP/9elpzmk+BxWqR0ZmDFNYA1Rj1sWExcm
        fgILP9116WRqikXUK4tGgq0dRl6u13mSs6phGZvEXLo++mmFwxZXCYauUUJsgg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 0/9] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / MIPI CSI-2 Support
Date:   Wed,  2 Mar 2022 23:07:30 +0100
Message-Id: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new version is an offspring from the big "Allwinner A31/A83T
MIPI CSI-2 Support and A31 ISP Support" series, which was split into
individual series for better clarity and handling.

This part only concerns the MIPI CSI-2 controllers support changes.

Changes since all-in-one v2:
- Use the newly-introduced media/mipi-csi2.h header instead of local
  definitions;
- Introduce a use a mutex for format access serialization;
- Make both port@0 and port@1 as well as ports required in the binding;
- Made one of the two CSI input ports required;

Paul Kocialkowski (9):
  dt-bindings: sun6i-a31-mipi-dphy: Add optional direction property
  phy: allwinner: phy-sun6i-mipi-dphy: Support D-PHY Rx mode for MIPI
    CSI-2
  dt-bindings: media: sun6i-a31-csi: Add MIPI CSI-2 input port
  dt-bindings: media: Add Allwinner A31 MIPI CSI-2 bindings
    documentation
  media: sunxi: Add support for the A31 MIPI CSI-2 controller
  MAINTAINERS: Add entry for the Allwinner A31 MIPI CSI-2 bridge driver
  dt-bindings: media: Add Allwinner A83T MIPI CSI-2 bindings
    documentation
  media: sunxi: Add support for the A83T MIPI CSI-2 controller
  MAINTAINERS: Add entry for the Allwinner A83T MIPI CSI-2 bridge

 .../media/allwinner,sun6i-a31-csi.yaml        |  66 +-
 .../media/allwinner,sun6i-a31-mipi-csi2.yaml  | 147 ++++
 .../media/allwinner,sun8i-a83t-mipi-csi2.yaml | 138 +++
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml    |  12 +
 MAINTAINERS                                   |  16 +
 drivers/media/platform/sunxi/Kconfig          |   2 +
 drivers/media/platform/sunxi/Makefile         |   2 +
 .../platform/sunxi/sun6i-mipi-csi2/Kconfig    |  12 +
 .../platform/sunxi/sun6i-mipi-csi2/Makefile   |   4 +
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c   | 766 ++++++++++++++++
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.h   |  53 ++
 .../sun6i-mipi-csi2/sun6i_mipi_csi2_reg.h     |  76 ++
 .../sunxi/sun8i-a83t-mipi-csi2/Kconfig        |  11 +
 .../sunxi/sun8i-a83t-mipi-csi2/Makefile       |   4 +
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c    |  72 ++
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.h    |  39 +
 .../sun8i_a83t_mipi_csi2.c                    | 833 ++++++++++++++++++
 .../sun8i_a83t_mipi_csi2.h                    |  56 ++
 .../sun8i_a83t_mipi_csi2_reg.h                | 151 ++++
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c   | 166 +++-
 20 files changed, 2609 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-mipi-csi2.yaml
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-mipi-csi2.yaml
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/Kconfig
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/Makefile
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.h
 create mode 100644 drivers/media/platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2_reg.h
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Makefile
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.h
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.h
 create mode 100644 drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2_reg.h

-- 
2.35.1

