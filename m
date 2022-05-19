Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB1752D09E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiESKfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiESKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:34:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E55579A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652956498; x=1684492498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XTGttujMcUg+0VmQSASdxmBA6ZgRvaya7ou+Hajd/cE=;
  b=P/fF2g1rZbnpct2l/Iv5/Mkchff80PaSCYSGLD2CebxRZnmiy+uq8ziC
   bTtdeFCmPyWoNp6hemLTN6DDtsp542lk8lMyR7IXe293SrihfMJ7i8FPl
   XoUbg7uOtAo2FSSXTe0qxcOghJkUNn2VlLGKhH6HwVf3sLVSoj8hnFK4H
   qIrzHTinnoDcZyBEmsClXfP8EDkaGle6+cCAuVTgIQMFBq78FVW23Fol2
   AIJUcMxjTHy1VxipblMYY5Bt3xz8zZa7PRUQ6SROE7BZk6ac1janhIyNC
   VXYhV7XLro9Q5kGg4lK4HyGafF6LyAcvWePeLBH6uJbyHvKPYKEk5CUMg
   w==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="164401320"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2022 03:34:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 19 May 2022 03:34:56 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 19 May 2022 03:34:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] ARM: at91: pm: use proper compatibles for sam9x60's rtc and rtt
Date:   Thu, 19 May 2022 13:37:22 +0300
Message-ID: <20220519103723.925800-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220519103723.925800-1-claudiu.beznea@microchip.com>
References: <20220519103723.925800-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use proper compatible strings for SAM9X60's RTC and RTT IPs. These are
necessary for configuring wakeup sources for ULP1 PM mode.

Fixes: eaedc0d379da ("ARM: at91: pm: add ULP1 support for SAM9X60")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 8556c81a3b96..3161e4467081 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -211,12 +211,12 @@ static const struct of_device_id sama5d2_ws_ids[] = {
 };
 
 static const struct of_device_id sam9x60_ws_ids[] = {
-	{ .compatible = "atmel,at91sam9x5-rtc",		.data = &ws_info[1] },
+	{ .compatible = "microchip,sam9x60-rtc",	.data = &ws_info[1] },
 	{ .compatible = "atmel,at91rm9200-ohci",	.data = &ws_info[2] },
 	{ .compatible = "usb-ohci",			.data = &ws_info[2] },
 	{ .compatible = "atmel,at91sam9g45-ehci",	.data = &ws_info[2] },
 	{ .compatible = "usb-ehci",			.data = &ws_info[2] },
-	{ .compatible = "atmel,at91sam9260-rtt",	.data = &ws_info[4] },
+	{ .compatible = "microchip,sam9x60-rtt",	.data = &ws_info[4] },
 	{ .compatible = "cdns,sam9x60-macb",		.data = &ws_info[5] },
 	{ /* sentinel */ }
 };
-- 
2.34.1

