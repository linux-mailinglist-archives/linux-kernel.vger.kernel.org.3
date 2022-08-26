Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1D5A2F33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbiHZSqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345423AbiHZSpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:45:51 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260EAE86A6;
        Fri, 26 Aug 2022 11:42:15 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6B82C40004;
        Fri, 26 Aug 2022 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661539324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+nlMaXlRJAOi+45N8WL10NSAt140nch8RLHZiELGrL0=;
        b=enPLVPZCnXb3DvBnzPM5mjuGqCiJTS2TDSxNj4y9a0TXii9/qKGzhdaI160bTzuzbqVAHF
        nBJxyu69f5eEwUk7PGMgldHf/zDB7fSsYePUfIOK803v5EZ03rlUi+jVDSbcfaUqNdFGwn
        vPv4GkLmxEQd7cSnFWY57QVvCVm4o1bpckRaSJZSTfpmRVcv5ZSYuBngc1gIqV/mpdN4M4
        s2I2AN2F4pns5hcy4Q9Itfnt+lYCmPtGejE6KWB+J8USo09NxgB0kxpCr8w84YAZ5NLLfq
        I4F1FPrYlXcqwlSgLRcbWfVk9hNHDQCnhgTikI8cBguSKYPk1lMsvumJtBAfhQ==
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
Subject: [PATCH v6 0/6] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / ISP Driver
Date:   Fri, 26 Aug 2022 20:41:38 +0200
Message-Id: <20220826184144.605605-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This part only concerns the introduction of the new ISP driver and related
adaptation of the CSI driver.

Most non-dt patches still need reviewing but should be pretty straightforward. 
Since this multi-part series has been going on for a while, it would be great
to see it merged soon!

Changes since v5:
- Rebased on latest media tree;
- Added collected tag;
- Switched to using media_pad_remote_pad_first;
- Switched to using media_pad_remote_pad_unique.

Changes since v4:
- Fixed device-tree binding indent-align;
- Added collected tag;
- Rebased on latest media tree;

Changes since v3:
- Removed the v4l2 controls handler from the driver;
- Added variant structure for table sizes;
- Removed the info message about video device registration;
- Removed comments in uAPI header;
- Used '/schemas/graph.yaml#/properties/port' whenever possible in bindings;
- Added CSI patches dependent on the ISP driver;
- Rebased on the latest media tree;

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

Paul Kocialkowski (6):
  dt-bindings: media: Add Allwinner A31 ISP bindings documentation
  dt-bindings: media: sun6i-a31-csi: Add ISP output port
  staging: media: Add support for the Allwinner A31 ISP
  MAINTAINERS: Add entry for the Allwinner A31 ISP driver
  media: sun6i-csi: Detect the availability of the ISP
  media: sun6i-csi: Add support for hooking to the isp devices

 .../media/allwinner,sun6i-a31-csi.yaml        |   4 +
 .../media/allwinner,sun6i-a31-isp.yaml        |  97 +++
 MAINTAINERS                                   |   9 +
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  74 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  10 +
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        |  32 +-
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       |  19 +-
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   1 +
 drivers/staging/media/sunxi/Kconfig           |   1 +
 drivers/staging/media/sunxi/Makefile          |   1 +
 drivers/staging/media/sunxi/sun6i-isp/Kconfig |  15 +
 .../staging/media/sunxi/sun6i-isp/Makefile    |   4 +
 .../staging/media/sunxi/sun6i-isp/TODO.txt    |   6 +
 .../staging/media/sunxi/sun6i-isp/sun6i_isp.c | 555 +++++++++++++
 .../staging/media/sunxi/sun6i-isp/sun6i_isp.h |  90 +++
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 742 ++++++++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.h |  78 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_params.c  | 566 +++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_params.h  |  52 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 577 ++++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  66 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
 .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
 23 files changed, 3304 insertions(+), 13 deletions(-)
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
2.37.1

