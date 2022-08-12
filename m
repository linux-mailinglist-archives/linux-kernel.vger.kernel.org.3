Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94235591711
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiHLWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiHLWBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:01:10 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC8AEDAC;
        Fri, 12 Aug 2022 15:01:08 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7582EC0007;
        Fri, 12 Aug 2022 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1660341667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsomnsM80ehFPqrwMjxRQ7MtpNN6QrCkAADG++xJ8Rc=;
        b=puIxzmFdKCqOMlJfFosFD0nzwqxaZSqgkP5wv8YwvSXtW1vTWZTeCg07teFkaDwoM67CES
        tHpa85ai5e/dVH74y7gBkYudkpM+zCy0jCkRi8Bz/w9eLBFixPurJ1w9kqP4IyP3+mgavl
        Hp8bOv03shRd/7o2q0Cyqj0wnk7jSxIt1c2LOiZSlpLYUjE7OAFxtb7oRqbtHBI4ou850W
        Q9mGsncNv3uG9uHgTrXc1hiJy0fZhVPGTc4yScWka91LaFeyfx9gL2kavEalNnBP0pqGfL
        vc6PWRxy5Rx9XhiOMjSp+3fdnN4DYDYizNcr2YJR56l6q5UDcbLMaqg23eRqtQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 4/6] media: sun4i-csi: Add a Kconfig dependency on RESET_CONTROLLER
Date:   Sat, 13 Aug 2022 00:00:43 +0200
Message-Id: <20220812220045.800820-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812220045.800820-1-paul.kocialkowski@bootlin.com>
References: <20220812220045.800820-1-paul.kocialkowski@bootlin.com>
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

The driver relies on the reset controller API to work, so add
RESET_CONTROLLER as one of its Kconfig dependencies.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun4i-csi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun4i-csi/Kconfig b/drivers/media/platform/sunxi/sun4i-csi/Kconfig
index 7960e6836f41..60610c04d6a7 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/Kconfig
+++ b/drivers/media/platform/sunxi/sun4i-csi/Kconfig
@@ -3,7 +3,7 @@
 config VIDEO_SUN4I_CSI
 	tristate "Allwinner A10 CMOS Sensor Interface Support"
 	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && COMMON_CLK  && HAS_DMA
+	depends on VIDEO_DEV && COMMON_CLK && RESET_CONTROLLER && HAS_DMA
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
-- 
2.37.1

