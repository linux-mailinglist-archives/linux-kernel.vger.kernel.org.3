Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4549F43B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiA1HSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:18:04 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:21490 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiA1HSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643354283; x=1674890283;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=K+Uv8pmoiitwbzIuGduDNaut2mMU/wE30++d5+B9hSQ=;
  b=sT2Hgk5/l1ZpyAwTF/fyauVnyYuDbNlZwzWt6qnp0Qa/hwFzTjrdCRAZ
   tSN96TdSw0lYTtKwPqbXs5n3Bna089KuPC96U6a08ZqFUrf1GCD3heFon
   isUsGE2HYkZtemrfbjhR7/GqIfd+F9b/yO0Lhu0eF+5aCtdhhlYCKYal9
   eM7MXLVfybiEy7E/eEAFNrsrSSqvVGjjymCaXCW0MQeWmPsXyhFPxhc/A
   kBwQdk1nSgMSCD+Rm50zpogshX7kSvNEgZcL+/687VpgU4llVVUumlc9k
   ap7XXUeEBufykYe/phjNRaB6iaJUc/K6haaK7El0VgtVwFcxpQOrYsxyF
   A==;
IronPort-SDR: 5N8rWxNHDZ5OQXBnq36Wf4it0+f8lxYfM96DKaDFgUqftlpn8Kj5zSU6xWdYTgh79L+GlLbMWE
 Rk9vNFmXXpWMBXSi0Qyqp0Stx2yUnt2kTVKrTJf7iyBJ1NqiQeHJdMC7YhbIuEt9kfdjFlsVdV
 WbsUwR5Jd89nIRbd9wYBte6mH1FTgMZoAkwFn4OZHhSBqqlTqEqP2J4MRXVmLyY1aqMeIxpE8o
 9Ft6ieCHni0bsuHDZL+9VTlvkJUzIGXXgO7BmtqE7lbf5XPh8ZwDnJ+NdmO4kktNyLyqRfStvP
 KaWkB00f8OEQ4jlfrgb3ENHI
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="83968551"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jan 2022 00:18:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 28 Jan 2022 00:18:02 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 28 Jan 2022 00:17:57 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>
CC:     <UNGLinuxDriver@microchip.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH v2] crypto: atmel: add support for AES and SHA IPs available on lan966x SoC
Date:   Fri, 28 Jan 2022 12:47:55 +0530
Message-ID: <20220128071755.25277-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for hardware version of AES and SHA IPs
available on lan966x SoC.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
v1 -> v2:
- Removed fallthrough line, as it is not required.

 drivers/crypto/atmel-aes.c | 1 +
 drivers/crypto/atmel-sha.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index fe0558403191..f72c6b3e4ad8 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2509,6 +2509,7 @@ static void atmel_aes_get_cap(struct atmel_aes_dev *dd)
 
 	/* keep only major version number */
 	switch (dd->hw_version & 0xff0) {
+	case 0x700:
 	case 0x500:
 		dd->caps.has_dualbuff = 1;
 		dd->caps.has_cfb64 = 1;
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 1b13f601fd95..d1628112dacc 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -2508,6 +2508,7 @@ static void atmel_sha_get_cap(struct atmel_sha_dev *dd)
 
 	/* keep only major version number */
 	switch (dd->hw_version & 0xff0) {
+	case 0x700:
 	case 0x510:
 		dd->caps.has_dma = 1;
 		dd->caps.has_dualbuff = 1;
-- 
2.17.1

