Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF10588A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiHCK1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbiHCK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:26:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3326120BE1;
        Wed,  3 Aug 2022 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522412; x=1691058412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSIzxMNIlBjvvm8G+s2ESA2q3nUg2ihYeM/Z3C6vBKE=;
  b=DONmtz9ICGPL08b4EDFOnJxRbLW8UZ6Xi2l7dz12dMM2ro9hsYmx3+NU
   0ba0JoKSIxKa7RyIu9J10IiGBNWryxCFjBoCmyDtHOitFFN+Ajw8UoNMY
   EopAJf/kryRKMIbZAAYKfYIFiIX8n/bPWqgh/n5e2Yh1rXWNQMyTA6YGp
   3lPBCKDowUiD2BzZT8dYBtmgoXt7J6muprONfpHRBORPb+hxaUzoNSZ5R
   d19To/1awe+t7Mu+Log8qRovqE0DW92Vpst3tJAeeNIMlqKhSOR6LIRl6
   VbNbbgqIXwvZnbh2DXFXUvpEsDNnqxd1nmlVrBg5PIwHwpoLzU2uWceCj
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="107364673"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:26:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:26:47 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:26:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 03/19] iio: adc: at91-sama5d2_adc: lock around oversampling and sample freq
Date:   Wed, 3 Aug 2022 13:28:39 +0300
Message-ID: <20220803102855.2191070-4-claudiu.beznea@microchip.com>
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

.read_raw()/.write_raw() could be called asynchronously from user space
or other in kernel drivers. Without locking on st->lock these could be
called asynchronously while there is a conversion in progress. Read will
be harmless but changing registers while conversion is in progress may
lead to inconsistent results. Thus, to avoid this lock st->lock.

Fixes: 27e177190891 ("iio:adc:at91_adc8xx: introduce new atmel adc driver")
Fixes: 6794e23fa3fe ("iio: adc: at91-sama5d2_adc: add support for oversampling resolution")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 08d1f806c839..3734ddc82952 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1542,10 +1542,10 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		ret = at91_adc_read_position(st, chan->channel,
 					     &tmp_val);
 		*val = tmp_val;
-		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
 		if (ret > 0)
 			ret = at91_adc_adjust_val_osr(st, val);
+		mutex_unlock(&st->lock);
+		iio_device_release_direct_mode(indio_dev);
 
 		return ret;
 	}
@@ -1558,10 +1558,10 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		ret = at91_adc_read_pressure(st, chan->channel,
 					     &tmp_val);
 		*val = tmp_val;
-		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
 		if (ret > 0)
 			ret = at91_adc_adjust_val_osr(st, val);
+		mutex_unlock(&st->lock);
+		iio_device_release_direct_mode(indio_dev);
 
 		return ret;
 	}
@@ -1650,16 +1650,20 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		/* if no change, optimize out */
 		if (val == st->oversampling_ratio)
 			return 0;
+		mutex_lock(&st->lock);
 		st->oversampling_ratio = val;
 		/* update ratio */
 		at91_adc_config_emr(st);
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

