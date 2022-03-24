Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304A74E64DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350811AbiCXOQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350820AbiCXOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:16:21 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D7422BC2;
        Thu, 24 Mar 2022 07:14:32 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4697860016;
        Thu, 24 Mar 2022 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648131271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5s5ePrERJH/JY3JJrixIGuqiMybYP3kM3jgY8tOV50=;
        b=UHBZfyH+5RBZ2t8GXg1k8t92rQ3xfqjH3zQSSAcbxm9tm/gQRthqpY8ttweH75GPPY+d9i
        7iOGGj3VWdEwxxhH9ytjHqhnhNMEb+l2veDCbVasKVKHB3dOtD236jKvOpIvRc/OUzFivB
        A15X+v31iKpnM+9uJ5nzfxnUw5qUJv4EZFSzuAJ41NhLwhgbYJ20geu2wIoASsgm5m4WE/
        CgMffdNOV+wpP/7KJg/GtBmZCNe3Iz7dYJMuvMar9XYC7ckxYUMP5r5G3nsK8tPvRcEFfb
        /dFutORuP8dKPlzQrTCbczwTYvaMjw/yJTKX3579iH6hlTOOJhzFnGUISm3O1A==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v2 3/3] reset: mchp: sparx5: set fwnode field of reset controller
Date:   Thu, 24 Mar 2022 15:12:37 +0100
Message-Id: <20220324141237.297207-4-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220324141237.297207-1-clement.leger@bootlin.com>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now that reset subsystem has fwnode support, use the fwnode field of
the rcdev to setup the fwnode to be used for the controller.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/reset/reset-microchip-sparx5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index 00b612a0effa..eb648b40dffd 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -101,7 +101,6 @@ static int mchp_sparx5_map_io(struct platform_device *pdev, int index,
 
 static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 {
-	struct device_node *dn = pdev->dev.of_node;
 	struct mchp_reset_context *ctx;
 	int err;
 
@@ -119,7 +118,7 @@ static int mchp_sparx5_reset_probe(struct platform_device *pdev)
 	ctx->rcdev.owner = THIS_MODULE;
 	ctx->rcdev.nr_resets = 1;
 	ctx->rcdev.ops = &sparx5_reset_ops;
-	ctx->rcdev.of_node = dn;
+	ctx->rcdev.fwnode = dev_fwnode(&pdev->dev);
 	ctx->props = device_get_match_data(&pdev->dev);
 
 	return devm_reset_controller_register(&pdev->dev, &ctx->rcdev);
-- 
2.34.1

