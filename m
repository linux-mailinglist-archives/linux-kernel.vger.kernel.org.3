Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128E747CB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbhLVDQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:16:21 -0500
Received: from out28-74.mail.aliyun.com ([115.124.28.74]:34054 "EHLO
        out28-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbhLVDQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:16:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07439341|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0152868-0.0082419-0.976471;FP=12208373059880385638|1|1|5|0|-1|-1|-1;HT=ay29a033018047208;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.MMkHKcv_1640142974;
Received: from sunxibot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.MMkHKcv_1640142974)
          by smtp.aliyun-inc.com(10.147.40.26);
          Wed, 22 Dec 2021 11:16:15 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     ulf.hansson@linaro.org, mripard@kernel.org, wens@csie.org,
        samuel@sholland.org, andre.przywara@arm.com
Cc:     jernej.skrabec@gmail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Wu <michael@allwinnertech.com>
Subject: [PATCH 3/3] mmc: sunxi-mmc: use pll to increase clock speed
Date:   Wed, 22 Dec 2021 11:15:57 +0800
Message-Id: <20211222031557.34242-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Default clock soucre is 24M,if we want clock over 24M
We should use pll as clock source

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c | 57 +++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 7b47ec453fb6..0039ee58b303 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -756,6 +756,57 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
 	return 0;
 }
 
+/**
+ *
+ * sunxi_clk_get_parent() - get parent pll from dts
+ * @host:		sunxi_mmc_host struct point
+ * @@clock:		the clock frequency that requested
+ *
+ * Default clock source is 24M,if we want clock over 24M,We should use
+ * pll as clock soure
+ *
+ * Return:the 0:ok,other:failed
+ */
+static int sunxi_clk_get_parent(struct sunxi_mmc_host *host, u32 clock)
+{
+	struct clk *sclk = NULL;
+	char *sclk_name = NULL;
+	u32 src_clk = 0;
+	s32 err = 0;
+	struct device *dev = mmc_dev(host->mmc);
+
+	sclk = clk_get(dev, "osc24m");
+	sclk_name = "osc24m";
+
+	if (IS_ERR(sclk)) {
+		dev_err(mmc_dev(host->mmc), "Error to get source clock %s\n",
+				sclk_name);
+		return PTR_ERR(sclk);
+	}
+
+	src_clk = clk_get_rate(sclk);
+	if (clock > src_clk) {
+		clk_put(sclk);
+		sclk = clk_get(dev, "pll_periph");
+		sclk_name = "pll_periph";
+	}
+	if (IS_ERR(sclk)) {
+		dev_err(mmc_dev(host->mmc), "Error to get source clock %s\n",
+				sclk_name);
+		return PTR_ERR(sclk);
+	}
+
+	err = clk_set_parent(host->clk_mmc, sclk);
+	if (err) {
+		dev_err(mmc_dev(host->mmc), "set parent failed\n");
+		clk_put(sclk);
+		return err;
+	}
+	clk_put(sclk);
+	return 0;
+}
+
+
 static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 				  struct mmc_ios *ios)
 {
@@ -801,7 +852,11 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 			return ret;
 		}
 	}
-
+	/**
+	 * No check return value,because dts may not have osc24M, and pll_periph,
+	 * at that time,use default value from clk system
+	 */
+	sunxi_clk_get_parent(host, clock);
 	rate = clk_round_rate(host->clk_mmc, clock);
 	if (rate < 0) {
 		dev_err(mmc_dev(mmc), "error rounding clk to %d: %ld\n",
-- 
2.29.0

