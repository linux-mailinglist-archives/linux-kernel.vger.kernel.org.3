Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FC25A2E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiHZSdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiHZSdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:10 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F8E39A3;
        Fri, 26 Aug 2022 11:33:08 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7BBD5FF80A;
        Fri, 26 Aug 2022 18:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rgiedVDI26uxmOnUF2UJgB4eZJ7cOZaNiQBMvaYqW4s=;
        b=gLIsTM5NxKI2dhCCbY6x/kJwmqWh7nX4eiERnxLo0f4e2Fb5AAFJvBHAT6B8S5qVcnKTlm
        4kGogzau17hKqgQu7A2rvhbDfndrkn7EMb0PiAO4XM+g+U2ZSFHmNrKIX/14O2bMflC7X9
        ZqpQ67aWYkIXzuJl4GnZfCTljC0iMILA2Ecp7bkbmCM4dMViwM4B17dp0oaNNjodZKHWVf
        8cuJy+S900u9Zxi3UjaOzOUWjKb5bc7fkbSJPJyNgNZa8UGBLGtm7txb+qn2M0g15BihgO
        2my+02U0yZ2lMEo4QP7xRnVOLOvdBVtLMCTCXElvCaM/D4MGzmdcgjw3V05q0g==
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
Subject: [PATCH v6 00/43] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / CSI Rework
Date:   Fri, 26 Aug 2022 20:31:57 +0200
Message-Id: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This part only concerns the rework of the CSI driver to support the MIPI CSI-2
and ISP workflows.

Very few patches have not received any review at this point and the whole
thing looks good to go. Since this multi-part series has been going on for a
while, it would be great to see it merged soon!

Changes since v5:
- Rebased on latest media tree;
- Switched to using media_pad_remote_pad_first;
- Switched to using media_pad_remote_pad_unique.

Changes since v4:
- Removed the v4l2 controls handler from the driver;
- Removed the info message about video device registration;
- Fixed "literature" typos;
- Moved patches dependent on the ISP driver to its dedicated series;
- Rebased on the latest media tree;
- Added collected tags;

Changes since v3:
- Updated Kconfig to follow the latest media-wide changes;
- Rebased on latest changes to the driver (JPEG/sRGB colorspaces);
- Added helper to get a single enabled link for an entity's pad, to replace
  source selection at link_validate time and select the remote source at
  stream on time instead;
- Kept clock-managed regmap mmio;
- Added collected review tags;
- Various cosmetic cleanups;

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

Paul Kocialkowski (43):
  media: sun6i-csi: Define and use driver name and (reworked)
    description
  media: sun6i-csi: Refactor main driver data structures
  media: sun6i-csi: Tidy up platform code
  media: sun6i-csi: Always set exclusive module clock rate
  media: sun6i-csi: Define and use variant to get module clock rate
  media: sun6i-csi: Use runtime pm for clocks and reset
  media: sun6i-csi: Tidy up Kconfig
  media: sun6i-csi: Tidy up v4l2 code
  media: sun6i-csi: Tidy up video code
  media: sun6i-csi: Pass and store csi device directly in video code
  media: sun6i-csi: Register the media device after creation
  media: sun6i-csi: Remove controls handler from the driver
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
  media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
  media: sun6i-csi: Cleanup headers and includes, update copyright lines
  media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
  media: sun6i-csi: Only configure capture when streaming
  media: sun6i-csi: Add extra checks to the interrupt routine
  media: sun6i-csi: Request a shared interrupt
  MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry

 MAINTAINERS                                   |   17 +-
 .../media/platform/sunxi/sun6i-csi/Kconfig    |   12 +-
 .../media/platform/sunxi/sun6i-csi/Makefile   |    2 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 1027 ++++------------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  149 +--
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        |  844 +++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |   69 ++
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 1089 +++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   88 ++
 .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  |  362 +++---
 .../platform/sunxi/sun6i-csi/sun6i_video.c    |  685 -----------
 .../platform/sunxi/sun6i-csi/sun6i_video.h    |   38 -
 12 files changed, 2551 insertions(+), 1831 deletions(-)
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
 delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
 delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h

-- 
2.37.1

