Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C44847E5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbhLWPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:42:40 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:29127 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349058AbhLWPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640274051; x=1671810051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YcN1nSjIyeMlPtXRTSvXWfI2gE85Pz9oyuBbS0L9t3o=;
  b=jEVztBzvEVMQVvkknXoHfNteTPEMiRl4DF9oxReKTW89uittrEklt8mV
   MJoQ9hnBjcLPYjFvZR5+2svVdZ/vDaeWgNzBnAL8JRZXoXYzim02p6r8J
   zmBNUik5iauYf1L4g5BHAY0Lemsae3jY4mIIgErC8ohH3mykdtsmjtpgc
   q4v66UISPHZvJPaHi9G2ghsm2n/+DUOZqBL5SBHMPgaiQ7nVaht9I0PdK
   GPKgWMALf3l9f41JenEq9I7dzEV60o9tevKDEGAyNye1LqhhXNpv4X9My
   I4Ost7Jd7pgrDJXz56GziEqxmP6cc4AttXKxMq07nYX0t99jRMLv2B1RG
   Q==;
IronPort-SDR: 0a4KLaVZrN1JIu1Ug/vccFTYr2vwezpVcKJMBevxA2bKYV8aihzvV2pCCE612j4nGy/q/abjem
 yNDOpvQXvIc8AQW8i/SPJzlKtZn367ufgX8EyGMiT3Cve142VanXM1Ugu5BQAwEJ8PJ9bjS6vx
 Vxka0pr6tWiupKti87yictTNSbJPNHOc9XLuvLDagUf5kOhzoi8/wtpCMIsbwOKUNt7i0ePTI5
 aPlZu8RD0SjPNNwfj/LXqJpzRnuIyCaeoNFCIB3T0uuQ0UYmRz4g9aeiCJDEpDmzsHkv6hXe+1
 RQQgrAwNpsxeaEMqUX9xsAkB
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="140721431"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 08:40:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 08:40:50 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 08:40:49 -0700
From:   <conor.dooley@microchip.com>
To:     <mani@kernel.org>, <Mmturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <daire.mcnamara@microchip.com>,
        <mail@conchuod.ie>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] clk: bm1880: remove kfrees on static allocations
Date:   Thu, 23 Dec 2021 15:42:44 +0000
Message-ID: <20211223154244.1024062-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

bm1880_clk_unregister_pll & bm1880_clk_unregister_div both try to
free statically allocated variables, so remove those kfrees.

For example, if we take L703 kfree(div_hw):
- div_hw is a bm1880_div_hw_clock pointer
- in bm1880_clk_register_plls this is pointed to an element of arg1:
  struct bm1880_div_hw_clock *clks
- in the probe, where bm1880_clk_register_plls is called arg1 is
  bm1880_div_clks, defined on L371:
  static struct bm1880_div_hw_clock bm1880_div_clks[]

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/clk-bm1880.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/clk-bm1880.c b/drivers/clk/clk-bm1880.c
index e6d6599d310a..fad78a22218e 100644
--- a/drivers/clk/clk-bm1880.c
+++ b/drivers/clk/clk-bm1880.c
@@ -522,14 +522,6 @@ static struct clk_hw *bm1880_clk_register_pll(struct bm1880_pll_hw_clock *pll_cl
 	return hw;
 }
 
-static void bm1880_clk_unregister_pll(struct clk_hw *hw)
-{
-	struct bm1880_pll_hw_clock *pll_hw = to_bm1880_pll_clk(hw);
-
-	clk_hw_unregister(hw);
-	kfree(pll_hw);
-}
-
 static int bm1880_clk_register_plls(struct bm1880_pll_hw_clock *clks,
 				    int num_clks,
 				    struct bm1880_clock_data *data)
@@ -555,7 +547,7 @@ static int bm1880_clk_register_plls(struct bm1880_pll_hw_clock *clks,
 
 err_clk:
 	while (i--)
-		bm1880_clk_unregister_pll(data->hw_data.hws[clks[i].pll.id]);
+		clk_hw_unregister(data->hw_data.hws[clks[i].pll.id]);
 
 	return PTR_ERR(hw);
 }
@@ -695,14 +687,6 @@ static struct clk_hw *bm1880_clk_register_div(struct bm1880_div_hw_clock *div_cl
 	return hw;
 }
 
-static void bm1880_clk_unregister_div(struct clk_hw *hw)
-{
-	struct bm1880_div_hw_clock *div_hw = to_bm1880_div_clk(hw);
-
-	clk_hw_unregister(hw);
-	kfree(div_hw);
-}
-
 static int bm1880_clk_register_divs(struct bm1880_div_hw_clock *clks,
 				    int num_clks,
 				    struct bm1880_clock_data *data)
@@ -729,7 +713,7 @@ static int bm1880_clk_register_divs(struct bm1880_div_hw_clock *clks,
 
 err_clk:
 	while (i--)
-		bm1880_clk_unregister_div(data->hw_data.hws[clks[i].div.id]);
+		clk_hw_unregister(data->hw_data.hws[clks[i].div.id]);
 
 	return PTR_ERR(hw);
 }
-- 
2.30.2

