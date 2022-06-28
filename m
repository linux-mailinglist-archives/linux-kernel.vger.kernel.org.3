Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816A255EBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiF1SBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiF1SB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:01:26 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4102F13CED;
        Tue, 28 Jun 2022 11:01:25 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 0F6FA520C8D;
        Tue, 28 Jun 2022 20:01:24 +0200 (CEST)
Received: from vmlxhi-182.adit-jv.com (10.72.92.119) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Tue, 28 Jun
 2022 20:01:23 +0200
From:   Michael Rodin <mrodin@de.adit-jv.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
CC:     Michael Rodin <mrodin@de.adit-jv.com>, <michael@rodin.online>,
        <erosca@de.adit-jv.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH 2/3] rcar-csi2: Do not try to recover after transfer error
Date:   Tue, 28 Jun 2022 20:00:21 +0200
Message-ID: <20220628180024.451258-3-mrodin@de.adit-jv.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628180024.451258-1-mrodin@de.adit-jv.com>
References: <YqEO3/KekkZhVjW+@oden.dyn.berto.se>
 <20220628180024.451258-1-mrodin@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.72.92.119]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Instead of restarting the R-Car CSI-2 receiver if a transmission error
is detected, inform the R-Car VIN driver of the error so it can inform
user-space. This is done to reflect a updated usage recommendation in later
versions of the datasheet.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
[mrodin@de.adit-jv.com: removed the statement about stopping the pipeline from the commit message]
Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
---
 .../media/platform/renesas/rcar-vin/rcar-csi2.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c b/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
index fea8f00a9152..5a6494167c82 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
@@ -943,21 +943,22 @@ static irqreturn_t rcsi2_irq(int irq, void *data)
 
 	rcsi2_write(priv, INTERRSTATE_REG, err_status);
 
-	dev_info(priv->dev, "Transfer error, restarting CSI-2 receiver\n");
-
 	return IRQ_WAKE_THREAD;
 }
 
 static irqreturn_t rcsi2_irq_thread(int irq, void *data)
 {
 	struct rcar_csi2 *priv = data;
+	struct v4l2_event event = {
+		.type = V4L2_EVENT_XFER_ERROR,
+	};
 
-	mutex_lock(&priv->lock);
-	rcsi2_stop(priv);
-	usleep_range(1000, 2000);
-	if (rcsi2_start(priv))
-		dev_warn(priv->dev, "Failed to restart CSI-2 receiver\n");
-	mutex_unlock(&priv->lock);
+	/* Disable further interrupts to not spam the transfer error event. */
+	rcsi2_write(priv, INTEN_REG, 0);
+
+	dev_err(priv->dev, "Transfer error detected.\n");
+
+	v4l2_subdev_notify_event(&priv->subdev, &event);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

