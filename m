Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4D55E8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348101AbiF1PPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348020AbiF1POu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:14:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17E72E6A3;
        Tue, 28 Jun 2022 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429282; x=1687965282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jcvo0wu+k5u2pzIapeqAAgKTFCFIWAriQznaF6vAo8M=;
  b=SHwJPv09ys6XqBp0lMsUsytOkBQclmbgBL2YnW2m1ll8ELAY664hdct2
   Q6psuygsKC+gET2k0F9GEE0jzm9Rtg6Es7P3IE8xJlLIT1NA6Ti7y6Czq
   +8k0KzoAWNW5GleyAODNOKCjEfIDO3bQo+AvTpIdYLoIIOEeZpHhiOCWd
   rh7DJz2Py1hA7iisUe1RXqXpHR6A2Wsa9Edp57G1O2XEIQ/d0BczIrYpA
   myxI5qlDNFNfttRd3ExApG+yILda8IEc4RhpVlgJ7SupNKPHYRrjleS7j
   h6xb4Nx7/dltCoHMvzFFgwY5xQ4nDq2PfOLhdJMpGijdTBM36IptB4TzA
   A==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="162420840"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:14:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:14:29 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:14:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 05/19] iio: adc: at91-sama5d2_adc: exit from write_raw() when buffers are enabled
Date:   Tue, 28 Jun 2022 18:16:17 +0300
Message-ID: <20220628151631.3116454-6-claudiu.beznea@microchip.com>
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

When buffers are enabled conversion may start asynchronously thus
allowing changes on actual hardware could lead to bad behavior. Thus
do not allow changing oversampling ratio and sample frequency when
if iio_device_claim_direct_mode() returns with error.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 2c087d52f164..cd2b8190a8da 100644
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

