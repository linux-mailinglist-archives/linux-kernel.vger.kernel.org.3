Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAB4C8BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiCAMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiCAMec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:34:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731592D2A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646138032; x=1677674032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kVbe5kyjR6LZvsZoGI+3OLtGGwUKh9RENE9A7JuYgqA=;
  b=tTRUTFDcTltst6ZHrHrcQ2Xtg24IlzmG0A9eQLjlkXCnLqHXS6hUIxuB
   t2yb9Up5or/kgwiRoSGoGgiiozLiKESWiRKtYTAFxsiN2ML967X6+rLIX
   hwmNXChqhn1PwIJZGPnY9xUzwIbxUeWP61WIUxCSvdw3pRdaIsmhcHz3r
   AiEyAW8rdm66VkBunSm7HfDGg2ESfLLGKiNR9rZ8DqnViXHCfEWU2Mqfd
   TFt04adzaKeIwSe5EuGp//s85kgEq8Wr2iFYWftlHJW8ikoTHWtN+ixnD
   Inr5v2MF5VkVRDoxFNJFazZlqs/TyR5I+WYO/56SEKaYAYdjKRnOk89im
   A==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643698800"; 
   d="scan'208";a="87382485"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2022 05:33:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Mar 2022 05:33:51 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 1 Mar 2022 05:33:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/7] clocksource/drivers/timer-microchip-pit64b: remove timer-of depenency
Date:   Tue, 1 Mar 2022 14:34:44 +0200
Message-ID: <20220301123449.2816625-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
References: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
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

PIT64B driver doesn't use timer-of APIs. Thus, remove the selection.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1ea556e75494..3aee0ffad1fe 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -713,7 +713,6 @@ config INGENIC_OST
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
-	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
 	  based system. It supports the oneshot, the periodic
-- 
2.32.0

