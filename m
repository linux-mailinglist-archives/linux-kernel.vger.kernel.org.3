Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D633591712
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiHLWBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiHLWBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:01:11 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39FCAF0D4;
        Fri, 12 Aug 2022 15:01:09 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 89E10C0006;
        Fri, 12 Aug 2022 22:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1660341668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICxRmg8LColIPirnJ+I1Csx9CqwGjKG1Bxfn6DihTrw=;
        b=IncgV2D56x0S6njXdfc/p0CdrXphM5OkJWdSGqsM6/pavl0OANresD6EasK68ue0DhrIKk
        BHnKNuBOdVeqM5xWVcBhF55b2uX672x49aWkJf7w2FA3ClpsGUEI5DZhhdUNbO0QDSLhrZ
        tlik/8TcykIAejQ+fjfv4vwO4XBwRPYgmTDYZMSsUnrJV+JSEAI10guPOkBc7QMrizoc6s
        wEOKn0h1D/5SsTzd19bH1hNhWJY1v2sPCYH/U0Mao1Rh4sUi1JJkB+Sh3w44y/oEbcMyFP
        spVoS8BVQOAlj/XFf94dGWKmgV4C/UMx1M15Hf1/uLtteUFx4KOJtuO5GHmGjA==
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
Subject: [PATCH 5/6] media: sun8i-di: Add a Kconfig dependency on RESET_CONTROLLER
Date:   Sat, 13 Aug 2022 00:00:44 +0200
Message-Id: <20220812220045.800820-5-paul.kocialkowski@bootlin.com>
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
 drivers/media/platform/sunxi/sun8i-di/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/Kconfig b/drivers/media/platform/sunxi/sun8i-di/Kconfig
index ff71e06ee2df..f688396913b7 100644
--- a/drivers/media/platform/sunxi/sun8i-di/Kconfig
+++ b/drivers/media/platform/sunxi/sun8i-di/Kconfig
@@ -4,7 +4,7 @@ config VIDEO_SUN8I_DEINTERLACE
 	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV
 	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on COMMON_CLK && OF
+	depends on COMMON_CLK && RESET_CONTROLLER && OF
 	depends on PM
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
-- 
2.37.1

