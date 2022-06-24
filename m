Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9659D559717
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiFXJ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFXJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:56:24 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCC37A189;
        Fri, 24 Jun 2022 02:56:22 -0700 (PDT)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 27895FF803;
        Fri, 24 Jun 2022 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656064581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P+xAWw+Bp79/ff3vorq93ipaITpawgJ5CXoeUyR3LMY=;
        b=ZP2yeGuv8xiH2UwEEajX1vft4nQdwDgCflluP3aygsyT320Jiqt1u/+wn82yLuxmN+Xb83
        E1GQPfH80/o9HIC6iZlCmk/ECKypAFUOCf0hO0jxGhc4PCOSS/TlF4odF+OM5Oxomf1dWr
        K2g7/uXO4HoWW5a8nBPXup4kGVEO+GAp94OiuX6Nvk0KVjJ5lbQ8+/fy+pc7aRj1FSvbi3
        pZ6hD1woVK/g5cGJNR3bti4VDQgsz1XeK1BFwCiAKhr4ISRT6yotvzE7hk8kBtgxF4Nk4J
        pxUJNsGkz7wW69l/JmnaBfASWLTwDSz5PVzMW963Lx03I9ZwWVzC5bh+ifcexg==
From:   Kory Maincent <kory.maincent@bootlin.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.petazzoni@bootlin.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] iio: dac: mcp4922: add support to mcp4921
Date:   Fri, 24 Jun 2022 11:56:17 +0200
Message-Id: <20220624095619.1415614-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
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

Add support to mcp4921 which has only one output channel.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/iio/dac/mcp4922.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index cb9e60e71b91..0d41c0f25515 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -17,10 +17,12 @@
 #include <linux/bitops.h>
 
 #define MCP4922_NUM_CHANNELS	2
+#define MCP4921_NUM_CHANNELS	1
 
 enum mcp4922_supported_device_ids {
 	ID_MCP4902,
 	ID_MCP4912,
+	ID_MCP4921,
 	ID_MCP4922,
 };
 
@@ -105,9 +107,10 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static const struct iio_chan_spec mcp4922_channels[3][MCP4922_NUM_CHANNELS] = {
+static const struct iio_chan_spec mcp4922_channels[4][MCP4922_NUM_CHANNELS] = {
 	[ID_MCP4902] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
 	[ID_MCP4912] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
+	[ID_MCP4921] = { MCP4922_CHAN(0, 12),	{} },
 	[ID_MCP4922] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
 };
 
@@ -154,7 +157,10 @@ static int mcp4922_probe(struct spi_device *spi)
 	indio_dev->info = &mcp4922_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mcp4922_channels[id->driver_data];
-	indio_dev->num_channels = MCP4922_NUM_CHANNELS;
+	if (id->driver_data == ID_MCP4921)
+		indio_dev->num_channels = MCP4921_NUM_CHANNELS;
+	else
+		indio_dev->num_channels = MCP4922_NUM_CHANNELS;
 	indio_dev->name = id->name;
 
 	ret = iio_device_register(indio_dev);
@@ -185,6 +191,7 @@ static void mcp4922_remove(struct spi_device *spi)
 static const struct spi_device_id mcp4922_id[] = {
 	{"mcp4902", ID_MCP4902},
 	{"mcp4912", ID_MCP4912},
+	{"mcp4921", ID_MCP4921},
 	{"mcp4922", ID_MCP4922},
 	{}
 };
-- 
2.25.1

