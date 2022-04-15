Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917A5502D30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355534AbiDOPk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355516AbiDOPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:40:06 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D743C72F;
        Fri, 15 Apr 2022 08:37:17 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ED909240006;
        Fri, 15 Apr 2022 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650037035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kXBDK8xo31Siszz9mdQu0RpXYIzmlLJyUEJsWA4vLkA=;
        b=JBhAze1ahVizW7R+goEcOR/IGfDIuv6Y3R8FisdEI09kZT8Tx81cDJIx9cUuiRpWdWc1eI
        wynmFiji49Jmv+S6xfgFMhNJBF9l79sggXq2K40rl20ZKNLB2k2DYhvQPNwVw51/TJ7q/E
        fagPCbQ+CplZz2d0FT9y/Fr/z3ioNZkPyXPnINbHJLkuf28n2ph6sSXvITgQIxn9tVhDP5
        Ut/bQoDvp+J6vVY4gKE9pwFcWoPm681B3uTWhwktYK/wPzw+QkxbUUMTh6B6cYoD5uoIDG
        oHlzA/RK36FlbXF4AbXwGoXm+ifYyg9LSIbkiz6f4lYPFCwKL7W2vnZ0z8YQ1g==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 0/4] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / ISP Driver
Date:   Fri, 15 Apr 2022 17:37:04 +0200
Message-Id: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
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

This part only concerns the introduction of the new ISP driver.

Changes since all-in-one v2:
- Updated Kconfig to follow the latest media-wide changes;
- Reworked async subdev handling with a dedicated structure holding the
  corresponding source to avoid matching in the driver;
- Switched to clock-managed regmap mmio;
- Used helper to get a single enabled link for an entity's pad, to replace
  source selection at link_validate time and select the remote source at
  stream on time instead;
- Added mutex for mbus format serialization;
- Used endpoint-base instead of video-interface for "internal" endpoints
  in device-tree schema;
- Added TODO with unstaging requirements;
- Various cosmetic cleanups;
- Updated copyright years;

Paul Kocialkowski (4):
  dt-bindings: media: Add Allwinner A31 ISP bindings documentation
  dt-bindings: media: sun6i-a31-csi: Add ISP output port
  staging: media: Add support for the Allwinner A31 ISP
  MAINTAINERS: Add entry for the Allwinner A31 ISP driver

 .../media/allwinner,sun6i-a31-csi.yaml        |  14 +
 .../media/allwinner,sun6i-a31-isp.yaml        | 117 +++
 MAINTAINERS                                   |   9 +
 drivers/staging/media/sunxi/Kconfig           |   1 +
 drivers/staging/media/sunxi/Makefile          |   1 +
 drivers/staging/media/sunxi/sun6i-isp/Kconfig |  15 +
 .../staging/media/sunxi/sun6i-isp/Makefile    |   4 +
 .../staging/media/sunxi/sun6i-isp/TODO.txt    |   6 +
 .../staging/media/sunxi/sun6i-isp/sun6i_isp.c | 556 +++++++++++++
 .../staging/media/sunxi/sun6i-isp/sun6i_isp.h |  85 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 749 ++++++++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.h |  78 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_params.c  | 573 ++++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_params.h  |  52 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 578 ++++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  66 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
 .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
 18 files changed, 3222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Kconfig
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Makefile
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/TODO.txt
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h

-- 
2.35.2

