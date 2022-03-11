Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872854D6394
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349404AbiCKOg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiCKOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:36:57 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398AA1C8D93;
        Fri, 11 Mar 2022 06:35:53 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BADB9240012;
        Fri, 11 Mar 2022 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XT+M29uVA0vJ1WSKa+wbExMQdXBbv2jocdFEg0seS+M=;
        b=Cy+Kn6dBk6RepjY0iXSK5OBNQ3WeErvF+tgHZwZqmSxJwCGjI1zfYF5poSCECorUyeoSbY
        ZxFyq6FuOlExsdLnPajNiLaGPZtpPxJ3ozPQdNLoh6i9JYEIAXeTTWyRi8dyVRy82xXJ2O
        CeLAbA2ysa6a0HvHwxMTqxf6Bf67PJopc/PYJTJoI0IlrHhJiQ6l4oTE8RPkvaC8eCcdF2
        zJarh3J2do+KObPD2Y4zXsGTmdWpcqBKKXb3ua3jS0diMn7QqRR9cGBJOYcltUwMOmPeAv
        jtcJv8gr6a7cGaz7kQO4vZFdU42LhZkmqo/tC6YbqIjtQV+xv0X+hC+kGjuYCw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 00/46] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / CSI Rework
Date:   Fri, 11 Mar 2022 15:34:46 +0100
Message-Id: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
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

This part only concerns the rework of the CSI driver to support the MIPI CSI-2
and ISP workflows.

Changes since all-in-one v2:
- Reworked capture video device registration, which stays in the main path.
- Reworked async subdev handling with a dedicated structure holding the
  corresponding source to avoid matching in the driver;
- Added mutex for mbus format serialization;
- Remove useless else in link_validate;
- Reworked commit logs to include missing information;
- Cleaned up Kconfig, added PM dependency;
- Moved platform-specific clock rate to of match data;
- Added collected Reviewed-by tags;
- Updated copyright years;

Paul Kocialkowski (46):
  media: sun6i-csi: Define and use driver name and (reworked)
    description
  media: sun6i-csi: Refactor main driver data structures
  media: sun6i-csi: Grab bus clock instead of passing it to regmap
  media: sun6i-csi: Tidy up platform code
  media: sun6i-csi: Always set exclusive module clock rate
  media: sun6i-csi: Define and use variant to get module clock rate
  media: sun6i-csi: Use runtime pm for clocks and reset
  media: sun6i-csi: Tidy up Kconfig
  media: sun6i-csi: Tidy up v4l2 code
  media: sun6i-csi: Tidy up video code
  media: sun6i-csi: Pass and store csi device directly in video code
  media: sun6i-csi: Register the media device after creation
  media: sun6i-csi: Add media ops with link notify callback
  media: sun6i-csi: Introduce and use video helper functions
  media: sun6i-csi: Move csi buffer definition to main header file
  media: sun6i-csi: Add bridge v4l2 subdev with port management
  media: sun6i-csi: Rename sun6i_video to sun6i_csi_capture
  media: sun6i-csi: Add capture state using vsync for page flip
  media: sun6i-csi: Rework register definitions, invert misleading
    fields
  media: sun6i-csi: Add dimensions and format helpers to capture
  media: sun6i-csi: Implement address configuration without indirection
  media: sun6i-csi: Split stream sequences and irq code in capture
  media: sun6i-csi: Move power management to runtime pm in capture
  media: sun6i-csi: Move register configuration to capture
  media: sun6i-csi: Rework capture format management with helper
  media: sun6i-csi: Remove custom format helper and rework configure
  media: sun6i-csi: Add bridge dimensions and format helpers
  media: sun6i-csi: Get mbus code from bridge instead of storing it
  media: sun6i-csi: Tidy capture configure code
  media: sun6i-csi: Introduce bridge format structure, list and helper
  media: sun6i-csi: Introduce capture format structure, list and helper
  media: sun6i-csi: Configure registers from format tables
  media: sun6i-csi: Introduce format match structure, list and helper
  media: sun6i-csi: Implement capture link validation with logic
  media: sun6i-csi: Get bridge subdev directly in capture stream ops
  media: sun6i-csi: Move hardware control to the bridge
  media: sun6i-csi: Unset bridge source on capture streamon fail
  media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
  media: sun6i-csi: Cleanup headers and includes, update copyright lines
  media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
  media: sun6i-csi: Only configure capture when streaming
  media: sun6i-csi: Add extra checks to the interrupt routine
  media: sun6i-csi: Request a shared interrupt
  media: sun6i-csi: Detect the availability of the ISP
  media: sun6i-csi: Add support for hooking to the isp devices
  MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry

 MAINTAINERS                                   |   17 +-
 .../media/platform/sunxi/sun6i-csi/Kconfig    |    9 +-
 .../media/platform/sunxi/sun6i-csi/Makefile   |    2 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 1086 +++++-----------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  154 +--
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        |  883 +++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |   70 ++
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 1102 +++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   89 ++
 .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  |  362 +++---
 .../platform/sunxi/sun6i-csi/sun6i_video.c    |  681 ----------
 .../platform/sunxi/sun6i-csi/sun6i_video.h    |   38 -
 12 files changed, 2688 insertions(+), 1805 deletions(-)
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
 delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
 delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h

-- 
2.35.1

