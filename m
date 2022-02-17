Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C554BA237
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbiBQN7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:59:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiBQN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:59:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060FE2B04AA;
        Thu, 17 Feb 2022 05:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106339; x=1676642339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q6diDbG5W/BH3EeOJNaDQg5HrHiclFaPCU00lATXlck=;
  b=ixropleGBgqZpP6tdjTMVM30PcMhnFOfAgVBJTZYWQkK7WgSPS1p/nGd
   6g0Nid9cxwQd79FrhjwanXlaqGI48qhLFVCoPKzA08x4yAy1Exv4yr5t9
   7dEy1s8FJt5A9Io+5pScZqPQC162681li7yxpxDVMvrV6xQAKvVg7LerG
   e5GncG9lTCRg5sPbcrBD9NsNdabkDTVlg/o433UpU10HrzLbVqE4b/uhH
   2DwRL8e46ujOaWzGVykx1pEGk+Iq5JuYo7zt3zUgu6coGhzUagpMUoA2P
   HnUFnT4iQrBgVKDKge7ml1xgEf97yej+vrZkMZT5oT6IXl5ib5gEM9UcU
   w==;
IronPort-SDR: ug/QtYItfUctoanUV7aHR5K+FUfnwGMGYfVgV9nmUlf60XjI2WrkhLXKHMnL83Ymc0E6NsjbjX
 1yzefEq8AL3dywUk0wZvRtgvntI0JlU8OXWyS/sfouzIzePF0y7uWkY0sm5ozt15b2YWyAyUit
 dRDsEeRX9X5d2db7GmpSZh2qlSuDe1oxLf3w+PwArMKytDZux4Jy4iaiRQoBVnWCpXI+9mcrTT
 /BBIPgXmzGHfqz70Zq1J6442MosnAUnVC94jINL4VW1wTKg937z4Q4m4gXyp1rKpc31phSqink
 XgiHzTrEJKctISTdBP9wZkXa
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="153432210"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 06:58:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 06:58:52 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 06:58:36 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v5 05/13] media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
Date:   Thu, 17 Feb 2022 15:56:37 +0200
Message-ID: <20220217135645.1427466-6-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217135645.1427466-1-eugen.hristev@microchip.com>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index c244682ea22f..025c3e8a7e95 100644
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

