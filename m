Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A81E4CD53D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiCDNfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiCDNfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:35:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8F1B7627
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646400896; x=1677936896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yt27LNUTflYgzhTyHkUhcmzYyrzGjKVHAKDiaE7aibE=;
  b=BlKb9utF2Noz9+2D4IZrgnpAHbQOcbtMn245SS3i5jAmRMRaMJAPCf4n
   8IH3N5B4ZyLYsNWL9cv7e7z4S3V3y8jWfuyWEHUcIYSNJMY1dLIZFwKPB
   7RlvYPjlRMX9MHNbYbSSZoUeGnJY4qcrwkxCnpMfLv4BVmCVuk/k2Ieya
   jtH/nQkxbV5jEz3yU9EAhhnP3hIhf8tQfQiiKN/O2+ujfotS+BJ61YLRL
   9+pZH3ST09/ZwTNAkiQVmqsPvWS8uIv8RBlw1IGAnhuSlUn59J2dvtzIo
   HB4zwYxbiXy1Xh0DcUfJ+N6HYyl3TKODDCVlNoegJEk7cM9wlrz8JW2Xh
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="148098670"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 06:34:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 06:34:54 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 06:34:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/6] clocksource/drivers/timer-microchip-pit64b: remove mmio selection
Date:   Fri, 4 Mar 2022 15:35:56 +0200
Message-ID: <20220304133601.2404086-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
References: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PIT64B timer driver doesn't depend on CLKSRC_MMIO since
commit e85c1d21b16b ("clocksource/drivers/timer-microchip-pit64b:
Add clocksource suspend/resume"). Remove the selection.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfb8ea0df3b1..1ea556e75494 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -713,7 +713,6 @@ config INGENIC_OST
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
-	select CLKSRC_MMIO
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
-- 
2.32.0

