Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66165AEDE9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbiIFOjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242301AbiIFOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:39:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C64A9A95D;
        Tue,  6 Sep 2022 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662472866; x=1694008866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0iBvNvc6oWFi2GwjYfyBen8v+JZc1cmnAG1OVejo090=;
  b=K3i+MMVc8YRojr/yv9RWxH/1vtnnZx7zQxf5eq6GC13ho3RGPDK3iokr
   wIZ9FbzfNwR3XKZMvAuXPZRuH2L1Ymcw6ygxiKARUU3uusDbFwWZ7qAgf
   MNMf7mgtURagmb/WEyMZzic0fH5/nGBAUR3cGCW9+u9fpg/VukNePGcXb
   wf2VPHeC9eXsJ6p/OKF4O15JTIgJYarpQ7YUn7JjnnFAgxgJVj6fuqKYZ
   jS7wA3aDZgWbzvybzTZD7gvay8zZz5FjOuDfD/5hghmesrV/wrEREzRAu
   CuDZ2YrBhYnnKx0h7naGbgSiNQ3Hv9X0sWhUrVVIh7dgQgHH43Ua21735
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="175830176"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:57:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:57:31 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 06:57:26 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <sergiu.moga@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v2 11/13] clk: at91: sama5d2: Add Generic Clocks for UART/USART
Date:   Tue, 6 Sep 2022 16:55:10 +0300
Message-ID: <20220906135511.144725-12-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906135511.144725-1-sergiu.moga@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the generic clocks for UART/USART in the sama5d2 driver to allow them
to be registered in the Common Clock Framework.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---



v1 -> v2:
- Added R-b tag




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

