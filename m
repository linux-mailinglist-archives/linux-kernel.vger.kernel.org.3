Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2620448A916
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348806AbiAKIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:09:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:20295 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiAKIJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641888579; x=1673424579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qt7FmkV+eT+RljvKOaswKjs5L9PsPSobPl63lL0Klk0=;
  b=eFw2DY533Q2S074t1wLI2P9xdCPw8l0KRFVVRJ1zPVjLnbamJcnWCf1P
   TMhi4tUFd+/pqo2IKxdnL9S7X+yUSLyCk76QNRXZoTmy40TRmSVcbaD4m
   e4h+PbkoVXUx/ndCzUJIDilAzcBOkkQYEpND9GDLWFXfX3TIDqXKWhYOW
   QxZv9vZAOIdRDujQB/9ISagtUcbVDspgxoM0JTjJJ0qmiWcS1HLqrh3d8
   ikqbEmEId0b0+NZ9PVsCWLDa7l+XbexQFjEPQxSQYXmBHfeI3xLTa6FqW
   /LU5llBsq9K6iX0+/VDjLR5XwR70i+0z+MT4Hm/EOkLSMtp/Rghwi190j
   g==;
IronPort-SDR: VI0glG87FvnWOO4K/40NedprheBRNUfrX+vHn6MMTn1hYbJ99JxCz8LAwRwul4TZy28po5Y+ki
 cDOnMLNn4ajPALkuL2PxK+Ss6Y/rZusS/bW1Hf15RjIIZOaDx4295qFhH0hfsMALrBxTHmN5JD
 Z2EBG1AHF7ZV3rnervKk0mrIxwBI9mj0E7g0HVfMm2pW/KCZcRRSP9sNz/Fdh2c72LgkvHrT/r
 8s8YbJbglARIfz+sXQ50tks/F8nTPs+WqtBo8w0lhwycYInDyOQeZkKFl/9CAVPx3KuremLtTc
 jP8i6FcdT5xBsh4296OWDOQO
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="149227131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2022 01:09:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 01:09:37 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 11 Jan 2022 01:09:35 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <nicolas.ferre@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <bbrezillon@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2: Fix PMERRLOC resource size
Date:   Tue, 11 Jan 2022 10:09:33 +0200
Message-ID: <20220111080933.800414-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMERRLOC resource size has been shrunk to 0x100, which resulted in
HSMC_ERRLOCx register being truncated to offset x = 21, causing
error correction to fail if more than 22 bit errors where 24 or
32 bit error correction was supported.

Fixes: d9c41bf30cf8 ("ARM: dts: at91: Declare EBI/NAND controllers")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 801969c113d6..de88eb484718 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -413,7 +413,7 @@ hsmc: hsmc@f8014000 {
 				pmecc: ecc-engine@f8014070 {
 					compatible = "atmel,sama5d2-pmecc";
 					reg = <0xf8014070 0x490>,
-					      <0xf8014500 0x100>;
+					      <0xf8014500 0x200>;
 				};
 			};
 
-- 
2.25.1

