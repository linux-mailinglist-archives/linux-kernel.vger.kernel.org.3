Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF55144B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356072AbiD2Iud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356054AbiD2Iub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:50:31 -0400
Received: from bin-mail-out-06.binero.net (bin-mail-out-06.binero.net [195.74.38.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E4D54BC9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:47:13 -0700 (PDT)
X-Halon-ID: f513e3fe-c798-11ec-9627-0050569116f7
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id f513e3fe-c798-11ec-9627-0050569116f7;
        Fri, 29 Apr 2022 10:47:11 +0200 (CEST)
From:   Andreas Larsson <andreas@gaisler.com>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-kernel@vger.kernel.org, software@gaisler.com,
        Daniel Hellstrom <daniel@gaisler.com>
Subject: [PATCH v2 1/3] can: grcan: use ofdev->dev when allocating DMA memory
Date:   Fri, 29 Apr 2022 10:46:54 +0200
Message-Id: <20220429084656.29788-2-andreas@gaisler.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220429084656.29788-1-andreas@gaisler.com>
References: <20220429084656.29788-1-andreas@gaisler.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>

Use the device of the device tree node should be rather than the device
of the struct net_device when allocating DMA buffers.

The driver got away with it on sparc32 until commit 53b7670e5735
("sparc: factor the dma coherent mapping into helper") after which the
driver oopses.

Fixes: 6cec9b07fe6a ("can: grcan: Add device driver for GRCAN and GRHCAN cores")

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/net/can/grcan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index d0c5a7a60daf..f7c3cf941f61 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -248,6 +248,7 @@ struct grcan_device_config {
 struct grcan_priv {
 	struct can_priv can;	/* must be the first member */
 	struct net_device *dev;
+	struct device *ofdev_dev;
 	struct napi_struct napi;
 
 	struct grcan_registers __iomem *regs;	/* ioremap'ed registers */
@@ -921,7 +922,7 @@ static void grcan_free_dma_buffers(struct net_device *dev)
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_dma *dma = &priv->dma;
 
-	dma_free_coherent(&dev->dev, dma->base_size, dma->base_buf,
+	dma_free_coherent(priv->ofdev_dev, dma->base_size, dma->base_buf,
 			  dma->base_handle);
 	memset(dma, 0, sizeof(*dma));
 }
@@ -946,7 +947,8 @@ static int grcan_allocate_dma_buffers(struct net_device *dev,
 
 	/* Extra GRCAN_BUFFER_ALIGNMENT to allow for alignment */
 	dma->base_size = lsize + ssize + GRCAN_BUFFER_ALIGNMENT;
-	dma->base_buf = dma_alloc_coherent(&dev->dev,
+
+	dma->base_buf = dma_alloc_coherent(priv->ofdev_dev,
 					   dma->base_size,
 					   &dma->base_handle,
 					   GFP_KERNEL);
@@ -1587,6 +1589,7 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	memcpy(&priv->config, &grcan_module_config,
 	       sizeof(struct grcan_device_config));
 	priv->dev = dev;
+	priv->ofdev_dev = &ofdev->dev;
 	priv->regs = base;
 	priv->can.bittiming_const = &grcan_bittiming_const;
 	priv->can.do_set_bittiming = grcan_set_bittiming;
-- 
2.17.1

