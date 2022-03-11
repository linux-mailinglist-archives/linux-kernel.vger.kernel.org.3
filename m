Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BF84D638B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349498AbiCKOhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349445AbiCKOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:12 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E310F1C8D9E;
        Fri, 11 Mar 2022 06:36:04 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 231D1240018;
        Fri, 11 Mar 2022 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fk7QR84y0sUuiS1RoyQ7eIcmi41dnOp0E0reQwiR4Y=;
        b=klA4LHBqU+S1tB1GBVhZWxLtLS8l/ivVVfPxo+IjngltmmmlgVFKjQHjbj6NLaVuaWoxUI
        KnXVce1WhmrJCQm+jq+dPo7tt6H2Zm8XqdmTSMPWA5lEKJuLHpYfr/s87577gaUKs4ejU5
        LVLjAxMIOop6IH4TLF69M8wMQyaRmmHAIuLLQgp2sjQocLaKPd5gjuoOQbBg6pp+weYitS
        /EE64V80kiGqb+31UyNO3OhjMhV22foqzJ+TkOt6ivrKQUkaIKNIoO/zQ8fl9K4toIS1lb
        Kyh2iDqGggN5C0ILIqnW1hbA0nlaGM95wbQYsLClW5pnEVS7uLDFzmlC2QYVww==
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
Subject: [PATCH v3 08/46] media: sun6i-csi: Tidy up Kconfig
Date:   Fri, 11 Mar 2022 15:34:54 +0100
Message-Id: <20220311143532.265091-9-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
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

Update the option title and help, group related options together,
add dependency on VIDEO_DEV since the driver uses it.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
index fd03e48f0c8a..a88978eba455 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
+++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
@@ -1,12 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_SUN6I_CSI
-	tristate "Allwinner V3s Camera Sensor Interface driver"
-	depends on PM && VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
+	tristate "Allwinner A31 Camera Sensor Interface (CSI) Driver"
 	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on PM && COMMON_CLK && HAS_DMA
+	depends on VIDEO_DEV && VIDEO_V4L2
+	select REGMAP_MMIO
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_DMA_CONTIG
-	select REGMAP_MMIO
 	select V4L2_FWNODE
 	help
-	   Support for the Allwinner Camera Sensor Interface Controller on V3s.
+	   Support for the Allwinner A31 Camera Sensor Interface (CSI) controller.
-- 
2.35.1

