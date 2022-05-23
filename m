Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FCA530DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiEWJYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiEWJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:24:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179ED483AC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653297868; x=1684833868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trdQsmLNjG1jhgsfTrGbsi0l2B2wJ2HUtbA4xJyo3Jg=;
  b=fPd6oow0rZB9L8Oycr7MircNZ4evHUI6LcP4eb/oZE2tjT8AM2q6X3vT
   aEK8cJFTddGGhOr99m1De+9Z1f4H7fDl3VDzjLEOGoDj3eu0Iy5hy837x
   XASwIKRfqKSYSqGci3KqX6QHcvw8KXh3wYQ+yVe9Qa086pxEjanC+Qdw5
   VeXCD37vGlDO7/MuKsiWmZSFYak2XD04NyIM3knSm7PGT3n+t5w/GYwli
   lgwV9Ueo4kyhNcbMu05c6IRfGwa/0VGgCCEqTBaaGwn7K5xvGuaUrtLBL
   OEEVD+4zEsilWL7/dyMye0ew/A1e9XaYMWhRGJTaVkcdin/QjRwqDb+t/
   g==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="160174298"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 02:24:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 02:24:26 -0700
Received: from ROB-ULT-M18063.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 23 May 2022 02:24:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <sboyd@kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/3] ARM: at91: pm: use proper compatibles for sama5d2's rtc
Date:   Mon, 23 May 2022 12:24:19 +0300
Message-ID: <20220523092421.317345-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220523092421.317345-1-claudiu.beznea@microchip.com>
References: <20220523092421.317345-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use proper compatible strings for SAMA5D2's RTC IPs. These is necessary
for configuring wakeup sources for ULP1 PM mode.

Fixes: d7484f5c6b3b ("ARM: at91: pm: configure wakeup sources for ULP1 mode")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index b1a43d7bc56c..4d62f686bd1e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -202,7 +202,7 @@ static const struct wakeup_source_info ws_info[] = {
 
 static const struct of_device_id sama5d2_ws_ids[] = {
 	{ .compatible = "atmel,sama5d2-gem",		.data = &ws_info[0] },
-	{ .compatible = "atmel,at91rm9200-rtc",		.data = &ws_info[1] },
+	{ .compatible = "atmel,sama5d2-rtc",		.data = &ws_info[1] },
 	{ .compatible = "atmel,sama5d3-udc",		.data = &ws_info[2] },
 	{ .compatible = "atmel,at91rm9200-ohci",	.data = &ws_info[2] },
 	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
-- 
2.34.1

