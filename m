Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA6B4B2F56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353724AbiBKVXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:23:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353671AbiBKVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:23:12 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC7C2E7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:23:10 -0800 (PST)
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH 3/3] input: ps2-gpio: don't send rx data before the stop bit
Date:   Fri, 11 Feb 2022 22:22:58 +0100
Message-Id: <20220211212258.80345-4-danilokrummrich@dk-develop.de>
In-Reply-To: <20220211212258.80345-1-danilokrummrich@dk-develop.de>
References: <20220211212258.80345-1-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending the data before processing the stop bit from the device already
saves the data of the current xfer in case the stop bit is missed.

However, when TX xfers are enabled this introduces a race condition when
a peripheral driver using the bus immediately requests a TX xfer from IRQ
context.

Therefore the data must be send after receiving the stop bit, although
it is possible the data is lost when missing the stop bit.

Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
 drivers/input/serio/ps2-gpio.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index 336928a8a127..460d520ac865 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -217,6 +217,13 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
 			if (!drvdata->write_enable)
 				goto err;
 		}
+		break;
+	case PS2_STOP_BIT:
+		/* stop bit should be high */
+		if (unlikely(!data)) {
+			dev_err(drvdata->dev, "RX: stop bit should be high\n");
+			goto err;
+		}
 
 		/* Do not send spurious ACK's and NACK's when write fn is
 		 * not provided.
@@ -228,21 +235,9 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
 				break;
 		}
 
-		/* Let's send the data without waiting for the stop bit to be
-		 * sent. It may happen that we miss the stop bit. When this
-		 * happens we have no way to recover from this, certainly
-		 * missing the parity bit would be recognized when processing
-		 * the stop bit. When missing both, data is lost.
-		 */
 		serio_interrupt(drvdata->serio, byte, rxflags);
 		dev_dbg(drvdata->dev, "RX: sending byte 0x%x\n", byte);
-		break;
-	case PS2_STOP_BIT:
-		/* stop bit should be high */
-		if (unlikely(!data)) {
-			dev_err(drvdata->dev, "RX: stop bit should be high\n");
-			goto err;
-		}
+
 		cnt = byte = 0;
 
 		goto end; /* success */
-- 
2.34.1

