Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8742E588A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbiHCK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbiHCK06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:26:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F602ED75;
        Wed,  3 Aug 2022 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522415; x=1691058415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vs9ZAQ46uCeJMUwjZs++ilJZjlW5m48lwQpyLCI2ESo=;
  b=lXAy7HhnXdGTLXyBmd1VSkayKYs8/JmCn7gadelEoCpEGH/RU6ug+P/n
   aruL5RREQnZ6XweUY4RAwQNR0s66Nyxv6NRL2zp1cD8kmrww05M0P+c+s
   vOB6cp+R2EONtDxYJlATUZm7/LMdAbCcfJoopFdiyYOYp856GczNw9e8G
   OWmoUV6yxCPe7S8VJvXbVmoHFypdmhcXayzFyCCLnyZQUzh5Db1zFEjr3
   IhgRP4MiND3Gb8/SUq8ZRJiMahOT7oPCIRHV3pbT9FiqkRYroTs3tKGEX
   6EbsnSmVJxeHCo8tHaavF9gpHVf7miz+bAe/Vxj+tF8puVgiF9pCsRBtT
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="170757307"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:26:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:26:53 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:26:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 05/19] iio: adc: at91-sama5d2_adc: exit from write_raw() when buffers are enabled
Date:   Wed, 3 Aug 2022 13:28:41 +0300
Message-ID: <20220803102855.2191070-6-claudiu.beznea@microchip.com>
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

When buffers are enabled conversion may start asynchronously thus
allowing changes on actual hardware could lead to bad behavior. Thus
do not allow changing oversampling ratio and sample frequency when
if iio_device_claim_direct_mode() returns with error.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index e2c82c5a2fac..64943d8ea869 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1641,6 +1641,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 			      int val, int val2, long mask)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -1650,20 +1651,29 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		/* if no change, optimize out */
 		if (val == st->oversampling_ratio)
 			return 0;
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 		mutex_lock(&st->lock);
 		st->oversampling_ratio = val;
 		/* update ratio */
 		at91_adc_config_emr(st);
 		mutex_unlock(&st->lock);
+		iio_device_release_direct_mode(indio_dev);
 		return 0;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val < st->soc_info.min_sample_rate ||
 		    val > st->soc_info.max_sample_rate)
 			return -EINVAL;
 
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 		mutex_lock(&st->lock);
 		at91_adc_setup_samp_freq(indio_dev, val);
 		mutex_unlock(&st->lock);
+		iio_device_release_direct_mode(indio_dev);
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.34.1

