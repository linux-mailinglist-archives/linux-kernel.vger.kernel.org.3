Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6155E803
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347981AbiF1POh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347435AbiF1POX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:14:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B752DD47;
        Tue, 28 Jun 2022 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429260; x=1687965260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NNq6gdlQsaf7ue8ni5xZBhwoM33UgV11nIU8tW4lZbk=;
  b=XyxeKBNeFO5fhWxGNWjo66qZVkCk9FtDP4heW6HqYU9UVZaT6N7yTYr8
   xj50ZoC6NS/iHzqBaey220eOa8cdGqOw6M6SJzhTtg73ldjWdCqQw9Siq
   vIaaMQgZrwMLPjLIya9ko17qCA8QKkrjVbPAQHT42sYEUYhMOIx4BEnQJ
   DB9gNrxwF3y6BWLDJ4TW4ep3ux6WnPcD3pLSFJvxrWbQywivDz+jVIyTc
   r+VZV32GSSVqD+lVzr9HEGqWL6dTGhy3ewQyCYDRW1ywi7/8KU/kwcTxf
   RWRp3UpcD029RRzRQv4tqJ0RCwFmjMCFcf7Fow43DaqsVkCAKNOGM240v
   A==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="170219090"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:14:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:14:19 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:14:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 02/19] iio: adc: at91-sama5d2_adc: check return status for pressure and touch
Date:   Tue, 28 Jun 2022 18:16:14 +0300
Message-ID: <20220628151631.3116454-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check return status of at91_adc_read_position() and
at91_adc_read_pressure() in at91_adc_read_info_raw().

Fixes: 6794e23fa3fe ("iio: adc: at91-sama5d2_adc: add support for oversampling resolution")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 32b6f157b803..c3301c749164 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1544,8 +1544,10 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		*val = tmp_val;
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
+		if (ret > 0)
+			ret = at91_adc_adjust_val_osr(st, val);
 
-		return at91_adc_adjust_val_osr(st, val);
+		return ret;
 	}
 	if (chan->type == IIO_PRESSURE) {
 		ret = iio_device_claim_direct_mode(indio_dev);
@@ -1558,8 +1560,10 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		*val = tmp_val;
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
+		if (ret > 0)
+			ret = at91_adc_adjust_val_osr(st, val);
 
-		return at91_adc_adjust_val_osr(st, val);
+		return ret;
 	}
 
 	/* in this case we have a voltage channel */
-- 
2.34.1

