Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B061B5343FA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbiEYTM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344453AbiEYTMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:12:32 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98E81A07C;
        Wed, 25 May 2022 12:10:41 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C89B2FF803;
        Wed, 25 May 2022 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PQC9Sc/fmXfMeEKGF0+n+R+Yzuj2PvCgKGsrOFaydtQ=;
        b=IwX7fmlUhtoU7Ifnvlx4QQCCVBLa1+/kyhtH7CMgLbaGscHfD/L6WFKTcLhPRkgIvfCbP2
        OaRM5bbNhyWdQrPubFbhm/SA9tEe2PIU5FDMhwuZakBXRNm5cbRUe/a1ZIZM5sbtPFeo7G
        ilAkgEjXP0BMC1TF3mlfF2xfo0FB+K/dsBccw+x8AAE4fGcwoFdfip4QSDKPsvJi2TZBqP
        cMrYGS/tuCOB4J39//WoNxjkP/8W1DzRFeGv0U1QwyKExh3pPRCNTlKsEq4WitdpnEeoeG
        bdn0qA5QmBAtIdI8Od1D905mmNK0JBD6OMwSJD7vsArtWujNHlTeQQGBjIw8cA==
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
Subject: [PATCH v4 0/6] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / ISP Driver
Date:   Wed, 25 May 2022 21:10:20 +0200
Message-Id: <20220525191026.696636-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new version is an offspring from the big "Allwinner A31/A83T
MIPI CSI-2 Support and A31 ISP Support" series, which was split into
individual series for better clarity and handling.

This part only concerns the introduction of the new ISP driver.

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
 .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 578 ++++++++++++++
 .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  66 ++
 .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
 .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
 23 files changed, 3305 insertions(+), 13 deletions(-)
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
2.36.1

