Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B552475813
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhLOLpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:45:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:40158 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLOLpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639568738; x=1671104738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KU+hRdVySm5s0uHVi3dKg9v9GD2HE+bneHskT1rs1Pk=;
  b=fZm1r9AZ5VM3dpjIMNm4a/pwmho/9ah5dyzBIJHxziYd6cBqQTP4Wu9A
   35XVuvsnHq+oFHh9aNgpRBKIOiBi4r2ddGfR9MFdYCelwmYJUMzUIj1Um
   PCmg5+K3hQRmOjkRZg2uzUs18ZBfIW5O+i/V3BYarg6T7gxnyWK9LW/zV
   rXppVrfpt/l4FaUq1FYJGOonnCzlsGWpdgz84WlVru/EY48B+ktoepjka
   qWkfIggsF8CkMhsXXmp4mzL3JYpfDQeWygun3aQ1mk8LO8/t9V5DTL/rd
   oba1hrUaNWk3/FamgHKirvZZF2qoJnhu1w1BoODkcONmbRML0P2nbOfv5
   A==;
IronPort-SDR: f6NaQDcCr90bIDs6cMJCyWtOH26DX5ULUXOpWzgCVTr+9qDxaZUTdeM6fG5YUQ0HD0zVcLgMUR
 sSt0bZ+jbsyduETBCnw1frDJHTUlBzcMB4iFrPqAukFwbS5ryO5R71498lhf0Hp3QfTVQHcqfV
 FQXbgO22i9LffRyqK2xneMznousYpiaZYF5MSbRO3tyuPP810iltLoOJfjFNd49ZoY8MnOzF+6
 1ki/LzW3pkpUiq7GajhVgVmFr/65q3TyICZwx6M+rltDi+GlQOfhars5qjudxfXb/p01mCTZc6
 hQh+MTkfhXq/J2M9Hm0xld1O
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="142488026"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 04:45:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 04:45:37 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 04:45:34 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>, <dianders@chromium.org>,
        <emil.velikov@collabora.com>, <sam@ravnborg.org>,
        <codrin.ciubotariu@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2] ARM: configs: at91: Enable crypto software implementations
Date:   Wed, 15 Dec 2021 13:45:32 +0200
Message-ID: <20211215114532.300118-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable at least the same amount of algs as the hardware IPs are
supporting so that they are able to fallback to the software
implementations in case they need it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2:
- add CONFIG_CRYPTO_HMAC
- update commit message
- ignore other non-crypto changes that are revealed with
  "make savedefconfig".

 arch/arm/configs/at91_dt_defconfig | 10 +++++++++-
 arch/arm/configs/sama5_defconfig   |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index a6310c8abcc3..fe4838ea0bd1 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -216,7 +216,15 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CFB=y
+CONFIG_CRYPTO_OFB=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index fe0d7ccc8fb2..eee67628e231 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -232,6 +232,15 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CFB=y
+CONFIG_CRYPTO_OFB=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=y
-- 
2.25.1

