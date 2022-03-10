Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76234D4406
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiCJJx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbiCJJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:53:38 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2294EA5;
        Thu, 10 Mar 2022 01:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646905957; x=1678441957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iu9Y9l00LK8qD2HMPVyxqsR2snkJn5NMx606dNlvBmQ=;
  b=Y72CVVD0LQP17ElZxg1UdywnJ6ch+bdbg+b4BFe9nOtlAh/yDn/fkQBi
   E33TS/GsnOALJdoouQMx5Nwn6fp0TUVZC95MlNPcjbiVmY5DTn2hSODWP
   Cj/gmnamcccZsgBrIeMhk20hvQ2OhWXilRefBQUiU5rprnISqRCJFP6ya
   EVGIOgS3omfHq3hWbrOZ6uIbYF4yfCFW+xy9B3tvK+gQzKkNfzC8VvuQf
   HCg0WWdR/oK5f4h7LayiV4pnq6t6BP1nIT6odLZH6nz1k2j5RBmCzuHgT
   WNont1LfxRQsV51VvoInPQUQnkn+j/56wb3e3FTChIZq+Yd/q12Tk7qxP
   g==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643698800"; 
   d="scan'208";a="156406229"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2022 02:52:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Mar 2022 02:52:36 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 10 Mar 2022 02:52:33 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v9 05/13] media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
Date:   Thu, 10 Mar 2022 11:51:54 +0200
Message-ID: <20220310095202.2701399-6-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095202.2701399-1-eugen.hristev@microchip.com>
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
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

