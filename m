Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1046EC16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbhLIPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:49:17 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:63667 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240158AbhLIPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:49:16 -0500
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E69C14000D;
        Thu,  9 Dec 2021 15:45:41 +0000 (UTC)
From:   Michael Opdenacker <michael.opdenacker@bootlin.com>
To:     robh+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] ARM: dts: at91: enable watchdog for SAMA5D3 Xplained
Date:   Thu,  9 Dec 2021 16:45:40 +0100
Message-Id: <20211209154540.6391-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like on the SAMA5D2 and SAMA5D4 Xplained boards,
enable the watchdog device on the SAMA5D3 Xplained board.

As explained on drivers/watchdog/at91sam9_wdt.c,
for the watchdog driver to work in Linux, you need to make sure
that the bootstrap / bootloader doesn't disable the watchdog,
as the Watchdog Timer Mode Register can be only written to once.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index d72c042f2850..440eccc9eb38 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -79,6 +79,10 @@ timer1: timer@1 {
 				};
 			};
 
+			watchdog: watchdog@fffffe40 {
+				status = "okay";
+			};
+
 			i2c0: i2c@f0014000 {
 				pinctrl-0 = <&pinctrl_i2c0_pu>;
 				status = "okay";
-- 
2.25.1

