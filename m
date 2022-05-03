Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FB4518002
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiECItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiECIs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:48:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE478BED;
        Tue,  3 May 2022 01:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651567523; x=1683103523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tzm28KKlAo03TnEtdDDS7AYViASHkqt3HIyPL9UKq+Y=;
  b=QphZE7pElEFTkH5hXpVaI4PrMrqhnqdEKwZZOvvH0uElm3/tflJF8ug/
   uuLD9Tw5HoL7Cci05oxxiKHc0AUOms91lr5/3RlsGx6GOViEDgk1ko6uR
   uSY1UHxjXzUbIRWVMWNYF/vo6a4lx+BW+Y7k034w3Vc9n+YXjfjm5KBE5
   zi6j06V82trl08cR392Y6LfaU5ypGwcUv3vkcKk3qMHLe26vnvh+AlmZx
   4wI5891mwl+CPQMSJByje7hYeg365Hpp5IIfKTrROJbikz9WI2aefeMBR
   uWeyuCYmNus0XTxmhMqQLrQD2jpTzHA4vA3c+Xlvsf8l4dFGKCSzD50hL
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="94358213"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 01:45:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 01:45:21 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 01:45:14 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jacopo@jmondi.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v10 4/8] media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
Date:   Tue, 3 May 2022 11:44:17 +0300
Message-ID: <20220503084421.40682-5-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503084421.40682-1-eugen.hristev@microchip.com>
References: <20220503084421.40682-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this does not happen in production, this check should be done
versus the mask, as checking with the YCYC value may not include
some bits that may be set.
Is it correct and safe to check the whole mask.

Fixes: 123aaf816b95 ("media: atmel: atmel-sama5d2-isc: fix YUYV format")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index c5b9563e36cb..3a711de9f820 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -291,7 +291,7 @@ static void isc_sama5d2_config_rlp(struct isc_device *isc)
 	 * Thus, if the YCYC mode is selected, replace it with the
 	 * sama5d2-compliant mode which is YYCC .
 	 */
-	if ((rlp_mode & ISC_RLP_CFG_MODE_YCYC) == ISC_RLP_CFG_MODE_YCYC) {
+	if ((rlp_mode & ISC_RLP_CFG_MODE_MASK) == ISC_RLP_CFG_MODE_YCYC) {
 		rlp_mode &= ~ISC_RLP_CFG_MODE_MASK;
 		rlp_mode |= ISC_RLP_CFG_MODE_YYCC;
 	}
-- 
2.25.1

