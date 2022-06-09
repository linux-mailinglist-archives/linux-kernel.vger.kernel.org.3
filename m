Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096FA5445E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbiFIIaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbiFIIaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B515351A;
        Thu,  9 Jun 2022 01:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763400; x=1686299400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReAgd8AZYf9psM+Zy+vxFLOf6B4zGQCZIqGbm96Pzms=;
  b=ybD3NcNebDjEH21EhY/DEcvYTegpglOBQg3SnwHDr8s6ycqH6WyLgupF
   L4hOuqM9HpVz7aHIcCDB2SZGH48Fj42krOG1+dwU3wPd0l8zPhnuBNMCi
   wgIkUvDF/5XtrVL/msJu3lQDblhLI/u083a1fgPmZtrp2zA2S0ENGi4dW
   V7xdVEVx31oPRLZN+JmMHnJXpqiq+oePZ4YVpSDpif5vd8fyESmqLQDuw
   BGEMp8zCK/RWFiV1xITgVZRaAOwjeLUPpfZOLJZgzVGKMMuoGWDMaLj/l
   qnalHkYKFOYr7JP9LXgO5d7DdpeRV1iHMsYYRCt4SxiHYfgJ4X6IFMuae
   A==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="177213399"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:29:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:29:59 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:29:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 02/16] iio: adc: at91-sama5d2_adc: lock around oversampling and sample freq
Date:   Thu, 9 Jun 2022 11:31:59 +0300
Message-ID: <20220609083213.1795019-3-claudiu.beznea@microchip.com>
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

.read_raw()/.write_raw() could be called asynchronously from user space
or other in kernel drivers. Without locking on st->lock these could be
called asynchronously while there is a conversion in progress. Read will
be harmless but changing registers while conversion is in progress may
lead to inconsistent results. Thus, to avoid this lock st->lock.

Fixes: 27e177190891 ("iio:adc:at91_adc8xx: introduce new atmel adc driver")
Fixes: 6794e23fa3fe ("iio: adc: at91-sama5d2_adc: add support for oversampling resolution")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 32b6f157b803..a672a520cdc0 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1542,10 +1542,11 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		ret = at91_adc_read_position(st, chan->channel,
 					     &tmp_val);
 		*val = tmp_val;
+		ret = at91_adc_adjust_val_osr(st, val);
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 
-		return at91_adc_adjust_val_osr(st, val);
+		return ret;
 	}
 	if (chan->type == IIO_PRESSURE) {
 		ret = iio_device_claim_direct_mode(indio_dev);
@@ -1556,10 +1557,11 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		ret = at91_adc_read_pressure(st, chan->channel,
 					     &tmp_val);
 		*val = tmp_val;
+		ret = at91_adc_adjust_val_osr(st, val);
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 
-		return at91_adc_adjust_val_osr(st, val);
+		return ret;
 	}
 
 	/* in this case we have a voltage channel */
@@ -1620,11 +1622,15 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_FRACTIONAL_LOG2;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&st->lock);
 		*val = at91_adc_get_sample_freq(st);
+		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		mutex_lock(&st->lock);
 		*val = st->oversampling_ratio;
+		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
 
 	default:
@@ -1644,18 +1650,23 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		    (val != AT91_OSR_16SAMPLES))
 			return -EINVAL;
 		/* if no change, optimize out */
+		mutex_lock(&st->lock);
 		if (val == st->oversampling_ratio)
-			return 0;
+			goto unlock;
 		st->oversampling_ratio = val;
 		/* update ratio */
 		at91_adc_config_emr(st);
+unlock:
+		mutex_unlock(&st->lock);
 		return 0;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val < st->soc_info.min_sample_rate ||
 		    val > st->soc_info.max_sample_rate)
 			return -EINVAL;
 
+		mutex_lock(&st->lock);
 		at91_adc_setup_samp_freq(indio_dev, val);
+		mutex_unlock(&st->lock);
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.34.1

