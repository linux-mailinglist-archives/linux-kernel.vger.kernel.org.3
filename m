Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16D49DC2B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbiA0IEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:04:51 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3645 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbiA0IEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643270688; x=1674806688;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=YWLfVwtEW0AriDI6I/Te250BeiLS2TU4DY+DRwJFHks=;
  b=BEWmouZ30hUnIS+zpAitd7OKx4lWkqshMMAs2782q4exEDd6x6dvlIQd
   yKQzJw2nTO72JmSUPP0J1bizsNrl9hKROItQM1OvYCaaYYaTf4Tef4bU+
   9kgyVGn+O3/uVpgQoX/XIkVeBKZhhwEM7lKTIVS+hBX5y10urGiDdKZND
   Vn4ea+1SPWCXZafjLdNVM5LiDWNFR1Q3k3ioYD3aypPiX7mYt5X/vYrKD
   BPChi5nLXEaBFTr61GkGoGwkC5oVApkwgmydg0ikXpoWUOaJxGrqz0PQp
   wyJ7wZ7YnWrfn3WdnW9cWOWdgALXaxgkU55k35+xgS7DltieGUGLpd13Z
   A==;
IronPort-SDR: JSOzhSf5BRfTmZ4iMVuE+uJ+mY5S7DSTp3OG3gmA7908KbSHCvhwxC0ZBobm3nU2NQrdjarO6o
 n4DmSUanG5wcq46EF9GanyNAg7s6FNzzUav6XWBx3eFaPrUPl5xMa5xrds5I5EY39uzL3TUB8c
 2gFxDBs5OlCrWLTy/ANsFCMsG74YrwMUU99SkknKkZQdln9d60ONhhsEbk6ECUsmULYmxd4Wgs
 n0juJNj1ysd6E8NmBoWyQxv/h1dZ+0OYBe97k3sH2UHTcieCDRvR34KyAbgALmS4yxjSCo4Ii+
 2yR72ZfUd09C2J8hgS95r98O
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="144049447"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jan 2022 01:04:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 01:04:46 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 27 Jan 2022 01:04:42 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>
CC:     <UNGLinuxDriver@microchip.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH] crypto: atmel: add support for AES and SHA IPs available on lan966x SoC
Date:   Thu, 27 Jan 2022 13:34:08 +0530
Message-ID: <20220127080408.15791-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for hardware version of AES and SHA IPs
available on lan966x SoC.

Tested-by: Vradha Panchal <vradha.panchal@microchip.com>
Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 drivers/crypto/atmel-aes.c | 2 ++
 drivers/crypto/atmel-sha.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index fe0558403191..358f1092d890 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2509,6 +2509,8 @@ static void atmel_aes_get_cap(struct atmel_aes_dev *dd)
 
 	/* keep only major version number */
 	switch (dd->hw_version & 0xff0) {
+	case 0x700:
+		fallthrough;
 	case 0x500:
 		dd->caps.has_dualbuff = 1;
 		dd->caps.has_cfb64 = 1;
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 1b13f601fd95..6c7bb91c8cce 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -2508,6 +2508,8 @@ static void atmel_sha_get_cap(struct atmel_sha_dev *dd)
 
 	/* keep only major version number */
 	switch (dd->hw_version & 0xff0) {
+	case 0x700:
+		fallthrough;
 	case 0x510:
 		dd->caps.has_dma = 1;
 		dd->caps.has_dualbuff = 1;
-- 
2.17.1

