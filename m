Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BCE47CB94
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbhLVDPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:15:49 -0500
Received: from out28-145.mail.aliyun.com ([115.124.28.145]:35462 "EHLO
        out28-145.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbhLVDPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:15:48 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1217135|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0561819-0.000317092-0.943501;FP=7011064724060272356|1|1|5|0|-1|-1|-1;HT=ay29a033018047199;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.MMifRmp_1640142945;
Received: from sunxibot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.MMifRmp_1640142945)
          by smtp.aliyun-inc.com(10.147.42.135);
          Wed, 22 Dec 2021 11:15:45 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     ulf.hansson@linaro.org, mripard@kernel.org, wens@csie.org,
        samuel@sholland.org, andre.przywara@arm.com
Cc:     jernej.skrabec@gmail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Wu <michael@allwinnertech.com>
Subject: [PATCH 2/3] mmc:sunxi-mmc:fix clock division for timing mode
Date:   Wed, 22 Dec 2021 11:15:21 +0800
Message-Id: <20211222031521.34170-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use new timings,all speed mode requires a doubled module clock
if speed mode is ddr,requires a four times module clock
When use old timings,only 8 bit ddr requires a doubled module clock

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/mmc/host/sunxi-mmc.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index afeefead6501..7b47ec453fb6 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -774,20 +774,23 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
 	if (!ios->clock)
 		return 0;
 
-	/*
-	 * Under the old timing mode, 8 bit DDR requires the module
-	 * clock to be double the card clock. Under the new timing
-	 * mode, all DDR modes require a doubled module clock.
-	 *
-	 * We currently only support the standard MMC DDR52 mode.
-	 * This block should be updated once support for other DDR
-	 * modes is added.
+	/**
+	 * When use new timings, all speed mode requires a doubled module clock.
+	 * if speed mode is ddr, requires a four times module clock.
+	 * When use old timings, only 8 bit ddr requires a doubled module clock.
 	 */
-	if (ios->timing == MMC_TIMING_MMC_DDR52 &&
-	    (host->use_new_timings ||
-	     ios->bus_width == MMC_BUS_WIDTH_8)) {
-		div = 2;
+	if (host->use_new_timings) {
 		clock <<= 1;
+		if (ios->timing == MMC_TIMING_MMC_DDR52) {
+			div = 2;
+			clock <<= 1;
+		}
+	} else {
+		if (ios->timing == MMC_TIMING_MMC_DDR52 &&
+				(ios->bus_width == MMC_BUS_WIDTH_8)) {
+			div = 2;
+			clock <<= 1;
+		}
 	}
 
 	if (host->use_new_timings && host->cfg->ccu_has_timings_switch) {
-- 
2.29.0

