Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B924552D52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348387AbiFUIpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbiFUIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:45:36 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F93825EAF;
        Tue, 21 Jun 2022 01:45:34 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25L7u7eV006621;
        Tue, 21 Jun 2022 10:45:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=2OyBIvFq+cbqc84GuaJEdZ2RqadPrXQDktccoEX4tyw=;
 b=YG8k6IgOGCpOqcO56I4GnWgsxNUvRpkvSbNJUa0NzXbZbwSDTquS6TUJakri3vIvhoym
 CHVkqJt+Lygzt9yIFZCASFqpE/Yg5pyPxJcFh5hqYjIZ0JDqOMtYZ1HrkyDhkFfwzOGo
 CC2xE33Mb9jjF/+FBp/dxbIhquEoXqBGJcpiUSS6LCygY4UKCI05GzPHB0xGDEY4OWx1
 0rrL0AvGHcp7AQ2m0jLr22EiAyEicZdCBVgY4OQ/dPoZuDDyuRv2+POBbeYhakUoKodm
 fYQagkyuBD3W4puQAtzKFOzHcwefZz/SIZmaXPZYrBZS8V/C3rbMlyLYT1iNma1oe0j/ OA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gua1n0atj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 10:45:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 309D9100034;
        Tue, 21 Jun 2022 10:45:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1A12721515D;
        Tue, 21 Jun 2022 10:45:18 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 21 Jun
 2022 10:45:17 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH] ARM: dts: stm32: add missing usbh clock and fix clk order on stm32mp15
Date:   Tue, 21 Jun 2022 10:45:09 +0200
Message-ID: <20220621084509.407451-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_03,2022-06-17_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USBH composed of EHCI and OHCI controllers needs the PHY clock to be
initialized first, before enabling (gating) them. The reverse is also
required when going to suspend.
So, add USBPHY clock as 1st entry in both controllers, so the USBPHY PLL
gets enabled 1st upon controller init. Upon suspend/resume, this also makes
the clock to be disabled/re-enabled in the correct order.
This fixes some IRQ storm conditions seen when going to low-power, due to
PHY PLL being disabled before all clocks are cleanly gated.

Fixes: 949a0c0dec85 ("ARM: dts: stm32: add USB Host (USBH) support to stm32mp157c")
Fixes: db7be2cb87ae ("ARM: dts: stm32: use usbphyc ck_usbo_48m as USBH OHCI clock on stm32mp151")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index edc0a1641c7b..9e2226430802 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1473,7 +1473,7 @@ stmmac_axi_config_0: stmmac-axi-config {
 		usbh_ohci: usb@5800c000 {
 			compatible = "generic-ohci";
 			reg = <0x5800c000 0x1000>;
-			clocks = <&rcc USBH>, <&usbphyc>;
+			clocks = <&usbphyc>, <&rcc USBH>;
 			resets = <&rcc USBH_R>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -1482,7 +1482,7 @@ usbh_ohci: usb@5800c000 {
 		usbh_ehci: usb@5800d000 {
 			compatible = "generic-ehci";
 			reg = <0x5800d000 0x1000>;
-			clocks = <&rcc USBH>;
+			clocks = <&usbphyc>, <&rcc USBH>;
 			resets = <&rcc USBH_R>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 			companion = <&usbh_ohci>;
-- 
2.25.1

