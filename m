Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6873588A76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiHCK2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbiHCK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:27:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106C564F6;
        Wed,  3 Aug 2022 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522437; x=1691058437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Of7iBAw/FGTaGozPvaStbkwhhPZUmle5SrpDpON9PI4=;
  b=qfaZ+beQcMv4VW6nTfCV9Y1hReyt+oBhgwTpCZcd+6H9J+1q+sV7PqKH
   +jlrYbdw4l0Q6dT6ZYSawrVGHIHBKQVCGGX5hQWA5mbWuC/O7p8SKOkfG
   1Z2Cgrm33vQhvNwH2tGQat2GaRCxsXSqYr++Qq/kJ5ETayrG+wOSJpGA1
   gyQQ0DnCqJNWlVpuERDEtIW65JsQUtJJTJ3iP0Cu2bLnj+SnRWNGXC3S/
   K1nr2DLdFZpyvML08ikdLRcIJwpuv5zmfrj/8UFAS/rz0FmeyJ8ALubED
   12+r9EnMt4E0cFIVrjJyoiwmpK3Px1zbv0sXCviPL4HYGXTeXXaYFJQX2
   w==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="184901670"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:27:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 3 Aug 2022 03:27:16 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:27:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 12/19] iio: adc: at91-sama5d2_adc: move oversampling storage in its function
Date:   Wed, 3 Aug 2022 13:28:48 +0300
Message-ID: <20220803102855.2191070-13-claudiu.beznea@microchip.com>
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

Move the storage of oversampling_ratio in at91_adc_config_emr().
This prepares for the next commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index d6a93aa7fbaf..a1df475a6f29 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -793,6 +793,8 @@ static int at91_adc_config_emr(struct at91_adc_state *st,
 
 	at91_adc_writel(st, EMR, emr);
 
+	st->oversampling_ratio = oversampling_ratio;
+
 	return 0;
 }
 
@@ -1705,8 +1707,6 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
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

