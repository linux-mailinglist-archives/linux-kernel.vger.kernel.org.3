Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7777D4D63E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349629AbiCKOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349615AbiCKOiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:38:09 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455DF1C947A;
        Fri, 11 Mar 2022 06:36:57 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E0FA1240011;
        Fri, 11 Mar 2022 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPtNVTUd4yP1lJocgKUeubQb7IU5L3ybRm3zk/OadgA=;
        b=Vud4ZHvg0Uo9MSqeKnIXCCvM3rygEXRb0rwt9dHBgYBMZDM701SVzeXf+xNVX6yDur7fxM
        qyffJHDzMlskaE49o73SRAqtwam/ttNKZS92Y124XqwrpjxpQgs1cYZ8jcHoD/KU/ggFGX
        kxKmmCDcBGLWjhjivEuwbN03ArVgvArQGPyUKvAK9gKF0TrinB9ofrapjILvFgFZ/ObVNb
        ex4+beUKbKc/m9WwAKPSySEBgGag55z84dLwQBMaHmleTmYapWTYzTxtiJWnvJM6h9KWQh
        nhpQUt74OUgACI84C1F/dQ+/X5PgUggr4dsScIMgpJIWTVsukj4/pCpkFZTq4Q==
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
Subject: [PATCH v3 43/46] media: sun6i-csi: Request a shared interrupt
Date:   Fri, 11 Mar 2022 15:35:29 +0100
Message-Id: <20220311143532.265091-44-paul.kocialkowski@bootlin.com>
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

Request our interrupt shared since it is typically shared with the isp
block. The interrupt routine looks good to go for shared irq.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index b28e5eaf4622..794ac53dcd30 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -280,8 +280,8 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 		goto error_clk_rate_exclusive;
 	}
 
-	ret = devm_request_irq(dev, irq, sun6i_csi_isr, 0, SUN6I_CSI_NAME,
-			       csi_dev);
+	ret = devm_request_irq(dev, irq, sun6i_csi_isr, IRQF_SHARED,
+			       SUN6I_CSI_NAME, csi_dev);
 	if (ret) {
 		dev_err(dev, "failed to request interrupt\n");
 		goto error_clk_rate_exclusive;
-- 
2.35.1

