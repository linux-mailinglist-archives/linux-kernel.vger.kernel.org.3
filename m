Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256C34A9A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358880AbiBDNfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:35:32 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25737 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiBDNf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643981729; x=1675517729;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IoStn4DVmu98unEojJq/9FbPgC7txAU64kKBw7DDTL0=;
  b=Vf2C/a3Ko0SXRZcj3BEDN+y1zeCTq5K0/rGOntr/96M67czDDdaepKhU
   /EXgwj3pRJW+dH1UKfE2vT9LzDnObn9ZNV87VZl9ab+23zvaeCHxjMUBJ
   OjtfHZKYtZ44fGSlzzbR4ghHJ5oHtHKQ6jV5TGZgX+bGSzWCvD7jiQrp9
   SJEz3BkrcJ1cbmY5/ItI6eC8/uBz+z1FAv5qHYABJift1gyMLHLDUSP72
   HtbC0q1ASizYs2ymcwfb6cxrBceWiygzkaYjxFBxRw8cdX9NltLawR/Q8
   DNG0J7D81GwEQqKo9HSHPQ/P1I6a5foR4pc2U6j62oXWZK9uVAhHd196U
   g==;
IronPort-SDR: bQiJFDJTWGJ+vJW5Om2VIWR+4ssi1NDmVcD6CoXPejWtOuqEzDC6AL1qOuvKg7ghwhKn+rzGbn
 Ppm5v0ZWtq/2FS5+vzvJb3dWzoRlQ1X8cNc6rhIcnatpj+63qx9kD3DSfKJjy+oRZn3dm8AC40
 DvVN8ypkB8BXiQqi6iYkAghFLBbFqZdUbbSctl71I23E/gdTFdswBBsTzpHINffIwtZPi38kh0
 4BTz6dsekaUgBYapiImGavrrzmp3z5t+ZThLXW4PIMq2Bn8W8RB6W4KSLqINzHYl4eAYqmBsZh
 qdu1u8tMgPZVLoy7DXD3Www7
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="161111958"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 06:35:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 06:35:28 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Feb 2022 06:35:24 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] crypto: atmel-tdes: Add support for the TDES IP available on sama7g5 SoC
Date:   Fri, 4 Feb 2022 15:35:22 +0200
Message-ID: <20220204133522.498387-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the TDES IP found on sama7g5.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/crypto/atmel-tdes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index e30786ec9f2d..9fd7b8e439d2 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -1130,6 +1130,7 @@ static void atmel_tdes_get_cap(struct atmel_tdes_dev *dd)
 
 	/* keep only major version number */
 	switch (dd->hw_version & 0xf00) {
+	case 0x800:
 	case 0x700:
 		dd->caps.has_dma = 1;
 		dd->caps.has_cfb_3keys = 1;
-- 
2.25.1

