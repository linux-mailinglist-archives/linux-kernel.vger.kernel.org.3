Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F765445C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiFIIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbiFIIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8064156B6C;
        Thu,  9 Jun 2022 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763409; x=1686299409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=II/xZso6dN8sdPch+aiFaxqQHPNylrepcZwdGMZFBWE=;
  b=0ND/fvWR8qO27flexOdQnM1iGpgdKc0nKne0TXpQc2zM7zY2krOVHl8j
   pHBG7iCd5xUeOVTNCG7oRnyxEi1Ap0AZHSAckqWZTdJwF2gLGiuYC8quX
   +kye0MnHgZQALz3AZUP4A2SZCbU4QZCViMfWrHk/Y05V9H0KQxe0jx2Ra
   thMQiyNbqhNqfxsS/hhktn04oHvgffmXg0+YWwEFiyJAhn85mHNV4xoYm
   G0t3+UqxFqa8bLUSN71+5zFguG7XZTa0izzCG7XuYQ/0wGeNTfYdPVCj/
   dC1B4AQKUgoBtVfr0gsj5M+aF/AdeUWeF0lSl5AmpGvlc+8QAvbEMFJqB
   g==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="99259897"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:03 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:29:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 03/16] iio: adc: at91-sama5d2_adc: exit from write_raw() when buffers are enabled
Date:   Thu, 9 Jun 2022 11:32:00 +0300
Message-ID: <20220609083213.1795019-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When buffers are enabled conversion may start asynchronously thus
allowing changes on actual hardware could lead to bad behavior. Thus
do not allow changing oversampling ratio and sample frequency when
buffers are enabled.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index a672a520cdc0..b76328da0cb2 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1644,6 +1644,9 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		if ((val != AT91_OSR_1SAMPLES) && (val != AT91_OSR_4SAMPLES) &&
-- 
2.34.1

