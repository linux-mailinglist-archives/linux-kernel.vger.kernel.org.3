Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D596596ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiHQIEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiHQIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:03:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456EA3CBD2;
        Wed, 17 Aug 2022 01:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660723413; x=1692259413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vcTzOtyWjobS5W/aThT1AJ1c0537v1+hlKeSaS5KGas=;
  b=Fu1ZdGK6Z9My3yY8fqVcsHXz8FUsGzEy+o0EADakMizw43iGU/v6nKrf
   qUoCXJQpT0Q/rWkL7owEtBpjawIyv3+dO3u53jbtApf/MP1+R+oCLsnEB
   Qb6tc0/BH0W+2hUQaSP3o5Bfdfx/6lKFTee7l06ZRU0mGOZM4jW/5nwX+
   ra4ypcY0YOGyfnKPeoVWQwhTDXFKXYZ9HSJIYNc2tvTktjsaKFQoN3TSw
   OoXm06sqahpQY4vcQuGJ4D/ehZ7DhWAKNJkCmUFtgFdTPao9IOIe85/l2
   7v/lXdql3AuJuSkFa3n48XQiVPuHfEPJeLyznUntQFIqS15fT3h1kvlLF
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="176721251"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 01:03:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 01:03:23 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 01:03:18 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH 4/5] clk: at91: sama5d2: Add Generic Clocks for UART/USART
Date:   Wed, 17 Aug 2022 10:55:17 +0300
Message-ID: <20220817075517.49575-5-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817075517.49575-1-sergiu.moga@microchip.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the generic clocks for UART/USART in the sama5d2 driver to allow them
to be registered in the Common Clock Framework.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 drivers/clk/at91/sama5d2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index cfd0f5e23b99..84156dc52bff 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -120,6 +120,16 @@ static const struct {
 	struct clk_range r;
 	int chg_pid;
 } sama5d2_gck[] = {
+	{ .n = "flx0_gclk",   .id = 19, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "flx1_gclk",   .id = 20, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "flx2_gclk",   .id = 21, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "flx3_gclk",   .id = 22, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "flx4_gclk",   .id = 23, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart0_gclk",  .id = 24, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart1_gclk",  .id = 25, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart2_gclk",  .id = 26, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart3_gclk",  .id = 27, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
+	{ .n = "uart4_gclk",  .id = 28, .chg_pid = INT_MIN, .r = { .min = 0, .max = 27666666 }, },
 	{ .n = "sdmmc0_gclk", .id = 31, .chg_pid = INT_MIN, },
 	{ .n = "sdmmc1_gclk", .id = 32, .chg_pid = INT_MIN, },
 	{ .n = "tcb0_gclk",   .id = 35, .chg_pid = INT_MIN, .r = { .min = 0, .max = 83000000 }, },
-- 
2.25.1

