Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DDD472E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbhLMNyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:54:25 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:8693 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbhLMNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403663; x=1670939663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QIlW9DbBMZJ7+M6XfWg1v8S4XbzujCKrn+C7a3HwsDQ=;
  b=Fyg8aJPPgQmLqKiiVTTjSCL2oIEf7XTSpeS7cU6aMl4Gtv0evoLok3SQ
   XLr9Lk6rip8LLdXYkZbfdjG/pUV2id370TrGh754yCFQogIW/SJ3FNP1G
   xzWQpwO2/fA1vFbE50KPBLQG6wSxA3++t87He41k7jvOJdLEtbvmZXk1d
   y/l8FNqASfDEdU8xrhNp1TKWbBGjgSUSmzcsfQwKilytvZhQXuVx/Tfe1
   pLNVr/vK7/FX/cDs1lh2lV3dJptwo+SY5kA8pgaxH74iI6mFYSHe6K66k
   L+FhjKZbvdia2v1R2LO6tTXiGNWMmkALdFuYS9ntOv7Yme0bONKGgZNbZ
   Q==;
IronPort-SDR: wDGmGxfBH2D0eZQcYh9AqZdKfZ945ZESxSAJ8QYnfufrCgSuLff0vuKGFUCrpcMAJ8W05XqmHu
 tJtVRZUfccSimTO4vizx7Ggysnbci+xh//0+sexRBDFrs1eq3GzHReirFv5TW1RVUu1FfGnGEH
 +exzHNY6qLxx4t6HWJgd5+3ybrsiqrTDy9MwgwHG80XI68MLFYsk24ARK/AZTB95SSdrUxH+D3
 WxJcXFw4A2u3TXuUdh1ucZNY5bYSnYTNv2SD9ZKLezeLtmk3ZLdCgiuJbIZU0/MP6n5WGF3eBp
 QXnQh/stTcqdl93xq9YRMQ+x
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="139571631"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:54:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:54:22 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:54:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 16/23] media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
Date:   Mon, 13 Dec 2021 15:49:33 +0200
Message-ID: <20211213134940.324266-17-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
index a3e4c32a66c4..a8d4ba60d3ac 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -267,7 +267,7 @@ static void isc_sama5d2_config_rlp(struct isc_device *isc)
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

