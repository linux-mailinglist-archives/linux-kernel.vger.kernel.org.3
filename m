Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76ED588A55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiHCK05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiHCK0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:26:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A34727CFF;
        Wed,  3 Aug 2022 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522407; x=1691058407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpvtSTPUT+P8D09GzxgK5isQg3fgKy4I0OwR91I+YJk=;
  b=WgbEUl5Ea5ZyFFmywOdfPr0v3MHBAzmObdpFRSU54t1Ku1BmbD1ubwwZ
   ysNghldBgEpInkO9cBDoFcJB1pdA60p3YpuMqxtc8Z/E/mtX/9o7AMnji
   vHv6mtqdUMzLXIRQu3zBYNFUHidpT4F1ocMT1tiQWMOtLco57SDugocHG
   g/NXMaDYOtArzCUOflrZ8W1Y6LoXV16EkuoWzwWSd+iz9+hqKvcusShC+
   0mYwbPhou8EKenDrXQIGOIEWJkWU+UQuGOmTn7VD6yK485heZg0KrZ/Nc
   ZgduJyUwZrBVI3oUdTjFOdEc5Thv7wRF/5sDrJ+l+eo5jachP7rdeyMfL
   A==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="107364652"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:26:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 03:26:44 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:26:41 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 02/19] iio: adc: at91-sama5d2_adc: check return status for pressure and touch
Date:   Wed, 3 Aug 2022 13:28:38 +0300
Message-ID: <20220803102855.2191070-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220803102855.2191070-1-claudiu.beznea@microchip.com>
References: <20220803102855.2191070-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index ac9ef89fba17..08d1f806c839 100644
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

