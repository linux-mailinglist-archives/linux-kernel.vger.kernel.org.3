Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AAF4759DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbhLONnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:43:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:10213 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbhLONnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639575799; x=1671111799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DB+4UXSNLFL5U+KUUKZY5o4OUcNG+kIDNiOJlDVl2XM=;
  b=VIx6xZDwHfvayuIt0BcItOimRCd1fW+olwclfRPWnC3fQV30skXBYLkW
   QXnDDFKWWLSjFK8e9S7ml0RyhMBtKKLhWKPwH5evGXdEc3F5sCMy/msC0
   rQJ/8hAB4C7kvMDPaXJ2guHKs3Yyr5LPP33LpzflI+frqKoi5etmXsJEc
   rqEJ4ejAQLgyC6hZS1kRzSDo2W5udAE2jZmDIk/g7FYpY3rXdGHqFWo2y
   oa69FVPp/R50OFeUOm/YpKXuwtvbqRneYi75hXezgZ+FBgYzlSf/9a+AO
   BudViuyv0I+CbDg7iB8Mhy4hBzI5js3uSSy31/d7jGeVrkfk1jPMvxp4Z
   g==;
IronPort-SDR: NhkGtw3sajwHnQXzvOVKjNiiQZo33uK8FoOMZnyZbz5VA3MpdpMhGLPPGTNCN7vES/OjFxiEEF
 sSg/WUYgVzS6EDbl1I7qGKtJE2y/GhEJPi4gUR57OGbx/kQgsK5rmdBbxjIy6OIOcddfUcE7u1
 sAlKI+nO5Ew6RDR8JmSTMp393FYatNmuWOEOiA09vzg7ezrs5IjrkwMsxhqQAOTTqHsaywy1sA
 VSrcbOgY1qRaEE1cFAIvEiLPjQ7RhQq4VdVxu0PFBu2vDOgDVQP9wcGKCBMx39O9fQDZ+nXQ/e
 9eY7QBvnNVxix+VGWxAAEoKp
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="79647478"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2021 06:43:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Dec 2021 06:43:16 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 15 Dec 2021 06:43:13 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <claudiu.beznea@microchip.com>, <dianders@chromium.org>,
        <emil.velikov@collabora.com>, <sam@ravnborg.org>,
        <codrin.ciubotariu@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3] ARM: configs: at91: Enable crypto software implementations
Date:   Wed, 15 Dec 2021 15:43:11 +0200
Message-ID: <20211215134311.304427-1-tudor.ambarus@microchip.com>
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
v3: drop CONFIG_CRYPTO_MD5, as MD5 is not hw accelerated.

v2:
- add CONFIG_CRYPTO_HMAC
- update commit message
- ignore other non-crypto changes that are revealed with
  "make savedefconfig"

 arch/arm/configs/at91_dt_defconfig | 9 ++++++++-
 arch/arm/configs/sama5_defconfig   | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index a6310c8abcc3..549d01be0b47 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -216,7 +216,14 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CFB=y
+CONFIG_CRYPTO_OFB=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index fe0d7ccc8fb2..03dd80c2a19e 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -232,6 +232,14 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CFB=y
+CONFIG_CRYPTO_OFB=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_SHA1=y
+CONFIG_CRYPTO_SHA512=y
+CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=y
-- 
2.25.1

