Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7464AE0E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384985AbiBHSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384957AbiBHSfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:35:36 -0500
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45882C06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:35:35 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.138.36])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id 002FD2473F2;
        Tue,  8 Feb 2022 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (88.125.132.78) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 19:35:33 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <linux-renesas-soc@vger.kernel.org>, <geert+renesas@glider.be>
CC:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] clk: renesas: r9a06g032: Disable the watchdog reset sources when halting
Date:   Tue, 8 Feb 2022 19:35:10 +0100
Message-ID: <20220208183511.2925304-7-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208183511.2925304-1-jjhiblot@traphandler.com>
References: <20220208183511.2925304-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.125.132.78]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 13255782555140831707
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrheejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeefueeggfeiuedthfdvgeevtedvueevgfevgeelieelveevheefjeejfffguddukeenucfkpheptddrtddrtddrtddpkeekrdduvdehrddufedvrdejkeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog reset sources must be disabled when the system is halted.
Otherwise the watchdogs will trigger a reset if they have been armed.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index c99942f0e4d4..d96211927a1d 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -129,6 +129,11 @@ enum { K_GATE = 0, K_FFC, K_DIV, K_BITSEL, K_DUALGATE };
 
 #define R9A06G032_CLOCK_COUNT		(R9A06G032_UART_GROUP_34567 + 1)
 
+#define R9A06G032_SYSCTRL_REG_RSTEN		0x120
+#define WDA7RST1	BIT(2)
+#define WDA7RST0	BIT(1)
+#define MRESET		BIT(0)
+
 static const struct r9a06g032_clkdesc r9a06g032_clocks[] = {
 	D_ROOT(CLKOUT, "clkout", 25, 1),
 	D_ROOT(CLK_PLL_USB, "clk_pll_usb", 12, 10),
@@ -893,6 +898,19 @@ static void r9a06g032_clocks_del_clk_provider(void *data)
 	of_clk_del_provider(data);
 }
 
+static void r9a06g032_reset_sources(struct r9a06g032_priv *clocks,
+			uint32_t mask, uint32_t value)
+{
+	uint32_t rsten;
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocks->lock, flags);
+	rsten = readl(clocks->reg);
+	rsten = (rsten & ~mask) | (value & mask);
+	writel(rsten, clocks->reg + R9A06G032_SYSCTRL_REG_RSTEN);
+	spin_unlock_irqrestore(&clocks->lock, flags);
+}
+
 static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -910,6 +928,8 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	if (!clocks || !clks)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, clocks);
+
 	spin_lock_init(&clocks->lock);
 
 	clocks->data.clks = clks;
@@ -963,9 +983,18 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+
 	return r9a06g032_add_clk_domain(dev);
 }
 
+static void r9a06g032_clocks_shutdown(struct platform_device *pdev)
+{
+	struct r9a06g032_priv *clocks = platform_get_drvdata(pdev);
+
+	/* Disable the watchdog reset sources */
+	r9a06g032_reset_sources(clocks, WDA7RST0 | WDA7RST1, 0);
+}
+
 static const struct of_device_id r9a06g032_match[] = {
 	{ .compatible = "renesas,r9a06g032-sysctrl" },
 	{ }
@@ -976,6 +1005,7 @@ static struct platform_driver r9a06g032_clock_driver = {
 		.name	= "renesas,r9a06g032-sysctrl",
 		.of_match_table = r9a06g032_match,
 	},
+	.shutdown = r9a06g032_clocks_shutdown,
 };
 
 static int __init r9a06g032_clocks_init(void)
-- 
2.25.1

