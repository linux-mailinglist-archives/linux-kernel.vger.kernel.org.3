Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8BD5445DF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241559AbiFIIbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241018AbiFIIae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:30:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4970518DAC9;
        Thu,  9 Jun 2022 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763424; x=1686299424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nr/sHF4a/6eEUoNV9OryJpAze1cR1cqFM3Ai8nAzrTs=;
  b=eA0mDSOY2qOZl/31s9/mQMyMnt1g4zXMkp+D9hd2ip5PXb+0fu5KXlE8
   3fYBaw5xXj7pCLCDu+EHiwiGa1Zf3iE/qNLHCdp0v8artFNq6QkJYGD8V
   x/u+wZiKrKYlnc42dS/cCaUwqtgrD8GBsz74yIy8+oPT/A+FkxBXqWlaN
   izRMwwhKZk7MAY9JOEkZFHd9jZHcdb+t+DLZbpQoXKTYLJVP3edQmzkoL
   37myRb4KJvai5aI04tE4KNTVmA0Iezr48jmz7/faTENU33bfmIldX8Dns
   yiaTov9w3mJjcsAnOGci/ke8TyKkJFmdUZK7ZM0AVrZXm6YPk1CmpkB7D
   A==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="99259954"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:30:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:30:21 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:30:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 08/16] iio: adc: at91-sama5d2_adc: move oversampling storage in its function
Date:   Thu, 9 Jun 2022 11:32:05 +0300
Message-ID: <20220609083213.1795019-9-claudiu.beznea@microchip.com>
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

Move the storage of oversampling_ratio in at91_adc_config_emr().
This prepares for the next commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index fbb98e216e70..76367cc948e8 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -796,6 +796,8 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 
 	at91_adc_writel(st, EMR, emr);
 
+	st->oversampling_ratio = oversampling_ratio;
+
 	return 0;
 }
 
@@ -1695,9 +1697,6 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 			goto unlock;
 		/* update ratio */
 		ret = at91_adc_config_emr(st, val);
-		if (ret)
-			goto unlock;
-		st->oversampling_ratio = val;
 unlock:
 		mutex_unlock(&st->lock);
 		return ret;
-- 
2.34.1

