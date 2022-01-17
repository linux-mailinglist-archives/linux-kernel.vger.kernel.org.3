Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAFE4905E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiAQKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:25:33 -0500
Received: from aposti.net ([89.234.176.197]:49658 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238576AbiAQKZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:25:28 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 2/2] iio: at91-sama5d2: Limit requested watermark value to hwfifo size
Date:   Mon, 17 Jan 2022 10:25:12 +0000
Message-Id: <20220117102512.31725-2-paul@crapouillou.net>
In-Reply-To: <20220117102512.31725-1-paul@crapouillou.net>
References: <20220117102512.31725-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of returning an error if the watermark value is too high, which
the core will silently ignore anyway, limit the value to the hardware
FIFO size; a lower-than-requested value is still better than using the
default, which is usually 1.

Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 854b1f81d807..5cc84f4a17bb 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1752,7 +1752,7 @@ static int at91_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 	int ret;
 
 	if (val > AT91_HWFIFO_MAX_SIZE)
-		return -EINVAL;
+		val = AT91_HWFIFO_MAX_SIZE;
 
 	if (!st->selected_trig->hw_trig) {
 		dev_dbg(&indio_dev->dev, "we need hw trigger for DMA\n");
-- 
2.34.1

