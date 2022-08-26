Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED705A2EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiHZShW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiHZSeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:34:44 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7294E68FD;
        Fri, 26 Aug 2022 11:33:54 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 30A4CFF808;
        Fri, 26 Aug 2022 18:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urflQyA5XyLAG4jVPpqfcGeZo83/7banJtbDyX987Ns=;
        b=V47Edqi4ypBwZ49wxT0JnS2WGZkrgTKMiGf9OJRGibipGbmu8s0dMn/nwNDiZsCKrysnaf
        /2wPWh9kXsgSaWrpiy2Gm4SGB3q5ezJjMBBK2WBMko9zETcqG0JuHaHMsqZJ5AhYvk5cmR
        3Xv97DmBx2YlHbTAPBQvwODwMoGYq/m8pRQeT/fqpGGn8C/TMKSlM0GRLR27zRTyDruycZ
        WhNsyiuLFE4FPkcDWhZU+IqF5YS9w48m4jaiHuDGH/A0qM2233PoL5qviJRDWKHWRl9FnE
        /pfvPVwsaHW0hl0zsYl21+tvsEq7bgYXUTeQBNqM6POv+L25Mhoi4c3lw52C5A==
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
Subject: [PATCH v6 42/43] media: sun6i-csi: Request a shared interrupt
Date:   Fri, 26 Aug 2022 20:32:39 +0200
Message-Id: <20220826183240.604834-43-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
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

Request our interrupt shared since it is typically shared with the isp
block. The interrupt routine looks good to go for shared irq.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 46c5f98702e1..00521f966cee 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -248,8 +248,8 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 		goto error_clock_rate_exclusive;
 	}
 
-	ret = devm_request_irq(dev, irq, sun6i_csi_interrupt, 0, SUN6I_CSI_NAME,
-			       csi_dev);
+	ret = devm_request_irq(dev, irq, sun6i_csi_interrupt, IRQF_SHARED,
+			       SUN6I_CSI_NAME, csi_dev);
 	if (ret) {
 		dev_err(dev, "failed to request interrupt\n");
 		goto error_clock_rate_exclusive;
-- 
2.37.1

