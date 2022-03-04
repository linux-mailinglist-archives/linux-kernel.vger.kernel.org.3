Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A284CDC62
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbiCDS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiCDS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:27:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818C1C666B;
        Fri,  4 Mar 2022 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646418386; x=1677954386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+jdzbR3flYYEH/bLSuzRzaIbwXXnCNewgaIgwzeUhWU=;
  b=DrGYNveW8plsTOumioNhyVIDarS7ubuT/7z0taqtXPPA873s0OeXdRup
   J4c5C0xvceI6Hn7WvTO7ikQdBshHePS4raTve4Qgw1opCNz2gluVgruqF
   9Jogr4VUwtSAV7Y3lP136G0oKoUA89vtAFhQwGDNyRrrTCjNf/vso5HfP
   XcIjFQDC9QAVtz4C4H42LjQygniGqp1ReR0N0ibUKj8+um0x0rrD29dGL
   8peUWNvKkvbtlKigvwYu6ErrEgLENyVIgcTNTgVIIYf1yKSE6Jbj5jNIs
   v6qcpDJPRd49jLjZNnUemG+dM3zW4sbRPv9ViLa1ySqefvjDP1SWrXOS5
   A==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="164571070"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 11:26:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 11:26:26 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 11:26:23 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] clk: at91: sama7g5: fix parents of PDMCs' GCLK
Date:   Fri, 4 Mar 2022 20:26:16 +0200
Message-ID: <20220304182616.1920392-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
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

Audio PLL can be used as parent by the GCLKs of PDMCs.

Fixes: cb783bbbcf54 ("clk: at91: sama7g5: add clock support for sama7g5")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 drivers/clk/at91/sama7g5.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index e43458673afb..9a213ba9e58b 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -699,16 +699,16 @@ static const struct {
 	{ .n  = "pdmc0_gclk",
 	  .id = 68,
 	  .r = { .max = 50000000  },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
-	  .pp_mux_table = { 5, 8, },
+	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
+	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
 
 	{ .n  = "pdmc1_gclk",
 	  .id = 69,
 	  .r = { .max = 50000000, },
-	  .pp = { "syspll_divpmcck", "baudpll_divpmcck", },
-	  .pp_mux_table = { 5, 8, },
+	  .pp = { "syspll_divpmcck", "audiopll_divpmcck", },
+	  .pp_mux_table = { 5, 9, },
 	  .pp_count = 2,
 	  .pp_chg_id = INT_MIN, },
 
-- 
2.32.0

