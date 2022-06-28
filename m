Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6708D55E909
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348166AbiF1PPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348092AbiF1PPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:15:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741492CDE3;
        Tue, 28 Jun 2022 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429297; x=1687965297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/944kLo78fvBdyEUIQtXZH5Aejk5V1Uwl/hxYvOfRg0=;
  b=O/7KQMrK1PibKb+fZKYgrQDhIqfR0uBo3hbc8eU69IIL+FPKLTf7Dj/Q
   M/L85wMe+xRpfNeQwxg7XlnPyKELBcjwrckN6M/1ptivJdKYlm3rQ7pQN
   pKd4AJz9n7XcRLZA3SVary+99TgJv/PGBZkGIz3fVvMAd2UEpw1XFv+OR
   Q9j526bSDUahn98UrnpzFVsuB07YrT3hnlA6A7cI5pnjdbxuh1v2nYMOQ
   3ew1sJW6YHPbmeGei3mOMu03XMpf0SnQ7ElABnoTA+mqBj1/aYgq+Vo6U
   ij+YKIaksmoLAhnWfZ4L+MUSxnxLMxNuv+U5n5aqUFTUFHPTo5aFgNat4
   g==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="169940940"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:14:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:14:54 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:14:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 12/19] iio: adc: at91-sama5d2_adc: move oversampling storage in its function
Date:   Tue, 28 Jun 2022 18:16:24 +0300
Message-ID: <20220628151631.3116454-13-claudiu.beznea@microchip.com>
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

Move the storage of oversampling_ratio in at91_adc_config_emr().
This prepares for the next commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 254c084f7198..57c78cd23634 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -793,6 +793,8 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 
 	at91_adc_writel(st, EMR, emr);
 
+	st->oversampling_ratio = oversampling_ratio;
+
 	return 0;
 }
 
@@ -1702,8 +1704,6 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&st->lock);
 		/* update ratio */
 		ret = at91_adc_config_emr(st, val);
-		if (!ret)
-			st->oversampling_ratio = val;
 		mutex_unlock(&st->lock);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
-- 
2.34.1

